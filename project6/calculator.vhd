library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity calculator is 
    port (
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

    component memram is 
        port (
            address : in  std_logic_vector(3 downto 0);
            clock   : in  std_logic;
            data    : in  std_logic_vector(7 downto 0);
            wren    : in  std_logic;
            q       : out std_logic_vector(7 downto 0)
        );
    end component;

    component segment_display is 
        port (
            input  : in  std_logic_vector(3 downto 0);
            output : out std_logic_vector(6 downto 0)
        );
    end component;

    constant value_0  : std_logic_vector(7 downto 0) := "00000000";

    signal stack_ptr  : unsigned(3 downto 0) := "0000";         
                            -- the pointer inside RAM to top locatiion
    signal RAM_input  : std_logic_vector(7 downto 0); -- data to be stored inside RAM
    signal RAM_output : std_logic_vector(7 downto 0); 
                            -- data read from RAM pointed by stack_ptr
    signal RAM_we     : std_logic := '0';                    -- whether to write data
    signal state      : std_logic_vector(3 downto 0) := "0000"; -- current state 
    signal MBR        : std_logic_vector(7 downto 0); -- memory buffer 
                            -- register, used to hold values moving to and from stack
    signal TEMPR      : std_logic_vector(7 downto 0); -- register
                            -- for holding values removed from stack

    -- slow down the clock
    signal counter    : unsigned(20 downto 0); 
    signal slowclk    : std_logic;

begin 

    stackview <= std_logic_vector(stack_ptr);
    
    process(reset, clk, b2, b3, b4) 
    begin 
        if reset = '0' then 
            stack_ptr  <= "0000";
            RAM_input  <= value_0;
            RAM_we     <= '0';
            state      <= "0000";
        elsif rising_edge(slowclk) then 
            case state is 
                when "0000" => -- wait state
                    if b2 = '0' then -- write input to MBR
                        state <= "1111";
                        MBR   <= data;
                    elsif b3 = '0' then -- push MBR to stack
                        state     <= "0001";
                        RAM_we    <= '1';
                        RAM_input <= MBR;
                    elsif b4 = '0' then -- execute operation
                        if not(stack_ptr = "0000") then 
                            stack_ptr <= stack_ptr - 1;
                        end if;
								state <= "0010";
                    end if;
                when "0001" => 
                    RAM_we    <= '0';
                    state     <= "1111";
                    if not(stack_ptr = "1111") then 
                        stack_ptr <= stack_ptr + 1;
                    end if;
                when "0010" => -- wait for retrieving value
                    state <= "0011";
                when "0011" => -- wait for retrieving value
                    state <= "0100";
                when "0100" => -- get value!
                    TEMPR <= RAM_output;
						  state <= "0101";
                when "0101" => -- execute arithmetic operations
                    case op is 
                        when "00" => -- add 
                            MBR <=
                           std_logic_vector(unsigned(MBR) + unsigned(TEMPR));
                        when "01" => -- minus 
                            MBR <= 
                           std_logic_vector(unsigned(MBR) - unsigned(TEMPR));
                        when "10" => -- times
                            MBR <= 
                           std_logic_vector(unsigned(MBR(3 downto 0)) *
                                            unsigned(TEMPR(3 downto 0)));
                        when "11" => -- divide
                            MBR <= 
                           std_logic_vector(unsigned(MBR(7 downto 0)) / 
														  unsigned(TEMPR(7 downto 0)));
                    end case;
						  state <= "1111";
                when others => -- state 1111
                    state <= "0000";
            end case;
        end if;


    end process;

    process(clk, reset) 
    begin 
        if reset = '0' then 
            counter <= "000000000000000000000";
        elsif rising_edge(clk) then 
            counter <= counter + 1;
        end if;
    end process;

    slowclk <= std_logic(counter(20));


RAM : memram 
    port map (std_logic_vector(stack_ptr), clk, RAM_input, RAM_we, RAM_output);

segment0 : segment_display 
    port map (MBR(3 downto 0), digit0);

segment1 : segment_display
    port map (MBR(7 downto 4), digit1);

end rtl;
