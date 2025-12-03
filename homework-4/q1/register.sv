module register #(
    parameter BIT_WIDTH = 16
    ) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 init,
    input  logic                 load,
    input  logic [BIT_WIDTH-1:0] in_value,
    output logic [BIT_WIDTH-1:0] out_value
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            out_value <= '0;
        else if (init)
            out_value <= '0;
        else if (load)
            out_value <= in_value;
    end
endmodule