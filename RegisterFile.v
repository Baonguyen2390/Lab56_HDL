`timescale 1ns/100ps

module RegisterFile(clk, ReadReg1, ReadReg2, WriteAddress, WriteData, RegWrite, ReadData1, ReadData2);
  input clk, RegWrite;
  input [4:0] ReadReg1, ReadReg2, WriteAddress;
  input [31:0] WriteData;
  output reg [31:0] ReadData1, ReadData2;
  
  reg [31:0] Register [31:0];
  
  initial begin
    Register[2] = 2;
    Register[3] = 3;
  end
  
  always @(*) begin
    ReadData1 = Register[ReadReg1];
    ReadData2 = Register[ReadReg2];
  end
  
  always @(posedge clk) begin
    if(RegWrite) begin
      Register[WriteAddress] = WriteData;
    end
  end
  
endmodule

module RegisterFile_tb();
  reg clk, RegWrite;
  reg [4:0] ReadReg1, ReadReg2, WriteAddress;
  reg [31:0] WriteData;
  wire [31:0] ReadData1, ReadData2;
  
  RegisterFile R (clk, ReadReg1, ReadReg2, WriteAddress, WriteData, RegWrite, ReadData1, ReadData2);
  
  initial begin
    forever #5 clk = ~clk;
  end
  initial begin
    clk = 90;
    ReadReg1 = 5'd2;
    ReadReg2 = 5'd3;
    WriteAddress = 5'd1;
    WriteData = 32'h12345678;
    RegWrite = 1;
    
    #10
    ReadReg1 = 5'd1;
    ReadReg2 = 5'd2;
    WriteAddress = 5'd3;
    WriteData = 32'h87654321;
    RegWrite = 1;
    
    #10
    ReadReg1 = 5'd2;
    ReadReg2 = 5'd3;
    WriteAddress = 5'd1;
    WriteData = 32'h1234abcd;
    RegWrite = 0;
    
    #10
    ReadReg1 = 5'd1;
    ReadReg2 = 5'd2;
    WriteAddress = 5'd1;
    WriteData = 32'h5678cdef;
    RegWrite = 0;
    
    #10
    $finish;
  end
  initial begin
    $monitor($time,, "WriteAddress = %d, ReadReg1 = %d, ReadReg2 = %d, WriteData = %h, RegWrite = %d, ReadData1 = %h, ReadData2 = %h" , WriteAddress, ReadReg1, ReadReg2, WriteData, RegWrite, ReadData1, ReadData2);
  end
  
endmodule
