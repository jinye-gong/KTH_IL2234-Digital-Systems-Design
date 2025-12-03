module adder #(
	parameter BIT_WIDTH) (
	input  logic [BIT_WIDTH-1:0] a, b,
	input  logic [2:0] count,
	output logic [BIT_WIDTH-1:0] sum, 
    output logic                 c_out
    );

    always_comb begin
        // Check if count is even or odd
        if (count % 2 == 1)
            sum = b - a;  // If count is even, perform addition
        else
            sum = a + b;  // If count is odd, perform subtraction
    end


    assign c_out = (count % 2 == 1) ? (a + b > (2**BIT_WIDTH - 1)) : (a < b);

endmodule