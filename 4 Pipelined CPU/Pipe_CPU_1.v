//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416038 ¤ýµú¸©_0416326 ±ç¹t±Ó
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
      clk_i,
		rst_i
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
wire [32-1:0]	pc_i;
wire [32-1:0]	pc_o;
wire [32-1:0]	IF_pc_add4;
wire [32-1:0]	IF_instruction;

/**** ID stage ****/
wire [32-1:0]	ID_pc_add4;
wire [32-1:0]	ID_instruction;

wire [6-1:0]	ID_op;
wire [5-1:0]	ID_Rs;
wire [5-1:0]	ID_Rt;
wire [5-1:0]	ID_Rd;
wire [5-1:0]	ID_shamt;
wire [16-1:0]	ID_value_16bits;
wire [32-1:0]	ID_value_32bits;

wire [32-1:0]	ID_Rsdata;
wire [32-1:0]	ID_Rtdata;
//control signal
wire 				ID_RegWrite_in;
wire [3-1:0]	ID_ALU_op_in;
wire 				ID_ALUSrc_in;
wire 				ID_RegDst_in;
wire [2-1:0]	ID_Branch_in;
wire 				ID_SignExtend_in;
wire 				ID_MemRead_in;
wire 				ID_MemWrite_in;
wire 				ID_MemtoReg_in;

wire 				ID_RegWrite;
wire [3-1:0]	ID_ALU_op;
wire 				ID_ALUSrc;
wire 				ID_RegDst;
wire [2-1:0]	ID_Branch;
wire 				ID_SignExtend;
wire 				ID_MemRead;
wire 				ID_MemWrite;
wire 				ID_MemtoReg;

/**** EX stage ****/
wire [32-1:0]	EX_pc_add4;
wire [5-1:0]	EX_Rs;
wire [5-1:0]	EX_Rt;
wire [5-1:0]	EX_Rd;
wire [5-1:0]	EX_shamt;
wire [32-1:0]	EX_Rsdata;
wire [32-1:0]	EX_Rtdata;
wire [32-1:0]	EX_value_32bits;

wire [32-1:0]	EX_shift_addr;
wire [32-1:0]	EX_branch_addr;

wire [4-1:0]	EX_ALUCtrl;
wire [6-1:0]	EX_funct;

wire [32-1:0]	EX_src2;
wire [5-1:0]	EX_WrtDst;

wire [32-1:0]	EX_result;
wire 				EX_zero;

wire [32-1:0]	ALUsrc1;
wire [32-1:0]	ALUsrc2;

//control signal
wire 				EX_RegWrite_in;
wire [2-1:0]	EX_Branch_in;
wire 				EX_MemRead_in;
wire 				EX_MemWrite_in;
wire 				EX_MemtoReg_in;

wire 				EX_RegWrite;
wire [3-1:0]	EX_ALU_op;
wire 				EX_ALUSrc;
wire 				EX_RegDst;
wire [2-1:0]	EX_Branch;
wire 				EX_SignExtend;
wire 				EX_MemRead;
wire 				EX_MemWrite;
wire 				EX_MemtoReg;

/**** MEM stage ****/
wire [32-1:0] 	MEM_branch_addr;
wire				MEM_zero;

wire [32-1:0]	MEM_result;
wire [32-1:0]	MEM_Rtdata;
wire [32-1:0]	MEM_Memdata;

wire [5-1:0]	MEM_WrtDst;

//control signal
wire				MEM_PCSrc;
wire 				MEM_RegWrite;
wire [2-1:0]	MEM_Branch;
wire 				MEM_SignExtend;
wire 				MEM_MemRead;
wire 				MEM_MemWrite;
wire 				MEM_MemtoReg;

/**** WB stage ****/ 
wire [32-1:0]	WB_result;
wire [32-1:0]	WB_Memdata;
wire [32-1:0]  WB_Wrtdata;
wire [5-1:0]	WB_WrtDst;
//control signal
wire 				WB_RegWrite;
wire 				WB_MemtoReg;

/**** Forwarding ****/
wire [2-1:0]	ForwardA;
wire [2-1:0]	ForwardB;

/**** Hazard Detection ****/
wire 				IF_flush;
wire 				ID_flush;
wire 				EX_flush;
wire 				IF_ID_Write;
wire 				PCWrite;

/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) PC_Mux(
	.data0_i(IF_pc_add4),
	.data1_i(MEM_branch_addr),
	.select_i(MEM_PCSrc),
	.data_o(pc_i)
		);

