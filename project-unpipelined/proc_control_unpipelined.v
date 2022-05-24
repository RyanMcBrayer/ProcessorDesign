module proc_control_unpipelined(op, regDst, memRead, memWrite, memtoReg, aluOP, aluSrc, signExtend, regWrite, upperDest, lbi, slbi, btr, jmp, jr_jalr, pc_r7, beqz, bnez, bltz, bgez, halt, clk, rst, err, seq, slt, sle, sco);

input clk, rst;
input [4:0] op;

output reg regDst, memRead, memWrite, memtoReg, aluSrc, signExtend, regWrite, upperDest, err, halt;
output reg lbi, slbi, btr, jmp, jr_jalr, pc_r7, beqz, bnez, bltz, bgez, seq, slt, sle, sco;
output reg [2:0] aluOP;

parameter HALT = 5'b00000;
parameter NOP = 5'b00001;
parameter ADDI = 5'b01000;
parameter SUBI = 5'b01001;
parameter XORI = 5'b01010;
parameter ANDNI = 5'b01011;
parameter ROLI = 5'b10100;
parameter SLLI = 5'b10101;
parameter RORI = 5'b10110;
parameter SRLI = 5'b10111;
parameter ST = 5'b10000;
parameter LD = 5'b10001;
parameter STU = 5'b10011;
parameter BTR = 5'b11001;
parameter ARITH = 5'b11011;
parameter SHFT = 5'b11010;
parameter SEQ = 5'b11100;
parameter SLT = 5'b11101;
parameter SLE = 5'b11110;
parameter SCO = 5'b11111;
parameter BEQZ = 5'b01100;
parameter BNEZ = 5'b01101;
parameter BLTZ = 5'b01110;
parameter BGEZ = 5'b01111;
parameter LBI = 5'b11000;
parameter SLBI = 5'b10010;
parameter JMP = 5'b00100;
parameter JR = 5'b00101;
parameter JAL = 5'b00110;
parameter JALR = 5'b00111;
parameter ILLEGAL = 5'b00010;
parameter RTI = 5'b00011;


//FOR DEFBUGGING USE ONLY 
reg default_reached;



