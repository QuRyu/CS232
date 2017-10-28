library ieee;
use ieee.std_logic_1164.all;

entity segment_display is 
	port (A, B, C, D : in std_logic; -- input
         E, F, G, H, I, J, K : out std_logic); -- segment 
end segment_display;

architecture display of segment_display is

begin 
	
process (A, B, C, D)
  variable input : std_logic_vector (3 downto 0); 
begin 
	input := A & B & C & D;
	E <= '1'; 
	F <= '1';
	G <= '1';
	H <= '1';
	I <= '1';
	J <= '1';
	K <= '1';

	case input is 
		when "0000" => -- 0
                        E <= '0';
                        F <= '0';
                        G <= '0';
                        H <= '0'; 
                        I <= '0'; 
                        J <= '0';
		when "0001" => -- 1 
			F <= '0';
			G <= '0';
		when "0010" => -- 2
			E <= '0';
			F <= '0';
			K <= '0';
			I <= '0';
			H <= '0';
		when "0011" => -- 3 
			E <= '0';
			F <= '0';
			G <= '0';
			H <= '0';
			K <= '0';
		when "0100" => -- 4 
			F <= '0';
			G <= '0';
			J <= '0';
			K <= '0';
		when "0101" => -- 5
			E <= '0';
			G <= '0';
                        H <= '0';
			J <= '0';
			K <= '0';
		when "0110" => -- 6
			E <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
		when "0111" => -- 7
			E <= '0';
			F <= '0';
			G <= '0';
		when "1000" => -- 8
			E <= '0';
			F <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
		when "1001" => -- 9
			E <= '0';
			F <= '0';
			G <= '0';
			J <= '0';
			K <= '0';
		when "1010" => -- 10 
			E <= '0';
			F <= '0';
			G <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
		when "1011" => -- 11 
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
		when "1100" => -- 12 
			E <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
		when "1101" => -- 13
			F <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
                        K <= '0';
		when "1110" => -- 14
			E <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
		when "1111" => -- 15
			E <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
		end case;
end process;


end display;
