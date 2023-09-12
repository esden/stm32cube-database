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
        #include "DMA.h"
    [/#if]

/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

    [#-- End Define includes --]

    [#compress]
        [#-- Section1: Create CallBack function for each middle ware instance --]
        [#-- This section can be moded into ip_h.ftl --]
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

            #n/* ${ipName} init function */
            void MX_${ipName}_Init(void)
            {
                #t/* USER CODE BEGIN ${userCodeIdx} */
                #t/* USER CODE END ${userCodeIdx} */
                #n
                [#assign userCodeIdx = userCodeIdx+1]

                [#if instanceData.methods??]
                    [#list instanceData.methods as method]
                        [#assign args = ""]
                        [#list method.arguments as fargument]
                            [#assign arg = ""]
                            [#if fargument.status=="OK" && fargument.value?? && fargument.value!="__NULL"]
                                [#if fargument.returnValue!="true"]
                                    [#assign arg = "" + fargument.value]
                                [/#if]
                            [/#if]
                            [#if args == "" && arg!=""]
                                [#assign args = args + arg ]
                            [#else]
                                [#if arg!=""]
                                    [#assign args = args + ', ' + arg]
                                [/#if]
                            [/#if]
                        [/#list]
                        #tif (${method.name}(${args}) != RESMGR_OK)
                        #t{
                        #t#tError_Handler();
                        #t}
                        #n
                    [/#list]
                [/#if]

                #t/* USER CODE BEGIN ${userCodeIdx} */
                #t/* USER CODE END ${userCodeIdx} */
                [#assign userCodeIdx = userCodeIdx+1]

            #n}#n
        [/#list]
    [/#compress]
[/#list]

[#if FamilyName=="STM32H7"]
#n/* Resource Manager send message function */
__weak void MX_${ipName}_SendMsg(uint32_t id, uint32_t msg)
{
    #t/* USER CODE BEGIN ${userCodeIdx} */
    switch (msg)
    {
        case RESMGR_MSG_INIT:
            //User Code
            break;

        case RESMGR_MSG_DEINIT:
            //User Code
            break;

        case RESMGR_MSG_ASSIGN:
            //User Code
            break;

        case RESMGR_MSG_RELEASE:
            //User Code
            break;

        case RESMGR_MSG_PEND:
            //User Code
            break;

        case RESMGR_MSG_REJECT:
            //User Code
            break;

        default:
            break;
    }
    #t/* USER CODE END ${userCodeIdx} */
    [#assign userCodeIdx = userCodeIdx+1]

    return;
}#n


#n/* Resource Manager callback function */
__weak void MX_${ipName}_Callback(uint32_t id, uint32_t msg)
{
    #t/* USER CODE BEGIN ${userCodeIdx} */
    switch (msg)
    {
        case RESMGR_MSG_INIT:
            //User Code
            break;

        case RESMGR_MSG_DEINIT:
            //User Code
            break;

        case RESMGR_MSG_ASSIGNED:
            //User Code
            break;

        case RESMGR_MSG_RELEASED:
            //User Code
            break;

        case RESMGR_MSG_PENDED:
            //User Code
            break;

        case RESMGR_MSG_REJECTED:
            //User Code
            break;

        default:
            break;
    }
    #t/* USER CODE END ${userCodeIdx} */
    [#assign userCodeIdx = userCodeIdx+1]

    return;
}#n
[/#if]


/**
  * @}
  */
