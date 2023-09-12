[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    res_mgr_conf.h
  * @author  MCD Application Team
  * @brief   Resources Manager configuration template file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- 'UserCode sections' are indexed dynamically --]
[#assign userCodeIdx = 0]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef  RES_MGR_CONF_H__
#define  RES_MGR_CONF_H__

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stddef.h>
#include "stm32h7xx_hal.h"
/** @addtogroup Utilities
  * @{
  */

/** @addtogroup Common
  * @{
  */

/** @addtogroup RES_MGR_TABLE
  * @{
  */

/** @defgroup RES_MGR_TABLE
  * @brief
  * @{
  */


/** @defgroup RES_MGR_Exported_Defines
  * @{
  */

/* This Part may be filled/customized by CubeMX/User */
/******** Shared Resource IDs *************************************************/
enum
{
[#list IPdatas as IP]
    [#list IP.configModelList as configModel]
        [#list configModel.refConfigFiles as refConfigFile]
            [#if refConfigFile.name?contains("Configuration")]
                [#list refConfigFile.arguments as argument]
                    [#if argument.name?? && (argument.name?contains("RESMGR_REQUEST_") || argument.name?contains("RESMGR_RESOURCE_REQUEST_")) && argument.value??]
                        [#assign valueResMgrRequest = argument.value.split(" ")[0]]
                        [#if valueResMgrRequest?? && valueResMgrRequest!=""]
                            [#lt]#tRESMGR_ID_${valueResMgrRequest},
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#list]
[/#list]
  /* USER CODE BEGIN ${userCodeIdx} */
  /* USER CODE END ${userCodeIdx} */
  [#assign userCodeIdx = userCodeIdx+1]
  RESMGR_ID_RESMGR_TABLE,
};

#define RESMGR_ENTRY_NBR    ((uint32_t)RESMGR_ID_RESMGR_TABLE + 1UL)
#define RESMGR_ID_ALL                      0x0000FFFFU
#define RESMGR_ID_NONE                     0xFFFFFFFFU

/**
  * @}
  */


/** @defgroup RES_MGR_Default_ResTable
  * @{
  */

#define RESMGR_USE_DEFAULT_TBL

#define RES_DEFAULT_ASSIGN_NONE   0
#define RES_DEFAULT_ASSIGN_CPU1   1
#define RES_DEFAULT_ASSIGN_CPU2   2

#ifdef RESMGR_USE_DEFAULT_TBL
static const uint8_t Default_ResTbl[RESMGR_ENTRY_NBR] = {
/* RES_DEFAULT_ASSIGN_NONE:Not assigned | RES_DEFAULT_ASSIGN_CPU1:Assigned to core1 | RES_DEFAULT_ASSIGN_CPU2:Assigned to core2 */
/* core1 -> CPU1, CortexM7 for STM32H7 */
/* core2 -> CPU2, CortexM4 for STM32H7 */
[#list IPdatas as IP]
    [#list IP.configModelList as configModel]
        [#list configModel.refConfigFiles as refConfigFile]
            [#if refConfigFile.name?contains("Configuration")]
                [#list refConfigFile.arguments as argument]
                    [#if argument.name?? && (argument.name?contains("RESMGR_REQUEST_") || argument.name?contains("RESMGR_RESOURCE_REQUEST_")) && argument.value?? && argument.value!=""]
                        [#assign valueList = argument.value.split(" ")]
                        [#assign valueResMgrRequest = valueList[0]]
                        [#if valueResMgrRequest?? && valueResMgrRequest!=""]
                            [#assign valueCore = ""]
                            [#if valueList?size == 1]
                                [#t]#tRES_DEFAULT_ASSIGN_NONE[#t]
                            [#else]
                                [#assign valueCore = valueList[1]]
                                [#if valueCore?contains("CortexM7")]
                                    [#t]#tRES_DEFAULT_ASSIGN_CPU1[#t]
                                [#elseif valueCore?contains("CortexM4")]
                                    [#t]#tRES_DEFAULT_ASSIGN_CPU2[#t]
                                [#else]
                                    [#t]#tRES_DEFAULT_ASSIGN_NONE[#t]
                                [/#if]
                            [/#if]
                            [#t],  /* RESMGR_ID_${valueResMgrRequest} */
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#list]
[/#list]
/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]
  RES_DEFAULT_ASSIGN_NONE /* RESMGR_ID_RESMGR_TABLE               */
};
#endif
/**
  * @}
  */

/* End of CubeMX/User Part*/

/** @defgroup RES_MGR_Lock_Procedure
  * @{
  */

/* Customized Lock Procedure definition  begin */

/* USER CODE BEGIN ${userCodeIdx} */

#define HSEM_ID_RES_TABLE                      31U

#define RESMGR_TBL_LOCK(lock_id)                          \
{                                                         \
  while (HAL_HSEM_FastTake(HSEM_ID_RES_TABLE) != HAL_OK)  \
  {                                                       \
  }                                                       \
}                                                         \

#define RESMGR_TBL_UNLOCK(lock_id)                        \
{                                                         \
  HAL_HSEM_Release(HSEM_ID_RES_TABLE,0);                  \
}                                                         \


/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

/* Customized Lock Procedure definition  end */

/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

/**
  * @}
  */

/** @defgroup RES_MGR_RPMSG extension
  * @{
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */
#endif /* RES_MGR_CONF_H__ */

