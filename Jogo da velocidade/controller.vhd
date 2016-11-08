  library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity controller is
	port (
			  clk, BTInicio, BTAP, TempoMenor5000, TempoMaior2000: in std_logic;
			  LedAP, LedR, LD_Tempo, Clr_Tempo, Ld_TempoC, Clr_TempoC: out std_logic;
			  Sel: out std_logic_vector(1 downto 0)
		 );
end controller;
 
architecture behav of controller is
	Constant Inicio: std_LOGIC_vector(2 downto 0) := "000";
	Constant Cont: std_LOGIC_vector(2 downto 0) := "001";
	Constant LigarLed: std_LOGIC_vector(2 downto 0) := "010";
	Constant MostrarTempo: std_LOGIC_vector(2 downto 0) := "011";
	Constant Erro: std_LOGIC_vector(2 downto 0) := "100";
	Constant Rapido: std_LOGIC_vector(2 downto 0) := "101";
	SIGNAL estado: std_LOGIC_vector(2 downto 0) := Inicio;
	begin
		PROCESS(clk, BTAP, BTInicio, TempoMaior2000, TempoMenor5000)
			BEGIN
				IF (clk'EVENT and clk='1') THEN
					CASE estado IS
						WHEN Inicio =>
							IF BTInicio = '0' THEN
								estado <= Cont;
							ELSE
								estado <= Inicio;
							END IF;
						WHEN Cont =>
							IF TempoMenor5000 = '0' THEN
								estado <= LigarLed;
							ELSIF TempoMenor5000 = '1' AND BTAP = '0' THEN
								estado <= Rapido;
							ELSE
								estado <= Cont;
							END IF;
						WHEN Rapido =>
							IF BTInicio = '0' THEN 
								estado <= Inicio;
							ELSE
								estado <= Rapido;
							END IF;
						WHEN LigarLed =>
							IF TempoMaior2000 = '1' THEN
								estado <= Erro;
							ELSIF TempoMaior2000 = '0' AND BTAP = '0' THEN 
								estado <= MostrarTempo;
							ELSE 
								estado <= LigarLed;
							END IF;
						WHEN Erro => 
							IF BTInicio = '0' THEN 
								estado <= Cont;
							ELSE 
								estado <= Erro;
							END IF;
						WHEN MostrarTempo =>
							IF BTInicio = '0' THEN
								estado <= Cont;
							ELSE 
								estado <= MostrarTempo;
							END IF;
						WHEN OTHERS =>
							estado <= Inicio;
					END CASE;			
				END IF;	
		END PROCESS;
		
		PROCESS(estado)
			BEGIN
				CASE estado IS
					WHEN Inicio =>
						CLR_Tempo <= '0';
						LEDAP <= '0';
						LEDR <= '0';
						LD_Tempo <= '0';
						Ld_TempoC <= '0';
						Clr_TempoC <= '1';
						sel <= "10";
					WHEN Cont =>
						LD_Tempo <= '1';
						CLR_TempoC <= '0';
						SEL <= "10";
						LEDAP <= '0';
						LEDR <= '0';
						Ld_TempoC <= '0';
						CLR_Tempo <= '0';
					WHEN Rapido =>
						LEDR <= '1';
						CLR_Tempo <= '1';
						LD_Tempo <= '0';
						LEDAP <= '0';
						Ld_TempoC <= '0';
						SEL <= "10";
						CLR_TempoC <= '1';
					WHEN LigarLed =>
						LEDAP <= '1';
						LD_TempoC <= '1';
						LD_Tempo <= '0';
						CLR_Tempo <= '1';
						LEDR <= '0';
						SEL <= "10";
						CLR_TempoC <= '0';
					WHEN Erro => 
						SEL <= "00";
						CLR_Tempo <= '0';
						LEDAP <= '0';
						LD_Tempo <= '0';
						LD_TempoC <= '0';
						CLR_TempoC <= '0';
						LEDR <= '0';
					WHEN MostrarTempo =>
						SEL <= "01";
						CLR_Tempo <= '0';
						LEDAP <= '0';
						LD_Tempo <= '0';
						LD_TempoC <= '0';
						CLR_TempoC <= '0';
						LEDR <= '0';
					WHEN OTHERS =>
						CLR_Tempo <= '0';
						LEDAP <= '0';
						LEDR <= '0';
						LD_Tempo <= '0';
						Ld_TempoC <= '0';
						Clr_TempoC <= '1';
						sel <= "10";
				END CASE;			
		END PROCESS;
end behav;