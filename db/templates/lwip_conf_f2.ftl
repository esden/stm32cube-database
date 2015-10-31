[#ftl]

/**
  ******************************************************************************
  * File Name          : ${name}
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
/* Define to prevent recursive inclusion --------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#include "stm32f2xx_hal.h"

/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#ifdef __cplusplus
 extern "C" {
#endif

[#if includes??]
/* Includes -------------------------------------------------------------------*/
[#list includes as include]
#include "${include}"
[/#list]
[/#if] [#-- includes?? --]


[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]  
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if] [#-- SWIP.variables?? --]
[#-- Global variables --]

[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]
	
[#if SWIP.defines??]
	[#assign lwip_stats = 0]
	[#assign lwip_rtos = 0]	
	[#assign lwip_so_rcvbuf = 0]
	[#assign eth_pad_size = 0]
	[#assign tcp_wnd = 0]
	[#assign tcp_snd_buf = 0]
	[#assign ip_default_ttl = 0]
	[#assign lwip_tcp = 0]
	[#assign ppp_support = 0]
	[#assign checksum_by_hw = 0]
	[#list SWIP.defines as definition]
		[#if definition.name == "LWIP_STATS"]
            [#if definition.value == "1"]
                [#assign lwip_stats = 1]
            [/#if]
        [/#if] [#-- definition.name == "LWIP_STATS" --]
		[#if definition.name == "NO_SYS"]
			[#if definition.value == "0"]
				[#assign lwip_rtos = 1]
			[/#if]			
		[/#if] [#-- definition.name == "NO_SYS" --]
		[#if definition.name == "LWIP_SO_RCVBUF"]
			[#if definition.value == "1"]
				[#assign lwip_so_rcvbuf = 1]
			[/#if]  			
		[/#if] [#-- definition.name == "LWIP_SO_RCVBUF" --]
        [#if definition.name == "ETH_PAD_SIZE"]
            [#assign eth_pad_size = definition.value]
        [/#if] [#-- definition.name == "ETH_PAD_SIZE" --]
        [#if definition.name == "TCP_WND"]
            [#assign tcp_wnd = definition.value]
        [/#if] [#-- definition.name == "TCP_WND" --]
        [#if definition.name == "TCP_SND_BUF"]
            [#assign tcp_snd_buf = definition.value]
        [/#if] [#-- definition.name == "TCP_SND_BUF" --]
		[#if definition.name == "IP_DEFAULT_TTL"]
            [#assign ip_default_ttl = definition.value]
        [/#if] [#-- definition.name == "IP_DEFAULT_TTL" --]
        [#if definition.name == "LWIP_TCP"]
            [#assign lwip_tcp = definition.value]
        [/#if] [#-- definition.name == "LWIP_TCP" --]
        [#if definition.name == "PPP_SUPPORT"]
            [#assign ppp_support = definition.value]
        [/#if] [#-- definition.name == "PPP_SUPPORT" --]
        [#if definition.name == "LWIP_HAVE_SLIPIF"]
            [#assign lwip_have_slipif = definition.value]
        [/#if] [#-- definition.name == "LWIP_HAVE_SLIPIF" --]        
        [#if definition.name == "CHECKSUM_BY_HARDWARE"]
            [#if definition.value == "1"]
                [#assign checksum_by_hw = 1]
            [/#if]
        [/#if] [#-- definition.name == "CHECKSUM_BY_HARDWARE" --]
	[/#list] [#-- SWIP.defines line 81 --]
	
[#compress]
/* STM32CubeMX Specific Parameters (not defined in opt.h) ---------------------*/
/* Parameters set in STM32CubeMX LwIP Configuration GUI -*/
	[#list SWIP.defines as definition]
       [#if definition.name == "WITH_RTOS"]
           [#if lwip_rtos==1]
/*----- ${definition.name} enabled (Since FREERTOS is set) -----*/
#define ${definition.name}   1
           [#else]
/*----- ${definition.name} disabled (Since FREERTOS is not set) -----*/
#define ${definition.name}   0
           [/#if]
       [/#if]
       [#if definition.name == "CHECKSUM_BY_HARDWARE"]
           [#if checksum_by_hw == 1]
/*----- ${definition.name} enabled -----*/
#define ${definition.name}   1
           [#else]
/*----- ${definition.name} disabled -----*/
#define ${definition.name}   0
           [/#if]
       [/#if]
	[/#list] [#-- SWIP.defines line 113 --]
[/#compress]

/*-----------------------------------------------------------------------------*/


	[#if lwip_so_rcvbuf == 1]
/* LWIP_SO_RCVBUF is enabled => this requires INT_MAX definition in limits.h --*/
#include "limits.h"
	[/#if]

/* LwIP Stack Parameters (modified compared to initialization value in opt.h) -*/
/* Parameters set in STM32CubeMX LwIP Configuration GUI -*/
[#compress]	
	[#list SWIP.defines as definition]
		[#if definition.defaultValue != definition.value]
			[#if (definition.name=="NETMASK_ADDRESS") || (definition.name=="GATEWAY_ADDRESS") || (definition.name=="IP_ADDRESS") || (definition.name=="heth") || (definition.name=="gnetif") || (definition.name=="ipaddr") || (definition.name=="netmask") || (definition.name=="gw")]
               [#-- NETMASK_ADDRESS, GATEWAY_ADDRESS and IP_ADDRESS have a default value (0.0.0.0) that user cannot set >> #define will never be generated  --]			
			[#else]
		        [#if ((definition.name=="CHECKSUM_GEN_IP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_UDP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_TCP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_GEN_ICMP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_IP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_UDP") && (definition.value == "1")) || ((definition.name=="CHECKSUM_CHECK_TCP") && (definition.value == "1"))]
		        [#-- Checksum parameters are set to 1 in opt.h and to 0 by default in Cube >> If user set checksum parameter(s) to 1, no need to generate a #define --]
		        [#else]
		            [#if (lwip_stats==0) && ((definition.name=="LWIP_STATS_DISPLAY") || (definition.name=="LINK_STATS") || (definition.name=="ETHARP_STATS") || (definition.name=="IP_STATS") || (definition.name=="IPFRAG_STATS") || (definition.name=="ICMP_STATS") || (definition.name=="IGMP_STATS") || (definition.name=="UDP_STATS") || (definition.name=="TCP_STATS") || (definition.name=="MEM_STATS") || (definition.name=="MEMP_STATS") || (definition.name=="SYS_STATS"))]
	                [#-- No need to generate stat parameters when LWIP_STATS is not enabled since value will be ignored --]	        
		            [#else]
		            [#-- In all other cases where value is not the one in opt.h >> generate #define --]
		                [#if (definition.name != "CHECKSUM_BY_HARDWARE")]
		                    [#if (lwip_rtos == 0) && ((definition.name == "TCPIP_THREAD_NAME") || (definition.name == "TCPIP_THREAD_STACKSIZE") || (definition.name == "TCPIP_THREAD_PRIO") || (definition.name == "TCPIP_MBOX_SIZE") || (definition.name == "SLIPIF_THREAD_NAME") || (definition.name == "SLIPIF_THREAD_STACKSIZE") || (definition.name == "SLIPIF_THREAD_PRIO") || (definition.name == "PPP_THREAD_NAME") || (definition.name == "PPP_THREAD_STACKSIZE") || (definition.name == "PPP_THREAD_PRIO") || (definition.name == "DEFAULT_THREAD_NAME") || (definition.name == "DEFAULT_THREAD_STACKSIZE") || (definition.name == "DEFAULT_THREAD_PRIO") || (definition.name == "DEFAULT_RAW_RECVMBOX_SIZE") || (definition.name == "DEFAULT_UDP_RECVMBOX_SIZE") || (definition.name == "DEFAULT_TCP_RECVMBOX_SIZE") || (definition.name == "DEFAULT_ACCEPTMBOX_SIZE"))]
		                    [#-- Do not generate Thread parameters modified by user, if RTOS is disabled --]
		                    [#else]  
/*----- Default Value for ${definition.name}: ${definition.defaultValue} -*/
#define ${definition.name}   ${definition.value}
                            [/#if]
                        [/#if]
                    [/#if]
                [/#if]
		    [/#if]
		[#else]
		    [#-- Case where default value equals user value but #define generation is forced since the setting is different than in opt.h--]
			[#if (definition.name=="NO_SYS")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}   ${definition.value}
			[/#if]
            [#if (definition.name=="LWIP_NETCONN")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_SOCKET")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
			[#if (definition.name=="MEM_ALIGNMENT")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]
			[#if (definition.name=="TCPIP_THREAD_STACKSIZE") && (lwip_rtos == 1)]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="SLIPIF_THREAD_STACKSIZE") && (lwip_rtos == 1) && (lwip_have_slipif == "1")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="PPP_THREAD_STACKSIZE") && (lwip_rtos == 1) && (ppp_support == "1")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if] 
            [#if (definition.name=="DEFAULT_THREAD_STACKSIZE") && (lwip_rtos == 1)]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]      
            [#if (definition.name=="TCPIP_THREAD_PRIO") && (lwip_rtos == 1)]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="SLIPIF_THREAD_PRIO") && (lwip_rtos == 1) && (lwip_have_slipif == "1")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="PPP_THREAD_PRIO") && (lwip_rtos == 1) && (ppp_support == "1")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="DEFAULT_THREAD_PRIO") && (lwip_rtos == 1)]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]                                    
			[#if (definition.name=="LWIP_DHCP")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}   ${definition.value}
			[/#if]
            [#if (definition.name=="LWIP_ETHERNET")]
[#-- LWIP_ETHERNET is systematically generated since LWIP cannot be enabled wo ETH --]
/*----- Value in opt.h for ${definition.name}: (LWIP_ARP || PPPOE_SUPPORT) -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="MEMP_NUM_SYS_TIMEOUT") && (definition.value == "5")]
/*----- Value in opt.h for ${definition.name}: (LWIP_TCP + IP_REASSEMBLY + LWIP_ARP + (2*LWIP_DHCP) + LWIP_AUTOIP + LWIP_IGMP + LWIP_DNS + PPP_SUPPORT) -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_QUEUE_OOSEQ") && (definition.value != lwip_tcp)]
/*----- Value in opt.h for ${definition.name}: (LWIP_TCP) -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_SNDLOWAT") && (definition.value == "1071") && (tcp_snd_buf != "1072")]
/*----- Value in opt.h for ${definition.name}: (LWIP_MIN(LWIP_MAX(((TCP_SND_BUF)/2), (2 * TCP_MSS) + 1), (TCP_SND_BUF) - 1)) -*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_WND_UPDATE_THRESHOLD") && (definition.value == "536") && (tcp_wnd != "2144")]
/*----- Value in opt.h for ${definition.name}: (TCP_WND/4) -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="PBUF_LINK_HLEN") && (definition.value == "14") && (eth_pad_size != "0")]
/*----- Value in opt.h for ${definition.name}: (14+ETH_PAD_SIZE) -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="PPPOS_SUPPORT") && (definition.value != ppp_support)]
/*----- Value in opt.h for ${definition.name}: (PPP_SUPPORT) -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_IP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_UDP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_TCP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_ICMP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_IP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_UDP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_TCP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if ((definition.name=="ICMP_TTL")||(definition.name=="RAW_TTL")||(definition.name=="UDP_TTL")||(definition.name=="TCP_TTL")) && (definition.value != ip_default_ttl)]
/*----- Value in opt.h for ${definition.name}: (IP_DEFAULT_TTL) -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_STATS") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if lwip_stats == 1]
                [#if definition.name=="ETHARP_STATS"]
/*----- Value in opt.h for ${definition.name}: (LWIP_ARP) -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if definition.name=="IPFRAG_STATS"]
/*----- Value in opt.h for ${definition.name}: (IP_REASSEMBLY || IP_FRAG) -*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if definition.name=="IGMP_STATS"]
/*----- Value in opt.h for ${definition.name}: (LWIP_IGMP) -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if definition.name=="UDP_STATS"]
/*----- Value in opt.h for ${definition.name}: (LWIP_UDP) -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if definition.name=="TCP_STATS"]
/*----- Value in opt.h for ${definition.name}: (LWIP_TCP) -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if definition.name=="MEMP_STATS"]
/*----- Value in opt.h for ${definition.name}: (!MEMP_MEM_MALLOC) -*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if definition.name=="MEM_STATS"]
/*----- Value in opt.h for ${definition.name}: ((!MEM_LIBC_MALLOC) && (!MEM_USE_POOLS)) -*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if lwip_rtos == 1]
                    [#if (definition.name=="SYS_STATS") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: (!NO_SYS) -----*/
#define ${definition.name}   ${definition.value}
                    [/#if]
                [/#if]   
            [/#if]          
		[/#if] [#-- definition.defaultValue --]
	[/#list] [#-- SWIP.defines line 108 --]
/*-----------------------------------------------------------------------------*/
[/#compress]	
[/#if] [#-- SWIP.defines?? --]
[/#list] [#-- SWIPdatas --]
/* Parameter(s) not set in STM32CubeMX LwIP Configuration GUI -*/
/* LwIP Parameter(s) not in opt.h -----------------------------*/
#define LWIP_PROVIDE_ERRNO  1

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /*__ ${inclusion_protection}_H */

/************************* (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
