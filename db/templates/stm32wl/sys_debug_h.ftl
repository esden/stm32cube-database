[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sys_debug.h
  * @author  MCD Application Team
  * @brief   Configuration of the debug.c instances
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SYS_DEBUG_H__
#define __SYS_DEBUG_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "sys_conf.h"
#include "platform.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* Pin defines */

[#if CPUCORE != ""]
/* make sure a pin is not used simultaneously by the two cores */
/* PROBE_LINE1 & PROBE_LINE2 for CM4: this mapping can be changed*/
#if defined(CORE_CM0PLUS)
[/#if]
[#if BspIpDatas??]
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

          [#if (i == "3") && CPUCORE != ""]
#else
          [/#if]
/**  Definition for Probe Line ${i}   **/
/**
  * @brief Pin of Probe Line ${i}
  */
#define PROBE_LINE${i}_PIN                           ${IpInstance}

/**
  * @brief Port of Probe Line ${i}
  */
#define PROBE_LINE${i}_PORT                          ${IpName}

/**
  * @brief Enable GPIOs clock of Probe Line ${i}
  */
#define PROBE_LINE${i}_CLK_ENABLE()                  __HAL_RCC_${IpName}_CLK_ENABLE()

/**
  * @brief Disable GPIOs clock of Probe Line ${i}
  */
#define PROBE_LINE${i}_CLK_DISABLE()                 __HAL_RCC_${IpName}_CLK_DISABLE()

          [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]
[#if CPUCORE != ""]
#endif /* CORE_CM0PLUS */
[/#if]

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
#if defined (PROBE_PINS_ENABLED) && (PROBE_PINS_ENABLED == 1)

#define PROBE_GPIO_WRITE( gpio, n, x )  HAL_GPIO_WritePin( gpio, n, (GPIO_PinState)(x) )

/**
  * @brief Set pin to high level
  */
#define PROBE_GPIO_SET_LINE( gpio, n )       LL_GPIO_SetOutputPin( gpio, n )

/**
  * @brief Set pin to low level
  */
#define PROBE_GPIO_RST_LINE( gpio, n )       LL_GPIO_ResetOutputPin ( gpio, n )

/*enabling RTC_OUTPUT should be set via STM32CubeMX GUI because MX_RTC_Init is now entirely generated */

#elif defined (PROBE_PINS_ENABLED) && (PROBE_PINS_ENABLED == 0) /* PROBE_PINS_OFF */

#define PROBE_GPIO_WRITE( gpio, n, x )

/**
  * @brief not usable
  */
#define PROBE_GPIO_SET_LINE( gpio, n )

/**
  * @brief not usable
  */
#define PROBE_GPIO_RST_LINE( gpio, n )

/*disabling RTC_OUTPUT should be set via STM32CubeMX GUI because MX_RTC_Init is now entirely generated */

#else
#error "PROBE_PINS_ENABLED not defined or out of range <0,1>"
#endif /* PROBE_PINS_ENABLED */

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if (CPUCORE != "") ]
#if defined(CORE_CM4)

[/#if]
/**
  * @brief Disable debugger (serial wires pins)
  */
void DBG_Disable(void);

/**
  * @brief Config debugger when working in Low Power Mode
  * @note  When in Dual Core DbgMcu pins should be better disable only after CM0+ is started
  */
void DBG_ConfigForLpm(uint8_t enableDbg);
[#if (CPUCORE != "") ]

#endif /* CORE_CM4 */
[/#if]

/**
  * @brief Initializes the SW probes pins and the monitor RF pins via Alternate Function
  */
void DBG_ProbesInit(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SYS_DEBUG_H__ */

