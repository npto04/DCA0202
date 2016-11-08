library ieee;
use ieee.std_logic_1164.all;

entity maior is
	generic(n : integer := 4);
	port (			  
			  a, b: in std_logic_vector(n-1 downto 0);
			  s: out std_logic
		 );
end maior;

architecture behav of maior is
begin
  s <= '1' when a>b else
			'0';
end behav;