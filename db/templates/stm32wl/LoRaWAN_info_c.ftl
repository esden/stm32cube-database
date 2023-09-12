[#ftl]
/**
  ******************************************************************************
  * @file    lora_info.c
  * @author  MCD Application Team
  * @brief   To give info to the application about LoRaWAN configuration
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "LoRaMac.h"
#include "lora_info.h"
[#if CPUCORE == "CM0PLUS"]
#include "platform.h" /* Needed for Error_Handler */
#include "features_info.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/

/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if CPUCORE == ""]
static LoraInfo_t loraInfo = {0, 0};
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if CPUCORE == "CM0PLUS"]
/**
  * @brief initialises the LoraMacInfo capabilities table
  * @param none
  * @retval  none
  */
void StoreValueInFeatureListTable(void);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported variables --------------------------------------------------------*/
[#if CPUCORE == "CM0PLUS"]
UTIL_MEM_PLACE_IN_SECTION("MB_MEM2")  LoraInfo_t loraInfo;
[/#if]

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported functions --------------------------------------------------------*/
void LoraInfo_Init(void)
{
  loraInfo.ActivationMode = 0;
  loraInfo.Region = 0;
  loraInfo.ClassB = 0;
  loraInfo.Kms = 0;
  /* USER CODE BEGIN LoraInfo_Init_1 */

  /* USER CODE END LoraInfo_Init_1 */

#ifdef  REGION_AS923
  loraInfo.Region |= (1 << LORAMAC_REGION_AS923) ;
#endif /* REGION_AS923 */
#ifdef  REGION_AU915
  loraInfo.Region |= (1 << LORAMAC_REGION_AU915) ;
#endif /* REGION_AU915 */
#ifdef  REGION_CN470
  loraInfo.Region |= (1 << LORAMAC_REGION_CN470) ;
#endif /* REGION_CN470 */
#ifdef  REGION_CN779
  loraInfo.Region |= (1 << LORAMAC_REGION_CN779) ;
#endif /* REGION_CN779 */
#ifdef  REGION_EU433
  loraInfo.Region |= (1 << LORAMAC_REGION_EU433) ;
#endif /* REGION_EU433 */
#ifdef  REGION_EU868
  loraInfo.Region |= (1 << LORAMAC_REGION_EU868) ;
#endif /* REGION_EU868 */
#ifdef  REGION_KR920
  loraInfo.Region |= (1 << LORAMAC_REGION_KR920) ;
#endif /* REGION_KR920 */
#ifdef  REGION_IN865
  loraInfo.Region |= (1 << LORAMAC_REGION_IN865) ;
#endif /* REGION_IN865 */
#ifdef  REGION_US915
  loraInfo.Region |= (1 << LORAMAC_REGION_US915) ;
#endif /* REGION_US915 */
#ifdef  REGION_RU864
  loraInfo.Region |= (1 << LORAMAC_REGION_RU864) ;
#endif /* REGION_RU864 */

  if (loraInfo.Region == 0)
  {
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
    APP_PRINTF("error: At least one region shall be defined in the MW: check lorawan_conf.h \r\n");
[#else]
  /* USER CODE BEGIN LoraInfo_Init_NO_REGION */

  /* USER CODE END LoraInfo_Init_NO_REGION */
[/#if]
    while (1) {} /* At least one region shall be defined */
  }

#if ( LORAMAC_CLASSB_ENABLED == 1 )
  loraInfo.ClassB = 1;
#elif !defined (LORAMAC_CLASSB_ENABLED)
#error LORAMAC_CLASSB_ENABLED not defined ( shall be <0 or 1> )
#endif /* LORAMAC_CLASSB_ENABLED */

#if (!defined (LORAWAN_KMS) || (LORAWAN_KMS == 0))
  loraInfo.Kms = 0;
  loraInfo.ActivationMode = 3;
#else /* LORAWAN_KMS == 1 */
  loraInfo.Kms = 1;
  loraInfo.ActivationMode = ACTIVATION_BY_PERSONALISATION + (OVER_THE_AIR_ACTIVATION << 1);
#endif /* LORAWAN_KMS */
[#if CPUCORE == "CM0PLUS"]

  /* For DualCore */
  StoreValueInFeatureListTable();
[/#if]
  /* USER CODE BEGIN LoraInfo_Init_2 */

  /* USER CODE END LoraInfo_Init_2 */
}

LoraInfo_t *LoraInfo_GetPtr(void)
{
  /* USER CODE BEGIN LoraInfo_GetPtr */

  /* USER CODE END LoraInfo_GetPtr */
  return &loraInfo;
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private functions --------------------------------------------------------*/
[#if CPUCORE == "CM0PLUS"]
void StoreValueInFeatureListTable(void)
{
  FEAT_INFO_List_t *p_MBMUX_Cm0plusFeatureList = NULL;
  FEAT_INFO_Param_t  *p_feature;
  uint8_t i;
  uint8_t cm0plus_nr_of_supported_features;
  uint8_t found = 0;

  /* USER CODE BEGIN StoreValueInFeatureListTable_1 */

  /* USER CODE END StoreValueInFeatureListTable_1 */

  p_MBMUX_Cm0plusFeatureList = FEAT_INFO_GetListPtr();

  if (p_MBMUX_Cm0plusFeatureList != NULL)
  {
    cm0plus_nr_of_supported_features = p_MBMUX_Cm0plusFeatureList->Feat_Info_Cnt;

    for (i = 0; i < cm0plus_nr_of_supported_features;  i++)
    {
      p_feature = i + p_MBMUX_Cm0plusFeatureList->Feat_Info_TableAddress;
      if (p_feature->Feat_Info_Feature_Id == FEAT_INFO_LORAWAN_ID)
      {
        found = 1;
        break;
      }
    }
  }

  if (found)
  {
    p_feature->Feat_Info_Config_Size = sizeof(LoraInfo_t)/sizeof(uint32_t);
    p_feature->Feat_Info_Config_Ptr = &loraInfo;
  }
  else
  {
    Error_Handler();
  }

  /* USER CODE BEGIN StoreValueInFeatureListTable_2 */

  /* USER CODE END StoreValueInFeatureListTable_2 */
  return;
}
[/#if]

/* USER CODE BEGIN PF */

/* USER CODE END PF */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
