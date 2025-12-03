`timescale 1ns/1ps

module tb_iw_top_min;

  // 端口
    logic        clk = 0;
    logic        rst_n = 0;
    logic        dataReady = 0;
    logic [15:0] dataIn    = '0;
    logic        dataAccept;

    logic        imc_ready = 1;   // 最简单：一直允许（IMC可接收）
    logic        imc_start;
    logic [15:0] a, b, c, d;

  // 时钟 10ns
    always #5 clk = ~clk;

  // DUT
iw_top dut (
    .clk(clk), .rst_n(rst_n),
    .dataReady(dataReady), .dataIn(dataIn), .dataAccept(dataAccept),
    .imc_ready(imc_ready), .imc_start(imc_start),
    .a(a), .b(b), .c(c), .d(d)
);


initial begin
    // 复位
    repeat (4) @(posedge clk);
    rst_n = 1;

    // 依次送4个16位数据；dataReady 每个数据拉高1拍
    @(posedge clk); dataIn <= 16'h0011; dataReady <= 1;
    @(posedge clk); dataReady <= 0;

    @(posedge clk); dataIn <= 16'h0022; dataReady <= 1;
    @(posedge clk); dataReady <= 0;

    @(posedge clk); dataIn <= 16'h0033; dataReady <= 1;
    @(posedge clk); dataReady <= 0;

    @(posedge clk); dataIn <= 16'h0044; dataReady <= 1;
    @(posedge clk); dataReady <= 0;

    // 再等一会儿看 imc_start 和 a/b/c/d
    repeat (10) @(posedge clk);
    $finish;
end


endmodule
