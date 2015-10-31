[#ftl]
/**
  ******************************************************************************
  * @file           : ${name} 
  * @version        : ${version}
  * @brief          : This file implements the board support package for the USB device library
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  * 1. Redistributions of source code must retain the above copyright notice,
  * this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  * this list of conditions and the following disclaimer in the documentation
  * and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of its contributors
  * may be used to endorse or promote products derived from this software
  * without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
*/
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
		[#if variable.value?contains("MSC")][#assign className = "MSC"][/#if]
		[#if variable.value?contains("DFU")][#assign className = "DFU"][/#if]
		[#if variable.value?contains("HID")][#assign className = "HID"][/#if]
		[#if variable.value?contains("AUDIO")][#assign className = "AUDIO"][/#if]
		[#if variable.value?contains("CCID")][#assign className = "CCID"][/#if]
		[#if variable.value?contains("MTP")][#assign className = "MTP"][/#if]
		[#if variable.value?contains("CDC")][#assign className = "CDC"][/#if]
		[#if variable.value?contains("CUSTOMHID")][#assign className = "CUSTOMHID"][/#if]
		
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
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
[#if handleNameFS == "FS"]
[#include "Src/usb_otg_fs_vars.tmp"]
[/#if]
[#if handleNameUSB_FS = "FS"]
[#include "Src/usb_vars.tmp"]
[/#if]
[#if handleNameHS == "HS"]
[#include "Src/usb_otg_hs_vars.tmp"]
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
void HAL_PCDEx_SetConnectionState(PCD_HandleTypeDef *hpcd, uint8_t state);

/*******************************************************************************
                       LL Driver Callbacks (PCD -> USB Device Library)
*******************************************************************************/
/* MSP Init */
[#if handleNameFS == "FS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include "Src/usb_otg_fs_Msp.tmp"]
[/#if]
[/#if]
[#if handleNameHS == "HS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include "Src/usb_otg_hs_Msp.tmp"]
[/#if]
[/#if]
[#if handleNameUSB_FS == "FS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include "Src/usb_Msp.tmp"]
[/#if]
[/#if]

/**
  * @brief  Setup stage callback
  * @param  hpcd: PCD handle
  * @retval None
  */
void HAL_PCD_SetupStageCallback(PCD_HandleTypeDef *hpcd)
{
  USBD_LL_SetupStage(hpcd->pData, (uint8_t *)hpcd->Setup);
}

/**
  * @brief  Data Out stage callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint Number
  * @retval None
  */
void HAL_PCD_DataOutStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
{
  USBD_LL_DataOutStage(hpcd->pData, epnum, hpcd->OUT_ep[epnum].xfer_buff);
}

/**
  * @brief  Data In stage callback..
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint Number
  * @retval None
  */
void HAL_PCD_DataInStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
{
  USBD_LL_DataInStage(hpcd->pData, epnum, hpcd->IN_ep[epnum].xfer_buff);
}

/**
  * @brief  SOF callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
void HAL_PCD_SOFCallback(PCD_HandleTypeDef *hpcd)
{
  USBD_LL_SOF(hpcd->pData);
}

/**
  * @brief  Reset callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
void HAL_PCD_ResetCallback(PCD_HandleTypeDef *hpcd)
{ 
  USBD_SpeedTypeDef speed = USBD_SPEED_FULL;

  /*Set USB Current Speed*/
  switch (hpcd->Init.speed)
  {
  [#if handleNameFS == "FS" || handleNameHS == "HS"]
  case PCD_SPEED_HIGH:
    speed = USBD_SPEED_HIGH;
    break;
  [/#if]  
  case PCD_SPEED_FULL:
    speed = USBD_SPEED_FULL;    
    break;
	
  default:
    speed = USBD_SPEED_FULL;    
    break;    
  }
  USBD_LL_SetSpeed(hpcd->pData, speed);  
  
  /*Reset Device*/
  USBD_LL_Reset(hpcd->pData);
}

/**
  * @brief  Suspend callback.
  * When Low power mode is enabled the debug cannot be used (IAR, Keil doesn't support it)
  * @param  hpcd: PCD handle
  * @retval None
  */
void HAL_PCD_SuspendCallback(PCD_HandleTypeDef *hpcd)
{
  USBD_LL_Suspend(hpcd->pData);
  /*Enter in STOP mode */
  /* USER CODE BEGIN 2 */
  if (hpcd->Init.low_power_enable)
  {
    /* Set SLEEPDEEP bit and SleepOnExit of Cortex System Control Register */
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
void HAL_PCD_ResumeCallback(PCD_HandleTypeDef *hpcd)
{
  /* USER CODE BEGIN 3 */

  /* USER CODE END 3 */
  USBD_LL_Resume(hpcd->pData);
  
}

/**
  * @brief  ISOC Out Incomplete callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint Number
  * @retval None
  */
void HAL_PCD_ISOOUTIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
{
  USBD_LL_IsoOUTIncomplete(hpcd->pData, epnum);
}

/**
  * @brief  ISOC In Incomplete callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint Number
  * @retval None
  */
void HAL_PCD_ISOINIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
{
  USBD_LL_IsoINIncomplete(hpcd->pData, epnum);
}

/**
  * @brief  Connect callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
void HAL_PCD_ConnectCallback(PCD_HandleTypeDef *hpcd)
{
  USBD_LL_DevConnected(hpcd->pData);
}

/**
  * @brief  Disconnect callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
void HAL_PCD_DisconnectCallback(PCD_HandleTypeDef *hpcd)
{
  USBD_LL_DevDisconnected(hpcd->pData);
}

/*******************************************************************************
                       LL Driver Interface (USB Device Library --> PCD)
*******************************************************************************/
/**
  * @brief  Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
#t/* Init USB_IP */
[#if handleNameFS == "FS"]
#tif (pdev->id == DEVICE_FS) {
#t/* Link The driver to the stack */	
#thpcd_USB_OTG_FS.pData = pdev;
#tpdev->pData = &hpcd_USB_OTG_FS;
#t[#include "Src/usb_otg_fs_HalInit.tmp"] 
#tHAL_PCD_SetRxFiFo(&hpcd_USB_OTG_FS, 0x80);
#tHAL_PCD_SetTxFiFo(&hpcd_USB_OTG_FS, 0, 0x40);
#tHAL_PCD_SetTxFiFo(&hpcd_USB_OTG_FS, 1, 0x80);
#t}
[/#if]
[#if handleNameHS == "HS"]
#tif (pdev->id == DEVICE_HS) {
#t/* Link The driver to the stack */
#thpcd_USB_OTG_HS.pData = pdev;
#tpdev->pData = &hpcd_USB_OTG_HS;
[#include "Src/usb_otg_hs_HalInit.tmp"]
#tHAL_PCD_SetRxFiFo(&hpcd_USB_OTG_HS, 0x200);
#tHAL_PCD_SetTxFiFo(&hpcd_USB_OTG_HS, 0, 0x80);
#tHAL_PCD_SetTxFiFo(&hpcd_USB_OTG_HS, 1, 0x174);
#t}
[/#if]
[#if handleNameUSB_FS == "FS"]
#t/* Link The driver to the stack */
#thpcd_USB_FS.pData = pdev;
#tpdev->pData = &hpcd_USB_FS;
[#include "Src/usb_HalInit.tmp"]
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x00 , PCD_SNG_BUF, 0x18);
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x80 , PCD_SNG_BUF, 0x58);
[#if className == "MSC"]
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x81 , PCD_SNG_BUF, 0x98);  
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x01 , PCD_SNG_BUF, 0xD8);  
[/#if]
[#if className == "HID"]
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x81 , PCD_SNG_BUF, 0x100);  
[/#if]
[#if className == "CDC"]
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x81 , PCD_SNG_BUF, 0xC0);  
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x01 , PCD_SNG_BUF, 0x110);
#tHAL_PCDEx_PMAConfig(pdev->pData , 0x82 , PCD_SNG_BUF, 0x100);  
[/#if]
[#if className == "CUSTOMHID"]
#tHAL_PCDEx_PMAConfig(pdev->pData , CUSTOM_HID_EPIN_ADDR , PCD_SNG_BUF, 0x98);  
#tHAL_PCDEx_PMAConfig(pdev->pData , CUSTOM_HID_EPOUT_ADDR , PCD_SNG_BUF, 0xD8);  
[/#if]
[/#if]
#treturn USBD_OK;
}

/**
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
  HAL_PCD_DeInit(pdev->pData);
  return USBD_OK; 
}

/**
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
  HAL_PCD_Start(pdev->pData);
  return USBD_OK; 
}

/**
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
  HAL_PCD_Stop(pdev->pData);
  return USBD_OK; 
}

/**
  * @brief  Opens an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @param  ep_type: Endpoint Type
  * @param  ep_mps: Endpoint Max Packet Size
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{

  HAL_PCD_EP_Open(pdev->pData, 
                  ep_addr, 
                  ep_mps, 
                  ep_type);
  
  return USBD_OK; 
}

/**
  * @brief  Closes an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  
  HAL_PCD_EP_Close(pdev->pData, ep_addr);
  return USBD_OK; 
}

/**
  * @brief  Flushes an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_FlushEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  
  HAL_PCD_EP_Flush(pdev->pData, ep_addr);
  return USBD_OK; 
}

/**
  * @brief  Sets a Stall condition on an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  
  HAL_PCD_EP_SetStall(pdev->pData, ep_addr);
  return USBD_OK; 
}

/**
  * @brief  Clears a Stall condition on an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  
  HAL_PCD_EP_ClrStall(pdev->pData, ep_addr);  
  return USBD_OK; 
}

/**
  * @brief  Returns Stall condition.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  PCD_HandleTypeDef *hpcd = pdev->pData; 
  
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
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
  
  HAL_PCD_SetAddress(pdev->pData, dev_addr);
  return USBD_OK; 
}

/**
  * @brief  Transmits data over an endpoint.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @param  pbuf: Pointer to data to be sent
  * @param  size: Data size    
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{

  HAL_PCD_EP_Transmit(pdev->pData, ep_addr, pbuf, size);
  return USBD_OK;   
}

/**
  * @brief  Prepares an endpoint for reception.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @param  pbuf: Pointer to data to be received
  * @param  size: Data size
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,                                      
                                           uint8_t  *pbuf,
                                           uint16_t  size)
{

  HAL_PCD_EP_Receive(pdev->pData, ep_addr, pbuf, size);
  return USBD_OK;   
}

/**
  * @brief  Returns the last transfered packet size.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval Recived Data Size
  */
uint32_t USBD_LL_GetRxDataSize  (USBD_HandleTypeDef *pdev, uint8_t  ep_addr)  
{
  return HAL_PCD_EP_GetRxCount(pdev->pData, ep_addr);
}

/**
  * @brief  Delays routine for the USB Device Library.
  * @param  Delay: Delay in ms
  * @retval None
  */
void  USBD_LL_Delay (uint32_t Delay)
{
  HAL_Delay(Delay);  
}

/**
  * @brief  static single allocation.
  * @param  size: size of allocated memory
  * @retval None
  */
void *USBD_static_malloc(uint32_t size)
{
[#if className == "AUDIO"]
  //static uint8_t mem[sizeof(USBD_AUDIO_HandleTypeDef)];
  /* USER CODE BEGIN 4 */ 
  /**
  * To compute the request size you must use the formula:
    AUDIO_OUT_PACKET = (USBD_AUDIO_FREQ * 2 * 2) /1000)
    AUDIO_TOTAL_BUF_SIZE = AUDIO_OUT_PACKET * AUDIO_OUT_PACKET_NUM with 
	Number of sub-packets in the audio transfer buffer. You can modify this value but always make sure
    that it is an even number and higher than 3 
	AUDIO_OUT_PACKET_NUM = 80
  */  
  static uint8_t mem[512];
  /* USER CODE END 4 */
[/#if]  
[#if className == "DFU"]
  //static uint32_t mem[sizeof(USBD_DFU_HandleTypeDef)];
  static uint8_t mem[512];
[/#if]  
[#if className == "HID"]
  static uint32_t mem[sizeof(USBD_HID_HandleTypeDef)];
[/#if]  
[#if className == "MSC"]
  //static uint32_t mem[sizeof(USBD_MSC_BOT_HandleTypeDef)];
  static uint8_t mem[512];
[/#if]  
[#if className == "CDC"]
  //static uint32_t mem[sizeof(USBD_CDC_HandleTypeDef)];
  static uint8_t mem[512];
[/#if]  
[#if className == "CUSTOMHID"]
  static uint32_t mem[sizeof(USBD_CUSTOM_HID_HandleTypeDef)];
[/#if]   
[#if className == "CCID"]
  static uint32_t mem[sizeof(USBD_CCID_HandleTypeDef)];
[/#if]  
[#if className == "MTP"]
  static uint32_t mem[sizeof(USBD_MTP_HandleTypeDef)];
[/#if]
  return mem;
}

/**
  * @brief  Dummy memory free
  * @param  *p pointer to allocated  memory address
  * @retval None
  */
void USBD_static_free(void *p)
{

}

/**
* @brief Software Device Connection
* @param hpcd: PCD handle
* @param state: connection state (0 : disconnected / 1: connected) 
* @retval None
*/
void HAL_PCDEx_SetConnectionState(PCD_HandleTypeDef *hpcd, uint8_t state)
{
/* USER CODE BEGIN 5 */
  if (state == 1)
  {
    /* Configure Low Connection State */
	__HAL_SYSCFG_USBPULLUP_ENABLE();
  }
  else
  {
    /* Configure High Connection State */
    __HAL_SYSCFG_USBPULLUP_DISABLE();
  } 
/* USER CODE END 5 */
}


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
