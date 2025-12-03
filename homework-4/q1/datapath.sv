// ================= Datapath for 2x2 IMC =================
module imc_dp #(
parameter int WIDTH = 16
)(
    input  logic                   clk,
    input  logic                   rst_n,

  // 原始输入（Q8.8，无符号；整数 N 用 N<<8）
    input  logic [WIDTH-1:0]       aIn, bIn, cIn, dIn,

  // 控制信号（来自 imc_ctrl）
    input  logic [1:0]             mul1_a_sel,   // 00:a 01:b 10:c 11:d
    input  logic [1:0]             mul1_b_sel,
    input  logic [1:0]             mul2_a_sel,
    input  logic [1:0]             mul2_b_sel,
    input  logic                   mul1_sel_out, // 1:[31:16], 0:[23:8]
    input  logic                   mul2_sel_out,


  // 各寄存器的 init/load（同步清零/装载）
    input  logic                   init_multi1,  input logic load_multi1, // ad_hi
    input  logic                   init_multi2,  input logic load_multi2, // bc_hi
    input  logic                   init_det,     input logic load_det,    // |det|（16b）
    input  logic                   init_sign,    input logic load_sign,   // det 符号
    input  logic                   init_aout,    input logic load_aout,
    input  logic                   init_aOut_sign, input logic load_aOut_sign,
    input  logic                   init_bout,    input logic load_bout,
    input  logic                   init_bOut_sign, input logic load_bOut_sign,
    input  logic                   init_cout,    input logic load_cout,
    input  logic                   init_cOut_sign, input logic load_cOut_sign,
    input  logic                   init_dout,    input logic load_dout,
    input  logic                   init_dOut_sign, input logic load_dOut_sign,

  // 输出（幅度为 Q8.8，无符号；符号用 flag 表示）
    output logic [WIDTH-1:0]       aOut, bOut, cOut, dOut,
    output logic                   aOut_sign, bOut_sign, cOut_sign, dOut_sign
);

    logic [15:0] mul1_i1, mul1_i2, mul2_i1, mul2_i2;
    logic [15:0] mul1_o, mul2_o;
    logic [15:0] recip_out; 

mux3 u0_mux3 (
    .a   (aIn),
    .b   (recip_out),
    .c   (recip_out),
    .sel (mul1_a_sel),  
    .y   (mul1_i1)
);

mux3 u1_mux3 (
    .a   (dIn),
    .b   (dIn),
    .c   (cIn),
    .sel (mul1_b_sel), 
    .y   (mul1_i2)
);

mux3 u2_mux3 (
    .a   (bIn),
    .b   (recip_out),
    .c   (recip_out),
    .sel (mul2_a_sel),  
    .y   (mul2_i1)
);

mux3 u3_mux3 (
    .a   (cIn),
    .b   (bIn),
    .c   (aIn),
    .sel (mul2_b_sel), 
    .y   (mul2_i2)
);

    multi u_mul1 (
        .a(mul1_i1), 
        .b(mul1_i2),
        .select_output(mul1_sel_out),
        .y(mul1_o)
    );

    multi u_mul2 (
        .a(mul2_i1), 
        .b(mul2_i2),
        .select_output(mul2_sel_out),
        .y(mul2_o)
    );

    logic [15:0] mul1_reg_o, mul2_reg_o;


  register #(.BIT_WIDTH(16)) multi1_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_multi1),
  .load      (load_multi1),
  .in_value  (mul1_o),
  .out_value (mul1_reg_o)
);
  register #(.BIT_WIDTH(16)) multi2_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_multi2),
  .load      (load_multi2),
  .in_value  (mul2_o),
  .out_value (mul2_reg_o)
);  

logic [15:0] sub_out;
  sub u_sub(
    .a(mul1_reg_o),  
    .b(mul2_reg_o),   
    .diff(sub_out)
);

logic compar_sign;
  cmp u_cmp(
    .a(mul1_reg_o),  
    .b(mul2_reg_o),   
    .sign(compar_sign)
);

logic [8:0] recip;
reciprocal u_reciprocal (
  .x(sub_out), 
  .y(recip)
  );



  register #(.BIT_WIDTH(16)) recip_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_det),
  .load      (load_det),
  .in_value  ({7'b0,recip}),
  .out_value (recip_out)
);  
logic sign;
  register #(.BIT_WIDTH(1)) sin_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_sign),
  .load      (load_sign),
  .in_value  (compar_sign),
  .out_value (sign)
);  

  register #(.BIT_WIDTH(16)) aOut_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_aout),
  .load      (load_aout),
  .in_value  (mul1_o),
  .out_value (aOut)
);  

  register #(.BIT_WIDTH(1)) aOut_sign_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_aOut_sign),
  .load      (load_aOut_sign),
  .in_value  (sign),
  .out_value (aOut_sign)
);  

  register #(.BIT_WIDTH(16)) bOut_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_bout),
  .load      (load_bout),
  .in_value  (mul2_o),
  .out_value (bOut)
);  

  register #(.BIT_WIDTH(1)) bOut_sign_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_bOut_sign),
  .load      (load_bOut_sign),
  .in_value  (~sign),
  .out_value (bOut_sign)
);  

  register #(.BIT_WIDTH(16)) cOut_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_cout),
  .load      (load_cout),
  .in_value  (mul1_o),
  .out_value (cOut)
);  

  register #(.BIT_WIDTH(1)) cOut_sign_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_cOut_sign),
  .load      (load_cOut_sign),
  .in_value  (~sign),
  .out_value (cOut_sign)
);  

  register #(.BIT_WIDTH(16)) dOut_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_dout),
  .load      (load_dout),
  .in_value  (mul2_o),
  .out_value (dOut)
);  

  register #(.BIT_WIDTH(1)) dOut_sign_reg (
  .clk       (clk),
  .rst_n     (rst_n),
  .init      (init_dOut_sign),
  .load      (load_dOut_sign),
  .in_value  (sign),
  .out_value (dOut_sign)
);  


endmodule


