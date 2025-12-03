module tb_full_adder;

  // Inputs
  logic a;
  logic b;
  logic c_in;
  // Outputs
  logic c_out;
  logic s;

  // Instantiate the Unit Under Test (UUT)
  full_adder UUT (
    .a(a),
    .b(b),
    .c_in(c_in),
    .c_out(c_out),
    .s(s)
  );

  initial begin
      a = 0; b = 0; c_in = 0;
      #10;
    for(int i=0; i<20; i++) begin
      a = $urandom_range(0, 1);
      b = $urandom_range(0, 1);
      c_in = $urandom_range(0, 1);
      #2;
      $display("a=%b, b=%b, c_in=%b -> s=%b, c_out=%b", a, b, c_in, s, c_out);
    end
    #20;
    
    $finish;
  end   
endmodule