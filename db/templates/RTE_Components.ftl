[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    
  * @author  MCD Application Team
  * @version V2.0.0
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
  /* Define to prevent recursive inclusion -------------------------------------*/
#ifndef  __RTE_COMPONENTS_H__
#define  __RTE_COMPONENTS_H__ 

/* Defines ------------------------------------------------------------------*/
[#if RTEdatas??]
[#compress]
[#list RTEdatas as define]
${define}
[/#list]
[/#compress]
[/#if]
 
 
#endif /* __RTE_COMPONENTS_H__ */