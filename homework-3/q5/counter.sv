module counter (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 init0,
    input  logic                 enable,
    output logic [2:0] count,
    output logic                 co
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 1;
        else if (init0)
            count <= 1;
        else if (enable)
            count <= count + 1;
    end

    assign co = &count;

endmodule
