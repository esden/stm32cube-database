[#ftl]
/* USER CODE BEGIN Header */
/*
 ******************************************************************************
  * File Name          : ${name}.h
  * Description        : Touch-Sensing user configuration.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __TSL_USER_H
#define __TSL_USER_H

#include "tsl.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

[#-- ************************************************************** --]
[#-- list of includes platform dependent --]
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]
[#-- ************************************************************** --]

/* Select if you use STMStudio software (0=No, 1=Yes) */
#define USE_STMSTUDIO (0)

#if USE_STMSTUDIO > 0
#include "stmCriticalSection.h"
#define STMSTUDIO_LOCK {enterLock();}
#define STMSTUDIO_UNLOCK {exitLock();}
#else
#define STMSTUDIO_LOCK
#define STMSTUDIO_UNLOCK
#endif

typedef enum
{
  TSL_USER_STATUS_BUSY       = 0, /**< The bank acquisition is on-going */
  TSL_USER_STATUS_OK_NO_ECS  = 1, /**< The bank acquisition is ok, no time for ECS */
  TSL_USER_STATUS_OK_ECS_ON  = 2, /**< The bank acquisition is ok, ECS finished */
  TSL_USER_STATUS_OK_ECS_OFF = 3  /**< The bank acquisition is ok, ECS not executed */
} tsl_user_status_t;

[#-- ************************************************************** --]
[#-- list of channels IOs --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as define]
            [#if define.name == "TSC_SHIELDIOs"]
                [#assign shield_io = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_CHANNELS"]
                [#assign nbchannels = define.value]
                [#assign k = -1]
                [#assign nbchannels_nb = nbchannels?number]
                [#assign nbchannels_nbr = nbchannels?number-1]

                [#lt]
/* Channel IOs definition */
                [#list 0..nbchannels_nbr as i]
                    [#list SWIPdatas as SWIP2]
                        [#if SWIP2.defines??]
                            [#assign j = 0]
                            [#list SWIP2.defines as define2]
                                [#assign GxIOyName = define2.name]
                                [#assign GxIOyValue = define2.value]
                                [#if GxIOyName?contains ("IO_")]
                                    [#if j > k]
                                        [#if GxIOyValue != "valueNotSetted"]
                                            [#lt]#define CHANNEL_${i}_IO_MSK    (${GxIOyValue?replace("G","TSC_GROUP")})
                                            [#lt]#define CHANNEL_${i}_GRP_MSK   (${(GxIOyValue?substring(0,GxIOyValue?last_index_of("_")))?replace("G","TSC_GROUP")})
                                            [#lt]#define CHANNEL_${i}_SRC       (${(GxIOyValue?substring(0,GxIOyValue?last_index_of("_")))?replace("G","TSC_GROUP")}_IDX) [#if i=0]/* Index in source register (TSC->IOGXCR[]) */[/#if]
                                            [#lt]#define CHANNEL_${i}_DEST      (${i}) [#if i=0]/* Index in destination result array */[/#if]
                                            [#assign k = j]
                                            [#break]
                                        [/#if]
                                    [/#if]
                                [/#if]
                                [#assign j = j+1]
                            [/#list]
                        [/#if]
                    [/#list]

                [/#list]

                [#lt]
            [/#if]
[#-- *************end of list of channels************************** --]
[#-- ************************************************************** --]
[#-- ***************list of shield IOs***************************** --]
            [#if define.name == "TSC_ACTIVE_SHIELDS"]
/* Shield IOs definition */
                [#assign nbshields = define.value]
                [#if nbshields != "0"]
                    [#lt]#define SHIELD_IO_MSK      (${shield_io})
                [#else]
                    [#lt]#define SHIELD_IO_MSK      (0)
                [/#if]
[#-- *************end of list of shield IOs************************ --]
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#-- ************************************************************** --]
/* Bank(s) definition */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as define]
            [#if define.name == "TSC_SHIELDIOs"]
                [#assign shield_io = define.value]
            [/#if]
            [#assign bankNb = 0]
            [#assign i = 0]
            [#assign j = 0]
            [#assign k = 0]
            [#if define.name == "TSLPRM_SENSORS_DATAS"]
                [#assign wordsArray = define.value?split(" ")]
                [#assign wordsArraySize = wordsArray?size -1]
                [#list 0..wordsArraySize as i]
                    [#assign wordsArrayItem = wordsArray[i]]
                    [#if wordsArrayItem?contains("TSLPRM")]
                        [#assign wordsArrayItemNext = wordsArray[i+1]]
                        [#assign wordsArrayItemNextNbr = wordsArrayItemNext?number - 1]
                        [#assign bankNb = wordsArrayItemNextNbr + 1 + bankNb]
                    [/#if]
                [/#list]
                [#assign bankNb = bankNb -1]
                [#assign counter = 0]
                [#assign bankNbInt = 0]
                [#list 0..wordsArraySize as i]
                    [#assign wordsArrayItem = wordsArray[i]]
                    [#if wordsArrayItem?contains("TSLPRM")]
                        [#if wordsArrayItem?contains("TOUCHKEY")]
                            [#lt]/* ${wordsArrayItem?replace("TSLPRM_TOTAL_","")} bank(s) definition*/
                        [#else]
                            [#lt]/* ${wordsArrayItem?replace("TSLPRM_USE_","")} bank definition*/
                        [/#if]
                    [#assign ChannelsIOMSK = ""]
                    [#assign ChannelsGRPMSK = ""]
                        [#-- get nbr of dedicated banks --]
                        [#assign wordsArrayItemNext = wordsArray[i+1]]
                        [#assign wordsArrayItemNextNbr = wordsArrayItemNext?number - 1]
                        [#-- for each dedicated banks, get number oof items --]
                        [#list 0..wordsArrayItemNextNbr as j]
                            [#assign ChannelsIOMSK = "#define BANK_${bankNbInt}_MSK_CHANNELS   ("]
                            [#assign ChannelsGRPMSK = "#define BANK_${bankNbInt}_MSK_GROUPS     ("]
                            [#assign nbrofbankitem = wordsArray[i+1+j+1]]
                            [#assign nbrofbankitemnbr = nbrofbankitem?number -1 + counter]
                            [#lt]#define BANK_${bankNbInt}_NBCHANNELS (${nbrofbankitem?number})
                            [#list counter..nbrofbankitemnbr as k]
                                [#assign ChannelsIOMSK = ChannelsIOMSK + "CHANNEL_${k}_IO_MSK"]
                                [#if k != nbrofbankitemnbr]
                                    [#assign ChannelsIOMSK = ChannelsIOMSK + " | "]
                                [/#if]
                                [#assign ChannelsGRPMSK = ChannelsGRPMSK + "CHANNEL_${k}_GRP_MSK"]
                                [#if k != nbrofbankitemnbr]
                                    [#assign ChannelsGRPMSK = ChannelsGRPMSK + " | "]
                                [/#if]
                            [/#list]
                            [#assign counter = nbrofbankitemnbr + 1]
                            [#assign bankNbInt = bankNbInt + 1]
                            [#if shield_io?contains("+TSC:ShieldIOs")]
                                [#assign ChannelsIOMSK = ChannelsIOMSK + ")"]
                            [#else]
                                [#assign ChannelsIOMSK = ChannelsIOMSK + " | SHIELD_IO_MSK)"]
                            [/#if]
                            [#assign ChannelsGRPMSK = ChannelsGRPMSK + ")"]
                            [#lt]${ChannelsIOMSK}
                            [#lt]${ChannelsGRPMSK}

                        [/#list]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#-- *************end of list of banks***************************** --]

/* User Parameters */
extern CONST TSL_Bank_T MyBanks[];
[#-- ************************************************************** --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as define]
[#-- if touchkey --]
            [#if define.name == "TSLPRM_TOTAL_TOUCHKEYS"]
                [#if define.value != "0"]
                    [#lt]extern CONST TSL_TouchKey_T MyTKeys[];
                [/#if]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_TOUCHKEYS_B"]
                [#if define.value != "0"]
                    [#lt]extern CONST TSL_TouchKeyB_T MyTKeysB[];
                [/#if]
            [/#if]
[#-- *************end of touchkey user parameter******************* --]
[#-- if lin/rot --]
            [#if define.name == "TSLPRM_TOTAL_LINROTS"]
                [#if define.value != "0"]
                    [#lt]extern CONST TSL_LinRot_T MyLinRots[];
                [/#if]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_LINROTS_B"]
                [#if define.value != "0"]
                    [#lt]extern CONST TSL_LinRotB_T MyLinRotsB[];
                [/#if]
            [/#if]
[#-- *************end of lin/rot user parameter******************** --]
        [/#list]
    [/#if]
[/#list]
[#-- ************************************************************** --]
extern CONST TSL_Object_T MyObjects[];
extern TSL_ObjectGroup_T MyObjGroup;

void tsl_user_Init(void);
tsl_user_status_t tsl_user_Exec(void);
tsl_user_status_t tsl_user_Exec_IT(void);
void tsl_user_SetThresholds(void);

#endif /* __TSL_USER_H */
