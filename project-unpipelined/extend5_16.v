module extend5_16(In, Out, sign);

//This unit takes a 5 bit input and either sign extends or
//zero extends the input to 16bits (sign = 1 = sign extension)
input sign;
input [4:0] In;
output [15:0] Out;

assign Out = (sign == 1) ? ((In[4] == 1'b1) ? {11'h7FF,In} : {11'h000,In}) : {11'h000,In};
			                
						 							   
endmodule