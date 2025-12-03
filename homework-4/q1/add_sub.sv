module add_sub (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic        sel, // 0: add, 1: sub
    output logic [15:0] y
);
    always_comb begin
        if (sel == 1'b0) begin
            y = a + b; // addition
        end else begin
            y = a - b; // subtraction
        end
    end
endmodule