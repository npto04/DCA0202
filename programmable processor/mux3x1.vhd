library ieee;
use ieee.std_logic_1164.all;

entity mux3x1 is
	generic (n : integer := 7);
	port (
		i0, i1, i2: in std_logic_vector(n-1 downto 0);
		Sel: in std_logic_vector(1 downto 0);
		S : out std_logic_vector(n-1 downto 0)
	);
end mux3x1;

architecture behav of mux3x1 is
	begin
		PROCESS(Sel)
			BEGIN
				case (Sel) is
					when "00" =>
					 S <= i0;
					when "01" =>
					 S <= i1;
					when others =>
					 S <= i2;
				end case;
		END PROCESS;
end behav;