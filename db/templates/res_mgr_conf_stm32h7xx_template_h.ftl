[#ftl]
/**
  ******************************************************************************
  * @file    res_mgr_conf_stm32h7xx_template.h
  * @author  MCD Application Team
  * @brief   Resources Manager configuration template file.
  *          This file should be copied to the application folder and modified
  *          as follows:
  *            - Rename it to 'res_mgr_conf.h'.
  *            - Update it according your needs.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT(c) 2018 STMicroelectronics</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
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

[#-- 'UserCode sections' are indexed dynamically --]
[#assign userCodeIdx = 0]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef  RES_MGR_CONF_H__
#define  RES_MGR_CONF_H__

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stddef.h>
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
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name?? && definition.name?contains("RESMGR_REQUEST_") && definition.value??]
                [#assign valueResMgrRequest = definition.value.split(" ")[0]]
                [#if valueResMgrRequest?? && valueResMgrRequest!=""]
                    [#lt]#tRESMGR_ID_${valueResMgrRequest},
                [/#if]
            [/#if]
        [/#list]
    [/#if]
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

#ifdef RESMGR_USE_DEFAULT_TBL
static const uint8_t Default_ResTbl[RESMGR_ENTRY_NBR] = {
/* 0:Not assigned | 1:Assigned to core1 | 2:Assigned to core2 */
/* core1 -> CPU1, Cortex-M7 for STM32H7 */
/* core2 -> CPU2, Cortex-M4 for STM32H7 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name?? && definition.name?contains("RESMGR_REQUEST_") && definition.value?? && definition.value!=""]
                [#assign valueList = definition.value.split(" ")]
                [#assign valueResMgrRequest = valueList[0]]
                [#if valueResMgrRequest?? && valueResMgrRequest!=""]
                    [#assign valueCore = ""]
                    [#if valueList?size == 1]
                        [#t]#t0[#t]
                    [#else]
                        [#assign valueCore = valueList[1]]
                        [#if valueCore?contains("Cortex-M7")]
                            [#t]#t1[#t]
                        [#elseif valueCore?contains("Cortex-M4")]
                            [#t]#t2[#t]
                        [#else]
                            [#t]#t0[#t]
                        [/#if]
                    [/#if]
                    [#t],  /* RESMGR_ID_${valueResMgrRequest} */
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]
  0 , /* RESMGR_ID_RESMGR_TABLE               */
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

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
