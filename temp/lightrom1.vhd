library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightrom1 is 
    port (
        addr: in std_logic_vector (3 downto 0);
        data: out std_logic_vector (2 downto 0)
    );

end entity;


architecture rom of lightrom1 is 

begin 
     data <= 
      "000" when addr = "0000" else -- fil 0s         
      "101" when addr = "0001" else -- bit invert LR  
      "100" when addr = "0010" else -- sub 1 from LR  
      "100" when addr = "0011" else -- sub 1 from LR  
      "100" when addr = "0100" else -- sub 1 from LR  
      "001" when addr = "0101" else -- shift LR left  
      "111" when addr = "0110" else -- rotate LR left 
      "001" when addr = "0111" else -- shift LR right 
      "010" when addr = "1000" else -- shift LR left  
      "101" when addr = "1001" else -- bit invert LR  
      "100" when addr = "1010" else -- sub 1 from LR  
      "011" when addr = "1011" else -- add 1 to LR    
      "011" when addr = "1100" else -- add 1 to LR    
      "110" when addr = "1101" else -- rotate LR right
      "011" when addr = "1110" else -- add 1 to LR    
      "100";                        -- sub 1 from LR  

end rom;
