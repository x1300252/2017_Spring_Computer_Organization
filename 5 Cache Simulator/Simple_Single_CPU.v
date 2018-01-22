//Subject:     CO project 3 - Simple Single CPU
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
wire	[32-1:0]		jump_to;
wire	[32-1:0]		jump_result;
wire	[32-1:0]		branch_to;
wire	[32-1:0]		branch_result;

wire	[32-1:0]		shift_addr;
wire					branch_ctrl;
wire					branch_o;

wire	[32-1:0]		instruction;
wire	[26-1:0]		instr_addr;

wire	[6-1:0]		op;
wire	[2-1:0]		RegDst;
wire					RegWrite;
wire	[3-1:0]  	Branch;
wire	[2-1:0]		Branch_type;
wire					ALUSrc;
wire	[3-1:0]		ALUOp;
wire					SE_ctrl;
wire	[2-1:0]		MemtoReg;
wire					Jump;

wire	[5-1:0]		rs;
wire	[5-1:0]		rt;
wire	[5-1:0]		rd;
wire	[5-1:0]		ra;
wire	[5-1:0]		WReg;
wire	[32-1:0]		WriteData;

wire	[32-1:0]		src1;
wire	[32-1:0]		src2;
wire	[32-1:0]		RegData;
wire	[32-1:0]		ALU_result;
wire	[5-1:0]		write_dst;
wire					zero;

wire	[16-1:0]		val_16bit;
wire	[32-1:0]		val_32bit;

wire	[6-1:0]		func;
wire	[4-1:0]		ALUCtrl;
wire					JR;

wire	[5-1:0]		shamt;

wire	[32-1:0]		MemData;
wire					MemWrite;
wire					MemRead;

wire					BEQ;
wire					BLE;
wire					BLT;
wire					BNE;
//Greate componentes
ProgramCounter PC(
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_i) ,   
	    .pc_out_o(pc_o) 
	    );

// generate PC+4		 
Adder Adder1(
       .src1_i(32'd4),     
	    .src2_i(pc_o),     
	    .sum_o(next_addr)    
	    );

// calculate addr in jump	 	 
AddressExtend AE (
    .InstrAddr_i(instr_addr),
    .PC_i(pc_o),
    .JumpAddr_o(jump_to)
    );

// calculate addr in branch		
Shift_Left_Two_32 Shifter(
        .data_i(val_32bit),
        .data_o(shift_addr)
        );

Adder Adder2(
       .src1_i(next_addr),     
	    .src2_i(shift_addr),     
	    .sum_o(branch_to)      
	    );

// check branch type		 
assign BEQ = zero;
assign BLT = ALU_result[31] | zero;
assign BLE = ALU_result[31];
assign BNE = !zero;		  
MUX_4to1 #(.size(1)) Mux_Branch_Type(
        .data0_i(BEQ),
        .data1_i(BLT),
		  .data2_i(BLE),
        .data3_i(BNE),
        .select_i(Branch_type),
        .data_o(branch_o)
        );	
assign branch_ctrl = Branch & branch_o;

// addr after branch		
MUX_2to1 #(.size(32)) Mux_Branch(
        .data0_i(next_addr),
        .data1_i(branch_to),
        .select_i(branch_ctrl),
        .data_o(branch_result)
        );	

// addr after jump		
MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(branch_result),
        .data1_i(jump_to),
        .select_i(Jump),
        .data_o(jump_result)
        );

// addr after jr	
MUX_2to1 #(.size(32)) Mux_JR(
        .data0_i(jump_result),
        .data1_i(src1),
        .select_i(JR),
        .data_o(pc_i)
        );
		  
Instruction_Memory IM(
       .addr_i(pc_o),  
	    .instr_o(instruction)    
	    );

assign op		  = instruction[31:26];
assign rs		  = instruction[25:21];
assign rt 		  = instruction[20:16];
assign rd 		  = instruction[15:11];
assign shamt	  = instruction[10:6];
assign val_16bit = instruction[15:0];
assign func		  = instruction[5:0];
assign instr_addr= instruction[25:0];
assign ra		  = 5'd31;

// select reg distance
MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(rt),
        .data1_i(rd),
		  .data2_i(ra),
        .select_i(RegDst),
        .data_o(WReg)
        );			  

// read data from reg and store data into reg		
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(rs) ,  
        .RTaddr_i(rt) ,  
        .RDaddr_i(WReg) ,  
        .RDdata_i(WriteData)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(src1) ,  
        .RTdata_o(RegData)   
        );

// decode op field	
Decoder Decoder(
       .instr_op_i(op), 
	    .RegWrite_o(RegWrite),
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		 .Branch_o(Branch),
		 .BranchType_o(Branch_type),
		 .SignExtend_o(SE_ctrl),
		 .MemRead_o(MemRead),
		 .MemWrite_o(MemWrite),
		 .MemtoReg_o(MemtoReg),
		 .Jump_o(Jump)
	    );
		 
// decode funct field
ALU_Ctrl AC(
        .funct_i(func),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl),
		  .JR_o(JR)
        );

// extend immediate value	
Sign_Extend SE(
        .data_i(val_16bit),
		  .SECtrl_i(SE_ctrl),
        .data_o(val_32bit)
        );

// select src2 to ALU
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
	    .result_o(ALU_result),
		 .zero_o(zero)
	    );

Data_Memory DM(
		  .clk_i(clk_i),
		  .addr_i(ALU_result),
		  .data_i(RegData),
		  .MemRead_i(MemRead),
		  .MemWrite_i(MemWrite),
		  .data_o(MemData)
);

// select data to write to the reg
MUX_4to1 #(.size(32)) Mux_Data(
        .data0_i(ALU_result),
        .data1_i(MemData),
		  .data2_i(val_32bit),
        .data3_i(next_addr),
        .select_i(MemtoReg),
        .data_o(WriteData)
        );	
endmodule
		  


