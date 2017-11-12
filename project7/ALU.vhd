
-- CS 232 Spring 2013
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- The alu circuit implements the specified operation on srcA and srcB, putting
-- the result in dest and setting the appropriate condition flags.

-- The opcode meanings are shown in the case statement below

-- condition outputs
-- cr(0) <= '1' if the result of the operation is 0
-- cr(1) <= '1' if there is a 2's complement overflow
-- cr(2) <= '1' if the result of the operation is negative
-- cr(3) <= '1' if the operation generated a carry of '1'

-- Note that the and/or/xor operations are defined on std_logic_vectors, so you
-- may have to convert the srcA and srcB signals to std_logic_vectors, execute
-- the operation, and then convert the result back to an unsigned.  You can do
-- this all within a single expression.


entity alu is
  
  port (
    srcA : in  unsigned(15 downto 0);         -- input A
    srcB : in  unsigned(15 downto 0);         -- input B
    op   : in  std_logic_vector(2 downto 0);  -- operation
    cr   : out std_logic_vector(3 downto 0);  -- condition outputs
    dest : out unsigned(15 downto 0));        -- output value

end alu;

architecture test of alu is

  -- The signal tdest is an intermediate signal to hold the result and
  -- catch the carry bit in location 16.
  signal tdest : unsigned(16 downto 0);  
  
  -- Note that you should always put the carry bit into index 16, even if the
  -- carry is shifted out the right side of the number (into position -1) in
  -- the case of a shift or rotate operation.  This makes it easy to set the
  -- condition flag in the case of a carry out.

begin  -- test
  process (srcA, srcB, op)
  begin  -- process
    cr <= "0000"; -- initialize cr 
    case op is
      when "000" =>        -- addition     dest = srcA + srcB
          dest <= std_logic_vector(srcA + srcB);
          if (dest(15) xor srcA(15)) and (dest(15) xor srcB(15)) then 
              cr(1) <= '1'; -- overflow
          end if;
          if dest(15) = '0' then 
              cr(3) <= '1'; -- carry 
          end if;
      when "001" =>        -- subtraction  dest = srcA - srcB
          dest <= srcA - srcB;
          if (dest(15) xor srcA(15)) and (dest(15) xor srcB(15)) then 
              cr(1) <= '1'; -- overflow 
          end if;
          if dest(15) = '1' then 
              cr(3) <= '0'; -- carry
          end if;
      when "010" =>        -- and          dest = srcA and srcB
          dest <= srcA and srcB;
      when "011" =>        -- or           dest = srcA or srcB
          dest <= srcA or srcB;
      when "100" =>        -- xor          dest = srcA xor srcB
          dest <= srcA xor srcB;
      when "101" =>        -- shift        dest = src shifted left arithmetic by one if srcB(0) is 0, otherwise right
          if srcB = 0 then 
              if srcA(15) = '1' then 
                  cr(3) <= '1';
              else 
                  cr(3) <= '0'; 
              end if;
              dest <= shift_left(srcA, 1);
          else 
              if srcA(0) = '1' then 
                  cr(3) <= '1';
              else 
                  cr(3) <= '0'; 
              end if;
              dest <= shift_right(srcA, 1);
          end if;
      when "110" =>        -- rotate       dest = src rotated left by one if srcB(0) is 0, otherwise right
          if srcB = 0 then 
              dest <= rotate_left(srcA, 1);
          else 
              dest <= rotate_right(srcA, 1);
      when "111" =>        -- pass         dest = srcA
          dest <= srcA;
      when others =>
        null;
    end case;

    if dest = 0 then 
        cr(0) <= '1';
    else 
        cr(0) <= '0'; -- restore the bit if set previously
    end if;

    if dest(15) = '1' then 
        cr(2) <= '1'; 
    else 
        cr(2) <= '0';
    end if;
  end process;

  -- connect the low 16 bits of tdest to dest here

  -- set the four CR output bits here

end test;
