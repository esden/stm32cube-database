[#ftl]
/**
  ******************************************************************************
  * @file    flash_if.h
  * @author  MCD Application Team
  * @brief   This file provides interface to low level driver
  *****************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  *****************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __FLASH_H__
#define __FLASH_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * Writes a 64-bit word in flash at a specific address.
  * @param address (in bytes) must be a multiple of 8.
  * @param data data to write
  * @returns HW_OK, HW_BUSY or HW_FLASH_ERROR.
  */
extern int32_t HW_FLASH_Write(uint32_t address, uint64_t data);

/**
  * Erases 'n' flash pages from page number 'page' to page number
  * 'page + n - 1'.
  * - If 'interrupt' is set to 0, the erasing is performed in polling mode.
  * - If 'interrupt' is set to 1, the erasing is performed under FLASH
  *   interrupt: the function returns immediately and the user is informed of
  *   the end of erasing procedure by a call to the following function that
  *   must be implemented by the user: void HWCB_FLASH_EndOfCleanup( void );
  *   this call-back function is called under FLASH IRQ handler.
  * @param page memory start page number
  * @param n number of page
  * @param interrupt choice polling/interrupt
  * @returns HW_OK, HW_BUSY or HW_FLASH_ERROR.
  */
extern int32_t HW_FLASH_Erase(uint32_t page, uint16_t n, int32_t interrupt);

/**
  * Get from Option Bytes the IPCC buffer address
  * @returns HW_OK, HW_BUSY or HW_FLASH_ERROR.
  */
extern uint32_t HW_FLASH_OB_GetIPCCBufferAddr(void);

/**
  * Get from Option Bytes the SFSA secure flash address
  * @returns HW_OK, HW_BUSY or HW_FLASH_ERROR.
  */
extern uint32_t HW_FLASH_OB_GetSFSA(void);

/**
  * Callback
  */
extern void HWCB_FLASH_EndOfCleanup(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __FLASH_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
