module count_1_tb;

  // Inputs
  logic [3:0] a;

  // Outputs
  logic [2:0] out;

  // complete

count_1 UUT (
    .a(a),
    .out(out)
  );

  initial begin
    a = 4'b0000;
    #10;
    for(int i=0; i<16; i++) begin
      a = $urandom_range(0, 15);
      #1;
        $display("a=%0d -> out=%0d", a, out);
      end
    #20;

    $finish;
  end



endmodule
