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
// CREATED		"Thu Mar 12 18:21:40 2020"

module OverflowDetection(
	Op1,
	A,
	B,
	S,
	Overflow
);


input wire	Op1;
input wire	A;
input wire	B;
input wire	S;
output wire	Overflow;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;




assign	SYNTHESIZED_WIRE_2 =  ~A;

assign	SYNTHESIZED_WIRE_3 =  ~B;

assign	SYNTHESIZED_WIRE_4 =  ~S;

assign	Overflow = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1;

assign	SYNTHESIZED_WIRE_1 = Op1 & SYNTHESIZED_WIRE_2 & SYNTHESIZED_WIRE_3 & S;

assign	SYNTHESIZED_WIRE_0 = Op1 & A & B & SYNTHESIZED_WIRE_4;


endmodule
