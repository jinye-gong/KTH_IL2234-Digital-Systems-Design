module mux2to1 #(
    parameter BIT_WIDTH = 16) (
    input  logic [BIT_WIDTH-1:0] a, b,
    input  logic                 sel,
    output logic [BIT_WIDTH-1:0] out_value
    );

    assign out_value = sel ? b : a;

endmodule