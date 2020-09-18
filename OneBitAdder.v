
// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 15.0.0 Build 145 04/22/2015 SJ Web Edition"
// CREATED		"Wed Oct  4 19:27:08 2017"

module OneBitAdder(
	A,
	B,
	Cin,
	s,
	Cout
);


input wire	A;
input wire	B;
input wire	Cin;
output wire	s;
output wire	Cout;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;




assign	SYNTHESIZED_WIRE_8 = A & B;

assign	SYNTHESIZED_WIRE_7 = SYNTHESIZED_WIRE_0 & Cin;

assign	SYNTHESIZED_WIRE_4 =  ~SYNTHESIZED_WIRE_13;

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_13 & SYNTHESIZED_WIRE_3;

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_4 & B;

assign	s = SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_6;

assign	SYNTHESIZED_WIRE_0 = B | A;

assign	Cout = SYNTHESIZED_WIRE_7 | SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_9 =  ~A;

assign	SYNTHESIZED_WIRE_10 =  ~Cin;

assign	SYNTHESIZED_WIRE_12 = SYNTHESIZED_WIRE_9 & Cin;

assign	SYNTHESIZED_WIRE_11 = A & SYNTHESIZED_WIRE_10;

assign	SYNTHESIZED_WIRE_13 = SYNTHESIZED_WIRE_11 | SYNTHESIZED_WIRE_12;

assign	SYNTHESIZED_WIRE_3 =  ~B;


endmodule
