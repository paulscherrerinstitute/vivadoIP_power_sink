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
entity power_sink_ff is
	generic (
		FlipFlogs_g	: positive range 64 to integer'high	:= 8192
	);
	port (
		-- Control Signals
		Clk			: in	std_logic;	
		Rst			: in	std_logic;	
		
		-- Pattern Interface
		Enable		: in	std_logic;
		PatternSet	: in	std_logic;
		PatternIn	: in	std_logic_vector(31 downto 0);
		PatternOut	: out	std_logic_vector(31 downto 0)
	);
end entity;
		
------------------------------------------------------------------------------
-- Architecture Declaration
------------------------------------------------------------------------------
architecture rtl of power_sink_ff is	
	attribute S						: string;
	attribute keep					: string;
	attribute dont_touch			: string;

	signal PatternGen				: std_logic_vector(31 downto 0);
	signal FfChain					: std_logic_vector(FlipFlogs_g-1 downto 0);
	
	attribute keep of FfChain 		: signal is "true";
	attribute S of FfChain 			: signal is "true";
	attribute dont_touch of FfChain : signal is "true";

	
begin

	p_impl : process(Clk)
	begin
		if rising_edge(Clk) then
		
			if Enable = '1' then
				PatternGen 	<= PatternGen(30 downto 0) & PatternGen(31);
				FfChain 	<= FfChain(FlipFlogs_g-2 downto 0) & PatternGen(31);
				PatternOut 	<= FfChain(FlipFlogs_g-1 downto FlipFlogs_g-32);
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





