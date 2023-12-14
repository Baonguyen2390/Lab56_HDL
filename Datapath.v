`timescale 1ns/100ps

module Datapath(clk, in, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemToReg, outReadData1, outReadData2, ALUresult, outMuxMemToReg);
  input clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg;
  input [3:0] ALUcontrol;
  input [31:0] in;

  wire [4:0] outMuxRegDst;
  wire [31:0] outMuxALUSrc;

  wire [31:0] outSignExtend, outReadDataMem; 
  output [31:0] outReadData1, outReadData2, ALUresult, outMuxMemToReg;

  Mux2to1_5bit mux0(in[20:16], in[15:11], RegDst, outMuxRegDst);

  RegisterFile RF(clk, in[25:21], in[20:16], outMuxRegDst, outMuxMemToReg, RegWrite, outReadData1, outReadData2);

  SignExtend se(in[15:0], outSignExtend);

  Mux2to1_32bit mux1(outReadData2, outSignExtend, ALUSrc, outMuxALUSrc);

  ALU A(outReadData1, outMuxALUSrc, ALUcontrol,  ALUresult);

  DataMemory DM(clk, ALUresult[5:0], outReadData2, MemRead, MemWrite, outReadDataMem);

  Mux2to1_32bit mux2(outReadDataMem, ALUresult, MemToReg, outMuxMemToReg);
endmodule

module Datapath_tb();
  reg clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg;
  reg [3:0] ALUcontrol;
  reg [31:0]in;
  reg [5:0] op, funct;
  reg [4:0] rs, rt, rd, shamt;
  wire [31:0] outReadData1, outReadData2, ALUresult, outMuxMemToReg;
  
  Datapath DP(clk, in, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemToReg, outReadData1, outReadData2, ALUresult, outMuxMemToReg);
  
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
    RegDst = 1;
    RegWrite = 1;
    ALUSrc = 0;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 0;
    MemToReg = 1;
    //sw $1, 0($2);
    #10
    op = 6'h02;
    rs = 5'd2;
    rt = 5'd1;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    RegDst = 0;
    RegWrite = 0;
    ALUSrc = 1;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 1;
    MemToReg = 0;
    //sw $1, 0($2);
    #10
    op = 6'h04;
    rs = 5'd2;
    rt = 5'd4;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    RegDst = 0;
    RegWrite = 1;
    ALUSrc = 1;
    ALUcontrol = 4'b0101;
    MemRead = 1;
    MemWrite = 0;
    MemToReg = 0;
    //add $1, $1, $2;
    #10
    op = 6'h01;
    rs = 5'd1;
    rt = 5'd2;
    rd = 5'd1;
    shamt = 5'd0;
    funct = 5'd0;
    in = {op, rs, rt, rd, shamt, funct};
    RegDst = 1;
    RegWrite = 1;
    ALUSrc = 0;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 0;
    MemToReg = 1;
    
    
    #5
    $finish;
  end
  initial begin
    $monitor("Time = %0t,  in = %h, ReadData1 = %0d, ReadData2 = %0d, ALU_result = %0d, out_MemtoReg = %0d,", $time, in, outReadData1, outReadData2, ALUresult, outMuxMemToReg);
  end
endmodule

