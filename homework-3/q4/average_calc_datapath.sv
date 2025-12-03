module average_calc_datapath #(
    parameter m=8,
    parameter n=4) (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic shift, 
    input logic init_sum,
    input logic init_shift,
    input logic [m-1:0] inputx,
    output logic [m-1:0] result
);

    // …
	// Add your description here

    logic [m-1:0] sum;           


    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sum <= 0;
        else if (init_sum)
            sum <= 0;
        else if (load)
            sum <= sum + inputx; 
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            result <= 0;
        else if (init_shift)
            result <= 0;
        else if (shift)
            result <= sum >> $clog2(n);  
    end



	// …
	
endmodule
