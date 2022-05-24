module proc_decode(instr, regWrite, regDst, signExtend, writeDataIn, upperDest, read_data1, read_data2, extendOut, lbi, slbi, btr, incPC, pc_r7, clk, rst, err);

input clk, rst, regWrite, regDst, signExtend, upperDest, lbi, slbi, btr, pc_r7;
input [15:0] incPC;
input [15:0] instr;
input [15:0] writeDataIn;
output [15:0] read_data1;
output [15:0] read_data2;
output [15:0] extendOut;
output err;


wire [2:0] WRS1;
wire [2:0] WRS2;
wire [2:0] WRS3;

wire [15:0] imm_byte;
wire [15:0] writeBack1;
wire [15:0] writeData;

wire [15:0] slbi_byte;
wire [15:0] btr_result;


//regDst mux
mux2_1_3b RegDstMux(.A(instr[4:2]), .B(instr[7:5]), .S(regDst), .Out(WRS1));

//mux that selects if upper bits (10:8) are needed to be written to
mux2_1_3b upperSelect(.A(instr[10:8]), .B(WRS1), .S(upperDest), .Out(WRS2));

//mux that sets R7 as WRS if jr_jalr
mux2_1_3b write_to_r7(.A(3'b111), .B(WRS2), .S(pc_r7), .Out(WRS3));

//Register File
rf RegisterFile(.read1data(read_data1), .read2data(read_data2), .err(err), .clk(clk), .rst(rst), .read1regsel(instr[10:8]),
					.read2regsel(instr[7:5]), .writeregsel(WRS3), .writedata(writeData), .write(regWrite));

//Extenstion Unit
extend5_16 extenstionUnit(.In(instr[4:0]), .Out(extendOut), .sign(signExtend)); 


//Immediate byte sign extension unit
extend8_16 byte_immediate(.In(instr[7:0]), .Out(imm_byte), .sign(signExtend));


//16bit or for SLBI
or_16bit or_16bit(.a(writeDataIn), .b(imm_byte), .out(slbi_byte));

//BTR Unit
btr BTR(.in(read_data1), .out(btr_result));

//Write back select mux
write_back_mux write_data_select(.writeDataIn(writeDataIn), .lbiIn(imm_byte), .slbiIn(slbi_byte), .btrIn(btr_result), .lbi(lbi), .slbi(slbi), .btr(btr), .out(writeBack1));

//if jr_jalr then need to write back incPC
mux2_1_16b jump_incPC(.A(incPC), .B(writeBack1), .S(pc_r7), .Out(writeData));


endmodule