always @ (op) begin

	case(op)
	
	HALT : begin
		//make sure no write, assert halt, unless in reset
		memWrite = 0;
		regWrite = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
		case(rst)
		1'b1: halt = 0;
		1'b0: halt = 1;
		default: halt = 1;
		endcase
	end
	
	NOP : begin
	//prevent a write, stall
	memWrite = 0;
	regWrite = 0;
	lbi = 0;
	slbi = 0;
	btr = 0;
	jmp = 0;
	jr_jalr = 0;
	pc_r7 = 0;
	beqz = 0;
	bnez = 0;
	bltz = 0;
	bgez = 0;
	seq = 0;
	slt = 0;
	sle = 0;
	sco = 0;
	end
	
	ADDI : begin
		aluOP = 3'b000; //ADD
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 1;//sign extended immediate
		regWrite = 1;//write result back
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
	    halt = 0; 
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	SUBI : begin
		aluOP = 3'b000; //ADD
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 1;//sign extended immediate
		regWrite = 1;//write result back
	    halt = 0; 
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	XORI : begin
		aluOP = 3'b010; //XOR
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//write result back
	    halt = 0; 
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	ANDNI : begin
		aluOP = 3'b011; //AND
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//write result back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	ROLI : begin
		aluOP = 3'b110; //ROL
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//write result back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	SLLI : begin
		aluOP = 3'b111; //SLL
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//write result back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	RORI : begin
		aluOP = 3'b001; // ROR
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//write result back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	SRLI : begin
		aluOP = 3'b101; //SRL
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;// no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//write result back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	ST : begin
		aluOP = 3'b000;// ADD to calculate mem addr 
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 1;// mem write
		memtoReg = 0; //take alu_result to write back(WB not needed)
		aluSrc = 1; //take extension into alu
		signExtend = 1;//sign extended immediate
		regWrite = 0;//nothing written back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	LD : begin
		aluOP = 3'b000;// ADD to calculate mem addr 
		regDst = 0; //take bits of 7:5 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 1; // mem read 
		memWrite = 0;//no mem write
		memtoReg = 1; //take memory data to write back
		aluSrc = 1; //take extension into alu
		signExtend = 1;//sign extended immediate
		regWrite = 1;//write memory data back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	STU : begin
		aluOP = 3'b000;// ADD to calculate mem addr 
		regDst = 0; // not used for reg dst
		upperDest = 1;// write to reg from upper bits
		memRead = 0; //no mem read 
		memWrite = 1;// mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 1; //take extension into alu
		signExtend = 1;//sign extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	BTR : begin
		aluOP = 3'b000;// ADD to calculate mem addr 
		regDst = 1; // not used for reg dst
		upperDest = 0;// write to reg from upper bits
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 1;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	ARITH : begin
		aluOP = 3'b000;// ADD
		regDst = 1; //take bits of 4:2 of instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//doesnt matter here
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
		
	end
	
	SHFT : begin
		aluOP = 3'b100;// SRA 
		regDst = 1; //take bits of 4:2 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	SEQ : begin
		aluOP = 3'b000;// ADD  
		regDst = 1; //take bits of 4:2 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 1;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	SLT : begin
		aluOP = 3'b000;// ADD
		regDst = 1; //take bits of 4:2 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 1;
		sle = 0;
		sco = 0;
	end
	
	SLE : begin
		aluOP = 3'b000;// ADDr
		regDst = 1; //take bits of 4:2 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 1;
		sco = 0;
	end
	
	SCO : begin
		aluOP = 3'b000;// ADD
		regDst = 1; //take bits of 4:2 instruction
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take read_data2 into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;// write back alu result
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 1;
	end
	
	BEQZ : begin
		aluOP = 3'b000;// ADD to calculate target addr
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//sign extended immediate
		regWrite = 0;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 1;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	BNEZ : begin
		aluOP = 3'b000;// ADD to calculate target addr
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//sign extended immediate
		regWrite = 0;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 1;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	BLTZ : begin
		aluOP = 3'b000;// ADD to calculate target addr
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//sign extended immediate
		regWrite = 0;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 1;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	BGEZ : begin
		aluOP = 3'b000;// ADD to calculate target addr
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//sign extended immediate
		regWrite = 0;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 1;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	LBI : begin
		regDst = 0; //reg dst not from these bytes
		upperDest = 1;//upper bits not needed for write
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		aluSrc = 1; //take extension into alu
		signExtend = 1;//sign extended immediate
		regWrite = 1;//write back
	    halt = 0;
		lbi = 1;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	SLBI : begin
		aluOP = 3'b111;// SLL
		regDst = 0; //no write register for branch
		upperDest = 1;//upper bits are WRS
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 1;
		btr = 0;
		jmp = 0;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	JMP : begin
		aluOP = 3'b000;// 
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits are WRS
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 0;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 1;
		jr_jalr = 0;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	JR : begin
		aluOP = 3'b000;// 
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits are WRS
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 0;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 1;
		pc_r7 = 0;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	JAL : begin
		aluOP = 3'b000;// 
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits are WRS
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 1;
		jr_jalr = 0;
		pc_r7 = 1;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	JALR : begin
		aluOP = 3'b000;// 
		regDst = 0; //no write register for branch
		upperDest = 0;//upper bits are WRS
		memRead = 0; //no mem read 
		memWrite = 0;//no mem write
		memtoReg = 0; //take alu_result to write back
		aluSrc = 0; //take extension into alu
		signExtend = 0;//zero extended immediate
		regWrite = 1;//no write back
	    halt = 0;
		lbi = 0;
		slbi = 0;
		btr = 0;
		jmp = 0;
		jr_jalr = 1;
		pc_r7 = 1;
		beqz = 0;
		bnez = 0;
		bltz = 0;
		bgez = 0;
		seq = 0;
		slt = 0;
		sle = 0;
		sco = 0;
	end
	
	ILLEGAL : begin
	//Not yet implemented
	end
	
	RTI : begin
	//PC<-EPC
	//For now just prevents a write
	memWrite = 0;
	regWrite = 0;
	end

	default: default_reached = 1;
endcase
end

endmodule
