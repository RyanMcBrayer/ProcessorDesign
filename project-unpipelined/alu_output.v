module alu_output(shifterIn, addIn, logicIn, Op, out);

input [15:0] shifterIn;
input [15:0] addIn;
input [15:0] logicIn;
input [2:0] Op;
output [15:0] out;

//if MSB of Op is 1, pass shifterIn, else look at 2 LSB's and pass andIn if both are zero
assign out = Op[2] ? shifterIn : Op[1:0] == 2'b00 ? addIn : logicIn;
						
endmodule