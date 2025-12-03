module iab #(parameter input_width = 64,
               parameter output_width = 8)
               (input logic clk,
                input logic rst_n,
                input logic readyA,
                input logic gntIAB,
                input logic acceptedI,
                input logic [input_width-1:0] dataA,
                output logic [output_width-1:0] dataOut,
                output logic acceptedA,
                output logic reqIAB);

// Your code goes here
  // -------- 内部连线 --------
  logic [2:0] byte_idx;   // 控制给数据通路：当前发送第几字节
  logic       bus_oe;     // 若上层需要三态，可把它往上层穿；此处内部使用
  logic       readyI;     // IAB->B 的“我有字节可发”信号（本顶层不对外暴露）
  logic       shared_oe;

   // ---------- 实例化：control ----------
  iab_ctrl u_ctrl (
    .clk       (clk),
    .rst_n     (rst_n),

    .readyA    (readyA),
    .acceptedA (acceptedA),

    .reqIAB    (reqIAB),
    .gntIAB    (gntIAB),

    .readyI    (readyI),
    .acceptedI (acceptedI),

    .bus_oe    (bus_oe),
    .byte_idx  (byte_idx)
  );

  // ---------- 实例化：datapath ----------
  iab_datapath DUT (
    .clk       (clk),
    .rst_n     (rst_n),

    // 来自设备 A 的 64 位数据
    .dataA     (dataA),
    .load64    (acceptedA),   // 锁存 dataA 的 1 拍脉冲（control 的 A_ACK）

    // 来自控制路径
    .sel_idx   (byte_idx),    // 当前发送的字节索引 0..7
    .bus_oe    (bus_oe),      // 控制驱动共享总线

    // 推荐：输出到顶层的总线驱动对
    .shared_do (dataOut),     // 要驱动到共享总线的数据
    .shared_oe (shared_oe)    // 该拍是否驱动共享总线
  );

endmodule
