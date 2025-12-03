module imc      #(parameter WIDTH = 16)
                (input logic clk,
                input logic rst_n,
                input logic start,
                input logic [WIDTH-1:0] aIn, 
                input logic [WIDTH-1:0] bIn,
                input logic [WIDTH-1:0] cIn,
                input logic [WIDTH-1:0] dIn,
                output logic ready,
                output logic [WIDTH-1:0] aOut,
                output logic [WIDTH-1:0] bOut,
                output logic [WIDTH-1:0] cOut,
                output logic [WIDTH-1:0] dOut,
                output logic aOut_sign,
                output logic bOut_sign,
                output logic cOut_sign,
                output logic dOut_sign
                );
// Your code goes here


// ---------------- 控制连线 ----------------
  logic [1:0] mul1_a_sel, mul1_b_sel;
  logic [1:0] mul2_a_sel, mul2_b_sel;
  logic       mul1_sel_out, mul2_sel_out;

  logic init_multi1, load_multi1;
  logic init_multi2, load_multi2;
  logic init_aout,   load_aout;
  logic init_aOut_sign,   load_aOut_sign;
  logic init_bout,   load_bout;
  logic init_bOut_sign,   load_bOut_sign;
  logic init_cout,   load_cout;
  logic init_cOut_sign,   load_cOut_sign;
  logic init_dout,   load_dout;
  logic init_dOut_sign,   load_dOut_sign;
  logic init_sign,   load_sign;
  logic init_det,    load_det;

  // ---------------- 实例化控制器 ----------------
  imc_ctrl u_ctrl (
    .clk          (clk),
    .rst_n        (rst_n),

    .start        (start),
    .ready        (ready),

    .mul1_a_sel   (mul1_a_sel),
    .mul1_b_sel   (mul1_b_sel),
    .mul2_a_sel   (mul2_a_sel),
    .mul2_b_sel   (mul2_b_sel),

    .mul1_sel_out (mul1_sel_out),
    .mul2_sel_out (mul2_sel_out),

    .init_multi1  (init_multi1),
    .load_multi1  (load_multi1),

    .init_multi2  (init_multi2),
    .load_multi2  (load_multi2),

    .init_aout    (init_aout),
    .load_aout    (load_aout),
    .init_aOut_sign(init_aOut_sign),      
    .load_aOut_sign(load_aOut_sign), 

    .init_bout    (init_bout),
    .load_bout    (load_bout),
    .init_bOut_sign(init_bOut_sign),      
    .load_bOut_sign(load_bOut_sign), 

    .init_cout    (init_cout),
    .load_cout    (load_cout),
    .init_cOut_sign(init_cOut_sign),      
    .load_cOut_sign(load_cOut_sign), 

    .init_dout    (init_dout),
    .load_dout    (load_dout),
    .init_dOut_sign(init_dOut_sign),      
    .load_dOut_sign(load_dOut_sign), 

    .init_sign    (init_sign),
    .load_sign    (load_sign),

    .init_det     (init_det),
    .load_det     (load_det)
  );



imc_dp #(.WIDTH(WIDTH)) u_dp (
    .clk          (clk),
    .rst_n        (rst_n),

    .aIn          (aIn),
    .bIn          (bIn),
    .cIn          (cIn),
    .dIn          (dIn),

    .mul1_a_sel   (mul1_a_sel),
    .mul1_b_sel   (mul1_b_sel),
    .mul2_a_sel   (mul2_a_sel),
    .mul2_b_sel   (mul2_b_sel),
    .mul1_sel_out (mul1_sel_out),
    .mul2_sel_out (mul2_sel_out),

    .init_multi1  (init_multi1), .load_multi1(load_multi1),
    .init_multi2  (init_multi2), .load_multi2(load_multi2),
    .init_det     (init_det),    .load_det   (load_det),
    .init_sign    (init_sign),   .load_sign  (load_sign),
    .init_aout    (init_aout),   .load_aout  (load_aout),
    .init_aOut_sign(init_aOut_sign),.load_aOut_sign(load_aOut_sign), 
    .init_bout    (init_bout),   .load_bout  (load_bout),
    .init_bOut_sign(init_bOut_sign),.load_bOut_sign(load_bOut_sign), 
    .init_cout    (init_cout),   .load_cout  (load_cout),
    .init_cOut_sign(init_cOut_sign),.load_cOut_sign(load_cOut_sign), 
    .init_dout    (init_dout),   .load_dout  (load_dout),
    .init_dOut_sign(init_dOut_sign),.load_dOut_sign(load_dOut_sign), 

    .aOut         (aOut),
    .bOut         (bOut),
    .cOut         (cOut),
    .dOut         (dOut),
    .aOut_sign    (aOut_sign),
    .bOut_sign    (bOut_sign),
    .cOut_sign    (cOut_sign),
    .dOut_sign    (dOut_sign)
  );













endmodule