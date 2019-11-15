------------------------------------------------------------------------------
--  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
--  All rights reserved.
--  Authors: Oliver Bruendler
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Description
------------------------------------------------------------------------------

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
entity power_sink_dsp is
	generic (
		InAWidth_g	: positive range 1 to 32			:= 18;
		InBWidth_g	: positive range 1 to 32			:= 25;
		AccuWidth_g	: positive range 1 to 64			:= 48;
		DspCount_g	: positive							:= 20
	);
	port (
		-- Control Signals
		Clk			: in	std_logic;	
		Rst			: in	std_logic;	
		
		-- Pattern Interface
		Enable		: in	std_logic;
		PatternInA1	: in	std_logic_vector(31 downto 0);
		PatternInA2	: in	std_logic_vector(31 downto 0);
		PatternInB1	: in	std_logic_vector(31 downto 0);
		PatternInB2	: in	std_logic_vector(31 downto 0);
		PatternOut	: out	std_logic_vector(31 downto 0)
	);
end entity;
		
------------------------------------------------------------------------------
-- Architecture Declaration
------------------------------------------------------------------------------
architecture rtl of power_sink_dsp is	
	
	signal PatternCnt 	: integer range 0 to 3;
	signal MultInA		: std_logic_vector(InAWidth_g-1 downto 0);
	signal MultInB		: std_logic_vector(InBWidth_g-1 downto 0);
	type InA_t is array (natural range <>) of std_logic_vector(InAWidth_g-1 downto 0);
	signal InAChain		: InA_t(0 to DspCount_g);
	type InB_t is array (natural range <>) of std_logic_vector(InBWidth_g-1 downto 0);
	signal InBChain		: InB_t(0 to DspCount_g);
	signal EnaChain		: std_logic_vector(0 to DspCount_g-1);
	type Sum_t is array (natural range <>) of std_logic_vector(AccuWidth_g-1 downto 0);
	signal SumChain		: Sum_t(0 to DspCount_g);

	
begin

	p_impl : process(Clk)
	begin
		if rising_edge(Clk) then
		
			if Enable = '1' then
				if PatternCnt = 3 then
					PatternCnt <= 0;
				else
					PatternCnt <= PatternCnt + 1;
				end if;
				
				case PatternCnt is
					when 0 => 	MultInA <= PatternInA1(InAWidth_g-1 downto 0);
								MultInB	<= PatternInB1(InBWidth_g-1 downto 0);
					when 1 =>	MultInA	<= PatternInA2(InAWidth_g-1 downto 0);
								MultInB	<= PatternInB1(InBWidth_g-1 downto 0);
					when 2 => 	MultInA	<= PatternInA2(InAWidth_g-1 downto 0);
								MultInB	<= PatternInB2(InBWidth_g-1 downto 0);
					when 3 =>	MultInA	<= PatternInA1(InAWidth_g-1 downto 0);
								MultInB	<= PatternInB2(InBWidth_g-1 downto 0);
					when others => null;
				end case;

			end if;
			EnaChain(0)	<= Enable;
			EnaChain(1 to EnaChain'high) <= EnaChain(0 to EnaChain'high-1);
			
			if AccuWidth_g <= 32 then
				PatternOut <= SumChain(DspCount_g)(AccuWidth_g-1 downto 0);
			else
				PatternOut <= SumChain(DspCount_g)(31 downto 0) xor (ZerosVector(64-AccuWidth_g) & SumChain(DspCount_g)(AccuWidth_g-1 downto 32));
			end if;
		
			if Rst = '1' then
				PatternCnt <= 0;
			end if;
			
		end if;
	end process;	
	

	InAChain(0) <= MultInA;
	InBChain(0) <= MultInB;
	SumChain(0) <= (others => '0');
	
	-- VHDL Implementation of the usual Xilinx DSP Slice architecture
	g_dsp_chain : for i in 0 to DspCount_g-1 generate
		signal AReg : InA_t(0 to 1);
		signal BReg : InB_t(0 to 1);
		signal Mult : std_logic_vector(InAWidth_g+InBWidth_g-1 downto 0);
		signal Sum 	: std_logic_vector(AccuWidth_g-1 downto 0);
	begin
		p_dsp : process(Clk)
		begin
			if rising_edge(Clk) then
				if EnaChain(i) = '1' then
					AReg(0) <= InAChain(i);
					AReg(1) <= AReg(0);
					BReg(0) <= InBChain(i);
					BReg(1) <= BReg(0);
					Mult <= std_logic_vector(signed(AReg(1)) * signed(BReg(1)));
					Sum <= std_logic_vector(signed(SumChain(i)) + signed(Mult));		
				else
					AReg <= (others => (others => '0'));
					BReg <= (others => (others => '0'));
					Mult <= (others => '0');
					Sum <= (others => '0');
				end if;
			end if;
		end process;
		
		SumChain(i+1) <= Sum;
		InAChain(i+1) <= AReg(0);
		InBChain(i+1) <= BReg(0);
	end generate;
	
end;





