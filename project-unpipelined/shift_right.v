module shift_right(in, amt, out);

input [15:0] in;
input [3:0] amt;
output [15:0] out;

wire [15:0] rotate1;
wire [15:0] rotate2;
wire [15:0] rotate3;

assign rotate1 = (amt[0]) ? {in[0],in[15:1]} : in;
assign rotate2 = (amt[1]) ? {rotate1[1:0],rotate1[15:2]} : rotate1;
assign rotate3 = (amt[2]) ? {rotate2[3:0],rotate2[15:4]} : rotate2;
assign out = (amt[3]) ? {rotate3[7:0],rotate3[15:8]} : rotate3;



endmodule