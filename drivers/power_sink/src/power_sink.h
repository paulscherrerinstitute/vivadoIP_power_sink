/*############################################################################
#  Copyright (c) 2019 by Paul Scherrer Institute, Switzerland
#  All rights reserved.
#  Authors: Oliver Bruendler
############################################################################*/

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

//*******************************************************************************
// Includes
//*******************************************************************************
#include <stdint.h>
#include <stdbool.h>

//*******************************************************************************
// Definitions
//*******************************************************************************

// Register
#define POWER_SINK_REG_FF_ENA				0x00
#define POWER_SINK_REG_SRL_ENA				0x04
#define POWER_SINK_REG_BRAM_ENA				0x08
#define POWER_SINK_REG_DSP_ENA				0x0C
#define POWER_SINK_REG_GLOBAL_ENA			0x10
#define POWER_SINK_REG_FF_PATTERN			0x20
#define POWER_SINK_REG_SRL_PATTERN			0x24
#define POWER_SINK_REG_BRAM_PATTERN			0x28
#define POWER_SINK_REG_DSP_PATTERN_A1		0x30
#define POWER_SINK_REG_DSP_PATTERN_A2		0x34
#define POWER_SINK_REG_DSP_PATTERN_B1		0x38
#define POWER_SINK_REG_DSP_PATTERN_B2		0x3C

// Status Register Bitmasks
#define POWER_SINK_ENA						(1 << 0)



//*******************************************************************************
// Access Functions
//*******************************************************************************
/**
 * Set enable of FF toggling
 *
 * @param baseAddr		Base address of the IP component to access
 * @param enable		True = enable FF toggling, False = disable FF toggling
 */
void PowerSink_SetFfEnable(const uint32_t baseAddr, const bool enable);

/**
 * Set enable of SRL toggling
 *
 * @param baseAddr		Base address of the IP component to access
 * @param enable		True = enable SRL toggling, False = disable SRL toggling
 */
void PowerSink_SetSrlEnable(const uint32_t baseAddr, const bool enable);

/**
 * Set enable of BRAM toggling
 *
 * @param baseAddr		Base address of the IP component to access
 * @param enable		True = enable BRAM toggling, False = disable BRAM toggling
 */
void PowerSink_SetBramEnable(const uint32_t baseAddr, const bool enable);

/**
 * Set enable of DSP toggling
 *
 * @param baseAddr		Base address of the IP component to access
 * @param enable		True = enable DSP toggling, False = disable DSP toggling
 */
void PowerSink_SetDspEnable(const uint32_t baseAddr, const bool enable);

/**
 * Set global enable
 *
 * @param baseAddr		Base address of the IP component to access
 * @param enable		True = all parts enabled, False = all parts disable
 */
void PowerSink_SetGlobalEnable(const uint32_t baseAddr, const bool enable);

/**
 * Set pattern to toggle FFs (shifted every clock cycle)
 *
 * @param baseAddr		Base address of the IP component to access
 * @param pattern		Pattern to use
 */
void PowerSink_SetFfPattern(const uint32_t baseAddr, const uint32_t pattern);

/**
 * Set pattern to toggle SRLs (shifted every clock cycle)
 *
 * @param baseAddr		Base address of the IP component to access
 * @param pattern		Pattern to use
 */
void PowerSink_SetSrlPattern(const uint32_t baseAddr, const uint32_t pattern);

/**
 * Set pattern to toggle BRAMs (shifted every clock cycle)
 *
 * @param baseAddr		Base address of the IP component to access
 * @param pattern		Pattern to use
 */
void PowerSink_SetBramPattern(const uint32_t baseAddr, const uint32_t pattern);

/**
 * Set pattern to toggle DSPs. The multiplier dooes the following calculation
 * in loops repeatedly:
 * a1 * b1, a2 * b1, a2 * b2, a1 * b2, ...
 *
 * @param baseAddr		Base address of the IP component to access
 * @param a1			Pattern coefficient a1
 * @param a2			Pattern coefficient a1
 * @param b1			Pattern coefficient a1
 * @param b2			Pattern coefficient a1
 */	
void PowerSink_SetDspPattern(const uint32_t baseAddr, const uint32_t a1, const uint32_t a2, const uint32_t b1, const uint32_t b2);


#ifdef __cplusplus
}
#endif


