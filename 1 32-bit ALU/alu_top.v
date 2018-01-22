`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2011 
// Design Name: 
// Module Name:    alu_top 
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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
					set
               );

	input         src1;
	input         src2;
	input         less;
	//input         equal;
	input         A_invert;
	input         B_invert;
	input         cin;
	input [2-1:0] operation;
//	input         comp;
	// input equal;
	
	output        result;
	output        cout;
	output		  set;
	reg           set;
	reg           result;

	wire in1, in2;
	wire w0, w1, w2, w3;

	invert i1(src1, A_invert, in1);
	invert i2(src2, B_invert, in2);

	and g0(w0, in1, in2);
	or g1(w1, in1, in2);
	full_adder g2(in1, in2, cin, w2, cout);
//	comp g3(less, equal, comp, w3);

	always@( * )
	begin
		set <= w2;
		case (operation)
			2'b00: 
				result <= w0; // and, nor
			2'b01: 
				result <= w1; // or, nand
			2'b10: 
				result <= w2; // add, sub
			2'b11: 
				result <= less; // slt
		endcase
	end

endmodule