ProgramCounter PC(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.PC_write_i(PCWrite),
	.pc_in_i(pc_i),
	.pc_out_o(pc_o)
        );

Instr_Memory IM(
	.addr_i(pc_o),
	.instr_o(IF_instruction)
	    );

Adder Add_pc(
	.src1_i(pc_o),
	.src2_i(32'd4),
	.sum_o(IF_pc_add4)
		);

		
Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
	.clk_i(clk_i),
	.rst_i(rst_i),
	.write_i(IF_ID_Write),
	.flush_i(IF_flush),
	.data_i({IF_pc_add4, IF_instruction}),
	.data_o({ID_pc_add4, ID_instruction})
		);

//Instantiate the components in ID stage
assign ID_op 				= ID_instruction[31:26];
assign ID_Rs				= ID_instruction[25:21];
assign ID_Rt				= ID_instruction[20:16];
assign ID_Rd				= ID_instruction[15:11];
assign ID_shamt			= ID_instruction[10:6];
assign ID_value_16bits 	= ID_instruction[15:0];

Reg_File RF(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.RSaddr_i(ID_Rs),
	.RTaddr_i(ID_Rt),
	.RDaddr_i(WB_WrtDst),
	.RDdata_i(WB_Wrtdata),
	.RegWrite_i(WB_RegWrite),
	.RSdata_o(ID_Rsdata),
	.RTdata_o(ID_Rtdata)
		);

Decoder Control(
	.instr_op_i(ID_op),
	.RegWrite_o(ID_RegWrite_in),
	.ALU_op_o(ID_ALU_op_in),
	.ALUSrc_o(ID_ALUSrc_in),
	.RegDst_o(ID_RegDst_in),
	.Branch_o(ID_Branch_in),
	.SignExtend_o(ID_SignExtend_in),
	.MemRead_o(ID_MemRead_in),
	.MemWrite_o(ID_MemWrite_in),
	.MemtoReg_o(ID_MemtoReg_in)
		);

MUX_2to1 #(.size(12)) ID_Mux(
	.data0_i({ID_RegWrite_in, ID_ALU_op_in, ID_ALUSrc_in, ID_RegDst_in, ID_Branch_in, ID_SignExtend_in, ID_MemRead_in, ID_MemWrite_in, ID_MemtoReg_in}),
	.data1_i(12'd0),
	.select_i(ID_flush),
	.data_o({ID_RegWrite, ID_ALU_op, ID_ALUSrc, ID_RegDst, ID_Branch, ID_SignExtend, ID_MemRead, ID_MemWrite, ID_MemtoReg})
        );

Sign_Extend Sign_Extend(
	.data_i(ID_value_16bits),
	.SECtrl_i(ID_SignExtend_in),
   .data_o(ID_value_32bits)
		);	

Pipe_Reg #(.size(159)) ID_EX(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.write_i(1'd1),
	.flush_i(1'd0),
	.data_i({ID_RegWrite, ID_MemtoReg,
				ID_Branch, ID_MemRead, ID_MemWrite,
				ID_RegDst, ID_ALUSrc, ID_ALU_op, 
				ID_pc_add4,
				ID_Rsdata, ID_Rtdata,
				ID_shamt,
				ID_value_32bits,
				ID_Rs, ID_Rt, ID_Rd}),
	.data_o({EX_RegWrite_in, EX_MemtoReg_in,
				EX_Branch_in, EX_MemRead_in, EX_MemWrite_in,
				EX_RegDst, EX_ALUSrc, EX_ALU_op, 
				EX_pc_add4,
				EX_Rsdata, EX_Rtdata,
				EX_shamt,
				EX_value_32bits,
				EX_Rs, EX_Rt, EX_Rd})
		);

//Instantiate the components in EX stage
Shift_Left_Two_32 Shifter(
        .data_i(EX_value_32bits),
        .data_o(EX_shift_addr)
        );

Adder Adder1(
       .src1_i(EX_pc_add4),     
	    .src2_i(EX_shift_addr),     
	    .sum_o(EX_branch_addr)    
	    );
 
ALU ALU(
	.src1_i(ALUsrc1),
	.src2_i(EX_src2),
	.shamt_i(EX_shamt),
	.ctrl_i(EX_ALUCtrl),
	.result_o(EX_result),
	.zero_o(EX_zero)
		);

