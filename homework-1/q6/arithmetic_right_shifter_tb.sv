module arithmetic_right_shifter_tb;

  localparam N = 8;



    // Inputs
  logic [N-1:0] input_data;
  logic [1:0] control;
  // Outputs
  logic [N-1:0] shifted_result;


  // complete
arithmetic_right_shifter #(N) UUT (
    .input_data(input_data),
    .control(control),
    .shifted_result(shifted_result)
  );


  initial begin
      input_data = 8'b10101010;
      control = 2'b00;
      #10;
    for(int i=0; i<20; i++) begin
      input_data = $urandom_range(0, 255);
      control = $urandom_range(0, 3);
      #2;
      $display("input_data=%b, control=%b -> shifted_result=%b", input_data, control, shifted_result);
    end
    #20;
    
    $finish;
  end
endmodule
