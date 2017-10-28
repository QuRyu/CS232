-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity bright is

	port(
          buttonOne, buttonTwo, buttonThree : in std_logic;
          reset : in std_logic;
          redLED : out std_logic_vector (2 downto 0);
          greenLED : out std_logic
	);

end entity;

architecture rtl of bright is 

	-- Build an enumerated type for the state machine
	type state_type is (sIdle, sOne, sTwo, sThree);

	-- Register to hold the current state
	signal state : state_type;
  
       

begin

	-- Logic to advance to the next state
	process (buttonOne, buttonTwo, buttonThree, reset)
	begin
			if reset = '1' then 
				state <= sIdle;
			end if;

			case state is
				when sIdle =>
					if buttonOne = '1' then   
						state <= sOne;
					end if;
				when sOne => 
			                if buttonTwo = '1' then 
						state <= sTwo;
					elsif buttonThree = '1' then 
						state <= sIdle;
					end if;
				when sTwo => 
					if buttonOne = '1' then 
						state <= sIdle;
					elsif buttonThree = '1' then 
						state <= sThree;
					end if;
				when sThree =>
					if buttonOne = '1' or buttonTwo = '1' then 
						state <= sIdle;
					end if;
			end case;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when sIdle => 
                                redLED <= "001";
                                greenLED <= '0';
			when sOne =>
				redLED <= "010";
			when sTwo =>
                                redLED <= "100";
			when sThree =>
				redLED <= "000";
                                greenLED <= '1';
		end case;
	end process;

end rtl;
