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
	
------------------------------------------------------------------------------
-- Entity Declaration
------------------------------------------------------------------------------
entity power_sink_srl is
	generic (
		SrlSize_g	: positive range 4 to integer'high 	:= 32;		-- Use 32 for 7Series one SRL per FF
		SrlCount_g	: positive range 4 to integer'high	:= 1024
	);
	port (
		-- Control Signals
		Clk			: in	std_logic;	
		Rst			: in	std_logic;	
		
		-- Pattern Interface
		Enable		: in	std_logic;
		PatternSet	: in	std_logic;
		PatternIn	: in	std_logic_vector(31 downto 0);
		PatternOut	: out	std_logic
	);
end entity;
		
------------------------------------------------------------------------------
-- Architecture Declaration
------------------------------------------------------------------------------
architecture rtl of power_sink_srl is	
	attribute srl_style : string;

	signal PatternGen				: std_logic_vector(31 downto 0);
	signal SrlChain					: std_logic_vector(SrlSize_g*SrlCount_g-1 downto 0);
	
	attribute srl_style of SrlChain : signal is "srl";

	
begin

	p_impl : process(Clk)
	begin
		if rising_edge(Clk) then
		
			if Enable = '1' then
				PatternGen 	<= PatternGen(30 downto 0) & PatternGen(31);
				SrlChain 	<= SrlChain(SrlChain'high-1 downto 0) & PatternGen(31);
				PatternOut 	<= SrlChain(SrlChain'high);
			end if;
		
			if PatternSet = '1' then
				PatternGen <= PatternIn;
			end if;
		
			if Rst = '1' then
				PatternGen <= X"AAAA_AAAA";
			end if;
		end if;
	end process;	
	
end;





