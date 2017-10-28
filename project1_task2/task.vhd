-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 32-bit"
-- VERSION		"Version 12.1 Build 177 11/07/2012 SJ Full Version"
-- CREATED		"Sun Sep 17 21:55:42 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY task IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		enable :  IN  STD_LOGIC;
		NSR :  OUT  STD_LOGIC;
		NSY :  OUT  STD_LOGIC;
		EWR :  OUT  STD_LOGIC;
		EWG :  OUT  STD_LOGIC;
		EWY :  OUT  STD_LOGIC;
		NSG :  OUT  STD_LOGIC
	);
END task;

ARCHITECTURE bdf_type OF task IS 

COMPONENT counter
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	A :  STD_LOGIC;
SIGNAL	B :  STD_LOGIC;
SIGNAL	C :  STD_LOGIC;
SIGNAL	D :  STD_LOGIC;
SIGNAL	q :  STD_LOGIC;
SIGNAL	q0 :  STD_LOGIC;
SIGNAL	q1 :  STD_LOGIC;
SIGNAL	q2 :  STD_LOGIC;
SIGNAL	q3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;


BEGIN 



SYNTHESIZED_WIRE_21 <= NOT(B);



SYNTHESIZED_WIRE_1 <= NOT(C);



SYNTHESIZED_WIRE_2 <= NOT(A);



SYNTHESIZED_WIRE_8 <= SYNTHESIZED_WIRE_0 AND SYNTHESIZED_WIRE_1 AND D;


SYNTHESIZED_WIRE_9 <= NOT(A);



SYNTHESIZED_WIRE_3 <= NOT(C);



SYNTHESIZED_WIRE_6 <= SYNTHESIZED_WIRE_2 AND SYNTHESIZED_WIRE_3 AND B;


SYNTHESIZED_WIRE_4 <= NOT(A);



SYNTHESIZED_WIRE_5 <= NOT(B);



SYNTHESIZED_WIRE_7 <= SYNTHESIZED_WIRE_4 AND SYNTHESIZED_WIRE_5 AND C;


NSG <= SYNTHESIZED_WIRE_6 OR SYNTHESIZED_WIRE_7 OR SYNTHESIZED_WIRE_8;

B <= q1;



NSY <= SYNTHESIZED_WIRE_9 AND B AND C;


SYNTHESIZED_WIRE_14 <= NOT(A);



SYNTHESIZED_WIRE_10 <= NOT(B);



SYNTHESIZED_WIRE_11 <= NOT(C);



SYNTHESIZED_WIRE_12 <= NOT(D);



SYNTHESIZED_WIRE_13 <= SYNTHESIZED_WIRE_10 AND SYNTHESIZED_WIRE_11 AND SYNTHESIZED_WIRE_12;


EWR <= SYNTHESIZED_WIRE_13 OR SYNTHESIZED_WIRE_14;


SYNTHESIZED_WIRE_18 <= NOT(C);



EWG <= SYNTHESIZED_WIRE_15 OR SYNTHESIZED_WIRE_16 OR SYNTHESIZED_WIRE_17;

C <= q2;



SYNTHESIZED_WIRE_17 <= SYNTHESIZED_WIRE_18 AND A AND B;


SYNTHESIZED_WIRE_19 <= NOT(C);



SYNTHESIZED_WIRE_15 <= SYNTHESIZED_WIRE_19 AND A AND D;


SYNTHESIZED_WIRE_20 <= NOT(B);



SYNTHESIZED_WIRE_16 <= SYNTHESIZED_WIRE_20 AND A AND C;


EWY <= A AND B AND C;

D <= q3;



b2v_inst40 : counter
PORT MAP(clk => clk,
		 reset => reset,
		 enable => enable);

A <= q0;



SYNTHESIZED_WIRE_22 <= NOT(C);



SYNTHESIZED_WIRE_23 <= NOT(D);



SYNTHESIZED_WIRE_24 <= SYNTHESIZED_WIRE_21 AND SYNTHESIZED_WIRE_22 AND SYNTHESIZED_WIRE_23;


NSR <= SYNTHESIZED_WIRE_24 OR A;


SYNTHESIZED_WIRE_0 <= NOT(A);



END bdf_type;