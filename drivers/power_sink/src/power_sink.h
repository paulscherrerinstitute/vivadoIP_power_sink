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
#define POWER_SINK_REG_FF_PATTERN			0x10
#define POWER_SINK_REG_SRL_PATTERN			0x14
#define POWER_SINK_REG_BRAM_PATTERN			0x18

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


#ifdef __cplusplus
}
#endif


