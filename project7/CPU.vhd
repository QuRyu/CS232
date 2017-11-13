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

    -- stack address pointer; for RAM
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

    -- Program Counter, connect to ROM for fetching instructions 
    signal PC : std_logic_vector(7 downto 0) := "00000000";

    -- state transition
    signal state : std_logic_vector(3 downto 0) := "0000";

    -- counter for the startup state
    signal startup_counter : unsigned(2 downto 0) := "000";

    -- ALU wires 
    signal ALU_input1 : std_logic_vector(15 downto 0);
    signal ALU_input2 : std_logic_vector(15 downto 0);
    signal ALU_output : unsigned(15 downto 0);
    signal ALU_opcode : std_logic_vector(2 downto 0); -- operation code 
    signal ALU_cr     : std_logic_vector(3 downto 0); -- condition outpus

    -- RAM signals 
    signal RAM_we     : std_logic;                     -- write signal
    signal RAM_input  : std_logic_vector(15 downto 0);
    signal RAM_output : std_logic_vector(15 downto 0);

    -- ROM signals 
    signal ROM_output : std_logic_vector(15 downto 0);

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
            data    : in  std_logic_vector(15 downto 0);
            wren    : in  std_logic;
            q       : out std_logic_vector(15 downto 0)
        );
    end component;

    component ALU is 
        port (
            srcA : in  unsigned(15 downto 0);
            srcB : in  unsigned(15 downto 0);
            op   : in  std_logic_vector(2 downto 0);
            cr   : out std_logic_vector(3 downto 0);
            dest : out unsigned(15 downto 0)
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

    process(clk, reset) 
    begin 
        if reset = '0' then 
            PC <= "00000000";
            MBR <= "0000000000000000";
            MAR <= "0000000";
            IR <= "0000000000000000";
            state <= "0000";
        elsif rising_edge(clk) then 
            case state is 
                when "0000" => -- start state 
                when "0001" => -- fetch state 
                when "0010" => -- setup 
                when "0011" => -- ALU 
                when "0100" => -- MemWait
                when "0101" => -- Write 
                when "0110" => -- Pause1 
                when "0111" => -- Pause2
                when "1000" => -- halt
                when others =>
                     NULL;
            end case;

        end if;

    end process;


    memory : DataRAM 
        port map (std_logic_vector(stack_ptr(7 downto 0)), clk, RAM_input, RAM_we, RAM_output);

    instrucitnos : ProgramROM 
        port map (PC, clk, ROM_output);

    calc : ALU 
        port map (unsigned(ALU_input1), unsigned(ALU_input2), ALU_opcode, ALU_cr, ALU_output);

end architecture;
