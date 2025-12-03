# IL2234 – Homework 3  
Digital Systems Design and Verification using HDLs (KTH)

## English

This repository contains the **Homework 3** code and related files for the KTH course  
**IL2234 – Digital Systems Design and Verification using Hardware Description Languages**. :contentReference[oaicite:0]{index=0}  

All designs are implemented in **SystemVerilog**, with corresponding testbenches and a written report summarizing the design decisions, FSM diagrams, datapaths, and simulation results. :contentReference[oaicite:1]{index=1}  

### Contents

- **Question 1 – 5 consecutive ones sequence detector (FSM)**  
  Design of a finite state machine that detects an input sequence of **five consecutive '1's**.  
  The output `detected` is asserted in the same cycle when the 5th `1` arrives and remains high as long as the input stays `1`.  
  Both **structural** and **behavioral** SystemVerilog models are implemented and verified.   

- **Question 2 – Message conversion system (Mealy & Moore FSMs)**  
  A system that converts an input bit stream `x` into an output `z` according to:  
  - If `x = 0`, toggle the current `z`;  
  - If `x = 1`, keep `z` unchanged.  
  Both a **Mealy** and a **Moore** FSM are designed, modeled, and compared in terms of timing, number of states, and waveforms.   

- **Question 3 – Serial communication device with begin-sequence**  
  A Moore FSM that looks for a fixed begin-sequence **011010** on `serData`.  
  After detecting this sequence, `outValid` is asserted and the next **32 bits** on `serData` are treated as valid data; then the FSM returns to the search state.   

- **Question 4 – Average calculator (datapath + controller)**  
  A parameterized average calculator that computes the average of `n = 2^k` (k > 1) **m-bit** input numbers.  
  The design uses a **datapath + controller** structure, starts on a `start` pulse, and asserts `done` when the average is ready.   

- **Question 5 – sin(x) accelerator using Taylor series**  
  An accelerator that approximates `sin(x)` based on its **Taylor series expansion**, for  
  `x` in fixed-point format: 1-bit integer + 15-bit fraction, `x ∈ [0, π/2)`.  
  It performs **8 iterations**, uses a provided coefficient LUT, and outputs a 16-bit fractional result `result ∈ [0, 1)`, with `done` asserted when the computation finishes.   

### Repository structure

```text
.
├── q1/                               # FSM for 5 consecutive ones detector
├── q2/                               # Mealy & Moore message conversion FSMs
├── q3/                               # Serial communication device (begin-sequence + 32 bits)
├── q4/                               # Average calculator (datapath + controller)
├── q5/                               # sin(x) accelerator (datapath + controller)
├── Homework_3_2025.pdf               # Original assignment specification
├── jinye Gong report of Homework_3.pdf  # Homework 3 report (design, diagrams, waveforms)
└── README.md                         # This file

```

This repository is only intended for study and submission within the IL2234 course and must comply with KTH’s academic integrity rules.

------









## IL2234 – Homework 3

数字系统设计与验证（使用硬件描述语言）

## 中文说明

本仓库包含 KTH 课程 **IL2234 – Digital Systems Design and Verification using Hardware Description Languages** 的 **Homework 3** 作业代码与相关文件。

所有题目均使用 **SystemVerilog** 实现，并配有相应的 testbench 与报告，用于展示状态机图、数据通路设计以及仿真波形等结果。

### 作业内容

- **Question 1 – 连续 5 个 1 的序列检测器（FSM）**
   设计一个有限状态机，用于检测输入信号中是否出现连续 **5 个 '1'**。
   当第 5 个 `1` 到来时，同一周期内将 `detected` 置 1，并在输入保持为 1 时持续保持。
   实现了 **结构化（structural）** 和 **行为级（behavioral）** 两种 SystemVerilog 模型，并比较其仿真结果。
- **Question 2 – 消息转换系统（Mealy 与 Moore 状态机）**
   根据以下规则将输入比特流 `x` 转换为输出 `z`：
  - 若 `x = 0`，则翻转当前输出 `z`；
  - 若 `x = 1`，则保持 `z` 不变。
     分别构建 **Mealy** 和 **Moore** 两种状态机，实现相同行为，并在报告中比较它们在时序、状态数和输出波形上的差异。
- **Question 3 – 起始序列的串行通信设备**
   设计一个 Moore FSM，用于在 `serData` 上检测固定起始序列 **011010**。
   检测到序列后，`outValid` 置 1，随后连续 **32 个时钟周期**内输入的比特被视为有效串行数据，完成后重新回到起始状态继续搜索。
- **Question 4 – 平均值计算器（数据通路 + 控制器）**
   设计一个参数化平均值计算器，用于计算 `n = 2^k`（k > 1）个 **m 位无符号数**的平均值。
   模块采用 **数据通路 + 控制器** 架构，在检测到 `start` 的上升沿后开始运算，结果就绪时拉高 `done` 信号。
- **Question 5 – 基于泰勒级数的 sin(x) 加速器**
   根据 `sin(x)` 的 **泰勒级数展开式**来近似计算 `sin(x)`：
  - 输入 `x` 为 1 位整数 + 15 位小数的定点数，`x ∈ [0, π/2)`；
  - 进行 **8 次迭代**，使用给定的系数查找表模块 `sin_coeff_lut`；
  - 输出为 16 位小数 `result ∈ [0,1)`，当计算完成时拉高 `done`。

### 仓库结构

```text
.
├── q1/                               # 连续 5 个 1 检测 FSM 的 HDL 与 testbench
├── q2/                               # Mealy / Moore 消息转换 FSM
├── q3/                               # 串行通信设备（起始序列 + 32 位数据）
├── q4/                               # 平均值计算器（数据通路 + 控制器）
├── q5/                               # sin(x) 加速器（数据通路 + 控制器）
├── Homework_3_2025.pdf               # 作业题目说明
├── jinye Gong report of Homework_3.pdf  # Homework 3 报告（设计说明与波形截图）
└── README.md                         # 本文件
本仓库仅用于 IL2234 课程的学习与作业提交，请严格遵守 KTH 的学术诚信政策，禁止抄袭与不当公开传播代码。
```

本仓库仅用于 IL2234 课程的学习与作业提交，请严格遵守 KTH 的学术诚信政策，禁止抄袭与不当公开传播代码。
