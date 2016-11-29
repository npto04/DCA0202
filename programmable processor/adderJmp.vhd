-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity adderJmp is
	port 
	(
		a	   : in std_logic_vector(7 downto 0);
		b	   : in std_logic_vector(7 downto 0);
		result : out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of adderJmp is
	signal one : std_logic_vector(7 downto 0) := "00000001";
	
begin
	result <= a + b - one;

end rtl;
