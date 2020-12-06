module ALUCtl(funct_code, ALUOp, ALUControl);

  input [5:0] funct_code;
  input [1:0] ALUOp;
  output reg [3:0] ALUControl;

  // Map: ALUOp to ALUControl
  always @(*)
     case(ALUOp)
       2'b00: ALUControl <= 4'b0010;  // If ALUOp=00, add.  Binv=0, CIn=0, Op=10 (so Op1=1, Op0=0)
       ///////////////////////////////////////////////////////////
       // PUT CODE HERE for sub
       ///////////////////////////////////////////////////////////
       default:
          case(funct_code)
             6'b100000: ALUControl <= 4'b0010; // ADD CASE
             /////////////////////////////////////////////////////////////
             // PUT CODE HERE for the rest (sub, and, or, less)
             /////////////////////////////////////////////////////////////
	  endcase
	endcase
endmodule

