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


/** @defgroup USBD_AUDIO_Private_FunctionPrototypes
  * @{
  */

static int8_t  AUDIO_Init         (uint32_t  AudioFreq, uint32_t Volume, uint32_t options);
static int8_t  AUDIO_DeInit       (uint32_t options);
static int8_t  AUDIO_AudioCmd     (uint8_t* pbuf, uint32_t size, uint8_t cmd);
static int8_t  AUDIO_VolumeCtl    (uint8_t vol);
static int8_t  AUDIO_MuteCtl      (uint8_t cmd);
static int8_t  AUDIO_PeriodicTC   (uint8_t cmd);
static int8_t  AUDIO_GetState     (void);

USBD_AUDIO_ItfTypeDef USBD_AUDIO_fops = 
{
  AUDIO_Init,
  AUDIO_DeInit,
  AUDIO_AudioCmd,
  AUDIO_VolumeCtl,
  AUDIO_MuteCtl,
  AUDIO_PeriodicTC,
  AUDIO_GetState,
};

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  AUDIO_Init
  *         Initializes the AUDIO media low layer
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_Init(uint32_t  AudioFreq, uint32_t Volume, uint32_t options)
{
  /* USER CODE BEGIN 0 */
  /*
     Add your initialization code here 
  */  
  return (0);
  /* USER CODE END 0 */
}

/**
  * @brief  AUDIO_DeInit
  *         DeInitializes the AUDIO media low layer
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_DeInit(uint32_t options)
{
  /* USER CODE BEGIN 1 */ 
 /*
     Add your deinitialization code here 
  */  
  return (0);
  /* USER CODE END 1 */
}


/**
  * @brief  AUDIO_AudioCmd
  *         AUDIO command handler 
  * @param  Buf: Buffer of data to be sent
  * @param  size: Number of data to be sent (in bytes)
  * @param  cmd: command opcode
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_AudioCmd (uint8_t* pbuf, uint32_t size, uint8_t cmd)
{
  /* USER CODE BEGIN 2 */
  return (0);
  /* USER CODE END 2 */
}

/**
  * @brief  AUDIO_VolumeCtl              
  * @param  vol: volume level (0..100)
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_VolumeCtl (uint8_t vol)
{
  /* USER CODE BEGIN 3 */ 
  return (0);
  /* USER CODE END 3 */
}

/**
  * @brief  AUDIO_MuteCtl              
  * @param  cmd: vmute command
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_MuteCtl (uint8_t cmd)
{
  /* USER CODE BEGIN 4 */ 
  return (0);
  /* USER CODE END 4 */
}

/**
  * @brief  AUDIO_PeriodicTC              
  * @param  cmd
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_PeriodicTC (uint8_t cmd)
{
  /* USER CODE BEGIN 5 */ 
  return (0);
  /* USER CODE END 5 */
}

/**
  * @brief  AUDIO_GetState              
  * @param  None
  * @retval Result of the opeartion: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t AUDIO_GetState (void)
{
  /* USER CODE BEGIN 6 */ 
  return (0);
  /* USER CODE END 6 */
}
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

