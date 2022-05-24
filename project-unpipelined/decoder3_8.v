module decoder3_8(S, Out, err);

input [2:0] S;
output [7:0] Out;
output err;

assign Out = (S == 3'b000) ? 8'h01 :
			 (S == 3'b001) ? 8'h02 :
			 (S == 3'b010) ? 8'h04 :
			 (S == 3'b011) ? 8'h08 :
			 (S == 3'b100) ? 8'h10 :
			 (S == 3'b101) ? 8'h20 :
			 (S == 3'b110) ? 8'h40 :
			 (S == 3'b111) ? 8'h80 : 8'h00;
			 
assign err = (Out == 8'h00) ? 1'b1 : 1'b0;

endmodule


			 