[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : ${name}
  * Description        : This file overrides LwIP stack default configuration
  *                      done in opt.h file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */ 
 
[#assign s_ori = name]
[#assign s1 = s_ori?replace(".","__")]
[#assign s2 = s1?replace("Target/","")]
[#assign inclusion_protection = s2?upper_case]
/* Define to prevent recursive inclusion --------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#include "main.h"

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]

[#if SWIP.defines??]
    [#list SWIP.defines as definition]
       [#if definition.name == "LwIP Version"]
/*-----------------------------------------------------------------------------*/
/* Current version of LwIP supported by CubeMx: ${definition.value} -*/
/*-----------------------------------------------------------------------------*/

       [/#if]
    [/#list]
[/#if]

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
[/#if][#-- includes?? --]


[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if][#-- SWIP.variables?? --]
[#-- Global variables --]

[#-- Parameters visible with/wo RTOS with default value changing with/wo RTOS => avoid using default value --]
[#assign rtosNoMaskList = ["NO_SYS", "LWIP_NETCONN", "LWIP_SOCKET", "WITH_RTOS", "LWIP_NETIF_LOOPBACK_MULTITHREADING"]]
[#-- Parameters visible only if RTOS with default values changing >> avoid using default value --]
[#assign rtosMaskList = ["WITH_MBEDTLS", "TCPIP_MBOX_SIZE", "DEFAULT_UDP_RECVMBOX_SIZE", "DEFAULT_TCP_RECVMBOX_SIZE", "DEFAULT_ACCEPTMBOX_SIZE", "TCPIP_THREAD_STACKSIZE", "TCPIP_THREAD_PRIO", "SLIPIF_THREAD_STACKSIZE", "SLIPIF_THREAD_PRIO", "DEFAULT_THREAD_STACKSIZE", "DEFAULT_THREAD_PRIO",
                          "LWIP_SOCKET_SET_ERRNO", "LWIP_COMPAT_SOCKETS", "LWIP_POSIX_SOCKETS_IO_NAMES"]]
[#-- STATS Parameters are disabled in CubeMx (enable in opt.h) >> avoid using default value --]
[#assign statList = ["LINK_STATS", "ETHARP_STATS", "IP_STATS", "IPFRAG_STATS", "ICMP_STATS", "IGMP_STATS", "UDP_STATS", "TCP_STATS", "MEM_STATS", "MEMP_STATS", "SYS_STATS", 
                             "IP6_STATS", "ICMP6_STATS", "IP6_FRAG_STATS", "MLD6_STATS", "MIB2_STATS"]]
[#-- Special parameters LWIP_DNS_SECURE cannot consider default value (logical OR) >> avoid using default value --]
[#-- Special parameters LWIP_DHCP is enabled in CubeMx (disabled in opt.h) >> avoid using default value --]
[#-- Special parameters CHECKSUM_BY_HARDWARE should be excluded since it is generated in STM32CubeMX Specific Parameters section --]
[#-- Special parameters RECV_BUFSIZE_DEFAULT is defined with 0xFFFFFFF (INT_MAX in opt.h) >> generate always with freertos --]
[#-- Special parameters TCP_RCV_SCALE is not defined if LWIP_WND_SCALE is enabled (see opt.h) >> generate always --]
[#-- Special parameters LWIP_SUPPORT_CUSTOM_PBUF (for H7) >> generate only for h7 --]
[#-- Special parameters LWIP_RAM_HEAP_POINTER (for H7) >> generate only for h7 --]
[#-- Special parameters HTTPD_USE_CUSTOM_FSDATA >> limitation to force to 1 when HTTPD is used --]
[#assign specialList = ["LWIP_DNS_SECURE", "LWIP_DHCP", "CHECKSUM_BY_HARDWARE", "LWIP_NETIF_LINK_CALLBACK", "RECV_BUFSIZE_DEFAULT", "TCP_RCV_SCALE", "LWIP_SUPPORT_CUSTOM_PBUF", "LWIP_RAM_HEAP_POINTER", "LWIP_TCP", "HTTPD_USE_CUSTOM_FSDATA"]]

[#-- Checksum parameters enabled (in opt.h) and disabled in CubeMx --]
[#assign checksumList = ["CHECKSUM_GEN_IP", "CHECKSUM_GEN_UDP", "CHECKSUM_GEN_TCP", "CHECKSUM_GEN_ICMP", "CHECKSUM_GEN_ICMP6", "CHECKSUM_CHECK_IP", "CHECKSUM_CHECK_UDP", "CHECKSUM_CHECK_TCP", "CHECKSUM_CHECK_ICMP", "CHECKSUM_CHECK_ICMP6"]]

[#-- CubeMx internal parameters --]
[#assign nonStdList = ["PHY", "NETMASK_ADDRESS", "GATEWAY_ADDRESS", "IP_ADDRESS", "heth", "gnetif", "ipaddr", "netmask", "gw"]]

[#-- internal use only --]
[#assign series = FamilyName?lower_case]

[#-- Function to test if a parameter belong to a list of parameters --]
[#function isParamInList paramName paramList]
    [#assign used=false]
    [#list paramList as param]
        [#if param==paramName]
            [#assign used=true]
            [#return true]
        [/#if]
    [/#list]
    [#return used]
[/#function]

[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]
[#assign lwip_mbed = 0]
[#assign lwip_httpd = 0]
[#assign cmsis_version = "v1"]
[#assign newlib_used = 0]
	
[#if SWIP.defines??]
	[#list SWIP.defines as definition]
	    [#-- Following settings are necessary for parameters linked to other one(s) and listed hereafter --]
		[#if definition.name == "NO_SYS"] 
			[#if definition.value == "0"] 
			    [#assign lwip_rtos = 1]
			[#else]	
			    [#assign lwip_rtos = 0] 
			[/#if]
		[/#if]
		[#if definition.name == "RTOS_USE_NEWLIB_REENTRANT"] 
			[#if definition.value == "1"] 
			    [#assign newlib_used = 1]
			[#else]	
			    [#assign newlib_used = 0] 
			[/#if]
		[/#if]
		[#if definition.name == "LWIP_USE_EXTERNAL_MBEDTLS"] 
			[#if definition.value == "1"] 
			    [#assign lwip_mbed = 1]
			[/#if]
		[/#if]
		[#if definition.name == "LWIP_HTTPD"] 
			[#if definition.value == "1"] 
			    [#assign lwip_httpd = 1]
			[/#if]
		[/#if]	
		[#if definition.name == "LWIP_STATS"] [#assign lwip_stats = definition.value] [/#if]
		[#if definition.name == "LWIP_SO_RCVBUF"] [#assign lwip_so_rcvbuf = definition.value] [/#if]
		[#if definition.name == "MEMP_NUM_TCPIP_MSG_API"] [#assign memp_num_tcpip_msg_api = definition.value] [/#if]
        [#if definition.name == "MEMP_NUM_PPP_PCB"] [#assign memp_num_ppp_pcb = definition.value] [/#if]
        [#if definition.name == "ETH_PAD_SIZE"] [#assign eth_pad_size = definition.value] [/#if]
        [#if definition.name == "TCP_WND"] [#assign tcp_wnd = definition.value] [/#if]
        [#if definition.name == "TCP_SND_BUF"] [#assign tcp_snd_buf = definition.value] [/#if]
        [#if definition.name == "TCP_MSS"] [#assign tcp_mss = definition.value] [/#if]        
		[#if definition.name == "IP_DEFAULT_TTL"] [#assign ip_default_ttl = definition.value] [/#if]
        [#if definition.name == "LWIP_TCP"] [#assign lwip_tcp = definition.value] [/#if]
        [#if definition.name == "LWIP_NETIF_LOOPBACK"]  [#assign lwip_netif_loopback = definition.value] [/#if]
        [#if definition.name == "PPP_SUPPORT"] [#assign ppp_support = definition.value] [/#if]
        [#if definition.name == "PPPOL2TP_SUPPORT"]  [#assign pppol2tp_support = definition.value] [/#if]
        [#if definition.name == "CHAP_SUPPORT"] [#assign chap_support = definition.value] [/#if]
        [#if definition.name == "EAP_SUPPORT"] [#assign eap_support = definition.value] [/#if]       
        [#if definition.name == "PPPOL2TP_AUTH_SUPPORT"] [#assign pppol2tp_auth_support = definition.value] [/#if]
        [#if definition.name == "LWIP_HAVE_SLIPIF"] [#assign lwip_have_slipif = definition.value] [/#if]       
        [#if definition.name == "LWIP_IPV6"] [#assign lwip_ipv6 = definition.value] [/#if]
        [#if definition.name == "LWIP_ICMP"] [#assign lwip_icmp = definition.value] [/#if]
        [#if definition.name == "LWIP_ICMP6"][#assign lwip_icmp6 = definition.value] [/#if]
        [#if definition.name == "LWIP_ARP"] [#assign lwip_arp = definition.value] [/#if]
        [#if definition.name == "IP_REASSEMBLY"] [#assign ip_reassembly = definition.value] [/#if]
        [#if definition.name == "IP_FRAG"] [#assign ip_frag = definition.value] [/#if]
        [#if definition.name == "LWIP_IGMP"] [#assign lwip_igmp = definition.value] [/#if]
        [#if definition.name == "LWIP_UDP"] [#assign lwip_udp = definition.value] [/#if]
        [#if definition.name == "MEMP_MEM_MALLOC"] [#assign memp_mem_malloc = definition.value] [/#if]
        [#if definition.name == "MEM_LIBC_MALLOC"] [#assign mem_libc_malloc = definition.value] [/#if]
        [#if definition.name == "MEM_USE_POOLS"] [#assign mem_use_pools = definition.value] [/#if]
        [#if definition.name == "LWIP_IPV6_FRAG"] [#assign lwip_ipv6_frag = definition.value] [/#if]
        [#if definition.name == "LWIP_IPV6_REASS"] [#assign lwip_ipv6_reass = definition.value] [/#if]
        [#if definition.name == "LWIP_IPV6_MLD"] [#assign lwip_ipv6_mld = definition.value] [/#if]
        [#if definition.name == "CHECKSUM_BY_HARDWARE"] [#assign checksum_by_hw = definition.value] [/#if]
        [#if definition.name == "LWIP_IPV4"] [#assign lwip_ipv4 = definition.value] [/#if]
        [#if definition.name == "LWIP_SNMP"] [#assign lwip_snmp = definition.value] [/#if]
        [#if definition.name == "LWIP_WND_SCALE"] [#assign lwip_wnd_scale = definition.value] [/#if]
        [#if definition.name == "LWIP_SOCKET"] [#assign lwip_socket = definition.value] [/#if]
        [#if (definition.name == "CMSIS_VERSION")]
                [#if definition.value == "0"]
                    [#assign cmsis_version = "v1"]
                [/#if]
                [#if definition.value == "1"]
                    [#assign cmsis_version = "v2"]
                [/#if]
        [/#if][#-- CMSIS_VERSION --]
	[/#list]

[#compress]

/* STM32CubeMX Specific Parameters (not defined in opt.h) ---------------------*/
/* Parameters set in STM32CubeMX LwIP Configuration GUI -*/
	[#list SWIP.defines as definition]
       [#if definition.name == "WITH_RTOS"]
           [#if lwip_rtos == 1]
/*----- ${definition.name} enabled (Since FREERTOS is set) -----*/
#define ${definition.name}   1
               [#if GCC_USED?? && (newlib_used == 1)]
/* Temporary workaround to avoid conflict on errno defined in STM32CubeIDE and lwip sys_arch.c errno */               
#undef LWIP_PROVIDE_ERRNO
               [/#if]
           [#else]
/*----- ${definition.name} disabled (Since FREERTOS is not set) -----*/
#define ${definition.name}   0
           [/#if]
       [/#if]
       [#if definition.name == "WITH_MBEDTLS"]
           [#if lwip_mbed == 1]
/*----- ${definition.name} enabled (Since MBEDTLS and FREERTOS are set) -----*/
#define ${definition.name}   1
           [/#if]
       [/#if]       
       [#if definition.name == "CHECKSUM_BY_HARDWARE"]
           [#if checksum_by_hw == "1"]
/*----- ${definition.name} enabled -----*/
#define ${definition.name}   1
           [#else]
/*----- ${definition.name} disabled -----*/
#define ${definition.name}   0
           [/#if]
       [/#if]
	[/#list]
[/#compress]

/*-----------------------------------------------------------------------------*/


[#if lwip_so_rcvbuf == "1"]
/* LWIP_SO_RCVBUF is enabled => this requires INT_MAX definition in limits.h --*/
#include "limits.h"
[/#if]
 

/* LwIP Stack Parameters (modified compared to initialization value in opt.h) -*/
/* Parameters set in STM32CubeMX LwIP Configuration GUI -*/
[#compress]	
	[#list SWIP.defines as definition]
		[#if (definition.defaultValue != definition.value) && (definition.value != "valueNotSetted") && !isParamInList(definition.name nonStdList) && !isParamInList(definition.name checksumList) && !isParamInList(definition.name rtosNoMaskList) 
		    && !isParamInList(definition.name rtosMaskList) && !isParamInList(definition.name statList) && !isParamInList(definition.name specialList)]
		    [#-- In all cases where value is not the one in opt.h >> generate #define --]  
/*----- Default Value for ${definition.name}: ${definition.defaultValue} ---*/
#define ${definition.name}  ${definition.value}
		[#else]
		    [#-- Case1 where default value equals user value but #define generation is forced since the setting is different than in opt.h--]
		    [#-- Case2 where param1 = param2 by default, user change param2 and modify after param1 to keep default value => generate it in this case --]
			[#if (definition.name=="LWIP_ETHERNET")][#-- LWIP_ETHERNET is systematically generated since LWIP cannot be enabled wo ETH --]
/*----- Value in opt.h for ${definition.name}: LWIP_ARP || PPPOE_SUPPORT -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_DHCP") && (definition.value == "1")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]     
            [#if (definition.name=="LWIP_TCP") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_NETIF_LINK_CALLBACK") && (definition.value == "1")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if lwip_httpd == 1]
                [#if (definition.name=="HTTPD_USE_CUSTOM_FSDATA") && (definition.value == "1")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
            [/#if]
			[#if (definition.name=="NO_SYS") && (definition.value !="0")]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]
			[#if (definition.name=="SYS_LIGHTWEIGHT_PROT") && (definition.value =="0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]									
			[#if (definition.name=="MEM_ALIGNMENT") && (definition.value !="1")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="MEMP_NUM_SYS_TIMEOUT") && (definition.value != "valueNotSetted") && (definition.value == "5")]
/*----- Value in opt.h for ${definition.name}: (LWIP_TCP + IP_REASSEMBLY + LWIP_ARP + (2*LWIP_DHCP) + LWIP_AUTOIP + LWIP_IGMP + LWIP_DNS + (PPP_SUPPORT*6*MEMP_NUM_PPP_PCB) + (LWIP_IPV6 ? (1 + LWIP_IPV6_REASS + LWIP_IPV6_MLD) : 0)) -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="MEMP_NUM_PPPOS_INTERFACES") && (definition.value != "valueNotSetted") && (definition.value != memp_num_ppp_pcb)]
/*----- Value in opt.h for ${definition.name}: MEMP_NUM_PPP_PCB -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="MEMP_NUM_API_MSG") || (definition.name=="MEMP_NUM_DNS_API_MSG") || (definition.name=="MEMP_NUM_SOCKET_SETGETSOCKOPT_DATA") || (definition.name=="MEMP_NUM_NETIFAPI_MSG")] 
                [#if (definition.value != memp_num_tcpip_msg_api) && (definition.value != "valueNotSetted")]
/*----- Value in opt.h for ${definition.name}: MEMP_NUM_TCPIP_MSG_API -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
            [/#if]
            [#if (definition.name=="PBUF_LINK_HLEN") && (definition.value == "14") && (definition.value != "valueNotSetted") && (eth_pad_size != "0")]
/*----- Value in opt.h for ${definition.name}: 14+ETH_PAD_SIZE -----*/
#define ${definition.name}  ${definition.value}
            [/#if]            
            [#if (definition.name=="LWIP_NETCONN") && (definition.value != "valueNotSetted") && (definition.value !="1")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_SOCKET") && (definition.value != "valueNotSetted") && (definition.value !="1")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]          
            [#if (definition.name=="LWIP_MULTICAST_TX_OPTIONS") && (definition.value != "valueNotSetted") && (definition.value != lwip_igmp)]
/*----- Value in opt.h for ${definition.name}: LWIP_IGMP -----*/
#define ${definition.name}  ${definition.value}
            [/#if]	
            [#if ((definition.name=="ICMP_TTL")||(definition.name=="RAW_TTL")||(definition.name=="UDP_TTL")||(definition.name=="TCP_TTL")) && (definition.value != ip_default_ttl) && (definition.value != "valueNotSetted")]
/*----- Value in opt.h for ${definition.name}: IP_DEFAULT_TTL -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_DNS_SECURE") && (definition.value != "valueNotSetted")][#-- Generate always this param --]
/*----- Value in opt.h for ${definition.name}: (LWIP_DNS_SECURE_RAND_XID | LWIP_DNS_SECURE_NO_MULTIPLE_OUTSTANDING | LWIP_DNS_SECURE_RAND_SRC_PORT) -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_DNS") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "0")][#-- Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_USE_EXTERNAL_MBEDTLS") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "0")][#-- Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_WND") && (definition.value != "valueNotSetted") && (definition.value == "2144") && (tcp_mss != "536")]
/*----- Value in opt.h for ${definition.name}: 4 * TCP_MSS -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_QUEUE_OOSEQ") && (definition.value != "valueNotSetted") && (definition.value != lwip_tcp)]
/*----- Value in opt.h for ${definition.name}: LWIP_TCP -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_SND_BUF") && (definition.value != "valueNotSetted") && (definition.value == "1072") && (tcp_mss != "536")]
/*----- Value in opt.h for ${definition.name}: 2 * TCP_MSS -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_SND_QUEUELEN") && (definition.value != "valueNotSetted") && (definition.value == "9")]
/*----- Value in opt.h for ${definition.name}: (4*TCP_SND_BUF + (TCP_MSS - 1))/TCP_MSS -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_SNDLOWAT") && (definition.value != "valueNotSetted") && (definition.value == "1071")]
/*----- Value in opt.h for ${definition.name}: LWIP_MIN(LWIP_MAX(((TCP_SND_BUF)/2), (2 * TCP_MSS) + 1), (TCP_SND_BUF) - 1) -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_SNDQUEUELOWAT") && (definition.value != "valueNotSetted") && (definition.value == "5")]
/*----- Value in opt.h for ${definition.name}: LWIP_MAX(TCP_SND_QUEUELEN)/2, 5) -*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_WND_UPDATE_THRESHOLD") && (definition.value != "valueNotSetted") && (definition.value == "536")]
/*----- Value in opt.h for ${definition.name}: LWIP_MIN(TCP_WND/4, TCP_MSS*4) -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCP_RCV_SCALE") && (lwip_wnd_scale == "1")]
/*----- Value in opt.h for ${definition.name}: undefined if LWIP_WND_SCALE is defined -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_NETIF_LOOPBACK_MULTITHREADING") && (definition.value != "valueNotSetted") && (((definition.value == "0") && (lwip_rtos == 1)) || ((definition.value == "1") && (lwip_rtos == 0)))]
/*----- Value in opt.h for ${definition.name}: !NO_SYS -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_HAVE_LOOPIF") && (definition.value != "valueNotSetted") && (definition.value != lwip_netif_loopback)]
/*----- Value in opt.h for ${definition.name}: LWIP_NETIF_LOOPBACK -----*/
#define ${definition.name}  ${definition.value}
            [/#if]           
            [#if (definition.name=="PPPOL2TP_AUTH_SUPPORT") && (definition.value != "valueNotSetted") && (definition.value != pppol2tp_support)]
/*----- Value in opt.h for ${definition.name}: PPPOL2TP_SUPPORT -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="PPPOS_SUPPORT") && (definition.value != "valueNotSetted") && (definition.value != ppp_support)]
/*----- Value in opt.h for ${definition.name}: PPP_SUPPORT -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_PPP_API") && (definition.value != "valueNotSetted") && (definition.value == "0") && (ppp_support == "1") && (lwip_rtos == 1)][#-- Parameters with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: (PPP_SUPPORT && !NO_SYS) -----*/
#define ${definition.name}  ${definition.value}
            [/#if]             
            [#if (definition.name=="PPP_IPV4_SUPPORT") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv4)][#-- Parameter with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV4 -----*/ 
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="PPP_IPV6_SUPPORT") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv6)][#-- Parameter with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV6 -----*/ 
#define ${definition.name}  ${definition.value}
            [/#if]            
            [#if (definition.name=="PPP_MD5_RANDM") && (definition.value != "valueNotSetted") && (definition.value == "0") && ((chap_support == "1") || (eap_support == "1") || (pppol2tp_auth_support == "1"))]
/*----- Value in opt.h for ${definition.name}: (CHAP_SUPPORT || EAP_SUPPORT || PPPOL2TP_AUTH_SUPPORT) -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_ICMP6") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv6)]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV6 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_IPV6_MLD") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv6)]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV6 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_IPV6_REASS") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv6)]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV6 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_ND6_QUEUEING") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv6)]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV6 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_IPV6_AUTOCONFIG") && (definition.value != "valueNotSetted") && (definition.value != lwip_ipv6)]
/*----- Value in opt.h for ${definition.name}: LWIP_IPV6 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
			[#if (definition.name=="DEFAULT_UDP_RECVMBOX_SIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value !="0")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]
			[#if (definition.name=="DEFAULT_TCP_RECVMBOX_SIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value !="0")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]
			[#if (definition.name=="DEFAULT_ACCEPTMBOX_SIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value !="0")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]	             
            [#if (definition.name=="RECV_BUFSIZE_DEFAULT") && (definition.value != "valueNotSetted")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: INT_MAX -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
			[#if (definition.name=="TCPIP_MBOX_SIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value !="0")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
			[/#if]
            [#if (definition.name=="TCPIP_THREAD_STACKSIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "0")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="TCPIP_THREAD_PRIO")  && (definition.value != "valueNotSetted") && (lwip_rtos == 1)][#-- rtosMaskList Param visible if freertos --]
            /*----- Value in opt.h for ${definition.name}: 1 -----*/
            [#if cmsis_version = "v1"]
                [#if definition.value = "0"]
#define ${definition.name}  osPriorityIdle
                [/#if]
                [#if definition.value = "1"]
#define ${definition.name}  osPriorityLow
                [/#if]
                [#if definition.value = "2"]
#define ${definition.name}  osPriorityBelowNormal
                [/#if]
                [#if definition.value = "3"]
#define ${definition.name}  osPriorityNormal
                [/#if]
                [#if definition.value = "4"]
#define ${definition.name}  osPriorityAboveNormal
                [/#if]
                [#if definition.value = "5"]
#define ${definition.name}  osPriorityHigh
                [/#if]
                [#if definition.value = "6"]
#define ${definition.name}  osPriorityRealtime
                [/#if]
            [#else]
                [#if definition.value != "1"]
#define ${definition.name}  ${definition.value}
                [/#if]
            [/#if]
            [/#if]                 
            [#if (definition.name=="SLIPIF_THREAD_STACKSIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "0")][#-- rtosMaskList Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="SLIPIF_THREAD_PRIO") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "1")][#-- rtosMaskList Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="DEFAULT_THREAD_STACKSIZE") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "0")][#-- rtosMaskList Param visible if freertos --]
/*----- Value in opt.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]             
            [#if (definition.name=="DEFAULT_THREAD_PRIO") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "1")][#-- rtosMaskList Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_SOCKET_SET_ERRNO") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "1")][#-- rtosMaskList Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_COMPAT_SOCKETS") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "1")][#-- rtosMaskList Param visible if freertos, with default value changing on certain condition --]        
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]            
            [#if (definition.name=="LWIP_POSIX_SOCKETS_IO_NAMES") && (definition.value != "valueNotSetted") && (lwip_rtos == 1) && (definition.value != "1")][#-- rtosMaskList Param visible if freertos, with default value changing on certain condition --]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="LWIP_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0")][#-- Case1: Parameter with default value in MX different than in opt.h--]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="SNMP_LWIP_MIB2") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_snmp == "1")][#-- Case2 --]
/*----- Value in snmp_opts.h for ${definition.name}: 0 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]                          
            [#if lwip_stats == "1"][#-- Parameters with default value changing on certain condition --]
                [#if (definition.name=="LINK_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 0 or 1 -*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="ETHARP_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_arp == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_ARP -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="IP_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 0 or 1 -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="IPFRAG_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && ((ip_reassembly == "1") || (ip_frag == "1"))]
/*----- Value in opt.h for ${definition.name}: 0 or (IP_REASSEMBLY || IP_FRAG) -*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="ICMP_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_icmp == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_ICMP -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="IGMP_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_igmp == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_IGMP -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="UDP_STATS") && (definition.value != "valueNotSetted")&& (definition.value == "0") && (lwip_udp == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_UDP -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="TCP_STATS")  && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_tcp == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_TCP -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="MEM_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (mem_libc_malloc == "0") && (mem_use_pools == "0")]
/*----- Value in opt.h for ${definition.name}: 0 or (!MEM_LIBC_MALLOC && !MEM_USE_POOLS) -*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="MEMP_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (memp_mem_malloc == "0")]
/*----- Value in opt.h for ${definition.name}: 0 or !MEMP_MEM_MALLOC -*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="SYS_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_rtos == 1)]
/*----- Value in opt.h for ${definition.name}: 0 or !NO_SYS -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="IP6_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_ipv6 == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_IPV6 -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="ICMP6_STATS") && (definition.value != "valueNotSetted")  && (definition.value == "0") && (lwip_ipv6 == "1") && (lwip_icmp6 == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or (LWIP_IPV6 && LWIP_ICMP6) -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="IP6_FRAG_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && ((lwip_ipv6 == "1") && ((lwip_ipv6_reass == "1") || (lwip_ipv6_frag == "1")))]
/*----- Value in opt.h for ${definition.name}: 0 or (LWIP_IPV6_FRAG || LWIP_IPV6_REASS) -*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="MLD6_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_ipv6 == "1") && (lwip_ipv6_mld == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or (LWIP_IPV6 && LWIP_IPV6_MLD) -----*/
#define ${definition.name}  ${definition.value}
                [/#if]
                [#if (definition.name=="ND6_STATS") && (definition.value != "valueNotSetted") && (definition.value == "0") && (lwip_ipv6 == "1")]
/*----- Value in opt.h for ${definition.name}: 0 or LWIP_IPV6 -----*/
#define ${definition.name}  ${definition.value}
                [/#if]      
                [#if (definition.name=="MIB2_STATS") && (definition.value != "valueNotSetted")]
/*----- Value in opt.h for ${definition.name}: 0 or SNMP_LWIP_MIB2 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [/#if][#-- End STAT* parameters --] 
            [#if (definition.name=="CHECKSUM_GEN_IP") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_UDP") && (definition.value != "valueNotSetted")  && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_TCP") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_ICMP") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_GEN_ICMP6") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_IP") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_UDP") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_TCP") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}  ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_ICMP") && (definition.value != "valueNotSetted")  && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (definition.name=="CHECKSUM_CHECK_ICMP6") && (definition.value != "valueNotSetted") && (definition.value == "0")]
/*----- Value in opt.h for ${definition.name}: 1 -----*/
#define ${definition.name}   ${definition.value}
            [/#if]
            [#if (series == "stm32h7")]
                [#if (definition.name=="LWIP_SUPPORT_CUSTOM_PBUF") && (definition.value != "valueNotSetted") && (definition.value == "1")]
/*----- Value supported for H7 devices: 1 -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.name=="LWIP_RAM_HEAP_POINTER") && (definition.value != "valueNotSetted")]
/*----- Default Value for H7 devices: 0x30044000 -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
                [#if (definition.value != "valueNotSetted") && (definition.name=="ETH_RX_BUFFER_SIZE")]
/*----- Default value in ETH configuration GUI in CubeMx: 1524 -----*/
#define ${definition.name}   ${definition.value}
                [/#if]
            [/#if][#-- stm32f4 --]
		[/#if][#-- definition.defaultValue --]
	[/#list][#-- SWIP.defines line 108 --]
/*-----------------------------------------------------------------------------*/
[/#compress]	
[/#if][#-- SWIP.defines?? --]
[/#list][#-- SWIPdatas --]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /*__${inclusion_protection}__ */
