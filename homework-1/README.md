# IL2234 – Homework 1  
Digital Systems Design and Verification using HDLs (KTH)

## English

This repository contains the **Homework 1** code and related files for the KTH course  
**IL2234 – Digital Systems Design and Verification using Hardware Description Languages**.   

The homework focuses on implementing and verifying a set of basic digital circuit modules using a hardware description language (HDL):

- A 4-bit one-hot decoder implemented using a **1-to-16 demultiplexer** (Question 1)   
- A 4-bit binary to **BCD encoder** implemented using a **16-to-1 multiplexer** (Question 2)   
- An **8-bit unsigned Carry Select Adder (CSA)** built from 4-bit adders (Question 3)   
- A **population counter** that counts the number of 1's in a 4-bit input (Question 4)   
- A binary to **Gray encoder** implemented using a 16-to-1 multiplexer (Question 5)   
- A parameterizable **arithmetic right shifter** (Question 6)   
- A signed **N-bit multiplier** implemented using half adders and full adders (Question 7)   
- A multiply–accumulate / weighted-sum circuit computing  
  `out = Σ X_k · X_{k+1},  k ∈ {0, 2, 4}` (Question 8)   
- A **16-bit unsigned multiplier** composed of multiple 4-bit multipliers (Question 9)   

### Repository structure

```text
.
├── q1/                  # HDL source and testbench for Question 1
├── q2/                  # Question 2
├── q3/                  # Question 3
├── q4/                  # Question 4
├── q5/                  # Question 5
├── q6/                  # Question 6
├── q7/                  # Question 7
├── q8/                  # Question 8
├── q9/                  # Question 9
├── Homework_1.pdf       # Original assignment specification
└── README.md            # This file
```

This repository is only intended for study and submission within the IL2234 course and must comply with KTH’s academic integrity rules.



# IL2234 – Homework 1  

数字系统设计与验证使用硬件描述语言

## 中文

本仓库包含 KTH 课程 IL2234 – Digital Systems Design and Verification using Hardware Description Languages 的 Homework 1 作业代码与相关文件。

作业要求使用硬件描述语言（HDL）实现和验证若干基础数字电路模块：

- 使用 1-to-16 解复用器 实现的 4-bit one-hot 解码器（Question 1）

- 使用 16-to-1 复用器 实现的 4-bit 二进制到 BCD 编码器（Question 2）

- 基于 4-bit 加法器构建的 8-bit 无符号 Carry Select Adder (CSA)（Question 3）

- 4-bit 输入中 1 的个数计数器（Question 4）

- 使用 16-to-1 复用器的 二进制到 Gray 编码器（Question 5）

- 可参数化的 算术右移器（Question 6）

- 使用半加器/全加器实现的 有符号 N-bit 乘法器（Question 7）

- 计算 out = Σ X_k · X_{k+1}, k∈{0,2,4} 的 加权求和/乘加电路（Question 8）

- 由多个 4-bit 乘法器构成的 16-bit 无符号乘法器（Question 9）

### 仓库结构

```text
.
├── q1/                  # 各题目的 HDL 源码与 testbench（Question 1）
├── q2/                  # Question 2
├── q3/                  # Question 3
├── q4/                  # Question 4
├── q5/                  # Question 5
├── q6/                  # Question 6
├── q7/                  # Question 7
├── q8/                  # Question 8
├── q9/                  # Question 9
├── Homework_1.pdf       # 原始题目说明
└── README.md            # 本文件
```

本仓库仅用于 IL2234 课程学习和作业提交，请遵守 KTH 的学术诚信政策，禁止抄袭与不当公开传播代码。
