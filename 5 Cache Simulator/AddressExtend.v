`timescale 1ns / 1ps
//Subject:     CO project 3 - AddressExtend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module AddressExtend(
    InstrAddr_i,
    PC_i,
    JumpAddr_o
    );
	 
//I/O ports
input  [26-1:0] InstrAddr_i;
input  [32-1:0] PC_i;

output [32-1:0] JumpAddr_o;
 
//Internal Signals
reg    [32-1:0] JumpAddr_o;
 
//Parameter

    
//Main function
always@(*) begin
	JumpAddr_o <= {PC_i[31:28], InstrAddr_i, 2'b00};
end

endmodule
