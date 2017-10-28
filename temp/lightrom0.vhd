library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightrom0 is 
    port (
        addr: in std_logic_vector (3 downto 0);
        data: out std_logic_vector (2 downto 0)
    );

end entity;


architecture rom of lightrom0 is 

begin 
     data <= 
      "000" when addr = "0000" else -- fil 0s         
      "101" when addr = "0001" else -- bit invert LR  
      "011" when addr = "0010" else -- add 1 to LR    
      "101" when addr = "0011" else -- bit invert LR  
      "100" when addr = "0100" else -- sub 1 from LR  
      "100" when addr = "0101" else -- sub 1 from LR  
      "111" when addr = "0110" else -- rotate LR left 
      "010" when addr = "0111" else -- shift LR left  
      "111" when addr = "1000" else -- rotate LR left 
      "011" when addr = "1001" else -- add 1 to LR    
      "010" when addr = "1010" else -- shift LR left  
      "011" when addr = "1011" else -- add 1 to LR    
      "111" when addr = "1100" else -- rotate LR left 
      "100" when addr = "1101" else -- sub 1 from LR  
      "101" when addr = "1110" else -- bit invert LR  
      "011";                        -- add 1 to LR    

end rom;
