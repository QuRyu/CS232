library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port 
  (
    d      : in unsigned  (3 downto 0);
    e      : in unsigned  (3 downto 0);
    f      : in std_logic_vector (1 downto 0);
    q      : out unsigned (4 downto 0)
  );

end entity;

architecture rtl of alu is

    signal d_ex : unsigned (4 downto 0);
    signal e_ex : unsigned (4 downto 0);

begin

    d_ex <= '0' & d;
    e_ex <= '0' & e;

process (d, e, f)
begin 

    --case f is 
        --when "00" => 
            --q <= d_ex + e_ex;
        --when "01" => 
            --q <= d_ex - e_ex; 
        --when "10" => 
            --q <= d_ex and e_ex;
        --when "11" => 
            --q <= d_ex or e_ex;
    --end case;
	     
    if f = "00" then
        q <= d_ex + e_ex;
    elsif f = "01" then 
        q <= d_ex - e_ex;
    elsif f = "10" then 
        q <= d_ex and e_ex;
    else 
        q <= d_ex or e_ex;
    end if;

end process; 
end rtl;
