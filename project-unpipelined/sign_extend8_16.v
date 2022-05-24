module sign_extend8_16(in, out);
input [7:0] in;
output [15:0] out;

assign out = in[7] ? {8'hFF,in} : {8'h00,in};

endmodule
