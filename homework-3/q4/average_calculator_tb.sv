module average_calculator_tb;
	parameter m = 8;
	parameter n = 4;
	
	logic clk;
	logic rst_n;    
	logic start;
	logic [m-1:0] inputx;
	logic [m-1:0] result;
	logic done;

	average_calculator #(m, n) dut (
		.clk(clk),
		.rst_n(rst_n),
		.start(start),
		.inputx(inputx),
		.result(result),
		.done(done)
	);

	// …
	// Add your description here



	always begin
        #5 clk = ~clk;  // Toggle every 5 time units
    end


	initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        start = 0;
        inputx = 0;

        // Apply reset
        #10;
        rst_n = 1; // Release reset
        #10;

        // Start the first test case
        // Load 4 values to compute their average
        start = 1;
        inputx = 8'b00000001;  
        #10;                  
        start = 0;             


        #10;
        inputx = 8'b00000010;  // Input value 2
        #10;
        inputx = 8'b00000100;  // Input value 4
        #10;
        inputx = 8'b00001000;  // Input value 8
        #10;

        wait(done == 1);        

        $display("Test completed. Result = %d, Done = %b", result, done);


        $finish;
    end


	// …
	
endmodule
