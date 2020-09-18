
module mips(clk, reset, adr, writedata, memwrite, readdata);
  input clk, reset;
  output [31:0] adr, writedata;
  output memwrite;
  input [31:0] readdata;


  wire        zero, pcen, irwrite, regwrite,
               alusrca, iord, memtoreg, regdst;
  wire [1:0]  alusrcb, pcsrc;
  wire [3:0]  alucontrol;
  wire [5:0]  op, funct;

  controller c(clk, reset, op, funct, zero,
               pcen, memwrite, irwrite, regwrite,
               alusrca, iord, memtoreg, regdst, 
               alusrcb, pcsrc, alucontrol);
  datapath dp(clk, reset, 
              pcen, irwrite, regwrite,
              alusrca, iord, memtoreg, regdst,
              alusrcb, pcsrc, alucontrol,
              op, funct, zero,
              adr, writedata, readdata);
endmodule

module controller(clk, reset, op, funct, zero, pcen, memwrite, irwrite, regwrite,
                  alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, alucontrol);

  input clk, reset;
  input [5:0] op, funct;
  input zero;
  output pcen, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst;
  output [1:0] alusrcb, pcsrc;
  output [3:0] alucontrol;

  wire [1:0] aluop;
  wire       branch, pcwrite;
  // Main Decoder and ALU Decoder subunits.
  maindec md(clk, reset, op,
             pcwrite, branch, iord, memwrite, irwrite, memtoreg, 
             pcsrc, aluop, alusrcb,
             alusrca, regwrite, regdst);

  aludec  ad(funct, aluop, alucontrol);

assign pcen = pcwrite | (branch & zero);
 
endmodule


module aludec(funct, aluop, alucontrol);

  input [5:0] funct;
  input [1:0] aluop;
  output reg [3:0] alucontrol;

  // Map: ALUOp to ALUControl
  always @(*)
     case(aluop)
       2'b00: alucontrol <= 4'b0010;
       2'b01: alucontrol <= 4'b1110;
       default:
          case(funct)
             6'b100000: alucontrol <= 4'b0010; // ADD CASE
	     6'b100010: alucontrol <= 4'b1110; // SUBTRACT CASE
             6'b100100: alucontrol <= 4'b0000; // AND CASE
	     6'b100101: alucontrol <= 4'b0001; // OR CASE
	     6'b101010: alucontrol <= 4'b1111; // SLT CASE
	  endcase
	endcase
endmodule





// The datapath unit is a structural verilog module.  That is,
// it is composed of instances of its sub-modules.  For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated.
module datapath(clk, reset, PCEn, IRWrite, RegWrite, ALUSrcA, IorD, MemtoReg, RegDst,
                ALUSrcB, PCSrc, ALUControl, Op, Funct, Zero, Adr, WD, RD);


  input          clk, reset, PCEn, IRWrite, RegWrite, ALUSrcA, IorD, MemtoReg, RegDst;
  input   [1:0]  ALUSrcB, PCSrc;
  input   [3:0]  ALUControl;
  output  [5:0]  Op, Funct;
  output         Zero;
  output  [31:0] Adr, WD; 
  input   [31:0] RD;


  wire [4:0]  WriteReg; // Added to diagram
  wire [31:0] PCPrime, PC;
  wire [31:0] Instr, Data, SrcA, SrcB;
  wire [31:0] A;
  wire [31:0] ALUResult, ALUOut;
  wire [31:0] ImmExt;   
  wire [31:0] ImmExt2;	
  wire [31:0] WD3, RD1, RD2;


  assign Op = Instr[31:26];
  assign Funct = Instr[5:0];
  wire ALUError; 
  //assign NegCheck = ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & ~Op[1] & ~Op[0] & Funct[3] & ~PCEn; 

  // Datapath hardware
  regfile RegFile(clk, RegWrite, Instr[25:21], Instr[20:16], WriteReg, WD3, RD1,RD2);
  flopenr regPC(clk, reset, PCEn, PCPrime, PC); 
  flopenr  flopInstr(clk, reset,IRWrite,RD,Instr);
  mux2 muxAdr(PC, ALUOut, IorD, Adr);
  mux3 muxPC(ALUResult, ALUOut, {PC[31:28], Instr[25:0], 2'b00}, PCSrc, PCPrime);
  mux2 #(5) muxA(Instr[20:16], Instr[15:11], RegDst, WriteReg);
  mux2 muxWD3(ALUOut, Data, MemtoReg, WD3);
  mux2 muxSrcA(PC, A , ALUSrcA, SrcA);
  mux4 muxSrcB(WD,32'b00000000000000000000000000000100 , ImmExt, ImmExt2, ALUSrcB, SrcB);
  ALU32 newALUResult (1'b0, ALUControl[3], ALUControl[2], {ALUControl[1], ALUControl[0]}, SrcA, SrcB, ALUResult, Zero, ALUError);
  signext newImmExt(Instr[15:0], ImmExt);
  sl2 newImmExt2(ImmExt, ImmExt2);
  flopr flopData(clk, reset, RD, Data);
  flopr flopA(clk,reset,RD1,A);
  flopr flopB(clk,reset,RD2,WD);
  flopr flopALUOut(clk, reset, ALUResult,ALUOut);

  /////////////////////////////////////////////////////////////////////////////


endmodule



