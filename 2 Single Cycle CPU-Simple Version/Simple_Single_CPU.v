//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
      clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire	[32-1:0] 	pc_i;
wire	[32-1:0]		pc_o;
wire	[32-1:0]		next_addr;

wire	[32-1:0]		shift_addr;
wire	[32-1:0]		go_addr;
wire					branch_ctrl;

wire	[32-1:0]		instruction;

wire	[6-1:0]		op;
wire					RegDst;
wire					RegWrite;
wire					branch;
wire					ALUSrc;
wire	[3-1:0]		ALUOp;
wire					bne;
wire					SE_ctrl;

wire	[5-1:0]		rs;
wire	[5-1:0]		rt;
wire	[5-1:0]		rd;
wire	[5-1:0]		WReg;

wire	[32-1:0]		src1;
wire	[32-1:0]		src2;
wire	[32-1:0]		RegData;
wire	[32-1:0]		result;
wire	[5-1:0]		write_dst;
wire					zero;

wire	[16-1:0]		val_16bit;
wire	[32-1:0]		val_32bit;

wire	[6-1:0]		func;
wire	[4-1:0]		ALUCtrl;

wire	[5-1:0]		shamt;
//Greate componentes
ProgramCounter PC(
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_i) ,   
	    .pc_out_o(pc_o) 
	    );
	
Adder Adder1(
       .src1_i(32'd4),     
	    .src2_i(pc_o),     
	    .sum_o(next_addr)    
	    );
	
Instr_Memory IM(
       .pc_addr_i(pc_o),  
	    .instr_o(instruction)    
	    );

assign op		  = instruction[31:26];
assign rs		  = instruction[25:21];
assign rt 		  = instruction[20:16];
assign rd 		  = instruction[15:11];
assign shamt	  = instruction[10:6];
assign val_16bit = instruction[15:0];
assign func		  = instruction[5:0];

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(rt),
        .data1_i(rd),
        .select_i(RegDst),
        .data_o(WReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(rs) ,  
        .RTaddr_i(rt) ,  
        .RDaddr_i(WReg) ,  
        .RDdata_i(result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(src1) ,  
        .RTdata_o(RegData)   
        );
	
Decoder Decoder(
       .instr_op_i(op), 
	    .RegWrite_o(RegWrite),
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		 .Branch_o(branch),
		 .Bne_o(bne),
		 .SignExtend_o(SE_ctrl)
	    );

ALU_Ctrl AC(
        .funct_i(func),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Sign_Extend SE(
        .data_i(val_16bit),
		  .SECtrl_i(SE_ctrl),
        .data_o(val_32bit)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RegData),
        .data1_i(val_32bit),
        .select_i(ALUSrc),
        .data_o(src2)
        );	
		
ALU ALU(
       .src1_i(src1),
	    .src2_i(src2),
		 .shamt_i(shamt),
	    .ctrl_i(ALUCtrl),
	    .result_o(result),
		 .zero_o(zero)
	    );
		
Adder Adder2(
       .src1_i(next_addr),     
	    .src2_i(shift_addr),     
	    .sum_o(go_addr)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(val_32bit),
        .data_o(shift_addr)
        ); 		

assign branch_ctrl = (branch & zero) | (bne & (!zero));
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(next_addr),
        .data1_i(go_addr),
        .select_i(branch_ctrl),
        .data_o(pc_i)
        );	

endmodule
		  


