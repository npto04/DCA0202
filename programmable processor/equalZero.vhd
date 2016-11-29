library ieee;
use ieee.std_logic_1164.all;

entity equalZero is
	generic(n : integer := 4);
	port (			  
			  a: in std_logic_vector(n-1 downto 0);
			  s: out std_logic
		 );
end equalZero;

architecture behav of equalZero is
begin
  s <= '1' when a = (other => '0') else
			'0';
end behav;