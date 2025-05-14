[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ble_timer.h
  * @author  MCD Application Team
  * @brief   This header defines the timer functions used by the BLE stack
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef BLE_TIMER_H__
#define BLE_TIMER_H__


void BLE_TIMER_Init( void );

uint8_t BLE_TIMER_Start( uint16_t id,
                     uint32_t ms_timeout );

void BLE_TIMER_Stop( uint16_t id );

/* Callback
 */
void BLE_TIMERCB_Expiry( uint16_t id );


#endif /* BLE_TIMER_H__ */
