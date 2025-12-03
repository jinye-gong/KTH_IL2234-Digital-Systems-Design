module half_adder (
  input logic a,b,
  output logic c_out, s
);
  assign s = a^b;
  assign c_out = a&b;
endmodule
