-- Qingbo Liu
-- linear shift register

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity shift is 

    port (
        start : in  std_logic;
        count : out unsigned(27 downto 0)
    );

end entity;


architecture sh of shift is 

    signal bit            : unsigned (27 downto 0);
    signal count_internal : unsigned (27 downto 0) :=
"1010011010101011110011100001"; -- seed 

begin

    count <= count_internal;

    process (start)
    begin 
        if start = '1' then
            -- shift the bits 
            bit <= (shift_right(count_internal, 0) xnor 
                    shift_right(count_internal, 3)) and 
                   "0000000000000000000000000001";
            count_internal <= shift_right(count_internal, 1) or 
                              shift_left(bit, 27);
        end if;
    end process;

end sh;


