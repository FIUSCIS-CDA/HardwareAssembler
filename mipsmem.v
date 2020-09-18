
module mem(clk, we, a, wd, rd);

  input clk, we;
  input [31:0] a, wd;
  output [31:0] rd;

  reg  [31:0] RAM[63:0]; // 64 addresses of one word (32 bits)

  // initialize memory with instructions
  initial
    begin
      $readmemh("memfile.dat",RAM);  // Instructions are in hexadecimal.  Load the program.
                                     
    end

  // NOTE: Verilog memories work much like arrays, as in you provide a spot and it gives you data
  // We cannot do an array of bytes, because then if you supply RAM[64] for example it will give
  // you only one byte, instead of returning RAM[64-67].
  // So in order to model byte-addressed memory, every address will be divided by four and there will
  // be one whole 32-bit word at that spot.
  assign rd = RAM[a[31:2]]; // word
  
  always @(posedge clk) // Synchronous memory
    if (we)
      RAM[a[31:2]] <= wd; // Only write on enable
endmodule
