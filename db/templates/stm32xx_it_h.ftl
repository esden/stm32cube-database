[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_it.h
  * @brief   This file contains the headers of the interrupt handlers.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --] 
 ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${FamilyName}xx_IT_H
#define __${FamilyName}xx_IT_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#compress]

[#list nvic as vector]

void ${vector.irqHandler}(void);
[/#list]
[#if FamilyName=="STM32WBA"]
[#list services as service]
[#if service?? && service.swlowRadioInterruptExist]
[#assign swlowRadioInterrupt = service.swlowRadioInterrupt]
void ${swlowRadioInterrupt.irqHandler}(void);
[/#if]
[/#list]
[/#if]
[/#compress]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __${FamilyName}xx_IT_H */
