[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    peripheral_init.h
  * @author  MCD Application Team
  * @brief   Header for peripheral init module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

#ifndef PERIPHERAL_INIT_H
#define PERIPHERAL_INIT_H

[#if (myHash["CFG_LPM_STDBY_SUPPORTED"]?number != 2)]
/**
  * @brief  Configure the SoC peripherals at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_PeripheralInit(void);
[#else]
/**
  * @brief  Configure the SoC peripherals at Stop2 mode exit.
  * @param  None
  * @retval None
  */
void MX_Stop2Exit_PeripheralInit(void);
[/#if]
#endif /* PERIPHERAL_INIT_H */
