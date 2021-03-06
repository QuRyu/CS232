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
-- CREATED		"Mon Sep 18 19:11:12 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY prime_extension IS 
	PORT
	(
		A :  IN  STD_LOGIC;
		B :  IN  STD_LOGIC;
		C :  IN  STD_LOGIC;
		D :  IN  STD_LOGIC;
		E :  IN  STD_LOGIC;
		F :  IN  STD_LOGIC;
		T :  IN  STD_LOGIC;
		G :  OUT  STD_LOGIC
	);
END prime_extension;

ARCHITECTURE bdf_type OF prime_extension IS 

ATTRIBUTE black_box : BOOLEAN;
ATTRIBUTE noopt : BOOLEAN;

COMPONENT and5_0
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_0: COMPONENT IS true;
ATTRIBUTE noopt OF and5_0: COMPONENT IS true;

COMPONENT and5_1
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_1: COMPONENT IS true;
ATTRIBUTE noopt OF and5_1: COMPONENT IS true;

COMPONENT and5_2
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_2: COMPONENT IS true;
ATTRIBUTE noopt OF and5_2: COMPONENT IS true;

COMPONENT and5_3
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_3: COMPONENT IS true;
ATTRIBUTE noopt OF and5_3: COMPONENT IS true;

COMPONENT and5_4
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_4: COMPONENT IS true;
ATTRIBUTE noopt OF and5_4: COMPONENT IS true;

COMPONENT and5_5
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_5: COMPONENT IS true;
ATTRIBUTE noopt OF and5_5: COMPONENT IS true;

COMPONENT and5_6
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_6: COMPONENT IS true;
ATTRIBUTE noopt OF and5_6: COMPONENT IS true;

COMPONENT and5_7
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_7: COMPONENT IS true;
ATTRIBUTE noopt OF and5_7: COMPONENT IS true;

COMPONENT and5_8
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_8: COMPONENT IS true;
ATTRIBUTE noopt OF and5_8: COMPONENT IS true;

