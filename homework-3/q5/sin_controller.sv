module sin_controller (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic        co,
    output logic        done,
    output logic        load_xpowertwo,
    output logic        init_xpowertwo,
    output logic        load_mult_reg,
    output logic        init_mult_reg,
    output logic        load_result,
    output logic        init_result,
    output logic        inc_counter,
    output logic        init_counter,
    output logic        sel_mult_in
);

	// …
	// Add your description here

    typedef enum logic [2:0] {
        IDLE          = 3'd0,
        INIT          = 3'd1,
        LOAD          = 3'd2,
        MULT1         = 3'd3,
        MULT2         = 3'd4,
        ADD           = 3'd5
    } state_t;

    state_t present_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= IDLE;
        else
            present_state <= next_state;
    end

    always_comb begin
        next_state = IDLE;   

        case (present_state)
            IDLE:  next_state = (!start) ? IDLE : INIT;
            INIT:  next_state = (start)  ? INIT : LOAD;
            LOAD:  next_state = MULT1;
            MULT1: next_state = MULT2;
            MULT2: next_state = ADD;
            ADD:   next_state = (co) ? IDLE : MULT1;
            default: next_state = IDLE;
        endcase
    end

    always_comb begin
        done            = 1'b0; sel_mult_in      = 1'b0;
        init_xpowertwo  = 1'b0; load_xpowertwo   = 1'b0; 
        init_mult_reg   = 1'b0; load_mult_reg    = 1'b0; 
        init_result     = 1'b0; load_result      = 1'b0;
        init_counter    = 1'b0; inc_counter      = 1'b0;

    case (present_state)
        IDLE: begin
            done  = 1'b1;
        end

        INIT: begin
            init_counter    = 1'b1;
            init_result     = 1'b1;
            init_mult_reg   = 1'b1;
            init_xpowertwo  = 1'b1;
        end

        LOAD: begin
            load_xpowertwo = 1'b1;
        end

        MULT1: begin
            sel_mult_in = 1'b0;
            load_mult_reg = 1'b1;
        end

        MULT2: begin
            sel_mult_in = 1'b1;
            load_mult_reg = 1'b1;
        end

        ADD: begin
            load_result   = 1'b1;
            inc_counter   = 1'b1;
        end

        default: begin
            done            = 1'b0; sel_mult_in      = 1'b0;
            init_xpowertwo  = 1'b0; load_xpowertwo   = 1'b0; 
            init_mult_reg   = 1'b0; load_mult_reg    = 1'b0; 
            init_result     = 1'b0; load_result      = 1'b0;
            init_counter    = 1'b0; inc_counter      = 1'b0;
        end
    endcase
end



	// …

endmodule