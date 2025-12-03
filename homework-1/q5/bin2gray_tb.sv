module bin2gray_tb;

  // Inputs
  logic [3:0] binary;

  // Outputs
  logic [3:0] gray;

  // complete

bin2gray UUT (
    .binary(binary),
    .gray(gray)
  );

  initial begin
    binary = 4'b0000;
    #10;
    for(int i=0; i<16; i++) begin
      binary = $urandom_range(0, 15);
      #1;
        $display("binary=%0d -> gray=%0d", binary, gray);
      end
    #20;

    $finish;
  end



endmodule
