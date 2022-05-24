module alu_unpipelined_tb();

        reg [15:0] A;
        reg [15:0] B;
        reg Cin;
        reg [2:0] Op;
        reg invA;
        reg invB;
        reg sign;
        wire [15:0] Out;
        wire Ofl;
        wire zf, gzf, lzf, nezf;
		
		
		
		alu_unpipelined DUT(.A(A), .B(B), .Cin(Cin), .Op(Op), .invA(invA), .invB(invB), .sign(sign), .Out(Out), .Ofl(Ofl), .zf(zf), .gzf(gzf), .lzf(lzf), .nezf(nezf));
		
		initial begin
		A = 0;
		B = 0;
		Cin = 0;
		Op = 0;
		invA = 0;
		invB = 0;
		sign = 0;
		
		#5;
		if(Out !== 16'h0000) $error("Out was expected to be 16'h0000 but was: %h", Out);
		if(!zf || gzf || lzf || nezf) $error("flags for Test 1 were wrong they were: zf %b, gzf %b, lzf %b, nezf %b",zf,gzf,lzf,nezf);
		
		A = 0;
		B = 16'h0005;
		Cin = 0;
		Op = 0;
		invA = 0;
		invB = 0;
		sign = 0;
		
		#5;
		if(Out !== 16'h0005) $error("Out was expected to be 16'h0005 but was: %h", Out);
		if(zf || !gzf || lzf || !nezf) $error("flags for Test 1 were wrong they were: zf %b, gzf %b, lzf %b, nezf %b",zf,gzf,lzf,nezf);
		
		A = 5;
		B = 16'h000A;
		Cin = 1;
		Op = 0;
		invA = 0;
		invB = 1;
		sign = 1;
		
		#5;
		if(Out !== 16'hFFFB) $error("Out was expected to be 16'hffb but was: %h", Out);
		if(zf || gzf || !lzf || !nezf) $error("flags for Test 1 were wrong they were: zf %b, gzf %b, lzf %b, nezf %b",zf,gzf,lzf,nezf);
		
		A = 16'h000A;
		B = 16'h0007;
		Cin = 0;
		Op = 3'b001;
		invA = 0;
		invB = 0;
		sign = 0;
		
		#5;
		if(Out !== 16'h1400) $error("Out was expected to be 16'h1400 but was: %h", Out);
		if(zf || !gzf || lzf || !nezf) $error("flags for Test 1 were wrong they were: zf %b, gzf %b, lzf %b, nezf %b",zf,gzf,lzf,nezf);
		
		A = 16'hA00A;
		B = 16'h0004;
		Cin = 0;
		Op = 3'b001;
		invA = 0;
		invB = 0;
		sign = 0;
		
		#5;
		if(Out !== 16'hAA00) $error("Out was expected to be 16'h0a00 but was: %h", Out);
		if(zf || gzf || !lzf || !nezf) $error("flags for Test 1 were wrong they were: zf %b, gzf %b, lzf %b, nezf %b",zf,gzf,lzf,nezf);
		
		A = 16'h8ABD;
		B = 16'h0008;
		Cin = 0;
		Op = 3'b001;
		invA = 0;
		invB = 0;
		sign = 0;
		
		#5;
		if(Out !== 16'hBD8A) $error("Out was expected to be 16'hBD8A but was: %h", Out);
		if(zf || gzf || !lzf || !nezf) $error("flags for Test 1 were wrong they were: zf %b, gzf %b, lzf %b, nezf %b",zf,gzf,lzf,nezf);
		
		
		$stop();
		end
		
endmodule