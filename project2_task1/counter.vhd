library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
  port( 
    clk    : in std_logic; 
    reset  : in std_logic; 
    q      : out std_logic_vector (7 downto 0)
  );

end entity; 

architecture rtl of counter is 
  
  signal cnt : unsigned (7 downto 0);

begin 

process (clk) 

begin 

  if reset = '1' then 
    cnt <= "00000000"; 
  elsif (rising_edge(clk)) then 
    cnt <= cnt + 1;
  end if;
  

end process;

  q <= std_logic_vector(cnt);

end rtl;
    
