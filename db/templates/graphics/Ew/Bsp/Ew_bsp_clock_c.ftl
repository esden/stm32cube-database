[#ftl]
  /**
  ******************************************************************************
  * @file    ew_bsp_clock.c
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


#include "${FamilyName?lower_case}xx_hal.h"

#include "ew_bsp_clock.h"

/* timer tick for Embedded Wizard UI applications */
unsigned int                  EmWiSystemTicks = 0;
[#assign useRTC = "0"]
[@common.optinclude name="ST-EmbeddedWizard/Ew_bsp_clock_tmp.c"/] 

[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]

 [#assign file = objectConstructor("java.io.File",workspace+"/"+"ST-EmbeddedWizard/Ew_bsp_clock_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
[#assign useRTC = "1"]
 [/#if]


[#if useRTC =="1" ]


/* RTC handler declaration */
extern RTC_HandleTypeDef      hrtc;
 [/#if]


#if EW_CPU_LOAD_MEASURING == 1

  static unsigned long        WorkingTime  = 0;
  static unsigned long        SleepingTime = 0;
  static unsigned long        prevCycCnt   = 0;

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
void EwBspConfigSystemTick( void )
{
  EmWiSystemTicks = 0;
}

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
void EwBspSystemTickIncrement( void )
{
  EmWiSystemTicks++;
}



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
unsigned long EwBspGetTime( void )
{
[#if useRTC =="1" ]
  #define TicksPerSecond    ( 1UL )
  #define TicksPerMinute    ( TicksPerSecond * 60UL )
  #define TicksPerHour      ( TicksPerMinute * 60UL )
  #define TicksPerDay       ( TicksPerHour   * 24UL )

  const unsigned long DaysToMonth[] =
  {
    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365
  };

  const unsigned long DaysToMonthInLeapYear[] =
  {
    0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366
  };

  extern RTC_TimeTypeDef sTime;
  extern RTC_DateTypeDef sDate;

  HAL_RTC_GetTime( &hrtc, &sTime, RTC_FORMAT_BIN );
  HAL_RTC_GetDate( &hrtc, &sDate, RTC_FORMAT_BIN );

  unsigned long   days;
  unsigned long   year   = sDate.Year;
  unsigned long   month  = sDate.Month;
  unsigned long   day    = sDate.Date;
  unsigned long   hour   = sTime.Hours;
  unsigned long   minute = sTime.Minutes;
  unsigned long   second = sTime.Seconds;
  unsigned long   timeInSeconds;

  /* year is the number of years since 2000 */
  /* calculate number of days since 01.01.1970 until begin of current
     year including the additional days of leap years */

  days = (year + 30) * 365 + (year + 27) / 4;

  if (year & 0x3)
  {
    days += DaysToMonth[month - 1];
  }
  else
  {
    days += DaysToMonthInLeapYear[month - 1];
  }

  days += day;

  timeInSeconds =
    days   * TicksPerDay +
    hour   * TicksPerHour +
    minute * TicksPerMinute +
    second;

  return timeInSeconds;
[/#if]
[#if useRTC !="1" ]
   /* USER CODE BEGIN BspGetTime */ 
  
   return 0 ;
   
 /* USER CODE END BspGetTime */
[/#if]
}



#if EW_CPU_LOAD_MEASURING == 1

/* helper function to initialize measuring unit */
static void CpuLoadInit()
{
  /* Enable TRC */
  CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;

  /* Unlock DWT registers */
  if ((*(uint32_t*)0xE0001FB4) & 1)
    *(uint32_t*)0xE0001FB0 = 0xC5ACCE55;

  /* clear the cycle counter */
  DWT->CYCCNT = 0;

  /* start the cycle counter */
  DWT->CTRL = 0x40000001;

  /* initialize counters */
  WorkingTime   = 0;
  SleepingTime  = 0;
  prevCycCnt    = 0;
}


/* helper function to get counter value since last call */
static unsigned long CpuLoadGetCounter()
{
  unsigned long cycCnt;
  unsigned long result;

  cycCnt = DWT->CYCCNT;
  if ( cycCnt > prevCycCnt )
    result = cycCnt - prevCycCnt;
  else
    result = prevCycCnt - cycCnt;
  prevCycCnt = cycCnt;

  return result;
}
#endif

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
 int EwBspGetCpuLoad( void )
{
  int cpuLoad = 0;

  #if EW_CPU_LOAD_MEASURING == 1

    /* get actual counter value */
    WorkingTime += CpuLoadGetCounter();

    /* calculate CPU load as percent value */
    cpuLoad = ( int ) ( WorkingTime / (( SleepingTime + WorkingTime ) / 100 ));

    /* clear accumulated counter values */
    WorkingTime  = 0;
    SleepingTime = 0;

  #endif

  return cpuLoad;
}

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
void EwBspCpuLoadSetActive( void )
{
  #if EW_CPU_LOAD_MEASURING == 1

    static char initialized = 0;

    if ( !initialized )
    {
      CpuLoadInit();
      initialized = 1;
    }

    SleepingTime += CpuLoadGetCounter();

  #endif
}

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
void EwBspCpuLoadSetIdle( void )
{
  #if EW_CPU_LOAD_MEASURING == 1

    WorkingTime += CpuLoadGetCounter();

  #endif
}

/* msy */
