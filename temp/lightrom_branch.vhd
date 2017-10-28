library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightrom is 
    port (
        addr: in std_logic_vector (3 downto 0);
        data: out std_logic_vector (3 downto 0)
    );

end entity;


architecture rom of lightrom is 

begin 
    data <= 
      "0000" when addr = "0000" else -- fil 0s         
      "0101" when addr = "0001" else -- bit invert LR  
      "0101" when addr = "0010" else -- bit invert LR 
      "0101" when addr = "0011" else -- bit invert LR 
      "0101" when addr = "0100" else -- bit invert LR 
      "0101" when addr = "0101" else -- bit invert LR 
      "0101" when addr = "0110" else -- bit invert LR 
      "0101" when addr = "0111" else -- bit invert LR 
      "0101" when addr = "1000" else -- bit invert LR 
      "0101" when addr = "1001" else -- bit invert LR 
      "0101" when addr = "1010" else -- bit invert LR 
      "0101" when addr = "1011" else -- bit invert LR 
      "0001" when addr = "1100" else -- right shift
      "1000" when addr = "1101" else -- conditional jump
      "0011" when addr = "1110" else -- add 1 to LR
      "0011";                        -- add 1 to LR


end rom;
