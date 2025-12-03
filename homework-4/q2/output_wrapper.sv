module ow_top (
    input  logic        clk, rst_n,
  // from IMC
    input  logic        imc_ready,
    input  logic [15:0] a_in, b_in, c_in, d_in,
  // to consumer/bus
    input  logic        startTransmit,
    output logic        outAvail,
    output logic        request,
    input  logic        grant,
    output logic [15:0] dataOut,
    output logic        outReady,
    input  logic        outAccepted
);
    logic        we_latch;
    logic [1:0]  send_idx;

    ow_ctrl     CTRL(.clk, .rst_n, .imc_ready, .startTransmit, .outAvail,
                    .request, .grant, .outReady, .outAccepted, .we_latch, .send_idx);

    ow_datapath DP  (.clk, .rst_n, .a_in, .b_in, .c_in, .d_in, .we_latch, .send_idx, .dataOut);
endmodule