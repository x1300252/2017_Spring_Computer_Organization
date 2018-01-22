//Subject:     CO project 3 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó 
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
	 SECtrl_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
input            SECtrl_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always@(*)begin
	if (SECtrl_i)
		data_o <= {16'd0, data_i};
	else
		data_o <= {{16{data_i[15]}}, data_i};
end
endmodule      
     