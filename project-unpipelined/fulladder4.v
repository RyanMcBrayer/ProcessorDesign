module fulladder4(A, B, Cin, S, Cout);

input [3:0] A;
input [3:0] B;
input Cin;
output [3:0] S;
output Cout;

wire cout1, cout2, cout3; //internal signals for carries

fulladder1 adder1(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(cout1));
fulladder1 adder2(.A(A[1]), .B(B[1]), .Cin(cout1), .S(S[1]), .Cout(cout2));
fulladder1 adder3(.A(A[2]), .B(B[2]), .Cin(cout2), .S(S[2]), .Cout(cout3));
fulladder1 adder4(.A(A[3]), .B(B[3]), .Cin(cout3), .S(S[3]), .Cout(Cout));

endmodule