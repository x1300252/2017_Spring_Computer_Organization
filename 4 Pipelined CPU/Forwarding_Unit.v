//Subject:     CO project 4 - Forwarding Unit
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Forwarding_Unit(
	EX_MEM_RegWrite,
	EX_MEM_RegRd,
	MEM_WB_RegWrite,
	MEM_WB_RegRd,
	ID_EX_RegRs,
	ID_EX_RegRt,
	ForwardA,
	ForwardB
    );
	 
//I/O ports               
input 			EX_MEM_RegWrite;
input  [5-1:0]	EX_MEM_RegRd;
input 			MEM_WB_RegWrite;
input  [5-1:0]	MEM_WB_RegRd;
input  [5-1:0]	ID_EX_RegRs;
input  [5-1:0]	ID_EX_RegRt;
output [2-1:0]	ForwardA;
output [2-1:0]	ForwardB;

//Internal Signals
reg [2-1:0]	ForwardA;
reg [2-1:0]	ForwardB;

//Main function
always@(*) begin
	ForwardA <= 2'd0;
	ForwardB <= 2'd0;
	
	// EX hazard
	if (EX_MEM_RegWrite && (EX_MEM_RegRd != 0)) begin
		if (EX_MEM_RegRd == ID_EX_RegRs)
			ForwardA <= 2'd1;
		else if (EX_MEM_RegRd == ID_EX_RegRt)
			ForwardB <= 2'd1;
	end
	
	// MEM hazard
	if (MEM_WB_RegWrite && (MEM_WB_RegRd != 0)) begin
		if (!((EX_MEM_RegWrite && (EX_MEM_RegRd != 0)) && (EX_MEM_RegRd == ID_EX_RegRs)) && (MEM_WB_RegRd == ID_EX_RegRs))
				ForwardA <= 2'd2;
		else if (!((EX_MEM_RegWrite && (EX_MEM_RegRd != 0)) && (EX_MEM_RegRd == ID_EX_RegRt)) && (MEM_WB_RegRd == ID_EX_RegRt))
				ForwardB <= 2'd2;
	end
end

endmodule
