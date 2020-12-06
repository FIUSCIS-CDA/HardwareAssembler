


module maindec(clk, reset, op, pcwrite, pcwritecond, iord, memwrite, irwrite,
               memtoreg, pcsrc, aluop, alusrcb, alusrca, regwrite, regdst);
    
  input clk, reset;
  input [5:0] op;
  
  output pcwrite, memwrite, irwrite, regwrite;
  output alusrca, pcwritecond, iord, memtoreg, regdst;
  output [1:0] alusrcb, aluop, pcsrc; 
  
  wire[3:0] state;
  wire addrctl;

  FSM myFSM(clk, reset, op[5], op[4], op[3], op[2], op[1], op[0], addrctl, state[3], state[2], state[1], state[0]);
  microprogram myMicro(state, pcwrite, pcwritecond, iord, memwrite, irwrite,
                       memtoreg, pcsrc, aluop, alusrcb, alusrca, regwrite, regdst, addrctl);
endmodule

