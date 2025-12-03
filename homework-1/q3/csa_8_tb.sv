module csa_8_tb;

  // Inputs
  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] sum;
  logic carry;

  // complete

  csa_8 UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  initial begin

for(int i=0; i<16; i++) begin
      a = $urandom_range(0, 255);
      b = $urandom_range(0, 255);
      #10;
        $display("a=%0d, b=%0d -> sum=%0d, carry=%b", a, b, sum, carry);
      end
    #20;

    $finish;
  end 





  
endmodule
