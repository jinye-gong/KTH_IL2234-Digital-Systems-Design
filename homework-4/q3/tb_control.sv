`timescale 1ns/1ps
module iab_ctrl_tb_tiny;
  // DUT ports
  logic clk=0, rst_n=0;
  logic readyA, acceptedA;
  logic reqIAB, gntIAB;
  logic readyI, acceptedI;
  logic bus_oe;
  logic [2:0] byte_idx;

  // clock
  always #5 clk = ~clk;

  // DUT
  iab_ctrl dut(
    .clk(clk), .rst_n(rst_n),
    .readyA(readyA), .acceptedA(acceptedA),
    .reqIAB(reqIAB), .gntIAB(gntIAB),
    .readyI(readyI), .acceptedI(acceptedI),
    .bus_oe(bus_oe), .byte_idx(byte_idx)
  );

  initial begin
    // init
    readyA=0; gntIAB=0; acceptedI=0;
    repeat(3) @(posedge clk); rst_n=1;

    //========================
    // 场景1：正常 8 字节突发
    //========================
    // A->IAB：A 就绪，等待 acceptedA
    readyA <= 1;
    @(posedge clk);
    wait(acceptedA==1);
    readyA <= 0;

    // 申请总线后给 grant
    wait(reqIAB==1);
    repeat(2) @(posedge clk);
    gntIAB <= 1;

    // 逐字节：readyI=1 时给 acceptedI 脉冲
    for (int i=0;i<8;i++) begin
      wait(readyI==1);
      acceptedI <= 1; @(posedge clk); acceptedI <= 0;
      if (i<7) wait(byte_idx==i+1);
    end

    gntIAB <= 0;                 // 完成后撤销 grant
    repeat(5) @(posedge clk);

    //=====================================
    // 场景2：B 端背压（第2/5/7字节各卡两拍）
    //=====================================
    readyA <= 1;
    @(posedge clk);
    wait(acceptedA==1);
    readyA <= 0;

    wait(reqIAB==1);
    repeat(2) @(posedge clk);
    gntIAB <= 1;

    for (int j=0;j<8;j++) begin
      // 背压：在第2/5/7个字节（索引1/4/6）额外等两拍
      if (j==1 || j==4 || j==6) repeat(2) @(posedge clk);

      wait(readyI==1);
      acceptedI <= 1; @(posedge clk); acceptedI <= 0;
      if (j<7) wait(byte_idx==j+1);
    end

    gntIAB <= 0;
    repeat(5) @(posedge clk);

    $finish;
  end
endmodule
