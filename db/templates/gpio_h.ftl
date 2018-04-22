[#ftl]
/**
  ******************************************************************************
  * File Name          : gpio.h
  * Description        : This file contains all the functions prototypes for 
  *                      the gpio  
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __gpio_H
#define __gpio_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#list includes as include]
#include "${include}"
[/#list]
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
[#list datas as data]
[#if data.ipName=="gpio"]
void MX_GPIO_Init(void);
[#else]
void MX_${data.ipName}_GPIO_Init(void);
[/#if]
[/#list]
[#compress]
#n/* USER CODE BEGIN Prototypes */
#n     
/* USER CODE END Prototypes */
#n
[/#compress]
#ifdef __cplusplus
}
#endif
#endif /*__ pinoutConfig_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/