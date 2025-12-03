# IL2234 – Homework 4  
Digital Systems Design and Verification using HDLs (KTH)

## English

This repository contains the **Homework 4** code and related files for the KTH course  
**IL2234 – Digital Systems Design and Verification using Hardware Description Languages**. :contentReference[oaicite:0]{index=0}  

All designs are implemented and verified in **SystemVerilog**, with a separate written report that includes datapath diagrams, state machines, interface block diagrams, and waveform screenshots for each task. :contentReference[oaicite:1]{index=1}  

### Contents

- **Question 1 – Inverse Matrix Calculator (IMC) for a 2×2 matrix**  
  RTL design of an inverse matrix calculator for a 2×2 matrix with 16-bit fixed-point inputs and outputs.  
  The IMC uses:
  - Two 16-bit multipliers with selectable 16-bit slices from the 32-bit product  
  - An approximate reciprocal unit (1/x)  
  - Adders/subtractors, comparators, multiplexers, and registers  
  A datapath + controller architecture is implemented to meet the timing constraint of a clock period ≤ 120d, and a testbench verifies the functional correctness.   

- **Question 2 – Input and output wrappers for IMC on a 16-bit arbitrated bus**  
  Design of an **input wrapper** and **output wrapper** that connect the IMC to a shared 16-bit bus using fully responsive two-line handshaking:
  - Input wrapper: collects four 16-bit values via `dataReady/dataAccept`, waits for IMC `ready`, asserts `start`, and forwards `aIn–dIn`.  
  - Output wrapper: waits for IMC `ready`, asserts `outAvail`, requests bus access with `request/grant`, and then sends the four 16-bit results in a burst using `outReady/outAccepted`.  
  Both wrappers are modeled with explicit datapaths and FSM controllers, and verified by testbenches.   

- **Question 3 – IAB interface between 64-bit device A and 8-bit shared bus**  
  Implementation of the **IAB** interface that allows a 64-bit device A (`dataA`) to write to device B over an arbitrated 8-bit shared bus:  
  - Handshake with A: `readyA/acceptedA` (64-bit transfer)  
  - Bus arbitration: `reqIAB/gntIAB`  
  - Handshake with B: `readyI/acceptedI` for each 8-bit chunk  
  The 64-bit word is split into eight 8-bit transfers and sent in burst mode once bus access is granted. A datapath + FSM controller is implemented and verified with a testbench.   

- **Question 4 – Constrained random test generation for CPU–Memory interface**  
  SystemVerilog constrained random stimulus for a CPU–Memory interface performing burst transfers.  
  The sequence item/transaction includes constraints on:
  - Burst length (2–8 transfers)  
  - Word-aligned addresses (4-byte alignment)  
  - Separate read and write address regions  
  - 80% read vs 20% write probability  
  - Legal `write_en` patterns with at least one byte enabled for writes and all zeros for reads  
  The random tests are used to drive read/write bursts on the interface and evaluate coverage.   

- **Question 5 – Assertion-based verification of a 1011 sequence detector**  
  A set of SystemVerilog Assertions (SVA) is written for a given Moore FSM that detects the bit sequence **1011**:  
  - Whenever output `w` is high, the last four input bits are 1011  
  - `w` is asserted for exactly one clock cycle per detection  
  - Every property uses `disable iff(!rst_n)` to mask the reset phase  
  The assertions are simulated together with the FSM to check correct behavior.   

### Repository structure

```text
.
├── q1/                                   # IMC (2×2 inverse matrix calculator) RTL + TB
├── q2/                                   # Input & output wrappers around IMC
├── q3/                                   # IAB interface (64-bit to 8-bit bus) + TB
├── q4/                                   # Constrained random tests for CPU–Memory interface
├── q5/                                   # SVA properties for 1011 sequence detector
├── Homework_4_2025.pdf                   # Original assignment specification
├── jinye Gong report of Homework4_.pdf    # Homework 4 report (design, diagrams, waveforms)
└── README.md                             # This file

```

This repository is only intended for study and submission within the **IL2234** course and must comply with KTH’s academic integrity rules.

------





## IL2234 – Homework 4

数字系统设计与验证（使用硬件描述语言）

