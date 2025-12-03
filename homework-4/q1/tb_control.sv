`timescale 1ns/1ps
module tb_imc_ctrl_simple;

  // 时钟/复位/握手
  logic clk = 0;
  logic rst_n = 0;
  logic start = 0;
  logic ready;

  // DUT 控制端口
  logic [1:0] mul1_a_sel, mul1_b_sel, mul2_a_sel, mul2_b_sel;
  logic       mul1_sel_out, mul2_sel_out;

  logic init_multi1, load_multi1;
  logic init_multi2, load_multi2;
  logic init_aout,   load_aout;
  logic init_aOut_sign,   load_aOut_sign;
  logic init_bout,   load_bout;
  logic init_bOut_sign,   load_bOut_sign;
  logic init_cout,   load_cout;
  logic init_cOut_sign,   load_cOut_sign;
  logic init_dout,   load_dout;
  logic init_dOut_sign,   load_dOut_sign;
  logic init_sign,   load_sign;
  logic init_det,    load_det;

  // 实例化 DUT
  imc_ctrl dut (
    .clk, .rst_n,
    .start, .ready,
    .mul1_a_sel, .mul1_b_sel, .mul2_a_sel, .mul2_b_sel,
    .mul1_sel_out, .mul2_sel_out,
    .init_multi1, .load_multi1,
    .init_multi2, .load_multi2,
    .init_aout, .load_aout,
    .init_aOut_sign, .load_aOut_sign,
    .init_bout, .load_bout,
    .init_bOut_sign, .load_bOut_sign,
    .init_cout, .load_cout,
    .init_cOut_sign, .load_cOut_sign,
    .init_dout, .load_dout,
    .init_dOut_sign, .load_dOut_sign,
    .init_sign, .load_sign,
    .init_det,  .load_det
  );

  // 100 MHz 时钟
  always #5 clk = ~clk;

  // 复位流程
  initial begin
    rst_n = 0;
    repeat(4) @(posedge clk);
    rst_n = 1;
  end

  // 简单任务：在 ready=1 时打一拍 start 脉冲
  task automatic kick();
    @(posedge clk);               // 对齐时钟
    wait (ready);                 // 等待空闲/完成
    @(posedge clk); start <= 1;   // 脉冲 1 个周期
    @(posedge clk); start <= 0;
  endtask

  // 主测试：连发几次事务，中间穿插一点无效 start 干扰
  initial begin
    // 波形（可选，Icarus/Verilator/VCS 都支持）
    $dumpfile("imc_ctrl.vcd");
    $dumpvars(0, tb_imc_ctrl_simple);

    @(posedge rst_n);
    kick();            // 事务1
    kick();            // 事务2
    // 忙碌期间乱按 start（应被忽略）
    @(posedge clk); start <= 1;
    @(posedge clk); start <= 0;
    kick();            // 事务3

    // 结束
    repeat(5) @(posedge clk);
    $display("[%0t] SIMPLE TB DONE.", $time);
    $finish;
  end

  // 打印关键信号，便于观察状态推进
  initial begin
    $display(" time | rdy st | Lm1 Lm2 | Lsg Ldet | La Lb | Lc Ld | sel1 sel2 | m1a m1b m2a m2b");
    $monitor("%5t |  %0b   %0b |  %0b   %0b |  %0b    %0b | %0b  %0b | %0b  %0b |   %0b    %0b |  %02b  %02b  %02b  %02b",
      $time, ready, start,
      load_multi1, load_multi2,
      load_sign, load_det,
      load_aout, load_bout,
      load_cout, load_dout,
      mul1_sel_out, mul2_sel_out,
      mul1_a_sel, mul1_b_sel, mul2_a_sel, mul2_b_sel
    );
  end

endmodule
