[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${Board_RPN?lower_case}_radio.h
  * @author  MCD Application Team
  * @brief   Header for ${Board_RPN?lower_case}_radio.c
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+ "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${BoardName?upper_case}_H
#define __${BoardName?upper_case}_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "${BoardName}_conf.h"
#include "${BoardName}_errno.h"

   
/** @addtogroup BSP
  * @{
  */

/** @addtogroup ${BoardName?upper_case} ${BoardName?upper_case}
  * @{
  */

/** @defgroup ${BoardName?upper_case}_RADIO_LOW_LEVEL RADIO LOW LEVEL
  * @{
  */

/** @defgroup ${BoardName?upper_case}_RADIO_LOW_LEVEL_Exported_Types RADIO LOW LEVEL Exported Types
  * @{
  */

typedef enum 
{
  RADIO_SWITCH_OFF    = 0,
  RADIO_SWITCH_RX     = 1,
  RADIO_SWITCH_RFO_LP = 2,
  RADIO_SWITCH_RFO_HP = 3,
}BSP_RADIO_Switch_TypeDef;

/**
  * @}
  */ 

/** @defgroup ${BoardName?upper_case}_RADIO_LOW_LEVEL_Exported_Constants RADIO LOW LEVEL Exported Constants
  * @{
  */

/** @defgroup ${BoardName?upper_case}_RADIO_LOW_LEVEL_RADIOCONFIG RADIO LOW LEVEL RADIO CONFIG Constants
  * @{
  */ 

#define RADIO_CONF_RFO_LP_HP  0
#define RADIO_CONF_RFO_LP     1
#define RADIO_CONF_RFO_HP     2


/**
  * @}
  */ 

/** @defgroup ${BoardName?upper_case}_RADIO_LOW_LEVEL_RFSWITCH RADIO LOW LEVEL RF SWITCH Constants
  * @{
  */ 

[#assign REF_1_PORT = ""]
[#assign REF_1_PIN = ""]
[#assign REF_2_PORT = ""]
[#assign REF_2_PIN = ""]
[#assign REF_3_PORT = ""]
[#assign REF_3_PIN = ""]

  
[#list BspIpDatas as SWIP] 
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
            [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
            [/#if]	            		
            [#if variables.value?contains("RF SW CTRL 1")]
                [#assign REF_1_PORT = IpName]
                [#assign REF_1_PIN = IpInstance]												
            [/#if]  
            [#if variables.value?contains("RF SW CTRL 2")]
                [#assign REF_2_PORT = IpName]
                [#assign REF_2_PIN = IpInstance]												
            [/#if]  
            [#if variables.value?contains("RF SW CTRL 3")]
                [#assign REF_3_PORT = IpName]
                [#assign REF_3_PIN = IpInstance]												
            [/#if]           
        [/#list]
    [/#if]
[/#list] 
   
#define RF_SW_CTRL3_PIN                          ${REF_3_PIN}
#define RF_SW_CTRL3_GPIO_PORT                    ${REF_3_PORT}
#define RF_SW_CTRL3_GPIO_CLK_ENABLE()            __HAL_RCC_${REF_3_PORT}_CLK_ENABLE()
#define RF_SW_CTRL3_GPIO_CLK_DISABLE()           __HAL_RCC_${REF_3_PORT}_CLK_DISABLE()

#define RF_SW_CTRL1_PIN                          ${REF_1_PIN}
#define RF_SW_CTRL1_GPIO_PORT                    ${REF_1_PORT}
#define RF_SW_CTRL1_GPIO_CLK_ENABLE()            __HAL_RCC_${REF_1_PORT}_CLK_ENABLE()
#define RF_SW_RX_GPIO_CLK_DISABLE()              __HAL_RCC_${REF_1_PORT}_CLK_DISABLE()

#define RF_SW_CTRL2_PIN                          ${REF_2_PIN}
#define RF_SW_CTRL2_GPIO_PORT                    ${REF_2_PORT}
#define RF_SW_CTRL2_GPIO_CLK_ENABLE()            __HAL_RCC_${REF_2_PORT}_CLK_ENABLE()
#define RF_SW_CTRL2_GPIO_CLK_DISABLE()           __HAL_RCC_${REF_2_PORT}_CLK_DISABLE()

#define RF_TCXO_VCC_PIN                          GPIO_PIN_0
#define RF_TCXO_VCC_GPIO_PORT                    GPIOB
#define RF_TCXO_VCC_CLK_ENABLE()                 __HAL_RCC_GPIOB_CLK_ENABLE()
#define RF_TCXO_VCC_CLK_DISABLE()                __HAL_RCC_GPIOB_CLK_DISABLE()
/**
 * @}
 */

/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_RADIO_LOW_LEVEL_Exported_Functions RADIO LOW LEVEL Exported Functions
  * @{
  */
int32_t BSP_RADIO_Init(void);
int32_t BSP_RADIO_DeInit(void);
int32_t BSP_RADIO_ConfigRFSwitch(BSP_RADIO_Switch_TypeDef Config);
int32_t BSP_RADIO_GetTxConfig(void);
int32_t BSP_RADIO_GetWakeUpTime(void);
int32_t BSP_RADIO_IsTCXO(void);
int32_t BSP_RADIO_IsDCDC(void);

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

#ifdef __cplusplus
}
#endif

#endif /*__${BoardName?upper_case}__H */



