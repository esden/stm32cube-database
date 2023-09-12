[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${name}
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : This file implements the board support package for the USB device library
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
[#if SWIncludes??]
[#list SWIncludes as include]
#include "${include}"
[/#list]
[/#if]
#include "usbd_core.h"
[#assign handleNameFS = ""]
[#assign handleNameUSB_FS = ""]
[#assign handleNameHS = ""]
[#assign instanceNb = 0]
[#assign includeMspDone = 0]
[#assign className = ""]
[#list SWIPdatas as SWIP]
[#compress]
[#-- Section2: Create global Variables for each middle ware instance --]
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
		[#-- extern ${variable.type} --][#if variable.value??][#--${variable.value};--]
		[#if variable.value == "MSC"][#assign className = "MSC"][/#if]
		[#if variable.value == "DFU"][#assign className = "DFU"][/#if]
		[#if variable.value == "HID"][#assign className = "HID"][/#if]
		[#if variable.value == "AUDIO"][#assign className = "AUDIO"][/#if]
		[#if variable.value == "CCID"][#assign className = "CCID"][/#if]
		[#if variable.value == "MTP"][#assign className = "MTP"][/#if]
		[#if variable.value == "CDC"][#assign className = "CDC"][/#if]
		[#if variable.value == "CUSTOM_HID"][#assign className = "CUSTOMHID"][/#if]
		[#if variable.value?contains("OTG_FS")][#assign handleNameFS = "FS"][/#if]
		[#if variable.value?contains("USB_FS")][#assign handleNameUSB_FS = "FS"][/#if]
		[#if variable.value?contains("OTG_HS")][#assign handleNameHS = "HS"][/#if]
		[/#if]
	[/#list]
[/#if]
[#-- Global variables --]
[/#compress]
[/#list]
[#if className == "AUDIO"]
#include "usbd_audio.h"
[/#if]
[#if className == "DFU"]
#include "usbd_dfu.h"
[/#if]
[#if className == "HID"]
#include "usbd_hid.h"
[/#if]
[#if className == "MSC"]
#include "usbd_msc.h"
[/#if]
[#if className == "CDC"]
#include "usbd_cdc.h"
[/#if]
[#if className == "CUSTOMHID"]
#include "usbd_customhid.h"
[/#if]
[#if className == "CCID"]
#include "usbd_ccid.h"
[/#if]
[#if className == "MTP"]
#include "usbd_mtp.h"
[/#if]


/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

[#if handleNameFS == "FS"]
[#include mxTmpFolder+"/usb_otg_fs_vars.tmp"]
[/#if]
[#if handleNameUSB_FS = "FS"]
[#include mxTmpFolder+"/usb_vars.tmp"]
[/#if]
[#if handleNameHS == "HS"]
[#include mxTmpFolder+"/usb_otg_hs_vars.tmp"]
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */

/* Private functions ---------------------------------------------------------*/
static USBD_StatusTypeDef USBD_Get_USB_Status(HAL_StatusTypeDef hal_status);
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCDEx_SetConnectionState(PCD_HandleTypeDef *hpcd, uint8_t state);
else
void HAL_PCDEx_SetConnectionState(PCD_HandleTypeDef *hpcd, uint8_t state);
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */

/*******************************************************************************
                       LL Driver Callbacks (PCD -> USB Device Library)
*******************************************************************************/
/* MSP Init */
[#if handleNameFS == "FS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include mxTmpFolder+"/usb_otg_fs_Msp.tmp"]
[/#if]
[/#if]

[#if handleNameHS == "HS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include mxTmpFolder+"/usb_otg_hs_Msp.tmp"]
[/#if]
[/#if]

[#if handleNameUSB_FS == "FS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include mxTmpFolder+"/usb_Msp.tmp"]
[/#if]
[/#if]

/**
  * @brief  Setup stage callback
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_SetupStageCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_SetupStageCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_SetupStage((USBD_HandleTypeDef*)hpcd->pData, (uint8_t *)hpcd->Setup);
}

/**
  * @brief  Data Out stage callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_DataOutStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_DataOutStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_DataOutStage((USBD_HandleTypeDef*)hpcd->pData, epnum, hpcd->OUT_ep[epnum].xfer_buff);
}

/**
  * @brief  Data In stage callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_DataInStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_DataInStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_DataInStage((USBD_HandleTypeDef*)hpcd->pData, epnum, hpcd->IN_ep[epnum].xfer_buff);
}

/**
  * @brief  SOF callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_SOFCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_SOFCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_SOF((USBD_HandleTypeDef*)hpcd->pData);
}

/**
  * @brief  Reset callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ResetCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_ResetCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{ 
  USBD_SpeedTypeDef speed = USBD_SPEED_FULL;

  if ( hpcd->Init.speed != PCD_SPEED_FULL)
  {
    Error_Handler();
  }
    /* Set Speed. */
  USBD_LL_SetSpeed((USBD_HandleTypeDef*)hpcd->pData, speed);

  /* Reset Device. */
  USBD_LL_Reset((USBD_HandleTypeDef*)hpcd->pData);
}

/**
  * @brief  Suspend callback.
  * When Low power mode is enabled the debug cannot be used (IAR, Keil doesn't support it)
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_SuspendCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_SuspendCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* Inform USB library that core enters in suspend Mode. */
  USBD_LL_Suspend((USBD_HandleTypeDef*)hpcd->pData);
  /* Enter in STOP mode. */
  /* USER CODE BEGIN 2 */
  if (hpcd->Init.low_power_enable)
  {
    /* Set SLEEPDEEP bit and SleepOnExit of Cortex System Control Register. */
    SCB->SCR |= (uint32_t)((uint32_t)(SCB_SCR_SLEEPDEEP_Msk | SCB_SCR_SLEEPONEXIT_Msk));
  }
  /* USER CODE END 2 */
}

/**
  * @brief  Resume callback.
  * When Low power mode is enabled the debug cannot be used (IAR, Keil doesn't support it)
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ResumeCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_ResumeCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN 3 */

  /* USER CODE END 3 */
  USBD_LL_Resume((USBD_HandleTypeDef*)hpcd->pData);
}

/**
  * @brief  ISOOUTIncomplete callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ISOOUTIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_ISOOUTIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_IsoOUTIncomplete((USBD_HandleTypeDef*)hpcd->pData, epnum);
}

/**
  * @brief  ISOINIncomplete callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ISOINIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_ISOINIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_IsoINIncomplete((USBD_HandleTypeDef*)hpcd->pData, epnum);
}

/**
  * @brief  Connect callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ConnectCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_ConnectCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_DevConnected((USBD_HandleTypeDef*)hpcd->pData);
}

/**
  * @brief  Disconnect callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_DisconnectCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_DisconnectCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  USBD_LL_DevDisconnected((USBD_HandleTypeDef*)hpcd->pData);
}

/*******************************************************************************
                       LL Driver Interface (USB Device Library --> PCD)
*******************************************************************************/

/**
  * @brief  Initializes the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Init(USBD_HandleTypeDef *pdev)
{
#t/* Init USB Ip. */
[#if handleNameFS == "FS"]
#tif (pdev->id == DEVICE_FS) {
#t/* Link the driver to the stack. */
#thpcd_USB_OTG_FS.pData = pdev;
#tpdev->pData = &hpcd_USB_OTG_FS;
#t[#include mxTmpFolder+"/usb_otg_fs_HalInit.tmp"]
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
  /* Register USB PCD CallBacks */
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_SOF_CB_ID, PCD_SOFCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_SETUPSTAGE_CB_ID, PCD_SetupStageCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_RESET_CB_ID, PCD_ResetCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_SUSPEND_CB_ID, PCD_SuspendCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_RESUME_CB_ID, PCD_ResumeCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_CONNECT_CB_ID, PCD_ConnectCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_DISCONNECT_CB_ID, PCD_DisconnectCallback);

  HAL_PCD_RegisterDataOutStageCallback(&hpcd_USB_OTG_FS, PCD_DataOutStageCallback);
  HAL_PCD_RegisterDataInStageCallback(&hpcd_USB_OTG_FS, PCD_DataInStageCallback);
  HAL_PCD_RegisterIsoOutIncpltCallback(&hpcd_USB_OTG_FS, PCD_ISOOUTIncompleteCallback);
  HAL_PCD_RegisterIsoInIncpltCallback(&hpcd_USB_OTG_FS, PCD_ISOINIncompleteCallback);
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
#tHAL_PCDEx_SetRxFiFo(&hpcd_USB_OTG_FS, 0x80);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_FS, 0, 0x40);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_FS, 1, 0x80);
#t}
[/#if]
[#if handleNameHS == "HS"]
#tif (pdev->id == DEVICE_HS) {
#t/* Link the driver to the stack. */
#thpcd_USB_OTG_HS.pData = pdev;
#tpdev->pData = &hpcd_USB_OTG_HS;
[#include mxTmpFolder+"/usb_otg_hs_HalInit.tmp"]
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
  /* Register USB PCD CallBacks */
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_SOF_CB_ID, PCD_SOFCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_SETUPSTAGE_CB_ID, PCD_SetupStageCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_RESET_CB_ID, PCD_ResetCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_SUSPEND_CB_ID, PCD_SuspendCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_RESUME_CB_ID, PCD_ResumeCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_CONNECT_CB_ID, PCD_ConnectCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_DISCONNECT_CB_ID, PCD_DisconnectCallback);

  HAL_PCD_RegisterDataOutStageCallback(&hpcd_USB_OTG_HS, PCD_DataOutStageCallback);
  HAL_PCD_RegisterDataInStageCallback(&hpcd_USB_OTG_HS, PCD_DataInStageCallback);
  HAL_PCD_RegisterIsoOutIncpltCallback(&hpcd_USB_OTG_HS, PCD_ISOOUTIncompleteCallback);
  HAL_PCD_RegisterIsoInIncpltCallback(&hpcd_USB_OTG_HS, PCD_ISOINIncompleteCallback);
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
#tHAL_PCDEx_SetRxFiFo(&hpcd_USB_OTG_HS, 0x200);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_HS, 0, 0x80);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_HS, 1, 0x174);
#t}
[/#if]
[#if handleNameUSB_FS == "FS"]
#t/* Link the driver to the stack. */
#thpcd_USB_FS.pData = pdev;
#tpdev->pData = &hpcd_USB_FS;
[#include mxTmpFolder+"/usb_HalInit.tmp"]
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
  /* Register USB PCD CallBacks */
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_SOF_CB_ID, PCD_SOFCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_SETUPSTAGE_CB_ID, PCD_SetupStageCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_RESET_CB_ID, PCD_ResetCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_SUSPEND_CB_ID, PCD_SuspendCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_RESUME_CB_ID, PCD_ResumeCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_CONNECT_CB_ID, PCD_ConnectCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_DISCONNECT_CB_ID, PCD_DisconnectCallback);

  HAL_PCD_RegisterDataOutStageCallback(&hpcd_USB_FS, PCD_DataOutStageCallback);
  HAL_PCD_RegisterDataInStageCallback(&hpcd_USB_FS, PCD_DataInStageCallback);
  HAL_PCD_RegisterIsoOutIncpltCallback(&hpcd_USB_FS, PCD_ISOOUTIncompleteCallback);
  HAL_PCD_RegisterIsoInIncpltCallback(&hpcd_USB_FS, PCD_ISOINIncompleteCallback);
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
#t/* USER CODE BEGIN EndPoint_Configuration */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x00 , PCD_SNG_BUF, 0x18);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x80 , PCD_SNG_BUF, 0x58);
#t/* USER CODE END EndPoint_Configuration */
[#if className == "MSC"]
#t/* USER CODE BEGIN EndPoint_Configuration_MSC */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x81 , PCD_SNG_BUF, 0x98);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x01 , PCD_SNG_BUF, 0xD8);
#t/* USER CODE END EndPoint_Configuration_MSC */
[/#if]
[#if className == "HID"]
#t/* USER CODE BEGIN EndPoint_Configuration_HID */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x81 , PCD_SNG_BUF, 0x100);
#t/* USER CODE END EndPoint_Configuration_HID */
[/#if]
[#if className == "CDC"]
#t/* USER CODE BEGIN EndPoint_Configuration_CDC */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x81 , PCD_SNG_BUF, 0xC0);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x01 , PCD_SNG_BUF, 0x110);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x82 , PCD_SNG_BUF, 0x100);
#t/* USER CODE END EndPoint_Configuration_CDC */
[/#if]
[#if className == "CUSTOMHID"]
#t/* USER CODE BEGIN EndPoint_Configuration_CUSTOM_HID */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , CUSTOM_HID_EPIN_ADDR , PCD_SNG_BUF, 0x98);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , CUSTOM_HID_EPOUT_ADDR , PCD_SNG_BUF, 0xD8);
#t/* USER CODE END EndPoint_Configuration_CUSTOM_HID */
[/#if]
[/#if]
#treturn USBD_OK;
}

/**
  * @brief  De-Initializes the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_DeInit(USBD_HandleTypeDef *pdev)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_DeInit(pdev->pData);

  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status; 
}

/**
  * @brief  Starts the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
 
  hal_status = HAL_PCD_Start(pdev->pData);
  
  usb_status =  USBD_Get_USB_Status(hal_status);  
  
  return usb_status;
}

/**
  * @brief  Stops the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Stop(USBD_HandleTypeDef *pdev)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_Stop(pdev->pData);

  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;
}

/**
  * @brief  Opens an endpoint of the low level driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @param  ep_type: Endpoint type
  * @param  ep_mps: Endpoint max packet size
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_OpenEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr, uint8_t ep_type, uint16_t ep_mps)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_EP_Open(pdev->pData, ep_addr, ep_mps, ep_type);

  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status;
}

/**
  * @brief  Closes an endpoint of the low level driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_CloseEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_Close(pdev->pData, ep_addr);
      
  usb_status =  USBD_Get_USB_Status(hal_status);

  return usb_status;  
}

/**
  * @brief  Flushes an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_FlushEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_Flush(pdev->pData, ep_addr);
      
  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;  
}

/**
  * @brief  Sets a Stall condition on an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_StallEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_SetStall(pdev->pData, ep_addr);

  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status;  
}

/**
  * @brief  Clears a Stall condition on an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_ClearStallEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_ClrStall(pdev->pData, ep_addr);  
     
  usb_status =  USBD_Get_USB_Status(hal_status);

  return usb_status; 
}

/**
  * @brief  Returns Stall condition.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  PCD_HandleTypeDef *hpcd = (PCD_HandleTypeDef*) pdev->pData;
  
  if((ep_addr & 0x80) == 0x80)
  {
    return hpcd->IN_ep[ep_addr & 0x7F].is_stall; 
  }
  else
  {
    return hpcd->OUT_ep[ep_addr & 0x7F].is_stall; 
  }
}

/**
  * @brief  Assigns a USB address to the device.
  * @param  pdev: Device handle
  * @param  dev_addr: Device address
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_SetUSBAddress(USBD_HandleTypeDef *pdev, uint8_t dev_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_SetAddress(pdev->pData, dev_addr);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status;  
}

/**
  * @brief  Transmits data over an endpoint.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @param  pbuf: Pointer to data to be sent
  * @param  size: Data size    
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Transmit(USBD_HandleTypeDef *pdev, uint8_t ep_addr, uint8_t *pbuf, uint16_t size)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_EP_Transmit(pdev->pData, ep_addr, pbuf, size);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;    
}

/**
  * @brief  Prepares an endpoint for reception.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @param  pbuf: Pointer to data to be received
  * @param  size: Data size
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, uint8_t ep_addr, uint8_t *pbuf, uint16_t size)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_EP_Receive(pdev->pData, ep_addr, pbuf, size);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
  	
  return usb_status; 
}

/**
  * @brief  Returns the last transfered packet size.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval Recived Data Size
  */
uint32_t USBD_LL_GetRxDataSize(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  return HAL_PCD_EP_GetRxCount((PCD_HandleTypeDef*) pdev->pData, ep_addr);
}

/**
  * @brief  Delays routine for the USB device library.
  * @param  Delay: Delay in ms
  * @retval None
  */
void USBD_LL_Delay(uint32_t Delay)
{
  HAL_Delay(Delay);
}

/**
  * @brief  Static single allocation.
  * @param  size: Size of allocated memory
  * @retval None
  */
void *USBD_static_malloc(uint32_t size)
{
[#if className == "AUDIO"]
  static uint8_t mem[sizeof(USBD_AUDIO_HandleTypeDef)];
[/#if]
[#if className == "DFU"]
  static uint32_t mem[(sizeof(USBD_DFU_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "HID"]
  static uint32_t mem[(sizeof(USBD_HID_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "MSC"]
  static uint32_t mem[(sizeof(USBD_MSC_BOT_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "CDC"]
  static uint32_t mem[(sizeof(USBD_CDC_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "CUSTOMHID"]
  static uint32_t mem[(sizeof(USBD_CUSTOM_HID_HandleTypeDef)/4+1)];/* On 32-bit boundary */
[/#if]
[#if className == "CCID"]
  static uint32_t mem[(sizeof(USBD_CCID_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "MTP"]
  static uint32_t mem[(sizeof(USBD_MTP_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
  return mem;
}

/**
  * @brief  Dummy memory free
  * @param  p: Pointer to allocated  memory address
  * @retval None
  */
void USBD_static_free(void *p)
{

}

/**
  * @brief Software device connection
  * @param hpcd: PCD handle
  * @param state: Connection state (0: disconnected / 1: connected)
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
void PCDEx_SetConnectionState(PCD_HandleTypeDef *hpcd, uint8_t state)
#else
void HAL_PCDEx_SetConnectionState(PCD_HandleTypeDef *hpcd, uint8_t state)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN 6 */
  if (state == 1)
  {
    /* Configure Low connection state. */

  }
  else
  {
    /* Configure High connection state. */

  }
  /* USER CODE END 6 */
}

/**
  * @brief  Retuns the USB status depending on the HAL status:
  * @param  hal_status: HAL status
  * @retval USB status
  */
USBD_StatusTypeDef USBD_Get_USB_Status(HAL_StatusTypeDef hal_status)
{
  USBD_StatusTypeDef usb_status = USBD_OK;

  switch (hal_status)
  {
    case HAL_OK :
      usb_status = USBD_OK;
    break;
    case HAL_ERROR :
      usb_status = USBD_FAIL;
    break;
    case HAL_BUSY :
      usb_status = USBD_BUSY;
    break;
    case HAL_TIMEOUT :
      usb_status = USBD_FAIL;
    break;
    default :
      usb_status = USBD_FAIL;
    break;
  }
  return usb_status;
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
