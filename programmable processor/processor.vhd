LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY processor IS
	PORT
	(
		bt1, bt2, clk : IN STD_LOGIC;
		LEDs: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END processor;


ARCHITECTURE SYN OF processor IS
	COMPONENT mux3x1 is
		generic (n : integer := 7);
		port (
			i0, i1, i2: in std_logic_vector(n-1 downto 0);
			Sel: in std_logic_vector(1 downto 0);
			S : out std_logic_vector(n-1 downto 0)
		);
	end COMPONENT;
	
	COMPONENT RAM IS
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT datapath is
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
	end COMPONENT;
	
	COMPONENT Instr_memory IS
		GENERIC(n : INTEGER := 1);
		PORT
		(
			addr: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			rd: IN STD_LOGIC;
			data: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT control_unity is
		port(
			clk, RF_Rp_zero, bt1, bt2 : in std_logic;
			data: in std_logic_vector(15 downto 0);
			I_rd, D_rd, D_wr, W_wr, Rp_rd, Rq_rd : out std_logic;
			RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0);
			RF_W_data, D_addr : out std_logic_vector(7 downto 0);
			alu_sel : out std_logic_vector(2 downto 0);
			RF_sel, sel : out std_logic_vector(1 downto 0);
			addr: out std_logic_vector(15 downto 0)
		);
	end COMPONENT;
	--IMPLEMENTAR SEL(MUX DE LEDs) no BC
	SIGNAL addr, RF_data, w_data, R_data, data: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL sel, RF_sel: STD_LOGIC_VECTOR(1 DOWNTO 0); 
	SIGNAL ALU_sel: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL RF_w_data, D_addr: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL RF_w_addr, RF_rp_addr, RF_rq_addr: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL I_rd, D_rd, D_wr, W_wr, Rp_rd, Rq_rd, RF_rp_zero: STD_LOGIC;
	BEGIN
		i1: instr_memory generic map(6) port map (addr, I_rd, data);
		i2: control_unity port map(clk, RF_Rp_zero, BT1, BT2, data, I_rd, D_rd, D_wr, W_wr, Rp_rd, Rq_rd, 
			RF_w_addr, RF_rp_addr, RF_rq_addr, RF_w_data, D_addr, ALU_sel, RF_sel, sel, addr);
		i3: RAM port map(D_addr, clk, w_data, D_rd or D_wr, R_data);
		i4: datapath port map(R_data,	RF_sel, ALU_sel, RF_w_data, RF_w_addr, RF_rp_addr, RF_rq_addr,	
			clk, W_wr, Rp_rd, Rq_rd, RF_rp_zero, w_data, RF_data);
		i5: mux3x1 generic map(16) port map(RF_data, w_data,(others => '0'),sel,LEDs);
END SYN;
