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
use ieee.math_real.all;	
	
------------------------------------------------------------------------------
-- Entity Declaration
------------------------------------------------------------------------------
entity power_sink_srl is
  generic(srl_size_g	: positive range 4 to integer'high := 32);		-- Use 32 for 7Series one SRL per FF
  port(clk_i		: in	std_logic;	
       rst_i		: in	std_logic;			
       en_i		: in	std_logic;
       ssr_i            : in	std_logic;
       ssr_o	        : out	std_logic);
end entity;
		
------------------------------------------------------------------------------
-- Architecture Declaration
------------------------------------------------------------------------------
architecture rtl of power_sink_srl is	

  signal srl_vector	: std_logic_vector(srl_size_g-1 downto 0);
  
  attribute srl_style : string;
  attribute srl_style of srl_vector : signal is "srl";

	
begin
  
  
  lut_ssr_pro : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if en_i = '1' then
        srl_vector <= srl_vector(srl_vector'left-1 downto 0) & ssr_i;
      end if;
    end if;
  end process;	

    
  reg_pro : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        ssr_o <= '0';
      else
        ssr_o <= srl_vector(srl_vector'left);
      end if;
    end if;
  end process;		

  
end;