COMPONENT and5_9
	PORT(IN3 : IN STD_LOGIC;
		 IN2 : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC;
		 IN5 : IN STD_LOGIC;
		 IN4 : IN STD_LOGIC;
		 OUT : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF and5_9: COMPONENT IS true;
ATTRIBUTE noopt OF and5_9: COMPONENT IS true;

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
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_33 :  STD_LOGIC;


BEGIN 



SYNTHESIZED_WIRE_28 <= NOT(A);



SYNTHESIZED_WIRE_29 <= NOT(C);



SYNTHESIZED_WIRE_0 <= NOT(D);



b2v_inst12 : and5_0
PORT MAP(IN3 => SYNTHESIZED_WIRE_0,
		 IN2 => SYNTHESIZED_WIRE_1,
		 IN1 => SYNTHESIZED_WIRE_2,
		 IN5 => F,
		 IN4 => E,
		 OUT => SYNTHESIZED_WIRE_17);


SYNTHESIZED_WIRE_5 <= NOT(A);



SYNTHESIZED_WIRE_4 <= NOT(B);



SYNTHESIZED_WIRE_3 <= NOT(E);



b2v_inst16 : and5_1
PORT MAP(IN3 => SYNTHESIZED_WIRE_3,
		 IN2 => SYNTHESIZED_WIRE_4,
		 IN1 => SYNTHESIZED_WIRE_5,
		 IN5 => F,
		 IN4 => D,
		 OUT => SYNTHESIZED_WIRE_22);


b2v_inst17 : and5_2
PORT MAP(IN3 => SYNTHESIZED_WIRE_6,
		 IN2 => SYNTHESIZED_WIRE_7,
		 IN1 => SYNTHESIZED_WIRE_8,
		 IN5 => F,
		 IN4 => B,
		 OUT => SYNTHESIZED_WIRE_21);


SYNTHESIZED_WIRE_8 <= NOT(A);



SYNTHESIZED_WIRE_7 <= NOT(C);



SYNTHESIZED_WIRE_30 <= NOT(C);



SYNTHESIZED_WIRE_6 <= NOT(D);



b2v_inst21 : and5_3
PORT MAP(IN3 => D,
		 IN2 => B,
		 IN1 => SYNTHESIZED_WIRE_9,
		 IN5 => F,
		 IN4 => E,
		 OUT => SYNTHESIZED_WIRE_20);


SYNTHESIZED_WIRE_9 <= NOT(A);



b2v_inst23 : and5_4
PORT MAP(IN3 => C,
		 IN2 => B,
		 IN1 => SYNTHESIZED_WIRE_10,
		 IN5 => F,
		 IN4 => D,
		 OUT => SYNTHESIZED_WIRE_24);


SYNTHESIZED_WIRE_10 <= NOT(E);



b2v_inst25 : and5_5
PORT MAP(IN3 => A,
		 IN2 => SYNTHESIZED_WIRE_11,
		 IN1 => SYNTHESIZED_WIRE_12,
		 IN5 => F,
		 IN4 => D,
		 OUT => SYNTHESIZED_WIRE_23);


SYNTHESIZED_WIRE_12 <= NOT(C);



SYNTHESIZED_WIRE_11 <= NOT(E);



b2v_inst28 : and5_6
PORT MAP(IN3 => A,
		 IN2 => SYNTHESIZED_WIRE_13,
		 IN1 => SYNTHESIZED_WIRE_14,
		 IN5 => F,
		 IN4 => C,
		 OUT => SYNTHESIZED_WIRE_25);


SYNTHESIZED_WIRE_14 <= NOT(B);



SYNTHESIZED_WIRE_33 <= NOT(D);



SYNTHESIZED_WIRE_13 <= NOT(D);



b2v_inst31 : and5_7
PORT MAP(IN3 => E,
		 IN2 => A,
		 IN1 => SYNTHESIZED_WIRE_15,
		 IN5 => F,
		 IN4 => C,
		 OUT => SYNTHESIZED_WIRE_27);


SYNTHESIZED_WIRE_15 <= NOT(B);



b2v_inst33 : and5_8
PORT MAP(IN3 => C,
		 IN2 => A,
		 IN1 => SYNTHESIZED_WIRE_16,
		 IN5 => F,
		 IN4 => E,
		 OUT => SYNTHESIZED_WIRE_26);


SYNTHESIZED_WIRE_16 <= NOT(D);



G <= SYNTHESIZED_WIRE_17 OR SYNTHESIZED_WIRE_18 OR SYNTHESIZED_WIRE_19 OR SYNTHESIZED_WIRE_20 OR SYNTHESIZED_WIRE_21 OR SYNTHESIZED_WIRE_22 OR SYNTHESIZED_WIRE_23 OR SYNTHESIZED_WIRE_24 OR SYNTHESIZED_WIRE_25 OR SYNTHESIZED_WIRE_26 OR SYNTHESIZED_WIRE_27 OR T;


SYNTHESIZED_WIRE_19 <= SYNTHESIZED_WIRE_28 AND SYNTHESIZED_WIRE_29 AND E AND F;


SYNTHESIZED_WIRE_31 <= NOT(B);



SYNTHESIZED_WIRE_32 <= NOT(A);



b2v_inst7 : and5_9
PORT MAP(IN3 => SYNTHESIZED_WIRE_30,
		 IN2 => SYNTHESIZED_WIRE_31,
		 IN1 => SYNTHESIZED_WIRE_32,
		 IN5 => E,
		 IN4 => SYNTHESIZED_WIRE_33,
		 OUT => SYNTHESIZED_WIRE_18);


SYNTHESIZED_WIRE_2 <= NOT(A);



SYNTHESIZED_WIRE_1 <= NOT(B);



END bdf_type;