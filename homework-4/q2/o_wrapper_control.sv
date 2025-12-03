module ow_ctrl (
    input  logic clk, rst_n,
  // from IMC
    input  logic imc_ready,          
  // to consumer/bus
    input  logic startTransmit,
    output logic outAvail,
    output logic request,
    input  logic grant,
    output logic outReady,
    input  logic outAccepted,
  // to datapath
    output logic        we_latch,
    output logic [1:0]  send_idx
);
    typedef enum logic [2:0] {S_IDLE, S_AVAIL, S_ARB, S_S0, S_S1, S_S2, S_S3} state_e;
    state_e s, ns;

    logic ready_d;
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) ready_d <= 1'b0;
    else        ready_d <= imc_ready;
end

wire ready_edge = imc_ready & ~ready_d;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) s <= S_IDLE;
    else        s <= ns;
end

always_comb begin
    ns = s;
    outAvail = 1'b0; request=1'b0; outReady=1'b0;
    we_latch = 1'b0; send_idx = 2'd0;

    unique case (s)
    S_IDLE: begin
        if (ready_edge) begin
            we_latch = 1'b1;     
            ns = S_AVAIL;
        end
    end

    S_AVAIL: begin
        outAvail = 1'b1;       
        ns = startTransmit ? S_ARB : S_AVAIL;
    end

    S_ARB: begin
        outAvail = 1'b1; request=1'b1;
        ns = grant ? S_S0 : S_ARB;
    end

    S_S0: begin outAvail=1; request=1; outReady=1; send_idx=2'd0; ns = outAccepted ? S_S1 : S_S0; end
    S_S1: begin outAvail=1; request=1; outReady=1; send_idx=2'd1; ns = outAccepted ? S_S2 : S_S1; end
    S_S2: begin outAvail=1; request=1; outReady=1; send_idx=2'd2; ns = outAccepted ? S_S3 : S_S2; end
    S_S3: begin outAvail=1; request=1; outReady=1; send_idx=2'd3; ns = outAccepted ? S_IDLE : S_S3; end

    default: ns = S_IDLE;
    endcase
end
endmodule

