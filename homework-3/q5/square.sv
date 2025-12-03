module square (
    input  logic        clk,             
    input  logic        rst_n,          
    input  logic [15:0] x,                
    input  logic        enable,           
    output logic [31:0] result           
);

    
    reg [31:0] result_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result_reg <= 32'b0;        
        end else if (enable) begin
            result_reg <= x * x;       
        end
    end


    assign result = result_reg;

endmodule
