-- Bruce A. Maxwell
-- Spring 2016
-- CS 232
--
-- test program for the counter
-- shows how to create a clock using a loop

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture test of testbench is
  constant num_cycles : integer := 40;  -- run for 40 clock cycles

  -- this circuit needs a clock, enable, and a reset
  signal clk : std_logic := '1';
  signal enable : std_logic;
  signal reset : std_logic;
  signal q : std_logic_vector (3 downto 0);
  signal NSR, NSG, NSY, EWR, EWG, EWY : std_logic;

  -- counter component
  component task 
        port 
        (
                clk	  : in std_logic;
		reset	  : in std_logic;
		enable	  : in std_logic;
                q         : out std_logic_vector (3 downto 0); 
                NSR       : out std_logic; 
                NSG       : out std_logic; 
                NSY       : out std_logic; 
                EWR       : out std_logic; 
                EWG       : out std_logic;  
                EWY       : out std_logic
        );
   end component;

  -- output signals
  

begin

  -- start off with a short reset
  reset <= '1', '0' after 5 ns;

  enable <= '1';

  -- create a clock
  process begin
    for i in 1 to num_cycles loop
      clk <= not clk;
      wait for 5 ns;
      clk <= not clk;
      wait for 5 ns;
    end loop;
    wait;
  end process;

  -- port map the circuit
T0: task port map( clk, reset, enable, q, NSR, NSG, NSY, EWR, EWG, EWY );

end test;