assign EX_funct = EX_value_32bits[5:0];
ALU_Ctrl ALU_Ctrl(
	.funct_i(EX_funct),
	.ALUOp_i(EX_ALU_op),
	.ALUCtrl_o(EX_ALUCtrl)
		);

MUX_2to1 #(.size(32)) ALUSrc_Mux(
	.data0_i(ALUsrc2),
	.data1_i(EX_value_32bits),
	.select_i(EX_ALUSrc),
	.data_o(EX_src2)
        );

MUX_2to1 #(.size(5)) RegDst_Mux(
	.data0_i(EX_Rt),
	.data1_i(EX_Rd),
	.select_i(EX_RegDst),
	.data_o(EX_WrtDst)
        );

MUX_3to1 #(.size(32)) ForwardA_Mux(
	.data0_i(EX_Rsdata),
	.data1_i(MEM_result),
	.data2_i(WB_Wrtdata),
	.select_i(ForwardA),
	.data_o(ALUsrc1)
        );
		  
MUX_3to1 #(.size(32)) ForwardB_Mux(
	.data0_i(EX_Rtdata),
	.data1_i(MEM_result),
	.data2_i(WB_Wrtdata),
	.select_i(ForwardB),
	.data_o(ALUsrc2)
        );
	  
MUX_2to1 #(.size(6)) EX_Mux(
	.data0_i({EX_RegWrite_in, EX_MemtoReg_in, EX_Branch_in, EX_MemRead_in, EX_MemWrite_in}),
	.data1_i(6'd0),
	.select_i(EX_flush),
	.data_o({EX_RegWrite, EX_MemtoReg, EX_Branch, EX_MemRead, EX_MemWrite})
        );

Pipe_Reg #(.size(108)) EX_MEM(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.write_i(1'd1),
	.flush_i(1'd0),
	.data_i({EX_RegWrite, EX_MemtoReg,
				EX_Branch, EX_MemRead, EX_MemWrite, 
				EX_branch_addr,
				EX_zero, EX_result,
				ALUsrc2,
				EX_WrtDst}),
	.data_o({MEM_RegWrite, MEM_MemtoReg,
				MEM_Branch, MEM_MemRead, MEM_MemWrite, 
				MEM_branch_addr,
				MEM_zero, MEM_result,
				MEM_Rtdata,
				MEM_WrtDst})
		);

//Instantiate the components in MEM stage
assign MEM_PCSrc = (MEM_Branch[0] & MEM_zero) || (MEM_Branch[1] & (!MEM_zero));
Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(MEM_result),
	.data_i(MEM_Rtdata),
	.MemRead_i(MEM_MemRead),
	.MemWrite_i(MEM_MemWrite),
	.data_o(MEM_Memdata)
	    );

Pipe_Reg #(.size(71)) MEM_WB(
   .clk_i(clk_i),
	.rst_i(rst_i),
	.write_i(1'd1),
	.flush_i(1'd0),
	.data_i({MEM_RegWrite, MEM_MemtoReg, 
				MEM_result,
				MEM_Memdata,
				MEM_WrtDst}),
	.data_o({WB_RegWrite, WB_MemtoReg, 
				WB_result,
				WB_Memdata,
				WB_WrtDst})     
		);

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) WB_Data(
	.data0_i(WB_result),
	.data1_i(WB_Memdata),
	.select_i(WB_MemtoReg),
	.data_o(WB_Wrtdata)
        );

/****************************************
signal assignment
****************************************/	

Forwarding_Unit FU(
	.EX_MEM_RegWrite(MEM_RegWrite),
	.EX_MEM_RegRd(MEM_WrtDst),
	.MEM_WB_RegWrite(WB_RegWrite),
	.MEM_WB_RegRd(WB_WrtDst),
	.ID_EX_RegRs(EX_Rs),
	.ID_EX_RegRt(EX_Rt),
	.ForwardA(ForwardA),
	.ForwardB(ForwardB)
    );
	 
Hazard_Detection HD(
	.ID_EX_MemRead(EX_MemRead),
	.ID_EX_RegRt(EX_Rt),
	.IF_ID_RegRs(ID_Rs),
	.IF_ID_RegRt(ID_Rt),
	.PCSrc(MEM_PCSrc),
	.IF_flush(IF_flush),
	.ID_flush(ID_flush),
	.EX_flush(EX_flush),
	.IF_ID_Write(IF_ID_Write),
	.PCWrite(PCWrite)
    );
endmodule


