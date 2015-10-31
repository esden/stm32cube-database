[#ftl]

/**
  ******************************************************************************
  * File Name          : ${name}
  * Date               : ${date}
  * Description        : This file overrides LwIP stack default configuration
  *                      done in opt.h file.
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
 
[#assign s = name]
[#assign toto = s?replace(".","__")]
[#assign inclusion_protection = toto?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#include "stm32f4xx_hal.h"

/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#ifdef __cplusplus
 extern "C" {
#endif

[#if includes??]
/* Includes ------------------------------------------------------------------*/
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]
[#-- Global variables --]

[#assign instName = SWIP.ipName]   
[#assign fileName = SWIP.fileName]   
[#assign version = SWIP.version]
	

[#if SWIP.defines??]
	[#assign lwip_stats = 1]
	[#assign lwip_dhcp = 0]
	[#list SWIP.defines as definition]			
		[#if definition.name == "LWIP_STATS"]
			[#if definition.value == "0"]
				[#assign lwip_stats = 0]
			[/#if]			
		[/#if]		
		[#if definition.name == "LWIP_DHCP"]
			[#if definition.value == "1"]
				[#assign lwip_dhcp = 1]
			[/#if]			
		[/#if]
		[#if definition.name == "NO_SYS"]
			[#if definition.value == "1"]
				[#assign lwip_rtos = 0]
			[#else]
				[#assign lwip_rtos = 1]
			[/#if]			
		[/#if]
		[#if definition.name == "LWIP_SO_RCVBUF"]
			[#if definition.value == "1"]
				[#assign lwip_so_rcvbuf = 1]
			[#else]
				[#assign lwip_so_rcvbuf = 0]
			[/#if]  			
		[/#if]					
	[/#list]
	
	[#if lwip_so_rcvbuf == 1]
/* LWIP_SO_RCVBUF is enabled => this requires INT_MAX definition in limits.h */	
#include "limits.h"		
	[/#if]
	
	[#list SWIP.defines as definition]
		[#if lwip_stats == 0]
			[#if (definition.name=="LINK_STATS") || (definition.name=="IP_STATS") || (definition.name=="IPFRAG_STATS") || (definition.name=="ICMP_STATS") || (definition.name=="IGMP_STATS") || (definition.name=="UDP_STATS") || (definition.name=="TCP_STATS") || (definition.name=="MEM_STATS") || (definition.name=="MEMP_STATS") || (definition.name=="SYS_STATS") || (definition.name=="LWIP_STATS_DISPLAY")]
			[#else]
				[#if definition.defaultValue != definition.value]
					[#if (definition.name=="NETMASK_ADDRESS") || (definition.name=="GATEWAY_ADDRESS") || (definition.name=="IP_ADDRESS") || (definition.name=="heth") || (definition.name=="gnetif") || (definition.name=="ipaddr") || (definition.name=="netmask") || (definition.name=="gw")]
					[#else]
					   [#if ((definition.name=="CHECKSUM_GEN_IP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_UDP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_TCP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_ICMP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_IP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_UDP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_TCP") && (definition.value == "1"))]
					   [#else]
/*----- Default Value for ${definition.name}: ${definition.defaultValue} -----*/
#define ${definition.name}   ${definition.value}
                       [/#if]                     
					[/#if]
				[#else]
					[#if (definition.name=="NO_SYS")]
/*----- Default Value for ${definition.name}: 0 -----*/ 
#define ${definition.name}   ${definition.value}		
					[/#if]
					[#if (definition.name=="WITH_RTOS")]
/*----- Default Value for ${definition.name}: 1 -----*/ 
						[#if lwip_rtos==1]
#define ${definition.name}   1
						[#else]
#define ${definition.name}   0
						[/#if]					
					[/#if]
					[#if (definition.name=="LWIP_NETCONN")]
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}	
					[/#if]
					[#if (definition.name=="LWIP_SOCKET")]
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
					[/#if]
					[#if (definition.name=="MEM_ALIGNMENT")] 
/*----- Default Value for ${definition.name}: 1 -----*/  
#define ${definition.name}  ${definition.value}
					[/#if]
					[#if (definition.name=="LWIP_DHCP")]						
/*----- Default Value for ${definition.name}: 0 -----*/  
#define ${definition.name}   ${definition.value}
					[/#if]		
                    [#if (definition.name=="LWIP_ETHERNET")]                     
/*----- Default Value for ${definition.name}:0 -----*/ 
#define ${definition.name}  ${definition.value}
                    [/#if]	
                    [#if (definition.name=="CHECKSUM_GEN_IP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]
                    [#if (definition.name=="CHECKSUM_GEN_UDP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]
                    [#if (definition.name=="CHECKSUM_GEN_TCP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]
                    [#if (definition.name=="CHECKSUM_GEN_ICMP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]
                    [#if (definition.name=="CHECKSUM_CHECK_IP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]
                    [#if (definition.name=="CHECKSUM_CHECK_UDP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]
                    [#if (definition.name=="CHECKSUM_CHECK_TCP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                    [/#if]                              							
				[/#if]	
			[/#if]				
		[#else]
			[#if definition.defaultValue != definition.value]
				[#if (definition.name=="NETMASK_ADDRESS") || (definition.name=="GATEWAY_ADDRESS") || (definition.name=="IP_ADDRESS") || (definition.name=="heth") || (definition.name=="gnetif") || (definition.name=="ipaddr") || (definition.name=="netmask") || (definition.name=="gw")]
				[#else]
                       [#if ((definition.name=="CHECKSUM_GEN_IP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_UDP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_TCP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_ICMP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_IP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_UDP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_TCP") && (definition.value == "1"))]
                       [#else]
/*----- Default Value for ${definition.name}: ${definition.defaultValue} -----*/
#define ${definition.name}   ${definition.value}
                       [/#if] 	
				[/#if]
			[#else]			
				[#if (definition.name=="NO_SYS")]
/*----- Default Value for ${definition.name}: 0 -----*/ 
#define ${definition.name}   ${definition.value}			
				[/#if]	
				[#if (definition.name=="WITH_RTOS")]
/*----- Default Value for ${definition.name}: 1 -----*/ 
						[#if lwip_rtos==1]
#define ${definition.name}   1
						[#else]
#define ${definition.name}   0
						[/#if]
				[/#if]
				[#if (definition.name=="LWIP_NETCONN")]
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}		
				[/#if]	
				[#if (definition.name=="LWIP_SOCKET")]
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}		
				[/#if]	
				[#if (definition.name=="MEM_ALIGNMENT")] 
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
				[/#if]					
			    [#if (definition.name=="LWIP_DHCP")]			    
/*----- Default Value for ${definition.name}: 0 -----*/  
#define ${definition.name}   ${definition.value}
				[/#if]	
                [#if (definition.name=="LWIP_ETHERNET")]            
/*----- Default Value for ${definition.name}: 0 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]		
                [#if (definition.name=="CHECKSUM_GEN_IP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="CHECKSUM_GEN_UDP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="CHECKSUM_GEN_TCP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="CHECKSUM_GEN_ICMP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="CHECKSUM_CHECK_IP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="CHECKSUM_CHECK_UDP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="CHECKSUM_CHECK_TCP") && (definition.value == "0")]            
/*----- Default Value for ${definition.name}: 1 -----*/ 
#define ${definition.name}   ${definition.value}
                [/#if]               				
			[/#if]
		[/#if]
	[/#list]
[/#if]
[/#list]
/*----- No Default Value for LWIP_PROVIDE_ERRNO -----*/
#define LWIP_PROVIDE_ERRNO  1

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /*__ ${inclusion_protection}_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
