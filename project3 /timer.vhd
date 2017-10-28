library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is

    port (
        clk      : in   std_logic;
        start	  : in	std_logic;
        reset    : in	std_logic;
        react    : in   std_logic;
        mstime   : out	std_logic_vector (7 downto 0); -- current record
        red      : out  std_logic; 
        green    : out  std_logic;
        mintime  : out  std_logic_vector (7 downto 0); -- fastest record
        record_reset : in std_logic
    );

end entity;

architecture rtl of timer is

    -- Build an enumerated type for the state machine
    type state_type is (sIdle, sWait, sCount);

    -- Register to hold the current state
    signal state : state_type := sIdle;

    -- counter 
    constant count_0 : unsigned := "0000000000000000000000000000";
    constant count_n : unsigned := "1100000000000000000000111000";
    constant count_1 : unsigned := "1111111111111111111111111111";
    signal count : unsigned (27 downto 0) := count_0;

    -- min time record
    signal min : unsigned (27 downto 0) := count_1; -- record the
fastest record
    signal mintime_internal : std_logic_vector (7 downto 0) :=
"00000000"; -- connect to mintime, set here only because I do not know
how to initialize the value of the output signal 
    signal changed : std_logic := '0'; -- signal if the fastest record
should be changed

    -- shift register 
    signal wait_time : unsigned (27 downto 0); -- output from linear
shift register
 
    component shift is 
        port (
            start : in  std_logic;
            count : out unsigned (27 downto 0)
        );
    end component;

begin

	mintime <= mintime_internal;
	
	-- Logic to advance to the next state
    process (clk, reset, start, react)
    begin
        if reset = '1' then
            state <= sIdle;
            count <= count_0;
        elsif (rising_edge(clk)) then 
            case state is 
                when sIdle => 
                    if start = '1' then 
                        state <= sWait; 
                        count <= wait_time;
                    end if;
                when sWait => 
                    if react = '1' then 
                        state <= sIdle; 
                        count <= count_1;
                    elsif count = count_0 then
                        state <= sCount; 
                    else
                        count <= count + 1;
                    end if;
                when sCount => 
                    if react = '1' then 
                        state <= sIdle;
                        if count < min then -- test if the fastest
record should be changed
                            changed <= '1';
                            min <= count;
                        end if;
                    else 
                        count <= count + 1;
                    end if;
            end case;

            if record_reset = '1' then -- clear the fastest record
                mintime_internal <= "00000000"; 
                min <= count_1;
                changed <= '0';
            elsif changed = '1' then -- change the fastest record
                mintime_internal <= std_logic_vector (min (23 downto 16));
                changed <= '0';
            end if;
        end if;
		
    end process;

	 

    green <= '1' when state = sCount else '0';
    red   <= '1' when state = sWait else '0';
    mstime <= "00000000" when state = sWait else std_logic_vector(count(23 downto 16));
    
shift0 : shift 
    port map (
        start => start,
        count => wait_time
); 
end rtl;
