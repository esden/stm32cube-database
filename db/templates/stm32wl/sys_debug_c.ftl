[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sys_debug.c
  * @author  MCD Application Team
  * @brief   Configure probes pins RealTime debugging and JTAG/SerialWires for LowPower
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
  * @brief Initializes the SW probes pins and the monitor RF pins via Alternate Function
  */
void DBG_Init(void)
{
  /* USER CODE BEGIN DBG_Init_1 */

  /* USER CODE END DBG_Init_1 */

  /* SW probes */
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 0 )
  HAL_DBGMCU_DisableDBGSleepMode();
  HAL_DBGMCU_DisableDBGStopMode();
  HAL_DBGMCU_DisableDBGStandbyMode();
#elif defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
  /*Debug power up request wakeup CBDGPWRUPREQ*/
  LL_EXTI_EnableIT_32_63(LL_EXTI_LINE_46);
  /* Disabled HAL_DBGMCU_  */
  HAL_DBGMCU_EnableDBGSleepMode();
  HAL_DBGMCU_EnableDBGStopMode();
  HAL_DBGMCU_EnableDBGStandbyMode();
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_OFF */

[#assign DEBUG_HEADER="true"]
[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Debug --]
        [#if variables.value?contains("Debug ") ]
          [#if DEBUG_HEADER == "true"]
            [#assign DEBUG_HEADER="false"]
  GPIO_InitTypeDef  GPIO_InitStruct = {0};

  /* Configure the GPIO pin */
  GPIO_InitStruct.Mode   = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;

  /* Enable the GPIO Clock */
          [/#if]
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

[#assign DEBUG_HEADER="true"]
[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Debug --]
        [#if variables.value?contains("Debug ") ]
          [#if DEBUG_HEADER == "true"]
            [#assign DEBUG_HEADER="false"]
  /* Reset probe Pins */
          [/#if]
          [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  HAL_GPIO_WritePin(PROBE_LINE${i}_PORT, PROBE_LINE${i}_PIN, GPIO_PIN_RESET);
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]
          [#if DEBUG_HEADER == "true"]
#if (DEBUG_SUBGHZSPI_MONITORING_ENABLED == 1) || \
    (DEBUG_RF_NRESET_ENABLED == 1) || \
    (DEBUG_RF_HSE32RDY_ENABLED == 1) || \
    (DEBUG_RF_SMPSRDY_ENABLED == 1) || \
    (DEBUG_RF_LDORDY_ENABLED == 1) || \
    (DEBUG_RF_DTB1_ENABLED == 1) || \
    (DEBUG_RF_BUSY_ENABLED == 1)
  GPIO_InitTypeDef  GPIO_InitStruct = {0};
#endif

        [/#if]
  /* USER CODE BEGIN DBG_Init_2 */

  /* USER CODE END DBG_Init_2 */

  /* HW alternate functions for monitoring RF */

#if (DEBUG_SUBGHZSPI_MONITORING_ENABLED == 1)
  /*spi dbg*/
  GPIO_InitStruct.Pin    = (GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7);
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate  = GPIO_AF13_DEBUG_SUBGHZSPI;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
#endif /* DEBUG_SUBGHZSPI_MONITORING_ENABLED */

#if (DEBUG_RF_NRESET_ENABLED == 1)
  GPIO_InitStruct.Pin = GPIO_PIN_11;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
#endif /* DEBUG_RF_NRESET_ENABLED */

#if (DEBUG_RF_HSE32RDY_ENABLED == 1)
  GPIO_InitStruct.Pin = GPIO_PIN_10;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
#endif /* DEBUG_RF_HSE32RDY_ENABLED */

#if (DEBUG_RF_SMPSRDY_ENABLED == 1)
  GPIO_InitStruct.Pin    = (GPIO_PIN_2);
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate  = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
#endif /* DEBUG_RF_SMPSRDY_ENABLED */

#if (DEBUG_RF_LDORDY_ENABLED == 1)
  GPIO_InitStruct.Pin    = (GPIO_PIN_4);
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate  = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
#endif /* DEBUG_RF_LDORDY_ENABLED */

#if (DEBUG_RF_DTB1_ENABLED == 1)
  GPIO_InitStruct.Pin = GPIO_PIN_3;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate = GPIO_AF13_DEBUG_RF;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
#endif /* DEBUG_RF_DTB1_ENABLED */

#if (DEBUG_RF_BUSY_ENABLED == 1)
  /* Busy */
  GPIO_InitStruct.Pin    = (GPIO_PIN_12);
  GPIO_InitStruct.Mode   = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate  = GPIO_AF6_RF_BUSY;
  __HAL_RCC_GPIOA_CLK_ENABLE() ;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
#endif /* DEBUG_RF_BUSY_ENABLED */

  /* USER CODE BEGIN DBG_Init_3 */

  /* USER CODE END DBG_Init_3 */
}

[#if (CPUCORE != "") ]
#endif /* CORE_CM4 */

[/#if]
/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
