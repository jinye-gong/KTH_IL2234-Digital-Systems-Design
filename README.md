# IL2234 – Digital Systems Design and Verification using HDLs  
KTH Royal Institute of Technology

This repository contains my coursework for the KTH course  
**IL2234 – Digital Systems Design and Verification using Hardware Description Languages** .

The course focuses on designing and verifying digital hardware using HDLs (mainly SystemVerilog), including RTL design, testbench construction, simulation, and basic verification techniques.

---

## Repository contents (Homeworks Overview)

### Homework 1 – Combinational logic design

**Theme:** Basic combinational building blocks and arithmetic modules.

Main tasks:

- 4-bit one-hot decoder built from a **1-to-16 demultiplexer**
- 4-bit binary to **BCD encoder** using a **16-to-1 multiplexer**
- **8-bit unsigned Carry Select Adder (CSA)** constructed from 4-bit adders
- **Population counter** that counts the number of `1`s in a 4-bit input
- Binary to **Gray code encoder** using a multiplexer
- Parameterizable **arithmetic right shifter**
- **Signed / unsigned multipliers** assembled from half-/full-adders or smaller multipliers
- Simple **multiply–accumulate / weighted-sum** combinational circuit

All modules are written in SystemVerilog (RTL style) with corresponding testbenches.

---

### Homework 2 – Sequential circuits and basic datapaths

**Theme:** Flip-flop based designs, counters, and small memories.

Main tasks:

- **Parametric N-bit shift register**  
  - Serial / parallel load modes  
  - Serial and parallel outputs  
- **6-bit LFSR (Linear Feedback Shift Register)** with selectable parallel load
- **Parametric N-bit up/down counter** with synchronous load and wrap-around indicator
- **16-bit counter and frequency divider** built from cascaded 4-bit counters
- **16×8 register file**  
  - 16 entries, 8-bit data width  
  - One write port and two synchronous read ports

Each design includes a SystemVerilog testbench to verify timing and functional behaviour.

---

### Homework 3 – FSMs and controller + datapath design

**Theme:** Finite State Machines, serial protocols, and arithmetic datapaths.

Main tasks:

- **5 consecutive ones sequence detector (FSM)**  
  - Detects a run of 5 consecutive `1`s  
  - Output asserted when the 5th `1` arrives and kept high as long as the input stays `1`  
  - Both structural and behavioural implementations

- **Message conversion system (Mealy & Moore FSMs)**  
  - Input stream `x` → output `z`  
  - If `x = 0`, toggle `z`; if `x = 1`, keep `z`  
  - Both Mealy and Moore versions designed and compared

- **Serial communication device with begin-sequence**  
  - Detects a fixed begin sequence `011010`  
  - After detection, marks the next 32 bits as valid data

- **Average calculator (datapath + controller)**  
  - Computes the average of `n = 2^k` numbers (k > 1), with parameterizable bit-width  
  - Clear split between datapath and control FSM

- **sin(x) accelerator using Taylor series**  
  - Fixed-point input `x ∈ [0, π/2)` (1-bit integer + 15-bit fraction)  
  - Iterative Taylor-series based approximation over several iterations  
  - Fixed-point 16-bit fractional output and `done` signalling

A written report documents FSM diagrams, datapaths, and simulation results.

---

### Homework 4 – System-level design and verification techniques

**Theme:** More complex datapaths, bus interfaces, constrained random tests, and assertions.

Main tasks:

- **2×2 Inverse Matrix Calculator (IMC)**  
  - RTL datapath to compute the inverse of a 2×2 matrix in fixed-point  
  - Uses limited resources: 16-bit multipliers, approximate reciprocal unit, adders, comparators, multiplexers, registers  
  - Controlled by an FSM to meet a given timing (clock period) constraint

- **Input/Output wrappers for IMC on an arbitrated 16-bit bus**  
  - Input wrapper that collects four 16-bit values over a handshake protocol and starts the IMC  
  - Output wrapper that waits for the IMC result, arbitrates for the bus, and sends four 16-bit results in a burst

- **IAB interface (64-bit device to 8-bit shared bus)**  
  - Splits 64-bit transfers from device A into 8× 8-bit transfers  
  - Handles separate handshaking with device A, bus arbiter, and device B

- **Constrained random test generation for a CPU–Memory interface**  
  - SystemVerilog classes and constraints for burst length, address alignment, read/write regions, and write-enable patterns  
  - Generates diverse read/write burst scenarios for verification

- **Assertion-based verification of a 1011 sequence detector**  
  - SystemVerilog Assertions (SVA) to check correctness of a Moore FSM  
  - Properties on output pulse width, input history, and reset behaviour

---

## Repository structure (example)

> The exact layout may differ; update this section if your folder names are different.

