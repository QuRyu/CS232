library ieee;
use ieee.std_logic_1164.all;

entity main is 
  port (
    A, B, C, D : in std_logic;   -- number 1  
    E, F, G, H : in std_logic;   -- number 2 
    Z : in std_logic;            -- if in two's complement form
    out1 : out std_logic_vector (6 downto 0);
    out2 : out std_logic_vector (6 downto 0);
	 minus : out std_logic := '1'; -- minus sign of segment 3 
	 out3 : out std_logic_vector (5 downto 0); -- the third segment 
	 opt : in std_logic  -- operation button; 1 is addition, 0 is substraction
  );
end main;


architecture run of main is 
  component operation is 
    port ( 
      A, B, C, D : in std_logic; 
      E, F, G, H : in std_logic;
      Z : in std_logic;
      output : out std_logic_vector (4 downto 0);
		opt : in std_logic
    );
  end component;
  
  component segment_display is 
    port (
      number : in std_logic_vector (4 downto 0); 
      Z : in std_logic; 
      out1 : out std_logic_vector (6 downto 0);
      out2 : out std_logic_vector (6 downto 0);
		minus : out std_logic -- this should be inverted
    ); 
  end component;
     
  signal wire0 : std_logic_vector (4 downto 0);  -- connect cs of component operation to number of segment_display   
  
begin 

out3 <= "111111";

op : operation 
  port map ( 
    A => A, 
    B => B, 
    C => C, 
    D => D, 
    E => E, 
    F => F, 
    G => G, 
    H => H, 
    Z => Z, 
    output => wire0,
	 opt => opt
);
    
display : segment_display 
  port map (
    number => wire0, 
    Z => Z,
    out1 => out1, 
    out2 => out2,
	 minus => minus
);


end run;

