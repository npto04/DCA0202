library ieee;
use ieee.std_logic_1164.all;

entity control_unity is
	port(
		clk, RF_Rp_zero, bt1, bt2 : in std_logic;
		data: in std_logic_vector(15 downto 0);
		I_rd, D_rd, D_wr, W_wr, Rp_rd, Rq_rd : out std_logic;
		RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0);
		RF_W_data, D_addr : out std_logic_vector(7 downto 0);
		alu_sel, RF_sel, sel : out std_logic_vector(1 downto 0);
		addr: out std_logic_vector(15 downto 0)
	);
end control_unity;

architecture arq of control_unity is
	component IR is
		port( entrada : in std_logic_vector(15 downto 0);
				ld, clk : in std_logic;
				saida : out std_logic_vector(15 downto 0));
	end component;
	
	component PC is
		port( jmp_addr : in std_logic_vector(15 downto 0);
			ld, up, clk, clr : in std_logic;
			saida : out std_logic_vector(15 downto 0));
	end component;
	
	component BCproc is
		port (
			RF_Rp_zero, clk, bt1, bt2: in std_logic;
			IR: in std_logic_vector(15 downto 0);
			I_rd, PC_ld, PC_clr, PC_inc, IR_ld, D_rd, D_wr, W_wr, Rp_rd, Rq_rd: out std_logic;
			RF_s, sel : out std_logic_vector(1 downto 0);
			alu_s : out std_logic_vector(2 downto 0);
			RF_W_addr, RF_Rp_addr, RF_Rq_addr: out std_logic_vector(3 downto 0);
			RF_W_data, D_addr: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component adderJmp is
		port 
		(
			a: in std_logic_vector(7 downto 0);
			b: in std_logic_vector(7 downto 0);
			result: out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal IR_ld, PC_ld, PC_inc, PC_clr: std_logic;
	signal IR: std_logic_vector(15 downto 0);
	signal jmp_addr, PC_addr: std_logic_vector(15 downto 0) := (others => '0');
	
	begin
		i0: IR port map (data, ld, clk, IR);
		
		i1: adderJmp port map (IR(7 downto 0), PC_addr(7 downto 0), jmp_addr(7 downto 0));
		
		i2: PC port map (jmp_addr, PC_ld, PC_inc, clk, PC_clr, PC_addr);
		
		addr <= PC_addr;
		
		i3: BC port map (RF_Rp_zero, clk, bt1, bt2, IR, I_rd, PC_ld, PC_inc, IR_ld, D_rd, 
			D_wr, W_wr, Rp_rd, Rq_rd, RF_sel, sel, alu_sel, RF_W_addr, RF_Rp_addr, RF_Rq_addr, RF_W_data, D_addr);
		

end arq;