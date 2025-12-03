module multiplier (
    input  logic [15:0] a, b,
    output logic [15:0] out_value
);
    logic [31:0] temp;

    assign temp = a * b;
    assign out_value = temp[30:15];

endmodule