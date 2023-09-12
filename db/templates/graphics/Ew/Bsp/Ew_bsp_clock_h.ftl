[#ftl]
  /**
  ******************************************************************************
  * @file    ew_bsp_clock.h
  * @author  MCD Application Team
  * @brief   This file is part of the interface (glue layer) between an Embedded 
  *          Wizard generated UI application and the board support package 
  *          (BSP) of a dedicated target.   
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2018 STMicroelectronics International N.V. 
  * All rights reserved.</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  * DESCRIPTION:
  *   This template is responsible to initialize the system clock of the 
  *   hardware,to provide a timer tick for the Embedded Wizard UI application
  *   and to get access to the realtime clock (RTC). Additionally, this file 
  *   contains some performance measurements to analyse the CPU usage of the 
  *   UI application.
  ******************************************************************************
  */


#ifndef EW_BSP_CLOCK_H
#define EW_BSP_CLOCK_H

#ifdef __cplusplus
  extern "C"
  {
#endif

#if EW_CPU_LOAD_MEASURING == 1
  #define CPU_LOAD_SET_IDLE()           EwBspCpuLoadSetIdle()
  #define CPU_LOAD_SET_ACTIVE()         EwBspCpuLoadSetActive()
#else
  #define CPU_LOAD_SET_IDLE()
  #define CPU_LOAD_SET_ACTIVE()
#endif

/*******************************************************************************
* FUNCTION:
*   EwBspConfigSystemTick
*
* DESCRIPTION:
*   Configure the system tick counter.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspConfigSystemTick
( 
  void
);

/*******************************************************************************
* FUNCTION:
*   EwBspSystemTickIncrement
*
* DESCRIPTION:
*   The function EwBspSystemTickIncrement increments the millisecond counter,
*   which is used by the Runtime Environmet (RTE) to trigger timer events.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspSystemTickIncrement
( 
  void
);


/*******************************************************************************
* FUNCTION:
*   EwBspGetTime
*
* DESCRIPTION:
*   Returns the current time in seconds since 01.01.1970.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   The current time in seconds since 01.01.1970.
*
*******************************************************************************/
unsigned long EwBspGetTime
( 
  void
);

/*******************************************************************************
* FUNCTION:
*   EwBspGetCpuLoad
*
* DESCRIPTION:
*   Returns the current CPU load as percent value.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   The current CPU load.
*
*******************************************************************************/
int EwBspGetCpuLoad
( 
  void
);

/*******************************************************************************
* FUNCTION:
*   EwBspCpuLoadSetActive
*
* DESCRIPTION:
*   Starts the CPU load counting. Call this function whenever CPU processing
*   is needed.
*
* ARGUMENTS:
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspCpuLoadSetActive
( 
  void
);

/*******************************************************************************
* FUNCTION:
*   EwBspCpuLoadSetIdle
*
* DESCRIPTION:
*   Stops the CPU load counting. Call this function whenever CPU processing is
*   currently not needed since the program execution is waiting for some system
*   event.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspCpuLoadSetIdle
( 
  void
);

#ifdef __cplusplus
  }
#endif

#endif /* EW_BSP_CLOCK_H */

/* msy */
