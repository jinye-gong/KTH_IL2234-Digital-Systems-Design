module sub(
    input  logic [15:0] a,  
    input  logic [15:0] b,   
    output logic [15:0] diff
);
    always_comb begin
        if (a >= b) begin
            diff = a - b;
        end else begin
            diff = b - a;
        end
    end
endmodule
