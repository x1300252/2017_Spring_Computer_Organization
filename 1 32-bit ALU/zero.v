`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:53:06 03/24/2017 
// Design Name: 
// Module Name:    zero 
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
module zero(
		input[31:0] result,
		output z
    );

	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16;
	wire x1, x2, x3, x4, x5, x6, x7, x8;
	wire y1, y2, y3, y4;
	wire z1, z2;
	wire c, d;
	
	or g1(w1, result[0], result[1]);
	or g2(w2, result[2], result[3]);
	or g3(w3, result[4], result[5]);
	or g4(w4, result[6], result[7]);

	or g5(w5, result[8], result[9]);
	or g6(w6, result[10], result[11]);
	or g7(w7, result[12], result[13]);
	or g8(w8, result[14], result[15]);
	
	or g9(w9, result[16], result[17]);
	or g10(w10, result[18], result[19]);
	or g11(w11, result[20], result[21]);
	or g12(w12, result[22], result[23]);
	
	or g13(w13, result[24], result[25]);
	or g14(w14, result[26], result[27]);
	or g15(w15, result[28], result[29]);
	or g16(w16, result[30], result[31]);
	
	or h1(x1, w1, w2);
	or h2(x2, w3, w4);
	or h3(x3, w5, w6);
	or h4(x4, w7, w8);
	
	or h5(x5, w9, w10);
	or h6(x6, w11, w12);
	or h7(x7, w13, w14);
	or h8(x8, w15, w16);
	
	or i1(y1, x1, x2);
	or i2(y2, x3, x4);
	or i3(y3, x5, x6);
	or i4(y4, x7, x8);
	
	or j1(z1, y1, y2);
	or j2(z2, y3, y4);
	
	or k(c, z1, z2);
	not n(z, c);
/*
always@(*)
	z <= d;
*/
endmodule
