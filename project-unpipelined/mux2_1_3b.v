module mux2_1_3b(A, B, S, Out);

//Mux selects from two 16b inputs, high selects input A
input [2:0] A;
input [2:0] B;
input S;
output [2:0] Out;

assign Out = S ? A : B;

endmodule