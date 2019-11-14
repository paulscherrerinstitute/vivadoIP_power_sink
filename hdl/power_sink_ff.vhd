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
		FlipFlogs_g	: positive range 1024 to integer'high	:= 8192;
		AddLuts_g	: boolean								:= true;
		LutInputs_g	: integer range 2 to 30					:= 30
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
		variable NonLutFfs_c	: integer	:= LutInputs_g*32;
		variable LutOutput_v 	: std_logic_vector(FlipFlogs_g-NonLutFfs_c-1 downto 0);
	begin
		if rising_edge(Clk) then
		
			if Enable = '1' then
				PatternGen 	<= PatternGen(30 downto 0) & PatternGen(31);
				if not AddLuts_g then
					FfChain 	<= FfChain(FlipFlogs_g-2 downto 0) & PatternGen(31);
				else
					-- Add LUT before each FF
					FfChain(NonLutFfs_c-1 downto 0)		<= 	FfChain(NonLutFfs_c-2 downto 0) & PatternGen(31);
					LutOutput_v := FfChain(FfChain'high-NonLutFfs_c-1 downto 0) & PatternGen(31);
					for i in 1 to LutInputs_g-1 loop
						LutOutput_v := LutOutput_v and FfChain(FfChain'high-NonLutFfs_c+32*i-1 downto 32*i-1);
					end loop;					
					FfChain(FfChain'high downto NonLutFfs_c)	<= 	LutOutput_v;
				end if;
					
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





