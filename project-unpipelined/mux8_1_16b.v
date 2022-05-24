module mux8_1_16b(S, In1, In2, In3, In4, In5, In6, In7, In8, Out, err);

input [2:0] S;
input [15:0] In1;
input [15:0] In2;
input [15:0] In3;
input [15:0] In4;
input [15:0] In5;
input [15:0] In6;
input [15:0] In7;
input [15:0] In8;
output [15:0] Out;
output err;

assign Out = (S == 3'b000) ? In1 :
			 (S == 3'b001) ? In2 :
			 (S == 3'b010) ? In3 :
			 (S == 3'b011) ? In4 :
			 (S == 3'b100) ? In5 :
			 (S == 3'b101) ? In6 :
			 (S == 3'b110) ? In7 :
			 (S == 3'b111) ? In8 : 16'hFFFF;
			 
assign err = (Out == 16'hFFFF) ? 1'b1 : 1'b0;
			 
endmodule