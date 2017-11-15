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
        oport : out std_logic_vector(15 downto 0); -- output port
		  oSP   : out std_logic_vector(15 downto 0);
		  oRAM_output : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rlt of CPU is 

    constant zeros_15 : std_logic_vector(15 downto 0) := "0000000000000000";
    constant ones_15 : std_logic_vector(15 downto 0) := "1111111111111111";
	 
	 type state_type is (sStartup, sHalt, sFetch, sSetup, sALU, sMemWait, sWrite, sPause1, sPause2);

    -- stack address pointer; for RAM
    signal stack_ptr : unsigned(15 downto 0) := unsigned(zeros_15);

    -- Registers 
    signal CR  : std_logic_vector(3 downto 0);  -- condition register 
    signal MAR : std_logic_vector(7 downto 0);  -- memory address register
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
    signal state : state_type := sSTARTUP;

    -- counter for the startup state
    signal startup_counter : unsigned(2 downto 0) := "000";

    -- ALU wires 
    signal ALU_input1 : std_logic_vector(15 downto 0); -- srcA
    signal ALU_input2 : std_logic_vector(15 downto 0); -- srcB
    signal ALU_output : unsigned(15 downto 0);
    signal ALU_opcode : std_logic_vector(2 downto 0); -- operation code 
    signal ALU_cr     : std_logic_vector(3 downto 0); -- condition outpus

    -- RAM signals 
    signal RAM_we     : std_logic := '0';             -- write signal
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
	oSP <= std_logic_vector(stack_ptr);
	oRAM_output <= RAM_output;

    process(clk, reset) 
    begin 
        if reset = '0' then 
            PC <= "00000000";
            MBR <= zeros_15;
            MAR <= "00000000";
            IR <= "0000000000000000";
            state <= sStartup;
            OUTREG <= zeros_15;
            A <= zeros_15;
            B <= zeros_15;
            C <= zeros_15;
            D <= zeros_15;
            E <= zeros_15;
            CR <= "0000";
            stack_ptr <= unsigned(zeros_15);
				startup_counter <= "000";
        elsif rising_edge(clk) then 
            case state is 
                when sStartup => -- start state 
                    if startup_counter = "111" then 
                        state <= sFetch;
                    else 
                        startup_counter <= startup_counter + 1;
                    end if;
						  
						  
						  
                when sFetch => -- fetch state 
                    IR <= ROM_output;
                    PC <= std_logic_vector(unsigned(PC) + 1);
                    state <= sSetup;
						  
						  
				    -- SETUP STATE
                when sSetup => 
                    ALU_opcode <= IR(14 downto 12);

                    case IR(15 downto 12) is 
                        when "0000" | "0001" => -- load and store instructions 
                            if IR(11) = '1' then 
                                MAR <= std_logic_vector(unsigned(IR(7 downto 0)) + unsigned(E(7 downto 0)));
                            else 
                                MAR <= IR(7 downto 0);
                            end if;

                            case IR(10 downto 8) is 
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
											when others => 
											   null;
                            end case;
									 
									 
                        when "0010" => -- unconditional branch
                            PC <= IR(7 downto 0);
									 
									 
                        when "0011" => -- CALL, RETURN, conditional branch
                            case IR(11 downto 10) is 
									 
                                when "00" => -- conditional branch
                                    case IR(9 downto 8) is 
                                        when "00" => -- zero 
                                            if CR(0) = '1' then 
                                                PC <= IR(7 downto 0);
                                            end if;
                                        when "01" => -- overflow
                                            if CR(1) = '1' then 
                                                PC <= IR(7 downto 0);
                                            end if;
                                        when "10" => --negative 
                                            if CR(2) = '1' then 
                                                PC <= IR(7 downto 0);
                                            end if;
                                        when others => -- carry
                                            if CR(3) = '1' then 
                                                PC <= IR(7 downto 0);
                                            end if;
                                    end case;
												
                                -- CALL 
                                when "01" => 
                                    PC <= IR(7 downto 0);
                                    MAR <= std_logic_vector(stack_ptr(7 downto 0));
                                    MBR <= "0000" & CR & PC;
                                    stack_ptr <= stack_ptr + 1;
												
                                -- RETURN	
                                when "10" => 
                                    MAR <= std_logic_vector(stack_ptr(7 downto 0)-1);
                                    stack_ptr <= stack_ptr - 1;

                                when others =>
                                null;
                            end case;


                        when "0100" => -- push 
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
                                    MBR <= "00000000" & PC;
                                when others => -- CR 
                                    MBR <= "000000000000" & CR;
                            end case;
									 
                         -- POP
                        when "0101" => 
                            MAR <= std_logic_vector(stack_ptr(7 downto 0)-1);
                            stack_ptr <= stack_ptr - 1;
									 
                        -- BINARY OPERATIONS
                        when "1000" | "1001" | "1010" | "1011" | "1100" => 
                            case IR(11 downto 9) is 
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
                                when "110" => -- zeros 
                                    ALU_input1 <= zeros_15;
                                when others => -- ones 
                                    ALU_input1 <= ones_15;
                            end case;

                            case IR(8 downto 6) is 
                                when "000" => -- RA
                                    ALU_input2 <= A;
                                when "001" => -- RB
                                    ALU_input2 <= B;
                                when "010" => -- RC
                                    ALU_input2 <= C;
                                when "011" => -- RD
                                    ALU_input2 <= D;
                                when "100" => -- RE
                                    ALU_input2 <= E;
                                when "101" => -- SP 
                                    ALU_input2 <= std_logic_vector(stack_ptr);
                                when "110" => -- zeros 
                                    ALU_input2 <= zeros_15;
                                when others => -- ones 
                                    ALU_input2 <= ones_15;
                            end case;

                         -- UNARY OPERATION
                         when "1101" | "1110" => 
									  
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
                                when "110" => -- zeros 
                                    ALU_input1 <= zeros_15;
                                when others => -- ones 
                                    ALU_input1 <= ones_15;
                            end case;
									 
                            if IR(11) = '0' then -- set direction of the unary operation 
                                ALU_input2 <= zeros_15; -- left
                            else 
                                ALU_input2 <= ones_15; -- right
                            end if;

                        -- MOVE
                        when "1111" =>  
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
                                        ALU_input1 <= "00000000" & PC;
                                    when others => -- IR 
                                        ALU_input1 <= IR;
                                end case;
                            end if;
									 

                       when others => 
                           null;
                    end case;

						  -- EXIT state
                    if IR(15 downto 10) = "001111" then 
                        state <= sHalt; 
                    else 
                        state <= sALU;
                    end if;
								
								
								
                when sALU => -- process 
                    if IR(15 downto 12) = "0001" or IR(15 downto 12) = "0100"
                            or IR(15 downto 10) = "001101" then -- store, push, or call
                        RAM_we <= '1';
                    end if;
						  
						  
						  if IR(15 downto 12) = "0101" or IR(15 downto 12) = "0000" or IR(15 downto 10) = "001110" then
						      state <= sMemWait;
						  else 
							   state <= sWrite;
						  end if;
						  
                when sMemWait => -- MemWait
                    state <= sWrite;
						  
						  
						  
                when sWrite => -- Write 
                    RAM_we <= '0';

                    case IR(15 downto 12) is 
                        -- LOAD
                        when "0000" => 
                            case IR(10 downto 8) is 
                                when "000" => -- RA
                                    A <= RAM_output;
                                when "001" => -- RB
                                    B <= RAM_output;
                                when "010" => -- RC
                                    C <= RAM_output;
                                when "011" => -- RD
                                    D <= RAM_output;
                                when "100" => -- RE
                                    E <= RAM_output;
                                when "101" => -- SP
                                    stack_ptr <= unsigned(RAM_output);
                                when others => 
                                    null;
                            end case;

                        -- RETURN
                        when "0011" => 
                            if IR(11 downto 10) = "10" then 
                                PC <= RAM_output(7 downto 0);
                                CR <= RAM_output(11 downto 8);
                            end if;
    								
    								
                        -- POP
                        when "0101" => 
                            case IR(11 downto 9) is 
                                when "000" => -- RA
                                    A <= RAM_output;
                                when "001" => -- RB
                                    B <= RAM_output;
                                when "010" => -- RC
                                    C <= RAM_output;
                                when "011" => -- RD
                                    D <= RAM_output;
                                when "100" => -- RE
                                    E <= RAM_output;
                                when "101" => -- SP 
                                    stack_ptr <= unsigned(RAM_output);
                                when "110" => -- PC 
                                    PC <= RAM_output(7 downto 0);
                                when others => -- CR 
                                    CR <= RAM_output(3 downto 0);
                            end case;
    								
    								
                        -- STORE to OUTPUT
                        when "0110" => 
                            case IR(11 downto 9) is 
                                when "000" => -- RA
                                    OUTREG <= A;
                                when "001" => -- RB
                                    OUTREG <= B;
                                when "010" => -- RC
                                    OUTREG <= C;
                                when "011" => -- RD
                                    OUTREG <= D;
                                when "100" => -- RE
                                    OUTREG <= E;
                                when "101" => -- SP 
                                    OUTREG <= std_logic_vector(stack_ptr);
                                when "110" => -- PC 
                                    OUTREG <= "00000000" & PC;
                                when others => -- IR 
                                    OUTREG <= IR;
                            end case;
    								
    								
                        when "0111" => -- load from input
                            case IR(11 downto 9) is 
                                when "000" => -- RA
                                    A <= "00000000" & iport;
                                when "001" => -- RB
                                    B <= "00000000" & iport;
                                when "010" => -- RC
                                    C <= "00000000" & iport;
                                when "011" => -- RD
                                    D <= "00000000" & iport;
                                when "100" => -- RE
                                    E <= "00000000" & iport;
                                when "101" => -- SP 
                                    stack_ptr <= unsigned("00000000" & iport);
                                when others => 
                                    null;
                            end case;

                        -- BINARY and UNARY operations
                        when "1000" | "1001" | "1010" | "1011" | "1100" | "1101" | "1110" =>
                            case IR(2 downto 0) is 
                                when "000" => -- RA
                                    A <= std_logic_vector(ALU_output);
                                when "001" => -- RB
                                    B <= std_logic_vector(ALU_output);
                                when "010" => -- RC
                                    C <= std_logic_vector(ALU_output);
                                when "011" => -- RD
                                    D <= std_logic_vector(ALU_output);
                                when "100" => -- RE
                                    E <= std_logic_vector(ALU_output);
                                when "101" => -- SP 
                                    stack_ptr <= ALU_output;
                                when others =>
                                    null;
                            end case;

                            CR <= ALU_cr;
    								
    								
                        -- MOVE
                        when "1111" => 
                            case IR(2 downto 0) is 
                                when "000" => -- RA
                                    A <= std_logic_vector(ALU_output);
                                when "001" => -- RB
                                    B <= std_logic_vector(ALU_output);
                                when "010" => -- RC
                                    C <= std_logic_vector(ALU_output);
                                when "011" => -- RD
                                    D <= std_logic_vector(ALU_output);
                                when "100" => -- RE
                                    E <= std_logic_vector(ALU_output);
                                when "101" => -- SP 
                                    stack_ptr <= ALU_output;
                                when others =>
                                    null;
                            end case;

                            CR <= ALU_cr;
    								
    								

                        when others =>
                            -- store, unconditional branch, conditional branch, call, push 
                            null;
                    end case;
    
    						  
                    if IR(15 downto 10) = "001110" then 
                        state <= sPause1; -- RETURN instruction goes to PAUSE1 
                    else 
                        state <= sFetch;
                    end if;
						  
						  
						  
                when sPause1 => -- Pause1 
                    state <= sPause2;
						  
						  
						  
                when sPause2 => -- Pause2
                    state <= sFetch;
						  
						  
                when sHalt =>
                    state <= sFetch;

            end case;

        end if;

    end process;


    memory : DataRAM 
        port map (MAR, clk, MBR, RAM_we, RAM_output);

    instrucitnos : ProgramROM 
        port map (PC, clk, ROM_output);

    calc : ALU 
        port map (unsigned(ALU_input1), unsigned(ALU_input2), ALU_opcode, ALU_cr, ALU_output);

end architecture;
