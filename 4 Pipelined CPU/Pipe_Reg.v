//Subject:     CO project 4 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_Reg(
   clk_i,
	rst_i,
	write_i,
	flush_i,
	data_i,
	data_o
	);

parameter size = 0;

input					clk_i;		  
input					rst_i;
input					write_i;
input					flush_i;
input	[size-1: 0]	data_i;
output reg	[size-1: 0]	data_o;

reg 					flag;
reg [size-1:0]		store;

always @(posedge clk_i) begin
	if(~rst_i || flush_i) begin
		data_o <= 0;
		flag <= 1'd0;
	end
	else if (write_i) begin
		case (flag)
			1'd0:
				data_o <= data_i;	
			1'd1: begin
				flag <= 1'd0;
				data_o <= store;
			end
		endcase
	end
	
	else if (!write_i) begin
		flag	 <= 1'd1;
		store  <= data_i;
		data_o <= data_o;
	end
end

endmodule	