library ieee;
use ieee.std_logic_1164.all;

entity BCproc is
port (
	RF_Rp_zero, clk, bt1, bt2: in std_logic;
	IR: in std_logic_vector(15 downto 0);
	I_rd, PC_ld, PC_clr, PC_inc, IR_ld, D_rd, D_wr, W_wr, Rp_rd, Rq_rd: out std_logic;
	RF_s, sel : out std_logic_vector(1 downto 0);
	alu_s : out std_logic_vector(2 downto 0);
	RF_W_addr, RF_Rp_addr, RF_Rq_addr: out std_logic_vector(3 downto 0);
	RF_W_data, D_addr: out std_logic_vector(7 downto 0)
);
end BCproc;

architecture arc of BCproc is	

CONSTANT Init : std_logic_vector(4 downto 0) := "00000";
CONSTANT Fetch : std_logic_vector(4 downto 0) := "00001";
CONSTANT Decode : std_logic_vector(4 downto 0) := "00010";
CONSTANT Load : std_logic_vector(4 downto 0) := "10000";
CONSTANT Store : std_logic_vector(4 downto 0) := "10001";
CONSTANT Add : std_logic_vector(4 downto 0) := "10010";
CONSTANT Load_constant : std_logic_vector(4 downto 0) := "10011";
CONSTANT Subtract : std_logic_vector(4 downto 0) := "10100";
CONSTANT Jump_if_zero : std_logic_vector(4 downto 0) := "10101";
CONSTANT Jump_if_zero_jmp : std_logic_vector(4 downto 0) := "10110";
CONSTANT l_or : std_logic_vector(4 downto 0) := "10111";
CONSTANT l_and : std_logic_vector(4 downto 0) := "11000";
CONSTANT l_not : std_logic_vector(4 downto 0) := "11001";
CONSTANT l_xnor : std_logic_vector(4 downto 0) := "11010";
SIGNAL estado : std_logic_vector(4 downto 0) := Init;

begin
	process(clk)
		begin
			if(clk'event and clk='1') then
				case (estado) is
					when Init =>
						estado <= Fetch;
					when Fetch =>
						estado <= Decode;
					when Decode =>
						if (bt1='0') then
							if (IR(15 downto 12) = Load) then
								estado <= Load;
							else if (IR(15 downto 12) = Store) then
								estado <= Store;
							else if (IR(15 downto 12) = Add) then
								estado <= Add;
							else if (IR(15 downto 12) = Load_constant) then
								estado <= Load_constant;
							else if (IR(15 downto 12) = Subtract) then
								estado <= Subtract;
							else if (IR(15 downto 12) = Jump_if_zero) then
								estado <= Jump_if_zero;
							else if (IR(15 downto 12) = Jump_if_zero_jmp) then
								estado <= Jump_if_zero_jmp;
							else if (IR(15 downto 12) = l_or) then
								estado <= l_or;
							else if (IR(15 downto 12) = l_and) then
								estado <= l_and;
							else if (IR(15 downto 12) = l_not) then
								estado <= l_not;
							else if (IR(15 downto 12) = l_xnor) then
								estado <= l_xnor;
							end if;
						end if;
					when Jump_if_zero =>
						if(bt2 = '0') then
							if(RF_Rp_zero = '1') then
								estado <= Jump_if_zero_jmp;
							else
								estado <= Fetch;
							end if;
						end if;
					when others=>
						if(bt2='0') then
							estado <= Fetch;
						end if
				end case;
			end if;
	end process;
	I_rd <= '1' when estado = Fetch else '0';
	PC_inc <= '1' when estado = Fetch else '0';
	IR_ld <= '1' when estado = Fetch else '0';
	PC_ld <= '1' when estado = Jump_if_zero_jmp else '0';
	PC_clr <= '1' when estado = Init else '0';
	D_rd <= '1' when estado = Load else '0';
	D_wr <= '1' when estado = Store else '0';
	with(estado) select
	W_wr <= '1' when Add or Load or Load_constant or Subtract or l_and or l_or or l_not or l_xnor,
				'0' when others;
	with(estado) select
	RP_rd <= '1' when Store or Add or Subtract or jump_if_zero or l_and or l_or or l_not or l_xnor,
				'0' when others;
	Rq_rd <= '1' when estado = Add or estado = Subtract or estado = l_and or estado = l_or or estado = l_xnor else '0';
	RF_s <= "00" when estado = Add or estado = Subtract or estado = l_and or estado = l_or or estado = l_xnor estado = l_not else
			  "01" when estado = Load else
	  		  "10" when estado = Load_constant;
	with(estado) select
	alu_s <= "001" when Add,
				"010" when Subtract,
				"011" when l_not,
				"100" when l_and,
				"101" when l_or,
				"110" when l_xnor,
				"000" when others;
	RF_Rp_addr <= IR(11 downto 8) when estado = Store or estado = jump_if_zero else
					(others => '-') when estado = load or estado = load_constant else
					IR(7 downto 4);
	RF_Rq_addr <= IR(3 downto 0) when estado = Add or estado = Subtract or estado = l_and or estado = l_or or estado = l_xnor else (others => '-');
	with(estado) select
	RF_W_addr <= IR(11 downto 8) when Add or Load or Load_constant or Subtract or l_and or l_or or l_not or l_xnor,
				(others => '-') when others;
	D_addr <= IR(7 downto 0) when estado = load or estado = load_constant else (others => '-');
	RF_W_data <= IR(7 downto 0) when estado = load_constant else (others => '-');
	--sel <=
end arc;