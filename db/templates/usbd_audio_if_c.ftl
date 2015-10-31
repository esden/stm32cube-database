[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_audio_if.c
  * @author         : MCD Application Team
  * @version        : V1.1.0
  * @date           : 19-March-2012
  * @brief          : Generic media access Layer.
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
#include "usbd_audio_if.h"

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */


/** @defgroup USBD_AUDIO 
  * @brief usbd core module
  * @{
  */ 

/** @defgroup USBD_AUDIO_Private_TypesDefinitions
  * @{
  */ 
/**
  * @}
  */ 


/** @defgroup USBD_AUDIO_Private_Defines
  * @{
  */ 
/**
  * @}
  */ 


/** @defgroup USBD_AUDIO_Private_Macros
  * @{
  */ 

/**
  * @}
  */ 

/* Private variables ---------------------------------------------------------*/
/* USB handler declaration */
/* Handle for USB Full Speed IP */
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
USBD_HandleTypeDef  *hUsbDevice_0;
[/#if]

[#if handleNameHS == "HS"]
/* Handle for USB High Speed IP */
USBD_HandleTypeDef  *hUsbDevice_1;
[/#if]
  
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
extern USBD_HandleTypeDef hUsbDeviceFS;
[/#if]
[#if handleNameHS == "HS"]
extern USBD_HandleTypeDef hUsbDeviceHS;  
[/#if]

/** @defgroup USBD_AUDIO_Private_FunctionPrototypes
  * @{
  */
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
static int8_t  AUDIO_Init_FS         (uint32_t  AudioFreq, uint32_t Volume, uint32_t options);
static int8_t  AUDIO_DeInit_FS       (uint32_t options);
static int8_t  AUDIO_AudioCmd_FS     (uint8_t* pbuf, uint32_t size, uint8_t cmd);
static int8_t  AUDIO_VolumeCtl_FS    (uint8_t vol);
static int8_t  AUDIO_MuteCtl_FS      (uint8_t cmd);
static int8_t  AUDIO_PeriodicTC_FS   (uint8_t cmd);
static int8_t  AUDIO_GetState_FS     (void);
[/#if]

[#if handleNameHS == "HS"]
static int8_t  AUDIO_Init_HS         (uint32_t  AudioFreq, uint32_t Volume, uint32_t options);
static int8_t  AUDIO_DeInit_HS       (uint32_t options);
static int8_t  AUDIO_AudioCmd_HS     (uint8_t* pbuf, uint32_t size, uint8_t cmd);
static int8_t  AUDIO_VolumeCtl_HS    (uint8_t vol);
static int8_t  AUDIO_MuteCtl_HS      (uint8_t cmd);
static int8_t  AUDIO_PeriodicTC_HS   (uint8_t cmd);
static int8_t  AUDIO_GetState_HS     (void);
[/#if]

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
USBD_AUDIO_ItfTypeDef USBD_AUDIO_fops_FS = 
{
  AUDIO_Init_FS,
  AUDIO_DeInit_FS,
  AUDIO_AudioCmd_FS,
  AUDIO_VolumeCtl_FS,
  AUDIO_MuteCtl_FS,
  AUDIO_PeriodicTC_FS,
  AUDIO_GetState_FS,
};
[/#if]

[#if handleNameHS == "HS"]
USBD_AUDIO_ItfTypeDef USBD_AUDIO_fops_HS = 
{
  AUDIO_Init_HS,
  AUDIO_DeInit_HS,
  AUDIO_AudioCmd_HS,
  AUDIO_VolumeCtl_HS,
  AUDIO_MuteCtl_HS,
  AUDIO_PeriodicTC_HS,
  AUDIO_GetState_HS,
};
[/#if]

/* Private functions ---------------------------------------------------------*/
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/**
  * @brief  AUDIO_Init_FS
  *         Initializes the AUDIO media low layer over USB FS IP
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_Init_FS(uint32_t  AudioFreq, uint32_t Volume, uint32_t options)
{
  hUsbDevice_0 = &hUsbDeviceFS;
  /* USER CODE BEGIN 0 */
  return (USBD_OK);
  /* USER CODE END 0 */
}

/**
  * @brief  AUDIO_DeInit_FS
  *         DeInitializes the AUDIO media low layer
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_DeInit_FS(uint32_t options)
{
  /* USER CODE BEGIN 1 */ 
  return (USBD_OK);
  /* USER CODE END 1 */
}


/**
  * @brief  AUDIO_AudioCmd_FS
  *         AUDIO command handler 
  * @param  Buf: Buffer of data to be sent
  * @param  size: Number of data to be sent (in bytes)
  * @param  cmd: command opcode
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_AudioCmd_FS (uint8_t* pbuf, uint32_t size, uint8_t cmd)
{
  /* USER CODE BEGIN 2 */
  switch(cmd)
  {
    case AUDIO_CMD_START:    
    break;
  
    case AUDIO_CMD_PLAY:   
    break;	
  }
  return (USBD_OK);
  /* USER CODE END 2 */
  
}

/**
  * @brief  AUDIO_VolumeCtl_FS              
  * @param  vol: volume level (0..100)
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_VolumeCtl_FS (uint8_t vol)
{
  /* USER CODE BEGIN 3 */ 
  return (USBD_OK);
  /* USER CODE END 3 */
}

/**
  * @brief  AUDIO_MuteCtl_FS              
  * @param  cmd: vmute command
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_MuteCtl_FS (uint8_t cmd)
{
  /* USER CODE BEGIN 4 */ 
  return (USBD_OK);
  /* USER CODE END 4 */
}

/**
  * @brief  AUDIO_PeriodicT_FS              
  * @param  cmd
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_PeriodicTC_FS (uint8_t cmd)
{
  /* USER CODE BEGIN 5 */ 
  return (USBD_OK);
  /* USER CODE END 5 */
}

/**
  * @brief  AUDIO_GetState_FS       
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_GetState_FS (void)
{
  /* USER CODE BEGIN 6 */ 
  return (USBD_OK);
  /* USER CODE END 6 */
}

/**
  * @brief  Manages the DMA full Transfer complete event.
  * @param  None
  * @retval None
  */
void TransferComplete_CallBack_FS(void)
{
  /* USER CODE BEGIN 7 */ 
  USBD_AUDIO_Sync(hUsbDevice_0, AUDIO_OFFSET_FULL);
  /* USER CODE END 7 */
}

/**
  * @brief  Manages the DMA Half Transfer complete event.
  * @param  None
  * @retval None
  */
void HalfTransfer_CallBack_FS(void)
{ 
  /* USER CODE BEGIN 8 */ 
  USBD_AUDIO_Sync(hUsbDevice_0, AUDIO_OFFSET_HALF);
  /* USER CODE END 8 */
}
[/#if]
[#if handleNameHS == "HS"]
/**
  * @brief  AUDIO_Init_HS
  *         Initializes the AUDIO media low layer over ths USB HS IP
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_Init_HS(uint32_t  AudioFreq, uint32_t Volume, uint32_t options)
{
  hUsbDevice_1 = &hUsbDeviceHS;
  /* USER CODE BEGIN 9 */ 
  return (USBD_OK);
  /* USER CODE END 9 */
}

/**
  * @brief  AUDIO_DeInit_HS
  *         DeInitializes the AUDIO media low layer
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_DeInit_HS(uint32_t options)
{
  /* USER CODE BEGIN 10 */ 
  return (USBD_OK);
  /* USER CODE END 10 */
}

/**
  * @brief  AUDIO_AudioCmd_HS
  *         AUDIO command handler 
  * @param  Buf: Buffer of data to be sent
  * @param  size: Number of data to be sent (in bytes)
  * @param  cmd: command opcode
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_AudioCmd_HS (uint8_t* pbuf, uint32_t size, uint8_t cmd)
{
  /* USER CODE BEGIN 11 */
  switch(cmd)
  {
    case AUDIO_CMD_START:    
    break;
  
    case AUDIO_CMD_PLAY:   
    break;	
  }
  return (USBD_OK);
  /* USER CODE END 11 */
  
}

/**
  * @brief  AUDIO_VolumeCtl_HS              
  * @param  vol: volume level (0..100)
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_VolumeCtl_HS (uint8_t vol)
{
  /* USER CODE BEGIN 12 */ 
  return (USBD_OK);
  /* USER CODE END 12 */
}

/**
  * @brief  AUDIO_MuteCtl_HS              
  * @param  cmd: vmute command
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_MuteCtl_HS (uint8_t cmd)
{
  /* USER CODE BEGIN 13 */ 
  return (USBD_OK);
  /* USER CODE END 13 */
}

/**
  * @brief  AUDIO_PeriodicTC_HS              
  * @param  cmd
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_PeriodicTC_HS (uint8_t cmd)
{
  /* USER CODE BEGIN 14 */ 
  return (USBD_OK);
  /* USER CODE END 14 */
}

/**
  * @brief  AUDIO_GetState_HS              
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_GetState_HS (void)
{
  /* USER CODE BEGIN 15 */ 
  return (USBD_OK);
  /* USER CODE END 15 */
}

/**
  * @brief  Manages the DMA full Transfer complete event.
  * @param  None
  * @retval None
  */
void TransferComplete_CallBack_HS(void)
{
  /* USER CODE BEGIN 16 */ 
  USBD_AUDIO_Sync(hUsbDevice_1, AUDIO_OFFSET_FULL);
  /* USER CODE END 16 */
}

/**
  * @brief  Manages the DMA Half Transfer complete event.
  * @param  None
  * @retval None
  */
void HalfTransfer_CallBack_HS(void)
{ 
  /* USER CODE BEGIN 17 */ 
  USBD_AUDIO_Sync(hUsbDevice_1, AUDIO_OFFSET_HALF);
  /* USER CODE END 17 */
}
[/#if]
/**
  * @}
  */ 

/**
  * @}
  */ 

/**
  * @}
  */ 

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

