library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity calculator is 
    port(
        clk       : in  std_logic;
        reset     : in  std_logic;
        b2        : in  std_logic;
        b3        : in  std_logic;
        b4        : in  std_logic;
        op        : in  std_logic_vector(1 downto 0);
        data      : in  std_logic_vector(7 downto 0);
        digit0    : out std_logic_vector(6 downto 0);
        digit1    : out std_logic_vector(6 downto 0);
        stackview : out std_logic_vector(3 downto 0)
    );
end entity;


architecture rtl of calculator is 

begin 

end rtl;
