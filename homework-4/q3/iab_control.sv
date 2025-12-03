module iab_ctrl (
  input  logic clk,
  input  logic rst_n,

  // Handshake with A (A 发起，IAB 接收 64-bit)
  input  logic readyA,       // A=1 表示有一帧64b可写
  output logic acceptedA,    // IAB=1 表示已接收/锁存该64b

  // Arbitration to shared 8-bit bus
  output logic reqIAB,       // IAB 请求总线
  input  logic gntIAB,       // 获得仲裁

  // Handshake with B over shared bus (逐字节写)
  output logic readyI,       // IAB=1 表示本拍有8b欲写
  input  logic acceptedI,    // B=1 表示已接收该8b

  // Optional: 控制数据输出使能（给数据通路/三态用）
  output logic bus_oe,       // 只有突发期间并持有grant时为1
  // 供数据通路用的计数（指示发送第几字节；0..7）
  output logic [2:0] byte_idx
);

  //======================
  // 状态定义
  //======================
  typedef enum logic [2:0] {
    S_IDLE,       // 等 A 的 readyA
    S_ACCEPT_A,   // 向A回覆acceptedA，上锁存64b
    S_REQ_BUS,    // 拉起reqIAB等待gntIAB
    S_BURST,      // 突发发送8个字节，readyI/acceptedI握手
    S_DONE        // 一帧完成，整理并回到IDLE
  } state_t;

  state_t st, nst;

  // 3-bit 计数器数8拍
  logic [2:0] cnt;
  logic       last;          // =1 表示当前字节是最后一个(索引7)

  assign last     = (cnt == 3'd7);
  assign byte_idx = cnt;

  //======================
  // 状态寄存器与计数寄存器
  //======================
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      st  <= S_IDLE;
      cnt <= 3'd0;
    end else begin
      st <= nst;

      // 计数规则：仅在突发阶段且当前字节被 B 接收时自增
      if (st == S_BURST && acceptedI) begin
        if (!last) cnt <= cnt + 3'd1;
        else       cnt <= 3'd0;  // 完成一帧复位为0
      end

      // 若在等待总线期间（或被打断）离开突发，则保证计数清零
      if (st == S_REQ_BUS && nst != S_BURST) begin
        cnt <= 3'd0;
      end
    end
  end

  //======================
  // 次态逻辑
  //======================
  always_comb begin
    nst = st;
    unique case (st)
      S_IDLE: begin
        // A 准备好一帧64b
        if (readyA) nst = S_ACCEPT_A;
      end

      S_ACCEPT_A: begin
        // 单拍确认接收后立即去申请总线
        nst = S_REQ_BUS;
      end

      S_REQ_BUS: begin
        // 等到 grant 才能开始突发
        if (gntIAB) nst = S_BURST;
      end

      S_BURST: begin
        // 每当当前字节被接收且是最后一拍，则完成
        if (acceptedI && last) nst = S_DONE;

        // 可选健壮性：若突发期间失去 gnt，则回去重申请求
        else if (!gntIAB)      nst = S_REQ_BUS;
      end

      S_DONE: begin
        // 归位，等待下一帧
        nst = S_IDLE;
      end

      default: nst = S_IDLE;
    endcase
  end

  //======================
  // 输出逻辑（纯组合，基于当前态/输入）
  //======================
  always_comb begin
    // 默认值
    acceptedA = 1'b0;
    reqIAB    = 1'b0;
    readyI    = 1'b0;
    bus_oe    = 1'b0;

    unique case (st)
      S_IDLE: begin
        // 无动作
      end

      S_ACCEPT_A: begin
        // 对 A 的“全响应两线握手”：看到 readyA 后回一个 acceptedA
        // 这里设计为脉冲 1 个周期来触发数据通路锁存64位
        acceptedA = 1'b1;
      end

      S_REQ_BUS: begin
        // 向仲裁器持续请求直到获得 gntIAB
        reqIAB = 1'b1;
      end

      S_BURST: begin
        // 只有持有 grant 才能驱动总线
        reqIAB = 1'b1;         // 保持请求，通常仲裁会在突发期间不撤销
        bus_oe = gntIAB;       // 使能三态/数据驱动

        // 对 B 的“全响应两线握手”
        // 本拍我们要送一个字节，则拉高 readyI，直到对方给 acceptedI
        // 若对方未接收(acceptedI=0)，readyI 持续为 1（背压）
        readyI = gntIAB;       // 简洁做法：有总线就一直准备好送当前字节
      end

      S_DONE: begin
        // 一帧结束：释放总线，所有控制信号回零
      end
    endcase
  end

endmodule
