module shifter_cell(Ileft, Iright, Inp, S, Cnt, Out);
/*each cell of the shifter needs a default input, a lshift input,
and a rshift input. This module sets the behavior for each of the
64 cells in a 16-bit barrel shifter*/
input Ileft, Iright, Inp, Cnt, S;
output Out;

wire shiftIn;//this intermediate signal holds the prospective bit to be shifted in

mux1_2 mux1(.A(Ileft), .B(Iright), .S(S), .Out(shiftIn)); //first mux looks at MSB of op to determine Right/Left
mux1_2 mux2(.A(shiftIn), .B(Inp), .S(Cnt), .Out(Out));//second mux uses appropriate bit of Cnt to determine shift/no shift
													  //If no shift, Out = default(Inp); If shift Out = Shift Input

endmodule