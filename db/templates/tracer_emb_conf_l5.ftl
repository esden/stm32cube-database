[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    tracer_emb_conf.h
  * @author  MCD Application Team
  * @brief   This file contains the Trace HW related defines.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign UARTUsed = false]
[#assign UARTinstance = ""]
[#assign UARTbaudrate = ""]
[#assign UARTinterrupt = ""]
[#assign UARTenableClock = ""]
[#assign UARTdisableClock = ""]
[#assign UART_TX_PIN = ""]
[#assign UART_TX_GPIO_PORT = ""]
[#assign UART_TX_GPIO_PIN = ""]
[#assign UART_TX_SELECT_AF = ""]
[#assign UART_RX_PIN = ""]
[#assign UART_RX_GPIO_PORT = ""]
[#assign UART_RX_GPIO_PIN = ""]
[#assign UART_RX_SELECT_AF = ""]
[#assign UART_TX_DMA_CHANNEL = ""]
[#assign UART_TX_DMA_REQUEST = ""]
[#assign UART_TX_DMA = ""]
[#assign UART_TX_DMA_LL_CHANNEL = ""]
[#assign UART_TX_DMA_CHANNEL_ID = ""]
[#assign UART_TX_DMA_interrupt = ""]

[#list IPdatas as IP]
    [#list IP.configModelList as configModel]
        [#list configModel.refConfigFiles as refConfigFile]
            [#if refConfigFile.name?contains("TRACER_EMB_CONF")]
                [#list refConfigFile.arguments as argument]
                    [#if argument.name == "UARTinstance" && argument.value != ""]
                        [#assign UARTUsed = true]
                        [#assign UARTinstance = argument.value]
                    [/#if]
                    [#if argument.name == "UARTbaudrate"]
                        [#assign UARTbaudrate = argument.value]
                    [/#if]
                    [#if argument.name == "UARTinterrupt"]
                        [#assign UARTinterrupt = argument.value]
                    [/#if]
                    [#if argument.name == "UARTenableClock"]
                        [#assign UARTenableClock = argument.value]
                    [/#if]
                    [#if argument.name == "UARTdisableClock"]
                        [#assign UARTdisableClock = argument.value]
                    [/#if]
                    [#if argument.name == "UART_TX_PIN"]
                        [#assign UART_TX_PIN = argument.value]
                        [#if UART_TX_PIN != "" && UART_TX_PIN != "valueNotSetted"]
                            [#assign UART_TX_PIN_elems = UART_TX_PIN.split("_")]
                            [#assign UART_TX_GPIO_PORT = UART_TX_PIN_elems[1]]
                            [#assign UART_TX_GPIO_PIN = UART_TX_PIN_elems[2]]
                            [#assign UART_TX_SELECT_AF = UART_TX_PIN_elems[4]]
                        [#else]
                            [#assign UART_TX_GPIO_PORT = "valueNotSetted"]
                            [#assign UART_TX_GPIO_PIN = "valueNotSetted"]
                            [#assign UART_TX_SELECT_AF = "valueNotSetted"]
                        [/#if]
                    [/#if]
                    [#if argument.name == "UART_RX_PIN"]
                        [#assign UART_RX_PIN = argument.value]
                        [#if UART_RX_PIN != "" && UART_RX_PIN != "valueNotSetted"]
                            [#assign UART_RX_PIN_elems = UART_RX_PIN.split("_")]
                            [#assign UART_RX_GPIO_PORT = UART_RX_PIN_elems[1]]
                            [#assign UART_RX_GPIO_PIN = UART_RX_PIN_elems[2]]
                            [#assign UART_RX_SELECT_AF = UART_RX_PIN_elems[4]]
                        [#else]
                            [#assign UART_RX_GPIO_PORT = "valueNotSetted"]
                            [#assign UART_RX_GPIO_PIN = "valueNotSetted"]
                            [#assign UART_RX_SELECT_AF = "valueNotSetted"]
                        [/#if]
                    [/#if]
                    [#if argument.name == "UART_TX_DMA_CHANNEL"]
                        [#assign UART_TX_DMA_CHANNEL = argument.value]
                        [#if UART_TX_DMA_CHANNEL != ""]
                            [#assign UART_TX_DMA_CHANNEL_elems = UART_TX_DMA_CHANNEL.split("_")]
                            [#assign UART_TX_DMA_REQUEST = UART_TX_DMA_CHANNEL_elems[0] + "_" + UART_TX_DMA_CHANNEL_elems[1]]
                            [#assign UART_TX_DMA = UART_TX_DMA_CHANNEL_elems[2]]
                            [#assign UART_TX_DMA_LL_CHANNEL = UART_TX_DMA_CHANNEL_elems[3]?upper_case]
                            [#assign UART_TX_DMA_LL_CHANNEL = UART_TX_DMA_LL_CHANNEL + "_" + UART_TX_DMA_CHANNEL_elems[4]]
                            [#assign UART_TX_DMA_CHANNEL_ID = UART_TX_DMA_CHANNEL_elems[4]]
                        [#else]
                            [#assign UART_TX_DMA_REQUEST = "valueNotSetted"]
                            [#assign UART_TX_DMA = "valueNotSetted"]
                            [#assign UART_TX_DMA_LL_CHANNEL = "valueNotSetted"]
                            [#assign UART_TX_DMA_CHANNEL_ID = "valueNotSetted"]
                        [/#if]
                    [/#if]
                    [#if argument.name == "UART_TX_DMA_interrupt"]
                        [#assign UART_TX_DMA_interrupt = argument.value]
                    [/#if]
                    [#if argument.name == "UART_TX_DMA_enableClock"]
                        [#assign UART_TX_DMA_enableClock = argument.value]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#list]
[/#list]

#ifndef TRACER_EMB_CONF_H
#define TRACER_EMB_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_ll_bus.h"
#include "${FamilyName?lower_case}xx_ll_dma.h"
#include "${FamilyName?lower_case}xx_ll_gpio.h"
#include "${FamilyName?lower_case}xx_ll_rcc.h"
#include "${FamilyName?lower_case}xx_ll_usart.h"
[#if UARTinstance??]
    [#if UARTinstance?starts_with("LPUART")]
        [#lt]#include "${FamilyName?lower_case}xx_ll_lpuart.h"
    [/#if]
[/#if]
/* Private typedef -----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

/* -----------------------------------------------------------------------------
      Definitions for TRACE feature
-------------------------------------------------------------------------------*/
[#if !UARTUsed]/*[/#if]
#define TRACER_EMB_BAUDRATE                          ${UARTbaudrate}UL

[#if UART_TX_DMA != ""]
#define TRACER_EMB_DMA_MODE                          1UL
#define TRACER_EMB_IT_MODE                           0UL
[#else]
#define TRACER_EMB_DMA_MODE                          0UL
#define TRACER_EMB_IT_MODE                           1UL
[/#if]

#define TRACER_EMB_BUFFER_SIZE                       1024UL

/* -----------------------------------------------------------------------------
      Definitions for TRACE Hw information
-------------------------------------------------------------------------------*/

[#if UARTinstance?starts_with("LPUART")][#t]
#define TRACER_EMB_IS_INSTANCE_LPUART_TYPE           1UL /* set to 1UL if LPUART is used instead of USART */
[#else]
#define TRACER_EMB_IS_INSTANCE_LPUART_TYPE           0UL /* set to 0UL if USART is used */
[/#if][#t]

#define TRACER_EMB_USART_INSTANCE                    ${UARTinstance}

#define TRACER_EMB_TX_GPIO                           GPIO${UART_TX_GPIO_PORT}
#define TRACER_EMB_TX_PIN                            LL_GPIO_PIN_${UART_TX_GPIO_PIN}
#define TRACER_EMB_TX_AF                             LL_GPIO_AF_${UART_TX_SELECT_AF}
#define TRACER_EMB_TX_GPIO_ENABLE_CLOCK()            LL_AHB2_GRP1_EnableClock(LL_AHB2_GRP1_PERIPH_GPIO${UART_TX_GPIO_PORT})
#define TRACER_EMB_RX_GPIO                           GPIO${UART_RX_GPIO_PORT}
#define TRACER_EMB_RX_PIN                            LL_GPIO_PIN_${UART_RX_GPIO_PIN}
#define TRACER_EMB_RX_AF                             LL_GPIO_AF_${UART_RX_SELECT_AF}
#define TRACER_EMB_RX_GPIO_ENABLE_CLOCK()            LL_AHB2_GRP1_EnableClock(LL_AHB2_GRP1_PERIPH_GPIO${UART_RX_GPIO_PORT})

#define TRACER_EMB_ENABLE_CLK_USART()                ${UARTenableClock}
#define TRACER_EMB_DISABLE_CLK_USART()               ${UARTdisableClock}
#define TRACER_EMB_SET_CLK_SOURCE_USART()            /* No need for clock source selection in case of USART${UARTinstance} */
#define TRACER_EMB_USART_IRQ                         ${UARTinterrupt}
#define TRACER_EMB_USART_IRQHANDLER                  ${UARTinterrupt.replace("IRQn", "IRQHandler")}

#define TRACER_EMB_TX_AF_FUNCTION                    [#if UART_TX_GPIO_PIN != "valueNotSetted"][#if UART_TX_GPIO_PIN?number < 8]LL_GPIO_SetAFPin_0_7[#else]LL_GPIO_SetAFPin_8_15[/#if][#else]${UART_TX_GPIO_PIN}[/#if]
#define TRACER_EMB_RX_AF_FUNCTION                    [#if UART_RX_GPIO_PIN != "valueNotSetted"][#if UART_RX_GPIO_PIN?number < 8]LL_GPIO_SetAFPin_0_7[#else]LL_GPIO_SetAFPin_8_15[/#if][#else]${UART_RX_GPIO_PIN}[/#if]

[#if UART_TX_DMA != ""]
#define TRACER_EMB_DMA_INSTANCE                      ${UART_TX_DMA}
#define TRACER_EMB_ENABLE_CLK_DMA()                  do {                                                       \
                                                       ${UART_TX_DMA_enableClock};                               \
                                                       } while(0)
#define TRACER_EMB_TX_DMA_REQUEST                    LL_DMAMUX_REQ_${UART_TX_DMA_REQUEST}
#define TRACER_EMB_TX_DMA_CHANNEL                    LL_DMA_${UART_TX_DMA_LL_CHANNEL}
#define TRACER_EMB_ENABLECHANNEL                     LL_DMA_EnableChannel
#define TRACER_EMB_DISABLECHANNEL                    LL_DMA_DisableChannel
#define TRACER_EMB_TX_DMA_IRQ                        ${UART_TX_DMA_interrupt}
#define TRACER_EMB_TX_DMA_IRQHANDLER                 ${UART_TX_DMA_interrupt.replace("IRQn", "IRQHandler")}
#define TRACER_EMB_TX_DMA_ACTIVE_FLAG                LL_DMA_IsActiveFlag_TC${UART_TX_DMA_CHANNEL_ID}
#define TRACER_EMB_TX_DMA_CLEAR_FLAG                 LL_DMA_ClearFlag_GI${UART_TX_DMA_CHANNEL_ID}
[/#if]

[#if !UARTUsed]*/[/#if]

#ifdef __cplusplus
}
#endif

#endif /* TRACER_EMB_CONF_H */
