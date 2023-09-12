[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${name?lower_case}.c
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : This file implements the USB Device
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- Create global variables --]
[#assign includeDone = 0]
[#assign includeClassAudio = 0]
[#assign includeClassCcid = 0]
[#assign includeClassCdc = 0]
[#assign includeClassDfu = 0]
[#assign includeClassHid = 0]
[#assign includeClassMsc = 0]
[#assign includeClassMtp = 0]
[#assign includeClassCustomHid = 0]

[#assign instanceNb = 0]
[#assign instanceNbCallBack = 0]
[#assign instanceNbFunction = 0]

[#assign useBCD=false]

/* Includes ------------------------------------------------------------------*/
[#-- IPdatas is a list of IPconfigModel --]
[#if configs??]
   [#list configs as config]
        [#list config.peripheralParams?keys as PeripheralParams]
            [#if PeripheralParams=="USB"]
                [#assign values = config.peripheralParams[PeripheralParams]][#-- values is a hash list --]
                [#if values["battery_charging_enable"]=="ENABLE"]	
[#assign useBCD=true]			 
                [/#if]
            [/#if]
        [/#list]
    [/#list]
 [/#if]
 
[#compress]
[#list IPdatas as IP]
[#assign ipvar = IP]
[#list IP.configModelList as instanceData]
        [#if includeDone == 0]
        [#assign includeDone = 1]
#include "${name?lower_case}.h"
#include "usbd_core.h"
#include "usbd_desc.h"
        [/#if]
[#assign className = instanceData.instanceName?lower_case]
[#assign descriptorClassName = instanceData.instanceName]

[#if instanceData.instanceName == "ALL_CLASSES"]

        [#if includeClassAudio == 0]
        [#assign includeClassAudio = 1]
#include "usbd_audio.h"
#include "usbd_audio_if.h"
        [/#if]

        [#if includeClassCcid == 0]
        [#assign includeClassCcid = 1]
#include "usbd_ccid.h"
#include "usbd_ccid_if.h"
        [/#if]

        [#if includeClassCdc == 0]
        [#assign includeClassCdc = 1]
#include "usbd_cdc.h"
#include "usbd_cdc_if.h"
        [/#if]

        [#if includeClassHid == 0]
        [#assign includeClassHid = 1]
#include "usbd_hid.h"
        [/#if]

        [#if includeClassDfu == 0]
        [#assign includeClassDfu = 1]
#include "usbd_dfu.h"
#include "usbd_dfu_if.h"
        [/#if]

        [#if includeClassMsc == 0]
        [#assign includeClassMsc = 1]
#include "usbd_msc.h"
#include "usbd_storage_if.h"
        [/#if]

        [#if includeClassMtp == 0]
        [#assign includeClassMtp = 1]
#include "usbd_mtp.h"
        [/#if]

        [#if className == "customhid"]		
                [#if includeClassCustomHid == 0]
                [#assign includeClassCustomHid = 1]
#include "usbd_customhid.h"
#include "usbd_custom_hid_if.h"
                [/#if]
        [/#if]
[/#if]

        [#if className == "audio"]
                [#if includeClassAudio == 0]
                [#assign includeClassAudio = 1]
#include "usbd_audio.h"
#include "usbd_audio_if.h"
                [/#if]
        [/#if]

        [#if className == "ccid"]
                [#if includeClassCcid == 0]
                [#assign includeClassCcid = 1]
#include "usbd_ccid.h"
#include "usbd_ccid_if.h"
        [/#if]
        [/#if]

        [#if className == "cdc"]
                [#if includeClassCdc == 0]
                [#assign includeClassCdc = 1]
#include "usbd_cdc.h"
#include "usbd_cdc_if.h"
                [/#if]
        [/#if]

        [#if className == "hid"]
                [#if includeClassHid == 0]
                [#assign includeClassHid = 1]
#include "usbd_hid.h"
                [/#if]
        [/#if]

        [#if className == "customhid"]
		[#assign descriptorClassName = "CUSTOM_HID"]
                [#if includeClassCustomHid == 0]
                [#assign includeClassCustomHid = 1]
#include "usbd_customhid.h"
#include "usbd_custom_hid_if.h"
                [/#if]
        [/#if]

        [#if className == "dfu"]
                [#if includeClassDfu == 0]
                [#assign includeClassDfu = 1]
#include "usbd_dfu.h"
[#if FamilyName == "STM32G4"]
#include "usbd_dfu_flash.h"
[#else]
#include "usbd_dfu_if.h"
[/#if]

                [/#if]
        [/#if]

        [#if className == "msc"]
                [#if includeClassMsc == 0]
                [#assign includeClassMsc = 1]
#include "usbd_msc.h"
#include "usbd_storage_if.h"
                [/#if]
        [/#if]

        [#if className == "mtp"]
                [#if includeClassMtp == 0]
                [#assign includeClassMtp = 1]
#include "usbd_mtp.h"
                [/#if]
        [/#if]


[/#list]
[/#list]
[/#compress]
[#-- Define includes --]
#n
[#--/****************************************/--]
[#--/* #define for FS and HS identification */--]
[#--#define DEVICE_HS           0--]
[#--#define DEVICE_FS           1--]

[#-- macro generateConfigModelCode --]
[#macro generateConfigModelCode configModel inst nTab]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else]
        [#assign methodList = configModel.libMethod]
[/#if]
[#assign USBD_Start=false]
[#local myInst=inst]

        [#list methodList as method]
            [#if !FREERTOS?? || method.osCall=="PRE_OS"]
                [#assign args = ""]
                [#if method.callBackMethod=="false"]
                [#if method.status=="OK"]
                
            [#if method.arguments??]            
                [#list method.arguments as fargument]
                                [#if fargument.returnValue=="false"]
                                        [#assign return = ""]
                                        [#compress]
                                        [#if fargument.addressOf]
                                                [#assign adr = "&"]
                                        [#else ]
                                                [#assign adr = ""]
                                        [/#if]
                                        [/#compress]
                                        [#if fargument.genericType == "Array"]
                                                [#assign valList = fargument.value?split(fargument.arraySeparator)]
                        [#assign i = 0]
                                                [#list valList as val]
                                                        #t${fargument.name}[${i}] = ${val};
                                                        [#assign i = i+1]
                                                [/#list]
                    [#assign argValue="&"+fargument.name]
                                        [/#if]
                                        [#if fargument.genericType == "struct"]
                                                [#if fargument.context??]
                                                        [#if fargument.context=="global"]
                                                                [#if configModel.ipName=="DMA"]
                                                                        [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                                                                [#else]
                                                                        [#assign instanceIndex = inst?replace(name,"")]
                                                                [/#if]
                                                        [/#if]
                                                [/#if]
                                                [#if instanceIndex??&&fargument.context=="global"]
                                                        [#assign arg = "" + adr + fargument.name + instanceIndex]
                                                [#else]
                                                        [#assign arg = "" + adr + fargument.name]
                                                [/#if]
                                                [#-- [#assign arg = "" + adr + fargument.name] --]
                                                [#--if (!method.name?contains("Init")&&fargument.context=="global")--]
                                                [#if (fargument.init=="false")] [#-- MZA add the field init for Argument object, if init is false the initialization of this argument is not done --]
                                                        [#-- do Nothing --]
                                                [#else]
                                                        [#list fargument.argument as argument]
                                                                [#compress]
                                                                        [#if argument.addressOf]
                                                                                [#assign AdrMza = ""]
                                                                        [#else]
                                                                                [#assign AdrMza = ""]
                                                                        [/#if]
                                                                [/#compress]
                                                                [#if argument.genericType != "struct"]        
                                                                        [#if argument.mandatory]
                                                                                [#if instanceIndex??&&fargument.context=="global"]
                                                                                        [#assign argValue=argument.value?replace("$Index",instanceIndex)]
                                                                                [#else]
                                                                                        [#assign argValue=argument.value]
                                                                                [/#if]
                                                                                [#if argument.genericType=="Array"][#-- if genericType=Array --]
                                                                                        [#assign valList = argument.value?split(argument.arraySeparator)]
                                                                                        [#assign i = 0]
                                                                                        [#list valList as val]
                                                                                                #t${argument.name}[${i}] = ${val};
                                                                                                [#assign i = i+1]
                                                                                        [/#list]
                                                                                [/#if] [#-- if genericType=Array --]
                                                                                [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                                                                [#else]
                                                                                        [#if argument.genericType=="fpointer"]
                                                                                                [#local Function = inst + "_" + argument.name]
                                                [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${AdrMza}${Function};
                                                                                        [#else]
                                                [#if argument.value??]
                                                                                                        [#local Function = argument.value]
                                                                                                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${AdrMza}${Function};
                                                [/#if]
                                                                                        [/#if]
                                                                                [#--[#if argument.name=="Instance"]--]
                                                                                        [#-- [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${AdrMza}${Function};--]
                                                                                [#--[/#if]--]
                                                                        [/#if]
                                                                [#else]
                                                                [#list argument.argument as argument1]
                                                                        [#if argument1.mandatory]
                                                                                [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument1.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument1.value][/#if]
                                                                                [#if argument1.genericType=="Array"][#-- if genericType=Array --]
                                                                                        [#assign valList = argument1.value?split(":")]
                                                                                        [#assign i = 0]
                                                                                        [#list valList as val]
                                                                                                #t${argument1.name}[${i}] = ${val};
                                                                                                [#assign i = i+1]
                                                                                        [/#list]
                                                                                        [#assign argValue="&"+argument1.name+"[0]"]
                                                                                [/#if] [#-- if genericType=Array --]
                                                                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                                                                        [/#if]
                                                                [/#list]
                                                                [/#if]
                                                        [/#list][#-- list  fargument.argument as argument--]
                                                [/#if]
                                        [#elseif fargument.genericType == "simple"] [#-- MZA if argument is simple we pass the name of the argument and not the value --]
                                                [#if fargument.context=="global"]
                                                        [#assign arg = "" + adr + fargument.name + myInst]
                                                [#else]
                                                        [#--[#assign arg = "" + adr + fargument.name]--]
                                                        [#assign arg = "" + adr + fargument.value]
                                                [/#if]
                                        [#else][#-- if struct --]
                                                [#assign arg = "" + adr + fargument.value]
                                        [/#if]
                                        [#if args == ""]
                                                [#assign args = args + arg ]
                                        [#else]
                                                [#assign args = args + ', ' + arg]
                                        [/#if]
                                [#else] [#-- here we have an Argument as Return Value --]
                                        [#if fargument.context=="global"] [#assign return = fargument.name + myInst + " = "]
                                        [#else] [#assign return = fargument.name + " = "]
                                        [/#if]
                                [/#if]

                [/#list]
                                [#if method.name == "USBD_Start"]
                                	[#if useBCD=true]
                                		[#if nTab==2]#t#t[#else]#t[/#if]/* Verify if the Battery Charging Detection mode (BCD) is used : */
                                		[#if nTab==2]#t#t[#else]#t[/#if]/* If yes, the USB device is started in the HAL_PCDEx_BCD_Callback */
                                		[#if nTab==2]#t#t[#else]#t[/#if]/* upon reception of PCD_BCD_DISCOVERY_COMPLETED message. */                                		                                		
                                		#tif (USBD_LL_BatterryCharging(&hUsbDeviceFS) != USBD_OK) {
                                		#t#tError_Handler();
                                		#t}
                                	[#else]                                                                                                
                                		[#if nTab==2]#t#t[#else]#t[/#if]if (${return}${method.name}(${args}) != USBD_OK) {                                
                                		#t#tError_Handler();
                                		#t}  
                                	[/#if]                              
                                [#else]                                
                    [#if nTab==2]#t#t[#else]#t[/#if]if (${return}${method.name}(${args}) != USBD_OK) {   
                    			#t#tError_Handler();
                                #t}
                                [/#if]
                        [/#if]        
                               
                [/#if]
                [#if method.status=="KO"]                 
                #n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
                [#if method.arguments??]                        [#-- here we comment all variables initialization --]
                                [#list method.arguments as fargument]
                                        [#if fargument.addressOf]
                                                [#assign adr = "&"]
                                        [#else ]
                                                [#assign adr = ""]
                                        [/#if]
                                        [#if fargument.genericType == "struct"]
                                                [#assign arg = "" + adr + fargument.name]
                        [#if fargument.context??]
                                                        [#if fargument.context=="global"]
                                                                [#if configModel.ipName=="DMA"]
                                                                        [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                                                                [#else]
                                                                        [#assign instanceIndex = inst?replace(name,"")]
                                                                [/#if]
                                                        [/#if]
                                                [/#if]
                        [#if instanceIndex??&&fargument.context=="global"]
                                                        [#assign arg = "" + adr + fargument.name + instanceIndex]
                                                [#else]
                                                        [#assign arg = "" + adr + fargument.name]
                                                [/#if]
                        [#if (!method.name?contains("Init")&&fargument.context=="global")]
                        [#else]
                        [#list fargument.argument as argument]
                                [#if argument.genericType != "struct"]
                                                                        [#if argument.mandatory]
                                                                                [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument.value][/#if]
                                                                        [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                 [#else]
                                    [#if argument.name=="Instance"]
                                        [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${inst};
                                    [/#if]
                                [/#if]
                                                                [#else]
                                                                [#list argument.argument as argument1]
                                                                        [#if argument1.mandatory]
                                                                                [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument1.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument1.value][/#if]
                                                                                [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                                                                        [/#if]
                                                                [/#list]
                                                                [/#if]
                        [/#list]
                                        [/#if]
                    [#else]
                        [#assign arg = "" + adr + fargument.value]
                    [/#if]
                                        [#if args == ""]
                                                [#assign args = args + arg ]
                                        [#else]
                                                [#assign args = args + ', ' + arg]
                    [/#if]
                [/#list]
                                [#if nTab==2]#t#t[#else]#t[/#if]//${method.name}(${args});
            [#else]
            [#if nTab==2]#t#t[#else]#t[/#if]${method.name}()#n;
                        [/#if]
        [/#if]
[/#if]
	[/#if]
    [/#list]

[#assign instanceIndex = ""]
[#-- else there is no LibMethod to call--]
[/#macro]
[#-- End macro generateConfigModelCode --]
#n

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */


[#-- Section2: Create global Variables for each middle ware instance --]
[#-- Global variables --]
[#assign handle = ""]
extern void Error_Handler(void);
/* USB Device Core handle declaration. */
[#compress]
[#list IPdatas as IP]
[#assign ipvar = IP]
[#if IP.variables??]
        [#list IP.variables as variable]
                [#if variable.value?contains("Handle")]
                ${variable.value} ${variable.name};
                [#assign instanceNb = instanceNb + 1]
                [#assign handle = variable.name]
                [/#if]
        [/#list]
[/#if]
[/#list]
[/#compress]
#nextern USBD_DescriptorsTypeDef ${descriptorClassName}_Desc;
[#-- Global variables --]
#n
/*
 * -- Insert your variables declaration here --
 */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#n
/*
 * -- Insert your external function declaration here --
 */
[#if useBCD=true]
extern USBD_StatusTypeDef USBD_LL_BatterryCharging(USBD_HandleTypeDef *pdev); 
[/#if] 
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#n#n

/**
  * Init USB device Library, add supported class and start the library
  * @retval None
  */
void MX_${name}_Init(void)
{
[#compress]
[#-- Section3: Create the void mx_<IpInstance>_init() function for each middle ware instance --]
[#list IPdatas as IP]
[#if instanceNb == 1]
        [#assign instName = ""]
[#else]
        [#assign instName= "1"]
[/#if]
[#--[#assign instName = instance]--]
[#assign ipvar = IP]
[#list IP.configModelList as instanceData]
[#--[#assign instName = instanceData.instanceName]--]
[#assign halMode= instanceData.halMode]
[#assign ipName = instanceData.ipName]
[#assign instName = ""]
        [#-- MZA je dois remplir la liste des configs, pour l'instant j'utilise la liste des methods --]
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""]
        [#list instanceData.configs as config]
                [#--[@getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]--]
                [#assign listOfLocalVariables =resultList]
        [/#list]
#t/* USER CODE BEGIN ${ipName}_Init_PreTreatment */
#t
#t/* USER CODE END ${ipName}_Init_PreTreatment */
#t

        #t/* Init Device Library, add supported class and start the library. */
        [#list instanceData.configs as config]
        [@generateConfigModelCode configModel=config inst=instName  nTab=1/]
    [/#list]
        [#assign instName= "${instanceNb}"]
        [#assign instanceNb = instanceNb + 1]
[/#list]
[/#list]
[/#compress]

#t/* USER CODE BEGIN ${ipName}_Init_PostTreatment */
#t
#t/* USER CODE END ${ipName}_Init_PostTreatment */
}

/**
  * @}
  */

/**
  * @}
  */

