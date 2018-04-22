[#ftl]
/**
  ******************************************************************************
  * File Name          : gpio.c
  * Description        : This file provides code for the configuration
  *                      of all used GPIO pins.
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

  [#compress]
/* Includes ------------------------------------------------------------------*/
#include "gpio.h"

[/#compress]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/*----------------------------------------------------------------------------*/
/* Configure GPIO                                                             */
/*----------------------------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

[#compress]
void MX_GPIO_Init(void) 
{
[#assign v = ""]
[#list datas as data]
	[#list data.variables as variable]				
			[#if v?contains(variable.name)]
				[#-- no matches--]
			[#else]
				#t${variable.value} ${variable.name};
				[#assign v = v + " "+ variable.name/]	
			[/#if]	
	[/#list]
[/#list]

[#list datas as data]
[#if data.comments??]

[#if data.methods?size >0 ]#n#t/** ${data.comments}#n#t*/[/#if][/#if]
	[#list data.methods as method][#assign args = ""]			
			[#if method.status=="OK"]	
                [#-- --]                
                [#if (method.name == "HAL_GPIO_Init") || (method.name == "GPIO_Init") ]
                    [#assign pin = ""]
                    [#assign port = ""]
                    [#list method.arguments as fargument]
                    [#if fargument.name =="GPIOx"]							
                       [#assign port = port + " " + fargument.value]
                        [#assign i =port?length-1]
                        [#assign j =port?length]
                       [#assign port = "P"+port?substring(i,j)]
                    [/#if]
                    [#if fargument.genericType == "struct"]											
                        [#list fargument.argument as argument]	
                            [#if argument.name =="Pin"]							
                                [#assign pin = pin + " " + argument.value]
                            [/#if]                            
                        [/#list]
                    [/#if]
                    [/#list]
                    [#compress]
                    #n#t/*Configure GPIO [#if pin?split("|")?size>1]pins[#else]pin[/#if] : [#list pin?split("|") as x][#assign i =x?split("_")] [#assign j =i?last]${port}${j} [/#list] */[/#compress]
                [#else]
                [#if method.comment??]#n#t/*[#compress]${method.comment} */[/#compress][/#if]			
                [/#if]    

                [#-- --]
		
				[#if method.arguments??]
					[#list method.arguments as fargument][#compress]
						[#if fargument.addressOf] [#assign adr = "&"][#else ][#assign adr = ""][/#if][/#compress]
						[#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]											
							[#list fargument.argument as argument]	
							
[#if argument.mandatory]
[#if argument.value??][#if argument.value!=""]							
#t${fargument.name}.${argument.name} = ${argument.value};
[#else]
//#t${fargument.name}.${argument.name} = ${argument.value};
[/#if][/#if]
[/#if]

[/#list][#else][#assign arg = "" + adr + fargument.value][/#if]
					[#if args == ""][#assign args = args + arg ][#else][#assign args = args + ', ' + arg][/#if]
[/#list]
#t${method.name}(${args});

				[#else]
#t//${method.comment}[/#if]			
[/#if]
[#if method.status=="KO"]
		
#n#t//!!! ${method.name} is commented because some parameters are missing
			[#if method.arguments??]			
				[#list method.arguments as fargument]
					[#if fargument.addressOf] [#assign adr = "&"][#else ] [#assign adr = ""][/#if]
					[#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]
						[#list fargument.argument as argument]	
[#if argument.mandatory]						
#t//${fargument.name}.${argument.name} = ${argument.value}; 
[/#if]
		 				[/#list][#else][#assign arg = "" + adr + fargument.value][/#if]
					[#if args == ""][#assign args = args + arg ]
					[#else][#assign args = args + ', ' + arg][/#if][/#list]
#t//${method.name}(${args});[/#if]
[/#if][/#list][/#list]
}
[/#compress]


/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/