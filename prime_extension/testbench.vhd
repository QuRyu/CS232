library ieee; 
use ieee.std_logic_1164.all;

entity testbench is 
end entity;

architecture test of testbench is 
  signal A, B, C, D, E, F, G  : std_logic;
  signal T : std_logic := '1';

  component prime 
  port( 
    A : in std_logic; 
    B : in std_logic;
    C : in std_logic;
    D : in std_logic; 
    E : in std_logic; 
    F : in std_logic; 
    T : in std_logic; 
    G : out std_logic
  ); 
  end component; 

begin 
 
  A <= '1'; 
  B <= '1';
  C <= '1'; 
  D <= '1';
  E <= '0';
  F <= '0';

  for i in 1 to 64 loop 
    F <= not F; 
    wait for 50 ns; 
  end loop;

  for i in 1 to 32 loop 
    E <= not E; 
    wait for 100 ns; 
  end loop;

T0: task port map(A, B, C, D, E, F, T, G);

end test;
