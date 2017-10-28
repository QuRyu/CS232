library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segment_display is 
  port(
    number : in std_logic_vector (4 downto 0); 
    Z : in std_logic; -- if the number is in two's complement form
    out1 : out std_logic_vector (6 downto 0); 
    out2 : out std_logic_vector (6 downto 0);
	 minus : out std_logic -- used in the third segment display
  );
end segment_display;

architecture display of segment_display is 

  component display_delegate is 
    port (
      A, B, C, D : in std_logic; 
      output : out std_logic_vector (6 downto 0);
      minus : in std_logic
    );
  signal minus_inverted : std_logic;
  signal minus_segment2 : std_logic; -- the segment display
  signal number1 : std_logic_vector (3 downto 0);
  signal number2 : std_logic_vector (3 downto 0);
  signal alwayOff : std_logic;
 
  
begin

alwayOff <= '0';
minus <= not(minus_inverted);
  
process (number, Z)
begin
  -- always remeber to clear the minus sign and number 1 and 2 
  minus_inverted <= '0'; -- don't change this line!
  minus_segment2 <= '0';
  number1 <= "0000";
  number2 <= "0000";
  
  if Z = '1' then  -- the number is in two's complement form
    if number(4) = '0' then -- number is positive 
      number1 <= number (3 downto 0);
    else           	 -- number is negative
	   -- check against the situation when number is "10000"; needs two segments! 
		if number = "10000" then 
		  minus_inverted <= '1'; -- minus sign of segment 3; don't change it, it's correct
		  number1 <= "0000";
		  number2 <= "0001";
		else 
        minus_segment2 <= '1';
		
		  -- TODO enumerate all the cases
		  case number(3 downto 0) is 
		    when "0000" => number1 <= "0000";
		    when "0001" => number1 <= "1111"; 
			 when "0010" => number1 <= "1110";
			 when "0011" => number1 <= "1101";
			 when "0100" => number1 <= "1100";
			 when "0101" => number1 <= "1011";
			 when "0110" => number1 <= "1010";
			 when "0111" => number1 <= "1001";
			 when "1000" => number1 <= "1000";
			 when "1001" => number1 <= "0111";
			 when "1010" => number1 <= "0110";
			 when "1011" => number1 <= "0101";
			 when "1100" => number1 <= "0100";
			 when "1101" => number1 <= "0011";
		    when "1110" => number1 <= "0010";
			 when "1111" => number1 <= "0001";
	      end case;
		end if;
    end if;
  else             -- the number is in plain form
    number1 <= number (3 downto 0);
    number2 <= "000" & number(4);
  end if;

end process;
    
delegate1 : display_delegate  -- display of number 1 
  port map (
    A => number1(3),
    B => number1(2), 
    C => number1(1),  
    D => number1(0), 
    minus => alwayOff,
    output => out1
);

delegate2 : display_delegate  -- display of number 2
  port map (
    A => number2(3), 
    B => number2(2),
    C => number2(1),
    D => number2(0), 
    minus => minus_segment2, 
    output => out2
);

end display;
  



