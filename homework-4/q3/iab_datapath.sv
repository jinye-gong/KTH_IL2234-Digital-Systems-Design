module iab_datapath #(parameter bit LITTLE_ENDIAN = 1'b1
)(
  input  logic        clk,
  input  logic        rst_n,

  // 来自设备 A 的 64 位数据
  input  logic [63:0] dataA,
  input  logic        load64,     // 锁存 dataA 的 1 拍脉冲（来自 ctrl 的 A_ACK 状态）

  // 来自控制路径
  input  logic [2:0]  sel_idx,    // 当前发送的字节索引 0..7（来自 ctrl 的 cnt）
  input  logic        bus_oe,     // 允许驱动共享总线（ctrl 在突发期间拉高）

  // 推荐：输出到顶层的总线驱动对（更好综合/跨模块复用）
  output logic [7:0]  shared_do,  // 要驱动到共享总线的数据
  output logic        shared_oe 
);

  // 64 位缓冲寄存器
  logic [63:0] buf64;

  // 锁存 A 侧数据：load64 为单拍即可
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      buf64 <= 64'h0;
    end else if (load64) begin
      buf64 <= dataA;
    end
  end

  // 字节选择器（组合）：根据大小端参数挑选字节
  logic [7:0] byte_sel;
  always_comb begin
    if(bus_oe == 1'b0) begin
      byte_sel = 8'hzz; // 不驱动总线时输出高阻
    end else
    if (LITTLE_ENDIAN) begin
      // 低字节先发：idx=0 对应 buf64[7:0]，idx=7 对应 [63:56]
      unique case (sel_idx)
        3'd0: byte_sel = buf64[ 7: 0];
        3'd1: byte_sel = buf64[15: 8];
        3'd2: byte_sel = buf64[23:16];
        3'd3: byte_sel = buf64[31:24];
        3'd4: byte_sel = buf64[39:32];
        3'd5: byte_sel = buf64[47:40];
        3'd6: byte_sel = buf64[55:48];
        default: byte_sel = buf64[63:56];
      endcase
    end else begin
      // 高字节先发：idx=0 对应 buf64[63:56]，idx=7 对应 [7:0]
      unique case (sel_idx)
        3'd0: byte_sel = buf64[63:56];
        3'd1: byte_sel = buf64[55:48];
        3'd2: byte_sel = buf64[47:40];
        3'd3: byte_sel = buf64[39:32];
        3'd4: byte_sel = buf64[31:24];
        3'd5: byte_sel = buf64[23:16];
        3'd6: byte_sel = buf64[15: 8];
        default: byte_sel = buf64[ 7: 0];
      endcase
    end
  end

  // 输出到共享总线的驱动对
  assign shared_do = byte_sel;
  assign shared_oe = (bus_oe==1'b1) ? 1'b1 : 1'b0;

endmodule