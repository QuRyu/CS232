library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightrom is 
    port (
        addr: in std_logic_vector (4 downto 0);
        data: out std_logic_vector (4 downto 0)
    );

end entity;


architecture rom of lightrom is 

begin 
     data <= 
      "00000" when addr = "00000" else -- fil 0s         
      "00101" when addr = "00001" else -- bit invert LR  
      "00100" when addr = "00010" else -- sub 1 from LR  
      "00100" when addr = "00011" else -- sub 1 from LR  
      "00100" when addr = "00100" else -- sub 1 from LR  
      "00001" when addr = "00101" else -- shift LR left  
      "00111" when addr = "00110" else -- rotate LR left 
      "00001" when addr = "00111" else -- shift LR right 
      "00010" when addr = "01000" else -- shift LR left  
      "00101" when addr = "01001" else -- bit invert LR  
      "00100" when addr = "01010" else -- sub 1 from LR  
      "00011" when addr = "01011" else -- add 1 to LR    
      "00011" when addr = "01100" else -- add 1 to LR    
      "00110" when addr = "01101" else -- rotate LR right
      "00011" when addr = "01110" else -- add 1 to LR    
      "00100" when addr = "01111" else -- sub 1 from LR  
      "00100" when addr = "10000" else -- sub 1 from LR  
      "00100" when addr = "10001" else -- sub 1 from LR  
      "00100" when addr = "10010" else -- sub 1 from LR  
      "00100" when addr = "10011" else -- sub 1 from LR  
      "00100" when addr = "10100" else -- sub 1 from LR  
      "00100" when addr = "10101" else -- sub 1 from LR  
      "00100" when addr = "10110" else -- sub 1 from LR  
      "00101" when addr = "10111" else -- sub 1 from LR  
      "00100" when addr = "11000" else -- sub 1 from LR  
      "00100" when addr = "11001" else -- sub 1 from LR  
      "00100" when addr = "11010" else -- sub 1 from LR  
      "00100" when addr = "11011" else -- sub 1 from LR  
      "00100" when addr = "11100" else -- sub 1 from LR  
      "00100" when addr = "11101" else -- sub 1 from LR  
      "00100" when addr = "11110" else -- sub 1 from LR  
      "00001";                         -- shift LR right 

end rom;
