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
module Hazard_Detection(
	ID_EX_MemRead,
	ID_EX_RegRt,
	IF_ID_RegRs,
	IF_ID_RegRt,
	PCSrc,
	IF_flush,
	ID_flush,
	EX_flush,
	IF_ID_Write,
	PCWrite
    );
	 
//I/O ports
input 			ID_EX_MemRead;
input	[5-1:0]	ID_EX_RegRt;
input [5-1:0]	IF_ID_RegRs;
input [5-1:0]	IF_ID_RegRt;
input 			PCSrc;
output 			IF_flush;
output 			ID_flush;
output 			EX_flush;
output			IF_ID_Write;
output 			PCWrite;

//Internal Signals
reg 			IF_flush;
reg 			ID_flush;
reg 			EX_flush;
reg			IF_ID_Write;
reg 			PCWrite;

//Main function
always@(*) begin
	IF_flush 	<= 1'd0; 
	ID_flush 	<= 1'd0;
	EX_flush 	<= 1'd0;
	IF_ID_Write <= 1'd1;
	PCWrite  	<= 1'd1;
	
	// Load-use hazard detection
	if (ID_EX_MemRead && ((ID_EX_RegRt == IF_ID_RegRs) || (ID_EX_RegRt == IF_ID_RegRt))) begin
		ID_flush		<= 1'd1;
		IF_ID_Write <= 1'd0;
		PCWrite  	<= 1'd0;
	end
	
	// Branch hazard detection
	if (PCSrc) begin
		IF_flush 	<= 1'd1; 
		ID_flush 	<= 1'd1;
		EX_flush 	<= 1'd1;
	end
end

endmodule
