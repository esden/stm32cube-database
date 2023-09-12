[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_netxduo.h
  * @author  MCD Application Team
  * @brief   NetXDuo applicative header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_NETXDUO_H__
#define __APP_NETXDUO_H__

#ifdef __cplusplus
extern "C" {
#endif
[#assign NX_APP_THREAD_PRIORITY_value = "0"]
[#assign NetXDuo_Generate_Init_Code_value = "false"]
[#assign Nx_App_Thread_Name_value = ""]
[#assign NX_APP_PACKET_POOL_SIZE_value = "0"]
[#assign NX_APP_THREAD_STACK_SIZE_value = "0"]
[#assign NX_APP_IP_INSTANCE_THREAD_SIZE_value = "0"]
[#assign NetXDuo_Static_IP_address_value = ""]
[#assign NetXDuo_Application_NetMask_value = ""]
[#assign Initialize_DHCP_protocol_value = "false"]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
 [#list SWIP.defines as definition]
 [#assign value = definition.value]
 [#assign name = definition.name]

 [#if name == "NX_APP_THREAD_PRIORITY"]
 [#assign NX_APP_THREAD_PRIORITY_value = value]
 [/#if]

 [#if name == "NetXDuo_Generate_Init_Code"]
 [#assign NetXDuo_Generate_Init_Code_value = value]
 [/#if]

 [#if name == "NX_APP_THREAD_STACK_SIZE"]
 [#assign NX_APP_THREAD_STACK_SIZE_value = value]
 [/#if]

 [#if name == "NetXDuo_Application_Thread_Name"]
 [#assign Nx_App_Thread_Name_value = value]
 [/#if]

 [#if name == "NX_APP_PACKET_POOL_SIZE"]
 [#assign NX_APP_PACKET_POOL_SIZE_value = value]
 [/#if]

 [#if name == "Initialize_DHCP_protocol"]
 [#assign Initialize_DHCP_protocol_value = value]
 [/#if]

 [#if name == "NX_APP_IP_INSTANCE_THREAD_SIZE"]
 [#assign NX_APP_IP_INSTANCE_THREAD_SIZE_value = value]
 [/#if]

 [#if name == "NetXDuo_Static_IP_address"]
 [#assign NetXDuo_Static_IP_address_value = value]
 [/#if]

 [#if name == "NetXDuo_Application_NetMask"]
 [#assign NetXDuo_Application_NetMask_value = value]
 [/#if]

 [#if name == "ETH_ON"]
 [#assign ETH_ON_value = value]
 [/#if]

 [/#list]
[/#if]
[/#list]
[/#compress]

[#if RTEdatas??]
[#list RTEdatas as define]

[/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "nx_api.h"

/* Private includes ----------------------------------------------------------*/
[#if ETH_ON_value??]
[#if ETH_ON_value == "1"]
#include "nx_stm32_eth_driver.h"
[/#if]
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */
[#if NetXDuo_Generate_Init_Code_value == "true"]
/* The DEFAULT_PAYLOAD_SIZE should match with RxBuffLen configured via MX_ETH_Init */
#ifndef DEFAULT_PAYLOAD_SIZE
#define DEFAULT_PAYLOAD_SIZE      1536
#endif

#ifndef DEFAULT_ARP_CACHE_SIZE
#define DEFAULT_ARP_CACHE_SIZE    1024
#endif

[/#if]

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
UINT MX_NetXDuo_Init(VOID *memory_ptr);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if NetXDuo_Generate_Init_Code_value == "true"]
#define NX_APP_DEFAULT_TIMEOUT               (10 * NX_IP_PERIODIC_RATE)

#define NX_APP_PACKET_POOL_SIZE              ((DEFAULT_PAYLOAD_SIZE + sizeof(NX_PACKET)) * ${NX_APP_PACKET_POOL_SIZE_value})

#define NX_APP_THREAD_STACK_SIZE             ${NX_APP_THREAD_STACK_SIZE_value}

#define Nx_IP_INSTANCE_THREAD_SIZE           ${NX_APP_IP_INSTANCE_THREAD_SIZE_value}

#define NX_APP_THREAD_PRIORITY               ${NX_APP_THREAD_PRIORITY_value}

#ifndef NX_APP_INSTANCE_PRIORITY
#define NX_APP_INSTANCE_PRIORITY             NX_APP_THREAD_PRIORITY
#endif

[#if Initialize_DHCP_protocol_value == "false" ]
#define NX_APP_DEFAULT_IP_ADDRESS                   IP_ADDRESS(${NetXDuo_Static_IP_address_value?replace(".",", ")})

#define NX_APP_DEFAULT_NET_MASK                     IP_ADDRESS(${NetXDuo_Application_NetMask_value?replace(".",", ")})
[#else]
#define NX_APP_DEFAULT_IP_ADDRESS                   0

#define NX_APP_DEFAULT_NET_MASK                     0

[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* __APP_NETXDUO_H__ */
