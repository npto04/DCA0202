library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port( 
		R_data: in std_logic_vector(15 downto 0);
		RF_sel: in std_logic_vector(1 downto 0);
		ALU_sel: in std_logic_vector(2 downto 0);
		RF_w_data: in std_logic_vector(7 downto 0);
		RF_w_addr, RF_rp_addr, RF_rq_addr: in std_logic_vector(3 downto 0);
		clk, W_wr, Rp_rd, Rq_rd: in std_logic;
		RF_rp_zero: out std_logic;
		W_data, RF_data: out std_logic_vector(15 downto 0)
	);
end datapath;

architecture arq of datapath is
	component ALU is
		port (			  
				  a,b: in std_logic_vector(15 downto 0);
				  sel: in std_logic_vector(2 downto 0);
				  s: out std_logic_vector(15 downto 0)
			 );
	end component;
	
	component Register_File IS
		PORT
		(
			clk, w_wr, Rp_rd, Rq_rd: in std_logic;
			w_addr, Rq_addr, Rp_addr: in std_logic_vector(3 downto 0);
			w_data: in std_logic_vector(15 downto 0);
			Rq_data, Rp_data: out std_logic_vector(15 downto 0)
		);
	END component;
	
	component equalZero is
		generic(n : integer := 4);
		port (			  
				  a: in std_logic_vector(n-1 downto 0);
				  s: out std_logic
		);
	end component;
	
	component mux3x1 is
		generic (n : integer := 7);
		port (
			i0, i1, i2: in std_logic_vector(n-1 downto 0);
			Sel: in std_logic_vector(1 downto 0);
			S : out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	signal alu_data, s_RF_data, Rp_data, Rq_data : std_logic_vector(15 downto 0);
	
begin
	i0: mux3x1 generic map (16) port map (alu_data,R_data,RF_w_data,RF_sel,s_RF_data);
	RF_data <= s_RF_data;
	i1: Register_File port map (clk, w_wr, Rp_rd, Rq_rd, RF_w_addr, RF_Rq_addr, RF_Rp_addr, s_RF_data, Rq_data, Rp_data);
	i2: alu port map (Rp_data, Rq_data, ALU_sel, alu_data);
	i3: equalZero generic map (16) port map (Rp_data, RF_rp_zero);
	w_data <= Rp_data;

end arq;