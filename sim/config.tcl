##############################################################################
#  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
#  All rights reserved.
#  Authors: Oliver Bruendler
##############################################################################

#Constants
set LibPath "../../.."
namespace import psi::sim::*

#Set library
psi::sim::add_library power_sink

#suppress messages
psi::sim::compile_suppress 135,1236
psi::sim::run_suppress 8684,3479,3813,8009,3812

# libraries
psi::sim::add_sources "$LibPath/VHDL/psi_common/hdl" {
	psi_common_array_pkg.vhd \
	psi_common_math_pkg.vhd \
	psi_common_logic_pkg.vhd \
	psi_common_tdp_ram.vhd  \
	psi_common_pulse_cc.vhd  \
	psi_common_simple_cc.vhd  \
	psi_common_status_cc.vhd  \
	psi_common_pl_stage.vhd \
	psi_common_axi_slave_ipif.vhd \
} -tag lib

# psi_tb_v1_0	
psi::sim::add_sources "$LibPath/VHDL/psi_tb/hdl" {
	psi_tb_txt_util.vhd \
	psi_tb_compare_pkg.vhd \
	psi_tb_axi_pkg.vhd \
} -tag lib

# project sources
psi::sim::add_sources "../hdl" {
	power_sink_ff.vhd \
	power_sink_srl.vhd \
	power_sink_bram.vhd \
	power_sink_dsp.vhd \
	power_sink_wrp.vhd \
} -tag src

#testbenches
psi::sim::add_sources "../tb" {
	top_tb.vhd \
} -tag tb
	
#TB Runs
psi::sim::create_tb_run "top_tb"
psi::sim::add_tb_run