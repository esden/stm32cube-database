[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name?lower_case}.c
  * Description        : This file provides code for the configuration
  *                      of the ${name?lower_case} instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- 'UserCode sections' are indexed dynamically --]
[#assign userCodeIdx = 0]

/* Includes ------------------------------------------------------------------*/
#include "${name?lower_case}.h"

[#-- IPdatas is a list of IPconfigModel --]
[#list IPdatas as IP]
    [#assign ipvar = IP]
    [#assign useGpio = false]
    [#assign useDma = false]
    [#assign useNvic = false]

    [#-- extract hal mode list used by all instances of the ip --]
    [#assign halModeList= ""]
    [#list ipvar.instances.entrySet() as entry]
        [#if halModeList?contains(entry.value)]
        [#else]
            [#assign halModeList = halModeList + " " +entry.value]
        [/#if]
    [/#list]
    [#-- End extract hal mode list used by all instances of the ip --]

    [#-- Define includes --]
    [#list IP.configModelList as instanceData]
        [#if instanceData.initServices??]
            [#if instanceData.initServices.gpio??]
                [#assign useGpio = true]
            [/#if]
            [#if instanceData.initServices.dma??]
                [#assign useDma = true]
            [/#if]
            [#if instanceData.initServices.nvic??]
                [#assign useNvic = true]
            [/#if]
        [/#if]
    [/#list]
    [#if useGpio]
        #include "gpio.h"
    [/#if]
    [#if useDma]
        #include "dma.h"
    [/#if]

/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

    [#-- End Define includes --]

    [#compress]
        [#-- Section1: Create CallBack function for each middle ware instance --]
        [#-- This section can be moded into mw_h.ftl --]
        [#list IP.configModelList as instanceData]
            [#assign instName = instanceData.instanceName]
            [#list instanceData.configs as config]
                [#list config.libMethod as libMethod]
                    [#if libMethod.callBackMethod??]
                        [#if libMethod.callBackMethod=="true"]
                            [#if libMethod.arguments??]
                                [#assign argumentList= ""]
                                [#list libMethod.arguments as argument]
                                    [#if argument_has_next]
                                        [#assign argumentList = argumentList + " " + argument.typeName + ","]
                                    [#else]
                                        [#assign argumentList = argumentList + " " + argument.typeName]
                                    [/#if]
                                [/#list]
                                extern DSTATUS ${instName}_${libMethod.name}(${argumentList});
                            [#else]
                                extern DSTATUS ${instName}_${libMethod.name}(void);
                            [/#if]
                        [/#if]
                    [/#if]
                [/#list]
            [/#list]
        [/#list]#n

/* Global variables ---------------------------------------------------------*/
        [#-- Section2: Create global Variables for each middle ware instance --]
        [#-- Global variables --]
        [#if IP.variables??]
            [#list IP.variables as variable]
                [#if variable.generiqueType=="Array"]
                    ${variable.value} ${variable.name}[${variable.arraySize}];
                [#else]
                    ${variable.value} ${variable.name};
                [/#if]
            [/#list]
        [/#if]

        #n/* USER CODE BEGIN ${userCodeIdx} */
        /* USER CODE END ${userCodeIdx} */
        [#assign userCodeIdx = userCodeIdx+1]

        [#-- Global variables --]

        [#-- Section3: Create the void <IpInstance>_init() function for each middle ware instance --]
        [#list IP.configModelList as instanceData]
            [#assign instName = instanceData.instanceName]
            [#assign halMode= instanceData.halMode]
            [#assign ipName = instanceData.ipName]

            #n/* ${ipName}${instName} init function */
            void MX_${ipName}${instName}_Init(void)
            {
                #t/* USER CODE BEGIN ${userCodeIdx} */
                #t/* USER CODE END ${userCodeIdx} */
                #n
                [#assign userCodeIdx = userCodeIdx+1]

                [#assign args = ""]
                [#assign listOfLocalVariables =""]
                [#assign resultList =""]
                [#list instanceData.configs as config]
                    [@mw_common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]
                    [#assign listOfLocalVariables =resultList]
                [/#list]
                [#list instanceData.configs as config]
                    [@mw_common.generateConfigModelCode configModel=config inst=instName nTab=1/]
                [/#list]

                #n
                #t/* USER CODE BEGIN ${userCodeIdx} */
                #t/* USER CODE END ${userCodeIdx} */
                [#assign userCodeIdx = userCodeIdx+1]

            #n}#n
        [/#list]
    [/#compress]
[/#list]

/* USER CODE BEGIN ${userCodeIdx} */

#n/*  process function */
uint8_t MX_${ipName}${instName}_Process(uint16_t *PDMBuf, uint16_t *PCMBuf)
{
  /*
  uint8_t BSP_AUDIO_IN_PDMToPCM(uint16_t * PDMBuf, uint16_t * PCMBuf)

  Converts audio format from PDM to PCM.
  Parameters:
    PDMBuf : Pointer to PDM buffer data
    PCMBuf : Pointer to PCM buffer data
  Return values:
    AUDIO_OK in case of success, AUDIO_ERROR otherwise
  */
  /* this example return the default status AUDIO_ERROR */
  return (uint8_t) 1;
}#n

/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

/**
  * @}
  */
