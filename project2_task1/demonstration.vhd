library ieee; 
use ieee.std_logic_1164.all;

entity demonstration is 
  port( 
    clock, reset : in std_logic; -- input 
    A, B, C, D, E, F, G : out std_logic; -- segment 1 
    H, I, J, K, L, M, N : out std_logic -- segment 0
  );
end demonstration; 

architecture run of demonstration is 
component counter is 
  port (
    clk : in std_logic; 
    reset : in std_logic; 
    q : out std_logic_vector (7 downto 0)
  );
end component; 

component segment_display is
  port (
    A, B, C, D: in std_logic; 
    E, F, G, H, I, J, K : out std_logic
  ); 
end component;

signal q : std_logic_vector (7 downto 0);
-- signal q0, q1, q2, q3, q4, q5, q6, q7 : std_logic := '1';
signal invertedReset : std_logic;

begin 

invertedReset <= not(reset);

display1 : segment_display 
  port map (
    A => q(7),
    B => q(6), 
    C => q(5), 
    D => q(4), 
    E => A, 
    F => B, 
    G => C, 
    H => D,
    I => E, 
    J => F, 
    K => G
);

display0 : segment_display 
  port map ( 
    A => q(3), 
    B => q(2), 
    C => q(1), 
    D => q(0), 
    E => H, 
    F => I, 
    G => J, 
    H => K, 
    I => L, 
    J => M, 
    K => N
);

cnt : counter
  port map (
    clk => clock, 
    reset => invertedReset, 
    q => q
);


end run;
