-- Qingbo Liu
-- main file

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator is 
    port (
        clock     : in std_logic;
        reset     : in std_logic;
        b2        : in std_logic;  -- move data to MBR
        b3        : in std_logic;  -- push MBR to stack
        b4        : in std_logic;  -- pop data from stack and compute
        op        : in std_logic_vector(1 downto 0);
        data      : in std_logic_vector(7 downto 0);
        digit0    : in std_logic_vector(6 downto 0);
        digit1    : in std_logic_vector(6 downto 0);
        stackview : in std_logic_vector(3 downto 0)
    );
end entity;
        
architecture cal of calculator is 

    component memram is 
        port (
            address : in std_logic_vector(3 downto 0);
            clock   : in std_logic;
            data    : in std_logic_vector(7 downto 0);
            wren    : in std_logic;
            q       : out std_logic_vector(7 downto 0)
        );
    end component;

    -- memory buffer register 
    signal MBR : std_logic_vector(7 downto 0);

    -- signals for RAM
    signal RAM_we     : std_logic;
    signal RAM_input  : std_logic_vector(7 downto 0);
    signal RAM_output : std_logic_vector(7 downto 0);
    signal stack_ptr  : unsigned(3 downto 0);

    -- store values poped from stack
    signal TEMPR : std_logic_vector(7 downto 0);

    -- the state of execution 
    signal state : std_logic_vector(3 downto 0);

begin 

    process(clock, reset, b2, b3, b4)
    begin 
        if reset = '0' then 
            stack_ptr <= "0000";
            RAM_we    <= '0';
            RAM_input <= "00000000";
            state     <= "0000";
            MBR       <= "00000000";
        elsif rising_edge(clock) then 
            case state is 
                when "0000" => 
                    if b2 = '0' then -- move data to MBR
                        MBR <= data;
                        state <= "1111";
                    elsif b3 = '0' then -- push MBR to stack
                        RAM_we    <= '1';
                        RAM_input <= MBR;
                        state     <= "0001";
                    elsif b4 = '0' then  -- pop data from stack and computes
                        if stack_ptr /= "0000" then 
                            stack_ptr <= stack_ptr - 1;
                        end if;
                        state <= "0010";
                    end if;
                when "0001" => 
                    RAM_we <= '0';
                    state  <= "1111";
                when "0010" => -- wait for retrieving data from memory 
                    state <= "0011";
                when "0011" => -- wait for retrieving data from memory
                    state <= "0101";
                when "0100" => -- get the value!
                    TEMPR <= RAM_output;
                    state <= "0101";
                when "0101" => -- computes!
                    case op is 
                        when "00" => -- addition
                            MBR <= std_logic_vector(unsigned(MBR) + unsigned(TEMPR));
                        when "01" => -- subtraction
                            MBR <= std_logic_vector(unsigned(MBR) - unsigned(TEMPR));
                        when "10" => -- multiplication
                            MBR <= std_logic_vector(unsigned(MBR(3 downto 0)) * 
                                     unsigned(TEMPR(3 downto 0)));
                        when others => -- division
                            MBR <= std_logic_vector(unsigned(MBR) / unsigned(TEMPR));
                    end case;
                    state <= "1111";
                when others => -- final state
                    state <= "0000";
            end case;
        end if;
    end process;

RAM : memram 
    port map (std_logic_vector(stack_ptr), clock, RAM_input, RAM_we, RAM_output);
end cal;
