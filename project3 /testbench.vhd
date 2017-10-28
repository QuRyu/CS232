library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench is 
end entity;

architecture test of testbench is 
    component reaction is 
        port (
            clk      : in  std_logic;
            start    : in  std_logic;
            reset    : in  std_logic;
            react    : in  std_logic;
            red      : out std_logic;
            green    : out std_logic;
            segment0 : out std_logic_vector (6 downto 0);
            segment1 : out std_logic_vector (6 downto 0)
        );
    end component;

    constant num_cycles : integer := 500;
    signal segment0, segment1 : std_logic_vector (6 downto 0);
    signal clk : std_logic := '1';
    signal react : std_logic := '1';
    signal start, reset, red, green : std_logic;
    
    signal n : unsigned (1 downto 0) := "00";

begin 

start <= '1', '0' after 100 ns, '1' after 200 ns, '0' after 800 ns, '1'
after 900 ns, '0' after 1300 ns, '1' after 1400 ns;

reset <= '1', '0' after 700 ns, '1' after 710 ns;

process 
begin 

    wait until green = '1';
    if not (n = "10") then 
    wait for 200 ns;
    react <= '0';
    wait for 100 ns;
    react <= '1';
    n <= n + 1;
    end if;

    wait until red = '1';
    if n = "10" then 
        wait for 20 ns;
        react <= '0';
        wait for 100 ns;
        react <= '1';
    end if;
    

end process;

process 
begin 
    for i in 1 to num_cycles loop
        clk <= not clk;
        wait for 5 ns;
        clk <= not clk;
        wait for 5 ns;
    end loop;
    wait;
end process;

reaction0 : reaction 
    port map (clk, start, reset, react, red, green, segment0, segment1);
        

end test;
