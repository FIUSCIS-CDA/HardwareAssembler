
module ALUBits0To30 (Ainvert, Binvert, CarryIn, Op1, Op0, a, b, Less, Result, CarryOut);
  input Ainvert, Binvert, CarryIn;
  input Op1, Op0;
  input a, b, Less;

  output Result, CarryOut;

  wire amuxout, bmuxout, S;

  MUX2 aInv(a, ~a, Ainvert, amuxout);
  MUX2 bInv(b, ~b, Binvert, bmuxout);
  OneBitAdder add(amuxout, bmuxout, CarryIn, S, CarryOut);
  MUX4 res(amuxout & bmuxout, amuxout | bmuxout, S, Less, Op1, Op0, Result);

endmodule