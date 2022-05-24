andni r0, r0, 31
andni r1, r1, 31
addi r1, r1, 1
beqz r1, 4
beqz r0, 2
nop
nop
nop
subi r1, r1, 0
andni r2, r2, 31
bnez r2, 15
bnez r1, 2
nop
bltz r2, 15
andni r3, r3, 31
addi r3, r3, 128
bltz r3, 2
nop
nop
bgez r3, 35
andni r3, r3, 31
bgez r3, 2
nop
halt
