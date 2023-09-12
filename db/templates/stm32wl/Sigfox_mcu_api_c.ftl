[#ftl]
/**
  ******************************************************************************
  * @file    mcu_api.c
  * @author  MCD Application Team
  * @brief   mcu library interface
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "sigfox_types.h"
#include "sigfox_api.h"
[#if (CPUCORE == "CM0PLUS")]
#include "sigfox_mbwrapper.h"
[/#if]
#include "mcu_api.h"
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#include "stm32_timer.h"
#include "stm32_seq.h"
#include "sgfx_eeprom_if.h"
#include "sys_debug.h"
#include "sgfx_cstimer.h"
[#if (CPUCORE == "")]
#include "adc_if.h"
[/#if]
#include "utilities_def.h"
#include "sys_app.h" /*for APP_LOG*/
#include "radio_board_if.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#define MCU_VER "MCU_API_V1.0"
#define LIBRARY_MEM_SIZE_MAX 200

#define TERM_RESET   "\033[0m"
#define TERM_BLACK   "\033[30m"      /* Black */
#define TERM_RED     "\033[31m"      /* Red   */
#define TERM_GREEN   "\033[32m"      /* Green */

#define T_RADIO_DELAY_ON (RF_WAKEUP_TIME)
#define T_RADIO_DELAY_OFF (11*10)

#if RF_WAKEUP_TIME<50
#define ARIB_DELAY (50-RF_WAKEUP_TIME)
#else
#define ARIB_DELAY 1
#endif /* RF_WAKEUP_TIME */

[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#ifndef ALIGN
#define ALIGN(n)             __attribute__((aligned(n)))
#endif /* !ALIGN */

[/#if]
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
static int32_t rxcount = 0;
static int32_t okcount = 0;

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
static sfx_u8 mcu_api_version[] = MCU_VER;
/*The allocated memory must be word aligned */
static uint8_t LibraryMem[LIBRARY_MEM_SIZE_MAX] ALIGN(4);

static UTIL_TIMER_Object_t Timer_delayMs;

static void OnTimerDelayEvt(void *context);

/*timer to handle low power delays*/
static UTIL_TIMER_Object_t Timer_Timeout;

static void OnTimerTimeoutEvt(void *context);

/*timer to handleCarrier Sense Timeout*/
static UTIL_TIMER_Object_t Timer_TimeoutCs;

static void Delay_Lp(uint32_t delay_ms);

[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
sfx_u8 MCU_API_malloc(sfx_u16 size, sfx_u8 **returned_pointer)
{
  sfx_error_t error = SFX_ERR_NONE;
  /* USER CODE BEGIN MCU_API_malloc_1 */

  /* USER CODE END MCU_API_malloc_1 */

  /* ------------------------------------------------------ */
  /* PSEUDO code */
  /* ------------------------------------------------------ */
  /* Allocate a memory : static or dynamic allocation */
  /* knowing that the sigfox library will ask for a buffer once at the SIGFOX_API_open() call. */
  /* This buffer will be released after SIGFOX_API_close() call. */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  if (size <= LIBRARY_MEM_SIZE_MAX)
  {
    /* The memory block is free, we can allocate it */
    *returned_pointer = LibraryMem ;
  }
  else
  {
    /* No block available */
    error = MCU_ERR_API_MALLOC;
  }
[/#if]
  /* USER CODE BEGIN MCU_API_malloc_2 */

  /* USER CODE END MCU_API_malloc_2 */
  return error;
}

/*******************************************************************/
sfx_u8 MCU_API_free(sfx_u8 *ptr)
{
  /* USER CODE BEGIN MCU_API_free_1 */

  /* USER CODE END MCU_API_free_1 */
  return SFX_ERR_NONE;
  /* USER CODE BEGIN MCU_API_free_2 */

  /* USER CODE END MCU_API_free_2 */
}

/*******************************************************************/
sfx_u8 MCU_API_get_voltage_temperature(sfx_u16 *voltage_idle, sfx_u16 *voltage_tx, sfx_s16 *temperature)
{
  sfx_u8 ret = SFX_ERR_NONE;
  /* USER CODE BEGIN MCU_API_get_voltage_temperature_1 */

  /* USER CODE END MCU_API_get_voltage_temperature_1 */

  /* brief Get voltage and temperature for Out of band frames*/
  /* Value must respect the units bellow for backend compatibility*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE == "")]
  *voltage_idle = (uint16_t) SYS_GetBatteryLevel(); /* mV */
  *voltage_tx = 0;   /* mV */
  *temperature = (uint16_t)((SYS_GetTemperatureLevel() * 10) >> 8);  /* */
[#elseif (CPUCORE == "CM0PLUS")]
  *voltage_idle = (uint16_t)GetBatteryLevel_mbwrapper(); /* mV */
  *voltage_tx = 0;
  *temperature = (uint16_t)((GetTemperatureLevel_mbwrapper() * 10) >> 8);   /* */
[/#if]
  APP_LOG(TS_ON, VLEVEL_M, "temp=%d , ", (int32_t) *temperature);
  APP_LOG(TS_OFF, VLEVEL_M, "voltage=%u\n\r", (uint32_t) *voltage_idle);

[/#if]
  /* USER CODE BEGIN MCU_API_get_voltage_temperature_2 */

  /* USER CODE END MCU_API_get_voltage_temperature_2 */
  return ret;
}

/*******************************************************************/
sfx_u8 MCU_API_delay(sfx_delay_t delay_type)
{
  /* Local variables */
  sfx_error_t err = SFX_ERR_NONE;
  /* USER CODE BEGIN MCU_API_delay_1 */

  /* USER CODE END MCU_API_delay_1 */

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  sfx_rc_enum_t sfx_rc = E2P_Read_Rc();
[/#if]

  /* Switch/case */
  switch (delay_type)
  {
    case SFX_DLY_INTER_FRAME_TRX :
      /* Delay  is 500ms  in FCC and ETSI
        * In ARIB : minimum delay is 50 ms */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      if ((sfx_rc == SFX_RC3A) ||
          (sfx_rc == SFX_RC3C) ||
          (sfx_rc == SFX_RC5))
      {
        /* 50 ms */
        Delay_Lp(ARIB_DELAY);
      }
      else if ((sfx_rc == SFX_RC2) ||
               (sfx_rc == SFX_RC4))
      {
        Delay_Lp(510 - T_RADIO_DELAY_ON - T_RADIO_DELAY_OFF / 6); /* 500-525ms */
      }
      else
      {
        Delay_Lp(510 - (T_RADIO_DELAY_ON) - T_RADIO_DELAY_OFF); /* 500-525 ms */
      }
[#else]
      /* USER CODE BEGIN SFX_DLY_INTER_FRAME_TRX */

      /* USER CODE END SFX_DLY_INTER_FRAME_TRX */
[/#if]
      break;

    case SFX_DLY_INTER_FRAME_TX :
      /* Start delay 0 seconds to 2 seconds in FCC and ETSI*/
      /* In ARIB : minimum delay is 50 ms */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      if ((sfx_rc == SFX_RC3A) ||
          (sfx_rc == SFX_RC3C) ||
          (sfx_rc == SFX_RC5))
      {
        /* 50 ms */
        Delay_Lp(ARIB_DELAY);
      }
      else
      {
        Delay_Lp(1000 - T_RADIO_DELAY_ON - T_RADIO_DELAY_OFF); /* 1000 ms */
      }
[#else]
      /* USER CODE BEGIN SFX_DLY_INTER_FRAME_TX */

      /* USER CODE END SFX_DLY_INTER_FRAME_TX */
[/#if]
      break;

    case SFX_DLY_OOB_ACK :
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      /* Start delay between 1.4 seconds to 4 seconds in FCC and ETSI */
      Delay_Lp(1600 - T_RADIO_DELAY_ON);
[#else]
      /* USER CODE BEGIN SFX_DLY_OOB_ACK */

      /* USER CODE END SFX_DLY_OOB_ACK */
[/#if]
      break;

    case SFX_DLY_CS_SLEEP :
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      Delay_Lp(500 - T_RADIO_DELAY_ON); /* 500 ms */
[#else]
      /* USER CODE BEGIN SFX_DLY_CS_SLEEP */

      /* USER CODE END SFX_DLY_CS_SLEEP */
[/#if]
      break;
[#if (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]

    /* USER CODE BEGIN SFX_DLY_ADD_CASE */

    /* USER CODE END SFX_DLY_ADD_CASE */
[/#if]

    default :
      err = MCU_ERR_API_DLY;
[#if (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
      /* USER CODE BEGIN SFX_DLY_DEFAULT */

      /* USER CODE END SFX_DLY_DEFAULT */
[/#if]
      break;
  }
  /* USER CODE BEGIN MCU_API_delay_Last */

  /* USER CODE END MCU_API_delay_Last */
  return err;
}

/*******************************************************************/
sfx_u8 MCU_API_get_nv_mem(sfx_u8 read_data[SFX_NVMEM_BLOCK_SIZE])
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_get_nv_mem_1 */

  /* USER CODE END MCU_API_get_nv_mem_1 */
  if (E2P_Read_McuNvm(read_data, SFX_NVMEM_BLOCK_SIZE) != E2P_OK)
  {
    return MCU_ERR_API_GETNVMEM;
  }
  /* USER CODE BEGIN MCU_API_get_nv_mem_2 */

  /* USER CODE END MCU_API_get_nv_mem_2 */
[#else]
  /* USER CODE BEGIN MCU_API_get_nv_mem */

  /* USER CODE END MCU_API_get_nv_mem */
[/#if]
  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_set_nv_mem(sfx_u8 data_to_write[SFX_NVMEM_BLOCK_SIZE])
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_set_nv_mem_1 */

  /* USER CODE END MCU_API_set_nv_mem_1 */

  if (E2P_Write_McuNvm(data_to_write, SFX_NVMEM_BLOCK_SIZE) != E2P_OK)
  {
    return MCU_ERR_API_SETNVMEM;
  }
  /* USER CODE BEGIN MCU_API_set_nv_mem_2 */

  /* USER CODE END MCU_API_set_nv_mem_2 */
[#else]
  /* USER CODE BEGIN MCU_API_set_nv_mem */

  /* USER CODE END MCU_API_set_nv_mem */
[/#if]
  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_timer_start_carrier_sense(sfx_u16 time_duration_in_ms)
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_timer_start_carrier_sense_1 */

  /* USER CODE END MCU_API_timer_start_carrier_sense_1 */
  APP_LOG(TS_ON, VLEVEL_M, "CS timeout Started= %d msec\n\r", time_duration_in_ms);
  UTIL_TIMER_Create(&Timer_TimeoutCs, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnTimerTimeoutCsEvt, NULL);
  UTIL_TIMER_Stop(&Timer_TimeoutCs);
  UTIL_TIMER_SetPeriod(&Timer_TimeoutCs,  time_duration_in_ms);
  UTIL_TIMER_Start(&Timer_TimeoutCs);
  /* USER CODE BEGIN MCU_API_timer_start_carrier_sense_2 */

  /* USER CODE END MCU_API_timer_start_carrier_sense_2 */
[#else]
  /*Starts CS timeout during time_duration_in_ms */
  /* USER CODE BEGIN MCU_API_timer_start_carrier_sense */

  /* USER CODE END MCU_API_timer_start_carrier_sense */
[/#if]
  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_timer_start(sfx_u32 time_duration_in_s)
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_timer_start_1 */

  /* USER CODE END MCU_API_timer_start_1 */
  uint32_t time_duration_in_millisec = time_duration_in_s * 1000;
  APP_LOG(TS_ON, VLEVEL_M, "TIM timeout Started= %d sec\n\r", time_duration_in_s);

  UTIL_TIMER_Create(&Timer_Timeout, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnTimerTimeoutEvt, NULL);
  UTIL_TIMER_Stop(&Timer_Timeout);
  UTIL_TIMER_SetPeriod(&Timer_Timeout, time_duration_in_millisec);
  UTIL_TIMER_Start(&Timer_Timeout);
  /* USER CODE BEGIN MCU_API_timer_start_2 */

  /* USER CODE END MCU_API_timer_start_2 */
[#else]
  /*Starts MCU timer during time_duration_in_ms */
  /* USER CODE BEGIN MCU_API_timer_start */

  /* USER CODE END MCU_API_timer_start */
[/#if]

  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_timer_stop(void)
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_timer_stop_1 */

  /* USER CODE END MCU_API_timer_stop_1 */
  APP_LOG(TS_ON, VLEVEL_M, "timer_stop\n\r");

  UTIL_TIMER_Stop(&Timer_Timeout);
  /* USER CODE BEGIN MCU_API_timer_stop_2 */

  /* USER CODE END MCU_API_timer_stop_2 */
[#else]
  /*Stops MCU timer timeout during time_duration_in_ms */
  /* USER CODE BEGIN MCU_API_timer_stop */

  /* USER CODE END MCU_API_timer_stop */
[/#if]

  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_timer_stop_carrier_sense(void)
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_timer_stop_carrier_sense_1 */

  /* USER CODE END MCU_API_timer_stop_carrier_sense_1 */
  APP_LOG(TS_ON, VLEVEL_M, "CS timer_stop\n\r");

  UTIL_TIMER_Stop(&Timer_TimeoutCs);
  /* USER CODE BEGIN MCU_API_timer_stop_carrier_sense_2 */

  /* USER CODE END MCU_API_timer_stop_carrier_sense_2 */
[#else]
  /*Stops CS timer timeout during time_duration_in_ms */
  /* USER CODE BEGIN MCU_API_timer_stop_carrier_sense */

  /* USER CODE END MCU_API_timer_stop_carrier_sense */
[/#if]

  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_timer_wait_for_end(void)
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_timer_wait_for_end_1 */

  /* USER CODE END MCU_API_timer_wait_for_end_1 */
  APP_LOG(TS_ON, VLEVEL_M, "TIM timeout Wait\n\r");

  UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_Timeout);
  /* USER CODE BEGIN MCU_API_timer_wait_for_end_2 */

  /* USER CODE END MCU_API_timer_wait_for_end_2 */
[#else]
  /*Wait here until MCU timer timeout */
  /* USER CODE BEGIN MCU_API_timer_wait_for_end */

  /* USER CODE END MCU_API_timer_wait_for_end */
[/#if]

  return SFX_ERR_NONE;
}

/*******************************************************************/
sfx_u8 MCU_API_report_test_result(sfx_bool status, sfx_s16 rssi)
{
  /* USER CODE BEGIN MCU_API_report_test_result_1 */

  /* USER CODE END MCU_API_report_test_result_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  rxcount++;
[/#if]

  if (status == SFX_TRUE)
  {
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
    /* Set the LED3 to inform the user that we received a frame for the device */
#if defined(USE_BSP_DRIVER)
    BSP_LED_On(LED_GREEN);
    HAL_Delay(50);
    BSP_LED_Off(LED_GREEN);
#elif defined(MX_BOARD_PSEUDODRIVER)
    SYS_LED_On(SYS_LED_GREEN);
    HAL_Delay(50);
    SYS_LED_Off(SYS_LED_GREEN);
#endif /* defined(USE_BSP_DRIVER) */
    okcount++;
    APP_LOG(TS_ON, VLEVEL_H, TERM_GREEN"RX OK. RSSI= %d dBm, cnt=%d, PER=%d%""%""\n\r  "TERM_RESET, (int32_t) rssi, rxcount,
            ((rxcount - okcount) * 100) / rxcount);
[#else]
    /* USER CODE BEGIN SFX_TRUE */
    /*Last Rx Packet received*/

    /* USER CODE END SFX_TRUE */
[/#if]
  }
  else
  {
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#if defined(USE_BSP_DRIVER)
    BSP_LED_On(LED_BLUE);
    HAL_Delay(50);
    BSP_LED_Off(LED_BLUE);
#elif defined(MX_BOARD_PSEUDODRIVER)
    SYS_LED_On(SYS_LED_BLUE);
    HAL_Delay(50);
    SYS_LED_Off(SYS_LED_BLUE);
#endif /* defined(USE_BSP_DRIVER) */
    APP_LOG(TS_ON, VLEVEL_H, TERM_RED"RX KO. RSSI= %d dBm, cnt=%d, PER=%d%""%""\n\r "TERM_RESET, (int32_t)rssi, rxcount,
            ((rxcount - okcount) * 100) / rxcount);
[#else]
    /* USER CODE BEGIN SFX_FALSE */
    /*Last Rx Packet on error or timeout*/
    /* USER CODE END SFX_FALSE */
[/#if]
  }

  return SFX_ERR_NONE;
  /* USER CODE BEGIN MCU_API_report_test_result_2 */

  /* USER CODE END MCU_API_report_test_result_2 */
}

/*******************************************************************/
sfx_u8 MCU_API_get_version(sfx_u8 **version, sfx_u8 *size)
{
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* USER CODE BEGIN MCU_API_get_version_1 */

  /* USER CODE END MCU_API_get_version_1 */
  *version = (sfx_u8 *)mcu_api_version;
  if (size == SFX_NULL)
  {
    return MCU_ERR_API_GET_VERSION;
  }
  *size = sizeof(mcu_api_version);
  /* USER CODE BEGIN MCU_API_get_version_2 */

  /* USER CODE END MCU_API_get_version_2 */
[#else]
  /* USER CODE BEGIN MCU_API_get_version */
  /*Report version*/
  /* USER CODE END MCU_API_get_version */
[/#if]

  return SFX_ERR_NONE;
}

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
static void Delay_Lp(uint32_t delay_ms)
{
  /* USER CODE BEGIN Delay_Lp_1 */

  /* USER CODE END Delay_Lp_1 */
  APP_LOG(TS_ON, VLEVEL_M, "Delay= %d ms\n\r", delay_ms);
  if (delay_ms > 5)
  {
    UTIL_TIMER_Create(&Timer_delayMs, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnTimerDelayEvt, NULL);
    UTIL_TIMER_Stop(&Timer_delayMs);
    UTIL_TIMER_SetPeriod(&Timer_delayMs,  delay_ms);
    UTIL_TIMER_Start(&Timer_delayMs);
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_Delay);
  }
  else
  {
    HAL_Delay(delay_ms);
  }
  APP_LOG(TS_ON, VLEVEL_M, "Delay Up\n\r");
  /* USER CODE BEGIN Delay_Lp_2 */

  /* USER CODE END Delay_Lp_2 */
}
[/#if]
/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
static void OnTimerDelayEvt(void *context)
{
  /* USER CODE BEGIN OnTimerDelayEvt_1 */

  /* USER CODE END OnTimerDelayEvt_1 */
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_Delay);
  /* USER CODE BEGIN OnTimerDelayEvt_2 */

  /* USER CODE END OnTimerDelayEvt_2 */
}

static void OnTimerTimeoutEvt(void *context)
{
  /* USER CODE BEGIN OnTimerTimeoutEvt_1 */

  /* USER CODE END OnTimerTimeoutEvt_1 */
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_Timeout);

  APP_LOG(TS_ON, VLEVEL_M, "TIM timeout Stopped\n\r");
  /* USER CODE BEGIN OnTimerTimeoutEvt_2 */

  /* USER CODE END OnTimerTimeoutEvt_2 */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
