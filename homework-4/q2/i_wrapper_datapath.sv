module iw_datapath (
    input  logic        clk, rst_n,
    input  logic [15:0] dataIn,
    input  logic        we_a, we_b, we_c, we_d,
    output logic [15:0] a, b, c, d
);
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin a<='0; b<='0; c<='0; d<='0; end
    else begin
        if (we_a) a <= dataIn;
        if (we_b) b <= dataIn;
        if (we_c) c <= dataIn;
        if (we_d) d <= dataIn;
    end
end
endmodule
