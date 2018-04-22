[#ftl]
/**
 ******************************************************************************
  * File Name          : ethernetif.h
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
  
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#assign use_rtos = 0]
[#assign netif_callback = 0]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]	 	
		[#if (definition.name == "NO_SYS")]
			[#if definition.value == "0"]
				[#assign use_rtos = 1]
			[/#if]
		[/#if]
		[#if (definition.name == "LWIP_NETIF_LINK_CALLBACK")]
            [#if definition.value == "1"]
                [#assign netif_callback = 1]
            [/#if]
        [/#if]
	[/#list]
[/#if]
[/#list]
[#assign series = FamilyName?lower_case]

#ifndef __ETHERNETIF_H__
#define __ETHERNETIF_H__

#include "lwip/err.h"
#include "lwip/netif.h"
[#if use_rtos == 1]
#include "cmsis_os.h"

[#if (netif_callback == 1) && (series != "stm32h7")]
/* Exported types ------------------------------------------------------------*/
/* Structure that include link thread parameters */
struct link_str {
  struct netif *netif;
  osSemaphoreId semaphore;
};
[/#if][#-- netif_callback --]
[/#if][#-- use_rtos --]

/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Exported functions ------------------------------------------------------- */
err_t ethernetif_init(struct netif *netif);

[#if use_rtos == 1]
void ethernetif_input( void const * argument );
[#else]
void ethernetif_input(struct netif *netif);
[/#if][#-- endif with_rtos --]
[#if series != "stm32h7"]
[#if (netif_callback == 1)]
[#if use_rtos == 1]
void ethernetif_set_link(void const *argument);
[#else]
void ethernetif_set_link(struct netif *netif);
[/#if][#-- endif with_rtos --]
[/#if][#-- endif netif_callback --]
[/#if][#-- endif series --]
[#if series == "stm32h7"]
[#if (netif_callback == 1)]
[#if use_rtos == 1]
void ethernet_link_thread(void const * argument );
[#else]
void ethernet_link_check_state(struct netif *netif);
[/#if][#-- endif with_rtos --]
[/#if][#-- endif netif_callback --]
[#else]
void ethernetif_update_config(struct netif *netif);
void ethernetif_notify_conn_changed(struct netif *netif);
[/#if]



/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#endif

  
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/