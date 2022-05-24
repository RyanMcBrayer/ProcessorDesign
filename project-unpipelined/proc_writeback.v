module proc_writeback(memoryData, alu_result, memtoReg, writeData);

input [15:0] memoryData;
input [15:0] alu_result;
input memtoReg;


output [15:0] writeData;

//Memto Reg decides what data is written back
mux2_1_16b memto_Reg(.A(memoryData), .B(alu_result), .S(memtoReg), .Out(writeData));

endmodule
