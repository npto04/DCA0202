library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic(n : integer := 6);
	port( entrada : in std_logic_vector(n-1 downto 0);
			ld, clk, clr : in std_logic;
			saida : out std_logic_vector(n-1 downto 0));
end reg;

architecture arq of reg is
	begin
		process(Ld,clk,clr)
			begin
				if(clr = '1') then
					if(clk'event and clk = '1') then
						if(ld='1') then
							SAIDA <= ENTRADA;
						end if;
					end if;
				else
					SAIDA <= (others => '0');
				end if;
		end process;
end arq;