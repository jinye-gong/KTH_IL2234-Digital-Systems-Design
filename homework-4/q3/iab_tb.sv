module iab_tb;

// Testbench code goes here


  logic clk=0, rst_n=0;
  always #5 clk = ~clk;


  logic readyA, gntIAB, acceptedI;
  logic [63:0] dataA;
  logic [7:0]  dataOut;
  logic acceptedA, reqIAB;

  iab dut (
    .clk(clk), 
    .rst_n(rst_n),
    .readyA(readyA), 
    .gntIAB(gntIAB), 
    .acceptedI(acceptedI),
    .dataA(dataA), 
    .dataOut(dataOut),
    .acceptedA(acceptedA), 
    .reqIAB(reqIAB)
  );

  initial begin
    readyA    = 1'b0;
    gntIAB    = 1'b0;
    acceptedI = 1'b0;
    dataA     = '0;

    // 复位
    repeat (3) @(posedge clk);
    rst_n = 1'b1;

    // A 侧送入一帧，并拉高 readyA
    @(posedge clk);
    dataA  <= 64'h8877_6655_4433_2211;
    readyA <= 1'b1;

    // 等 datapath 锁存：等待某个时刻 acceptedA=1
    wait (acceptedA == 1'b1);
    // 下一拍撤 readyA，表示这帧交付完成
    @(posedge clk);
    readyA <= 1'b0;

    // 等待 IAB 请求并授权
    wait (reqIAB == 1'b1);
    @(posedge clk);
    gntIAB <= 1'b1;

    // 消费 8 个字节：授权后每拍给一拍 acceptedI 脉冲
    repeat (8) begin
      @(posedge clk);
      $display("[%0t] accept byte, dataOut=0x%02h", $time, dataOut);
      acceptedI <= 1'b1;
      @(posedge clk);
      acceptedI <= 1'b0;
    end

    // 发送完收回授权
    @(posedge clk);
    gntIAB <= 1'b0;

    // 收尾
    repeat (3) @(posedge clk);
    $finish;
  end
endmodule


