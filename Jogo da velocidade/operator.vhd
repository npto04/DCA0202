library ieee;
use ieee.std_logic_1164.all;

entity operator is
	port (
		CLK, LD_Tempo, Clr_Tempo, Ld_TempoC, Clr_TempoC: in std_logic;
		Sel: in std_logic_vector(1 downto 0);
		TempoMenor5000, TempoMaior2000: out std_logic;
		d3, d2, d1, d0 : out std_logic_vector(6 downto 0)
	);
end operator;

architecture behav of operator is

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
	
	component maior is
		generic(n : integer := 4);
		port (			  
			  a, b: in std_logic_vector(n-1 downto 0);
			  s: out std_logic
		 );
	end component;
	
	COMPONENT segmentos IS
		PORT (entrada : IN STD_LOGIC_VECTOR(13 DOWNTO 0);        
			saida1, saida2, saida3, saida4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); 
	END COMPONENT;
	
	component mux3x1 is
		generic (n : integer := 7);
		port (
			i0, i1, i2: in std_logic_vector(n-1 downto 0);
			Sel: in std_logic_vector(1 downto 0);
			S : out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	signal b1 : std_logic_vector(12 downto 0) := (others => '0');--incremento tempo1
	signal tempo1, tempo2 : std_logic_vector(12 downto 0) := (others => '0');
	signal bin5000 : STD_LOGIC_VECTOR(12 downto 0) := "1001110001000";
	signal maior5000 : std_logic;
	
	signal b2 : std_logic_vector(10 downto 0) := (others => '0');--incremento TempoC
	signal TempoC1, TempoC2 : std_logic_vector(10 downto 0) := (others => '0');
	signal bin2000 : STD_LOGIC_VECTOR(10 downto 0) := "11111010000";
	
	signal s1,s2,s3,s4 : std_logic_vector(6 downto 0);
	signal tempoC_bin14 : std_logic_vector(13 downto 0) := (others => '0');
	
	signal E : std_logic_vector(6 downto 0) := "0000110";
	signal R : std_logic_vector(6 downto 0) := "1001110";
	signal O : std_logic_vector(6 downto 0) := "1000000";
	signal off : std_logic_vector(6 downto 0) := "1111111";

	begin
		b1(0) <= '1';
		b2(0) <= '1';
		
		i0: reg generic map(13) port map (tempo1,LD_Tempo,CLK,Clr_Tempo,tempo2);
		i1: maior generic map (13) port map (tempo2,bin5000,maior5000);
		TempoMenor5000 <= not maior5000;
		i3: soma generic map (13) port map (tempo2,b1,tempo1);
		
		i4: reg generic map (11) port map (TempoC1,LD_TempoC,CLK,Clr_TempoC,TempoC2);
		i5: maior generic map (11) port map (tempoC2,bin2000,TempoMaior2000);
		i6: soma generic map (11) port map (tempoC2,b2,tempoC1);	
		tempoC_bin14(0) <= TempoC2(0);
		tempoC_bin14(1) <= TempoC2(0);
		tempoC_bin14(2) <= TempoC2(0);
		tempoC_bin14(3) <= TempoC2(0);
		tempoC_bin14(4) <= TempoC2(0);
		tempoC_bin14(5) <= TempoC2(0);
		tempoC_bin14(6) <= TempoC2(0);
		tempoC_bin14(7) <= TempoC2(0);
		tempoC_bin14(8) <= TempoC2(0);
		tempoC_bin14(9) <= TempoC2(0);
		tempoC_bin14(10) <= TempoC2(0);
		i7: segmentos port map (tempoC_bin14,s1,s2,s3,s4);
		i8: mux3x1 generic map (7) port map (E,s4,off,Sel,d3);
		i9: mux3x1 generic map (7) port map (R,s3,off,Sel,d2);
		i10: mux3x1 generic map (7) port map (R,s2,off,Sel,d1);
		i11: mux3x1 generic map (7) port map (O,s1,off,Sel,d0);
		
end behav;