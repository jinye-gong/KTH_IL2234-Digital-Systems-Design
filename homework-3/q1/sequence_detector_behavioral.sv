module sequence_detector_behavioral (
    input logic clk,
    input logic rst_n,
    input logic input_sequence,
    output logic detected
);

	// …
	// Add your description here

    typedef enum logic [2:0] {
        A, B, C, D, E, F
    } state;

    state p_state,n_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p_state <= A;
        end else begin
            p_state <= n_state;
        end
    end

    always_comb begin
        case (p_state)
            A : n_state = input_sequence ? B : A;
            B : n_state = input_sequence ? C : A;   
            C : n_state = input_sequence ? D : A;
            D : n_state = input_sequence ? E : A;
            E : n_state = input_sequence ? F : A;
            F : n_state = input_sequence ? F : A;
            default: n_state = A;
        endcase
    end

    assign detected = (p_state == F) & input_sequence;

	// …

endmodule