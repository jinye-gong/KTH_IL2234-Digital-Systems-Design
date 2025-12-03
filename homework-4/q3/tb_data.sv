`timescale 1ns/1ps
module iab_datapath_tb;

  // 时钟/复位
  logic clk = 0, rst_n = 0;
  always #5 clk = ~clk;     // 100 MHz

  // 共同激励
  logic [63:0] dataA;
  logic        load64;
  logic        bus_oe;
  logic        shared_oe;
  logic [2:0]  byte_idx;

  // 两个实例的输出
  logic [7:0] dataOut;   // little-endian


  iab_datapath DUT (
  .clk(clk),
  .rst_n(rst_n),

  // 来自设备 A 的 64 位数据
  .dataA(dataA),
  .load64(load64),     // 锁存 dataA 的 1 拍脉冲（来自 ctrl 的 A_ACK 状态）

  // 来自控制路径
  .sel_idx(byte_idx),    // 当前发送的字节索引 0..7（来自 ctrl 的 cnt）
  .bus_oe(bus_oe),     // 允许驱动共享总线（ctrl 在突发期间拉高）

  // 推荐：输出到顶层的总线驱动对（更好综合/跨模块复用）
  .shared_do(dataOut),  // 要驱动到共享总线的数据
  .shared_oe(shared_oe)   // 该拍是否驱动共享总线
);



  initial begin
    // 初值
    load64 = 0; byte_idx = 0; dataA = '0;bus_oe =1'b0;
    #30;
    // 复位
    rst_n = 1;
    #30;
    // 准备一帧数据并装载（示例：0x8877665544332211）
    dataA  <= 64'h8877_6655_4433_2211;
    #30;load64 <= 1'b1;

    #30; bus_oe<=1'b1; load64 <= 1'b0;

    // 逐字节读取（小端）
    #10;
    byte_idx <= 3'd0; // 0x11
    #10;
    byte_idx <= 3'd1; // 0x22
    #10;
    byte_idx <= 3'd2; // 0x33
    #10;
    byte_idx <= 3'd3; // 0x44
    #10;
    byte_idx <= 3'd4; // 0x55
    #10;
    byte_idx <= 3'd5; // 0x66
    #10;
    byte_idx <= 3'd6; // 0x77
    #10;
    byte_idx <= 3'd7; // 0x88

    
  end

endmodule
