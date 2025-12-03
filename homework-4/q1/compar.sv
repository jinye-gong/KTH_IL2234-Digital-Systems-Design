module cmp(
    input  logic [15:0] a,
    input  logic [15:0] b,
    output logic       sign
);
    always_comb begin
    if (a >= b) begin
        sign = 0;
    end else begin
        sign = 1;
    end
    end
endmodule
