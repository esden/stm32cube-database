[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_devices_conf.h
  * @author  MCD Application Team
  * @brief   This file contains the device define.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign USBPD1Used = false]
[#assign UARTUsed = false]
[#assign UARTinstance = ""]
[#assign UARTbaudrate = ""]
[#assign UARTinterrupt = ""]
[#assign UARTenableClock = ""]
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

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "USBPD_PORT0"]
                [#assign USBPD_PORT0 = definition.value]
            [/#if]
            [#if definition.name == "USBPD_PORT1" && definition.value != "" && definition.value != "valueNotSetted" ]
                [#assign USBPD1Used = true]
                [#assign USBPD_PORT1 = definition.value]
            [/#if]
            [#if definition.name == "USBPDenableClock"]
                [#assign USBPDenableClock = definition.value]
            [/#if]
            [#if definition.name == "USBPD_PORT0_RX_DMA_CHANNEL"]
                [#assign USBPD_PORT0_RX_DMA_CHANNEL = definition.value]
                [#if USBPD_PORT0_RX_DMA_CHANNEL != "" && USBPD_PORT0_RX_DMA_CHANNEL != "valueNotSetted"]
                    [#assign USBPD_PORT0_RX_DMA_CHANNEL_elems = USBPD_PORT0_RX_DMA_CHANNEL.split("_")]
                    [#assign USBPD_PORT0_DMA_REQUEST_RX = USBPD_PORT0_RX_DMA_CHANNEL_elems[0] + "_" + USBPD_PORT0_RX_DMA_CHANNEL_elems[1]]
                    [#assign USBPD_PORT0_DMA_RX = USBPD_PORT0_RX_DMA_CHANNEL_elems[2]]
                    [#assign USBPD_PORT0_DMA_CHANNEL_RX = USBPD_PORT0_RX_DMA_CHANNEL_elems[2] + "_" + USBPD_PORT0_RX_DMA_CHANNEL_elems[3] + USBPD_PORT0_RX_DMA_CHANNEL_elems[4]]
                    [#assign USBPD_PORT0_DMA_LL_CHANNEL_RX = USBPD_PORT0_RX_DMA_CHANNEL_elems[3]?upper_case + "_" + USBPD_PORT0_RX_DMA_CHANNEL_elems[4]]
                [#else]
                    [#assign USBPD_PORT0_DMA_REQUEST_RX = "valueNotSetted"]
                    [#assign USBPD_PORT0_DMA_RX = "valueNotSetted"]
                    [#assign USBPD_PORT0_DMA_CHANNEL_RX = "valueNotSetted"]
                    [#assign USBPD_PORT0_DMA_LL_CHANNEL_RX = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "USBPD_PORT0_TX_DMA_CHANNEL"]
                [#assign USBPD_PORT0_TX_DMA_CHANNEL = definition.value]
                [#if USBPD_PORT0_TX_DMA_CHANNEL != "" && USBPD_PORT0_TX_DMA_CHANNEL != "valueNotSetted"]
                    [#assign USBPD_PORT0_TX_DMA_CHANNEL_elems = USBPD_PORT0_TX_DMA_CHANNEL.split("_")]
                    [#assign USBPD_PORT0_DMA_REQUEST_TX = USBPD_PORT0_TX_DMA_CHANNEL_elems[0] + "_" + USBPD_PORT0_TX_DMA_CHANNEL_elems[1]]
                    [#assign USBPD_PORT0_DMA_TX = USBPD_PORT0_TX_DMA_CHANNEL_elems[2]]
                    [#assign USBPD_PORT0_DMA_CHANNEL_TX = USBPD_PORT0_TX_DMA_CHANNEL_elems[2] + "_" + USBPD_PORT0_TX_DMA_CHANNEL_elems[3] + USBPD_PORT0_TX_DMA_CHANNEL_elems[4]]
                    [#assign USBPD_PORT0_DMA_LL_CHANNEL_TX = USBPD_PORT0_TX_DMA_CHANNEL_elems[3]?upper_case + "_" + USBPD_PORT0_TX_DMA_CHANNEL_elems[4]]
                [#else]
                    [#assign USBPD_PORT0_DMA_REQUEST_TX = "valueNotSetted"]
                    [#assign USBPD_PORT0_DMA_TX = "valueNotSetted"]
                    [#assign USBPD_PORT0_DMA_CHANNEL_TX = "valueNotSetted"]
                    [#assign USBPD_PORT0_DMA_LL_CHANNEL_TX = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "USBPD_PORT0_FRSTX1_PIN"]
                [#assign USBPD_PORT0_FRSTX1_PIN = definition.value]
                [#if USBPD_PORT0_FRSTX1_PIN != "" && USBPD_PORT0_FRSTX1_PIN != "valueNotSetted"]
                    [#assign USBPD_PORT0_FRSTX1_PIN_elems = USBPD_PORT0_FRSTX1_PIN.split("_")]
                    [#assign USBPD_PORT0_FRSTX1_GPIO_PORT = USBPD_PORT0_FRSTX1_PIN_elems[1]]
                    [#assign USBPD_PORT0_FRSTX1_GPIO_PIN = USBPD_PORT0_FRSTX1_PIN_elems[2]]
                    [#assign USBPD_PORT0_FRSTX1_SELECT_AF = USBPD_PORT0_FRSTX1_PIN_elems[4]]
                [#else]
                    [#assign USBPD_PORT0_FRSTX1_GPIO_PORT = "valueNotSetted"]
                    [#assign USBPD_PORT0_FRSTX1_GPIO_PIN = "valueNotSetted"]
                    [#assign USBPD_PORT0_FRSTX1_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "USBPD_PORT0_FRSTX2_PIN"]
                [#assign USBPD_PORT0_FRSTX2_PIN = definition.value]
                [#if USBPD_PORT0_FRSTX2_PIN != "" && USBPD_PORT0_FRSTX2_PIN != "valueNotSetted"]
                    [#assign USBPD_PORT0_FRSTX2_PIN_elems = USBPD_PORT0_FRSTX2_PIN.split("_")]
                    [#assign USBPD_PORT0_FRSTX2_GPIO_PORT = USBPD_PORT0_FRSTX2_PIN_elems[1]]
                    [#assign USBPD_PORT0_FRSTX2_GPIO_PIN = USBPD_PORT0_FRSTX2_PIN_elems[2]]
                    [#assign USBPD_PORT0_FRSTX2_SELECT_AF = USBPD_PORT0_FRSTX2_PIN_elems[4]]
                [#else]
                    [#assign USBPD_PORT0_FRSTX2_GPIO_PORT = "valueNotSetted"]
                    [#assign USBPD_PORT0_FRSTX2_GPIO_PIN = "valueNotSetted"]
                    [#assign USBPD_PORT0_FRSTX2_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "USBPD_PORT0_IRQ"]
                [#assign USBPD_PORT0_IRQ = definition.value]
                [#if USBPD_PORT0_IRQ == ""]
                    [#assign USBPD_PORT0_IRQ = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if USBPD1Used]
                [#if definition.name == "USBPD_PORT1_RX_DMA_CHANNEL"]
                    [#assign USBPD_PORT1_RX_DMA_CHANNEL = definition.value]
                    [#if USBPD_PORT1_RX_DMA_CHANNEL != "" && USBPD_PORT1_RX_DMA_CHANNEL != "valueNotSetted"]
                        [#assign USBPD_PORT1_RX_DMA_CHANNEL_elems = USBPD_PORT1_RX_DMA_CHANNEL.split("_")]
                        [#assign USBPD_PORT1_DMA_REQUEST_RX = USBPD_PORT1_RX_DMA_CHANNEL_elems[0] + "_" + USBPD_PORT1_RX_DMA_CHANNEL_elems[1]]
                        [#assign USBPD_PORT1_DMA_RX = USBPD_PORT1_RX_DMA_CHANNEL_elems[2]]
                        [#assign USBPD_PORT1_DMA_CHANNEL_RX = USBPD_PORT1_RX_DMA_CHANNEL_elems[2] + "_" + USBPD_PORT1_RX_DMA_CHANNEL_elems[3] + USBPD_PORT1_RX_DMA_CHANNEL_elems[4]]
                        [#assign USBPD_PORT1_DMA_LL_CHANNEL_RX = USBPD_PORT1_RX_DMA_CHANNEL_elems[3]?upper_case + "_" + USBPD_PORT1_RX_DMA_CHANNEL_elems[4]]
                    [#else]
                        [#assign USBPD_PORT1_DMA_REQUEST_RX = "valueNotSetted"]
                        [#assign USBPD_PORT1_DMA_RX = "valueNotSetted"]
                        [#assign USBPD_PORT1_DMA_CHANNEL_RX = "valueNotSetted"]
                        [#assign USBPD_PORT1_DMA_LL_CHANNEL_RX = "valueNotSetted"]
                    [/#if]
                [/#if]
                [#if definition.name == "USBPD_PORT1_TX_DMA_CHANNEL"]
                    [#assign USBPD_PORT1_TX_DMA_CHANNEL = definition.value]
                    [#if USBPD_PORT1_TX_DMA_CHANNEL != "" && USBPD_PORT1_TX_DMA_CHANNEL != "valueNotSetted"]
                        [#assign USBPD_PORT1_TX_DMA_CHANNEL_elems = USBPD_PORT1_TX_DMA_CHANNEL.split("_")]
                        [#assign USBPD_PORT1_DMA_REQUEST_TX = USBPD_PORT1_TX_DMA_CHANNEL_elems[0] + "_" + USBPD_PORT1_TX_DMA_CHANNEL_elems[1]]
                        [#assign USBPD_PORT1_DMA_TX = USBPD_PORT1_TX_DMA_CHANNEL_elems[2]]
                        [#assign USBPD_PORT1_DMA_CHANNEL_TX = USBPD_PORT1_TX_DMA_CHANNEL_elems[2] + "_" + USBPD_PORT1_TX_DMA_CHANNEL_elems[3] + USBPD_PORT1_TX_DMA_CHANNEL_elems[4]]
                        [#assign USBPD_PORT1_DMA_LL_CHANNEL_TX = USBPD_PORT1_TX_DMA_CHANNEL_elems[3]?upper_case + "_" + USBPD_PORT1_TX_DMA_CHANNEL_elems[4]]
                    [#else]
                        [#assign USBPD_PORT1_DMA_REQUEST_TX = "valueNotSetted"]
                        [#assign USBPD_PORT1_DMA_TX = "valueNotSetted"]
                        [#assign USBPD_PORT1_DMA_CHANNEL_TX = "valueNotSetted"]
                        [#assign USBPD_PORT1_DMA_LL_CHANNEL_TX = "valueNotSetted"]
                    [/#if]
                [/#if]
                [#if definition.name == "USBPD_PORT1_FRSTX1_PIN"]
                    [#assign USBPD_PORT1_FRSTX1_PIN = definition.value]
                        [#if USBPD_PORT1_FRSTX1_PIN != "" && USBPD_PORT1_FRSTX1_PIN != "valueNotSetted"]
                        [#assign USBPD_PORT1_FRSTX1_PIN_elems = USBPD_PORT1_FRSTX1_PIN.split("_")]
                        [#assign USBPD_PORT1_FRSTX1_GPIO_PORT = USBPD_PORT1_FRSTX1_PIN_elems[1]]
                        [#assign USBPD_PORT1_FRSTX1_GPIO_PIN = USBPD_PORT1_FRSTX1_PIN_elems[2]]
                        [#assign USBPD_PORT1_FRSTX1_SELECT_AF = USBPD_PORT1_FRSTX1_PIN_elems[4]]
                    [#else]
                        [#assign USBPD_PORT1_FRSTX1_GPIO_PORT = "valueNotSetted"]
                        [#assign USBPD_PORT1_FRSTX1_GPIO_PIN = "valueNotSetted"]
                        [#assign USBPD_PORT1_FRSTX1_SELECT_AF = "valueNotSetted"]
                    [/#if]
                [/#if]
                [#if definition.name == "USBPD_PORT1_FRSTX2_PIN"]
                    [#assign USBPD_PORT1_FRSTX2_PIN = definition.value]
                    [#if USBPD_PORT1_FRSTX2_PIN != "" && USBPD_PORT1_FRSTX2_PIN != "valueNotSetted"]
                        [#assign USBPD_PORT1_FRSTX2_PIN_elems = USBPD_PORT1_FRSTX2_PIN.split("_")]
                        [#assign USBPD_PORT1_FRSTX2_GPIO_PORT = USBPD_PORT1_FRSTX2_PIN_elems[1]]
                        [#assign USBPD_PORT1_FRSTX2_GPIO_PIN = USBPD_PORT1_FRSTX2_PIN_elems[2]]
                        [#assign USBPD_PORT1_FRSTX2_SELECT_AF = USBPD_PORT1_FRSTX2_PIN_elems[4]]
                    [#else]
                        [#assign USBPD_PORT1_FRSTX2_GPIO_PORT = "valueNotSetted"]
                        [#assign USBPD_PORT1_FRSTX2_GPIO_PIN = "valueNotSetted"]
                        [#assign USBPD_PORT1_FRSTX2_SELECT_AF = "valueNotSetted"]
                    [/#if]
                [/#if]
                [#if definition.name == "USBPD_PORT1_IRQ"]
                    [#assign USBPD_PORT1_IRQ = definition.value]
                    [#if USBPD_PORT1_IRQ == ""]
                        [#assign USBPD_PORT1_IRQ = "valueNotSetted"]
                    [/#if]
                [/#if]
            [/#if]
            [#if definition.name == "TIMinstance"]
                [#assign TIMinstance = definition.value]
            [/#if]
            [#if definition.name == "TIMinterrupt"]
                [#assign TIMinterrupt = definition.value]
            [/#if]
            [#if definition.name == "TIMenableClock"]
                [#assign TIMenableClock = definition.value]
            [/#if]
            [#if definition.name == "UARTinstance" && definition.value != ""]
                [#assign UARTUsed = true]
                [#assign UARTinstance = definition.value]
            [/#if]
            [#if definition.name == "UARTbaudrate"]
                [#assign UARTbaudrate = definition.value]
            [/#if]
            [#if definition.name == "UARTinterrupt"]
                [#assign UARTinterrupt = definition.value]
            [/#if]
            [#if definition.name == "UARTenableClock"]
                [#assign UARTenableClock = definition.value]
            [/#if]
            [#if definition.name == "UART_TX_PIN"]
                [#assign UART_TX_PIN = definition.value]
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
            [#if definition.name == "UART_RX_PIN"]
                [#assign UART_RX_PIN = definition.value]
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
            [#if definition.name == "UART_TX_DMA_CHANNEL"]
                [#assign UART_TX_DMA_CHANNEL = definition.value]
                [#if UART_TX_DMA_CHANNEL != "" && UART_TX_DMA_CHANNEL != "valueNotSetted"]
                    [#assign UART_TX_DMA_CHANNEL_elems = UART_TX_DMA_CHANNEL.split("_")]
                    [#assign UART_TX_DMA_REQUEST = UART_TX_DMA_CHANNEL_elems[0] + "_" + UART_TX_DMA_CHANNEL_elems[1]]
                    [#assign UART_TX_DMA = UART_TX_DMA_CHANNEL_elems[2]]
                    [#assign UART_TX_DMA_LL_CHANNEL = UART_TX_DMA_CHANNEL_elems[3]?upper_case + "_" + UART_TX_DMA_CHANNEL_elems[4]]
                    [#assign UART_TX_DMA_CHANNEL_ID = UART_TX_DMA_CHANNEL_elems[4]]
                [#else]
                    [#assign UART_TX_DMA_REQUEST = "valueNotSetted"]
                    [#assign UART_TX_DMA = "valueNotSetted"]
                    [#assign UART_TX_DMA_LL_CHANNEL = "valueNotSetted"]
                    [#assign UART_TX_DMA_CHANNEL_ID = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "UART_TX_DMA_interrupt"]
                [#assign UART_TX_DMA_interrupt = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* CubeMX Generated */
#define CUBEMX_GENERATED

#ifndef USBPD_DEVICE_CONF_H
#define USBPD_DEVICE_CONF_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32g0xx_ll_bus.h"
#include "stm32g0xx_ll_dma.h"
#include "stm32g0xx_ll_gpio.h"
#include "stm32g0xx_ll_rcc.h"
#include "stm32g0xx_ll_ucpd.h"
[#if TIMinstance??]
    [#if TIMinstance?starts_with("LPTIM")][#t]
        [#t]#include "stm32g0xx_ll_lptim.h"
    [/#if][#t]
    [#if TIMinstance?starts_with("TIM")][#t]
        [#t]#include "stm32g0xx_ll_tim.h"
    [/#if]
[/#if]
[#if UARTinstance??]
    [#if UARTinstance?starts_with("LPUART")][#t]
        [#t]#include "stm32g0xx_ll_lpuart.h"
    [/#if][#t]
    [#if UARTinstance?starts_with("UART") || UARTinstance?starts_with("USART")][#t]
        [#t]#include "stm32g0xx_ll_usart.h"
    [/#if]
[/#if]

/* USER CODE BEGIN Includes */
#include "usbpd_pwr_user.h"

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

/* -----------------------------------------------------------------------------
      usbpd_hw.c
-------------------------------------------------------------------------------*/

/* defined used to configure function : BSP_USBPD_GetUSPDInstance */
#define UCPD_INSTANCE0 ${USBPD_PORT0}
[#if USBPD1Used]
#define UCPD_INSTANCE1 ${USBPD_PORT1}
[/#if]

/* defined used to configure function : BSP_USBPD_Init_DMARxInstance,BSP_USBPD_DeInit_DMARxInstance */
#define UCPDDMA_INSTANCE0_CLOCKENABLE_RX  ${USBPDenableClock}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_CLOCKENABLE_RX  ${USBPDenableClock}
[/#if]

#define UCPDDMA_INSTANCE0_DMA_RX  ${USBPD_PORT0_DMA_RX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_DMA_RX  ${USBPD_PORT1_DMA_RX}
[/#if]

#define UCPDDMA_INSTANCE0_REQUEST_RX   DMA_REQUEST_${USBPD_PORT0_DMA_REQUEST_RX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_REQUEST_RX   DMA_REQUEST_${USBPD_PORT1_DMA_REQUEST_RX}
[/#if]

#define UCPDDMA_INSTANCE0_LL_CHANNEL_RX   LL_DMA_${USBPD_PORT0_DMA_LL_CHANNEL_RX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_LL_CHANNEL_RX   LL_DMA_${USBPD_PORT1_DMA_LL_CHANNEL_RX}
[/#if]

#define UCPDDMA_INSTANCE0_CHANNEL_RX   ${USBPD_PORT0_DMA_CHANNEL_RX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_CHANNEL_RX   ${USBPD_PORT1_DMA_CHANNEL_RX}
[/#if]

/* defined used to configure function : BSP_USBPD_Init_DMATxInstance, BSP_USBPD_DeInit_DMATxInstance */
#define UCPDDMA_INSTANCE0_CLOCKENABLE_TX  ${USBPDenableClock}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_CLOCKENABLE_TX  ${USBPDenableClock}
[/#if]

#define UCPDDMA_INSTANCE0_DMA_TX  ${USBPD_PORT0_DMA_TX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_DMA_TX  ${USBPD_PORT1_DMA_TX}
[/#if]

#define UCPDDMA_INSTANCE0_REQUEST_TX   DMA_REQUEST_${USBPD_PORT0_DMA_REQUEST_TX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_REQUEST_TX   DMA_REQUEST_${USBPD_PORT1_DMA_REQUEST_TX}
[/#if]

#define UCPDDMA_INSTANCE0_LL_CHANNEL_TX   LL_DMA_${USBPD_PORT0_DMA_LL_CHANNEL_TX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_LL_CHANNEL_TX   LL_DMA_${USBPD_PORT1_DMA_LL_CHANNEL_TX}
[/#if]

#define UCPDDMA_INSTANCE0_CHANNEL_TX   ${USBPD_PORT0_DMA_CHANNEL_TX}
[#if USBPD1Used]
#define UCPDDMA_INSTANCE1_CHANNEL_TX   ${USBPD_PORT1_DMA_CHANNEL_TX}
[/#if]

/* defined used to configure  BSP_USBPD_SetFRSSignalling */
[#if USBPD_PORT0_FRSTX1_PIN != ""]
#define UCPDFRS_INSTANCE0_FRSCC1   {                                                                   \
                                     LL_IOP_GRP1_EnableClock(LL_IOP_GRP1_PERIPH_GPIO${USBPD_PORT0_FRSTX1_GPIO_PORT});                \
                                     LL_GPIO_SetPinMode(GPIO${USBPD_PORT0_FRSTX1_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX1_GPIO_PIN}, LL_GPIO_MODE_ALTERNATE); \
                                     LL_GPIO_SetAFPin_0_7(GPIO${USBPD_PORT0_FRSTX1_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX1_GPIO_PIN}, LL_GPIO_AF_${USBPD_PORT0_FRSTX1_SELECT_AF});         \
                                   }
[#else]
#define UCPDFRS_INSTANCE0_FRSCC1
[/#if]
[#if USBPD_PORT0_FRSTX2_PIN != ""]
#define UCPDFRS_INSTANCE0_FRSCC2   {                                                                   \
                                     LL_IOP_GRP1_EnableClock(LL_IOP_GRP1_PERIPH_GPIO${USBPD_PORT0_FRSTX2_GPIO_PORT});                \
                                     LL_GPIO_SetPinMode(GPIO${USBPD_PORT0_FRSTX2_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX2_GPIO_PIN}, LL_GPIO_MODE_ALTERNATE); \
                                     LL_GPIO_SetAFPin_0_7(GPIO${USBPD_PORT0_FRSTX2_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX2_GPIO_PIN}, LL_GPIO_AF_${USBPD_PORT0_FRSTX2_SELECT_AF});         \
                                   }
[#else]
#define UCPDFRS_INSTANCE0_FRSCC2
[/#if]
[#if USBPD1Used]
    [#if USBPD_PORT1_FRSTX1_PIN != ""]
#define UCPDFRS_INSTANCE1_FRSCC1   {                                                                   \
                                     LL_IOP_GRP1_EnableClock(LL_IOP_GRP1_PERIPH_GPIO${USBPD_PORT1_FRSTX1_GPIO_PORT});                \
                                     LL_GPIO_SetPinMode(GPIO${USBPD_PORT1_FRSTX1_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT1_FRSTX1_GPIO_PIN}, LL_GPIO_MODE_ALTERNATE); \
                                     LL_GPIO_SetAFPin_0_7(GPIO${USBPD_PORT1_FRSTX1_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT1_FRSTX1_GPIO_PIN}, LL_GPIO_AF_${USBPD_PORT1_FRSTX1_SELECT_AF});         \
                                   }
    [#else]
#define UCPDFRS_INSTANCE1_FRSCC1
    [/#if]
    [#if USBPD_PORT1_FRSTX2_PIN != ""]
#define UCPDFRS_INSTANCE1_FRSCC2   {                                                                   \
                                     LL_IOP_GRP1_EnableClock(LL_IOP_GRP1_PERIPH_GPIO${USBPD_PORT1_FRSTX2_GPIO_PORT});                \
                                     LL_GPIO_SetPinMode(GPIO${USBPD_PORT1_FRSTX2_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT1_FRSTX2_GPIO_PIN}, LL_GPIO_MODE_ALTERNATE); \
                                     LL_GPIO_SetAFPin_0_7(GPIO${USBPD_PORT1_FRSTX2_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT1_FRSTX2_GPIO_PIN}, LL_GPIO_AF_${USBPD_PORT1_FRSTX2_SELECT_AF});         \
                                   }
    [#else]
#define UCPDFRS_INSTANCE1_FRSCC2
    [/#if]
[/#if]

#define UCPD_INSTANCE0_ENABLEIRQ   do{                                                                 \
                                        NVIC_SetPriority(${USBPD_PORT0_IRQ},0);                              \
                                        NVIC_EnableIRQ(${USBPD_PORT0_IRQ});                                  \
                                    } while(0)

[#if USBPD1Used]
#define UCPD_INSTANCE1_ENABLEIRQ   do{                                                                 \
                                        NVIC_SetPriority(${USBPD_PORT1_IRQ},0);                              \
                                        NVIC_EnableIRQ(${USBPD_PORT1_IRQ});                                  \
                                    } while(0)
[/#if]

/* -----------------------------------------------------------------------------
      Definitions for TRACE feature
-------------------------------------------------------------------------------*/

/* Enable below USE_FULL_LL_DRIVER_USART compilation flag to use generic LL_USART_Init() function */
/* #define USE_FULL_LL_DRIVER_USART */

[#if !UARTUsed]/*[/#if]
#define TRACE_BAUDRATE                          ${UARTbaudrate}u

#define TRACE_USART_INSTANCE                    ${UARTinstance}

#define TRACE_TX_GPIO                           GPIO${UART_TX_GPIO_PORT}
#define TRACE_TX_PIN                            LL_GPIO_PIN_${UART_TX_GPIO_PIN}
#define TRACE_TX_AF                             LL_GPIO_AF_${UART_TX_SELECT_AF}
#define TRACE_RX_GPIO                           GPIO${UART_RX_GPIO_PORT}
#define TRACE_RX_PIN                            LL_GPIO_PIN_${UART_RX_GPIO_PIN}
#define TRACE_RX_AF                             LL_GPIO_AF_${UART_RX_SELECT_AF}
#define TRACE_GPIO_ENABLE_CLOCK()               LL_IOP_GRP1_EnableClock(LL_IOP_GRP1_PERIPH_GPIO${UART_TX_GPIO_PORT})

#define TRACE_ENABLE_CLK_USART()                ${UARTenableClock}
#define TRACE_SET_CLK_SOURCE_USART()            // No need for clock source selection in case of USART3 // LL_RCC_SetUSARTClockSource(LL_RCC_USART3_CLKSOURCE_PCLK2)
#define TRACE_USART_IRQ                         ${UARTinterrupt}
#define TRACE_TX_AF_FUNCTION                    LL_GPIO_SetAFPin_0_7
#define TRACE_RX_AF_FUNCTION                    LL_GPIO_SetAFPin_0_7
[#if UART_TX_DMA != "" && UART_TX_DMA != "valueNotSetted"]
#define TRACE_DMA_INSTANCE                      ${UART_TX_DMA}
#define TRACE_ENABLE_CLK_DMA()                  ${USBPDenableClock}
#define TRACE_TX_DMA_REQUEST                    LL_DMAMUX_REQ_${UART_TX_DMA_REQUEST}
#define TRACE_TX_DMA_CHANNEL                    LL_DMA_${UART_TX_DMA_LL_CHANNEL}
#define TRACE_TX_DMA_IRQ                        ${UART_TX_DMA_interrupt}
#define TRACE_TX_DMA_ACTIVE_FLAG                LL_DMA_IsActiveFlag_TC${UART_TX_DMA_CHANNEL_ID}
#define TRACE_TX_DMA_CLEAR_FLAG                 LL_DMA_ClearFlag_GI${UART_TX_DMA_CHANNEL_ID}
[/#if]
[#if !UARTUsed]*/[/#if]

/* -----------------------------------------------------------------------------
      Definitions for timer service feature
-------------------------------------------------------------------------------*/

#define TIMX                           ${TIMinstance}
#define TIMX_CLK_ENABLE                ${TIMenableClock}
#define TIMX_IRQ                       ${TIMinterrupt}
#define TIMX_CHANNEL_CH1               LL_TIM_CHANNEL_CH1
#define TIMX_CHANNEL_CH2               LL_TIM_CHANNEL_CH2
#define TIMX_CHANNEL_CH3               LL_TIM_CHANNEL_CH3
#define TIMX_CHANNEL_CH4               LL_TIM_CHANNEL_CH4
#define TIMX_CHANNEL1_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH1(TIMX, (us_time + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC1(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL2_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH2(TIMX, (us_time + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC2(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL3_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH3(TIMX, (us_time + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC3(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL4_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH4(TIMX, (us_time + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC4(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL1_GETFLAG          LL_TIM_IsActiveFlag_CC1
#define TIMX_CHANNEL2_GETFLAG          LL_TIM_IsActiveFlag_CC2
#define TIMX_CHANNEL3_GETFLAG          LL_TIM_IsActiveFlag_CC3
#define TIMX_CHANNEL4_GETFLAG          LL_TIM_IsActiveFlag_CC4

#ifdef __cplusplus
 }
#endif

#endif /* USBPD_DEVICE_CONF_H */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
