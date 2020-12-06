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
// CREATED		"Mon Feb 10 11:35:29 2020"

module ALUBit31(
	a,
	b,
	Less,
	AInvert,
	BInvert,
	CarryIn,
	Operation1,
	Operation0,
	Result,
	Set,
	Overflow
);


input wire	a;
input wire	b;
input wire	Less;
input wire	AInvert;
input wire	BInvert;
input wire	CarryIn;
input wire	Operation1;
input wire	Operation0;
output wire	Result;
output wire	Set;
output wire	Overflow;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;

assign	Set = SYNTHESIZED_WIRE_16;




MUX2	b2v_inst(
	.S(AInvert),
	.A(a),
	.B(SYNTHESIZED_WIRE_0),
	.Y(SYNTHESIZED_WIRE_14));


OverflowDetection	b2v_inst1(
	.Op1(Operation1),
	.A(SYNTHESIZED_WIRE_14),
	.B(SYNTHESIZED_WIRE_15),
	.S(SYNTHESIZED_WIRE_16),
	.Overflow(Overflow));

assign	SYNTHESIZED_WIRE_0 =  ~a;


MUX2	b2v_inst3(
	.S(BInvert),
	.A(b),
	.B(SYNTHESIZED_WIRE_4),
	.Y(SYNTHESIZED_WIRE_15));

assign	SYNTHESIZED_WIRE_4 =  ~b;


MUX4	b2v_inst5(
	.O1(Operation1),
	.O0(Operation0),
	.A(SYNTHESIZED_WIRE_5),
	.B(SYNTHESIZED_WIRE_6),
	.C(SYNTHESIZED_WIRE_16),
	.D(Less),
	.Y(Result));

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_15 | SYNTHESIZED_WIRE_14;


OneBitAdder	b2v_inst8(
	.A(SYNTHESIZED_WIRE_14),
	.B(SYNTHESIZED_WIRE_15),
	.Cin(CarryIn),
	.s(SYNTHESIZED_WIRE_16)
	);

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_14 & SYNTHESIZED_WIRE_15;


endmodule
