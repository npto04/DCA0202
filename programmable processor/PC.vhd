library ieee;
use ieee.std_logic_1164.all;

entity PC is
	port( jmp_addr : in std_logic_vector(15 downto 0);
			ld, up, clk, clr : in std_logic;
			saida : out std_logic_vector(15 downto 0));
end PC;


architecture arq of cont is
	component reg is
		generic(n : integer := 6);
		port( entrada : in std_logic_vector(n-1 downto 0);
				ld, clk, clr : in std_logic;
				saida : out std_logic_vector(n-1 downto 0));
	end component;

	component soma is
		generic(n : integer := 4);
		port (		  
				  a,b: in std_logic_vector(n-1 downto 0);
				  s: out std_logic_vector(n-1 downto 0)
			 );
	end component;


	signal num1 : std_logic_vector(15 downto 0) := (others => '0');
	signal num2 : std_logic_vector(15 downto 0) := (others => '0');
	signal one : std_logic_vector(15 downto 0) := "0000000000000001";
	signal regIN : std_logic_vector(15 downto 0);
	
	begin
		process(ld)
			begin
				if(ld = 1) then
					regIn <= num1;
				else
					regIN <= jmp_addr;
				end if;
		end process;
					
		i1: soma generic map (16) port map (num2,one,num1);
		i2: reg generic map (16) port map(num1,ld or up,clk,clr,num2);
		
		saida <= num2;
		
end arq;