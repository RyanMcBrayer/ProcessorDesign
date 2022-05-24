module fulladder16(A, B, S, Cout);

input [15:0] A;
input [15:0] B;
output [15:0] S;
output Cout;

wire cout1, cout2, cout3; //signals for internal carries

fulladder4 adder1(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .S(S[3:0]), .Cout(cout1));
fulladder4 adder2(.A(A[7:4]), .B(B[7:4]), .Cin(cout1), .S(S[7:4]), .Cout(cout2));
fulladder4 adder3(.A(A[11:8]), .B(B[11:8]), .Cin(cout2), .S(S[11:8]), .Cout(cout3));
fulladder4 adder4(.A(A[15:12]), .B(B[15:12]), .Cin(cout3), .S(S[15:12]), .Cout(Cout));

endmodule