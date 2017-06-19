[#ftl]
/**
  ******************************************************************************
  * @file           : ${name}  
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : This file implements the USB Device 
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
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

/* Includes ------------------------------------------------------------------*/
[#-- IPdatas is a list of IPconfigModel --] 

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
#include "usbd_dfu_if.h"
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
[#--#define DEVICE_HS 		0--]
[#--#define DEVICE_FS 		1--]

[#-- macro generateConfigModelCode --]
[#macro generateConfigModelCode configModel inst nTab]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else] 
	[#assign methodList = configModel.libMethod]
[/#if]	
[#local myInst=inst]

	[#list methodList as method]
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
						[#if (fargument.init=="false")] [#-- MZA add the field init for Argument object, if init is false the intialization of this argument is not done --]				
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
								[#if argument.genericType != "struct"]	tata
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
				[#if nTab==2]#t#t[#else]#t[/#if]/* Verify if the Battery Charging Detection mode (BCD) is used : */
				[#if nTab==2]#t#t[#else]#t[/#if]/* If yes, the USB device is started in the HAL_PCDEx_BCD_Callback */
				[#if nTab==2]#t#t[#else]#t[/#if]/* upon reception of PCD_BCD_DISCOVERY_COMPLETED message. */
				[#if nTab==2]#t#t[#else]#t[/#if]/* If no, the USB device is started now. */
				[#if nTab==2]#t#t[#else]#t[/#if]if (USBD_LL_BatteryCharging(&hUsbDeviceFS) != USBD_OK) {
				[/#if]
				[#if nTab==2]#t#t[#else]#t[/#if]${return}${method.name}(${args});
				[#else]
                    [#if nTab==2]#t#t[#else]#t[/#if]${return}${method.name}();
				[/#if]	
				[#if method.name == "USBD_Start"]				
				[#if nTab==2]#t#t[#else]#t[/#if]}
				[/#if]
		[/#if]
		[#if method.status=="KO"]
		#n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
		[#if method.arguments??]			[#-- here we comment all variables intialization --]
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
    [/#list]

[#assign instanceIndex = ""]
[#-- else there is no LibMethod to call--]
[/#macro]
[#-- End macro generateConfigModelCode --]
#n

[#-- Section2: Create global Variables for each middle ware instance --] 
[#-- Global variables --]
[#assign handle = ""]
/* Return USBD_OK if the Battery Charging Detection mode (BCD) is used, else USBD_FAIL */
extern USBD_StatusTypeDef USBD_LL_BatteryCharging(USBD_HandleTypeDef *pdev);
/* USB Device Core handle declaration */
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
[#-- Global variables --]


#n#n
/* init function */				        
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
				
	#t/* Init Device Library,Add Supported Class and Start the library*/	
	[#list instanceData.configs as config]
        [@generateConfigModelCode configModel=config inst=instName  nTab=1/]
    [/#list]			
	[#assign instName= "${instanceNb}"]
	[#assign instanceNb = instanceNb + 1]
[/#list]
[/#list]
[/#compress]

}

/**
  * @brief  HAL_PCDEx_BCD_Callback : Send BCD message to user layer
  * @param  hpcd: PCD handle
  * @param  msg: LPM message
  * @retval HAL status
  */
void HAL_PCDEx_BCD_Callback(PCD_HandleTypeDef *hpcd, PCD_BCD_MsgTypeDef msg)
{
  USBD_HandleTypeDef usbdHandle = ${handle};
  /* USER CODE BEGIN 7 */
  if (hpcd->battery_charging_active == ENABLE)
  {
    switch(msg)
    {    
      case PCD_BCD_CONTACT_DETECTION:
    
      break;
    
      case PCD_BCD_STD_DOWNSTREAM_PORT:
   
      break;
    
      case PCD_BCD_CHARGING_DOWNSTREAM_PORT:
   
      break;
    
      case PCD_BCD_DEDICATED_CHARGING_PORT:
   
      break;
    
      case PCD_BCD_DISCOVERY_COMPLETED:
        USBD_Start(&usbdHandle);
      break;
    
      case PCD_BCD_ERROR:
      default:
      break;
    }
  }
  /* USER CODE END 7 */
}
/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
