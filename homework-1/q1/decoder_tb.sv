module decoder_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [15:0] one_hot;

  // Instantiate the decoder module
  decoder uut (
    .binary(binary),
    .one_hot(one_hot)
  );


  initial begin
    binary = 4'b0000;
    #10;
    for(int i=0; i <16 ; i++ )begin
      binary = i;
      #10;

      $display("binary=%0d -> one_hot=%b ", binary, one_hot);

    end

    #20;
    $finish;
  end

  // Complete your testbench here
endmodule
