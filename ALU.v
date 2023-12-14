`timescale 1ns/100ps
module ALU (inA, inB, ALUControl, ALUResult);
input [31:0] inA, inB;
input [3:0] ALUControl;
output [31:0]ALUResult;

assign ALUResult = (ALUControl == 4'b0101) ? (inA + inB) : 32'bz;

endmodule
