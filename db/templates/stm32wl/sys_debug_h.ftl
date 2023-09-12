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

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
#if !defined (DISABLE_PROBE_GPIO)

/**
  * @brief Set pin to x value
  */
#define PROBE_GPIO_WRITE( gpio, n, x )     HAL_GPIO_WritePin( gpio, n, (GPIO_PinState)(x) )

/**
  * @brief Set pin to high level
  */
#define PROBE_GPIO_SET_LINE( gpio, n )     LL_GPIO_SetOutputPin( gpio, n )

/**
  * @brief Set pin to low level
  */
#define PROBE_GPIO_RST_LINE( gpio, n )     LL_GPIO_ResetOutputPin( gpio, n )

#else  /* DISABLE_PROBE_GPIO */

/**
  * @brief not usable
  */
#define PROBE_GPIO_WRITE( gpio, n, x )

/**
  * @brief not usable
  */
#define PROBE_GPIO_SET_LINE( gpio, n )

/**
  * @brief not usable
  */
#define PROBE_GPIO_RST_LINE( gpio, n )

#endif /* DISABLE_PROBE_GPIO */

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if (CPUCORE != "") ]
#if defined(CORE_CM4)

[/#if]
/**
  * @brief Initializes the SW probes pins and the monitor RF pins via Alternate Function
  */
void DBG_Init(void);

[#if (CPUCORE != "") ]

#endif /* CORE_CM4 */
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SYS_DEBUG_H__ */
