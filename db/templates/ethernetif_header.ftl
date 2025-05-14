[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ethernetif.h
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
  
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#assign use_rtos = 0]
[#assign cmsis_version = "n/a"]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]	 	
		[#if (definition.name == "NO_SYS")]
			[#if definition.value == "0"]
				[#assign use_rtos = 1]
			[/#if]
		[/#if]
		[#if (definition.name == "WITH_RTOS")]
			[#if definition.value == "1"]
				[#assign with_rtos = 1]
			[/#if][#-- "1" --]
		[/#if][#-- WITH_RTOS --]
		[#if (definition.name == "CMSIS_VERSION") && (use_rtos == 1)]
			[#if definition.value == "0"]
				[#assign cmsis_version = "v1"]
			[/#if]
			[#if definition.value == "1"]
				[#assign cmsis_version = "v2"]
			[/#if]
		[/#if][#-- CMSIS_VERSION --]
	[/#list]
[/#if]
[/#list]
[#assign series = FamilyName?lower_case]
[#if (series != "stm32h7rs")]
#ifndef __ETHERNETIF_H__
#define __ETHERNETIF_H__
[#else]
#ifndef __ETHERNETIF_H
#define __ETHERNETIF_H
[/#if]
#include "lwip/err.h"
[#if ((series != "stm32h7rs") || ((series == "stm32h7rs") && (use_rtos == 0)))]
#include "lwip/netif.h"
[/#if]
[#if ((series == "stm32h7rs") && (use_rtos == 1))]
#include "lwip/netifapi.h"
[/#if]
[#if use_rtos == 1][#-- rtos used --]
[#if series != "stm32h7rs"]
#include "cmsis_os.h"
[#else]
#include "cmsis_os2.h"
[/#if]

[#if (series != "stm32h7") && (series != "stm32f7") && (series != "stm32f4") && (series != "stm32h7rs")][#-- series NOT stm32h7/f7/f4/h7rs --]
/* Exported types ------------------------------------------------------------*/
/* Structure that include link thread parameters */
struct link_str {
  struct netif *netif;
  osSemaphoreId semaphore;
};
[/#if][#-- endif series --]
[/#if][#-- endif use_rtos --]

/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Exported functions ------------------------------------------------------- */
err_t ethernetif_init(struct netif *netif);

[#if use_rtos == 1][#-- rtos used --]
[#if cmsis_version = "v2"][#-- cmsis_version v2 --]
void ethernetif_input(void* argument);
[/#if][#-- endif cmsis_version v2 --]
[#else][#-- rtos NOT used --]
void ethernetif_input(struct netif *netif);
[/#if][#-- endif use_rtos --]
[#if (series != "stm32h7") && (series != "stm32f7") && (series != "stm32f4") && (series != "stm32h7rs")][#-- series NOT stm32h7/f7/f4/h7rs --]
[#if use_rtos == 1][#-- rtos used --]
[#if cmsis_version = "v1"][#-- cmsis_version v1 --]
void ethernetif_set_link(void const *argument);
[#else][#-- cmsis_version v2 --]
void ethernetif_set_link(void* argument);
[/#if][#-- endif cmsis_version --]
[#else][#-- rtos NOT used --]
void ethernetif_set_link(struct netif *netif);
[/#if][#-- endif use_rtos --]
[/#if][#-- endif series --]
[#if (series == "stm32h7") || (series == "stm32f7") || (series == "stm32f4") || (series == "stm32h7rs")][#-- series stm32h7/f7/f4/h7rs --]
[#if use_rtos == 1][#-- rtos used --]
[#if cmsis_version = "v1"][#-- cmsis_version v1 --]
void ethernet_link_thread(void const * argument);
[#else][#-- cmsis_version v2 --]
void ethernet_link_thread(void* argument );
[/#if][#-- endif cmsis_version --]
[#else][#-- rtos NOT used --]
void ethernet_link_check_state(struct netif *netif);
[/#if][#-- endif with_rtos --]
[#else][#-- series NOT stm32h7/f7/f4/h7rs --]
void ethernetif_update_config(struct netif *netif);
void ethernetif_notify_conn_changed(struct netif *netif);
[/#if][#-- endif series --]

[#if series != "stm32h7rs"]
void Error_Handler(void);
[/#if]
u32_t sys_jiffies(void);
u32_t sys_now(void);

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
[#if (series != "stm32h7rs")]
#endif
[#else]
#endif /* __ETHERNETIF_H */
[/#if]