module alu_unpipelined (A, B, Cin, Op, invA, invB, sign, Out, Ofl, zf, gzf, lzf, nezf);
   
        input [15:0] A;
        input [15:0] B;
        input Cin;
        input [2:0] Op;
        input invA;
        input invB;
        input sign;
        output [15:0] Out;
        output Ofl;
        output zf, gzf, lzf, nezf;
		
		wire [15:0] Ain;//Holds A after inversion
		wire [15:0] Bin;//Holds B afrer inversion
		wire [15:0] shifterOut;//Holds output of shifter
		wire [15:0] addOut;//Holds output of cla adder
		wire [15:0] logicOut;//holds output of logic unit
		wire cout, xnorOut, xorOut, signedOvf;//intermediate signals for Ofl logic
		wire [15:0] rightShift;
		
		//inverter functionality
		assign Ain = invA ? ~A : A;
		assign Bin = invB ? ~B : B;
		
		//Shifter Unit: needs Ain , Bin[3:0] and Op[1:0], then outputs to intermediate signal 
		shifter shifterUnit(.In(Ain), .Cnt(Bin[3:0]), .Op(Op[1:0]), .Out(shifterOut));
		
		//Arithmetic unit: needs Ain, Bin, cin, and outputs sum to intermedite signal and cout to cout
		cla_16bit arithmeticUnit(.a(Ain), .b(Bin), .cin(Cin), .cout(cout), .sum(addOut));
		
		//Logic Unit: needs Ain, Bin, 2LSBs of Op, then outputs to intermediate signal
		logicUnit logicUnit(.A(Ain), .B(Bin), .Op(Op[1:0]), .Out(logicOut));
		
		shift_right shift_right(.in(A), .amt(B[3:0]), .out(rightShift));
		//if MSB of Op is 1, pass shifterIn, else look at 2 LSB's and pass andIn if both are zero
		assign Out = (Op == 3'b001) ?  rightShift : Op[2] ? shifterOut : Op[1:0] == 2'b00 ? addOut : logicOut;
		
		
		
		
		//zero flag
		assign zf = (Out == 16'h0000) ? 1'b1 : 1'b0;
		//greater than zero flag
		//If MSB is zero and any other bits set, then out>0
		assign gzf = (!Out[15]) ? (|Out[14:0] ? 1'b1 : 1'b0) : 1'b0;
		//less than zero flag
		//If MSB is set then out<0
		assign lzf = (Out[15]) ? 1'b1 : 1'b0;
		//not equal to zero flag
		assign nezf = (Out !== 16'h0000) ? 1'b1 : 1'b0;

		
		//Overflow logic
		xnor2 xnorOfl(.A(Ain[15]), .B(Bin[15]), .Out(xnorOut));//checks to see if MSB's of input after inversion are the same
		xor2 xorOfl(.in1(Ain[15]), .in2(addOut[15]), .out(xorOut));//checks if MSB of input is different from MSB of output
		and2 andOfl(.A(xnorOut), .B(xorOut), .Out(signedOvf));//if two above conditions are met, then signed ofl occurred
		
		//if signed used signedOvf logic, else Ofl is just cout. if op != 0 hold Ofl low
		assign Ofl = (Op == 3'b000) ? (sign ? signedOvf : cout) : 1'b0;
	
endmodule