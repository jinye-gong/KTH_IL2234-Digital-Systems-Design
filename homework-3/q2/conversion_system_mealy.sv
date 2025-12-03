module conversion_system_mealy (
    input logic clk,
    input logic rst_n,
    input logic x,
    output logic z
);

	// …
	// Add your description here
    typedef enum logic {S0, S1} state;
    state p_state, n_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            p_state <= S1;
        else
            p_state <= n_state;
    end

    always_comb begin
        case (p_state)
            S0: n_state = x ? S0 : S1;
            S1: n_state = x ? S1 : S0;
            default: n_state = S1;
        endcase
    end

    assign z = ((p_state==S1) ? x:~x);
	// 


endmodule