module multiplier_tb;

  // complete
logic [15:0] a, b;
  logic [31:0] product;

  multiplier uut (
    .a(a),
    .b(b),
    .product(product)
  );

  initial begin

    a = 16'h1234; b = 16'h5678;
    #10;
    $display("Fixed: a=%0d, b=%0d -> product=%0d (expected=%0d)",
             a, b, product, a*b);


    for (int i=0; i<20; i++) begin
      a = $urandom_range(0, 65535);
      b = $urandom_range(0, 65535);
      #5;
      $display("Random: a=%0d, b=%0d -> product=%0d (expected=%0d)",
               a, b, product, a*b);
    end

    #20;
    $finish;
  end

endmodule