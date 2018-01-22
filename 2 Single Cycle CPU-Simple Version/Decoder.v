//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
   instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Bne_o,
	SignExtend_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output			Bne_o;
output			SignExtend_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg				Bne_o;
reg				SignExtend_o;

//Parameter
parameter      R_FORMATE = 6'd0;
parameter		BEQ		 = 6'd4;
parameter		BNE		 = 6'd5;
parameter		ADDI		 = 6'd8;
parameter		ORI		 = 6'd13;
parameter		LUI		 = 6'd15;

//Main function
always@(*)begin
	case(instr_op_i)
		R_FORMATE: 	begin ALU_op_o <= 3'b100; RegDst_o <= 1'b1; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b0; Branch_o <= 1'b0; Bne_o <= 1'b0; SignExtend_o <= 0;end
			  ADDI:	begin ALU_op_o <= 3'b000; RegDst_o <= 1'b0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; Branch_o <= 1'b0; Bne_o <= 1'b0; SignExtend_o <= 0;end
			  ORI:	begin ALU_op_o <= 3'b101; RegDst_o <= 1'b0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; Branch_o <= 1'b0; Bne_o <= 1'b0; SignExtend_o <= 1;end
			  LUI:	begin ALU_op_o <= 3'b111; RegDst_o <= 1'b0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; Branch_o <= 1'b0; Bne_o <= 1'b0; SignExtend_o <= 0;end
			  BEQ:	begin ALU_op_o <= 3'b010; RegDst_o <= 1'b0; RegWrite_o <= 1'b0; ALUSrc_o <= 1'b0; Branch_o <= 1'b1; Bne_o <= 1'b0; SignExtend_o <= 0;end
			  BNE:	begin ALU_op_o <= 3'b010; RegDst_o <= 1'b0; RegWrite_o <= 1'b0; ALUSrc_o <= 1'b0; Branch_o <= 1'b0; Bne_o <= 1'b1; SignExtend_o <= 0;end
	endcase
end
endmodule





                    
                    