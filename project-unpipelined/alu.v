module alu (A, B, Cin, Op, invA, invB, sign, Out, Ofl, Z);
   
        input [15:0] A;
        input [15:0] B;
        input Cin;
        input [2:0] Op;
        input invA;
        input invB;
        input sign;
        output [15:0] Out;
        output Ofl;
        output Z;
		
		wire [15:0] Ain;//Holds A after inversion
		wire [15:0] Bin;//Holds B afrer inversion
		wire [15:0] shifterOut;//Holds output of shifter
		wire [15:0] addOut;//Holds output of cla adder
		wire [15:0] logicOut;//holds output of logic unit
		wire cout, xnorOut, xorOut, signedOvf;//intermediate signals for Ofl logic
		
		//inverter functionality
		assign Ain = invA ? ~A : A;
		assign Bin = invB ? ~B : B;
		
		//Shifter Unit: needs Ain , Bin[3:0] and Op[1:0], then outputs to intermediate signal 
		shifter shifterUnit(.In(Ain), .Cnt(Bin[3:0]), .Op(Op[1:0]), .Out(shifterOut));
		
		//Arithmetic unit: needs Ain, Bin, cin, and outputs sum to intermedite signal and cout to cout
		cla_16bit arithmeticUnit(.a(Ain), .b(Bin), .cin(Cin), .cout(cout), .sum(addOut));
		
		//Logic Unit: needs Ain, Bin, 2LSBs of Op, then outputs to intermediate signal
		logicUnit logicUnit(.A(Ain), .B(Bin), .Op(Op[1:0]), .Out(logicOut));
		
		//Output Mux: selects output from three units based on opcode
		alu_output outputMux(.shifterIn(shifterOut), .addIn(addOut), .logicIn(logicOut), .Op(Op), .out(Out));
		
		//zero flag
		assign Z = (Out == 16'h0000) ? 1'b1 : 1'b0;

		
		//Overflow logic
		xnor2 xnorOfl(.A(Ain[15]), .B(Bin[15]), .Out(xnorOut));//checks to see if MSB's of input after inversion are the same
		xor2 xorOfl(.in1(Ain[15]), .in2(addOut[15]), .out(xorOut));//checks if MSB of input is different from MSB of output
		and2 andOfl(.A(xnorOut), .B(xorOut), .Out(signedOvf));//if two above conditions are met, then signed ofl occurred
		
		//if signed used signedOvf logic, else Ofl is just cout. if op != 0 hold Ofl low
		assign Ofl = (Op == 3'b000) ? (sign ? signedOvf : cout) : 1'b0;
	
endmodule
