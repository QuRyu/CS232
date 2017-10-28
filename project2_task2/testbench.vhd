library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end entity;

architecture test of testbench is 
  component main is 
    port (
       A, B, C, D : in std_logic; 
       E, F, G, H : in std_logic;
       Z : in std_logic; 
       out1 : out std_logic_vector (6 downto 0);
       out2 : out std_logic_Vector (6 downto 0);
    );
  end component;
    
  signal A, B, C, D : in std_logic; 
  signal E, F, G, H : in std_logic;
  signal Z : in std_logic; 
  signal out1 : out std_logic_vector (6 downto 0);
  signal out2 : out std_logic_Vector (6 downto 0);

begin 

process 
begin 

  

end process;

m : main 
  port map (
    A => A, 
    B => B, 
    C => C, 
    D => D, 
    E => E,  
    F => F, 
    G => G, 
    H => H, 
    Z => Z, 
    out1 => out1, 
    out2 => out2
);

end test;
