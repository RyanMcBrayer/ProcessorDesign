module proc_memory(alu_result, read_data2, memRead, memWrite, memoryData, clk, rst, err);

input memRead, memWrite, clk, rst;
input [15:0] alu_result;
input [15:0] read_data2;

output [15:0] memoryData;
output err;

wire enable, wr;

assign enable = rst ? 1'b0 : 1'b1;

assign wr = (memWrite == 1) ? 1'b1 : 1'b0;

//instantiate memory to model data memory
memory2c data_memory(.data_out(memoryData), .data_in(read_data2), .addr(alu_result), .enable(enable), .wr(wr), .createdump(1'b0), .clk(clk), .rst(rst));

endmodule
