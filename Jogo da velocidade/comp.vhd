library ieee;
use ieee.std_logic_1164.all;

entity comp is
	generic(n : integer := 4);
	port (			  
			  a, b: in std_logic_vector(n-1 downto 0);
			  s: out std_logic
		 );
end comp;

architecture behav of comp is
begin
  s <= '1' when a=b else
			'0';
end behav;