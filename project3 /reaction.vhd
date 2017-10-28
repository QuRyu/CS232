library ieee;
use ieee.std_logic_1164.all;

entity reaction is 
    port (
        clk      : in   std_logic;
        start    : in   std_logic;
        reset    : in   std_logic;
        react    : in   std_logic;
        red      : out  std_logic;
        green    : out  std_logic;
        segment0 : out  std_logic_vector (6 downto 0);
        segment1 : out  std_logic_vector (6 downto 0);
        segment2 : out  std_logic_vector (6 downto 0);
        segment3 : out  std_logic_vector (6 downto 0);
        record_reset : in std_logic  -- reset the fastest record
    );

end entity;

architecture rtl of reaction is 

    component timer is 
        port (
            clk     : in  std_logic;
            start   : in  std_logic; 
            reset   : in  std_logic;
            react   : in  std_logic;
            mstime  : out std_logic_vector (7 downto 0);
            red     : out std_logic;
            green   : out std_logic;
            mintime : out std_logic_vector (7 downto 0);
            record_reset : in std_logic
        );
    end component;

    component segment_display is 
        port (
            input   : in  std_logic_vector (3 downto 0);
            output  : out std_logic_vector (6 downto 0)
        );
    end component;
            
    signal wire0 : std_logic_vector (7 downto 0); -- connect mstime to
segment 0 and 1 
    signal wire1 : std_logic_vector (7 downto 0); -- connect mintime to
segment 2 and 3 

    signal start_inv, reset_inv, react_inv: std_logic; -- invert buttons
    signal record_reset_inverted : std_logic; -- invert buttons
	 
begin 

    start_inv <= not start;
    react_inv <= not react;
    reset_inv <= not reset;
    record_reset_inverted <= not record_reset;


tmr : timer 
    port map ( 
        clk    => clk,
        start  => start_inv, 
        reset  => reset_inv, 
        react  => react_inv, 
        mstime => wire0,
        red    => red,
        green  => green,
        mintime => wire1,
        record_reset => record_reset_inverted
);

display0 : segment_display 
    port map (
        input  => wire0(3 downto 0),
        output => segment0
);
        
display1 : segment_display 
    port map (
        input  => wire0(7 downto 4),
        output => segment1
);

display2 : segment_display
    port map (
        input => wire1(3 downto 0),
        output => segment2
);

display3 : segment_display 
    port map (
        input => wire1(7 downto 4),
        output => segment3
);


end rtl;
