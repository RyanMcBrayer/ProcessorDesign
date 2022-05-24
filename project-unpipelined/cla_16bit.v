module cla_16bit(a, b, cin, cout, sum);
input [15:0] a;
input [15:0] b;
input cin;
output [15:0] sum;
output cout;

wire [2:0] c; //holds cout from each 4bit block

//instantiate 4insances of 4bit cla
cla_4bit cla_block1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c[0]));
cla_4bit cla_block2(.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .sum(sum[7:4]), .cout(c[1]));
cla_4bit cla_block3(.a(a[11:8]), .b(b[11:8]), .cin(c[1]), .sum(sum[11:8]), .cout(c[2]));
cla_4bit cla_block4(.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .sum(sum[15:12]), .cout(cout));

endmodule