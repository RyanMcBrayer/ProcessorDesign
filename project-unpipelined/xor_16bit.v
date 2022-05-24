module xor_16bit(A, B, Out);
input [15:0] A;
input [15:0] B;
output [15:0] Out;

//instantiates 16, 2-1 xor gates to produce Out
xor2 xor_1(.in1(A[0]), .in2(B[0]), .out(Out[0]));
xor2 xor_2(.in1(A[1]), .in2(B[1]), .out(Out[1]));
xor2 xor_3(.in1(A[2]), .in2(B[2]), .out(Out[2]));
xor2 xor_4(.in1(A[3]), .in2(B[3]), .out(Out[3]));
xor2 xor_5(.in1(A[4]), .in2(B[4]), .out(Out[4]));
xor2 xor_6(.in1(A[5]), .in2(B[5]), .out(Out[5]));
xor2 xor_7(.in1(A[6]), .in2(B[6]), .out(Out[6]));
xor2 xor_8(.in1(A[7]), .in2(B[7]), .out(Out[7]));
xor2 xor_9(.in1(A[8]), .in2(B[8]), .out(Out[8]));
xor2 xor_10(.in1(A[9]), .in2(B[9]), .out(Out[9]));
xor2 xor_11(.in1(A[10]), .in2(B[10]), .out(Out[10]));
xor2 xor_12(.in1(A[11]), .in2(B[11]), .out(Out[11]));
xor2 xor_13(.in1(A[12]), .in2(B[12]), .out(Out[12]));
xor2 xor_14(.in1(A[13]), .in2(B[13]), .out(Out[13]));
xor2 xor_15(.in1(A[14]), .in2(B[14]), .out(Out[14]));
xor2 xor_16(.in1(A[15]), .in2(B[15]), .out(Out[15]));



endmodule