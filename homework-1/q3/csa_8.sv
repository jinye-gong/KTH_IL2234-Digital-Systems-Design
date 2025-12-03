module csa_8 (
  input logic [7:0] a, b,
  output logic [7:0] sum,
  output logic carry
);
  // …
  // Add your description here


logic carry_low;
logic [3:0] sum_high_no_carry, sum_high_with_carry;
logic carry_high_no_carry, carry_high_with_carry;
logic [3:0] b_high_with_carry;

adder_4 adder_low (
    .A(a[3:0]),
    .B(b[3:0]),
    .sum(sum[3:0]),
    .carry(carry_low)
  );

adder_4 adder_high_0 (
    .A(a[7:4]),
    .B(b[7:4]),
    .sum(sum_high_no_carry),
    .carry(carry_high_no_carry)
  );

assign b_high_with_carry = b[7:4] + 1;
adder_4 adder_high_1 (
    .A(a[7:4]),
    .B(b_high_with_carry), 
    .sum(sum_high_with_carry),
    .carry(carry_high_with_carry)
  );

assign sum[7:4] = carry_low ? sum_high_with_carry : sum_high_no_carry;
assign carry    = carry_low ? carry_high_with_carry : carry_high_no_carry;




  // …
endmodule
