[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?lower_case}.c
  * @author  MCD Application Team
  * @brief   This file contains the device define.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "usbpd.h"
[#if GUI_INTERFACE??]
#include "gui_api.h"
[/#if]

/* USER CODE BEGIN 0 */
/* USER CODE END 0 */

/* USER CODE BEGIN 1 */
/* USER CODE END 1 */

/* Private variables ---------------------------------------------------------*/
[#if GUI_INTERFACE??]
const uint8_t HWBoardVersionName[] = "${BOARD_NAME}";
const uint8_t PDTypeName[] = "${PD_TYPE_NAME}";
[/#if]

/* Private functions ---------------------------------------------------------*/
[#if GUI_INTERFACE??]
static const uint8_t*          GetHWBoardVersionName(void);
static const uint8_t*          GetPDTypeName(void);
[/#if]

/* USER CODE BEGIN 2 */
/* USER CODE END 2 */

/* USBPD init function */
void MX_USBPD_Init(void)
{

[#if USBPD_CORELIB != "USBPDCORE_LIB_NO_PD"]
  /* Global Init of USBPD HW */
  USBPD_HW_IF_GlobalHwInit();
[/#if]

  /* Initialize the Device Policy Manager */
  if (USBPD_OK != USBPD_DPM_InitCore())
  {
    while(1);
  }

[#if GUI_INTERFACE??]
  /* Initialize GUI before retrieving PDO from RAM */
  GUI_Init(GetHWBoardVersionName, GetPDTypeName, HW_IF_PWR_GetVoltage, HW_IF_PWR_GetCurrent);
[/#if]

[#if USBPD_CORELIB != "USBPDCORE_LIB_NO_PD"]
  /* Initialise the DPM application */
  if (USBPD_OK != USBPD_DPM_UserInit())
  {
    while(1);
  }
[/#if]

  /* USER CODE BEGIN 3 */
  /* USER CODE END 3 */

  if (USBPD_OK != USBPD_DPM_InitOS())
  {
    while(1);
  }

  /* USER CODE BEGIN EnableIRQ */
  /* Enable IRQ which has been disabled by FreeRTOS services */
  __enable_irq();
  /* USER CODE END EnableIRQ */

}
[#if GUI_INTERFACE??]
/**
  * @brief  This method returns HW board version name
  * @retval HW Board version name
  */
static const uint8_t* GetHWBoardVersionName(void)
{
  return HWBoardVersionName;
}

/**
  * @brief  This method returns HW PD Type name
  * @retval HW Board version name
  */
static const uint8_t* GetPDTypeName(void)
{
  return PDTypeName;
}
[/#if]

/* USER CODE BEGIN 4 */
/* USER CODE END 4 */

/**
  * @}
  */
 
/**
  * @}
  */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
