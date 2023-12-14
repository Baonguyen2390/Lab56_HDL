`timescale 1ns/100ps
module MIPS(clk, in, outReadData1, outReadData2, ALUresult, outMuxMemToReg);
input clk;
input [31:0] in;
output [31:0] outReadData1, outReadData2, ALUresult, outMuxMemToReg;

wire RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemToReg;
wire [3:0]ALUcontrol;

ControlUnit C (in[31:26], RegDst, RegWrite, ALUSrc, ALUcontrol, MemWrite, MemRead, MemToReg);
Datapath D (clk, in, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemToReg, outReadData1, outReadData2, ALUresult, outMuxMemToReg);

endmodule

module MIPS_tb ();
  reg clk;
  reg [31:0] in;
  reg [5:0] op, funct;
  reg [4:0] rs, rt, rd, shamt;
  wire [31:0] outReadData1, outReadData2, ALUresult, outMuxMemToReg;

  MIPS M (clk, in, outReadData1, outReadData2, ALUresult, outMuxMemToReg);
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
    
    initial begin

    //add $1, $2, $3;
    op = 6'h01;
    rs = 5'd2;
    rt = 5'd3;
    rd = 5'd1;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    $display("Time = %0t, add $%0d, $%0d, $%0d", $time, rd, rs, rt);

    //sw $1, 0($2);
    #10
    op = 6'h02;
    rs = 5'd2;
    rt = 5'd1;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    $display("Time = %0t, sw $%0d, 0($%0d)", $time, rt, rs);
    
    //lw $1, 0($2);
    #10
    op = 6'h04;
    rs = 5'd2;
    rt = 5'd1;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    $display("Time = %0t, lw $%0d, 0($%0d)", $time, rt, rs);

    //add $1, $1, $2;
    #10
    op = 6'h01;
    rs = 5'd1;  
    rt = 5'd2;
    rd = 5'd1;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    $display("Time = %0t, add $%0d, $%0d, $%0d", $time, rd, rs, rt);
    
    #5
    $finish;
  end
  initial begin
      $monitor("Time = %0t, ReadData1 = %0d, ReadData2 = %0d, ALUresult = %0d, outMuxMemToReg = %0d", $time, outReadData1, outReadData2, ALUresult, outMuxMemToReg);
  end
  
endmodule