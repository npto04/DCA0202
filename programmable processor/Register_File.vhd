LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;


ENTITY Register_File IS
	PORT
	(
		clk, w_wr, Rp_rd, Rq_rd: in std_logic;
		w_addr, Rq_addr, Rp_addr: in std_logic_vector(3 downto 0);
		w_data: in std_logic_vector(15 downto 0);
		Rq_data, Rp_data: out std_logic_vector(15 downto 0)
	);
END Register_File;


ARCHITECTURE SYN OF Register_File IS
	SIGNAL S: std_logic_vector(255 downto 0);
	SIGNAL y1, y2 : UNSIGNED (15 DOWNTO 0);
	SIGNAL x1, x2 : INTEGER range 0 TO 255;

	BEGIN
		process(Rq_rd,Rp_rd,w_wr,clk)
		
			begin	
			
				if(clk'event and clk = '1') then
					if(w_wr = '1') then
					-- Write w_data at address w_addr
						y1 <= UNSIGNED (w_addr);
						x1 <= TO_INTEGER(y1);
						S(x1*16+15 downto x1*16) <= w_data;
						
					elsif(Rq_rd = '1' and Rp_rd = '1') then
					-- Read Rq_data on address Rq_addr
						y1 <= UNSIGNED (Rq_addr);
						x1 <= TO_INTEGER(y1);
						Rq_data <= S(x1*16+15 downto x1*16);
					-- Read Rp_data on address Rp_addr
						y2 <= UNSIGNED (Rp_addr);
						x2 <= TO_INTEGER(y2);
						Rp_data <= S(x2*16+15 downto x2*16);
						
					elsif(Rp_rd = '0' and Rq_rd = '1') then	
					-- Read Rq_data on address Rq_addr
						y1 <= UNSIGNED (Rq_addr);
						x1 <= TO_INTEGER(y1);
						Rq_data <= S(x1*16+15 downto x1*16);
					
					elsif(Rp_rd = '1' and Rq_rd = '0') then
					-- Read Rp_data on address Rp_addr
						y1 <= UNSIGNED (Rp_addr);
						x1 <= TO_INTEGER(y1);
						Rp_data <= S(x1*16+15 downto x1*16);

					end if;
				end if;
		end process;

END SYN;
