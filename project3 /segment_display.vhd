library ieee;
use ieee.std_logic_1164.all;

entity segment_display is 
  port (
    input : in  std_logic_vector (3 downto 0);
    output : out std_logic_vector (6 downto 0)
  ); 
end segment_display;

architecture display of segment_display is 

  signal A, B, C, D : std_logic;
  signal notA, notB, notC, notD : std_logic; 
  signal E, F, G, H, I, J, K : std_logic;
  
  signal E_wire1, E_wire2, E_wire3, E_wire4 : std_logic;
  signal F_wire1, F_wire2, F_wire3, F_wire4 : std_logic;
  signal G_wire1, G_wire2, G_wire3 : std_logic;
  signal H_wire1, H_wire2, H_wire3, H_wire4 : std_logic;
  signal I_wire1, I_wire2, I_wire3 : std_logic;
  signal J_wire1, J_wire2, J_wire3, J_wire4 : std_logic;
  signal K_wire1, K_wire2, K_wire3 : std_logic;

begin 

  A <= input (3);
  B <= input (2);
  C <= input (1);
  D <= input (0);

  notA <= not(A);
  notB <= not(B);
  notC <= not(C);
  notD <= not(D);
  
  output(0) <= E;
  output(1) <= F;
  output(2) <= G;
  output(3) <= H; 
  output(4) <= I;
  output(5) <= J; 
  output(6) <= K;
  
  E_wire1 <= notA and notB and notC and D;
  E_wire2 <= notA and B and notC and notD;
  E_wire3 <= A and notB and C and D;
  E_wire4 <= A and B and notC and D;
  
  F_wire1 <= B and C and notD;
  F_wire2 <= A and C and D;
  F_wire3 <= A and B and notD;
  F_wire4 <= notA and B and notC and D;
  
  G_wire1 <= A and B and notD; 
  G_wire2 <= A and B and C;
  G_wire3 <= notA and notB and C and notD;
  
  H_wire1 <= notB and notC and D;
  H_wire2 <= B and C and D;
  H_wire3 <= notA and B and notC and notD;
  H_wire4 <= A and notB and C and notD;
  
  I_wire1 <= notA and D;
  I_wire2 <= notB and notC and D;
  I_wire3 <= notA and B and notC;
  
  J_wire1 <= notA and notB and D;
  J_wire2 <= notA and notB and C;
  J_wire3 <= notA and C and D;
  J_wire4 <= A and B and notC and D;
  
  K_wire1 <= notA and notB and notC;
  K_wire2 <= notA and B and C and D;
  K_wire3 <= A and B and notC and notD;
	
  E <= E_wire1 or E_wire2 or E_wire3 or E_wire4;

  F <= F_wire1 or F_wire2 or F_wire3 or F_wire4;
	
  G <= G_wire1 or G_wire2 or G_wire3;
	
  H <= H_wire1 or H_wire2 or H_wire3 or H_wire4;
	
  I <= I_wire1 or I_wire2 or I_wire3;

  J <= J_wire1 or J_wire2 or J_wire3 or J_wire4;

  K <= K_wire1 or K_wire2 or K_wire3;

end display;
