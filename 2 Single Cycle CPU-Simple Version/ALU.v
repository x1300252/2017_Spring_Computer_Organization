//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
   src1_i,
	src2_i,
	shamt_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [5-1:0]   shamt_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]  result_o;
output           zero_o;

//Internal signals
reg       [32-1:0] result_o;
wire               zero_o;

reg  signed [31:0] result;
wire signed [31:0] signed1;
wire signed [31:0] signed2;

//Parameter
parameter ADD  = 4'b0000;
parameter SUB  = 4'b0010;
parameter AND  = 4'b0100;
parameter OR   = 4'b0101;
parameter SLT  = 4'b1010;
parameter SLTU = 4'b1011;
parameter SLL  = 4'b1101;
parameter SLLV = 4'b1100;
parameter LUI  = 4'b1111;

//Main function
assign signed1 = src1_i;
assign signed2 = src2_i;

assign zero_o = (result_o == 0) ? 1 : 0;
always@(*) begin
	result_o <= result[31:0];
	case(ctrl_i)
		ADD:  result <= signed1 +  signed2;
		SUB:  result <= signed1 -  signed2;
		AND:  result <= src1_i &  src2_i;
		OR :  result <= src1_i |  src2_i;
		SLT:  result <= (signed1 < signed2) ? 32'd1 : 32'd0;
		SLTU: result <= (src1_i < src2_i) ? 32'd1 : 32'd0;
		SLL:  result <= src2_i << shamt_i;
		SLLV: result <= src2_i << src1_i;
		LUI:  result <= src2_i << 16;
	endcase
end

endmodule





                    
                    