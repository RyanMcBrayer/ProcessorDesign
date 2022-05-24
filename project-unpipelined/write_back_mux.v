module write_back_mux(writeDataIn, lbiIn, slbiIn, btrIn, lbi, slbi, btr, out);

input lbi, slbi, btr;
input [15:0] writeDataIn;
input [15:0] lbiIn;
input [15:0] slbiIn;
input [15:0] btrIn;
output [15:0] out;


assign out = btr ? btrIn : slbi ? slbiIn : lbi ? lbiIn : writeDataIn;

endmodule

