//Subject:     CO project 3 - ALU Controller
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
          ALUCtrl_o,
			 JR_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;
output     			 JR_o; 
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg        			 JR_o;

//Parameter
parameter	R_FORMATE_op	= 3'b100;
parameter	ADDI_op			= 3'b000;
parameter	ORI_op			= 3'b101;
parameter	LUI_op			= 3'b111;
parameter	BRENCH_op		= 3'b010;
parameter	JUMP_op			= 3'b110;

parameter	ADD_func       = 6'd32;
parameter	SUB_func  		= 6'd34;
parameter	AND_func  		= 6'd36;
parameter	OR_func  		= 6'd37;
parameter	SLT_func  		= 6'd42;
parameter	SLTU_func  		= 6'd43;
parameter	SLL_func  		= 6'd0;
parameter	SLLV_func  		= 6'd4;
parameter	MUL_func  		= 6'd24;
parameter	JR_func  		= 6'd8;

parameter ADD  = 4'b0000;
parameter SUB  = 4'b0010;
parameter AND  = 4'b0100;
parameter OR   = 4'b0101;
parameter SLT  = 4'b1010;
parameter SLTU = 4'b1011;
parameter SLL  = 4'b1101;
parameter SLLV = 4'b1100;
parameter LUI  = 4'b1111;
parameter MUL  = 4'b1000;

//Select exact operation
always@(*) begin
		case(ALUOp_i)
			R_FORMATE_op:
				case(funct_i)
					ADD_func : begin ALUCtrl_o <= ADD;	JR_o <= 0; end
					SUB_func : begin ALUCtrl_o <= SUB;	JR_o <= 0; end
					AND_func : begin ALUCtrl_o <= AND;	JR_o <= 0; end
					OR_func  : begin ALUCtrl_o <= OR;	JR_o <= 0; end
					SLT_func : begin ALUCtrl_o <= SLT;	JR_o <= 0; end
					SLTU_func: begin ALUCtrl_o <= SLTU;	JR_o <= 0; end
					SLL_func : begin ALUCtrl_o <= SLL;	JR_o <= 0; end
					SLLV_func: begin ALUCtrl_o <= SLLV;	JR_o <= 0; end
					MUL_func : begin ALUCtrl_o <= MUL;	JR_o <= 0; end
					JR_func:   begin ALUCtrl_o <= ADD;	JR_o <= 1; end
				endcase
			ADDI_op		: begin ALUCtrl_o <= ADD;		JR_o <= 0; end
			ORI_op		: begin ALUCtrl_o <= OR;		JR_o <= 0; end
			LUI_op		: begin ALUCtrl_o <= LUI;		JR_o <= 0; end
			BRENCH_op	: begin ALUCtrl_o <= SUB;		JR_o <= 0; end
			JUMP_op	   : begin ALUCtrl_o <= ADD;		JR_o <= 0; end
		endcase
end 

endmodule     





                    
                    