module reg_16bit(writedata, clk, rst, WE, readdata);

input [15:0] writedata;
input clk, rst, WE;
output [15:0] readdata;

wire [15:0] mux1_2Out;


mux2_1_16b write_select_mux(.A(writedata), .B(readdata), .S(WE), .Out(mux1_2Out));
dff_16bit dff_16b(.q(readdata), .d(mux1_2Out), .clk(clk), .rst(rst));

endmodule