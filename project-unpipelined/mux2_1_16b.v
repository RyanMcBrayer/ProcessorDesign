module mux2_1_16b(A, B, S, Out);

//Mux selects from two 16b inputs, high selects input A
input [15:0] A;
input [15:0] B;
input S;
output [15:0] Out;

assign Out = S ? A : B;

endmodule