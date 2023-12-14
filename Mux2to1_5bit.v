`timescale 1ns/100ps
module Mux2to1_5bit (inA, inB, sel, out);
input [4:0] inA, inB;
input sel;
output [4:0] out;

assign out = sel ? inB : inA;

endmodule
