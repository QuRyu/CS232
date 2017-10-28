-- Qingbo Liu
-- test linear shift register 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifttest is 
end entity;


architecture test of shifttest is 
    
    component shift is 
        port (
            start : in  std_logic;
            count : out unsigned (27 downto 0)
        );
    end component;

    signal start : std_logic;
    signal count : unsigned (27 downto 0);

begin 

start <= '0', '1' after 100 ns, '0' after 105 ns, '1' after 150 ns, '0'
after 155 ns, '1' after 200 ns, '0' after 205 ns;


shift0 : shift 
    port map (
        start => start, 
        count => count
);

end test;
