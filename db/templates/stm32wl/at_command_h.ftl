[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#--
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
--]
[#assign SUBGHZ_APPLICATION = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  * @file    lora_command.h
[/#if]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
  * @file    subg_command.h
[/#if]
  * @author  MCD Application Team
  * @brief   Header for driver command.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#ifndef __LORA_COMMAND_H__
#define __LORA_COMMAND_H__
[/#if]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#ifndef __SUBG_COMMAND_H__
#define __SUBG_COMMAND_H__
[/#if]

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
/* Character added when a RX error has been detected */
#define AT_ERROR_RX_CHAR 0x01

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
  * @brief Initializes command module
  * @param CmdProcessNotify cb to signal application that character has been received
  */
void CMD_Init(void (*CmdProcessNotify)(void));

/**
  * @brief Process the command
  */
void CMD_Process(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#endif /* __LORA_COMMAND_H__*/
[/#if]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#endif /* __SUBG_COMMAND_H__ */
[/#if]
