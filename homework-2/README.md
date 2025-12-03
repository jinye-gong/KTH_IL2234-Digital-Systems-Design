# IL2234 – Homework 2  
Digital Systems Design and Verification using HDLs (KTH)

## English

This repository contains the **Homework 2** code and related files for the KTH course  
**IL2234 – Digital Systems Design and Verification using Hardware Description Languages**. 

The homework focuses on designing, modeling and verifying several sequential digital systems in SystemVerilog:

- **Question 1 – Parametric N-bit shift register**  
  An N-bit shift register with serial/parallel loading, controlled by `serial_parallel` and `load_enable`, with both serial and parallel outputs. 

- **Question 2 – 6-bit LFSR (Linear Feedback Shift Register)**  
  A 6-bit LFSR that can either load an initial value in parallel (`sel = 0`) or run in shift/LFSR mode (`sel = 1`). 

- **Question 3 – Parametric N-bit up/down counter**  
  An N-bit counter with `up_down` direction control, synchronous `load` from `input_load`, and `carry_out` indicating wrap-around in both directions. 

- **Question 4 – 16-bit counter & frequency divider**  
  A 16-bit counter constructed by cascading four 4-bit counters, extended to a frequency divider that alternates between division ratios 18 and 866. 

- **Question 5 – 16×8 register file with two read ports**  
  An 8-bit-wide, 16-entry register file with one write port and two synchronous read ports, controlled by `write_en` and address signals. 

Each design is accompanied by a System Verilog testbench that verifies its required functionality.

### Repository structure

```text
.
├── q1/                  # HDL source and testbench for Question 1
├── q2/                  # Question 2
├── q3/                  # Question 3
├── q4/                  # Question 4
├── q5/                  # Question 5
├── Homework_2.pdf       # Original assignment specification
└── README.md            # This file

```

This repository is only intended for study and submission within the IL2234 course and must comply with KTH’s academic integrity rules.

------

# IL2234 – Homework 2

数字系统设计与验证使用硬件描述语言

## 中文

本仓库包含 KTH 课程 **IL2234 – Digital Systems Design and Verification using Hardware Description Languages** 的 **Homework 2** 作业代码与相关文件。

本次作业主要使用 System Verilog 设计、建模并验证多种时序数字系统：

- **Question 1 – 可参数化 N 位移位寄存器**
   设计一个 N-bit 移位寄存器，在 `load_enable` 有效时更新，可通过 `serial_parallel` 选择串行或并行装载数据，同时提供串行与并行输出。

- **Question 2 – 6 位 LFSR 线性反馈移位寄存器**
   设计一个 6-bit LFSR，当 `sel = 0` 时并行加载初始值，当 `sel = 1` 时进入移位/LFSR 工作模式，输出为 6 位寄存器内容。

- **Question 3 – 可参数化 N 位加/减计数器**
   设计 N-bit up/down counter，通过 `up_down` 控制计数方向，`load` 信号用于在时钟上升沿加载 `input_load`，`carry_out` 在计数上溢或下溢（回环）时置位。

- **Question 4 – 16 位计数器与分频器**
   级联四个 4-bit 计数器构成 16-bit 计数器，并在此基础上实现一个频率分频器，使输出在分频比 18 与 866 之间交替。

- **Question 5 – 16×8 双读口寄存器堆**
   设计一个深度为 16、数据宽度为 8 的寄存器文件，具有一个写端口和两个读端口，写使能由 `write_en` 控制，读操作与时钟同步。

每个题目均配有相应的 System Verilog testbench，用于验证功能是否满足题目要求。

### 仓库结构

```text
.
├── q1/                  # Question 1 的 HDL 源码与 testbench
├── q2/                  # Question 2
├── q3/                  # Question 3
├── q4/                  # Question 4
├── q5/                  # Question 5
├── Homework_2.pdf       # 作业题目说明
└── README.md            # 本文件
```

本仓库仅用于 IL2234 课程学习和作业提交，请遵守 KTH 的学术诚信政策，禁止抄袭与不当公开传播代码。
