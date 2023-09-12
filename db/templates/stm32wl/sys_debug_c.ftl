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
BSP IP Datas:
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
SWIP Datas:
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
[#if CPUCORE != ""]
#define DBGMCU_LPM   0   /* if 1 enables/disables the Debug Module during LowPower modes */
                         /* if 0 it does not modify the DBGMCU_CR_DBG registers */
                         /* in DualCore few issues are under investigation when 1 */

[/#if]
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

[#if CPUCORE == ""]
void DBG_Init(void)
{
  /* USER CODE BEGIN DBG_Init_1 */

  /* USER CODE END DBG_Init_1 */
#if defined (DEBUGGER_ON) && ( DEBUGGER_ON == 1 )
  GPIO_InitTypeDef  GPIO_InitStruct = {0};

  /* Enable the GPIO Clock */
[#list BspIpDatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variables]
      [#if variables.name?contains("IpInstance")]
        [#assign IpInstance = variables.value]
      [/#if]
      [#if variables.name?contains("IpName")]
        [#assign IpName = variables.value]
      [/#if]
      [#-- User BSP Debug --]
      [#if variables.value?contains("Debug ") ]
        [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  DGB_LINE${i}_CLK_ENABLE();
      [/#if]
    [/#list]
  [/#if]
[/#list]

  /* Configure the GPIO pin */
  GPIO_InitStruct.Mode   = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull   = GPIO_PULLUP;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;

[#list BspIpDatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variables]
      [#if variables.name?contains("IpInstance")]
        [#assign IpInstance = variables.value]
      [/#if]
      [#if variables.name?contains("IpName")]
        [#assign IpName = variables.value]
      [/#if]
      [#-- User BSP Debug --]
      [#if variables.value?contains("Debug ") ]
        [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  GPIO_InitStruct.Pin    = DGB_LINE${i}_PIN;
  HAL_GPIO_Init(DGB_LINE${i}_PORT, &GPIO_InitStruct);
      [/#if]
    [/#list]
  [/#if]
[/#list]

  /* Reset debug Pins */
[#list BspIpDatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variables]
      [#if variables.name?contains("IpInstance")]
        [#assign IpInstance = variables.value]
      [/#if]
      [#if variables.name?contains("IpName")]
        [#assign IpName = variables.value]
      [/#if]
      [#-- User BSP Debug --]
      [#if variables.value?contains("Debug ") ]
        [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  HAL_GPIO_WritePin(DGB_LINE${i}_PORT, DGB_LINE${i}_PIN, GPIO_PIN_RESET);
      [/#if]
    [/#list]
  [/#if]
[/#list]

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

  /******** MCO OUT Config on PA8 *****/
  HAL_RCC_MCOConfig(RCC_MCO1, RCC_MCO1SOURCE_SYSCLK, RCC_MCODIV_16);

  /*Debug power up request wakeup CBDGPWRUPREQ*/
  LL_EXTI_EnableIT_32_63(LL_EXTI_LINE_46);

  /* lowpower DBGmode: just needed for CORE_CM4 */
  HAL_DBGMCU_EnableDBGSleepMode();
  HAL_DBGMCU_EnableDBGStopMode();
  HAL_DBGMCU_EnableDBGStandbyMode();

#elif defined (DEBUGGER_ON) && (DEBUGGER_ON == 0) /* DEBUGGER_OFF */
  /* Put the debugger pin PA13 and P14 in analog for LowPower*/
  /* The 4 debug lines above are simply not set in this case */
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  GPIO_InitStruct.Mode   = GPIO_MODE_ANALOG;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_13 | GPIO_PIN_14);
  /* make sure clock is enabled before setting the pins with HAL_GPIO_Init() */
  __HAL_RCC_GPIOA_CLK_ENABLE() ;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  HAL_DBGMCU_DisableDBGSleepMode();
  HAL_DBGMCU_DisableDBGStopMode();
  HAL_DBGMCU_DisableDBGStandbyMode();

#else
#error "DEBUGGER_ON not defined or out of range <0,1>"
#endif /* DEBUGGER_OFF */
  /* USER CODE BEGIN DBG_Init_Last */

  /* USER CODE END DBG_Init_Last */
}
[#else]
void DBG_Init(void)
{
  /* USER CODE BEGIN DBG_Init_1 */

  /* USER CODE END DBG_Init_1 */
#if defined (DEBUGGER_ON) && ( DEBUGGER_ON == 1 )
  GPIO_InitTypeDef  GPIO_InitStruct = {0};

  /* Configure the GPIO pin */
  GPIO_InitStruct.Mode   = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull   = GPIO_PULLUP;
  GPIO_InitStruct.Speed  = GPIO_SPEED_FREQ_VERY_HIGH;

  /* make sure a pin is not used simultaneusly by the two cores */
  /* DGB_LINE1 & DGB_LINE2 for CM4: this mapping can be changed*/
#if defined(CORE_CM4)

  /* Enable the GPIO_LINES Clock */
  DGB_LINE3_CLK_ENABLE();
  DGB_LINE4_CLK_ENABLE();

  GPIO_InitStruct.Pin    = DGB_LINE3_PIN;
  HAL_GPIO_Init(DGB_LINE3_PORT, &GPIO_InitStruct);
  GPIO_InitStruct.Pin    = DGB_LINE4_PIN;
  HAL_GPIO_Init(DGB_LINE4_PORT, &GPIO_InitStruct);

  /* Reset debug Pins */
  HAL_GPIO_WritePin(DGB_LINE3_PORT, DGB_LINE3_PIN, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(DGB_LINE4_PORT, DGB_LINE4_PIN, GPIO_PIN_RESET);

  /******** MCO OUT Config on PA8 *****/
  HAL_RCC_MCOConfig(RCC_MCO1, RCC_MCO1SOURCE_SYSCLK, RCC_MCODIV_16);

  /*Debug power up request wakeup CBDGPWRUPREQ*/
  LL_EXTI_EnableIT_32_63(LL_EXTI_LINE_46);

  /* lowpower DBGmode: just needed for CORE_CM4 */
#if defined (DBGMCU_LPM) && ( DBGMCU_LPM == 1 )
  /* careful does not work correctly in dual core: Bugzilla 71087 */
  HAL_DBGMCU_EnableDBGSleepMode();
  HAL_DBGMCU_EnableDBGStopMode();
  HAL_DBGMCU_EnableDBGStandbyMode();
#elif defined (DBGMCU_LPM) && ( DBGMCU_LPM == 0 )
  HAL_DBGMCU_DisableDBGSleepMode();
  HAL_DBGMCU_DisableDBGStopMode();
  HAL_DBGMCU_DisableDBGStandbyMode();
#elif !defined (DBGMCU_LPM)
#error "DBGMCU_LPM not defined or out of range <0,1>"
#endif /* DBGMCU_LPM */

#else /* CORE_CM0PLUS */

  /* Enable the GPIO_LINES Clock */
  DGB_LINE1_CLK_ENABLE();
  DGB_LINE2_CLK_ENABLE();

  GPIO_InitStruct.Pin    = DGB_LINE1_PIN ;
  HAL_GPIO_Init(DGB_LINE1_PORT, &GPIO_InitStruct);
  GPIO_InitStruct.Pin    = DGB_LINE2_PIN;
  HAL_GPIO_Init(DGB_LINE2_PORT, &GPIO_InitStruct);

  /* Reset debug Pins */
  HAL_GPIO_WritePin(DGB_LINE1_PORT, DGB_LINE1_PIN, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(DGB_LINE2_PORT, DGB_LINE2_PIN, GPIO_PIN_RESET);

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

  /* LDO_rdy & BUCK_rdy */
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

#endif /* CORE_CM4 */

#elif defined (DEBUGGER_ON) && (DEBUGGER_ON == 0) /* DEBUGGER_OFF */

#if defined(CORE_CM4)
  /* Put the debugger pin PA13 and P14 in analog for LowPower*/
  /* The 4 debug lines above are simply not set in this case */
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  GPIO_InitStruct.Mode   = GPIO_MODE_ANALOG;
  GPIO_InitStruct.Pull   = GPIO_NOPULL;
  GPIO_InitStruct.Pin    = (GPIO_PIN_13 | GPIO_PIN_14);
  /* make sure clock is enabled before setting the pins with HAL_GPIO_Init() */
  __HAL_RCC_GPIOA_CLK_ENABLE() ;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  HAL_DBGMCU_DisableDBGSleepMode();
  HAL_DBGMCU_DisableDBGStopMode();
  HAL_DBGMCU_DisableDBGStandbyMode();

#endif /* CORE_CM4 */

#else
#error "DEBUGGER_ON not defined or out of range <0,1>"
#endif /* DEBUGGER_OFF */
  /* USER CODE BEGIN DBG_Init_Last */

  /* USER CODE END DBG_Init_Last */
}

[/#if]
/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
