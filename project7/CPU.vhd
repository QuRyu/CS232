library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is 
    port (
        clk   : in  std_logic;
        reset : in  std_logic;

        PCview : out std_logic_vector(7 downto 0);  -- debugging outputs
        IRview : out std_logic_vector(15 downto 0);
        RAview : out std_logic_vector(15 downto 0);
        RBview : out std_logic_vector(15 downto 0);
        RCview : out std_logic_vector(15 downto 0);
        RDview : out std_logic_vector(15 downto 0);
        REview : out std_logic_vector(15 downto 0);

        iport : in  std_logic_vector(7 downto 0); -- input port
        oport : out std_logic_vector(15 downto 0) -- output port
    );
end entity;

architecture rlt of CPU is 

    -- stack address pointer 
    signal stack_ptr : unsigned(15 downto 0);

    -- Registers 
    signal CR  : std_logic_vector(3 downto 0);  -- condition register 
    signal MAR : std_logic_vector(7 downto 1);  -- memory address register
    signal MBR : std_logic_vector(15 downto 0); -- memory buffer register 
    signal IR  : std_logic_vector(15 downto 0); -- Instruction Register
    signal A   : std_logic_vector(15 downto 0);
    signal B   : std_logic_vector(15 downto 0);
    signal C   : std_logic_vector(15 downto 0);
    signal D   : std_logic_vector(15 downto 0);
    signal E   : std_logic_vector(15 downto 0);

    signal OUTREG : std_logic_vector(15 downto 0);

    -- Program Counter
    signal PC : std_logic_vector(7 downto 0);


    component ProgramROM is 
        port (
            address : in  std_logic_vector(7 downto 0);
            clock   : in  std_logic;
            q       : out std_logic_vector(15 downto 0)
        );
    end component;

    component DataRAM is 
        port (
            address : in  std_logic_vector(7 downto 0);
            clock   : in  std_logic;
            q       : out std_logic_vector(15 downto 0)
        );
    end component;

begin

    PCview <= PC;
    IRview <= IR;

    RAview <= A;
    RBview <= B;
    RCview <= C;
    RDview <= D;
    REview <= E;

    oport <= OUTREG;

end architecture;
