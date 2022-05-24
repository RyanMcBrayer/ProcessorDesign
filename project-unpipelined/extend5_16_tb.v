module extend5_16_tb();

reg sign;
reg [4:0] In;
wire [15:0] Out;

extend5_16 DUT(.In(In), .Out(Out), .sign(sign));

initial begin
sign = 0;
In = 5'h00;
#5;
if(Out !== 16'h0000) $error("Out should have been 16'h0000, but was: %h", Out);

sign = 1;
In = 5'h0F;
#5;
if(Out !== 16'h000F) $error("Out should have been 16'h000F, but was: %h", Out);

In = 5'h10;
#5;
if(Out !== 16'hFFF0) $error("Out should have been 16'hFFF0, but was: %h", Out);

sign = 0;
In = 5'h1F;
#5;
if(Out !== 16'h001F) $error("Out should have been 16'h001F, but was: %h", Out);

sign = 1;
#5;
if(Out !== 16'hFFFF) $error("Out should have been 16'hFFFF, but was: %h", Out);

$stop();
end


endmodule