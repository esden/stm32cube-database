[#ftl]
/*******************************************************************************
*
* E M B E D D E D   W I Z A R D   P R O J E C T
*
*                                                Copyright (c) TARA Systems GmbH
*                                    written by Paul Banach and Manfred Schweyer
*
********************************************************************************
*
* This software is delivered "as is" and shows the usage of other software
* components. It is provided as an example software which is intended to be
* modified and extended according to particular requirements.
*
* TARA Systems hereby disclaims all warranties and conditions with regard to the
* software, including all implied warranties and conditions of merchantability
* and non-infringement of any third party IPR or other rights which may result
* from the use or the inability to use the software.
*
********************************************************************************
*
* DESCRIPTION:
*   This file is part of the interface (glue layer) between an Embedded Wizard
*   generated UI application and the board support package (BSP) of a dedicated
*   target.
*   This template is responsible to establish a serial connection in order
*   to send debug messages to a PC terminal tool, or to receive key events
*   for the UI application.
*
*******************************************************************************/

#include "${FamilyName?lower_case}xx_hal.h"

#include "ew_bsp_serial.h"
[@common.optinclude name="EmbeddedWizard/Ew_init_UART_tmp.c"/] 
