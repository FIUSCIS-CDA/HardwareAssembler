module top(clk, reset, writedata, adr, memwrite);

  input clk, reset;
  output [31:0] writedata, adr;
  output memwrite;

  wire [31:0] readdata;

  // Wire in the CPU and Memory.  

  // microprocessor (control & datapath)
  mips mips(clk, reset, adr, writedata, memwrite, readdata);

  // memory 
  mem mem(clk, memwrite, adr, writedata, readdata);

endmodule
