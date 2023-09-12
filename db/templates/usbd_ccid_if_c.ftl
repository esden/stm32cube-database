[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : usbd_ccid_if.c
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          :
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign handleNameFS = ""]
[#assign handleNameHS = ""]
[#assign handleNameUSB_FS = ""]
[#list SWIPdatas as SWIP]
[#compress]
[#-- Section2: Create global Variables for each middle ware instance --]
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
		[#-- extern ${variable.type} --][#if variable.value??][#--${variable.value};--]
		[#if variable.value?contains("FS")][#assign handleNameFS = "FS"][/#if]
		[#if variable.value?contains("USB_FS")][#assign handleNameUSB_FS = "FS"][/#if]
		[#if variable.value?contains("HS")][#assign handleNameHS = "HS"][/#if]
		[/#if]
	[/#list]
[/#if]
[#-- Global variables --]
[/#compress]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "usbd_ccid_if.h"

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */


/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @brief Usb device library.
  * @{
  */


/** @addtogroup USBD_CCID_IF
  * @{
  */

/** @defgroup USBD_CCID_IF_Private_TypesDefinitions USBD_CCID_IF_Private_TypesDefinitions
  * @brief Private types.
  * @{
  */

/* USER CODE BEGIN PRIVATE_TYPES */

/* USER CODE END PRIVATE_TYPES */

/**
  * @}
  */


/** @defgroup USBD_CCID_IF_Private_Defines USBD_CCID_IF_Private_Defines
  * @brief Private defines.
  * @{
  */

/* USER CODE BEGIN PRIVATE_DEFINES */

/* USER CODE END PRIVATE_DEFINES */

/**
  * @}
  */


/** @defgroup USBD_CCID_IF_Private_Macros USBD_CCID_IF_Private_Macros
  * @brief Private macros.
  * @{
  */

/* USER CODE BEGIN PRIVATE_MACRO */

/* USER CODE END PRIVATE_MACRO */

/**
  * @}
  */

/** @defgroup USBD_CCID_IF_Private_Variables USBD_CCID_IF_Private_Variables
  * @brief Private variables.
  * @{
  */

/* USER CODE BEGIN PRIVATE_VARIABLES */

/* USER CODE END PRIVATE_VARIABLES */

/**
  * @}
  */

/** @defgroup USBD_CCID_IF_Exported_Variables USBD_CCID_IF_Exported_Variables
  * @brief Public variables.
  * @{
  */

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
extern USBD_HandleTypeDef hUsbDeviceFS;
[/#if]
[#if handleNameHS == "HS"]
extern USBD_HandleTypeDef hUsbDeviceHS;
[/#if]

/* USER CODE BEGIN EXPORTED_VARIABLES */

/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */

/** @defgroup USBD_CCID_IF_Private_FunctionPrototypes USBD_CCID_IF_Private_FunctionPrototypes
  * @brief Private functions declaration.
  * @{
  */

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
static int8_t SC_If_Init_FS(void);
static int8_t SC_If_DeInit_FS(void);
static int8_t SC_If_Decode_FS(uint8_t msg, uint8_t *pbuf, uint16_t length);
[/#if]

[#if handleNameHS == "HS"]
static int8_t SC_If_Init_HS(void);
static int8_t SC_If_DeInit_HS(void);
static int8_t SC_If_Decode_HS(uint8_t msg, uint8_t *pbuf, uint16_t length);
[/#if]

/* USER CODE BEGIN PRIVATE_FUNCTIONS_DECLARATION */

/* USER CODE END PRIVATE_FUNCTIONS_DECLARATION */

/**
  * @}
  */

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
USBD_CCID_ItfTypeDef USBD_CCID_fops_FS =
{
  SC_If_Init_FS,
  SC_If_DeInit_FS,
  SC_If_Decode_FS
};
[/#if]

[#if handleNameHS == "HS"]
USBD_CCID_ItfTypeDef USBD_CCID_fops_HS =
{
  SC_If_Init_HS,
  SC_If_DeInit_HS,
  SC_If_Decode_HS
};
[/#if]

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/**
  * @brief  Memory initialization routine.
  * @retval USBD_OK if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Init_FS(void)
{
  /* USER CODE BEGIN 0 */
  return (USBD_OK);
  /* USER CODE END 0 */
}

/**
  * @brief  Memory deinitialization routine.
  * @retval USBD_OK if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_DeInit_FS(void)
{
  /* USER CODE BEGIN 1 */
  return (USBD_OK);
  /* USER CODE END 1 */
}


/**
  * @brief  .
  * @param  msg: .
  * @param  pbuf: .
  * @param  length: .
  * @retval USBD_OK if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Decode_FS(uint8_t msg, uint8_t *pbuf, uint16_t length)
{
  /* USER CODE BEGIN 2 */
  switch(msg)
  {
  case PC_TO_RDR_ICCPOWERON:
    break;
  case PC_TO_RDR_ICCPOWEROFF:
    break;
  case PC_TO_RDR_GETSLOTSTATUS:
    break;
  case PC_TO_RDR_XFRBLOCK:
    break;
  case PC_TO_RDR_GETPARAMETERS:
    break;
  case PC_TO_RDR_RESETPARAMETERS:
    break;
  case PC_TO_RDR_SETPARAMETERS:
    break;
  case PC_TO_RDR_ESCAPE:
    break;
  case PC_TO_RDR_ICCCLOCK:
    break;
  case PC_TO_RDR_ABORT:
    break;
  case PC_TO_RDR_T0APDU:
    break;
  case PC_TO_RDR_MECHANICAL:
    break;   
  case PC_TO_RDR_SETDATARATEANDCLOCKFREQUENCY:
    break;
  case PC_TO_RDR_SECURE:
    break;
  default:
    break;
  }
  return (USBD_OK);
  /* USER CODE END 2 */
}
[/#if]

[#if handleNameHS == "HS"]
/**
  * @brief  Memory initialization routine.
  * @retval USBD_OK if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Init_HS(void)
{ 
  /* USER CODE BEGIN 3 */
  return (USBD_OK);
  /* USER CODE END 3 */
}

/**
  * @brief  Memory deinitialization routine.
  * @retval USBD_OK if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_DeInit_HS(void)
{ 
  /* USER CODE BEGIN 4 */
  return (USBD_OK);
  /* USER CODE END 4 */
}

/**
  * @brief  .
  * @param  msg: .
  * @param  pbuf: .
  * @param  length: .
  * @retval USBD_OK if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Decode_HS(uint8_t msg, uint8_t *pbuf, uint16_t length)
{
  /* USER CODE BEGIN 5 */
  switch(msg)
  {
  case PC_TO_RDR_ICCPOWERON:
    break;
  case PC_TO_RDR_ICCPOWEROFF:
    break;
  case PC_TO_RDR_GETSLOTSTATUS:
    break;
  case PC_TO_RDR_XFRBLOCK:
    break;
  case PC_TO_RDR_GETPARAMETERS:
    break;
  case PC_TO_RDR_RESETPARAMETERS:
    break;
  case PC_TO_RDR_SETPARAMETERS:
    break;
  case PC_TO_RDR_ESCAPE:
    break;
  case PC_TO_RDR_ICCCLOCK:
    break;
  case PC_TO_RDR_ABORT:
    break;
  case PC_TO_RDR_T0APDU:
    break;
  case PC_TO_RDR_MECHANICAL:
    break;   
  case PC_TO_RDR_SETDATARATEANDCLOCKFREQUENCY:
    break;
  case PC_TO_RDR_SECURE:
    break;
  default:
    break;
  }
  return (USBD_OK);
  /* USER CODE END 5 */
}
[/#if]

/* USER CODE BEGIN PRIVATE_FUNCTIONS_IMPLEMENTATION */

/* USER CODE END PRIVATE_FUNCTIONS_IMPLEMENTATION */

/**
  * @}
  */

/**
  * @}
  */
