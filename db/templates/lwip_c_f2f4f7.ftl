[#ftl]
/**
 ******************************************************************************
  * File Name          : ${name}.c
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#compress][#--- Macro START ---]
[#--- Generation lwip_dhcp = 0 or 1 ---]
[#--- Generation with_rtos = 0 or 1 ---]
[#macro DHCP_RTOS_Settings configModel]
	[#assign lwip_dhcp = 0]
	[#assign with_rtos = 0]
	[#assign netif_callback = 0]
	[#assign no_sys_no_timers = 0]
	[#assign lwip_ipv4 = 0]
	[#assign lwip_ipv6 = 0]
	[#assign methodList = configModel.libMethod]
	[#list methodList as method]
		[#list method.arguments as argument]
			[#if (argument.name == "LWIP_DHCP") && (argument.value == "1")]
				[#assign lwip_dhcp = 1]
			[/#if]
			[#if (argument.name == "NO_SYS") && (argument.value == "0")]
				[#assign with_rtos = 1]
			[/#if]
			[#if (argument.name == "LWIP_NETIF_LINK_CALLBACK") && (argument.value == "1")]
				[#assign netif_callback = 1]
			[/#if]
			[#if (argument.name == "NO_SYS_NO_TIMERS") && (argument.value == "1")]
                [#assign no_sys_no_timers = 1]
            [/#if]
            [#if (argument.name == "LWIP_IPV4") && (argument.value == "1")]
                [#assign lwip_ipv4 = 1]
            [/#if]
            [#if (argument.name == "LWIP_IPV6") && (argument.value == "1")]
                [#assign lwip_ipv6 = 1]
            [/#if]
		[/#list]
	[/#list]
[/#macro]



[#--- Macro END ---]

[#--- Generation of lwip_dhcp/with_rtos = 0 or 1 ---]
[#list IPdatas as IP]
[#list IP.configModelList as instanceData]
	[#list instanceData.configs as config]
        [@DHCP_RTOS_Settings configModel=config/]
    [/#list]
[/#list]
[/#list]

[#-- --> lwip_dhcp: ${lwip_dhcp} --]
[#-- --> with_rtos: ${with_rtos} --][/#compress]
  
/* Includes ------------------------------------------------------------------*/
#include "lwip.h"
#include "lwip/init.h"
#include "lwip/netif.h"
[#if (netif_callback == 1) && (with_rtos == 1)]
#include "ethernetif.h"
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* ETH Variables initialization ----------------------------------------------*/
[#include "Src/eth_vars.tmp"]

[#compress][#if lwip_dhcp == 1]
[#if with_rtos == 0]
/* DHCP Variables initialization ---------------------------------------------*/
uint32_t DHCPfineTimer = 0;
uint32_t DHCPcoarseTimer = 0;
[/#if] [#-- endif with_rtos --]
[/#if] [#-- endif lwip_dhcp --][/#compress] 
[#-- IPdatas is a list of IPconfigModel --]  
[#list IPdatas as IP]  
[#assign ipvar = IP] 
 
[#-- macro getLocalVariable of a config Start--]
[#macro getLocalVariable configModel1 listOfLocalVariables resultList]
    [#if configModel1.methods??] 
        [#assign methodList1 = configModel1.methods]			
    [#else] 	
		[#assign methodList1 = configModel1.libMethod]
    [/#if]
    [#list methodList1 as method][#-- list methodList1 --]	
		[#if method.callBackMethod=="false"]		
			[#list method.arguments as argument][#-- list method.arguments --]		
				[#if (argument.genericType == "struct")][#-- if struct --]		 		
					[#if argument.context??][#-- if argument.context?? --]
						[#if argument.context!="global"] [#-- if global --]					
							[#assign varName= " "+argument.name]  					               
							[#assign ll= listOfLocalVariables?split(" ")]
							[#assign exist=false]					
							[#list ll as var  ]													
								[#if var==argument.name]												
									[#assign exist=true]
								[/#if]
							[/#list]
							[#if !exist]  [#-- if exist --] 					
							#t${argument.typeName} ${argument.name};
								[#assign resultList = listOfLocalVariables + " "+ argument.name]
							[/#if][#-- if exist --]
						[/#if][#-- if global --]
					[#else][#-- if context?? --]					
					#t${argument.typeName} ${argument.name};
					[/#if][#-- if argument.context?? --]
			
					[#-- Array type --] 	
					[#list argument.argument as subArg] [#-- list subArg --]				
					[#if subArg.genericType=="Array"] [#-- if genericType == "Array" --]					
						#t${subArg.typeName} ${subArg.name}[${subArg.arraySize}]; 
					[/#if] [#-- if genericType == "Array" --]
					[#if subArg.genericType =="struct"]
						[#list subArg.argument as subArg1] [#-- list subArg1 --]
							[#if subArg1.genericType=="Array"] [#-- if genericType == "Array" --]						
								#t ${subArg1.typeName} ${subArg1.name}[${subArg1.arraySize}] ; 
							[/#if] [#-- if genericType == "Array" --]
						[/#list]
					[/#if]
				[/#list] [#-- list subArg --]
				[/#if][#-- if struct --]
			
			
				[#if argument.genericType == "simple"]
					[#compress]
					[#if argument.addressOf] 
						[#assign adr = "&"]
					[#else]
						[#assign adr = ""]
					[/#if]
					[/#compress]
					[#if argument.context??]
						[#if argument.context =="local"] 				
							[#assign varName= " "+argument.name]  					               
							[#if (argument.init=="false")]
								#t${argument.typeName} ${argument.name};
							[#else]
								#t${argument.typeName} ${argument.name} = ${adr}${argument.value};
							[/#if]
						[/#if][#-- argument.context local --]
					[/#if][#-- argument.context?? --]
				[/#if][#-- genericType struct --]					
			[/#list][#-- list method.arguments --]
		[/#if][#-- callBackMethod --]	
    [/#list][#-- list methodList1 --]
[/#macro]
[#-- macro getLocalVariable of a config End--]

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
		[#if (method.status=="OK") || (method.status=="OK")]			
            [#if method.arguments??]		
                [#list method.arguments as fargument]
				[#if fargument.returnValue=="false"]								
					[#assign return = ""]
					[#compress]
					[#if fargument.addressOf] 
						[#assign adr = "&"]
					[#else]
						[#assign adr = ""]
					[/#if]
					[/#compress]
					[#if fargument.genericType == "simple"]			
					[/#if]
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
                                        [#assign argValue="&"+argument.name]
										[/#if] [#-- if genericType=Array --]
										[#if nTab==2]#t#t[#else]#t[/#if][#--[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};--]
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
							[#assign arg = "" + adr + fargument.name]
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
				[#if nTab==2]#t#t[#else]#t[/#if][#--${return}${method.name}(${args});#n--]
				[#else]
					[#--[#if nTab==2]#t#t[#else]#t[/#if]${return}${method.name}();--]
				[/#if]
		[/#if]
		[#if method.status=="KO"]
		#n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
		[#if method.arguments??]			[#-- here we comment all variables intialization --]
				[#list method.arguments as fargument]
					[#if fargument.addressOf] 
						[#assign adr = "&"]
					[#else] 
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

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
[#if (netif_callback == 1) && (with_rtos == 1)]
/* Semaphore to signal Ethernet Link state update */
osSemaphoreId Netif_LinkSemaphore = NULL;
/* Ethernet link thread Argument */
struct link_str link_arg;
[/#if]

[#compress]
[#-- Section2: Create global Variables for each middle ware instance --] 
[#-- Global variables --]

/* Variables Initialization */
[#if IP.variables??]
	[#list IP.variables as variable]
	[#if (variable.generiqueType=="Array") && (lwip_dhcp == 0) && (lwip_ipv4 == 1)]	
		${variable.value} ${variable.name}[${variable.arraySize}];
	[#else]
		[#if (variable.name == "ipaddr") || (variable.name == "netmask") || (variable.name == "gw")]
		     [#if lwip_ipv4 == 1]
			${variable.value} ${variable.name};
			 [/#if]
		[#else]
		    [#if variable.name == "gnetif"]
                struct ${variable.value} ${variable.name};
            [/#if]
			[#if variable.name != "heth"]
				[#-- ${variable.value} ${variable.name}; --]
			[/#if]
		[/#if]
	[/#if]
	[/#list]
[/#if]
[#if (lwip_ipv6 == 1)]
ip6_addr_t ip6addr;
[/#if]

[#-- Global variables --]
[/#compress]

#n/* USER CODE BEGIN 2 */

/* USER CODE END 2 */
[#compress]
[#-- Section3: Create the void mx_<IpInstance>_init() function for each middle ware instance --] 
[#list IP.configModelList as instanceData]
   [#assign instName = instanceData.instanceName]   
   [#assign halMode= instanceData.halMode]
   [#assign ipName = instanceData.ipName]
   
#n
/**   
#t* LwIP initialization function 
#t*/				        
void MX_LWIP_Init(void)
{
  [#-- MZA je dois remplir la liste des configs, pour l'instant j'utilise la liste des methods --]
  [#-- assign ipInstanceIndex = instName?replace(name,"")--]
  [#assign args = ""]
  [#assign listOfLocalVariables =""]
  [#assign resultList =""]
  [#list instanceData.configs as config]
    [@getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]	
    [#assign listOfLocalVariables =resultList]
  [/#list]
[#if (lwip_dhcp == 0) && (lwip_ipv4 == 1)]
  [#list instanceData.configs as config]
  [#--- Generation of IP @ initialization ex. IP_ADDRESS[0] = 000; ---]
#t/* IP addresses initialization */
  [@generateConfigModelCode configModel=config inst=instName  nTab=1/]
  [/#list]
[/#if] [#-- endif lwip_dhcp --] 
[/#list]
[/#compress]
[/#list]

[#compress]
[#if with_rtos == 0]
#t/* Initilialize the LwIP stack without RTOS */
#tlwip_init();
[/#if] [#-- endif with_rtos --]
[#if with_rtos == 1]
#t/* Initilialize the LwIP stack with RTOS */
#ttcpip_init( NULL, NULL );	
[/#if] [#-- endif with_rtos --]
#n
[/#compress]
[#compress]
[#if ((lwip_dhcp == 1) && (lwip_ipv4 == 1))]
#t/* IP addresses initialization with DHCP (IPv4) */
#tipaddr.addr = 0;
#tnetmask.addr = 0;
#tgw.addr = 0;
[#else]	
[#if (lwip_ipv4 == 1)]
#t/* IP addresses initialization without DHCP (IPv4) */
#tIP4_ADDR(&ipaddr, IP_ADDRESS[0], IP_ADDRESS[1], IP_ADDRESS[2], IP_ADDRESS[3]);
#tIP4_ADDR(&netmask, NETMASK_ADDRESS[0], NETMASK_ADDRESS[1] , NETMASK_ADDRESS[2], NETMASK_ADDRESS[3]);
#tIP4_ADDR(&gw, GATEWAY_ADDRESS[0], GATEWAY_ADDRESS[1], GATEWAY_ADDRESS[2], GATEWAY_ADDRESS[3]);
[/#if] [#-- endif lwip_ipv4 --]     
[/#if] [#-- endif lwip_dhcp && lwip_ipv4 --]
#n
[/#compress]
[#compress]
[#if with_rtos == 0]
[#if lwip_ipv4 == 1]
#t/* add the network interface (IPv4/IPv6) without RTOS */
#tnetif_add(&gnetif, &ipaddr, &netmask, &gw, NULL, &ethernetif_init, &ethernet_input);
[#else] [#-- case lwip_ipv4 == 0 --]
[#if lwip_ipv6 == 1]
#t/* add the network interface (IPv6) without RTOS */
#tnetif_add(&gnetif, NULL, &ethernetif_init, &ethernet_input);
[/#if] [#-- endif lwip_ipv6 --]
[/#if] [#-- endif lwip_ipv4 --]
[#else] [#-- case with_rtos == 1 --]
[#if lwip_ipv4 == 1]
#t/* add the network interface (IPv4/IPv6) with RTOS */
#tnetif_add(&gnetif, &ipaddr, &netmask, &gw, NULL, &ethernetif_init, &tcpip_input);
[#else] [#-- case lwip_ipv4 == 0 --]
[#if lwip_ipv6 == 1]
#t/* add the network interface (IPv6) with RTOS */
#tnetif_add(&gnetif, NULL, &ethernetif_init, &tcpip_input);
[/#if] [#-- endif lwip_ipv6 --]
[/#if] [#-- endif lwip_ipv4 --]
[/#if] [#-- endif with_rtos --]
[#if lwip_ipv6 == 1]
#n
#t/* Create IPv6 local address */
#tnetif_create_ip6_linklocal_address(&gnetif, 0);
[/#if] [#-- endif lwip_ipv6 --]
#n 
#t/*  Registers the default network interface */
#tnetif_set_default(&gnetif);
#n
#tif (netif_is_link_up(&gnetif))
#t{
#t#t/* When the netif is fully configured this function must be called */
#t#tnetif_set_up(&gnetif);
#t}
#telse
#t{
#t#t/* When the netif link is down this function must be called */
#t#tnetif_set_down(&gnetif);
#t}  
#n  
[#if (netif_callback == 1) && (with_rtos == 1)]
#t/* Set the link callback function, this function is called on change of link status*/
#tnetif_set_link_callback(&gnetif, ethernetif_update_config);
#n  
#t/* create a binary semaphore used for informing ethernetif of frame reception */
#tosSemaphoreDef(Netif_SEM);
#tNetif_LinkSemaphore = osSemaphoreCreate(osSemaphore(Netif_SEM) , 1 );
#n  
#tlink_arg.netif = &gnetif;
#tlink_arg.semaphore = Netif_LinkSemaphore;
#t/* Create the Ethernet link handler thread */
#tosThreadDef(LinkThr, ethernetif_set_link, osPriorityNormal, 0, configMINIMAL_STACK_SIZE * 2);
#tosThreadCreate (osThread(LinkThr), &link_arg);
[/#if]
#n
[#if (lwip_dhcp == 1) && (lwip_ipv4 == 1)]
#t/* Start DHCP negotiation for a network interface (IPv4) */
#tdhcp_start(&gnetif);
[/#if] [#-- endif lwip_dhcp --] 
#n
#n/* USER CODE BEGIN 3 */
#n
/* USER CODE END 3 */
}
[/#compress]

/* USER CODE BEGIN 4 */
#n
[#if (with_rtos == 0) && (no_sys_no_timers == 0)]
/**
 * ----------------------------------------------------------------------
 * Function given to help user to continue LwIP Initialization
 * Up to user to complete or change this function ...
 * Up to user to call this function in main.c in while (1) of main(void) 
 *-----------------------------------------------------------------------
 * Read a received packet from the Ethernet buffers 
 * Send it to the lwIP stack for handling
 * Handle timeouts if NO_SYS_NO_TIMERS not set and without RTOS
 */
void MX_LWIP_Process(void)
{
  ethernetif_input(&gnetif);
       
  /* Handle timeouts */
  #if !NO_SYS_NO_TIMERS && NO_SYS
    sys_check_timeouts();
  #endif
    
}
[/#if]
/* USER CODE END 4 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
