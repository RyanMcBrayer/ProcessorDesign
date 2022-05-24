module cla_4bit(a, b, cin, sum, cout);
input [3:0] a;
input [3:0] b;
input cin;
output [3:0] sum;
output cout;

wire [3:0] p;//these internal signals track 
wire [3:0] g;
wire [3:0] c;

assign p = a ^ b;//a XOR b is propogate
assign g = a & b;//both bits are 1 generate
assign sum = p ^ c;//sum is a 1 if bit propogates XOR has a cin

/*Carry lookahead logic: first bit of c is cin, then every other bit must look at the
previous bit(s) to see if it either generates, or if there is a propogation chain that leads
to a generate or a cin */

assign c[0] = cin;
assign c[1] = g[0] | (p[0] & cin);
assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

endmodule

