LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
--USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY segmentos IS
  PORT (entrada : IN STD_LOGIC_VECTOR(13 DOWNTO 0);        
        saida1, saida2, saida3, saida4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); 
END segmentos;

ARCHITECTURE behav OF segmentos IS

SIGNAL x : INTEGER range 0 TO 2048;
SIGNAL display1 : INTEGER range 0 TO 15;
SIGNAL display2 : INTEGER range 0 TO 15;
SIGNAL display3 : INTEGER range 0 TO 15;
SIGNAL display4 : INTEGER range 0 TO 15;
SIGNAL y : UNSIGNED (13 DOWNTO 0);

BEGIN
	
  PROCESS(entrada)	
	BEGIN
		y <= UNSIGNED (entrada);
		x <= TO_INTEGER(y);
		display4 <= (x / 1000);
		display3 <= ((x - (display4*1000))/100);
		display2 <= ((x - (display4*1000) - (display3*100))/10);
		display1 <= (x - (display4*1000) - (display3*100) - (display2*10));
		CASE display4 IS
			WHEN 1 =>
				saida3 <= "1111001";				
			WHEN 2 =>
				saida3 <= "0100100";				
			WHEN 3 =>
				saida3 <= "0110000";				
			WHEN 4 =>
				saida3 <= "0011001";				
			WHEN 5 =>
				saida3 <= "0010010";					
			WHEN 6 =>
				saida3 <= "0000010";					
			WHEN 7 =>
				saida3 <= "1111000";					
			WHEN 8 =>
				saida3 <= "0000000";				
			WHEN 9 =>
				saida3 <= "0010000";
			WHEN OTHERS =>
				saida3 <= "1000000";
		END CASE;
		
		CASE display3 IS
			WHEN 1 =>
				saida3 <= "1111001";				
			WHEN 2 =>
				saida3 <= "0100100";				
			WHEN 3 =>
				saida3 <= "0110000";				
			WHEN 4 =>
				saida3 <= "0011001";				
			WHEN 5 =>
				saida3 <= "0010010";					
			WHEN 6 =>
				saida3 <= "0000010";					
			WHEN 7 =>
				saida3 <= "1111000";					
			WHEN 8 =>
				saida3 <= "0000000";				
			WHEN 9 =>
				saida3 <= "0010000";
			WHEN OTHERS =>
				saida3 <= "1000000";
		END CASE;
		
		CASE display2 IS
			WHEN 1 =>
				saida2 <= "1111001";				
			WHEN 2 =>
				saida2 <= "0100100";				
			WHEN 3 =>
				saida2 <= "0110000";				
			WHEN 4 =>
				saida2 <= "0011001";				
			WHEN 5 =>
				saida2 <= "0010010";					
			WHEN 6 =>
				saida2 <= "0000010";					
			WHEN 7 =>
				saida2 <= "1111000";					
			WHEN 8 =>
				saida2 <= "0000000";				
			WHEN 9 =>
				saida2 <= "0010000";
			WHEN OTHERS =>
				saida2 <= "1000000";
		END CASE;
		
		CASE display1 IS
			WHEN 1 =>
				saida1 <= "1111001";				
			WHEN 2 =>
				saida1 <= "0100100";				
			WHEN 3 =>
				saida1 <= "0110000";				
			WHEN 4 =>
				saida1 <= "0011001";				
			WHEN 5 =>
				saida1 <= "0010010";					
			WHEN 6 =>
				saida1 <= "0000010";					
			WHEN 7 =>
				saida1 <= "1111000";					
			WHEN 8 =>
				saida1 <= "0000000";				
			WHEN 9 =>
				saida1 <= "0010000";
			WHEN OTHERS =>
				saida1 <= "1000000";		
		END CASE;						
	END PROCESS;
END behav; 