`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:43:59 03/20/2017 
// Design Name: 
// Module Name:    invert 
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
module invert(
	input in, 
	input signal,
	output out
);
	wire w1, w2, w3, w4;
	
	not(w1, in);
	not(w2, signal);
	and(w3, w1, signal);
	and(w4, w2, in);
	or(out, w3, w4);
endmodule
