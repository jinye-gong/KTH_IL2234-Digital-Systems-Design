module mult4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [7:0] p
);
    assign p = a * b;   
endmodule
