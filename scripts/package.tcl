##############################################################################
#  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
#  All rights reserved.
#  Authors: Oliver Bruendler
##############################################################################

###############################################################
# Include PSI packaging commands
###############################################################
source ../../../TCL/PsiIpPackage/PsiIpPackage.tcl
namespace import -force psi::ip_package::latest::*

###############################################################
# General Information
###############################################################
set IP_NAME power_sink
set IP_VERSION 1.0
set IP_REVISION "auto"
set IP_LIBRARY PSI
set IP_DESCIRPTION "Logic that wastes power for testing purposes"

init $IP_NAME $IP_VERSION $IP_REVISION $IP_LIBRARY
set_description $IP_DESCIRPTION
set_logo_relative "../doc/psi_logo_150.gif"
set_datasheet_relative "../doc/$IP_NAME.pdf"

###############################################################
# Add Source Files
###############################################################

#Relative Source Files
add_sources_relative { \
	../hdl/power_sink_ff.vhd \
	../hdl/power_sink_srl.vhd \
	../hdl/power_sink_bram.vhd \
	../hdl/power_sink_wrp.vhd \
}

#PSI Common
add_lib_relative \
	"../../../VHDL/psi_common/hdl"	\
	{ \
		psi_common_array_pkg.vhd \
		psi_common_math_pkg.vhd \
		psi_common_logic_pkg.vhd \
		psi_common_tdp_ram.vhd \
		psi_common_pulse_cc.vhd \
		psi_common_simple_cc.vhd \
		psi_common_status_cc.vhd \
		psi_common_pulse_cc.vhd \
		psi_common_pl_stage.vhd \
		psi_common_axi_slave_ipif.vhd \
	}

###############################################################
# Driver Files
###############################################################	

add_drivers_relative ../drivers/power_sink { \
	src/power_sink.c \
	src/power_sink.h \
}
	

###############################################################
# GUI Parameters
###############################################################

#User Parameters
gui_add_page "Configuration"

gui_create_parameter "FlipFlogs_g" "Number of Flip-Flops to toggle"
gui_parameter_set_range 1024 214783647
gui_add_parameter

gui_create_parameter "AddLuts_g" "Add luts between Flip-Flops"
gui_parameter_set_widget_checkbox
gui_add_parameter

gui_create_parameter "LutInputs_g" "Inputs for logic between Flip-Flops"
gui_parameter_set_range 2 30
gui_add_parameter


gui_create_parameter "SrlSize_g" "Number of bits per SRL"
gui_parameter_set_range 4 214783647
gui_add_parameter

gui_create_parameter "SrlCount_g" "Number of SRLs to toggle"
gui_parameter_set_range 4 214783647
gui_add_parameter

gui_create_parameter "BramDepth_g" "Depth of BRAMs to implement"
gui_parameter_set_range 4 214783647
gui_add_parameter

gui_create_parameter "BramWidth_g" "With of BRAMs to implement"
gui_parameter_set_range 4 63
gui_add_parameter

gui_create_parameter "BramCount_g" "Number of BRAMs to toggle"
gui_parameter_set_range 4 214783647
gui_add_parameter

###############################################################
# Optional Ports
###############################################################

#None

###############################################################
# Package Core
###############################################################
set TargetDir ".."
#											Edit  	Synth	
package_ip $TargetDir 						false 	true




