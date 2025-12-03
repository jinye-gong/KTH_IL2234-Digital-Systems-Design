module bin2bcd_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [3:0] bcd;
  logic carry;

  // complete your tb
  bin2bcd uut (
    .binary(binary),
    .bcd(bcd),
    .carry(carry)
  );

initial begin
    binary = 4'b0000;
    #10
    for(int i = 0; i < 16; i++) begin
      binary = i;
      #10;
      $display("binary=%0d => bcd=%b, carry=%b", binary, bcd, carry);
    end

    #20;

    $stop;
end




endmodule
