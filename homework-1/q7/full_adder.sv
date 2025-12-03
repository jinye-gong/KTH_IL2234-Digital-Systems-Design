module full_adder (
  input logic a,b,c_in,
  output logic c_out, s
);
  logic s1,c1,c2;
  half_adder ha1(.a(a),.b(b),.c_out(c1),.s(s1));
  half_adder ha2(.a(s1),.b(c_in),.c_out(c2),.s(s));
  assign c_out = c1|c2;

endmodule
