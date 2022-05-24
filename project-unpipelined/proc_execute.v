module proc_execute(read_data1, read_data2, extendOut, aluSrc, slbi, aluOP, op, two_lsbs, seq, slt, sle, sco, jr_jalr, jmp, beqz, bnez, bltz, bgez, displacement, incPC, nxtPC, alu_result, clk, rst, err);

input clk, rst, aluSrc, slbi;
input [15:0] read_data1;
input [15:0] read_data2;
input [15:0] extendOut;
input [2:0] aluOP;
input [4:0] op;
input [1:0] two_lsbs;

output [15:0] alu_result;
wire [15:0] raw_alu_result;
//output zf, nezf, gzf, lzf;
output err;

wire [15:0] alu_src;
wire [15:0] alu_input;
wire [2:0] aluOPcontrol;
wire invA, invB, sign, Cin, Ofl;

//Pipeline Signals
///////////////////////////////////////////////////////////////////////
//NEW I/O signals declared here (move to top later)
input seq, slt, sle, sco;
input [10:0] displacement;
input [15:0] incPC;
input jr_jalr, jmp;
input beqz, bnez, bltz, bgez;
output [15:0] nxtPC;

///////////////////////////////////////////////////////////////////////
//NEW intermediates here
wire [15:0] seqMuxOut;
wire [15:0] sltMuxOut;
wire [15:0] sleMuxOut;
wire invGZF, xor1, xor2;
wire [15:0] displacement_8;
wire [15:0] displacement_11;
wire [15:0] nxtPC_jmp;
wire [15:0] jPC;
wire [15:0] jrPC;
wire b_gzf, b_lzf, b_nezf, b_zf;
wire beqz_s, bnez_s, bltz_s, bgez_s;
wire [15:0] beqz_tgt;
wire [15:0] bnez_tgt;
wire [15:0] bltz_tgt;
wire [15:0] bgez_tgt;
wire [15:0] nxtPC_b1;
wire [15:0] nxtPC_b2;
wire [15:0] nxtPC_b3;
wire orOut;
///////////////////////////////////////////////////////////////////////

//ALU src mux
mux2_1_16b AluSrcMux(.A(extendOut), .B(read_data2), .S(aluSrc), .Out(alu_src));

//For SLBI we need to do a shift left by 8
mux2_1_16b slbiSrcMux(.A(16'h0008), .B(alu_src), .S(slbi), .Out(alu_input));

//ALU
alu_unpipelined ALU(.A(read_data1), .B(alu_input), .Cin(Cin), .Op(aluOPcontrol), .invA(invA), .invB(invB), .sign(sign), .Out(raw_alu_result), .Ofl(Ofl), .zf(zf), .gzf(gzf), .lzf(lzf), .nezf(nezf));


//ALU Control
alu_control_unpipelined alu_control(.aluOPin(aluOP), .op(op), .two_lsbs(two_lsbs), .aluOPout(aluOPcontrol), .invA(invA), .invB(invB), .Cin(Cin), .sign(sign));



//BRANCH, JUMP, and SE instr must be done in execute stage for pipeline


//SE instructions, change the alu_result

//not to invert gzf
not flag_invert(invGZF, gzf);
xor xor_1(xor1, lzf, Ofl);
xor xor_2(xor2, invGZF, Ofl);

//SEQ mux
mux2_1_16b seq_mux(.A({15'h0000, zf}), .B(raw_alu_result), .S(seq), .Out(seqMuxOut));

//SLT mux
mux2_1_16b slt_mux(.A({15'h0000, xor1}), .B(seqMuxOut), .S(slt), .Out(sltMuxOut));

//SLE mux
mux2_1_16b sle_mux(.A({15'h0000, xor2}), .B(sltMuxOut), .S(sle), .Out(sleMuxOut));

//SCO mux
mux2_1_16b sco_mux(.A({15'h0000, Ofl}), .B(sleMuxOut), .S(sco), .Out(alu_result));


//Now branches and jumps, change PC

//sign extend displacements
sign_extend8_16 extend_8(.in(displacement[7:0]), .out(displacement_8));
sign_extend11_16 extend_11(.in(displacement), .out(displacement_11));

//Jumps First

//For JMP and JAL we need nxt PC to be incPC + displacement(11bit)
fulladder16 add_JMP_JAL(.A(incPC), .B(displacement_11), .S(jPC), .Cout());

//For JR and JALR we need nxt PC to be read_data1 + displacement(8bit)
fulladder16 add_JR_JALR(.A(read_data1), .B(displacement_8), .S(jrPC), .Cout());

//need a mux to select what nxtPC should be
assign nxtPC_jmp = jr_jalr ? jrPC : jmp ? jPC : incPC;

//Now Branches

//flag unit for branches
branch_flags flag_unit(.in(read_data1), .zf(b_zf), .nezf(b_nezf), .gzf(b_gzf), .lzf(b_lzf));

//BEQZ
//full adder to calculate target addr
fulladder16 add_beqz(.A(incPC), .B(displacement_8), .S(beqz_tgt), .Cout());

//beqz AND zf make select for beqz mux
and beqz_and(beqz_s, beqz, b_zf);
//beqz mux
mux2_1_16b beqz_mux(.A(beqz_tgt), .B(nxtPC_jmp), .S(beqz_s), .Out(nxtPC_b1));

//BNEZ
//full adder to calculate target addr
fulladder16 add_bnez(.A(incPC), .B(displacement_8), .S(bnez_tgt), .Cout());

//beqz AND zf make select for beqz mux
and bnez_and(bnez_s, bnez, b_nezf);
//beqz mux
mux2_1_16b bnez_mux(.A(bnez_tgt), .B(nxtPC_b1), .S(bnez_s), .Out(nxtPC_b2));

//BLTZ
//full adder to calculate target addr
fulladder16 add_bltz(.A(incPC), .B(displacement_8), .S(bltz_tgt), .Cout());

//beqz AND zf make select for beqz mux
and bltz_and(bltz_s, bltz, b_lzf);
//bltz mux
mux2_1_16b bltz_mux(.A(bltz_tgt), .B(nxtPC_b2), .S(bltz_s), .Out(nxtPC_b3));

//BGEZ
//full adder to calculate target addr
fulladder16 add_bgez(.A(incPC), .B(displacement_8), .S(bgez_tgt), .Cout());

//OR because greater than OR equal to zero
or bgez_or(orOut, b_zf, b_gzf);
//beqz AND zf make select for beqz mux
and bgez_and(bgez_s, orOut, bgez);
//beqz mux
mux2_1_16b bgez_mux(.A(bltz_tgt), .B(nxtPC_b3), .S(bgez_s), .Out(nxtPC));


endmodule
 
