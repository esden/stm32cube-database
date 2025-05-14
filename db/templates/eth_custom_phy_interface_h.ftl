[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    eth_custom_phy_interface.h
  * @author  MCD Application Team
  * @brief   This file contains all the functions prototypes for the
  *          eth_custom_phy_interface.c PHY driver.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2014 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 


#ifndef ETH_CUSTOM_PHY_INTERFACE_H
#define ETH_CUSTOM_PHY_INTERFACE_H

#ifdef   __cplusplus
extern   "C" {
#endif
#include <stdint.h>


#define  ETH_PHY_STATUS_ERROR                 ((int32_t)-1)
#define  ETH_PHY_STATUS_OK                    ((int32_t) 0)

#define  ETH_PHY_STATUS_LINK_ERROR            ((int32_t) 0)
#define  ETH_PHY_STATUS_LINK_DOWN             ((int32_t) 1)

#define  ETH_PHY_STATUS_100MBITS_FULLDUPLEX   ((int32_t) 2)
#define  ETH_PHY_STATUS_100MBITS_HALFDUPLEX   ((int32_t) 3)
#define  ETH_PHY_STATUS_10MBITS_FULLDUPLEX    ((int32_t) 4)
#define  ETH_PHY_STATUS_10MBITS_HALFDUPLEX    ((int32_t) 5)
#define  ETH_PHY_STATUS_AUTONEGO_NOT_DONE     ((int32_t) 6)
#if defined(ETH_PHY_1000MBITS_SUPPORTED)
#define  ETH_PHY_STATUS_1000MBITS_FULLDUPLEX  ((int32_t) 7)
#define  ETH_PHY_STATUS_1000MBITS_HALFDUPLEX  ((int32_t) 8)
#endif

int32_t eth_phy_init(void);

int32_t eth_phy_get_link_state(void);

#ifdef   __cplusplus
}
#endif
#endif
