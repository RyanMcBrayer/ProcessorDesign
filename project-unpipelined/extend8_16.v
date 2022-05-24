module extend8_16(In, Out, sign);

//This unit takes a 8 bit input and either sign extends or
//zero extends the input to 16bits (sign = 1 = sign extension)
input sign;
input [7:0] In;
output [15:0] Out;

assign Out = (sign == 1) ? ((In[7] == 1'b1) ? {8'hFF,In} : {8'h00,In}) : {8'h00,In};
			                
						 							   
endmodule