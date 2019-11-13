------------------------------------------------------------------------------
--  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
--  All rights reserved.
--  Authors: Oliver Bruendler
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Description
------------------------------------------------------------------------------
-- This entity implement a non-optimizable FF chain to drain power for testing
-- purposes

------------------------------------------------------------------------------
-- Libraries
------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;	
	
library work;
    use work.psi_common_logic_pkg.all;
    use work.psi_common_math_pkg.all;
	
------------------------------------------------------------------------------
-- Entity Declaration
------------------------------------------------------------------------------
entity power_sink_bram is
	generic (
		BramDepth_g	: positive range 4 to integer'high 	:= 1024;
		BramWidth_g	: positive range 4 to 63 			:= 18;
		BramCount_g	: positive range 4 to integer'high	:= 64;
		Behavior_g	: string							:= "RBW"	-- "RBW" = read-before-write, "WBR" = write-before-read
	);
	port (
		-- Control Signals
		Clk			: in	std_logic;	
		Rst			: in	std_logic;	
		
		-- Pattern Interface
		Enable		: in	std_logic;
		PatternSet	: in	std_logic;
		PatternIn	: in	std_logic_vector(31 downto 0);
		PatternOutA	: out	std_logic_vector(31 downto 0);
		PatternOutB	: out	std_logic_vector(31 downto 0)
	);
end entity;
		
------------------------------------------------------------------------------
-- Architecture Declaration
------------------------------------------------------------------------------
architecture rtl of power_sink_bram is	

	signal PatternGen				: std_logic_vector(63 downto 0);
	type Data_t is array (natural range <>) of std_logic_vector(BramWidth_g-1 downto 0);
	signal DataA					: Data_t(0 to BramCount_g);
	signal DataB					: Data_t(0 to BramCount_g);
	signal AddrCnt					: std_logic_vector(log2ceil(BramDepth_g)-1 downto 0);
	type Addr_t is array (natural range <>) of std_logic_vector(log2ceil(BramDepth_g)-1 downto 0);
	signal AddrA					: Addr_t(0 to BramCount_g-1);
	signal AddrB					: Addr_t(0 to BramCount_g-1);
	
begin

	p_impl : process(Clk)
	begin
		if rising_edge(Clk) then
		
			if Enable = '1' then
				PatternGen 	<= PatternGen(62 downto 0) & PatternGen(63);
				AddrCnt		<= std_logic_vector(unsigned(AddrCnt)+1);
				PatternOutA <= (others => '0');
				if BramWidth_g <= 32 then
					PatternOutA(BramWidth_g-1 downto 0) <= DataA(DataA'high);
					PatternOutB(BramWidth_g-1 downto 0) <= DataB(DataA'high);
				else
					PatternOutA <= DataA(DataA'high)(31 downto 0) xor (DataA(DataA'high)(BramWidth_g-1 downto 32) & ZerosVector(64-BramWidth_g));
					PatternOutB <= DataB(DataB'high)(31 downto 0) xor (DataB(DataA'high)(BramWidth_g-1 downto 32) & ZerosVector(64-BramWidth_g));					
				end if;
			end if;
			
			AddrA(0) <= AddrCnt;
			AddrA(1 to BramCount_g-1) <= AddrA(0 to BramCount_g-2);
			AddrB(0) <= not AddrCnt(AddrCnt'high) & AddrCnt(AddrCnt'high-1 downto 0);
			AddrB(1 to BramCount_g-1) <= AddrB(0 to BramCount_g-2);
		
			if PatternSet = '1' then
				PatternGen <= PatternIn & PatternIn;
			end if;
			
		
			if Rst = '1' then
				PatternGen 	<= X"AAAA_AAAA_AAAA_AAAA";
				AddrCnt		<= (others => '0');
			end if;
			
		end if;
	end process;	
	
	DataA(0) <= PatternGen(BramWidth_g-1 downto 0);
	DataB(0) <= PatternGen(PatternGen'high downto PatternGen'high-BramWidth_g+1);
	
	g_bram : for i in 0 to BramCount_g-1 generate
		i_ram : entity work.psi_common_tdp_ram
			generic map (
				Depth_g		=> BramDepth_g,
				Width_g		=> BramWidth_g,
				Behavior_g	=> Behavior_g
			)
			port map (
				ClkA		=> Clk,
				AddrA		=> AddrA(i),
				WrA			=> '1',
				DinA		=> DataA(i),
				DoutA		=> DataA(i+1),
				ClkB		=> Clk,
				AddrB		=> AddrB(i),
				WrB			=> '1',
				DinB		=> DataB(i),
				DoutB		=> DataB(i+1)
			);
		end generate;
	
end;





