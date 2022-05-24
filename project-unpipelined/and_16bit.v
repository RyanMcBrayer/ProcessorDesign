module and_16bit(A, B, Out);
input [15:0] A;
input [15:0] B;
output [15:0] Out;

//instantiates 16, 2-1 and gates to produce Out
and2 and_1(.A(A[0]), .B(B[0]), .Out(Out[0]));
and2 and_2(.A(A[1]), .B(B[1]), .Out(Out[1]));
and2 and_3(.A(A[2]), .B(B[2]), .Out(Out[2]));
and2 and_4(.A(A[3]), .B(B[3]), .Out(Out[3]));
and2 and_5(.A(A[4]), .B(B[4]), .Out(Out[4]));
and2 and_6(.A(A[5]), .B(B[5]), .Out(Out[5]));
and2 and_7(.A(A[6]), .B(B[6]), .Out(Out[6]));
and2 and_8(.A(A[7]), .B(B[7]), .Out(Out[7]));
and2 and_9(.A(A[8]), .B(B[8]), .Out(Out[8]));
and2 and_10(.A(A[9]), .B(B[9]), .Out(Out[9]));
and2 and_11(.A(A[10]), .B(B[10]), .Out(Out[10]));
and2 and_12(.A(A[11]), .B(B[11]), .Out(Out[11]));
and2 and_13(.A(A[12]), .B(B[12]), .Out(Out[12]));
and2 and_14(.A(A[13]), .B(B[13]), .Out(Out[13]));
and2 and_15(.A(A[14]), .B(B[14]), .Out(Out[14]));
and2 and_16(.A(A[15]), .B(B[15]), .Out(Out[15]));

endmodule