/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   wire err_fetch, err_decode, err_mem, err_wb, err_control;
   assign err = (err_fetch|err_decode|err_mem|err_wb|err_control) ? 1'b1 : 1'b0;
   
   //Control Signals
   wire regWrite, regDst, signExtend, aluSrc, memRead, memWrite, memtoReg, upperDest, byteImmediate;
   wire lbi, slbi, btr, jmp, jr_jalr, pc_r7, seq, slt, sle, sco;
   wire [2:0] aluOP;
   
   wire [15:0] instruction;
   wire [15:0] read_data1;
   wire [15:0] read_data2;
   wire [15:0] extendOut;

   
   wire [15:0] nxtPC;
   wire [15:0] incPC;
   
   wire [15:0] alu_result;
   wire zf, nezf, gzf, lzf;
   wire beqz, bnez, bltz, bgez;
   
   wire [15:0] memoryData;
   
   wire [15:0] writeData;
   
   wire halt;
   wire cout;
   
    
	//FETCH
	proc_fetch fetch(.nxtPC(nxtPC), .instr(instruction), .incPC(incPC), .clk(clk), .rst(rst), .err(err_fetch));
   
	//DECODE
	proc_decode decode(.instr(instruction), .regWrite(regWrite), .regDst(regDst), .signExtend(signExtend), .writeDataIn(writeData), .read_data1(read_data1), .upperDest(upperDest),
					  .read_data2(read_data2), .extendOut(extendOut), .lbi(lbi), .slbi(slbi), .btr(btr), .incPC(incPC), .pc_r7(pc_r7), .clk(clk), .rst(rst), .err(err_decode));
	
	//EXECUTE				 
	proc_execute execute(.read_data1(read_data1), .read_data2(read_data2), .extendOut(extendOut), .aluSrc(aluSrc), .slbi(slbi), .aluOP(aluOP), .op(instruction[15:11]), .two_lsbs(instruction[1:0]),
				 .seq(seq), .slt(slt), .sle(sle), .sco(sco), .jr_jalr(jr_jalr), .jmp(jmp), .beqz(beqz), .bnez(bnez), .bltz(bltz), .bgez(bgez), .displacement(instruction[10:0]), .incPC(incPC),
				 .nxtPC(nxtPC), .alu_result(alu_result), .clk(clk), .rst(rst), .err(err));
						
	//MEMORY ACCESS
	proc_memory memory(.alu_result(alu_result), .read_data2(read_data2), .memRead(memRead), .memWrite(memWrite), .memoryData(memoryData), .clk(clk), .rst(rst), .err(err));
	
	//WRITE BACK				 
	proc_writeback writeback(.memoryData(memoryData), .alu_result(alu_result), .memtoReg(memtoReg), .writeData(writeData));
	
	//CONTROL
	proc_control_unpipelined control_unpipelined(.op(instruction[15:11]), .regDst(regDst), .memRead(memRead), .memWrite(memWrite), .memtoReg(memtoReg), .aluOP(aluOP), .aluSrc(aluSrc), 
						  .signExtend(signExtend), .regWrite(regWrite), .upperDest(upperDest), .lbi(lbi), .slbi(slbi), .btr(btr), .jmp(jmp), .jr_jalr(jr_jalr), .pc_r7(pc_r7),
						  .beqz(beqz), .bnez(bnez), .bltz(bltz), .bgez(bgez), .halt(halt),  .clk(clk), .rst(rst), .err(err_control), .seq(seq), .slt(slt), .sle(sle), .sco(sco));
						  
						 
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
