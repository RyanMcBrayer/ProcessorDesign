module proc_fetch(nxtPC, instr, incPC, clk, rst, err);

input clk, rst;
input [15:0] nxtPC;
output [15:0] incPC;
output [15:0] instr;
output err;

wire enable;
wire [15:0] PC;
	
	assign enable = rst ? 1'b0 : 1'b1;
	
	//Instruction Memory to fetch from
	memory2c InstructionMemory(.data_out(instr), .data_in(16'h0000), .addr(PC), .enable(enable), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));
	
	//16bit Full Adder to increment PC
	fulladder16 Inc2(.A(PC), .B(16'h0002), .S(incPC), .Cout());
	
	//FF to feed incremented PC back into PC
	dff_16bit dff_16b(.q(PC), .d(nxtPC), .clk(clk), .rst(rst));
	
endmodule