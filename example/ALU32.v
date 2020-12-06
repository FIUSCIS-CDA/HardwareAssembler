
module ALU32 (Ainvert, Binvert, CarryIn, Operation, A, B, Result, Zero, Overflow);
  input Ainvert, Binvert, CarryIn;
  input [1:0] Operation;
  input [31:0] A, B;

  output wire [31:0] Result;
  output Zero;
  output Overflow;

  wire [30:0] CarryOuts;
  wire Set;

  ALUBits0To30 lowestBit(Ainvert, Binvert, CarryIn, Operation[1], Operation[0], A[0], B[0], Set, Result[0], CarryOuts[0]);
  ALUBits0To30 middleBits [29:0](Ainvert, Binvert, CarryOuts[29:0], Operation[1], Operation[0], A[30:1], B[30:1], 1'b0, Result[30:1], CarryOuts[30:1]);

  // Add code here...
  ALUBit31 upperBit(A[31], B[31], 1'b0, Ainvert, Binvert, CarryOuts[30], Operation[1], Operation[0], Result[31], Set, Overflow);


  assign Zero = (Result==0);

endmodule

