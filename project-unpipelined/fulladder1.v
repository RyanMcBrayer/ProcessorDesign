module fulladder1(A, B, Cin, S, Cout);

input A, B, Cin;
output S, Cout;

wire notA, notB, notCin, xor1, nor1, nor2, notXor1, notNor1, notNor2; //internal signals

xor2 xor_1(.in1(A), .in2(B), .out(xor1));
xor2 xor_2(.in1(xor1), .in2(Cin), .out(S));
not1 not_1(.in1(A), .out(notA));
not1 not_2(.in1(B), .out(notB));
not1 not_3(.in1(Cin), .out(notCin));
not1 not_4(.in1(xor1), .out(notXor1));
nor2 nor_1(.in1(notXor1), .in2(notCin), .out(nor1));
nor2 nor_2(.in1(notA), .in2(notB), .out(nor2));
not1 not_5(.in1(nor1), .out(notNor1));
not1 not_6(.in1(nor2), .out(notNor2));
nand2 nand_1(.in1(notNor1), .in2(notNor2), .out(Cout));

endmodule
