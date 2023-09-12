[#ftl]
/**
  ******************************************************************************
  * @file    features_info.h
  * @author  MCD Application Team
  * @brief   Feature list and parameters TypeDefinitions
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SYSTEM_INFO_H
#define __SYSTEM_INFO_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/

/**
  * @brief Feature enumeration
  * @note This is the list of all available feature so far,
          the one available in a fiven build are listed in the Feat_Info_Table[]
          to keep compatibility, in order to add a feature
          use a new value to the bottom without changing the existing order
  */
typedef enum
{
  FEAT_INFO_SYSTEM_ID = 0,
  FEAT_INFO_SYSTEM_CMD_PRIO_A_ID,    /* = 1 : position should not change between revisions */
  FEAT_INFO_SYSTEM_NOTIF_PRIO_A_ID, /* = 2 : position should not change between revisions */
  FEAT_INFO_SYSTEM_CMD_PRIO_B_ID,  /* = 3 : position should not change between revisions */
  FEAT_INFO_SYSTEM_NOTIF_PRIO_B_ID,  /* = 4 : position should not change between revisions */
  FEAT_INFO_KMS_ID,  /* = 5 : position should not change between revisions */
  FEAT_INFO_TRACE_ID,  /* = 6 : position should not change between revisions */
  FEAT_INFO_RADIO_ID,  /* = 7 : position should not change between revisions */
  FEAT_INFO_LORAWAN_ID,  /* = 8 : position should not change between revisions */
  FEAT_INFO_SIGFOX_ID,  /* = 9 : position should not change between revisions */
  FEAT_INFO_WMBUS_ID,  /* = 10 : position should not change between revisions */
  /* USER CODE BEGIN FEAT_INFO_IdTypeDef */

  /* USER CODE END FEAT_INFO_IdTypeDef */
  FEAT_INFO_CNT
} FEAT_INFO_IdTypeDef;

/**
  * @brief Feature parameters
  */
typedef struct
{
  FEAT_INFO_IdTypeDef Feat_Info_Feature_Id;
  uint32_t Feat_Info_Feature_Version;
  uint32_t Feat_Info_Config_Size;
  void *Feat_Info_Config_Ptr;
} FEAT_INFO_Param_t;

/**
  * @brief Feature List
  */
typedef struct
{
  uint32_t Feat_Info_Cnt;
  FEAT_INFO_Param_t *Feat_Info_TableAddress;
} FEAT_INFO_List_t;

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
#define MAX_PARAM_OF_SYS_CMD_FUNCTIONS           7 /*!< Max number of parameters that the sys_cmd can use */
#define MAX_PARAM_OF_SYS_NOTIF_FUNCTIONS         5 /*!< Max number of parameters that the sys_notif can use */
#define MAX_PARAM_OF_SYS_PRIOA_CMD_FUNCTIONS     1 /*!< Max number of parameters that the sysA_cmd can use */
#define MAX_PARAM_OF_SYS_PRIOA_NOTIF_FUNCTIONS   1 /*!< Max number of parameters that the sysA_notif can use */
#define MAX_PARAM_OF_SYS_PRIOB_CMD_FUNCTIONS     1 /*!< Max number of parameters that the sysB_cmd can use */
#define MAX_PARAM_OF_SYS_PRIOB_NOTIF_FUNCTIONS   1 /*!< Max number of parameters that the sysB_notif can use */

#define MAX_PARAM_OF_KMS_CMD_FUNCTIONS          12 /*!< Max number of parameters that the kms can use */
#define MAX_PARAM_OF_TRACE_NOTIF_FUNCTIONS      11 /*!< Max number of parameters that the trace can use */
#define MAX_PARAM_OF_RADIO_CMD_FUNCTIONS        15 /*!< Max number of parameters that the radio_cmd can use */
#define MAX_PARAM_OF_RADIO_NOTIF_FUNCTIONS       4 /*!< Max number of parameters that the radio_notif can use */
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE")|| (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
#define MAX_PARAM_OF_LORAWAN_CMD_FUNCTIONS      15 /*!< Max number of parameters that the lorawan_cmd can use */
#define MAX_PARAM_OF_LORAWAN_NOTIF_FUNCTIONS     5 /*!< Max number of parameters that the lorawan_notif can use */
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")|| (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")|| (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
#define MAX_PARAM_OF_SIGFOX_CMD_FUNCTIONS       15 /*!< Max number of parameters that the sigfox_cmd can use */
#define MAX_PARAM_OF_SIGFOX_NOTIF_FUNCTIONS      5 /*!< Max number of parameters that the sigfox_notif can use */
[/#if]

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
/**
  * @brief  Init configuration params by calling specific feature xxx_info.c
  * @return void
  */
void FEAT_INFO_Init(void);
/**
  * @brief  Get the feature list ptr
  * @return address of Feat_Info_List available in shared memory
  */
FEAT_INFO_List_t *FEAT_INFO_GetListPtr(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SYSTEM_INFO_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
