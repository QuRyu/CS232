library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity calculator is 
    port(
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

    constant value_0  : std_logic_vecotr(7 downto 0) := "00000000";

    signal stack_ptr  : unsigned(3 downto 0);         
                            -- the pointer inside RAM to top locatiion
    signal RAM_input  : std_logic_vector(7 downto 0); -- data to be stored inside RAM
    signal RAM_output : std_logic_vector(7 downto 0); 
                            -- data read from RAM pointed by stack_ptr
    signal RAM_we     : std_logic;                    -- whether to write data
    signal state      : std_logic_vector(3 downto 0); -- current state 
    signal MBR        : std_logic_vector(7 downto 0); -- memory buffer 
                            -- register, used to hold values moving to and from stack
    signal TEMPR      : std_logic_vector(7 downto 0); -- register
                            -- for holding values removed from stack

begin 

    value <= MBR;
    stackview <= std_logic_vector(stack_ptr);
    stateview <= state;
    
    process(reset, clk, b2, b3, b4) 
    begin 
        if reset = '0' then 
            stack_ptr  <= "0000";
            RAM_input  <= value_0;
            RAM_output <= value_0;
            RAM_we     <= '0';
            state      <= "0000";
        elsif rising_edge(clk) then 

        end if;


    end process;


RAM : memram 
    port map (std_logic_vector(stack_ptr), clk, RAM_input, RAM_we, RAM_output);
end rtl;
