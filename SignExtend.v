`timescale 1ns/100ps
module SignExtend(in, out);
	input [15:0]in;
	output [31:0]out;
	reg [15:0]out0=16'h0000;
	reg [15:0]out1=16'hffff;

	assign	out = in[15] ? ({out1,in}) : ({out0, in});
endmodule