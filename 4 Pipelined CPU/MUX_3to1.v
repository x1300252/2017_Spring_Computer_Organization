//Subject:     CO project 4 - MUX 321
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ������_0416326 ��t�� 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
     
module MUX_3to1(
               data0_i,
               data1_i,
					data2_i,
               select_i,
               data_o
               );

parameter size = 0;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input   [size-1:0] data2_i;          
input   [2-1:0]    select_i;

output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function
always@(*) begin
	case (select_i)
		2'd0: data_o <= data0_i;
		2'd1: data_o <= data1_i;
		2'd2: data_o <= data2_i;
	endcase
end
endmodule      
          
          