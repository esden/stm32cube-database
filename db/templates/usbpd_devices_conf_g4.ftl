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
[#assign USBPDCORE_LIB_NO_PD = false]

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "USBPD_CoreLib" && definition.value == "USBPDCORE_LIB_NO_PD"]
                [#assign USBPDCORE_LIB_NO_PD = true]
            [/#if]
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
            [#if definition.name == "TIMenableClock"]
                [#assign TIMenableClock = definition.value]
            [/#if]
            [#if definition.name == "TIMdisableClock"]
                [#assign TIMdisableClock = definition.value]
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
#include "${FamilyName?lower_case}xx_ll_bus.h"
#include "${FamilyName?lower_case}xx_ll_dma.h"
#include "${FamilyName?lower_case}xx_ll_gpio.h"
#include "${FamilyName?lower_case}xx_ll_rcc.h"
#include "${FamilyName?lower_case}xx_ll_ucpd.h"
#include "${FamilyName?lower_case}xx_ll_pwr.h"
[#if TIMinstance??]
    [#if TIMinstance?starts_with("LPTIM")][#t]
        [#t]#include "${FamilyName?lower_case}xx_ll_lptim.h"
    [/#if][#t]
    [#if TIMinstance?starts_with("TIM")][#t]
        [#t]#include "${FamilyName?lower_case}xx_ll_tim.h"
    [/#if]
[/#if]
#include "usbpd_pwr_user.h"
#include "usbpd_pwr_if.h"

/* USER CODE BEGIN Includes */

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

/* defined used to configure function : BSP_USBPD_Init_DMARxInstance,BSP_USBPD_DeInit_DMARxInstance */
#define UCPDDMA_INSTANCE0_CLOCKENABLE_RX  ${USBPDenableClock}

#define UCPDDMA_INSTANCE0_DMA_RX  ${USBPD_PORT0_DMA_RX}

#define UCPDDMA_INSTANCE0_REQUEST_RX   DMA_REQUEST_${USBPD_PORT0_DMA_REQUEST_RX}

#define UCPDDMA_INSTANCE0_LL_CHANNEL_RX   LL_DMA_${USBPD_PORT0_DMA_LL_CHANNEL_RX}

#define UCPDDMA_INSTANCE0_CHANNEL_RX   ${USBPD_PORT0_DMA_CHANNEL_RX}

/* defined used to configure function : BSP_USBPD_Init_DMATxInstance, BSP_USBPD_DeInit_DMATxInstance */
#define UCPDDMA_INSTANCE0_CLOCKENABLE_TX  ${USBPDenableClock}

#define UCPDDMA_INSTANCE0_DMA_TX  ${USBPD_PORT0_DMA_TX}

#define UCPDDMA_INSTANCE0_REQUEST_TX   DMA_REQUEST_${USBPD_PORT0_DMA_REQUEST_TX}

#define UCPDDMA_INSTANCE0_LL_CHANNEL_TX   LL_DMA_${USBPD_PORT0_DMA_LL_CHANNEL_TX}

#define UCPDDMA_INSTANCE0_CHANNEL_TX   ${USBPD_PORT0_DMA_CHANNEL_TX}

/* defined used to configure  BSP_USBPD_SetFRSSignalling */
[#if USBPD_PORT0_FRSTX1_PIN != ""]
#define UCPDFRS_INSTANCE0_FRSCC1   {                                                                   \
                                     LL_AHB2_GRP1_EnableClock(LL_AHB2_GRP1_PERIPH_GPIO${USBPD_PORT0_FRSTX1_GPIO_PORT});                \
                                     LL_GPIO_SetPinMode(GPIO${USBPD_PORT0_FRSTX1_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX1_GPIO_PIN}, LL_GPIO_MODE_ALTERNATE); \
                                     [#if USBPD_PORT0_FRSTX1_GPIO_PIN?number < 8]LL_GPIO_SetAFPin_0_7[#else]LL_GPIO_SetAFPin_8_15[/#if](GPIO${USBPD_PORT0_FRSTX1_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX1_GPIO_PIN}, LL_GPIO_AF_${USBPD_PORT0_FRSTX1_SELECT_AF});         \
                                   }
[#else]
#define UCPDFRS_INSTANCE0_FRSCC1
[/#if]
[#if USBPD_PORT0_FRSTX2_PIN != ""]
#define UCPDFRS_INSTANCE0_FRSCC2   {                                                                   \
                                     LL_AHB2_GRP1_EnableClock(LL_AHB2_GRP1_PERIPH_GPIO${USBPD_PORT0_FRSTX2_GPIO_PORT});                \
                                     LL_GPIO_SetPinMode(GPIO${USBPD_PORT0_FRSTX2_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX2_GPIO_PIN}, LL_GPIO_MODE_ALTERNATE); \
                                     [#if USBPD_PORT0_FRSTX2_GPIO_PIN?number < 8]LL_GPIO_SetAFPin_0_7[#else]LL_GPIO_SetAFPin_8_15[/#if](GPIO${USBPD_PORT0_FRSTX2_GPIO_PORT}, LL_GPIO_PIN_${USBPD_PORT0_FRSTX2_GPIO_PIN}, LL_GPIO_AF_${USBPD_PORT0_FRSTX2_SELECT_AF});         \
                                   }
[#else]
#define UCPDFRS_INSTANCE0_FRSCC2
[/#if]

#define UCPD_INSTANCE0_ENABLEIRQ   do{                                                                 \
                                        NVIC_SetPriority(${USBPD_PORT0_IRQ},4);                              \
                                        NVIC_EnableIRQ(${USBPD_PORT0_IRQ});                                  \
                                    } while(0)


/* -----------------------------------------------------------------------------
      Definitions for timer service feature
-------------------------------------------------------------------------------*/

#define TIMX                           ${TIMinstance}
#define TIMX_CLK_ENABLE                ${TIMenableClock}
#define TIMX_CLK_DISABLE               ${TIMdisableClock}
#define TIMX_CHANNEL_CH1               LL_TIM_CHANNEL_CH1
#define TIMX_CHANNEL_CH2               LL_TIM_CHANNEL_CH2
#define TIMX_CHANNEL_CH3               LL_TIM_CHANNEL_CH3
#define TIMX_CHANNEL_CH4               LL_TIM_CHANNEL_CH4
#define TIMX_CHANNEL1_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH1(TIMX, (TimeUs + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC1(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL2_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH2(TIMX, (TimeUs + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC2(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL3_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH3(TIMX, (TimeUs + TIMX->CNT) % TIM_MAX_TIME);\
                                          LL_TIM_ClearFlag_CC3(TIMX);                                         \
                                       }while(0)
#define TIMX_CHANNEL4_SETEVENT         do{                                                                    \
                                          LL_TIM_OC_SetCompareCH4(TIMX, (TimeUs + TIMX->CNT) % TIM_MAX_TIME);\
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

