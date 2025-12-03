module tb_ripple_carry_adder;

  localparam N = 4;

  // Inputs
  logic [N-1:0] A;
  logic [N-1:0] B;
  logic c_in;
  // Outputs
  logic [N-1:0] SUM;
  logic c_out;

  // Instantiate the Unit Under Test (UUT)
  ripple_carry_adder #(N) UUT (
    .A(A),
    .B(B),
    .c_in(c_in),
    .SUM(SUM),
    .c_out(c_out)
  );

  initial begin
      A = 4'b0011; // 3
      B = 4'b0101; // 5
      c_in = 0;
      #10;
    for(int i=0; i<20; i++) begin
      A = $urandom_range(0, 15);
      B = $urandom_range(0, 15);
      c_in = $urandom_range(0, 1);
      #2;
      $display("A=%b (%0d), B=%b (%0d), c_in=%b -> SUM=%b (%0d), c_out=%b", A, A, B, B, c_in, SUM, SUM, c_out);
    end
    #20;
    
    $finish;
  end   
endmodule