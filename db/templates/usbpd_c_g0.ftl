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
#define BSP_BOARD_NAME  "${BOARD_NAME}";
#define BSP_BOARD_ID    "${PD_TYPE_NAME}";
[/#if]

/* Private functions ---------------------------------------------------------*/

/* USER CODE BEGIN 2 */
/* USER CODE END 2 */
[#if THREADX??]
unsigned int USBPD_PreInitOs(void)
{
[#if USBPD_CORELIB != "USBPDCORE_LIB_NO_PD"]
  /* Global Init of USBPD HW */
  USBPD_HW_IF_GlobalHwInit();
[/#if]
 /* Initialize the Device Policy Manager */
  if (USBPD_OK != USBPD_DPM_InitCore())
  {
    return USBPD_ERROR;
  }
[#if GUI_INTERFACE??]
  /* Initialize GUI before retrieving PDO from RAM */
  GUI_Init(BSP_GetBoardName, BSP_GetBoardID, HW_IF_PWR_GetVoltage, HW_IF_PWR_GetCurrent);
[/#if]
  
  return USBPD_OK;
}

/* USBPD init function */
unsigned int MX_USBPD_Init(void *memory_ptr)
{
  unsigned int result = USBPD_OK;

[#if USBPD_CORELIB != "USBPDCORE_LIB_NO_PD"]
  /* Initialise the DPM application */
  if (USBPD_OK != USBPD_DPM_UserInit())
  {
    return USBPD_ERROR;
  }
[/#if]

  /* USER CODE BEGIN 3 */
  /* USER CODE END 3 */

  if (USBPD_OK != USBPD_DPM_InitOS((void*)memory_ptr))
  {
    return USBPD_ERROR;
  }
  return result;
}
[#else]
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
  GUI_Init(BSP_GetBoardName, BSP_GetBoardID, HW_IF_PWR_GetVoltage, HW_IF_PWR_GetCurrent);
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
[/#if]

[#if GUI_INTERFACE??]
/**
  * @brief  This method returns the board name
  * @retval pointer to the board name string
  */
__weak const uint8_t* BSP_GetBoardName(void)
{
  return (const uint8_t*)BSP_BOARD_NAME;
}

/**
  * @brief  This method returns the board ID
  * @retval pointer to the board ID string
  */
__weak const uint8_t* BSP_GetBoardID(void)
{
  return (const uint8_t*)BSP_BOARD_ID;
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