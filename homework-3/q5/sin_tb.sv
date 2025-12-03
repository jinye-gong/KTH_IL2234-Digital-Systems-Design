module sin_tb;
    logic        clk;
    logic        rst_n;
    logic [15:0] x;
    logic        start;
    logic [15:0] result;
    logic        done;

    sin uut (
        .clk(clk),
        .rst_n(rst_n),
        .x(x),
        .start(start),
        .result(result),
        .done(done)
    );

	// …
	// Add your description here
    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock period


        // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        start = 0;

        // Apply reset
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        #10 x = 16'h4000;  // x = 0.5
        #10; // Wait for a clock cycle

        #10 start = 1;
        #10 start = 0;


        #300 x = 16'h0000;  // x = 0
        #10; // Wait for a clock cycle

        #10 start = 1;
        #10 start = 0;


        #300 x = 16'h2000;  // x = 0.25
        #10; // Wait for a clock cycle

        #10 start = 1;
        #10 start = 0;

        // End simulation
        #100 $finish;
    end







	// …

endmodule


