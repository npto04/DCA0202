library ieee;
use ieee.std_logic_1164.all;

entity IR is
	port( entrada : in std_logic_vector(15 downto 0);
			ld, clk : in std_logic;
			saida : out std_logic_vector(15 downto 0));
end IR;

architecture arq of reg is
	begin
		process(clk)
			begin
				if(clk'event and clk = '1') then
					if(ld='1') then
						SAIDA <= ENTRADA;
					end if;
				end if;
		end process;
end arq;