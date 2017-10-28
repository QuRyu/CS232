library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end testbench;

architecture one of testbench is 

  signal a, b, c, d, f:std_logic;
	
  component prime
  port(
    A:  IN STD_LOGIC;
    B:  IN STD_LOGIC;
    C:  IN STD_LOGIC; 
    D:  IN STD_LOGIC;
    F:  OUT STD_LOGIC
	 );
  end component;
  
begin 

A <= '0', '1' after 400 ns;
B <= '0', '1' after 200 ns, '0' after 400 ns, '1' after 600 ns; 
C <= '0', '1' after 100 ns, '0' after 200 ns, '1' after 300 ns, '0' after 400 ns, '1' after 500 ns, '0' after 600 ns, '1' after 700 ns;
D <= '0', '1' after 50 ns, '0' after 100 ns, '1' after 150 ns, '0' after 200 ns,'1' after 250 ns, '0' after 300 ns, '1' after 350 ns, '0' after 400 ns, '1' after 450 ns, '0' after 500 ns, '1' after 550 ns, '0' after 600 ns, '1' after 650 ns, '0' after 700 ns, '1' after 750 ns;
 
T0: prime port map(A, B, C, D, F);

end one; 
