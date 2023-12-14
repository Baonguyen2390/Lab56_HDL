`timescale 1ns/100ps
module Mux2to1_32bit (inA, inB, sel, out);
input [31:0] inA, inB;
input sel;
output [31:0] out;

assign out = sel ? inB : inA;

endmodule

