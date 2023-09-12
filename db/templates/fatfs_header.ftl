[#ftl]
[#assign contextFolder=""]
[#if cpucore!=""]    
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")+"/"]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file   fatfs.h
  * @brief  Header for fatfs applications
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __fatfs_H
#define __fatfs_H
#ifdef __cplusplus
 extern "C" {
#endif

[#compress]
[@common.optinclude name=contextFolder+mxTmpFolder+"/fatfs_inc.tmp"/][#--include fatfs includes --]

#n/* USER CODE BEGIN Includes */     
#n
#n/* USER CODE END Includes */
#n

[@common.optinclude name=contextFolder+mxTmpFolder+"/fatfs_ext_vars.tmp"/]

#nvoid MX_FATFS_Init(void);

#n/* USER CODE BEGIN Prototypes */
#n     
#n/* USER CODE END Prototypes */
[/#compress]

#ifdef __cplusplus
}
#endif
#endif /*__fatfs_H */
