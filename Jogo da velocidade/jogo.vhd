library ieee;
use ieee.std_logic_1164.all;

entity jogo is
	port (
		BTInicio, BTAP, CLK : in std_logic;
		LEDAP, LEDR : out std_logic;
		d3, d2, d1, d0 : out std_logic_vector(6 downto 0)
	);
end jogo;

architecture behav of jogo is

	component operator is
		port (
			CLK, LD_Tempo, Clr_Tempo, Ld_TempoC, Clr_TempoC: in std_logic;
			Sel: in std_logic_vector(1 downto 0);
			TempoMenor5000, TempoMaior2000: out std_logic;
			d3, d2, d1, d0 : out std_logic_vector(6 downto 0)
		);
	end component;
	
	component controller is
		port (			  
				  clk, BTInicio, BTAP, TempoMenor5000, TempoMaior2000: in std_logic;
				  LedAP, LedR, LD_Tempo, Clr_Tempo, Ld_TempoC, Clr_TempoC: out std_logic;
				  Sel: out std_logic_vector(1 downto 0)
			 );
	end component;
	
	component div_freq is
		generic(n : integer := 6);
		port (			  
				  div: in std_logic_vector(n-1 downto 0);
				  clkIn : in std_logic;
				  clkOut: out std_logic
			 );
	end component;
	
	signal clk1khz : std_logic;--50Mhz to 1khz
	signal TempoMaior2000, TempoMenor5000, LD_Tempo, Clr_Tempo, Ld_TempoC, Clr_TempoC : std_logic;
	signal Sel : std_logic_vector(1 downto 0);
	signal bin50000 : std_logic_vector(15 downto 0) := "1100001101010000";
	
begin
	i0: div_freq generic map (16) port map (bin50000,CLK,clk1khz);
	i1: controller port map (clk1khz,BTInicio,BTAP,TempoMenor5000,TempoMaior2000,LEDAP,LEDR,LD_Tempo,Clr_Tempo,LD_TempoC,Clr_TempoC,Sel);
	i2: operator port map (clk1khz, LD_Tempo, Clr_Tempo, Ld_TempoC, Clr_TempoC, Sel,	TempoMenor5000, TempoMaior2000,d3, d2, d1, d0);
	
end behav;