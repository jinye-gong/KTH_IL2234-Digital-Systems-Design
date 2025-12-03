// 16x16 unsigned multiplier with selectable 16-bit slice
module multi (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic        select_output, // 1: [31:16], 0: [23:8]
    output logic [15:0] y
);
    logic [31:0] p;

  // behavioural multiply
    assign p = a * b;

  // optional rounding before slicing
    always_comb begin
    y = select_output ? p[31:16] : p[23:8];
end
endmodule
