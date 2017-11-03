-- Bruce A. Maxwell
-- Fall 2017
-- CS 232
--
-- test program for the stacker circuit
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculatortest is
end entity;

architecture test of calculatortest is
  constant num_cycles : integer := 45;

  -- this circuit needs a clock and a reset
  signal clk : std_logic := '1';
  signal reset : std_logic;

  -- stacker component
  component calculator
    port(
         clock: in std_logic;
         reset: in std_logic;
         b2:    in std_logic; -- switch values to mbr
         b3:    in std_logic; -- push mbr -> stack
         b4:    in std_logic; -- pop stack -> mbr
         op:    in std_logic_vector(2 downto 0); -- operation 
         data:  in std_logic_vector(7 downto 0);
         digit0: out std_logic_vector(6 downto 0);
         digit1: out std_logic_vector(6 downto 0);
         stackview: out std_logic_vector(3 downto 0);
         stateview: out std_logic_vector(3 downto 0)
         );
  end component;

  -- output signals
  signal stackview : std_logic_vector(3 downto 0);
  signal stateview : std_logic_vector(3 downto 0);

  -- buttons
  signal b2, b3, b4 : std_logic;
  signal data: std_logic_vector(7 downto 0);

  -- segment display
  signal digit0 : std_logic_vector(6 downto 0);
  signal digit1 : std_logic_vector(6 downto 0);
  
  -- operation
  signal op : std_logic_vector(2 downto 0);

begin

  -- start off with a short reset
  reset <= '0', '1' after 5 ns;

  -- create a clock
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

  -- clock is in 5ns increments, rising edges on 5, 15, 25, 35, 45..., let 5 cycles
  -- go by before doing anything
  --
  -- We're going to push 1, 2, and 3 onto the stack at time 50, 100, and 150,
  -- then put a "0000" into the MBR register before popping the three values
  -- off the stack
  data <= "00000010", "00000101" after 90 ns;

  -- put data values into the MBR at 50, 100, 150
  b2 <= '1', '0' after 55 ns, '1' after 70 ns, '0' after 100 ns, '1' after 120 ns;

  -- push three values (1, 2, 3) onto the stack using b3 at time 70, 120, 170
  b3 <= '1', '0' after 75 ns, '1' after 80 ns;

  -- pop three values off the sack using b4 at times 220, 280, 340, should get
  -- 3, 2, 1 in that order
  b4 <= '1', '0' after 150 ns, '1' after 160 ns;

  -- operation
  op <= "100";

  -- port map the circuit
  L0: calculator port map(clk, reset, b2, b3, b4, op, data, digit0, digit1, stackview, stateview);

end test;
