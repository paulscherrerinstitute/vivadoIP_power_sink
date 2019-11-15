/*############################################################################
#  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
#  All rights reserved.
#  Authors: Oliver Bruendler
############################################################################*/

#include "power_sink.h"
#include <xil_io.h>

//*******************************************************************************
// Access Functions
//*******************************************************************************

void PowerSink_SetFfEnable(const uint32_t baseAddr, const bool enable)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_FF_ENA, (uint32_t)enable);
}

void PowerSink_SetSrlEnable(const uint32_t baseAddr, const bool enable)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_SRL_ENA, (uint32_t)enable);
}

void PowerSink_SetBramEnable(const uint32_t baseAddr, const bool enable)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_BRAM_ENA, (uint32_t)enable);
}

void PowerSink_SetDspEnable(const uint32_t baseAddr, const bool enable)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_DSP_ENA, (uint32_t)enable);
}

void PowerSink_SetGlobalEnable(const uint32_t baseAddr, const bool enable)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_GLOBAL_ENA, (uint32_t)enable);
}

void PowerSink_SetFfPattern(const uint32_t baseAddr, const uint32_t pattern)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_FF_PATTERN, pattern);
}

void PowerSink_SetSrlPattern(const uint32_t baseAddr, const uint32_t pattern)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_SRL_PATTERN, pattern);
}

void PowerSink_SetBramPattern(const uint32_t baseAddr, const uint32_t pattern)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_BRAM_PATTERN, pattern);
}

void PowerSink_SetDspPattern(const uint32_t baseAddr, const uint32_t a1, const uint32_t a2, const uint32_t b1, const uint32_t b2)
{
	Xil_Out32(baseAddr + POWER_SINK_REG_DSP_PATTERN_A1, a1);
	Xil_Out32(baseAddr + POWER_SINK_REG_DSP_PATTERN_A2, a2);
	Xil_Out32(baseAddr + POWER_SINK_REG_DSP_PATTERN_B1, b1);
	Xil_Out32(baseAddr + POWER_SINK_REG_DSP_PATTERN_B2, b2);
}



