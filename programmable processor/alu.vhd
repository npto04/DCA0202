library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity ALU is
	generic(n : integer := 4);
	port (			  
			  a,b: in std_logic_vector(n-1 downto 0);
			  sel: in std_logic_vector(2 downto 0);
			  s: out std_logic_vector(n-1 downto 0)
		 );
end ALU;
 
architecture behav of ALU is

begin
  s <= a+b when sel="001" else
		a-b when sel="010" else
		not a when sel="011" else
		a and b when sel="100" else
		a or b when sel="101" else
		a;
end behav;