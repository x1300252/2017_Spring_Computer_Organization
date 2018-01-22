`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2010
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			//bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

//reg    [32-1:0] result;
//reg             zero;
//reg             cout;
//reg             overflow;

	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31;
	wire[1:0] op;
	wire less, c; 
	wire set, s;
	
	xor n1(overflow, w30, c);
	  
	assign op = ALU_control[1:0];
	assign cout = (op != 2) ? 0 : c;
	zero z(.result(result), .z(zero));
	xor g1(less, s, overflow); 
	
	alu_top a0(.src1(src1[0]), .src2(src2[0]), .less(less), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_control[2]), .operation(op), .result(result[0]), .cout(w0), .set(set));
	alu_top a1(.src1(src1[1]), .src2(src2[1]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w0), .operation(op) , .result(result[1]), .cout(w1), .set(set));
	alu_top a2(.src1(src1[2]), .src2(src2[2]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w1), .operation(op) , .result(result[2]), .cout(w2), .set(set));
	alu_top a3(.src1(src1[3]), .src2(src2[3]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w2), .operation(op) , .result(result[3]), .cout(w3), .set(set));
	
	alu_top a4(.src1(src1[4]), .src2(src2[4]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w3), .operation(op) , .result(result[4]), .cout(w4), .set(set));
	alu_top a5(.src1(src1[5]), .src2(src2[5]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w4), .operation(op) , .result(result[5]), .cout(w5), .set(set));
	alu_top a6(.src1(src1[6]), .src2(src2[6]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w5), .operation(op) , .result(result[6]), .cout(w6), .set(set));
	alu_top a7(.src1(src1[7]), .src2(src2[7]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w6), .operation(op) , .result(result[7]), .cout(w7), .set(set));
	
	alu_top a8(.src1(src1[8]), .src2(src2[8]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w7), .operation(op) , .result(result[8]), .cout(w8), .set(set));
	alu_top a9(.src1(src1[9]), .src2(src2[9]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w8), .operation(op) , .result(result[9]), .cout(w9), .set(set));
	alu_top a10(.src1(src1[10]), .src2(src2[10]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w9), .operation(op) , .result(result[10]), .cout(w10), .set(set));
	alu_top a11(.src1(src1[11]), .src2(src2[11]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w10), .operation(op) , .result(result[11]), .cout(w11), .set(set));
	
	alu_top a12(.src1(src1[12]), .src2(src2[12]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w11), .operation(op) , .result(result[12]), .cout(w12), .set(set));
	alu_top a13(.src1(src1[13]), .src2(src2[13]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w12), .operation(op) , .result(result[13]), .cout(w13), .set(set));
	alu_top a14(.src1(src1[14]), .src2(src2[14]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w13), .operation(op) , .result(result[14]), .cout(w14), .set(set));
	alu_top a15(.src1(src1[15]), .src2(src2[15]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w14), .operation(op) , .result(result[15]), .cout(w15), .set(set));
	
	alu_top a16(.src1(src1[16]), .src2(src2[16]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w15), .operation(op) , .result(result[16]), .cout(w16), .set(set));
	alu_top a17(.src1(src1[17]), .src2(src2[17]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w16), .operation(op) , .result(result[17]), .cout(w17), .set(set));
	alu_top a18(.src1(src1[18]), .src2(src2[18]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w17), .operation(op) , .result(result[18]), .cout(w18), .set(set));
	alu_top a19(.src1(src1[19]), .src2(src2[19]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w18), .operation(op) , .result(result[19]), .cout(w19), .set(set));
	
	alu_top a20(.src1(src1[20]), .src2(src2[20]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w19), .operation(op) , .result(result[20]), .cout(w20), .set(set));
	alu_top a21(.src1(src1[21]), .src2(src2[21]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w20), .operation(op) , .result(result[21]), .cout(w21), .set(set));
	alu_top a22(.src1(src1[22]), .src2(src2[22]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w21), .operation(op) , .result(result[22]), .cout(w22), .set(set));
	alu_top a23(.src1(src1[23]), .src2(src2[23]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w22), .operation(op) , .result(result[23]), .cout(w23), .set(set));
	
	alu_top a24(.src1(src1[24]), .src2(src2[24]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w23), .operation(op) , .result(result[24]), .cout(w24), .set(set));
	alu_top a25(.src1(src1[25]), .src2(src2[25]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w24), .operation(op) , .result(result[25]), .cout(w25), .set(set));
	alu_top a26(.src1(src1[26]), .src2(src2[26]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w25), .operation(op) , .result(result[26]), .cout(w26), .set(set));
	alu_top a27(.src1(src1[27]), .src2(src2[27]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w26), .operation(op) , .result(result[27]), .cout(w27), .set(set));
	
	alu_top a28(.src1(src1[28]), .src2(src2[28]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w27), .operation(op) , .result(result[28]), .cout(w28), .set(set));
	alu_top a29(.src1(src1[29]), .src2(src2[29]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w28), .operation(op) , .result(result[29]), .cout(w29), .set(set));
	alu_top a30(.src1(src1[30]), .src2(src2[30]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w29), .operation(op) , .result(result[30]), .cout(w30), .set(set));
	alu_top a31(.src1(src1[31]), .src2(src2[31]), .less(0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(w30), .operation(op) , .result(result[31]), .cout(c), .set(s));
	
	
endmodule
 