module bin2bcd (
  input logic [3:0] binary,
  output logic [3:0] bcd,
  output logic carry
);
  // …
  // Add your description here
  
  localparam [15:0] mux0 = 16'b1010_1010_1010_1010;  //bcd0
  localparam [15:0] mux1 = 16'b0011_0000_1100_1100;  //bcd1
  localparam [15:0] mux2 = 16'b1100_0000_1111_0000;  //bcd2
  localparam [15:0] mux3 = 16'b0000_0011_0000_0000;  //bcd3

  localparam [15:0] mux4 = 16'b1111_1111_0000_0000;  //carry


  
  assign    bcd = {mux3[binary],mux2[binary],mux1[binary],mux0[binary]};
  assign    carry = mux4[binary];
  
  // …

endmodule