## 中文说明

本仓库包含 KTH 课程 **IL2234 – Digital Systems Design and Verification using Hardware Description Languages** 的 **Homework 4** 作业代码与相关文件。

所有题目均使用 **SystemVerilog** 实现，并在单独的报告中给出了数据通路、状态机、总线接口结构以及仿真波形等说明。

### 作业内容

- **Question 1 – 2×2 矩阵求逆电路 IMC**
   设计一个用于计算 2×2 矩阵逆的 RTL 电路，输入和输出均为 16 位定点数（8 位整数）。
   设计中使用：
  - 两个带可选输出片段的 16 位乘法器
  - 一个组合的近似倒数模块（1/x）
  - 加法器/减法器、比较器、多路复用器和寄存器
     采用 **数据通路 + 控制器** 架构，在时钟周期不超过 120d 的约束下完成计算，并通过 testbench 验证矩阵求逆结果及符号位输出。
- **Question 2 – IMC 的输入/输出封装器（16 位仲裁总线）**
   设计 **输入封装器** 和 **输出封装器**，将 IMC 连接到一个 16 位仲裁总线，使用完全响应式两线握手协议：
  - 输入封装器：通过 `dataReady/dataAccept` 接收四个 16 位数据，等待 IMC `ready` 后拉高 `start` 并将数据送入 IMC。
  - 输出封装器：监视 IMC 的 `ready`，在结果就绪时拉高 `outAvail`，通过 `request/grant` 申请总线，之后使用 `outReady/outAccepted` 以突发方式发送四个 16 位结果。
     两个封装器均给出数据通路和控制状态机，并用 testbench 验证数据传输的正确性。
- **Question 3 – 64 位设备 A 与 8 位共享总线之间的 IAB 接口**
   设计 **IAB 接口电路**，将 64 位数据总线 `dataA` 写入通过 8 位仲裁共享总线连接的设备 B：
  - 与设备 A 之间使用 `readyA/acceptedA` 进行 64 位数据握手
  - 通过 `reqIAB/gntIAB` 向仲裁器申请总线使用权
  - 与设备 B 之间使用 `readyI/acceptedI` 完成每个 8 位数据写入
     IAB 将 64 位数据拆分为 8 个 8 位突发传输，由数据通路和控制 FSM 共同实现，并通过 testbench 验证。
- **Question 4 – CPU–Memory 接口的约束随机测试生成**
   针对带突发传输的 CPU–Memory 接口，使用 SystemVerilog 随机化事务并施加约束：
  - 突发长度在 2–8 之间
  - 地址 4 字节对齐
  - 读写访问使用不同的地址区间
  - 读写操作的概率为 80% 读 / 20% 写
  - 对写操作的 `write_en` 施加合法模式约束，至少有一个字节使能；读操作 `write_en` 固定为 0000
     通过随机激励生成多种读写突发场景，并结合波形检查验证接口行为。
- **Question 5 – 1011 序列检测器的断言验证**
   针对给定的 Moore 型 **1011 序列检测器**，编写 SystemVerilog 断言（SVA）进行形式化/仿真验证：
  - 当输出 `w` 为 1 时，最近四个输入比特必为 1011
  - 每次检测到 1011 时，`w` 只拉高一个时钟周期
  - 所有属性都使用 `disable iff(!rst_n)` 处理复位阶段
     断言与被测 FSM 一起仿真，用以自动检查功能正确性。

### 仓库结构

```
.
├── q1/                                   # IMC 求逆电路的 HDL 与 testbench
├── q2/                                   # IMC 输入/输出封装器
├── q3/                                   # IAB 接口（64 位到 8 位总线）
├── q4/                                   # CPU–Memory 接口的约束随机测试
├── q5/                                   # 1011 序列检测器的 SVA 断言
├── Homework_4_2025.pdf                   # 作业题目说明
├── jinye Gong report of Homework_4.pdf    # Homework 4 报告（设计、图和波形）
└── README.md                             # 本文件
```

本仓库仅用于 **IL2234** 课程的学习与作业提交，请严格遵守 KTH 的学术诚信政策，禁止抄袭与不当公开传播代码。

