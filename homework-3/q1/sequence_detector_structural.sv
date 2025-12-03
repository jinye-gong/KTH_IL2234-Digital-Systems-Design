module sequence_detector_structural (
    input logic clk,
    input logic rst_n,
    input logic input_sequence,
    output logic detected
);

	// …
	// Add your description here

logic d0,q0;
logic d1,q1;
logic d2,q2;
logic d3,q3;
logic d4,q4;
logic d5,q5;

    // Combinational Logic for D Flip-Flop inputs

assign d0 = ~input_sequence; 
assign d1 = input_sequence & q0;
assign d2 = input_sequence & q1;
assign d3 = input_sequence & q2;
assign d4 = input_sequence & q3;
assign d5 = input_sequence & (q4|q5);

assign detected = input_sequence & q5;


    // D Flip-Flops 
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q0 <= 1'b1;
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
            q4 <= 1'b0;
            q5 <= 1'b0;
        end else begin
            q0 <= d0;
            q1 <= d1;
            q2 <= d2;
            q3 <= d3;
            q4 <= d4;
            q5 <= d5;
        end
    end     










	// …

endmodule

