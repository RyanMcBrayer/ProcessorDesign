/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel;
   input [2:0] read2regsel;
   input [2:0] writeregsel;
   input [15:0] writedata;
   input        write;

   output [15:0] read1data;
   output [15:0] read2data;
   output        err;
   
   wire [7:0] WE;//1 hot encoded intermediate signal for write enable
   wire [7:0] write_enable;//this signal AND WE form input to registers to enable a write
   wire [15:0] R0_data;
   wire [15:0] R1_data;
   wire [15:0] R2_data;
   wire [15:0] R3_data;
   wire [15:0] R4_data;
   wire [15:0] R5_data;
   wire [15:0] R6_data;
   wire [15:0] R7_data;
   
   
//Feed write select into decoder, outputs WE to AND gate with write
decoder3_8 WriteSelect(.S(writeregsel), .Out(WE), .err(err));

//AND gates control write enable on registers
and and1(write_enable[0], WE[0], write);
and and2(write_enable[1], WE[1], write);
and and3(write_enable[2], WE[2], write);
and and4(write_enable[3], WE[3], write);
and and5(write_enable[4], WE[4], write);
and and6(write_enable[5], WE[5], write);
and and7(write_enable[6], WE[6], write);
and and8(write_enable[7], WE[7], write);

//Registers: Inputs are write_enable and writedata, Outputs to read muxes
reg_16bit R0(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[0]), .readdata(R0_data));
reg_16bit R1(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[1]), .readdata(R1_data));
reg_16bit R2(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[2]), .readdata(R2_data));
reg_16bit R3(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[3]), .readdata(R3_data));
reg_16bit R4(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[4]), .readdata(R4_data));
reg_16bit R5(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[5]), .readdata(R5_data));
reg_16bit R6(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[6]), .readdata(R6_data));
reg_16bit R7(.writedata(writedata), .clk(clk), .rst(rst), .WE(write_enable[7]), .readdata(R7_data));

//Feed register outputs into RD1 and RD2 muxes to produce outputs
mux8_1_16b RD1(.S(read1regsel), .In1(R0_data), .In2(R1_data), .In3(R2_data), .In4(R3_data), .In5(R4_data), .In6(R5_data), .In7(R6_data), .In8(R7_data), .err(err), .Out(read1data));
mux8_1_16b RD2(.S(read2regsel), .In1(R0_data), .In2(R1_data), .In3(R2_data), .In4(R3_data), .In5(R4_data), .In6(R5_data), .In7(R6_data), .In8(R7_data), .err(err), .Out(read2data));

   

endmodule
// DUMMY LINE FOR REV CONTROL :1:
