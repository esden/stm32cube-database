[#ftl]
/*!
 * \file      Commissioning.h
 *
 * \brief     End-device commissioning parameters
 *
 * \copyright Revised BSD License, see section \ref LICENSE.
 *
 * \code
 *                ______                              _
 *               / _____)             _              | |
 *              ( (____  _____ ____ _| |_ _____  ____| |__
 *               \____ \| ___ |    (_   _) ___ |/ ___)  _ \
 *               _____) ) ____| | | || |_| ____( (___| | | |
 *              (______/|_____)_|_|_| \__)_____)\____)_| |_|
 *              (C)2013-2020 Semtech
 *
 * \endcode
 */
/**
  ******************************************************************************
  *
  *          Portions COPYRIGHT 2020 STMicroelectronics
  *
  * @file    Commissioning.h
  * @author  MCD Application Team
  * @brief   End-device commissioning parameters
  ******************************************************************************
 */
[#--
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
--]
[#assign LORAWAN_PUBLIC_NETWORK = ""]
[#assign LORAWAN_NETWORK_ID = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "LORAWAN_PUBLIC_NETWORK"]
                    [#assign LORAWAN_PUBLIC_NETWORK = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_NETWORK_ID"]
                    [#assign LORAWAN_NETWORK_ID = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COMMISSIONING_H__
#define __COMMISSIONING_H__

/*!
 ******************************************************************************
 ********************************** WARNING ***********************************
 ******************************************************************************

 The LoRaWAN AES128 keys are stored and provisioned on secure-elements.

 This project provides a software emulated secure-element.
 The LoRaWAN AES128 keys SHALL be updated under
 src/peripherals/<secure-element name>-se\se-identity.h file.

 ******************************************************************************
 ******************************************************************************
 ******************************************************************************
 */
#include "se-identity.h"

/* USER CODE BEGIN EC1 */

/* USER CODE END EC1 */

/*!
 * When using ABP activation the MAC layer must know in advance to which server
 * version it will be connected.
 */
#define ABP_ACTIVATION_LRWAN_VERSION_V10x                  0x01000300 /* 1.0.3.0 */

#define ABP_ACTIVATION_LRWAN_VERSION                       ABP_ACTIVATION_LRWAN_VERSION_V10x

/*!
 * Indicates if the end-device support the operation with repeaters
 */
#define LORAWAN_REPEATER_SUPPORT                           false

/*!
 * Indicates if the end-device is to be connected to a private or public network
 */
#define LORAWAN_PUBLIC_NETWORK                             ${LORAWAN_PUBLIC_NETWORK}

/*!
 * Current network ID
 */
#define LORAWAN_NETWORK_ID                                 ( uint32_t )${LORAWAN_NETWORK_ID}

/* USER CODE BEGIN EC2 */

/* USER CODE END EC2 */

#endif /* __COMMISSIONING_H__ */
