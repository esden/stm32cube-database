[#ftl]
/**
  ******************************************************************************
  * @file           : openamp_conf.h
  * @brief          : Configuration file for OpenAMP MW
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */


/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __OPENAMP_CONF__H__
#define __OPENAMP_CONF__H__

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#if defined (__LOG_TRACE_IO_) || defined(__LOG_UART_IO_)
#include "log.h"
#endif

/* ########################## Mailbox Interface Selection ############################## */
 /**
   * @brief This is the list of Mailbox interface  to be used in the OpenAMP MW
   *        Please note that not all interfaces are supported by a STM32 device
   */
#define MAILBOX_IPCC_IF_ENABLED
//#define MAILBOX_HSEM_IF_ENABLED

/* Includes ------------------------------------------------------------------*/
 /**
   * @brief Include Maibox interface  header file
   */

#ifdef MAILBOX_IPCC_IF_ENABLED
#include "mbox_ipcc.h"
#endif /* MAILBOX_IPCC_IF_ENABLED */

#ifdef MAILBOX_HSEM_IF_ENABLED
#include "mbox_hsem.h"
#endif /* MAILBOX_HSEM_IF_ENABLED */

 /* ########################## Virtual Diver Module Selection ############################## */
 /**
   * @brief This is the list of modules to be used in the OpenAMP Virtual driver module
   *        Please note that virtual driver are not supported on all stm32 families
   */
#define VIRTUAL_UART_MODULE_ENABLED
//#define VIRTUAL_I2C_MODULE_ENABLED


 /* Includes ------------------------------------------------------------------*/
 /**
   * @brief Include Virtual Driver module's  header file
   */

#ifdef VIRTUAL_UART_MODULE_ENABLED
#include "virt_uart.h"
#endif /* VIRTUAL_UART_MODULE_ENABLED */

#ifdef VIRTUAL_I2C_MODULE_ENABLED
#include "virt_i2c.h"
#endif /* VIRTUAL_I2C_MODULE_ENABLED */



/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/** @addtogroup OPENAMP_MW
  * @{
  */

/** @defgroup OPENAMP_CONF OPENAMP_CONF
  * @brief Configuration file for Openamp mw
  * @{
  */

/** @defgroup OPENAMP_CONF_Exported_Variables OPENAMP_CONF_Exported_Variables
  * @brief Public variables.
  * @{
  */

/**
  * @}
  */

/** @defgroup OPENAMP_CONF_Exported_Defines OPENAMP_CONF_Exported_Defines
  * @brief Defines for configuration of the Openamp mw
  * @{
  */

extern int __OPENAMP_region_start__[];   /* defined by linker script */
extern int __OPENAMP_region_end__[];  /* defined by linker script */
 

#define SHM_START_ADDRESS       ((metal_phys_addr_t)__OPENAMP_region_start__)
#define SHM_SIZE                (size_t)((void *)__OPENAMP_region_end__-(void *) __OPENAMP_region_start__)

[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
                        [#if definition.name="VRING_RX_ADDRESS"]
                        [#lt]#define VRING_RX_ADDRESS     ${definition.value}             /* allocated by Master processor: CA7 */
			[/#if]
                        [#if definition.name="VRING_TX_ADDRESS"]
                        [#lt]#define VRING_TX_ADDRESS     ${definition.value}             /* allocated by Master processor: CA7 */
			[/#if]
                        [#if definition.name="VRING_BUFF_ADDRESS"]
                        [#lt]#define VRING_BUFF_ADDRESS   ${definition.value}             /* allocated by Master processor: CA7 */
			[/#if]
                        [#if definition.name="VRING_ALIGNMENT"]
                        [#lt]#define VRING_ALIGNMENT      ${definition.value}         /* fixed to match with 4k page alignement requested by linux  */
			[/#if]
                        [#if definition.name="VRING_NUM_BUFFS"]
                        [#lt]#define VRING_NUM_BUFFS      ${definition.value}             /* number of rpmsg buffer */
			[/#if]
                        [#if definition.name="NUM_RESOURCE_ENTRIES"]
/* Fixed parameter */
                        [#lt]#define NUM_RESOURCE_ENTRIES ${definition.value}
			[/#if]
                        [#if definition.name="VRING_COUNT"]
                        [#lt]#define VRING_COUNT          ${definition.value}
			[/#if]
                        [#if definition.name="VDEV_ID"]
                        [#lt]#define VDEV_ID              ${definition.value}
			[/#if]
                        [#if definition.name="VRING0_ID"]
                        [#lt]#define VRING0_ID            ${definition.value}              /* VRING0 ID (master to remote) fixed to 0 for linux compatibility*/
			[/#if]
                        [#if definition.name="VRING1_ID"]
                        [#lt]#define VRING1_ID            ${definition.value}              /* VRING1 ID (remote to master) fixed to 1 for linux compatibility  */
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
  * @}
  */

/** @defgroup OPENAMP_CONF_Exported_Macros OPENAMP_CONF_Exported_Macros
  * @brief Aliases.
  * @{
  */

/* DEBUG macros */

#if defined (__LOG_TRACE_IO_) || defined(__LOG_UART_IO_)
  #define OPENAMP_log_dbg               log_dbg
  #define OPENAMP_log_info              log_info
  #define OPENAMP_log_warn              log_warn
  #define OPENAMP_log_err               log_err
#else
  #define OPENAMP_log_dbg(...)
  #define OPENAMP_log_info(...)
  #define OPENAMP_log_warn(...)
  #define OPENAMP_log_err(...)
#endif

/**
  * @}
  */

/** @defgroup OPENAMP_CONF_Exported_Types OPENAMP_CONF_Exported_Types
  * @brief Types.
  * @{
  */

/**
  * @}
  */

/** @defgroup OPENAMP_CONF_Exported_FunctionsPrototype OPENAMP_CONF_Exported_FunctionsPrototype
  * @brief Declaration of public functions for OpenAMP mw.
  * @{
  */

/* Exported functions -------------------------------------------------------*/

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */
#ifdef __cplusplus
}
#endif

#endif /* __OPENAMP_CONF__H__ */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
