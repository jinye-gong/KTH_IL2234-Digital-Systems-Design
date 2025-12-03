module iw_ctrl (
  input  logic clk, rst_n,
  // upstream
  input  logic dataReady,     
  output logic dataAccept,     
  // to IMC
  input  logic imc_ready,     
  output logic imc_start,      
  // to datapath
  output logic we_a, we_b, we_c, we_d
);
  typedef enum logic [1:0] {S_IDLE, S_COLLECT, S_LAUNCH} state_e;
  state_e s, ns;


  logic [1:0] idx, idx_n;


  logic sample_en;


  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s   <= S_IDLE;
      idx <= 2'd0;
    end else begin
      s   <= ns;
      idx <= idx_n;
    end
  end

  // ========= 组合控制 =========
  always_comb begin
    ns = s;
    dataAccept = 1'b0;
    imc_start  = 1'b0;
    we_a = 1'b0; we_b = 1'b0; we_c = 1'b0; we_d = 1'b0;

    sample_en  = dataReady & (s==S_IDLE || s==S_COLLECT);

    // 下一个 idx
    idx_n = idx;

    unique case (s)
      S_IDLE: begin
        dataAccept = 1'b1;
        if (sample_en) begin
          we_a  = 1'b1;     
          idx_n = 2'd1;
          ns    = S_COLLECT;
        end
      end

      
      S_COLLECT: begin
        dataAccept = 1'b1;
        if (sample_en) begin
          unique case (idx)
            2'd1: begin we_b=1'b1; idx_n=2'd2; end
            2'd2: begin we_c=1'b1; idx_n=2'd3; end
            2'd3: begin we_d=1'b1; idx_n=2'd0; ns=S_LAUNCH; end 
            default: ;
          endcase
        end
      end


      S_LAUNCH: begin
        imc_start = 1'b1;
        ns        = S_IDLE;
      end
    endcase
  end
endmodule
