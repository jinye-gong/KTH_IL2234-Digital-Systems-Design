module imc_ctrl(
    input  logic clk,
    input  logic rst_n,

  // handshake
    input  logic start,
    output logic ready,

  // mul1/2 输入选择：00:a, 01:b, 10:c, 11:d（S3/S4 用 01 表示 r 扩展）
    output logic [1:0] mul1_a_sel,
    output logic [1:0] mul1_b_sel,
    output logic [1:0] mul2_a_sel,
    output logic [1:0] mul2_b_sel,

  // 乘法输出切片与舍入
    output logic       mul1_sel_out,  // 1:[31:16], 0:[23:8]
    output logic       mul2_sel_out,


  // 寄存器装载使能
    output logic       init_multi1,      
    output logic       load_multi1,       

    output logic       init_multi2,      
    output logic       load_multi2,   

    output logic       init_aout,      
    output logic       load_aout,   
    output logic       init_aOut_sign,      
    output logic       load_aOut_sign, 

    output logic       init_bout,      
    output logic       load_bout,  
    output logic       init_bOut_sign,      
    output logic       load_bOut_sign,  

    output logic       init_cout,      
    output logic       load_cout,   
    output logic       init_cOut_sign,      
    output logic       load_cOut_sign, 

    output logic       init_dout,      
    output logic       load_dout,  
    output logic       init_dOut_sign,      
    output logic       load_dOut_sign,  

    output logic       init_sign,      
    output logic       load_sign,   

    output logic       init_det,      
    output logic       load_det

);

  // 状态编码：S0..S5
  typedef enum logic [2:0] {
    S_IDLE  = 3'd0, // 等 start；ready=1
    S_MUL1  = 3'd1, // 并行 ad, bc
    S_DET   = 3'd2, // det 符号/绝对值 + 近似倒数
    S_MUL2  = 3'd3, // 并行 d*r, b*r
    S_MUL3  = 3'd4, // 并行 c*r, a*r
    S_DONE  = 3'd5  // 输出格式化锁存；ready=1
  } state_t;

  state_t p_state, n_state;

  // ready 规则：在 IDLE/DONE 维持 1；收到 start 开始新一轮后拉低
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) p_state <= S_IDLE;
    else        p_state <= n_state;
  end

  // 默认值（避免锁存）
  always_comb begin
    // 默认禁用


    init_multi1=1'b0; load_multi1=1'b0;
    init_multi2=1'b0; load_multi2=1'b0;
    init_aout=1'b0;   load_aout=1'b0;
    init_aOut_sign=1'b0;   load_aOut_sign=1'b0;
    init_bout=1'b0;   load_bout=1'b0;
    init_bOut_sign=1'b0;   load_bOut_sign=1'b0;
    init_cout=1'b0;   load_cout=1'b0;
    init_cOut_sign=1'b0;   load_cOut_sign=1'b0;
    init_dout=1'b0;   load_dout=1'b0;
    init_dOut_sign=1'b0;   load_dOut_sign=1'b0;
    init_sign=1'b0;   load_sign=1'b0;
    init_det =1'b0;   load_det =1'b0;


    // 乘法器默认配置
    mul1_a_sel = 2'b00; 
    mul1_b_sel = 2'b00; 
    mul2_a_sel = 2'b00;
    mul2_b_sel = 2'b00;
    mul1_sel_out = 1'b0;
    mul2_sel_out = 1'b0;



    // ready 默认
    ready = 1'b0;

    n_state = p_state;

    case (p_state)
      //========================================
      // S0: 等待 start；锁存输入；ready=1
      //========================================
      S_IDLE: begin
        ready  = 1'b1;
        if (start) begin
        init_multi1=1'b0;       
        init_multi2=1'b0;   
        init_aout = 1'b0; 
        init_aOut_sign=1'b0;
        init_bout = 1'b0;   
        init_bOut_sign=1'b0;
        init_cout = 1'b0; 
        init_cOut_sign=1'b0;
        init_dout = 1'b0; 
        init_dOut_sign=1'b0;
        init_sign = 1'b0;   
        init_det  = 1'b0;   
        n_state = S_MUL1;
        end
      end

      //========================================
      // S1: 并行 ad 与 bc（select_output=1 取 [31:16]）
      //     关键路径：乘法 ≈84d
      //========================================
      S_MUL1: begin
        // mul1: a * d
        mul1_a_sel   = 2'b00;     // a
        mul1_b_sel   = 2'b00;     // d
        mul1_sel_out = 1'b1;      // [31:16]

        // mul2: b * c
        mul2_a_sel   = 2'b00;     // b
        mul2_b_sel   = 2'b00;     // c
        mul2_sel_out = 1'b1;      // [31:16]

        load_multi1= 1'b1;             // 锁存 ad_hi
        load_multi2= 1'b1;             // 锁存 bc_hi

        n_state = S_DET;
      end

      //========================================
      // S2: 行列式、绝对值、倒数
      //     det/sub/abs + reciprocal(组合≈84d)
      //========================================
      S_DET: begin
        // 此拍不再驱动乘法器
        load_sign = 1'b1;   
        load_det  = 1'b1;  
        n_state = S_MUL2;
      end

      //========================================
      // S3: 并行 d*r 与 b*r（select_output=0 取 [23:8]）
      //     关键路径：乘法 ≈84d
      //========================================
      S_MUL2: begin

        // mul1: d * r
        mul1_a_sel   = 2'b01;     // det
        mul1_b_sel   = 2'b01;     // d
        mul1_sel_out = 1'b0;      // [23:8]

        // mul2: b * r
        mul2_a_sel   = 2'b01;     // det
        mul2_b_sel   = 2'b01;     // -b
        mul2_sel_out = 1'b0;      // [23:8]

        load_aout = 1'b1;
        load_aOut_sign=1'b1;
        load_bout = 1'b1; 
        load_bOut_sign=1'b1;
        n_state = S_MUL3;
      end

      //========================================
      // S4: 并行 c*r 与 a*r（select_output=0 取 [23:8]）
      //========================================
      S_MUL3: begin

        // mul1: c * r
        mul1_a_sel   = 2'b10;     // det
        mul1_b_sel   = 2'b10;     // -c
        mul1_sel_out = 1'b0;      // [23:8]

        // mul2: a * r
        mul2_a_sel   = 2'b10;     // det
        mul2_b_sel   = 2'b10;     // a
        mul2_sel_out = 1'b0;      // [23:8]


        load_cout = 1'b1;
        load_cOut_sign=1'b1;
        load_dout = 1'b1; 
        load_dOut_sign=1'b1;
        n_state = S_DONE;
      end

      //========================================
      // S5: 输出锁存 + ready=1，等待下一次 start
      //========================================
      S_DONE: begin
      ready  = 1'b1;

    if (start) begin
      n_state = S_IDLE;    
    
    end else begin
      n_state = S_DONE;      
    end


      
      end

      default: n_state = S_IDLE;
    endcase
  end

endmodule
