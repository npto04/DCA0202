library ieee;
use ieee.std_logic_1164.all;

entity div_freq is
	generic(n : integer := 6);
	port (			  
			  div: in std_logic_vector(n-1 downto 0);
			  clkIn : in std_logic;
			  clkOut: out std_logic
		 );
end div_freq;

architecture arc of div_freq is
	component cont is
		generic(n : integer := 6);
		port( limite : in std_logic_vector(n-1 downto 0);
				clk : in std_logic;
				saida : out std_logic_vector(n-1 downto 0));
	end component;
	
	component comp is
		generic(n : integer := 4);
		port (			  
				  a, b: in std_logic_vector(n-1 downto 0);
				  s: out std_logic
			 );
	end component;
	
	signal contEdge : std_logic_vector(n-1 downto 0);

	begin
		i1: cont generic map (n) port map (div,clkIn,contEdge);
		i2: comp generic map(n) port map (contEdge,div,clkOut);
end arc;