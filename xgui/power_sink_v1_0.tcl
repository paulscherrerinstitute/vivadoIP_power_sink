# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Configuration [ipgui::add_page $IPINST -name "Configuration"]
  ipgui::add_param $IPINST -name "FlipFlogs_g" -parent ${Configuration}
  ipgui::add_param $IPINST -name "SrlSize_g" -parent ${Configuration}
  ipgui::add_param $IPINST -name "SrlCount_g" -parent ${Configuration}
  ipgui::add_param $IPINST -name "BramDepth_g" -parent ${Configuration}
  ipgui::add_param $IPINST -name "BramWidth_g" -parent ${Configuration}
  ipgui::add_param $IPINST -name "BramCount_g" -parent ${Configuration}


}

proc update_PARAM_VALUE.BramCount_g { PARAM_VALUE.BramCount_g } {
	# Procedure called to update BramCount_g when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BramCount_g { PARAM_VALUE.BramCount_g } {
	# Procedure called to validate BramCount_g
	return true
}

proc update_PARAM_VALUE.BramDepth_g { PARAM_VALUE.BramDepth_g } {
	# Procedure called to update BramDepth_g when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BramDepth_g { PARAM_VALUE.BramDepth_g } {
	# Procedure called to validate BramDepth_g
	return true
}

proc update_PARAM_VALUE.BramWidth_g { PARAM_VALUE.BramWidth_g } {
	# Procedure called to update BramWidth_g when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BramWidth_g { PARAM_VALUE.BramWidth_g } {
	# Procedure called to validate BramWidth_g
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ID_WIDTH { PARAM_VALUE.C_S00_AXI_ID_WIDTH } {
	# Procedure called to update C_S00_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ID_WIDTH { PARAM_VALUE.C_S00_AXI_ID_WIDTH } {
	# Procedure called to validate C_S00_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.FlipFlogs_g { PARAM_VALUE.FlipFlogs_g } {
	# Procedure called to update FlipFlogs_g when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FlipFlogs_g { PARAM_VALUE.FlipFlogs_g } {
	# Procedure called to validate FlipFlogs_g
	return true
}

proc update_PARAM_VALUE.SrlCount_g { PARAM_VALUE.SrlCount_g } {
	# Procedure called to update SrlCount_g when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SrlCount_g { PARAM_VALUE.SrlCount_g } {
	# Procedure called to validate SrlCount_g
	return true
}

proc update_PARAM_VALUE.SrlSize_g { PARAM_VALUE.SrlSize_g } {
	# Procedure called to update SrlSize_g when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SrlSize_g { PARAM_VALUE.SrlSize_g } {
	# Procedure called to validate SrlSize_g
	return true
}


proc update_MODELPARAM_VALUE.FlipFlogs_g { MODELPARAM_VALUE.FlipFlogs_g PARAM_VALUE.FlipFlogs_g } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FlipFlogs_g}] ${MODELPARAM_VALUE.FlipFlogs_g}
}

proc update_MODELPARAM_VALUE.SrlSize_g { MODELPARAM_VALUE.SrlSize_g PARAM_VALUE.SrlSize_g } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SrlSize_g}] ${MODELPARAM_VALUE.SrlSize_g}
}

proc update_MODELPARAM_VALUE.SrlCount_g { MODELPARAM_VALUE.SrlCount_g PARAM_VALUE.SrlCount_g } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SrlCount_g}] ${MODELPARAM_VALUE.SrlCount_g}
}

proc update_MODELPARAM_VALUE.BramDepth_g { MODELPARAM_VALUE.BramDepth_g PARAM_VALUE.BramDepth_g } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BramDepth_g}] ${MODELPARAM_VALUE.BramDepth_g}
}

proc update_MODELPARAM_VALUE.BramWidth_g { MODELPARAM_VALUE.BramWidth_g PARAM_VALUE.BramWidth_g } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BramWidth_g}] ${MODELPARAM_VALUE.BramWidth_g}
}

proc update_MODELPARAM_VALUE.BramCount_g { MODELPARAM_VALUE.BramCount_g PARAM_VALUE.BramCount_g } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BramCount_g}] ${MODELPARAM_VALUE.BramCount_g}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ID_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ID_WIDTH PARAM_VALUE.C_S00_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ID_WIDTH}
}

