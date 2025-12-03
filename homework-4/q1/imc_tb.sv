module imc_tb;

// Testbench code goes here




localparam int WIDTH = 16;

  // 端口信号
    logic                   clk;
    logic                   rst_n;
    logic                   start;
    logic                   ready;

    logic [WIDTH-1:0]       aIn, bIn, cIn, dIn;

    logic [WIDTH-1:0]       aOut, bOut, cOut, dOut;
    logic                   aOut_sign, bOut_sign, cOut_sign, dOut_sign;

  // 被测模块
    imc #(.WIDTH(WIDTH)) dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .start     (start),
        .ready     (ready),
        .aIn       (aIn),
        .bIn       (bIn),
        .cIn       (cIn),
        .dIn       (dIn),
        .aOut      (aOut),
        .bOut      (bOut),
        .cOut      (cOut),
        .dOut      (dOut),
        .aOut_sign (aOut_sign),
        .bOut_sign (bOut_sign),
        .cOut_sign (cOut_sign),
        .dOut_sign (dOut_sign)
    );

  // ================= 时钟/复位 =================
    initial clk = 0;
    always #5 clk = ~clk;   // 100MHz

initial begin
    rst_n = 0;
    #40;                // 复位一段时间
    rst_n = 1;
end

initial begin
    start = 0;
    aIn = '0; bIn = '0; cIn = '0; dIn = '0;
    #50;                // 复位一段时间
    start = 1;
    aIn = 16'b0000_0010_0000_0000; 
    bIn = 16'b0000_0010_0000_0000; 
    cIn = 16'b0000_0001_0000_0000; 
    dIn = 16'b0000_0000_0000_0000; 
    #500;        
    start = 0;

end













endmodule