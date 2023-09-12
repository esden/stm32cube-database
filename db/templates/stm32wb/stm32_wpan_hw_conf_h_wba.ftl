[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Hardware configuration file for STM32WPAN Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign CFG_HW_LPUART1_ENABLED = ""]
[#assign CFG_HW_LPUART1_DMA_TX_SUPPORTED = ""]
[#assign CFG_HW_LPUART1_DMA_RX_SUPPORTED = ""]
[#assign CFG_HW_USART1_ENABLED = ""]
[#assign CFG_HW_USART1_DMA_TX_SUPPORTED = ""]
[#assign CFG_HW_USART1_DMA_RX_SUPPORTED = ""]
[#assign CFG_HW_USART2_ENABLED = ""]
[#assign CFG_HW_USART2_DMA_TX_SUPPORTED = ""]
[#assign CFG_HW_USART2_DMA_RX_SUPPORTED = ""]
[#assign FREERTOS_STATUS = 0]
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_HW_LPUART1_ENABLED"]
                [#assign CFG_HW_LPUART1_ENABLED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_LPUART1_DMA_TX_SUPPORTED"]
                [#assign CFG_HW_LPUART1_DMA_TX_SUPPORTED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_LPUART1_DMA_RX_SUPPORTED"]
                [#assign CFG_HW_LPUART1_DMA_RX_SUPPORTED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART1_ENABLED"]
                [#assign CFG_HW_USART1_ENABLED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART1_DMA_TX_SUPPORTED"]
                [#assign CFG_HW_USART1_DMA_TX_SUPPORTED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART1_DMA_RX_SUPPORTED"]
                [#assign CFG_HW_USART1_DMA_RX_SUPPORTED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART2_ENABLED"]
                [#assign CFG_HW_USART2_ENABLED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART2_DMA_TX_SUPPORTED"]
                [#assign CFG_HW_USART2_DMA_TX_SUPPORTED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART2_DMA_RX_SUPPORTED"]
                [#assign CFG_HW_USART2_DMA_RX_SUPPORTED = definition.value]
            [/#if]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef HW_CONF_H
#define HW_CONF_H

[#if (FREERTOS_STATUS = 1)]
#include "FreeRTOSConfig.h"

[/#if]

/******************************************************************************
 * HW UART
 *****************************************************************************/
[#if CFG_HW_LPUART1_ENABLED != "" ]
    [#lt]#define CFG_HW_LPUART1_ENABLED           ${CFG_HW_LPUART1_ENABLED}
[/#if]
[#if CFG_HW_LPUART1_DMA_TX_SUPPORTED != ""]
    [#lt]#define CFG_HW_LPUART1_DMA_TX_SUPPORTED  ${CFG_HW_LPUART1_DMA_TX_SUPPORTED}
[/#if]
[#if CFG_HW_LPUART1_DMA_RX_SUPPORTED != ""]
    [#lt]#define CFG_HW_LPUART1_DMA_RX_SUPPORTED  ${CFG_HW_LPUART1_DMA_RX_SUPPORTED}
[/#if]
[#if CFG_HW_USART1_ENABLED != "" ]
    [#lt]#define CFG_HW_USART1_ENABLED            ${CFG_HW_USART1_ENABLED}
[/#if]
[#if CFG_HW_USART1_DMA_TX_SUPPORTED != ""]
    [#lt]#define CFG_HW_USART1_DMA_TX_SUPPORTED   ${CFG_HW_USART1_DMA_TX_SUPPORTED}
[/#if]
[#if CFG_HW_USART1_DMA_RX_SUPPORTED != ""]
    [#lt]#define CFG_HW_USART1_DMA_RX_SUPPORTED   ${CFG_HW_USART1_DMA_RX_SUPPORTED}
[/#if]
[#if CFG_HW_USART2_ENABLED != "" ]
    [#lt]#define CFG_HW_USART2_ENABLED            ${CFG_HW_USART2_ENABLED}
[/#if]
[#if CFG_HW_USART2_DMA_TX_SUPPORTED != ""]
    [#lt]#define CFG_HW_USART2_DMA_TX_SUPPORTED   ${CFG_HW_USART2_DMA_TX_SUPPORTED}
[/#if]
[#if CFG_HW_USART2_DMA_RX_SUPPORTED != ""]
    [#lt]#define CFG_HW_USART2_DMA_RX_SUPPORTED   ${CFG_HW_USART2_DMA_RX_SUPPORTED}
[/#if]

#endif /*HW_CONF_H */
