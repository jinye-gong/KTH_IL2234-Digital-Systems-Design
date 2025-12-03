module serial_communication(
    input logic clk,
    input logic rst_n,
    input logic serData,
    output logic outValid
);

	// …
	// Add your description here

    typedef enum logic [2:0] {
        A, B, C, D, E, F, G
    } state;

    state p_state, n_state;
    logic i0, en;
    logic [4:0] count;
    logic co;

    always_ff @(posedge clk or negedge rst_n ) begin
        if(!rst_n) p_state <= A;
        else p_state <= n_state;
    end


    always_comb begin
        n_state = A; i0 = 1'b0; en = 1'b0;

        case(p_state)
            A: n_state = serData==0 ? B: A;
            B: n_state = serData==1 ? C: A;
            C: n_state = serData==1 ? D: A;
            D: n_state = serData==0 ? E: A;
            E: n_state = serData==1 ? F: A;
            F: begin 
                i0= 1'b1; 
                n_state = serData==0 ? G: A;
            end
            G: begin 
                en= 1'b1; 
                n_state = co ? A: G;
            end
            default: begin 
                n_state = A;
                i0 = 1'b0; 
                en = 1'b0; 
            end
        endcase
    end

    assign outValid = (p_state == G);

    always_ff@(posedge clk or negedge rst_n) begin
        if(!rst_n)   count <= 5'b00000;
        else if (i0) count <= 5'b00000;
        else if (en) count <= count + 1'b1;
    end

    assign co =&count;




	// …


endmodule