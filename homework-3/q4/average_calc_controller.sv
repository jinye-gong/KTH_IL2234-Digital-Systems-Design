module average_calc_controller #(parameter n = 4) (
    input logic clk,
    input logic rst_n,
    input logic start,
    output logic init_sum,
    output logic init_shift,
    output logic load,
    output logic shift,
    output logic done
);

	// …
	// Add your description here

    localparam COUNT_WIDTH = $clog2(n);

    typedef enum logic [2:0] {
        IDLE        = 3'b000,       // Waiting for start signal
        IN_SUM      = 3'b001,      // start (init_sum)
        LOAD        = 3'b010,       // Load input values into sum
        IN_SHIFT    = 3'b011,
        SHIFT       = 3'b100,      // Perform shift operation
        DONE        = 3'b101        // Average calculation is done
    } state_t;


    state_t p_state, n_state;

    logic [COUNT_WIDTH:0] count;



    always_ff @(posedge clk or negedge rst_n ) begin
        if(!rst_n) p_state <= IDLE;
        else p_state <= n_state;
    end


    always_ff@(posedge clk or negedge rst_n) begin
        if(!rst_n)          count <= 0;
        else if (init_sum)  count <= 0;
        else if (load)      count <= count + 1'b1;
    end


    always_comb begin
        n_state = IDLE;
        init_sum = 1'b0;
        init_shift = 1'b0;
        load = 1'b0;
        shift = 1'b0;
        done = 1'b0;

        case(p_state)
            IDLE: n_state = start ? IN_SUM: IDLE;

            IN_SUM: 
                begin 
                    init_sum= 1'b1; 
                    n_state = LOAD;
                end


            LOAD: 
                begin 
                    load= 1'b1; 
                    n_state = (count == n) ? IN_SHIFT: LOAD;
                end

            IN_SHIFT:
                begin 
                    init_shift= 1'b1; 
                    n_state = SHIFT;
                end

            SHIFT:
                begin 
                    shift= 1'b1; 
                    n_state = DONE;
                end

            DONE: 
                begin 
                    done= 1'b1; 
                    n_state = IDLE;
                end
            default: begin 
                n_state = IDLE;
                init_sum = 1'b0;
                init_shift = 1'b0;
                load = 1'b0;
                shift = 1'b0;
                done = 1'b0;
            end
        endcase
    end


    



	// …

endmodule