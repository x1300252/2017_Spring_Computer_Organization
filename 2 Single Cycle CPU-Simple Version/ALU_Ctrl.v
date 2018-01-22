//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
parameter	R_FORMATE_op	= 3'b100;
parameter	ADDI_op			= 3'b000;
parameter	ORI_op			= 3'b101;
parameter	LUI_op			= 3'b111;
parameter	BRENCH_op		= 3'b010;

parameter	ADD_func       = 6'd32;
parameter	SUB_func  		= 6'd34;
parameter	AND_func  		= 6'd36;
parameter	OR_func  		= 6'd37;
parameter	SLT_func  		= 6'd42;
parameter	SLTU_func  		= 6'd43;
parameter	SLL_func  		= 6'd0;
parameter	SLLV_func  		= 6'd4;

parameter ADD  = 4'b0000;
parameter SUB  = 4'b0010;
parameter AND  = 4'b0100;
parameter OR   = 4'b0101;
parameter SLT  = 4'b1010;
parameter SLTU = 4'b1011;
parameter SLL  = 4'b1101;
parameter SLLV = 4'b1100;
parameter LUI  = 4'b1111;

//Select exact operation
always@(*) begin
		case(ALUOp_i)
			R_FORMATE_op:
				case(funct_i)
					ADD_func : ALUCtrl_o <= ADD;
					SUB_func : ALUCtrl_o <= SUB;
					AND_func : ALUCtrl_o <= AND;
					OR_func  : ALUCtrl_o <= OR;
					SLT_func : ALUCtrl_o <= SLT;
					SLTU_func: ALUCtrl_o <= SLTU;
					SLL_func : ALUCtrl_o <= SLL;
					SLLV_func: ALUCtrl_o <= SLLV;
				endcase
			ADDI_op		: ALUCtrl_o <= ADD;
			ORI_op		: ALUCtrl_o <= OR;
			LUI_op		: ALUCtrl_o <= LUI;
			BRENCH_op	: ALUCtrl_o <= SUB;
		endcase
end

endmodule     





                    
                    