module mux3(
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [15:0] c,
    input  logic [1:0] sel,
    output logic [15:0] y
);
always_comb begin
    unique case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        default: y = a; 
    endcase
    end
endmodule
