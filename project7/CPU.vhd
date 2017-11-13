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

    constant zeros_15 : std_logic_vector(15 downto 0) := "0000000000000000";

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
    signal ALU_input1 : std_logic_vector(15 downto 0); -- srcA
    signal ALU_input2 : std_logic_vector(15 downto 0); -- srcB
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
            MBR <= zeros_15;
            MAR <= "0000000";
            IR <= "0000000000000000";
            state <= "0000";
            OUTREG <= zeros_15;
            A <= zeros_15;
            B <= zeros_15;
            C <= zeros_15;
            D <= zeros_15;
            E <= zeros_15;
            CR <= "0000";
            SP <= unsigned(zeros_15);
        elsif rising_edge(clk) then 
            case state is 
                when "0000" => -- start state 
                    if startup_counter = "1111" then 
                        state <= "001";
                    else 
                        startup_counter <= startup_counter + 1;
                    end if;
                when "0001" => -- fetch state 
                    IR <= ROM_output;
                    PC <= std_logic_vector(unsigned(PC) + 1);
                    state <= "0010";
                when "0010" => -- setup 
                    case IR(15 downto 12) is 
                        when "0000" or "0001" =>  -- load and store instructions 
                            if IR(11) = '1' then 
                                MAR <= std_logic_vector(IR(7 downto 0) + unsigned(E(7 downto 0)));
                            else 
                                MAR <= IR(7 downto 0);
                            end if;
                        when "0010" => -- unconditional branch
                            PC <= IR(7 downto 0);
                        when "0011" => -- conditional branch
                            case IR(9 downto 8) is 
                                when "00" => -- zero 
                                    if ALU_cr(0) = '1' then 
                                        PC <= IR(7 downto 0);
                                    end if;
                                when "01" => -- overflow
                                    if ALU_cr(1) = '1' then 
                                        PC <= IR(7 downto 0);
                                    end if;
                                when "10" => --negative 
                                    if ALU_cr(2) = '1' then 
                                        PC <= IR(7 downto 0);
                                    end if;
                                when "11" => -- carry
                                    if ALU_cr(3) = '1' then 
                                        PC <= IR(7 downto 0);
                                    end if;
                            end case;
                        when "0100" => -- CALL instruction
                            PC <= IR(7 downto 0);
                            MAR <= std_logic_vector(stack_ptr(7 downto 0));
                            MBR <= "0000" & CR & PC;
                            stack_ptr <= stack_ptr + 1;
                        when "0101" => -- RETURN instruction 
                        when "0100" => -- psuh 
                            MAR <= std_logic_vector(stack_ptr(7 downto 0));
                            stack_ptr <= stack_ptr + 1;
                            case IR(11 downto 9) is 
                                when "000" => -- RA 
                                    MBR <= A;
                                when "001" => -- RB 
                                    MBR <= B;
                                when "010" => -- RC 
                                    MBR <= C;
                                when "011" => -- RD
                                    MBR <= D;
                                when "100" => -- RE
                                    MBR <= E;
                                when "101" => -- SP 
                                    MBR <= std_logic_vector(stack_ptr);
                                when "110" => -- PC
                                    MBR <= PC;
                                when "111" => -- CR 
                                    MBR <= CR;
                            end case;
                        when "0101" => -- pop 
                            if stack_ptr \= 0 then 
                                stack_ptr <= stack_ptr - 1;
                            end if;
                            MAR <= stack_ptr;
                        when "1111" => -- move 
                            if IR(11) = '1' then -- immediate value
                                if IR(10) = '1' then 
                                    ALU_input1 <= "11111111" & IR(10 downto 3);
                                else 
                                    ALU_input1 <= "00000000" & IR(10 downto 3);
                                end if;
                            else -- register
                                case IR(10 downto 8) is 
                                    when "000" => -- RA 
                                        ALU_input1 <= A;
                                    when "001" => -- RB
                                        ALU_input1 <= B;
                                    when "010" => -- RC
                                        ALU_input1 <= C;
                                    when "011" => -- RD
                                        ALU_input1 <= D;
                                    when "100" => -- RE
                                        ALU_input1 <= E;
                                    when "101" => -- SP
                                        ALU_input1 <= std_logic_vector(stack_ptr);
                                    when "110" => -- PC
                                        ALU_input1 <= PC;
                                    when "111" => -- IR 
                                        ALU_input1 <= IR;
                                end case;
                            end if;
                        when others => -- arithmetic operations
                    end case;
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
