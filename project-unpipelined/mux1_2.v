module mux1_2(A, B, S, Out);
//a high select input produces output A
input A, B, S;
output Out;



assign Out = S ? A : B;


/* I tried getting this to work using structural (shown below), but
I kept getting errors and I knew a dataflow implementation was
beyond simple. So I used an assign here because it is simple
and I know it works*/

//wire notS, outA, outB;

//not1 inverterS(.in1(S), .out(notS)); //Invert select signal
//nand2 nandB(.in1(B), .in2(S), .out(OutB));//S NOR notB => to produce OutB
//nand2 nandA(.in1(A), .in2(notS), .out(OutA));//notS NOR notA => to produce OutA
//nand2 nandOut(.in1(outA), .in2(outB), .out(Out));//now OR OutB and OutA (I used 2 NOR)


endmodule