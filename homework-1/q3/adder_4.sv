module adder_4 (
  input logic [3:0] A, B,
  output logic [3:0] sum,
  output logic carry
);
  assign {carry, sum} = A+B;
endmodule
