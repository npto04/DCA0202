LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

-- n = numero de instruçoes
ENTITY Instr_memory IS
	GENERIC(n : INTEGER := 1);
	PORT
	(
		addr: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		rd: IN STD_LOGIC;
		data: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END Instr_memory;


ARCHITECTURE SYN OF Instr_memory IS
	SIGNAL S: STD_LOGIC_VECTOR(n*16 DOWNTO 0); -- Storage
	SIGNAL y: UNSIGNED (15 DOWNTO 0);
	SIGNAL x: INTEGER range 0 TO n;

	BEGIN
		process(rd)
			begin
				if(rd = '1')
					y <= UNSIGNED (addr);
					x <= TO_INTEGER(y);
					data <= S(x*16+15 downto x*16);
				end if;
		end process;
END SYN;
