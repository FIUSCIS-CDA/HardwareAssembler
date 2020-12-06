
// Register file
module regfile(clk, we3, ra1, ra2, wa3,wd3, rd1, rd2);

  input clk, we3;
  input [4:0] ra1, ra2, wa3;
  input [31:0] wd3;
  output [31:0] rd1, rd2;

  reg [31:0] rf[31:0];

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0

  always @(posedge clk)
    if (we3) rf[wa3] <= wd3;	

  assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

// Simple adder
module adder(a, b, y);

  input [31:0] a, b;
  output [31:0] y;

  assign y = a + b;
endmodule

// Shift a value left by 2
module sl2(a, y);

  input [31:0] a;
  output [31:0] y;

  // shift left by 2
  assign y = {a[29:0], 2'b00};
endmodule

// Sign extension unit
module signext(a, y);
         
  input [15:0] a;
  output [31:0] y;
     
  assign y = {{16{a[15]}}, a};
endmodule

// Register (Written on clock tick)
module flopr (clk, reset, d, q);

  input clk, reset;
  input [31:0] d;
  output reg [31:0] q;

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;
endmodule

// Register (Written on a clock tick, and en=1)
module flopenr (clk, reset, en, d, q);
 
  input clk, reset, en;
  input [31:0] d;
  output reg [31:0] q;

  always @(posedge clk, posedge reset)
    if      (reset) q <= 0;
    else if (en)    q <= d;
endmodule

// Multiplexor
module mux2 #(parameter WIDTH = 32)
             (d0, d1, s, y);

  input [WIDTH-1:0] d0, d1;
  input s;
  output [WIDTH-1:0] y;

  assign y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 32)
             (d0, d1, d2, s, y);

  input [WIDTH-1:0] d0, d1, d2;
  input [1:0] s;
  output [WIDTH-1:0] y;

  assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule

module mux4 #(parameter WIDTH = 32)
             (d0, d1, d2, d3, s, y);

   input [WIDTH-1:0] d0, d1, d2, d3;
   input [1:0] s;
   output reg [WIDTH-1:0] y;

   always @*
      case(s)
         2'b00: y <= d0;
         2'b01: y <= d1;
         2'b10: y <= d2;
         2'b11: y <= d3;
      endcase
endmodule

