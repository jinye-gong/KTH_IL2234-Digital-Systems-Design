`timescale 1ns/1ps

module tb_ow_top_simple;

  // 时钟/复位
logic clk = 0;
logic rst_n = 0;
always #5 clk = ~clk;

  // DUT 端口
logic        imc_ready;
logic [15:0] a_in, b_in, c_in, d_in;
logic        startTransmit;
logic        outAvail;
logic        request;
logic        grant;
logic [15:0] dataOut;
logic        outReady;
logic        outAccepted;

  // 例化 DUT
ow_top dut (
    .clk           (clk),
    .rst_n         (rst_n),
    .imc_ready     (imc_ready),
    .a_in          (a_in),
    .b_in          (b_in),
    .c_in          (c_in),
    .d_in          (d_in),
    .startTransmit (startTransmit),
    .outAvail      (outAvail),
    .request       (request),
    .grant         (grant),
    .dataOut       (dataOut),
    .outReady      (outReady),
    .outAccepted   (outAccepted)
);

  // 最简单：接收方总是接受（与 outReady 同步）
assign outAccepted = outReady;

initial begin
    // 初值
    imc_ready      = 0;
    startTransmit  = 1;      // 一直允许发送
    grant          = 1;      // 一直授权
    a_in = 16'hA001; b_in = 16'hB002; c_in = 16'hC003; d_in = 16'hD004;

    // 复位
    repeat (2) @(posedge clk);
    rst_n = 1;

    // 给 IMC 就绪一个上升沿（1 拍脉冲）
    @(posedge clk); imc_ready <= 1;
    @(posedge clk); imc_ready <= 0;

    // 等几拍让 4 拍发送跑完
    repeat (10) @(posedge clk);
    $finish;
  end

endmodule
