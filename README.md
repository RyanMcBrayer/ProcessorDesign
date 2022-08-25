# Processor Design
This repo contains a single-cylce implementation of the WISC-SP13 ISA.
This project was made for my computer architecture class. This ISA is a 16-bit architecture based off the MIPS R2000 datapath.
The processor was implemented in Verilog HDL and the ISA details are given below.

## WISC-SP13 ISA

| Instruction Format   | Syntax            | Description |
| :--                  | :--               | :-- |
| 00000 xxxxxxxxxxx    | HALT              | Cease instruction issue and dump mem |
| 00001 xxxxxxxxxxx    | NOP               |  |
| 01000 sss ddd iiiii  | ADDI Rd, Rs, imm  | Rd &#8592; Rs + I (sign ext.) |
| 01001 sss ddd iiiii  | SUBI Rd, Rs, imm  | Rd &#8592; I (sign ext.) - Rs |
| 01010 sss ddd iiiii  | XORI Rd, Rs, imm  | Rd &#8592; Rs XOR I (zero ext.) |
| 01011 sss ddd iiiii  | ANDNI Rd, Rs, imm | Rd &#8592; Rs AND ~I (zero ext.) |
| 10100 sss ddd iiiii  | ROLI Rd, Rs, imm  | Rd &#8592; Rs << I (lowest 4 bits) |
| 10101 sss ddd iiiii  | SLLI Rd, Rs, imm  | Rd &#8592; Rs << I (lowest 4 bits) |
| 10110 sss ddd iiiii  | RORI Rd, Rs, imm  | Rd &#8592; Rs >> I (lowest 4 bits) |
| 10111 sss ddd iiiii  | SRLI Rd, Rs, imm  | Rd &#8592; Rs >> I (lowest 4 bits) |
| 10000 sss ddd iiiii  | ST Rd, Rs, imm    | Mem[Rs + I (sign ext.)] &#8592; Rd |
| 10001 sss ddd iiiii  | LD Rd, Rs, imm    | Rd &#8592; Mem[Rs + I(sign ext.)] |
| 10011 sss ddd iiiii  | STU Rd, Rs, imm   | Mem[Rs + I (sign ext.)] &#8592; Rd<br />Rs &#8592; Rs + I (sign ext.) |
| 11001 sss xxx ddd xx | BTR Rd, Rs        | Rd[i] &#8592; Rs[15-i] for i=0..15 |
| 11011 sss ttt ddd 00 | ADD Rd, Rs, Rt    | Rd &#8592; Rs + Rt |
| 11011 sss ttt ddd 01 | SUB Rd, Rs, Rt    | Rd &#8592; Rt - Rs |
| 11011 sss ttt ddd 10 | XOR Rd, Rs, Rt    | Rd &#8592; Rs XOR Rt |
| 11011 sss ttt ddd 11 | ANDN Rd, Rs, Rt   | Rd &#8592; Rs AND ~Rt |
| 11010 sss ttt ddd 00 | ROL Rd, Rs, Rt    | Rd &#8592; Rs << Rt (lowest 4 bits) |
| 11010 sss ttt ddd 01 | SLL Rd, Rs, Rt    | Rd &#8592; Rs << Rt (lowest 4 bits) |
| 11010 sss ttt ddd 10 | ROR Rd, Rs, Rt    | Rd &#8592; Rs >> Rt (lowest 4 bits) |
| 11010 sss ttt ddd 11 | SRL Rd, Rs, Rt    | Rd &#8592; Rs >> Rt (lowest 4 bits) |
| 11100 sss ttt ddd xx | SEQ Rd, Rs, Rt    | if (Rs == Rt) then Rd &#8592; 1 else Rd &#8592; 0 |
| 11101 sss ttt ddd xx | SLT Rd, Rs, Rt    | if (Rs < Rt) then Rd &#8592; 1 else Rd &#8592; 0 |
| 11110 sss ttt ddd xx | SLE Rd, Rs, Rt    | if (Rs <= Rt) then Rd &#8592; 1 else Rd &#8592; 0 |
| 11111 sss ttt ddd xx | SCO Rd, Rs, Rt    | if (Rs + Rt gen a carry) then Rd &#8592; 1 else Rd &#8592; 0 |
| 01100 sss iiiiiiii   | BEQZ Rs, imm      | if (Rs == 0) then PC &#8592; PC + 2 + I (sign ext.) |
| 01101 sss iiiiiiii   | BNEZ Rs, imm      | if (Rs != 0) then PC &#8592; PC + 2 + I (sign ext.) |
| 01110 sss iiiiiiii   | BLTZ Rs, imm      | if (Rs < 0) then PC &#8592; PC + 2 + I (sign ext.) |
| 01111 sss iiiiiiii   | BGEZ Rs, imm      | if (Rs >= 0) then PC &#8592; PC + 2 + I (sign ext.) |
| 11000 sss iiiiiiii   | LBI Rs, imm       | Rs &#8592; I(sign ext.) |
| 10010 sss iiiiiiii   | SLBI Rs, imm      | Rs &#8592; (Rs << 8) |
| 00100 ddddddddddd    | J displacement    | PC &#8592; PC + 2 + D (sign ext.) |
| 00101 sss iiiiiiii   | JAL displacement  | R7 &#8592; PC + 2<br />PC &#8592; PC + 2 + D (sign ext.) |
| 00111 sss iiiiiiii   | JALR Rs, imm      | R7 &#8592; PC + 2<br />PC &#8592; Rs + I (sign ext.) |
| 00010 sss xxxxxxxx   | siic Rs           | produce `IllegalOp` exception<br />note: currently not working |
| 00010 sss xxxxxxxx   | NOP / RTI         |  |
