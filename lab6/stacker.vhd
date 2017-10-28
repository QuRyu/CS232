library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stacker is 
    port (
        reset     : in std_logic;
        clk       : in std_logic;
        data      : in std_logic_vector(3 downto 0);
        b2        : in std_logic;
        b3        : in std_logic;
        b4        : in std_logic;
        value     : out std_logic_vector(3 downto 0);
        stackview : out std_logic_vector(3 downto 0);
        stateview : out std_logic_vector(2 downto 0)
    );

end entity;

architecture rtl of stacker is 

    component memram is 
        port (
            address : in std_logic_vector(3 downto 0);
            clock   : in std_logic;
            data    : in std_logic_vector(3 downto 0);
            wren    : in std_logic;
            q       : out std_logic_vector(3 downto 0)
        );
    end component;

    signal RAM_input  : std_logic_vector(3 downto 0);
    signal RAM_output : std_logic_vector(3 downto 0);
    signal RAM_we     : std_logic;
    signal stack_ptr  : unsigned(3 downto 0);
    signal MBR        : std_logic_vector(3 downto 0);
    signal state      : std_logic_vector(2 downto 0);
    
begin 

value <= MBR;
stackview <= std_logic_vector(stack_ptr);
stateview <= state;

process(clk, reset)
begin 
    if reset = '0' then 
        stack_ptr <= "0000";
        RAM_input <= "0000";
        RAM_we    <= '0';
        state     <= "000";
    elsif rising_edge(clk) then 
        case state is 
            when "000" =>
                if b2 = '0' then 
                    MBR <= data;
                    state <= "111";
                elsif b3 = '0' then 
                    RAM_input <= MBR;
                    RAM_we <= '0';
                    state <= "001";
                elsif b4 = '0' and not(stack_ptr = "0000") then 
                    stack_ptr <= stack_ptr - 1;
                    state <= "110";
                end if;
            when "001" =>
                RAM_we <= '0';
                stack_ptr <= stack_ptr + 1;
            when "100" =>
                state <= "101";
            when "101" =>
                state <= "110";
            when "110" => 
                MBR <= RAM_output;
            when "111" => 
                if b2 = '1' and b3 = '1' and b4 = '1' then 
                    state <= "000";
                end if;
            when others => 
                state <= "000";
			end case;
    end if;

end process;
RAM : memram 
    port map(std_logic_vector(stack_ptr), clk, RAM_input, RAM_we, RAM_output);

end rtl;
