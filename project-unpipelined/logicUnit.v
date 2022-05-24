module logicUnit(A, B, Op, Out);
input [15:0] A;
input [15:0] B;
input [1:0] Op;
output [15:0] Out;

wire [15:0] orOut;
wire [15:0] xorOut;
wire [15:0] andOut;

//OR logic
or_16bit orLogic(.a(A), .b(B), .out(orOut));

//XOR logic
xor_16bit xorLogic(.A(A), .B(B), .Out(xorOut));

//AND logic
and_16bit andLogic(.A(A), .B(B), .Out(andOut));

//selects which funtion to use based on Op, if Op = 2'b00 then set out to zero
assign Out = (Op == 2'b01) ? orOut :
			 (Op == 2'b10) ? xorOut :
			 (Op == 2'b11) ? andOut : 
			  16'h0000;
			  
endmodule