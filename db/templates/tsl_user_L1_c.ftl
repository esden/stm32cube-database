[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name}.c
  * Description        : User configuration file for TOUCHSENSING
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#--
[#list SWIPdatas as SWIP]  
    [#if SWIP.defines??]
        [#list SWIP.defines as define]
            define.name : ${define.name}
            define.value : ${define.value}
            [/#list]
    [/#if]
[/#list]
--]
[#assign channelnbr = 0]
[#list SWIPdatas as SWIP]  
    [#if SWIP.defines??]
        [#list SWIP.defines as define]
            [#assign bankNb = 0]
            [#assign i = 0]
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
            [/#if]
            [#if define.name == "TSC_SHIELDIOs"]
                [#assign tsc_shield_ios = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_OBJECTS"]
                [#assign total_objects = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_TOUCHKEYS"]
                [#assign total_touchkeys = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_TOUCHKEYS_B"]
                [#assign total_touchkeys_b = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_ALL_TOUCHKEYS"]
                [#assign  total_all_touchkeys = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_ALL_LINROTS"]
                [#assign  total_all_linrots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_LINROTS"]
                [#assign  total_linrots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_LINROTS_B"]
                [#assign  total_linrots_b = define.value]
            [/#if]

            [#if define.name == "TSLPRM_TOTAL_LINS"]
                [#assign  total_lins = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_LINS_B"]
                [#assign  total_lins_b = define.value]
            [/#if]

            [#if define.name == "TSLPRM_TOTAL_ROTS"]
                [#assign  total_rots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_ROTS_B"]
                [#assign  total_rots_b = define.value]
            [/#if]

            [#if define.name == "TSLPRM_TOTAL_CHANNELS"]
                [#assign total_channels = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_3CH_LINROTS"]
                [#assign total_3ch_linrots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_4CH_LINROTS"]
                [#assign total_4ch_linrots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_5CH_LINROTS"]
                [#assign total_5ch_linrots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_6CH_LINROTS"]
                [#assign total_6ch_linrots = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_3CH_LINROTS_LIN_M1"]
                [#assign total_3ch_linrots_lin_M1 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_LIN_M1_NBR"]
                [#assign total_3ch_linrots_lin_M1_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_LIN_M1_B_NBR"]
                [#assign total_3ch_linrots_lin_M1_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_3CH_LINROTS_LIN_M2"]
                [#assign total_3ch_linrots_lin_M2 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_LIN_M2_NBR"]
                [#assign total_3ch_linrots_lin_M2_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_LIN_M2_B_NBR"]
                [#assign total_3ch_linrots_lin_M2_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_3CH_LINROTS_LIN_H"]
                [#assign total_3ch_linrots_lin_H = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_LIN_H_NBR"]
                [#assign total_3ch_linrots_lin_H_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_LIN_H_B_NBR"]
                [#assign total_3ch_linrots_lin_H_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_3CH_LINROTS_ROT_M"]
                [#assign total_3ch_linrots_rot_M = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_ROT_M_NBR"]
                [#assign total_3ch_linrots_rot_M_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_3CH_ROT_M_B_NBR"]
                [#assign total_3ch_linrots_rot_M_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_4CH_LINROTS_LIN_M1"]
                [#assign total_4ch_linrots_lin_M1 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_LIN_M1_NBR"]
                [#assign total_4ch_linrots_lin_M1_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_LIN_M1_B_NBR"]
                [#assign total_4ch_linrots_lin_M1_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_4CH_LINROTS_LIN_M2"]
                [#assign total_4ch_linrots_lin_M2 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_LIN_M2_NBR"]
                [#assign total_4ch_linrots_lin_M2_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_LIN_M2_B_NBR"]
                [#assign total_4ch_linrots_lin_M2_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_4CH_LINROTS_LIN_H"]
                [#assign total_4ch_linrots_lin_H = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_LIN_H_NBR"]
                [#assign total_4ch_linrots_lin_H_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_LIN_H_B_NBR"]
                [#assign total_4ch_linrots_lin_H_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_4CH_LINROTS_ROT_M"]
                [#assign total_4ch_linrots_rot_M = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_ROT_M_NBR"]
                [#assign total_4ch_linrots_rot_M_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_4CH_ROT_M_B_NBR"]
                [#assign total_4ch_linrots_rot_M_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_5CH_LINROTS_LIN_M1"]
                [#assign total_5ch_linrots_lin_M1 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_LIN_M1_NBR"]
                [#assign total_5ch_linrots_lin_M1_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_LIN_M1_B_NBR"]
                [#assign total_5ch_linrots_lin_M1_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_5CH_LINROTS_LIN_M2"]
                [#assign total_5ch_linrots_lin_M2 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_LIN_M2_NBR"]
                [#assign total_5ch_linrots_lin_M2_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_LIN_M2_B_NBR"]
                [#assign total_5ch_linrots_lin_M2_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_5CH_LINROTS_LIN_H"]
                [#assign total_5ch_linrots_lin_H = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_LIN_H_NBR"]
                [#assign total_5ch_linrots_lin_H_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_LIN_H_B_NBR"]
                [#assign total_5ch_linrots_lin_H_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_5CH_LINROTS_ROT_M"]
                [#assign total_5ch_linrots_rot_M = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_ROT_M_NBR"]
                [#assign total_5ch_linrots_rot_M_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_ROT_M_B_NBR"]
                [#assign total_5ch_linrots_rot_M_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_5CH_LINROTS_ROT_D"]
                [#assign total_5ch_linrots_rot_D = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_ROT_D_NBR"]
                [#assign total_5ch_linrots_rot_D_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_5CH_ROT_D_B_NBR"]
                [#assign total_5ch_linrots_rot_D_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_6CH_LINROTS_LIN_M1"]
                [#assign total_6ch_linrots_lin_M1 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_LIN_M1_NBR"]
                [#assign total_6ch_linrots_lin_M1_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_LIN_M1_B_NBR"]
                [#assign total_6ch_linrots_lin_M1_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_6CH_LINROTS_LIN_M2"]
                [#assign total_6ch_linrots_lin_M2 = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_LIN_M2_NBR"]
                [#assign total_6ch_linrots_lin_M2_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_LIN_M2_B_NBR"]
                [#assign total_6ch_linrots_lin_M2_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_6CH_LINROTS_LIN_H"]
                [#assign total_6ch_linrots_lin_H = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_LIN_H_NBR"]
                [#assign total_6ch_linrots_lin_H_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_LIN_H_B_NBR"]
                [#assign total_6ch_linrots_lin_H_B_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_TOTAL_6CH_LINROTS_ROT_M"]
                [#assign total_6ch_linrots_rot_M = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_ROT_M_NBR"]
                [#assign total_6ch_linrots_rot_M_NBR = define.value]
            [/#if]
            [#if define.name == "TSLPRM_USE_6CH_ROT_M_B_NBR"]
                [#assign total_6ch_linrots_rot_M_B_NBR = define.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]


[#assign channelnbr = (3*(total_linrots?number + total_linrots_b?number) + total_touchkeys?number + total_touchkeys_b?number) -1]
[#assign total_all_touchkey_nb = total_touchkeys?number + total_touchkeys_b?number ]
[#assign total_all_linrots_nb = total_linrots?number + total_linrots_b?number ]
[#assign total_linrots_nb = total_linrots?number ]
[#assign total_linrots_b_nb = total_linrots_b?number ]

[#assign total_lins_nb = total_lins?number ]
[#assign total_lins_b_nb = total_lins_b?number ]
[#assign total_rots_nb = total_rots?number ]
[#assign total_rots_b_nb = total_rots_b?number ]

[#assign total_touchkeys_nb = total_touchkeys?number ]
[#assign total_touchkeys_b_nb = total_touchkeys_b?number ]
[#assign total_objects_nb = total_objects?number ]
[#assign total_channels_nb = total_channels?number ]
[#assign total_3ch_linrots_lin_M1_nb = total_3ch_linrots_lin_M1?number ]
[#assign total_3ch_linrots_lin_M1_NBR_nb = total_3ch_linrots_lin_M1_NBR?number ]
[#assign total_3ch_linrots_lin_M1_B_NBR_nb = total_3ch_linrots_lin_M1_B_NBR?number ]
[#assign total_3ch_linrots_lin_M2_NBR_nb = total_3ch_linrots_lin_M2_NBR?number ]
[#assign total_3ch_linrots_lin_M2_B_NBR_nb = total_3ch_linrots_lin_M2_B_NBR?number ]
[#assign total_3ch_linrots_lin_M2_nb = total_3ch_linrots_lin_M2?number ]
[#assign total_3ch_linrots_lin_H_nb = total_3ch_linrots_lin_H?number ]
[#assign total_3ch_linrots_lin_H_NBR_nb = total_3ch_linrots_lin_H_NBR?number ]
[#assign total_3ch_linrots_lin_H_B_NBR_nb = total_3ch_linrots_lin_H_B_NBR?number ]
[#assign total_3ch_linrots_rot_M_nb = total_3ch_linrots_rot_M?number ]
[#assign total_3ch_linrots_rot_M_NBR_nb = total_3ch_linrots_rot_M_NBR?number ]
[#assign total_3ch_linrots_rot_M_B_NBR_nb = total_3ch_linrots_rot_M_B_NBR?number ]
[#assign total_4ch_linrots_lin_M1_nb = total_4ch_linrots_lin_M1?number ]
[#assign total_4ch_linrots_lin_M1_NBR_nb = total_4ch_linrots_lin_M1_NBR?number ]
[#assign total_4ch_linrots_lin_M1_B_NBR_nb = total_4ch_linrots_lin_M1_B_NBR?number ]
[#assign total_4ch_linrots_lin_M2_NBR_nb = total_4ch_linrots_lin_M2_NBR?number ]
[#assign total_4ch_linrots_lin_M2_B_NBR_nb = total_4ch_linrots_lin_M2_B_NBR?number ]
[#assign total_4ch_linrots_lin_M2_nb = total_4ch_linrots_lin_M2?number ]
[#assign total_4ch_linrots_lin_H_nb = total_4ch_linrots_lin_H?number ]
[#assign total_4ch_linrots_lin_H_NBR_nb = total_4ch_linrots_lin_H_NBR?number ]
[#assign total_4ch_linrots_lin_H_B_NBR_nb = total_4ch_linrots_lin_H_B_NBR?number ]
[#assign total_4ch_linrots_rot_M_nb = total_4ch_linrots_rot_M?number ]
[#assign total_4ch_linrots_rot_M_NBR_nb = total_4ch_linrots_rot_M_NBR?number ]
[#assign total_4ch_linrots_rot_M_B_NBR_nb = total_4ch_linrots_rot_M_B_NBR?number ]
[#assign total_5ch_linrots_lin_M1_nb = total_5ch_linrots_lin_M1?number ]
[#assign total_5ch_linrots_lin_M1_NBR_nb = total_5ch_linrots_lin_M1_NBR?number ]
[#assign total_5ch_linrots_lin_M1_B_NBR_nb = total_5ch_linrots_lin_M1_B_NBR?number ]
[#assign total_5ch_linrots_lin_M2_NBR_nb = total_5ch_linrots_lin_M2_NBR?number ]
[#assign total_5ch_linrots_lin_M2_B_NBR_nb = total_5ch_linrots_lin_M2_B_NBR?number ]
[#assign total_5ch_linrots_lin_M2_nb = total_5ch_linrots_lin_M2?number ]
[#assign total_5ch_linrots_lin_H_nb = total_5ch_linrots_lin_H?number ]
[#assign total_5ch_linrots_lin_H_NBR_nb = total_5ch_linrots_lin_H_NBR?number ]
[#assign total_5ch_linrots_lin_H_B_NBR_nb = total_5ch_linrots_lin_H_B_NBR?number ]
[#assign total_5ch_linrots_rot_M_nb = total_5ch_linrots_rot_M?number ]
[#assign total_5ch_linrots_rot_M_NBR_nb = total_5ch_linrots_rot_M_NBR?number ]
[#assign total_5ch_linrots_rot_M_B_NBR_nb = total_5ch_linrots_rot_M_B_NBR?number ]
[#assign total_5ch_linrots_rot_D_nb = total_5ch_linrots_rot_D?number ]
[#assign total_5ch_linrots_rot_D_NBR_nb = total_5ch_linrots_rot_D_NBR?number ]
[#assign total_5ch_linrots_rot_D_B_NBR_nb = total_5ch_linrots_rot_D_B_NBR?number ]
[#assign total_6ch_linrots_lin_M1_nb = total_6ch_linrots_lin_M1?number ]
[#assign total_6ch_linrots_lin_M1_NBR_nb = total_6ch_linrots_lin_M1_NBR?number ]
[#assign total_6ch_linrots_lin_M1_B_NBR_nb = total_6ch_linrots_lin_M1_B_NBR?number ]
[#assign total_6ch_linrots_lin_M2_NBR_nb = total_6ch_linrots_lin_M2_NBR?number ]
[#assign total_6ch_linrots_lin_M2_B_NBR_nb = total_6ch_linrots_lin_M2_B_NBR?number ]
[#assign total_6ch_linrots_lin_M2_nb = total_6ch_linrots_lin_M2?number ]
[#assign total_6ch_linrots_lin_H_nb = total_6ch_linrots_lin_H?number ]
[#assign total_6ch_linrots_lin_H_NBR_nb = total_6ch_linrots_lin_H_NBR?number ]
[#assign total_6ch_linrots_lin_H_B_NBR_nb = total_6ch_linrots_lin_H_B_NBR?number ]
[#assign total_6ch_linrots_rot_M_nb = total_6ch_linrots_rot_M?number ]
[#assign total_6ch_linrots_rot_M_NBR_nb = total_6ch_linrots_rot_M_NBR?number ]
[#assign total_6ch_linrots_rot_M_B_NBR_nb = total_6ch_linrots_rot_M_B_NBR?number ]

#include "tsl_user.h"
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/*============================================================================*/
/* Channels                                                                   */
/*============================================================================*/

/* Source and Configuration (ROM) */
CONST TSL_ChannelSrc_T MyChannels_Src[TSLPRM_TOTAL_CHANNELS] =
{
[#-- ************************************************************************************************** --]
[#-- list of channels  1 per key, 3 per linear/rot, if n lin/rot activated then 3*n first GPIO affected --]
[#list 0..(total_channels_nb-1) as i]
  { CHANNEL_${i}_SRC, CHANNEL_${i}_SAMPLE, CHANNEL_${i}_CHANNEL }[#if i!=(total_channels_nb-1)],[/#if]
[/#list]
};
[#-- ************************************************************************************************** --]

/* Destination (ROM) */
CONST TSL_ChannelDest_T MyChannels_Dest[TSLPRM_TOTAL_CHANNELS] =
{
[#-- ************************************************************************************************** --]
[#-- list of channels  1 per key, 3 per linear/rot, if n lin/rot activated then 3*n first GPIO affected --]
[#list 0..(total_channels_nb-1) as i]
  { CHANNEL_${i}_DEST }[#if i!=(total_channels_nb-1)],[/#if]
[/#list]
[#-- ************************************************************************************************** --]
};

/* Data (RAM) */
TSL_ChannelData_T MyChannels_Data[TSLPRM_TOTAL_CHANNELS];

/*============================================================================*/
/* Banks                                                                      */
/*============================================================================*/

/* List (ROM) */
CONST TSL_Bank_T MyBanks[TSLPRM_TOTAL_BANKS] = {
[#-- ************************************************************************************************** --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as define]
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
                        [#-- get nbr of dedicated banks --]
                        [#assign wordsArrayItemNext = wordsArray[i+1]]
                        [#assign wordsArrayItemNextNbr = wordsArrayItemNext?number - 1]
                        [#-- for each dedicated banks, get number oof items --]
                        [#list 0..wordsArrayItemNextNbr as j]
                            [#assign nbrofbankitem = wordsArray[i+1+j+1]]
                            [#assign nbrofbankitemnbr = nbrofbankitem?number -1 + counter]
                            [#if tsc_shield_ios?contains("+TS:ShieldIOs")]
                                [#lt]   {&MyChannels_Src[${counter}], &MyChannels_Dest[${counter}], MyChannels_Data, BANK_${bankNbInt}_NBCHANNELS},
                            [#else]
                                [#lt]   {&MyChannels_Src[${counter}], &MyChannels_Dest[${counter}], MyChannels_Data, BANK_${bankNbInt}_NBCHANNELS, BANK_${bankNbInt}_SHIELD_SAMPLE, BANK_${bankNbInt}_SHIELD_CHANNEL},
                            [/#if]
                            [#assign counter = nbrofbankitemnbr + 1]
                            [#assign bankNbInt = bankNbInt + 1]
                        [/#list]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]
[/#list]
};
[#-- *************end of list of banks***************************** --]
[#if total_all_touchkey_nb != 0]
[#-- ************************************************************************************************** --]
[#-- If touchkey(s) is(are) enabled --]
/*============================================================================*/
/* Touchkey sensors                                                           */
/*============================================================================*/

/* Data (RAM) */
TSL_TouchKeyData_T MyTKeys_Data[TSLPRM_TOTAL_TKEYS];

/* Parameters (RAM) */
TSL_TouchKeyParam_T MyTKeys_Param[TSLPRM_TOTAL_TKEYS];

/* State Machine (ROM) */

void MyTKeys_ErrorStateProcess(void);
void MyTKeys_OffStateProcess(void);

CONST TSL_State_T MyTKeys_StateMachine[] =
{
  /* Calibration states */
  /*  0 */ { TSL_STATEMASK_CALIB,              TSL_tkey_CalibrationStateProcess },
  /*  1 */ { TSL_STATEMASK_DEB_CALIB,          TSL_tkey_DebCalibrationStateProcess },
  /* Release states */
  /*  2 */ { TSL_STATEMASK_RELEASE,            TSL_tkey_ReleaseStateProcess },
#if TSLPRM_USE_PROX > 0
  /*  3 */ { TSL_STATEMASK_DEB_RELEASE_PROX,   TSL_tkey_DebReleaseProxStateProcess },
#else
  /*  3 */ { TSL_STATEMASK_DEB_RELEASE_PROX,   0 },
#endif
  /*  4 */ { TSL_STATEMASK_DEB_RELEASE_DETECT, TSL_tkey_DebReleaseDetectStateProcess },
  /*  5 */ { TSL_STATEMASK_DEB_RELEASE_TOUCH,  TSL_tkey_DebReleaseTouchStateProcess },
#if TSLPRM_USE_PROX > 0
  /* Proximity states */
  /*  6 */ { TSL_STATEMASK_PROX,               TSL_tkey_ProxStateProcess },
  /*  7 */ { TSL_STATEMASK_DEB_PROX,           TSL_tkey_DebProxStateProcess },
  /*  8 */ { TSL_STATEMASK_DEB_PROX_DETECT,    TSL_tkey_DebProxDetectStateProcess },
  /*  9 */ { TSL_STATEMASK_DEB_PROX_TOUCH,     TSL_tkey_DebProxTouchStateProcess },  
#else
  /*  6 */ { TSL_STATEMASK_PROX,               0 },
  /*  7 */ { TSL_STATEMASK_DEB_PROX,           0 },
  /*  8 */ { TSL_STATEMASK_DEB_PROX_DETECT,    0 },
  /*  9 */ { TSL_STATEMASK_DEB_PROX_TOUCH,     0 },
#endif
  /* Detect states */
  /* 10 */ { TSL_STATEMASK_DETECT,             TSL_tkey_DetectStateProcess },
  /* 11 */ { TSL_STATEMASK_DEB_DETECT,         TSL_tkey_DebDetectStateProcess },
  /* Touch state */
  /* 12 */ { TSL_STATEMASK_TOUCH,              TSL_tkey_TouchStateProcess },
  /* Error states */
  /* 13 */ { TSL_STATEMASK_ERROR,              MyTKeys_ErrorStateProcess },
  /* 14 */ { TSL_STATEMASK_DEB_ERROR_CALIB,    TSL_tkey_DebErrorStateProcess },
  /* 15 */ { TSL_STATEMASK_DEB_ERROR_RELEASE,  TSL_tkey_DebErrorStateProcess },
  /* 16 */ { TSL_STATEMASK_DEB_ERROR_PROX,     TSL_tkey_DebErrorStateProcess },
  /* 17 */ { TSL_STATEMASK_DEB_ERROR_DETECT,   TSL_tkey_DebErrorStateProcess },
  /* 18 */ { TSL_STATEMASK_DEB_ERROR_TOUCH,    TSL_tkey_DebErrorStateProcess },
  /* Other states */
  /* 19 */ { TSL_STATEMASK_OFF,                MyTKeys_OffStateProcess }
};

/* Methods for "extended" type (ROM) */
CONST TSL_TouchKeyMethods_T MyTKeys_Methods =
{
  TSL_tkey_Init,
  TSL_tkey_Process
};
/* TouchKeys list (ROM) */
[#assign index1 = total_channels_nb - total_all_touchkey_nb ]

[#if total_touchkeys_nb != 0]

CONST TSL_TouchKey_T MyTKeys[TSLPRM_TOTAL_TOUCHKEYS] =
{
[#list 0..(total_touchkeys_nb-1) as i]
  { &MyTKeys_Data[${i}], &MyTKeys_Param[${i}], &MyChannels_Data[CHANNEL_${i + index1}_DEST], MyTKeys_StateMachine, &MyTKeys_Methods }[#if i!=(total_touchkeys_nb-1)],[/#if]
[/#list]
};
[/#if]

[#if total_touchkeys_b_nb != 0]
[#assign index1 = total_touchkeys_nb]
[#assign index2 = total_touchkeys_nb + total_channels_nb - total_all_touchkey_nb]
CONST TSL_TouchKeyB_T MyTKeysB[TSLPRM_TOTAL_TOUCHKEYS_B] =
{
[#list 0..(total_touchkeys_b_nb-1) as i]
  { &MyTKeys_Data[${index1 + i}], &MyTKeys_Param[${index1 +i}], &MyChannels_Data[CHANNEL_${index2 + i}_DEST] }[#if i!=(total_touchkeys_b_nb-1)],[/#if]
[/#list]
};
[/#if]

[#-- ************************************************************************************************** --]
[/#if]
[#if total_all_linrots_nb != 0]
[#-- ************************************************************************************************** --]
[#-- If lin/rot(s) is(are) enabled --]

/*============================================================================*/
/* Linear and Rotary sensors                                                  */
/*============================================================================*/

/* Data (RAM) */
TSL_LinRotData_T MyLinRots_Data[TSLPRM_TOTAL_ALL_LINROTS];

/* Parameters (RAM) */
TSL_LinRotParam_T MyLinRots_Param[TSLPRM_TOTAL_ALL_LINROTS];

/* State Machine (ROM) */

void MyLinRots_ErrorStateProcess(void);
void MyLinRots_OffStateProcess(void);

CONST TSL_State_T MyLinRots_StateMachine[] =
{
  /* Calibration states */
  /*  0 */ { TSL_STATEMASK_CALIB,              TSL_linrot_CalibrationStateProcess },
  /*  1 */ { TSL_STATEMASK_DEB_CALIB,          TSL_linrot_DebCalibrationStateProcess },
  /* Release states */
  /*  2 */ { TSL_STATEMASK_RELEASE,            TSL_linrot_ReleaseStateProcess },
#if TSLPRM_USE_PROX > 0
  /*  3 */ { TSL_STATEMASK_DEB_RELEASE_PROX,   TSL_linrot_DebReleaseProxStateProcess },
#else
  /*  3 */ { TSL_STATEMASK_DEB_RELEASE_PROX,   0 },
#endif
  /*  4 */ { TSL_STATEMASK_DEB_RELEASE_DETECT, TSL_linrot_DebReleaseDetectStateProcess },
  /*  5 */ { TSL_STATEMASK_DEB_RELEASE_TOUCH,  TSL_linrot_DebReleaseTouchStateProcess },
#if TSLPRM_USE_PROX > 0
  /* Proximity states */
  /*  6 */ { TSL_STATEMASK_PROX,               TSL_linrot_ProxStateProcess },
  /*  7 */ { TSL_STATEMASK_DEB_PROX,           TSL_linrot_DebProxStateProcess },
  /*  8 */ { TSL_STATEMASK_DEB_PROX_DETECT,    TSL_linrot_DebProxDetectStateProcess },
  /*  9 */ { TSL_STATEMASK_DEB_PROX_TOUCH,     TSL_linrot_DebProxTouchStateProcess },
#else
  /*  6 */ { TSL_STATEMASK_PROX,               0 },
  /*  7 */ { TSL_STATEMASK_DEB_PROX,           0 },
  /*  8 */ { TSL_STATEMASK_DEB_PROX_DETECT,    0 },
  /*  9 */ { TSL_STATEMASK_DEB_PROX_TOUCH,     0 },
#endif
  /* Detect states */
  /* 10 */ { TSL_STATEMASK_DETECT,             TSL_linrot_DetectStateProcess },
  /* 11 */ { TSL_STATEMASK_DEB_DETECT,         TSL_linrot_DebDetectStateProcess },
  /* Touch state */
  /* 12 */ { TSL_STATEMASK_TOUCH,              TSL_linrot_TouchStateProcess },
  /* Error states */
  /* 13 */ { TSL_STATEMASK_ERROR,              MyLinRots_ErrorStateProcess },
  /* 14 */ { TSL_STATEMASK_DEB_ERROR_CALIB,    TSL_linrot_DebErrorStateProcess },
  /* 15 */ { TSL_STATEMASK_DEB_ERROR_RELEASE,  TSL_linrot_DebErrorStateProcess },
  /* 16 */ { TSL_STATEMASK_DEB_ERROR_PROX,     TSL_linrot_DebErrorStateProcess },
  /* 17 */ { TSL_STATEMASK_DEB_ERROR_DETECT,   TSL_linrot_DebErrorStateProcess },
  /* 18 */ { TSL_STATEMASK_DEB_ERROR_TOUCH,    TSL_linrot_DebErrorStateProcess },
  /* Other states */
  /* 19 */ { TSL_STATEMASK_OFF,                MyLinRots_OffStateProcess }
};

/* Methods for "extended" type (ROM) */
CONST TSL_LinRotMethods_T MyLinRots_Methods =
{
  TSL_linrot_Init,
  TSL_linrot_Process,
  TSL_linrot_CalcPos
};

/* Delta Normalization Process
   The MSB is the integer part, the LSB is the real part
   Examples:
   - To apply a factor 1.10:
     0x01 to the MSB
     0x1A to the LSB (0.10 x 256 = 25.6 -> rounded to 26 = 0x1A)
   - To apply a factor 0.90:
     0x00 to the MSB
     0xE6 to the LSB (0.90 x 256 = 230.4 -> rounded to 230 = 0xE6)
*/
[#if total_linrots_nb != 0]
    [#list 0..(total_linrots_nb-1) as i]
    [#lt]CONST uint16_t MyLinRot${i}_DeltaCoeff[3] = {0x0100, 0x0100, 0x0100};
    [/#list]
[/#if]
[#if total_linrots_b_nb != 0]
    [#list 0..(total_linrots_b_nb-1) as i]
    [#lt]CONST uint16_t MyLinRotB${i}_DeltaCoeff[3] = {0x0100, 0x0100, 0x0100};
    [/#list]
[/#if]

[#if total_linrots_nb != 0]
    [#assign index1 = 0]
    [#assign index2 = 0]
[#else]
    [#assign index1 = 0]
    [#assign index2 = 0]
[/#if]

    [#lt]/* LinRots list (ROM)*/
    [#if total_linrots_nb != 0]
        [#lt]CONST TSL_LinRot_T MyLinRots[TSLPRM_TOTAL_LINROTS] =
        [#lt]{
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as define]
                    [#if define.name = "TSLPRM_USE_3CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_lin_M1_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_lin_M1_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_3CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_3CH_LIN_M1,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_3CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_lin_M2_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_lin_M2_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_3CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_3CH_LIN_M2,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_3CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_lin_H_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_lin_H_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_3CH_LIN_H,
                                    [#lt]   TSL_POSCORR_3CH_LIN_H,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_3CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_rot_M_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_rot_M_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_3CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_lin_M1_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_lin_M1_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_4CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_4CH_LIN_M1,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_lin_M2_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_lin_M2_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_4CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_4CH_LIN_M2,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_lin_H_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_lin_H_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_4CH_LIN_H,
                                    [#lt]   TSL_POSCORR_4CH_LIN_H,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_rot_M_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_rot_M_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_4CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_lin_M1_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_lin_M1_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_5CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_5CH_LIN_M1,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_lin_M2_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_lin_M2_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_5CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_5CH_LIN_M2,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_lin_H_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_lin_H_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_5CH_LIN_H,
                                    [#lt]   TSL_POSCORR_5CH_LIN_H,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_rot_M_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_rot_M_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_5CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_ROT_D"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_rot_D_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_rot_D_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_ROT_D,
                                    [#lt]   TSL_SCTCOMP_5CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_lin_M1_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_lin_M1_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_6CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_6CH_LIN_M1,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_lin_M2_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_lin_M2_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_6CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_6CH_LIN_M2,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_lin_H_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_lin_H_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_6CH_LIN_H,
                                    [#lt]   TSL_POSCORR_6CH_LIN_H,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_rot_M_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_rot_M_NBR_nb -1) as i]
                                    [#lt]   /* LinRot sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRot${index2}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_6CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#lt]};
    [/#if]
    [#if total_linrots_b_nb != 0]
        [#assign index3 = 0]
    [#else]
        [#assign index1 = 0]
        [#assign index2 = 0]
    [/#if]
        [#if total_linrots_b_nb != 0]
        [#lt]CONST TSL_LinRot_T MyLinRotsB[TSLPRM_TOTAL_LINROTS_B] =
        [#lt]{
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as define]
                    [#if define.name = "TSLPRM_USE_3CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_lin_M1_B_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_lin_M1_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_3CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_3CH_LIN_M1,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_3CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_lin_M2_B_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_lin_M2_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_3CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_3CH_LIN_M2,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_3CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_lin_H_B_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_lin_H_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_3CH_LIN_H,
                                    [#lt]   TSL_POSCORR_3CH_LIN_H,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_3CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_3ch_linrots_rot_M_B_NBR_nb != 0)]
                                [#list 0..(total_3ch_linrots_rot_M_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   3, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_3CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_3CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +3)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_lin_M1_B_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_lin_M1_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_4CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_4CH_LIN_M1,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_lin_M2_B_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_lin_M2_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_4CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_4CH_LIN_M2,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_lin_H_B_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_lin_H_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_4CH_LIN_H,
                                    [#lt]   TSL_POSCORR_4CH_LIN_H,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_4CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_4ch_linrots_rot_M_B_NBR_nb != 0)]
                                [#list 0..(total_4ch_linrots_rot_M_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   4, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_4CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_4CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +4)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_lin_M1_B_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_lin_M1_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_5CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_5CH_LIN_M1,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_lin_M2_B_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_lin_M2_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_5CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_5CH_LIN_M2,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_lin_H_NBR_nb != 0) | (total_5ch_linrots_lin_H_B_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_lin_H_NBR_nb + total_5ch_linrots_lin_H_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_5CH_LIN_H,
                                    [#lt]   TSL_POSCORR_5CH_LIN_H,
                                    [#lt]   MyLinRots_StateMachine,
                                    [#lt]   &MyLinRots_Methods
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_rot_M_B_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_rot_M_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_5CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_5CH_ROT_D"]
                        [#if define.value = "1"]
                            [#if (total_5ch_linrots_rot_D_B_NBR_nb != 0)]
                                [#list 0..(total_5ch_linrots_rot_D_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   5, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_5CH_ROT_D,
                                    [#lt]   TSL_SCTCOMP_5CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +5)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_LIN_M1"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_lin_M1_B_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_lin_M1_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_LIN_M1,
                                    [#lt]   TSL_SCTCOMP_6CH_LIN_M1,
                                    [#lt]   TSL_POSCORR_6CH_LIN_M1,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_LIN_M2"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_lin_M2_B_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_lin_M2_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_LIN_M2,
                                    [#lt]   TSL_SCTCOMP_6CH_LIN_M2,
                                    [#lt]   TSL_POSCORR_6CH_LIN_M2,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_LIN_H"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_lin_H_B_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_lin_H_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_LIN_H,
                                    [#lt]   TSL_SCTCOMP_6CH_LIN_H,
                                    [#lt]   TSL_POSCORR_6CH_LIN_H,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                    [#if define.name = "TSLPRM_USE_6CH_ROT_M"]
                        [#if define.value = "1"]
                            [#if (total_6ch_linrots_rot_M_B_NBR_nb != 0)]
                                [#list 0..(total_6ch_linrots_rot_M_B_NBR_nb -1) as i]
                                    [#lt]   /* LinRotB sensor ${index2} = S${(index2 + 1)} */
                                    [#lt]   {
                                    [#lt]   &MyLinRots_Data[${index2}],
                                    [#lt]   &MyLinRots_Param[${index2}],
                                    [#lt]   &MyChannels_Data[CHANNEL_${index1}_DEST],
                                    [#lt]   6, /* Number of channels */
                                    [#lt]   MyLinRotB${index3}_DeltaCoeff,
                                    [#lt]   (TSL_tsignPosition_T *)TSL_POSOFF_6CH_ROT_M,
                                    [#lt]   TSL_SCTCOMP_6CH_ROT_M,
                                    [#lt]   0,
                                    [#lt]   }[#if index2 != (total_objects_nb - 1)],[/#if]
                                    [#assign index1 = (index1 +6)]
                                    [#assign index2 = (index2 +1)]
                                    [#assign index3 = (index3 +1)]
                                [/#list]
                            [/#if]
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#lt]};
    [/#if]
[/#if]
[#-- ************************************************************************************************** --]

/*============================================================================*/
/* Generic Objects                                                            */
/*============================================================================*/

/* List (ROM) */
CONST TSL_Object_T MyObjects[TSLPRM_TOTAL_OBJECTS] =
[#assign index1 = 0]
{
[#if total_touchkeys_nb != 0]
    [#list 0..(total_touchkeys_nb-1) as i]
[#-- ************************************************************************************************** --]
[#-- list of objects  1 per key, 1 per linear/rot --]
[#-- if touchkey --]
  { TSL_OBJ_TOUCHKEY, (TSL_TouchKey_T *)&MyTKeys[${i}] }[#if i!=(total_objects_nb - 1)],[/#if]
        [#assign index1 = index1 +1]
    [/#list]
[/#if]
[#if total_touchkeys_b_nb != 0]
    [#list 0..(total_touchkeys_b_nb-1) as i]
[#-- ************************************************************************************************** --]
[#-- list of objects  1 per key, 1 per linear/rot --]
[#-- if touchkey --]
  { TSL_OBJ_TOUCHKEYB, (TSL_TouchKeyB_T *)&MyTKeysB[${i}] }[#if i!=(total_objects_nb - 1)],[/#if]
        [#assign index1 = index1 +1]
    [/#list]
[/#if]
[#-- ************************************************************************************************** --]
[#if total_linrots_nb != 0]
[#-- if linrots --]
[#if total_lins_nb != 0]
[#-- if lins --]
    [#list 0..(total_lins_nb -1) as i]
  { TSL_OBJ_LINEAR, (TSL_LinRot_T *)&MyLinRots[${i}] }[#if index1!=(total_objects_nb - 1)],[/#if]
        [#assign index1 = index1 +1]
    [/#list]
[/#if]
[#if total_rots_nb != 0]
[#-- if rots --]
    [#list total_lins_nb..(total_linrots_nb - 1) as i]
  { TSL_OBJ_ROTARY, (TSL_LinRot_T *)&MyLinRots[${i}] }[#if index1!=(total_objects_nb - 1)],[/#if]
        [#assign index1 = index1 +1]
    [/#list]
[/#if]
[/#if]
[#-- ************************************************************************************************** --]
[#if total_linrots_b_nb != 0]
[#-- if linsrot_b --]
[#if total_lins_b_nb != 0]
[#-- if lins_b --]
    [#list 0..(total_lins_b_nb -1) as i]
  { TSL_OBJ_LINEARB, (TSL_LinRotB_T *)&MyLinRotsB[${i}] }[#if index1!=(total_objects_nb - 1)],[/#if]
        [#assign index1 = index1 +1]
    [/#list]
[/#if]
[#if total_rots_b_nb != 0]
[#-- if rots_b --]
    [#list total_lins_b_nb..(total_linrots_b_nb- 1) as i]
  { TSL_OBJ_ROTARYB, (TSL_LinRotB_T *)&MyLinRotsB[${i}] }[#if index1!=(total_objects_nb - 1)],[/#if]
        [#assign index1 = index1 +1]
    [/#list]
[/#if]
[/#if]
};

/* Group (RAM) */
TSL_ObjectGroup_T MyObjGroup =
{
  &MyObjects[0],        /* First object */
  TSLPRM_TOTAL_OBJECTS, /* Number of objects */
  0x00,                 /* State mask reset value */
  TSL_STATE_NOT_CHANGED /* Current state */
};

/*============================================================================*/
/* TSL Common Parameters placed in RAM or ROM                                 */
/* --> external declaration in tsl_conf.h                                     */
/*============================================================================*/

TSL_Params_T TSL_Params =
{
  TSLPRM_ACQ_MIN,
  TSLPRM_ACQ_MAX,
  TSLPRM_CALIB_SAMPLES,
  TSLPRM_DTO,
#if TSLPRM_TOTAL_TKEYS > 0  
  MyTKeys_StateMachine,   /* Default state machine for TKeys */
  &MyTKeys_Methods,       /* Default methods for TKeys */
#endif
#if TSLPRM_TOTAL_LNRTS > 0
  MyLinRots_StateMachine, /* Default state machine for LinRots */
  &MyLinRots_Methods      /* Default methods for LinRots */
#endif
};

/* Private functions prototype -----------------------------------------------*/

/* Global variables ----------------------------------------------------------*/
/* USER CODE BEGIN Global variables */

/* USER CODE END Global variables */

__IO TSL_tTick_ms_T ECSLastTick; /* Hold the last time value for ECS */

/**
  * @brief  Initialize the STMTouch Driver
  * @param  None
  * @retval None
  */
void tsl_user_Init(void)
{
  TSL_obj_GroupInit(&MyObjGroup); /* Init Objects */
  
  TSL_Init(MyBanks); /* Init acquisition module */
  
  tsl_user_SetThresholds(); /* Init thresholds for each object individually (optional) */
}

/**
  * @brief  Execute STMTouch Driver main State machine
  * @param  None
  * @retval status Return TSL_STATUS_OK if the acquisition is done
  */
tsl_user_status_t tsl_user_Exec(void)
{
  static uint32_t idx_bank = 0;
  static uint32_t config_done = 0;
  tsl_user_status_t status = TSL_USER_STATUS_BUSY;

  /* Configure and start bank acquisition */
  if (!config_done)
  {
/* USER CODE BEGIN not config_done start*/

/* USER CODE END not config_done start*/
  TSL_acq_BankConfig(idx_bank);
    TSL_acq_BankStartAcq();
    config_done = 1;
/* USER CODE BEGIN not config_done */

/* USER CODE END not config_done */
  }

  /* Check end of acquisition (polling mode) and read result */
  if (TSL_acq_BankWaitEOC() == TSL_STATUS_OK)
  {
/* USER CODE BEGIN end of acquisition start*/

/* USER CODE END end of acquisition start*/
    STMSTUDIO_LOCK;
    TSL_acq_BankGetResult(idx_bank, 0, 0);
    STMSTUDIO_UNLOCK;
    idx_bank++; /* Next bank */
    config_done = 0;
/* USER CODE BEGIN end of acquisition */

/* USER CODE END end of acquisition */
  }

  /* Process objects, DxS and ECS
     Check if all banks have been acquired
  */
  if (idx_bank > TSLPRM_TOTAL_BANKS-1)
  {
/* USER CODE BEGIN before reset*/

/* USER CODE END before reset*/
    /* Reset flags for next banks acquisition */
    idx_bank = 0;
    config_done = 0;
    
    /* Process Objects */
    TSL_obj_GroupProcess(&MyObjGroup);
    
    /* DxS processing (if TSLPRM_USE_DXS option is set) */
    TSL_dxs_FirstObj(&MyObjGroup);
    
    /* ECS every TSLPRM_ECS_DELAY (in ms) */
    if (TSL_tim_CheckDelay_ms(TSLPRM_ECS_DELAY, &ECSLastTick) == TSL_STATUS_OK)
    {
      if (TSL_ecs_Process(&MyObjGroup) == TSL_STATUS_OK)
      {
        status = TSL_USER_STATUS_OK_ECS_ON;
      }
      else
      {
        status = TSL_USER_STATUS_OK_ECS_OFF;
      }
    }
    else
    {
      status = TSL_USER_STATUS_OK_NO_ECS;
    }
/* USER CODE BEGIN Process objects */

/* USER CODE END Process objects */
  }
  else
  {
    status = TSL_USER_STATUS_BUSY;
/* USER CODE BEGIN TSL_USER_STATUS_BUSY */

/* USER CODE END TSL_USER_STATUS_BUSY */
  }
  
  return status;
}

/**
  * @brief  Set thresholds for each object (optional).
  * @param  None
  * @retval None
  */
void tsl_user_SetThresholds(void)
{
/* USER CODE BEGIN Tsl_user_SetThresholds */
  /* Example: Decrease the Detect thresholds for the TKEY 0
  MyTKeys_Param[0].DetectInTh -= 10;
  MyTKeys_Param[0].DetectOutTh -= 10;
  */
/* USER CODE END Tsl_user_SetThresholds */
}

/**
  * @brief  Executed when a sensor is in Error state
  * @param  None
  * @retval None
  */
[#if total_all_touchkey_nb != 0]
[#-- If touchkey(s) is(are) enabled --]
  void MyTKeys_ErrorStateProcess(void)
{
/* USER CODE BEGIN total_all_touchkey_nb */
  /* Add here your own processing when a sensor is in Error state */
/* USER CODE END total_all_touchkey_nb */
}
[#-- ************************************************************************************************** --]
[/#if]
[#if total_all_linrots_nb != 0]
[#-- If linrot(s) is(are) enabled --]
void MyLinRots_ErrorStateProcess(void)
{
/* USER CODE BEGIN MyLinRots_ErrorStateProcess */
  /* Add here your own processing when a sensor is in Error state */
/* USER CODE END MyLinRots_ErrorStateProcess */
}
[#-- ************************************************************************************************** --]
[/#if]


/**
  * @brief  Executed when a sensor is in Off state
  * @param  None
  * @retval None
  */
[#if total_all_touchkey_nb != 0]
[#-- If touchkey(s) is(are) enabled --]
void MyTKeys_OffStateProcess(void)
{
/* USER CODE BEGIN MyTKeys_OffStateProcess */
  /* Add here your own processing when a sensor is in Off state */
/* USER CODE END MyTKeys_OffStateProcess */
}

[/#if]
[#if total_all_linrots_nb != 0]
[#-- If linrot(s) is(are) enabled --]
void MyLinRots_OffStateProcess(void)
{
/* USER CODE BEGIN MyLinRots_OffStateProcess */
  /* Add here your own processing when a sensor is in Off state */
/* USER CODE END MyLinRots_OffStateProcess */
}
[#-- ************************************************************************************************** --]
[/#if]
