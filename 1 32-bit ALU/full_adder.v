`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:14:46 03/20/2017 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder(
	A,
	B,
	cin,
	r,
	cout
);
	
	input A, B, cin;
	output r, cout;

	wire w1, w2, w3;
	
	xor g1(w1, A, B);
	xor g2(r, w1, cin);
	and g3(w2, w1, cin);
	and g4(w3, A, B);
	or g5(cout, w2, w3);
	
endmodule

