module arithmetic_right_shifter #(parameter N) (
  input logic [N-1:0] input_data,
  input logic [1:0] control,
  output logic [N-1:0] shifted_result
);

  // complete the module

logic sign_bit;
assign sign_bit = input_data[N-1];

always_comb begin
  case(control)
    2'b00: shifted_result = input_data; 
    2'b01: shifted_result = {sign_bit, input_data[N-1:1]}; 
    2'b10: shifted_result = {sign_bit, sign_bit, input_data[N-1:2]}; 
    2'b11: shifted_result = {sign_bit, sign_bit, sign_bit, input_data[N-1:3]}; 

  endcase
end



endmodule
