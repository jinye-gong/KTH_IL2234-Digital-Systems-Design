module ow_datapath (
input  logic        clk, rst_n,
  // from IMC
input  logic [15:0] a_in, b_in, c_in, d_in,
input  logic        we_latch,        // 1-cycle @ ready↑
  // to bus
input  logic [1:0]  send_idx,
output logic [15:0] dataOut
);
logic [15:0] q[0:3];

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin q[0]<='0; q[1]<='0; q[2]<='0; q[3]<='0; end
    else if (we_latch) begin
    q[0] <= a_in; q[1] <= b_in; q[2] <= c_in; q[3] <= d_in;
    end
end

always_comb begin
    unique case (send_idx)
    2'd0: dataOut = q[0];
    2'd1: dataOut = q[1];
    2'd2: dataOut = q[2];
    default: dataOut = q[3];
    endcase
end
endmodule