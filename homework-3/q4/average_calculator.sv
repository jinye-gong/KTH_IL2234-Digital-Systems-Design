module average_calculator #(parameter m = 8, parameter n = 4) (
    input logic clk,
    input logic rst_n,
    input logic start,
    input logic [m-1:0] inputx,
    output logic [m-1:0] result,
    output logic done
);

	// …
	// Add your description here

    logic load;                          // Load signal for datapath
    logic shift;                         // Shift signal for datapath
    logic init_sum;                      // Signal to initialize sum
    logic init_shift;                    // Signal to initialize shifted sum



average_calc_datapath #(m, n) datapath (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .shift(shift),
        .init_sum(init_sum),
        .init_shift(init_shift),
        .inputx(inputx),
        .result(result)  // Output from datapath
    );


average_calc_controller #(n) controller (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .init_sum(init_sum),
        .init_shift(init_shift),
        .load(load),
        .shift(shift),
        .done(done)  // Output from controller
    );



	// …
	
endmodule

