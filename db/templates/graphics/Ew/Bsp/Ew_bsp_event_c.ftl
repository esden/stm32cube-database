[#ftl]
  /**
  ******************************************************************************
  * @file    ew_bsp_event.c
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
  *   This template provides a system event mechanism, that can be used in
  *   combination with an operating system to sleep and to continue (resume) the
  *   operation of the UI main loop. 
  ******************************************************************************
  */


#include "${FamilyName?lower_case}xx_hal.h"

#if EW_USE_FREE_RTOS == 1

  #include "cmsis_os.h"

  #define OS_SIGNAL_WAKEUP_UI  0x00000001

  static osThreadId ThreadId = 0;

#endif

#include "ew_bsp_clock.h"
#include "ew_bsp_event.h"

/*******************************************************************************
* FUNCTION:
*   EwBspWaitForSystemEvent
*
* DESCRIPTION:
*   The function EwBspWaitForSystemEvent should be called from the Embedded
*   Wizard main loop in case there are no pending events, signals or timers that
*   have to be processed by the UI application.
*   The function EwBspWaitForSystemEvent is used to sleep the given time span or
*   to suspend the UI task. The function returns as soon as a new system event
*   occurs or when the given timeout value is expired.
*   Typically, a system event is a touch event or a key event or any event
*   from your device driver.
*
* ARGUMENTS:
*   aTimeout - timeout value in milliseconds.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspWaitForSystemEvent( int aTimeout )
{
  if ( aTimeout > 0 )
  {
    CPU_LOAD_SET_IDLE();

    #if EW_USE_FREE_RTOS == 1

      /* save the thread ID for signaling */
      if ( ThreadId == 0 )
        ThreadId = osThreadGetId();

      /* Important note: Within this template, the timeout value is limited to
         10 ms in order to ensure that the UI application is continuously working,
         e.g. to get new touch values or to receive data from a device driver.
         This makes the usage of this template very simple.
         If you want to implement a completly event driven system, you can use
         the given timeout without limiting it. In this case you have to ensure
         that the touch driver or your device drivers are resuming the UI task
         by calling TriggerSystemEvent().
      */
      if ( aTimeout > 10 )
        aTimeout = 10;

      osSignalWait( OS_SIGNAL_WAKEUP_UI, aTimeout );

    #else

      /* in bare metal maximum wait time is 10 ms to keep main loop running */
      if ( aTimeout > 10 )
        aTimeout = 10;

      HAL_Delay( aTimeout );

    #endif

    CPU_LOAD_SET_ACTIVE();
  }
}


/*******************************************************************************
* FUNCTION:
*   EwBspTriggerSystemEvent
*
* DESCRIPTION:
*   The function EwBspTriggerSystemEvent is used in combination with an
*   operating system to continue (resume) the operation of the UI main loop.
*   Typically, a system event is a touch event or a key event or any event
*   from your device driver.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspTriggerSystemEvent( void )
{
  #if EW_USE_FREE_RTOS == 1

    osSignalSet( ThreadId, OS_SIGNAL_WAKEUP_UI );

  #endif
}


/* msy */
