module iw_top (
    input  logic        clk, rst_n,
  // upstream
    input  logic        dataReady,
    input  logic [15:0] dataIn,
    output logic        dataAccept,
  // to IMC
    input  logic        imc_ready,
    output logic        imc_start,
    output logic [15:0] a, b, c, d
);
    logic we_a, we_b, we_c, we_d;

    iw_ctrl     CTRL(.clk, .rst_n, .dataReady, .dataAccept,
                    .imc_ready, .imc_start, .we_a, .we_b, .we_c, .we_d);
    iw_datapath DP  (.clk, .rst_n, .dataIn, .we_a, .we_b, .we_c, .we_d, .a, .b, .c, .d);
    
endmodule