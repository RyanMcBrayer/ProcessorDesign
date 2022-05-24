module shifter (In, Cnt, Op, Out);
   
input [15:0] In;
input [3:0]  Cnt;
input [1:0]  Op;
output [15:0] Out;
   
wire [15:0] row1out;//holds value of row1 output of shifter
wire [15:0] row2out;//holds value of row2 output of shifter
wire [15:0] row3out;//holds value of row3 output of shifter
wire [3:0] rshift;//holds values to shift in when right shifting

wire lshift1;//holds values to shift in when left shifting/rotating
wire [1:0] lshift2;
wire [3:0] lshift3;
wire [7:0] lshift4;

//these muxes select which input to take in from MSB/LSB for a right shift
mux1_2 Rshift1(.A(1'b0), .B(In[15]), .S(Op[0]), .Out(rshift[0]));//selects wether to take in 0's or preserve sign for right shift (row 1)
mux1_2 Rshift2(.A(1'b0), .B(In[15]), .S(Op[0]), .Out(rshift[1]));//selects wether to take in 0's or preserve sign for right shift (row 2)
mux1_2 Rshift3(.A(1'b0), .B(In[15]), .S(Op[0]), .Out(rshift[2]));//selects wether to take in 0's or preserve sign for right shift (row 3)
mux1_2 Rshift4(.A(1'b0), .B(In[15]), .S(Op[0]), .Out(rshift[3]));//selects wether to take in 0's or preserve sign for right shift (row 4)

//these muxes select to 0 fill or to wrap bits by each row
mux1_2 Lshift1_1(.A(1'b0), .B(In[15]), .S(Op[0]), .Out(lshift1));
//need 2 for row 2
mux1_2 Lshift2_1(.A(1'b0), .B(row1out[14]), .S(Op[0]), .Out(lshift2[0]));
mux1_2 Lshift2_2(.A(1'b0), .B(row1out[15]), .S(Op[0]), .Out(lshift2[1]));
//need 4 for row 3
mux1_2 Lshift3_1(.A(1'b0), .B(row2out[12]), .S(Op[0]), .Out(lshift3[0]));
mux1_2 Lshift3_2(.A(1'b0), .B(row2out[13]), .S(Op[0]), .Out(lshift3[1]));
mux1_2 Lshift3_3(.A(1'b0), .B(row2out[14]), .S(Op[0]), .Out(lshift3[2]));
mux1_2 Lshift3_4(.A(1'b0), .B(row2out[15]), .S(Op[0]), .Out(lshift3[3]));
//need 8 for row 4
mux1_2 Lshift4_1(.A(1'b0), .B(row3out[8]), .S(Op[0]), .Out(lshift4[0]));
mux1_2 Lshift4_2(.A(1'b0), .B(row3out[9]), .S(Op[0]), .Out(lshift4[1]));
mux1_2 Lshift4_3(.A(1'b0), .B(row3out[10]), .S(Op[0]), .Out(lshift4[2])); 
mux1_2 Lshift4_4(.A(1'b0), .B(row3out[11]), .S(Op[0]), .Out(lshift4[3]));
mux1_2 Lshift4_6(.A(1'b0), .B(row3out[12]), .S(Op[0]), .Out(lshift4[4]));
mux1_2 Lshift4_7(.A(1'b0), .B(row3out[13]), .S(Op[0]), .Out(lshift4[5]));
mux1_2 Lshift4_8(.A(1'b0), .B(row3out[14]), .S(Op[0]), .Out(lshift4[6]));
mux1_2 Lshift4_9(.A(1'b0), .B(row3out[15]), .S(Op[0]), .Out(lshift4[7]));



//Row one of shifter
/*
Iright: MSB needs rshift to fill 0's or preserve sign, other bits take from In 1 bit higher
Ileft: LSB needs 1shift to fill 0's or wrap around, other bits take from In 1 bit lower
Inp: Default Input is just In
S: Need to look at bit 1 of Op to determine L/R shift
Cnt: Look at bit 0 to see if shift needed in row
Out: Feed output of each cell into intermediate*/
shifter_cell row1_1(.Iright(rshift[0]), .Ileft(In[14]), .Inp(In[15]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[15]));
shifter_cell row1_2(.Iright(In[15]), .Ileft(In[13]), .Inp(In[14]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[14])); 
shifter_cell row1_3(.Iright(In[14]), .Ileft(In[12]), .Inp(In[13]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[13])); 
shifter_cell row1_4(.Iright(In[13]), .Ileft(In[11]), .Inp(In[12]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[12])); 
shifter_cell row1_5(.Iright(In[12]), .Ileft(In[10]), .Inp(In[11]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[11])); 
shifter_cell row1_6(.Iright(In[11]), .Ileft(In[9]), .Inp(In[10]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[10])); 
shifter_cell row1_7(.Iright(In[10]), .Ileft(In[8]), .Inp(In[9]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[9])); 
shifter_cell row1_8(.Iright(In[9]), .Ileft(In[7]), .Inp(In[8]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[8])); 
shifter_cell row1_9(.Iright(In[8]), .Ileft(In[6]), .Inp(In[7]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[7])); 
shifter_cell row1_10(.Iright(In[7]), .Ileft(In[5]), .Inp(In[6]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[6])); 
shifter_cell row1_11(.Iright(In[6]), .Ileft(In[4]), .Inp(In[5]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[5])); 
shifter_cell row1_12(.Iright(In[5]), .Ileft(In[3]), .Inp(In[4]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[4])); 
shifter_cell row1_13(.Iright(In[4]), .Ileft(In[2]), .Inp(In[3]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[3])); 
shifter_cell row1_14(.Iright(In[3]), .Ileft(In[1]), .Inp(In[2]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[2])); 
shifter_cell row1_15(.Iright(In[2]), .Ileft(In[0]), .Inp(In[1]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[1])); 
shifter_cell row1_16(.Iright(In[1]), .Ileft(lshift1), .Inp(In[0]), .S(Op[1]), .Cnt(Cnt[0]), .Out(row1out[0])); 

//Row two of shifter
/*
Iright: 2 MSB's needs rshift to fill 0's or preserve sign, other bits take from above row 2 bits higher
Ileft: 2 LSB's needs 1shift to fill 0's or wrap around, other bits take from above row 2 bits lower
Inp: Default Input is just out from higher row
S: Need to look at bit 1 of Op to determine L/R shift
Cnt: Look at bit 1 to see if shift needed in row
Out: Feed output of each cell into intermediate*/
shifter_cell row2_1(.Iright(rshift[1]), .Ileft(row1out[13]), .Inp(row1out[15]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[15]));
shifter_cell row2_2(.Iright(rshift[1]), .Ileft(row1out[12]), .Inp(row1out[14]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[14])); 
shifter_cell row2_3(.Iright(row1out[15]), .Ileft(row1out[11]), .Inp(row1out[13]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[13])); 
shifter_cell row2_4(.Iright(row1out[14]), .Ileft(row1out[10]), .Inp(row1out[12]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[12])); 
shifter_cell row2_5(.Iright(row1out[13]), .Ileft(row1out[9]), .Inp(row1out[11]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[11])); 
shifter_cell row2_6(.Iright(row1out[12]), .Ileft(row1out[8]), .Inp(row1out[10]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[10])); 
shifter_cell row2_7(.Iright(row1out[11]), .Ileft(row1out[7]), .Inp(row1out[9]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[9])); 
shifter_cell row2_8(.Iright(row1out[10]), .Ileft(row1out[6]), .Inp(row1out[8]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[8])); 
shifter_cell row2_9(.Iright(row1out[9]), .Ileft(row1out[5]), .Inp(row1out[7]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[7])); 
shifter_cell row2_10(.Iright(row1out[8]), .Ileft(row1out[4]), .Inp(row1out[6]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[6])); 
shifter_cell row2_11(.Iright(row1out[7]), .Ileft(row1out[3]), .Inp(row1out[5]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[5])); 
shifter_cell row2_12(.Iright(row1out[6]), .Ileft(row1out[2]), .Inp(row1out[4]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[4])); 
shifter_cell row2_13(.Iright(row1out[5]), .Ileft(row1out[1]), .Inp(row1out[3]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[3])); 
shifter_cell row2_14(.Iright(row1out[4]), .Ileft(row1out[0]), .Inp(row1out[2]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[2])); 
shifter_cell row2_15(.Iright(row1out[3]), .Ileft(lshift2[1]), .Inp(row1out[1]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[1])); 
shifter_cell row2_16(.Iright(row1out[2]), .Ileft(lshift2[0]), .Inp(row1out[0]), .S(Op[1]), .Cnt(Cnt[1]), .Out(row2out[0])); 

//Row three of shifter
/*
Iright: 4 MSB's needs rshift to fill 0's or preserve sign, other bits take from above row 4 bits higher
Ileft: 4 LSB's needs 1shift to fill 0's or wrap around, other bits take from above row 4 bits lower
Inp: Default Input is just out from higher row
S: Need to look at bit 1 of Op to determine L/R shift
Cnt: Look at bit 2 to see if shift needed in row
Out: Feed output of each cell into intermediate*/
shifter_cell row3_1(.Iright(rshift[2]), .Ileft(row2out[11]), .Inp(row2out[15]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[15]));
shifter_cell row3_2(.Iright(rshift[2]), .Ileft(row2out[10]), .Inp(row2out[14]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[14])); 
shifter_cell row3_3(.Iright(rshift[2]), .Ileft(row2out[9]), .Inp(row2out[13]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[13])); 
shifter_cell row3_4(.Iright(rshift[2]), .Ileft(row2out[8]), .Inp(row2out[12]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[12])); 
shifter_cell row3_5(.Iright(row2out[15]), .Ileft(row2out[7]), .Inp(row2out[11]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[11])); 
shifter_cell row3_6(.Iright(row2out[14]), .Ileft(row2out[6]), .Inp(row2out[10]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[10])); 
shifter_cell row3_7(.Iright(row2out[13]), .Ileft(row2out[5]), .Inp(row2out[9]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[9])); 
shifter_cell row3_8(.Iright(row2out[12]), .Ileft(row2out[4]), .Inp(row2out[8]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[8])); 
shifter_cell row3_9(.Iright(row2out[11]), .Ileft(row2out[3]), .Inp(row2out[7]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[7])); 
shifter_cell row3_10(.Iright(row2out[10]), .Ileft(row2out[2]), .Inp(row2out[6]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[6])); 
shifter_cell row3_11(.Iright(row2out[9]), .Ileft(row2out[1]), .Inp(row2out[5]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[5])); 
shifter_cell row3_12(.Iright(row2out[8]), .Ileft(row2out[0]), .Inp(row2out[4]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[4])); 
shifter_cell row3_13(.Iright(row2out[7]), .Ileft(lshift3[3]), .Inp(row2out[3]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[3])); 
shifter_cell row3_14(.Iright(row2out[6]), .Ileft(lshift3[2]), .Inp(row2out[2]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[2])); 
shifter_cell row3_15(.Iright(row2out[5]), .Ileft(lshift3[1]), .Inp(row2out[1]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[1])); 
shifter_cell row3_16(.Iright(row2out[4]), .Ileft(lshift3[0]), .Inp(row2out[0]), .S(Op[1]), .Cnt(Cnt[2]), .Out(row3out[0]));

//Row four of shifter
/*
Iright: 8 MSB's needs rshift to fill 0's or preserve sign, other bits take from above row 8 bits higher
Ileft: 8 LSB's needs 1shift to fill 0's or wrap around, other bits take from above row 8 bits lower
Inp: Default Input is just out from higher row
S: Need to look at bit 1 of Op to determine L/R shift
Cnt: Look at bit 3 to see if shift needed in row
Out: Feed output of each cell into Out*/
shifter_cell row4_1(.Iright(rshift[3]), .Ileft(row3out[7]), .Inp(row3out[15]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[15]));
shifter_cell row4_2(.Iright(rshift[3]), .Ileft(row3out[6]), .Inp(row3out[14]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[14])); 
shifter_cell row4_3(.Iright(rshift[3]), .Ileft(row3out[5]), .Inp(row3out[13]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[13])); 
shifter_cell row4_4(.Iright(rshift[3]), .Ileft(row3out[4]), .Inp(row3out[12]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[12])); 
shifter_cell row4_5(.Iright(rshift[3]), .Ileft(row3out[3]), .Inp(row3out[11]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[11])); 
shifter_cell row4_6(.Iright(rshift[3]), .Ileft(row3out[2]), .Inp(row3out[10]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[10])); 
shifter_cell row4_7(.Iright(rshift[3]), .Ileft(row3out[1]), .Inp(row3out[9]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[9])); 
shifter_cell row4_8(.Iright(rshift[3]), .Ileft(row3out[0]), .Inp(row3out[8]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[8])); 
shifter_cell row4_9(.Iright(row3out[15]), .Ileft(lshift4[7]), .Inp(row3out[7]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[7])); 
shifter_cell row4_10(.Iright(row3out[14]), .Ileft(lshift4[6]), .Inp(row3out[6]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[6])); 
shifter_cell row4_11(.Iright(row3out[13]), .Ileft(lshift4[5]), .Inp(row3out[5]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[5])); 
shifter_cell row4_12(.Iright(row3out[12]), .Ileft(lshift4[4]), .Inp(row3out[4]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[4])); 
shifter_cell row4_13(.Iright(row3out[11]), .Ileft(lshift4[3]), .Inp(row3out[3]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[3])); 
shifter_cell row4_14(.Iright(row3out[10]), .Ileft(lshift4[2]), .Inp(row3out[2]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[2])); 
shifter_cell row4_15(.Iright(row3out[9]), .Ileft(lshift4[1]), .Inp(row3out[1]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[1])); 
shifter_cell row4_16(.Iright(row3out[8]), .Ileft(lshift4[0]), .Inp(row3out[0]), .S(Op[1]), .Cnt(Cnt[3]), .Out(Out[0]));  
   
   
endmodule

