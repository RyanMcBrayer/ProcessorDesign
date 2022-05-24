module branch_flags(in, zf, nezf, gzf, lzf);

input [15:0] in;

output zf, nezf, gzf, lzf;

		//zero flag
		assign zf = (in == 16'h0000) ? 1'b1 : 1'b0;
		//greater than zero flag
		//If MSB is zero and any other bits set, then out>0
		assign gzf = (!in[15]) ? (|in[14:0] ? 1'b1 : 1'b0) : 1'b0;
		//less than zero flag
		//If MSB is set then out<0
		assign lzf = (in[15]) ? 1'b1 : 1'b0;
		//not equal to zero flag
		assign nezf = (in !== 16'h0000) ? 1'b1 : 1'b0;

endmodule