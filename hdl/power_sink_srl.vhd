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
  generic(srl_size_g	: positive range 4 to integer'high 	:= 32;		-- Use 32 for 7Series one SRL per FF
          srl_count_g	: positive range 4 to integer'high	:= 1024);
  port(clk_i		: in	std_logic;	
       rst_i		: in	std_logic;			
    -- Pattern Interface
       en_i		: in	std_logic;
       set_i	        : in	std_logic;
       pattern_i        : in	std_logic_vector(31 downto 0);
       ssr_o	        : out	std_logic);
end entity;
		
------------------------------------------------------------------------------
-- Architecture Declaration
------------------------------------------------------------------------------
architecture rtl of power_sink_srl is	

  constant n_in_fanout          : integer       := 128;  --just to help placement and timing
  constant n_rst_en             : integer       := integer(ceil(real(srl_count_g)/real(n_in_fanout)));                                                   
  signal rst_vec	        : std_logic_vector(n_rst_en-1 downto 0);
  signal en_vec	        	: std_logic_vector(n_rst_en-1 downto 0);
  signal pattern		: std_logic_vector(31 downto 0);
  signal ssr_input  		: std_logic_vector(srl_count_g-1 downto 0);
  signal ssr_output  		: std_logic_vector(srl_count_g-1 downto 0);

	
begin

  
  control_io_pro : process(clk_i)
  begin
    if rising_edge(clk_i) then
      rst_vec <= rst_vec(rst_vec'left-1 downto 0) & rst_i;  --just to help placement and timing
      en_loop : for i in 0 to en_vec'left loop
        en_vec(i)  <= not rst_vec(i) and en_i;              --just to help placement and timing
      end loop en_loop;

      if rst_i = '1' then
        pattern <= X"AAAA_AAAA";
      elsif set_i = '1' then
        pattern <= pattern_i;
      elsif en_vec(0) = '1' then
        pattern <= pattern(30 downto 0) & pattern(31);
      end if;

    end if;
  end process control_io_pro;

  
  ssr_input <= ssr_output(ssr_output'left-1 downto 0) & pattern(31);

  
  ssr_lut_reg_gen : for i in 0 to srl_count_g-1 generate
    constant num        : integer  := i/n_in_fanout;       
    signal srl_vector	: std_logic_vector(srl_size_g-1 downto 0);
  
    attribute srl_style : string;
    attribute srl_style of srl_vector : signal is "srl";

  begin

    lut_ssr_pro : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if en_vec(num) = '1' then
          srl_vector <= srl_vector(srl_vector'left-1 downto 0) & ssr_input(i);
        end if;
      end if;
    end process;	

    
    reg_pro : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if rst_vec(num) = '1' then
          ssr_output(i) <= '0';
        else
          ssr_output(i) <= srl_vector(srl_vector'left);
        end if;
      end if;
    end process;		

  end generate ssr_lut_reg_gen;	


  ssr_o <= ssr_output(ssr_output'left);

  
end;





