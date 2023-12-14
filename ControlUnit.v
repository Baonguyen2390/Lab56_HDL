`timescale 1ns/100ps
module ControlUnit(op, RegDst, RegWrite, ALUSrc, ALUcontrol, MemWrite, MemRead, MemToReg);
  input [5:0] op;
  output reg RegDst, MemRead, MemWrite, MemToReg, ALUSrc, RegWrite;
  output reg [3:0] ALUcontrol;
  
  always @(*) begin
    case(op)
      6'b000001 : begin //add
        RegDst = 1;
        MemRead = 0;
        MemWrite = 0;
        MemToReg = 1;
        ALUcontrol = 4'b0101;
        ALUSrc = 0;
        RegWrite = 1;
      end
      6'b000010 : begin //sw
        RegDst = 0;
        MemRead = 0;
        MemWrite = 1;
        MemToReg = 0;
        ALUcontrol = 4'b0101;
        ALUSrc = 1;
        RegWrite = 0;
      end
      6'b000100 : begin //lw
        RegDst = 0;
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 0;
        ALUcontrol = 4'b0101;
        ALUSrc = 1;
        RegWrite = 1;
      end
      
    endcase
  end
endmodule

module ControlUnit_tb();

  // Input signal
  reg [5:0] op;

  // Output signals
  wire RegDst, MemRead, MemWrite, MemToReg, ALUSrc, RegWrite;
  wire [3:0] ALUcontrol;

  // Instantiate the ControlUnit module
  ControlUnit dut (op, RegDst, RegWrite, ALUSrc, ALUcontrol, MemWrite, MemRead, MemToReg);

  // Initial block
  initial begin
    // Test add instruction
    op = 6'b000001;
    #10;

    // Test sw instruction
    op = 6'b000010;
    #10;

    // Test lw instruction
    op = 6'b000100;
    #10;

    // Stop simulation
    $finish;
  end

  // Monitor
  initial begin
    $monitor("time = %0t, op = %b, RegDst = %b, MemRead = %b, MemWrite = %b, MemToReg = %b, ALUControl = %b, ALUSrc = %b, RegWrite = %b", $time,op, RegDst, MemRead, MemWrite, MemToReg, ALUcontrol, ALUSrc, RegWrite);
  end

endmodule