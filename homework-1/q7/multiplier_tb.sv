module multiplier_tb;

  localparam N = 4;

  // Inputs
  logic signed [N-1:0] a;
  logic signed [N-1:0] b;
  // Outputs
  logic signed [2*N-1:0] product;

  // Instantiate the Unit Under Test (UUT)
  multiplier #(N) UUT (
    .a(a),
    .b(b),
    .product(product)
  );




  initial begin

    a = -3;
    b =  5;
    #10;


    for (int i=0; i<20; i++) begin
      a = $urandom_range(8, -7);
      b = $urandom_range(8, -7);
      #2;
      $display("a=%0d, b=%0d -> product=%0d (expected=%0d)",
               a, b, product, a*b);
    end

    #20;
    $finish;
  end

endmodule
