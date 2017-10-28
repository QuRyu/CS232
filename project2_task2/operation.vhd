library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operation is 
  port (
    A, B, C, D : in std_logic; -- the first number 
    E, F, G, H : in std_logic; -- the second number 
    Z : in std_logic; -- indicates if the number is in 2's complement form;
                      -- if it is on, the number is in 2's complement form
	 opt : in std_logic;  -- operation button; 1 is addtion
    output : out std_logic_vector (4 downto 0)  -- output 
);
end operation;

architecture addition of operation is 

  signal as : unsigned (4 downto 0); 
  signal bs : unsigned (4 downto 0);
  signal cs : unsigned (4 downto 0);

begin

as(0) <= D;
as(1) <= C;
as(2) <= B;
as(3) <= A; 

bs(0) <= H; 
bs(1) <= G;
bs(2) <= F;
bs(3) <= E;

output(4) <= cs(4);
output(3) <= cs(3);
output(2) <= cs(2);
output(1) <= cs(1);
output(0) <= cs(0);


process (A, B, C, D, E, F, G, H, Z, opt) 
begin 
  case Z is 
  when '0' => -- plain form 
    as(4) <= '0';
	 bs(4) <= '0';
	 
	 if opt = '1' then 
      cs <= as + bs;
	 else 
	   cs <= as + not(bs);
	 end if;
  when '1' => -- 2's complement form 
    if ('1' and A) = '1' then -- sign extension 
      as(4) <= '1'; -- negative 
    else 
      as(4) <= '0';
    end if; 

    if ('1' and E) = '1' then -- sign extension 
      bs(4) <= '1'; 
    else 
      bs(4) <= '0'; 
    end if;

	 if opt = '1' then 
      cs <= as + bs;
	 else 
	   cs <= as + ("00001" + not(bs));
	 end if;
  end case;

end process;


end addition;


