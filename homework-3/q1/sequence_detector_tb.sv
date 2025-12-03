module sequence_detector_tb;

    logic clk;
    logic rst_n;
    logic input_sequence;
    logic detected_behavioral;
    logic detected_structural;

    sequence_detector_behavioral uut (
        .clk(clk),
        .rst_n(rst_n),
        .input_sequence(input_sequence),
        .detected(detected_behavioral)
    );

    sequence_detector_structural uut2 (
        .clk(clk),
        .rst_n(rst_n),
        .input_sequence(input_sequence),
        .detected(detected_structural)
    );

	// …
	// Add your description here

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst_n = 0;
        input_sequence = 0;

        
        #12;
        rst_n = 1;

        
        #10 input_sequence = 1;
        #10 input_sequence = 0;
        #10 input_sequence = 1;
        #10 input_sequence = 1;
        #10 input_sequence = 0;
        #10 input_sequence = 1; 
        #10 input_sequence = 0;
        #10 input_sequence = 1;
        #10 input_sequence = 1;
        #10 input_sequence = 0;
        #10 input_sequence = 0;
        #10 input_sequence = 1; 
        #10 input_sequence = 1; 
        #10 input_sequence = 1;
        #10 input_sequence = 1;
        #10 input_sequence = 1;// Should detect here
        #10 input_sequence = 1;
        #10 input_sequence = 1;
        #10 input_sequence = 0;
        #10 input_sequence = 1;
        #10 input_sequence = 1;
        #10 input_sequence = 1;
        
        // Finish simulation
        #20;
        $finish;


	// …

    end
endmodule