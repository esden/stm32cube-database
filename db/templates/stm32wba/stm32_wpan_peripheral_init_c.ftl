[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    peripheral_init.c
  * @author  MCD Application Team
  * @brief   tbd module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

/* Includes ------------------------------------------------------------------*/
#include "app_conf.h"
#include "peripheral_init.h"
[#assign hdlnbr = 0]
[#if !HALCompliant??]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
        [#if ((ipHandler.handler == "huart1")
      || (ipHandler.handler == "huart2")
      || (ipHandler.handler == "huart3")
      || (ipHandler.handler == "hlpuart1"))
      && (hdlnbr = 0)]
#include "usart.h"
        [#assign hdlnbr = hdlnbr + 1]
        [/#if]
    [/#list]
  [/#list]
[/#list]
[/#if]
#include "icache.h"
#include "ramcfg.h"
#include "rng.h"
[#else]
#include "${main_h}"
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "crc_ctrl.h"
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "adc_ctrl.h"
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
[#-- [#if NVICSystemInit??]
 /**
  * @brief  Configure the CPU NVIC peripheral at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_NVICPeripharalInit(void)
{
  [#list NVICSystemInit as initVector]  
#t${""?right_pad(2)}HAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
#t${""?right_pad(2)}HAL_NVIC_EnableIRQ(${initVector.vector});
  [/#list]
}
[/#if] --]

/* External variables --------------------------------------------------------*/
[#assign PreviousHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
        [#if (ipHandler.handler != "hrtc")
      && (ipHandler.handler != "handle_GPDMA1_Channel1")
      && (ipHandler.handler != "handle_GPDMA1_Channel0")
      && (ipHandler.handler != "huart1")
    ]
            [#if ipHandler.handler != PreviousHandler]
              [#if ((ipHandler.handler != "hadc4") && (ipHandler.handler != "hcrc"))]
extern ${ipHandler.handlerType} ${ipHandler.handler};
              [/#if]
              [#assign PreviousHandler = ipHandler.handler]
            [/#if]
        [/#if]
    [/#list]
  [/#list]
[/#list]
[/#if]

/* USER CODE BEGIN EV */


/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/

[#if (myHash["CFG_LPM_STDBY_SUPPORTED"]?number != 2)]
/**
  * @brief  Configure the SoC peripherals at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_PeripheralInit(void)
{
  HAL_StatusTypeDef hal_status;
  /* USER CODE BEGIN MX_STANDBY_EXIT_PERIPHERAL_INIT_1 */

  /* USER CODE END MX_STANDBY_EXIT_PERIPHERAL_INIT_1 */

  /* Select SysTick source clock */
  HAL_SYSTICK_CLKSourceConfig(${myHash["SYSTICK_SOURCE_CLOCK_SELECTION"]});

  /* Re-Initialize Tick with new clock source */
  hal_status = HAL_InitTick(TICK_INT_PRIORITY);
  if (hal_status != HAL_OK)
  {
    assert_param(0);
  }

[#assign PreviousIpHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
    [#if (ipHandler.handler != "hrtc")
      && (ipHandler.handler != "handle_GPDMA1_Channel1")
      && (ipHandler.handler != "handle_GPDMA1_Channel0")
      && (ipHandler.handler != "huart1")
    ]
      [#if ipHandler.handler != PreviousIpHandler]
        [#if ((ipHandler.handler != "hadc4") && (ipHandler.handler != "hcrc"))]
${""?right_pad(2)}memset(&${ipHandler.handler}, 0, sizeof(${ipHandler.handler}));
                [/#if]
        [#assign PreviousIpHandler = ipHandler.handler]
      [/#if]
    [/#if]
    [/#list]
  [/#list]
[/#list]
[/#if]

[#if voidsList??]
  [#list voidsList as void]
  [#if void.functionName?? && void.genCode && !void.isStatic]
    [#if (void.functionName != "SystemClock_Config") 
      && (void.functionName != "SystemPower_Config")
      && (void.functionName != "MX_RTC_Init")
      && (void.functionName != "APPE_Init")
      && (void.functionName != "MX_RF_Init")
      && (void.functionName != "MX_CORTEX_M33_Init")
      && (void.functionName != "MX_CORTEX_M33_NS_Init")
      && (void.functionName != "MX_GPDMA1_Init")
      && (void.functionName != "MX_USART1_UART_Init")
      && (void.functionName != "MX_USART2_UART_Init")
      && (void.functionName != "MX_HSEM_Init")
      && (void.functionName != "MX_ADC4_Init")
      && (void.functionName != "MX_CRC_Init")
    ]
${""?right_pad(2)}${void.functionName}();
    [/#if]
  [/#if]
  [/#list]
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  CRCCTRL_Init();
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  ADCCTRL_Init();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]

#if (CFG_DEBUGGER_LEVEL == 0)
  GPIO_InitTypeDef DbgIOsInit = {0};
  DbgIOsInit.Mode = GPIO_MODE_ANALOG;
  DbgIOsInit.Pull = GPIO_NOPULL;
  DbgIOsInit.Pin = GPIO_PIN_13|GPIO_PIN_14|GPIO_PIN_15;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &DbgIOsInit);
  
  DbgIOsInit.Mode = GPIO_MODE_ANALOG;
  DbgIOsInit.Pull = GPIO_NOPULL;
  DbgIOsInit.Pin = GPIO_PIN_3|GPIO_PIN_4;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &DbgIOsInit);
#endif /* CFG_DEBUGGER_LEVEL */
  /* USER CODE BEGIN MX_STANDBY_EXIT_PERIPHERAL_INIT_2 */

  /* USER CODE END MX_STANDBY_EXIT_PERIPHERAL_INIT_2 */
}

[#else]
void MX_Stop2Exit_PeripheralInit(void)
{
  /* USER CODE BEGIN MX_STOP2_EXIT_PERIPHERAL_INIT_1 */
  /* USER CODE END MX_STOP2_EXIT_PERIPHERAL_INIT_1 */
  
[#assign PreviousIpHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
    [#if (ipHandler.handler != "hrtc")
      && (ipHandler.handler != "handle_GPDMA1_Channel1")
      && (ipHandler.handler != "handle_GPDMA1_Channel0")
      && (ipHandler.handler != "huart1")
	  && (ipHandler.handler != "hramcfg_SRAM1")
    ]
      [#if ipHandler.handler != PreviousIpHandler]
        [#if ((ipHandler.handler != "hadc4") && (ipHandler.handler != "hcrc"))]
${""?right_pad(2)}memset(&${ipHandler.handler}, 0, sizeof(${ipHandler.handler}));
                [/#if]
        [#assign PreviousIpHandler = ipHandler.handler]
      [/#if]
    [/#if]
    [/#list]
  [/#list]
[/#list]
[/#if]

[#if voidsList??]
  [#list voidsList as void]
  [#if void.functionName?? && void.genCode && !void.isStatic]
    [#if (void.functionName != "SystemClock_Config") 
      && (void.functionName != "SystemPower_Config")
      && (void.functionName != "MX_RTC_Init")
      && (void.functionName != "APPE_Init")
      && (void.functionName != "MX_RF_Init")
      && (void.functionName != "MX_CORTEX_M33_Init")
      && (void.functionName != "MX_CORTEX_M33_NS_Init")
      && (void.functionName != "MX_GPDMA1_Init")
      && (void.functionName != "MX_USART1_UART_Init")
      && (void.functionName != "MX_USART2_UART_Init")
      && (void.functionName != "MX_HSEM_Init")
      && (void.functionName != "MX_ADC4_Init")
      && (void.functionName != "MX_CRC_Init")
	  && (void.functionName != "MX_GPIO_Init")
	  && (void.functionName != "MX_RAMCFG_Init")
	  && (void.functionName != "MX_ICACHE_Init")
    ]
${""?right_pad(2)}${void.functionName}();
    [/#if]
  [/#if]
  [/#list]
[/#if]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  ADCCTRL_Init();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
  
  /* USER CODE BEGIN MX_STOP2_EXIT_PERIPHERAL_INIT_2 */
  /* USER CODE END MX_STOP2_EXIT_PERIPHERAL_INIT_2 */
}
[/#if]