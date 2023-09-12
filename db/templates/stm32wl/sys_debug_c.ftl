[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sys_debug.c
  * @author  MCD Application Team
  * @brief   Enables 4 debug pins for internal signals RealTime debugging
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#--
********************************
BSP IP Data:
[#if BspIpDatas??]
    [#list BspIpDatas as SWIP]
        [#if SWIP.defines??]
Defines:
            [#list SWIP.defines as defines]
                ${defines.name}: ${defines.value}
            [/#list]
        [/#if]
        [#if SWIP.variables??]
Variables:
            [#list SWIP.variables as variables]
                ${variables.name}: ${variables.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
********************************
SWIP Data:
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
Defines:
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
********************************
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "sys_debug.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

[#if (CPUCORE != "") ]
#if defined(CORE_CM4)

[/#if]
/**
  * @brief Disable debugger (serial wires pins)
  */
void DBG_Disable(void)
{
  /* USER CODE BEGIN DBG_Init_1 */

  /* USER CODE END DBG_Init_1 */

#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 0 ) /* DEBUGGER_DISABLED */
  /* Put the debugger pin PA13 and P14 in analog for LowPower*/
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  GPIO_InitStruct.Mode   = GPIO_MODE_ANALOG;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_13 | GPIO_PIN_14);
  /* make sure clock is enabled before setting the pins with HAL_GPIO_Init() */
  __HAL_RCC_GPIOA_CLK_ENABLE() ;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_OFF */

  /* Disabled HAL_DBGMCU_  */
  DBG_ConfigForLpm(0);

  /* USER CODE BEGIN DBG_Init_Last */

  /* USER CODE END DBG_Init_Last */
}

/**
  * @brief Config debugger when working in Low Power Mode
  * @note  When in Dual Core DbgMcu pins should be better disable only after Cm0 is started
  */
void DBG_ConfigForLpm(uint8_t enableDbg)
{
  uint8_t enable_dbg = enableDbg;
  /* USER CODE BEGIN DBG_ConfigForLpm_1 */

  /* USER CODE END DBG_ConfigForLpm_1 */

#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 0 )
  enable_dbg = 0;
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_OFF */

  if (enable_dbg == 1)
  {
    HAL_DBGMCU_EnableDBGSleepMode();
    HAL_DBGMCU_EnableDBGStopMode();
    HAL_DBGMCU_EnableDBGStandbyMode();
  }
  else
  {
    HAL_DBGMCU_DisableDBGSleepMode();
    HAL_DBGMCU_DisableDBGStopMode();
    HAL_DBGMCU_DisableDBGStandbyMode();
  }

  /* USER CODE BEGIN DBG_ConfigForLpm_Last */

  /* USER CODE END DBG_ConfigForLpm_Last */
}
[#if (CPUCORE != "") ]

#endif /* CORE_CM4 */
[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
void DBG_ProbesInit(void)
{
  /* USER CODE BEGIN DBG_ProbesInit_1 */

  /* USER CODE END DBG_ProbesInit_1 */

  /* SW probes */

#if defined (PROBE_PINS_ENABLED) && ( PROBE_PINS_ENABLED == 1 )
  GPIO_InitTypeDef  GPIO_InitStruct = {0};

  /* Configure the GPIO pin */
  GPIO_InitStruct.Mode   = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull   = GPIO_PULLUP;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;

[#if CPUCORE == ""]
  /* Enable the GPIO Clock */
[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Debug --]
        [#if variables.value?contains("Debug ") ]
          [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  PROBE_LINE${i}_CLK_ENABLE();
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]

[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Debug --]
        [#if variables.value?contains("Debug ") ]
          [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  GPIO_InitStruct.Pin    = PROBE_LINE${i}_PIN;
  HAL_GPIO_Init(PROBE_LINE${i}_PORT, &GPIO_InitStruct);
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]

  /* Reset probe Pins */
[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Debug --]
        [#if variables.value?contains("Debug ") ]
          [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  HAL_GPIO_WritePin(PROBE_LINE${i}_PORT, PROBE_LINE${i}_PIN, GPIO_PIN_RESET);
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]

[#else]
[#assign PROBE_LINE = {"1": "0", "2": "0", "3": "0", "4": "0"}]
[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Debug --]
        [#if variables.value?contains("Debug ") ]
          [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
          [#assign PROBE_LINE = PROBE_LINE + {i: "1"}]
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]

  /* make sure a pin is not used simultaneously by the two cores */
  /* PROBE_LINE1 & PROBE_LINE2 for CM0PLUS: this mapping can be changed*/
#if defined(CORE_CM4)

  /* Enable the GPIO_LINES Clock */
[#if PROBE_LINE["3"] == "1"]
  PROBE_LINE3_CLK_ENABLE();
[/#if]
[#if PROBE_LINE["4"] == "1"]
  PROBE_LINE4_CLK_ENABLE();
[/#if]

[#if PROBE_LINE["3"] == "1"]
  GPIO_InitStruct.Pin    = PROBE_LINE3_PIN;
  HAL_GPIO_Init(PROBE_LINE3_PORT, &GPIO_InitStruct);
[/#if]
[#if PROBE_LINE["4"] == "1"]
  GPIO_InitStruct.Pin    = PROBE_LINE4_PIN;
  HAL_GPIO_Init(PROBE_LINE4_PORT, &GPIO_InitStruct);
[/#if]

  /* Reset probe Pins */
[#if PROBE_LINE["3"] == "1"]
  HAL_GPIO_WritePin(PROBE_LINE3_PORT, PROBE_LINE3_PIN, GPIO_PIN_RESET);
[/#if]
[#if PROBE_LINE["4"] == "1"]
  HAL_GPIO_WritePin(PROBE_LINE4_PORT, PROBE_LINE4_PIN, GPIO_PIN_RESET);
[/#if]

#else /* CORE_CM0PLUS */

  /* Enable the GPIO_LINES Clock */
[#if PROBE_LINE["1"] == "1"]
  PROBE_LINE1_CLK_ENABLE();
[/#if]
[#if PROBE_LINE["2"] == "1"]
  PROBE_LINE2_CLK_ENABLE();
[/#if]

[#if PROBE_LINE["1"] == "1"]
  GPIO_InitStruct.Pin    = PROBE_LINE1_PIN;
  HAL_GPIO_Init(PROBE_LINE1_PORT, &GPIO_InitStruct);
[/#if]
[#if PROBE_LINE["2"] == "1"]
  GPIO_InitStruct.Pin    = PROBE_LINE2_PIN;
  HAL_GPIO_Init(PROBE_LINE2_PORT, &GPIO_InitStruct);
[/#if]

  /* Reset probe Pins */
[#if PROBE_LINE["1"] == "1"]
  HAL_GPIO_WritePin(PROBE_LINE1_PORT, PROBE_LINE1_PIN, GPIO_PIN_RESET);
[/#if]
[#if PROBE_LINE["2"] == "1"]
  HAL_GPIO_WritePin(PROBE_LINE2_PORT, PROBE_LINE2_PIN, GPIO_PIN_RESET);
[/#if]

#endif /* CORE_CM4 */
[/#if]

  /* USER CODE BEGIN DBG_ProbesInit_2 */

  /* USER CODE END DBG_ProbesInit_2 */
[#if (CPUCORE != "") ]
#if defined(CORE_CM0PLUS)

[/#if]
  /* HW alternate functions for monitoring RF */

  /* Configure the GPIO pin */
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;

  /*spi dbg*/
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7);
  GPIO_InitStruct.Alternate  = GPIO_AF13_DEBUG_SUBGHZSPI;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /* Busy */
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_12);
  GPIO_InitStruct.Alternate  = GPIO_AF6_RF_BUSY;
  __HAL_RCC_GPIOA_CLK_ENABLE() ;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /* LDO_rdy & BUCK_rdy (SMPS) */
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_2);
  GPIO_InitStruct.Alternate  = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_4);
  GPIO_InitStruct.Alternate  = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

[#if (CPUCORE != "") ]
#endif /* CORE_CM0PLUS */

[/#if]
#elif !defined (PROBE_PINS_ENABLED)
#error "PROBE_PINS_ENABLED not defined or out of range <0,1>"
#endif /* PROBE_PINS_ENABLED */

  /* USER CODE BEGIN DBG_ProbesInit_3 */

  /* USER CODE END DBG_ProbesInit_3 */

#if defined(CORE_CM4)
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
  /*Debug power up request wakeup CBDGPWRUPREQ*/
  LL_EXTI_EnableIT_32_63(LL_EXTI_LINE_46);
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_OFF */
#endif /* CORE_CM4 */

  /* USER CODE BEGIN DBG_ProbesInit_Last */

  /* USER CODE END DBG_ProbesInit_Last */
}
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
