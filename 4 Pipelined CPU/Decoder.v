//Subject:     CO project 4 - Decoder
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
	SignExtend_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output 			RegDst_o;
output [2-1:0]	Branch_o;
output			SignExtend_o;
output			MemRead_o;
output			MemWrite_o;
output      	MemtoReg_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    			RegDst_o;
reg    [2-1:0] Branch_o;
reg				SignExtend_o;
reg				MemRead_o;
reg				MemWrite_o;
reg	 			MemtoReg_o;

//Parameter
parameter      R_FORMATE = 6'd0;
parameter		BEQ		 = 6'd4;
parameter		BNE		 = 6'd5;
parameter		ADDI		 = 6'd8;
parameter		ORI		 = 6'd13;
parameter		LUI		 = 6'd15;
parameter		LW 	    = 6'd35;
parameter		SW  	    = 6'd43;

parameter	R_FORMATE_op	= 3'b100;
parameter	ADDI_op			= 3'b000;
parameter	ORI_op			= 3'b101;
parameter	LUI_op			= 3'b111;
parameter	BRANCH_op		= 3'b010;
//Main function
always@(*)begin
	case(instr_op_i)
		R_FORMATE: 	begin ALU_op_o <= R_FORMATE_op; RegDst_o <= 1'd1; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b0; SignExtend_o <= 1'b0; MemRead_o <= 1'b0; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd0; Branch_o <= 2'd0;end
			  ADDI:	begin ALU_op_o <= ADDI_op; 	  RegDst_o <= 1'd0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; SignExtend_o <= 1'b0; MemRead_o <= 1'b0; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd0; Branch_o <= 2'd0;end
			  ORI:	begin ALU_op_o <= ORI_op; 		  RegDst_o <= 1'd0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; SignExtend_o <= 1'b1; MemRead_o <= 1'b0; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd0; Branch_o <= 2'd0;end
			  
			  LUI:	begin ALU_op_o <= LUI_op; 		  RegDst_o <= 1'd0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; SignExtend_o <= 1'b0; MemRead_o <= 1'b0; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd0; Branch_o <= 2'd0;end
			  
			  BEQ:	begin ALU_op_o <= BRANCH_op;	  RegDst_o <= 1'd0; RegWrite_o <= 1'b0; ALUSrc_o <= 1'b0; SignExtend_o <= 1'b0; MemRead_o <= 1'b0; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd0; Branch_o <= 2'd1;end
			  BNE:	begin ALU_op_o <= BRANCH_op;	  RegDst_o <= 1'd0; RegWrite_o <= 1'b0; ALUSrc_o <= 1'b0; SignExtend_o <= 1'b0; MemRead_o <= 1'b0; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd0; Branch_o <= 2'd2;end
			  
			  LW:	   begin ALU_op_o <= ADDI_op;  	  RegDst_o <= 1'd0; RegWrite_o <= 1'b1; ALUSrc_o <= 1'b1; SignExtend_o <= 1'b0; MemRead_o <= 1'b1; MemWrite_o <= 1'b0; MemtoReg_o <= 1'd1; Branch_o <= 2'd0;end
			  SW:		begin ALU_op_o <= ADDI_op; 	  RegDst_o <= 1'd0; RegWrite_o <= 1'b0; ALUSrc_o <= 1'b1; SignExtend_o <= 1'b0; MemRead_o <= 1'b0; MemWrite_o <= 1'b1; MemtoReg_o <= 1'd0; Branch_o <= 2'd0;end
	endcase
end
endmodule





                    
                    