```text
.
├── homework_1/                 # Homework 1 – combinational designs (q1–q9)
├── homework_2/                 # Homework 2 – sequential circuits (q1–q5)
├── homework_3/                 # Homework 3 – FSMs & datapaths (q1–q5)
├── homework_4/                 # Homework 4 – system design & verification (q1–q5)
└── README.md                   # This file
```

Each homework directory typically contains:

- `qX/` subfolders with SystemVerilog RTL and testbenches
- The original assignment PDF
- A short report (PDF) with diagrams and waveforms

------

## Tools and languages

- **HDL:** SystemVerilog (with RTL-style design)
- **Topics:** combinational / sequential logic, FSMs, datapath & controller, bus interfaces, constrained random verification, assertions
- **Use:** educational only, for IL2234 coursework and examination

------

## Academic integrity

All files in this repository are intended **only** for study and course examination at KTH. 

Please do **not** use this repository for plagiarism, and do **not** redistribute the solutions in ways that violate KTH’s rules on collaboration and academic honesty.

------







# 中文说明

## 仓库简介

本仓库汇总了 KTH 课程
 **IL2234 – Digital Systems Design and Verification using Hardware Description Languages**（数字系统设计与验证，使用硬件描述语言）的四次大作业代码和文档。

主要内容包括：SystemVerilog RTL 设计、testbench 编写、仿真验证，以及简单的验证方法（随机约束生成、断言等）。

------

## 四个作业概览

### Homework 1 – 组合逻辑设计

**主题：** 基础组合电路与算术模块。

- 使用解复用器和复用器实现的编码器/解码器（one-hot 解码、BCD 编码、Gray 编码）
- 由 4-bit 加法器搭建的 **8-bit Carry Select Adder**
- 4-bit 输入 `1` 的个数计数器（population counter）
- 可参数化的 **算术右移器**
- 基于半加器/全加器或小位宽乘法器构建的乘法器
- 简单的乘加 / 加权求和组合电路

所有模块均配有 SystemVerilog testbench，用于基本功能仿真。

------

### Homework 2 – 时序电路与小型数据通路

**主题：** 触发器、移位寄存器、计数器和寄存器堆。

- 可参数化 **N 位移位寄存器**（串行/并行装载，串行/并行输出）
- **6 位 LFSR 线性反馈移位寄存器**
- **N 位 up/down 计数器**（支持同步 load，溢出/回环指示）
- 由 4-bit 计数器级联得到的 **16 位计数器与分频器**
- **16×8 寄存器堆**（1 写 2 读）

每个模块都通过 SystemVerilog testbench 验证时序和功能。

------

### Homework 3 – 有限状态机与控制器 + 数据通路

**主题：** FSM 设计、串行协议、算术数据通路。

- **连续 5 个 1 的序列检测器**（FSM，结构化 & 行为级两种实现）
- **消息转换系统**：输入 `x` 为 0 时翻转输出 `z`，为 1 时保持；分别用 Mealy 和 Moore FSM 实现并比较
- **带起始序列的串行通信设备**：检测 `011010` 作为起始序列，随后采集 32 位有效数据
- **平均值计算器**：计算 `2^k` 个 m-bit 无符号数的平均值，采用数据通路 + 控制器结构
- **基于泰勒展开的 sin(x) 加速器**：定点输入 `x ∈ [0, π/2)`，多次迭代近似计算 `sin(x)`

配套报告中给出了状态机图、数据通路结构图和仿真波形截图。

------

### Homework 4 – 系统级设计与验证技术

**主题：** 复杂数据通路、总线接口、随机验证与断言。

- **2×2 矩阵求逆电路 IMC**：有限资源下的 RTL 数据通路与控制器设计，输入输出均为定点数
- **IMC 的输入/输出封装器**：通过 16 位仲裁总线与外部系统进行握手和结果传输
- **IAB 接口**：在 64 位设备 A 与 8 位共享总线/设备 B 之间进行数据适配和突发传输
- **CPU–Memory 接口的约束随机测试**：使用 SystemVerilog 随机化事务和约束生成多种读写突发场景
- **1011 序列检测器的断言验证**：为 Moore 型状态机编写 SVA 断言，自动检查输入历史与输出脉冲宽度是否正确

------

## 仓库结构

```text
.
├── homework_1/                 # Homework 1：组合逻辑与算术模块
├── homework_2/                 # Homework 2：时序电路与寄存器堆
├── homework_3/                 # Homework 3：FSM 与控制器+数据通路
├── homework_4/                 # Homework 4：系统设计与验证
└── README.md
```

## 使用说明与学术诚信

- 本仓库仅用于 IL2234 课程学习与作业展示。
- 请遵守 KTH 的学术诚信政策，不要将本仓库内容用于任何形式的抄袭或违规共享。
