module alu_control_unpipelined(aluOPin, op, two_lsbs, aluOPout, invA, invB, Cin, sign);

input [2:0] aluOPin;
input [4:0] op;
input [1:0] two_lsbs;
output reg [2:0] aluOPout;
output reg invA, invB, Cin, sign;

parameter ADD = 3'b000;
parameter ROR = 3'b001;
parameter XOR = 3'b010;
parameter AND = 3'b011;
parameter SRA = 3'b100;
parameter SRL = 3'b101;
parameter ROL = 3'b110;
parameter SLL = 3'b111;


always @ (aluOPin, op, two_lsbs) begin

	case(aluOPin)
	
		ADD : begin
			case(op)
				//ADDI
				5'b01000 : begin
				aluOPout = ADD;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
				end
				
				//SUBI
				5'b01001 : begin
				aluOPout = ADD;
				invA = 1;
				invB = 0;
				Cin = 1;
				sign = 1;
				end

				//ARITH
				5'b11011 : begin
					case(two_lsbs)
					
					//ADD
					2'b00 : begin
					aluOPout = ADD;
					invA = 0;
					invB = 0;
					Cin = 0;
					sign = 0;
					end
					
					//SUB
					2'b01 : begin
					aluOPout = ADD;
					invA = 1;
					invB = 0;
					Cin = 1;
					sign = 1;
					end
					
					//XOR
					2'b10 : begin
					aluOPout = XOR;
					invA = 0;
					invB = 0;
					Cin = 0;
					sign = 0;
					end
					
					//ANDN
					2'b11 : begin
					aluOPout = AND;
					invA = 0;
					invB = 1;
					Cin = 0;
					sign = 0;
					end
					default : aluOPout = aluOPin;
					endcase

				end
				
				//SEQ
				5'b11100 : begin
				aluOPout = ADD;
				invA = 0;
				invB = 1;
				Cin = 1;
				sign = 1;
				end
				
				//SLT
				5'b11101 : begin
				aluOPout = ADD;
				invA = 0;
				invB = 1;
				Cin = 1;
				sign = 1;
				end
				
				//SLE
				5'b11110 : begin
				aluOPout = ADD;
				invA = 0;
				invB = 1;
				Cin = 1;
				sign = 1;
				end
				
				//SCO
				5'b11111 : begin
				aluOPout = ADD;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
				end
				
				default : begin
					aluOPout = aluOPin;
					invA = 0;
					invB = 0;
					Cin = 0;
					sign = 0;
					end
				endcase		
		end
		
		ROR : begin
			aluOPout = aluOPin;
			invA = 0;
			invB = 0;
			Cin = 0;
			sign = 0;
		end
		
		//XOR shouldnt need any altering
		XOR : begin
			aluOPout = aluOPin;
			invA = 0;
			invB = 0;
			Cin = 0;
			sign = 0;
		end
		
		AND : begin
			aluOPout = AND;
			invA = 0;
			invB = 1;
			Cin = 1;
			sign = 0;
		end
		
		//SHFT
		SRA : begin
			case(two_lsbs)
			
			//ROL
			2'b00 : begin
				aluOPout = ROL;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
			end
			
			//SLL
			2'b01 : begin
				aluOPout = SLL;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
			end
			
			//ROR
			2'b10 : begin
				aluOPout = ROR;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
			end
			
			//SRL
			2'b11 : begin
				aluOPout = SRL;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
			end
			
			
			default : begin
				aluOPout = aluOPin;
				invA = 0;
				invB = 0;
				Cin = 0;
				sign = 0;
			end
			endcase
		end
	
	
	
	
	default : begin
		aluOPout = aluOPin;
		invA = 0;
		invB = 0;
		Cin = 0;
		sign = 0;
		end
	endcase

end



endmodule
