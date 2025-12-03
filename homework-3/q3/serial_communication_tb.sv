module serial_communication_tb;

	logic clk;
	logic rst_n;    
	logic serData;
	logic outValid;
	
	serial_communication dut (
		.clk(clk),
		.rst_n(rst_n),
		.serData(serData),
		.outValid(outValid)
	);

	// …
	// Add your description here
	
	always #5 clk = ~clk;


initial begin
    clk = 0;
    rst_n = 0;
    #20 rst_n = 1;
end

initial begin

    #10 serData = 0;  
	#10 serData = 1;  
	#10 serData = 0;  
	#10 serData = 1; 
	#10 serData = 0;  
	#10 serData = 0;  
	#10 serData = 1;  
	#10 serData = 1;  
	#10 serData = 0;
	#10 serData = 0;   

	#10 serData = 0;  
    #10 serData = 1; 
    #10 serData = 1; 
    #10 serData = 0;  
    #10 serData = 1;  
    #10 serData = 0; 

    #10 
	serData = 0;
    #160 
	serData = 1;
    #160 

		serData = 1;
    #10 serData = 0;
    #10 serData = 1;
    #10 serData = 1;
end



	
	// …

endmodule