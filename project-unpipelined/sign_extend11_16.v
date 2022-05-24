module sign_extend11_16(in, out);
input [10:0] in;
output [15:0] out;

assign out = in[10] ? {5'h1F,in} : {5'h00,in};

endmodule
