[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_os_port_mx.h
  * @author  MCD Application Team
  * @brief   This file contains the core os portability macro definition.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
#ifndef USBPD_CORE_OSPORT_H_
#define USBPD_CORE_OSPORT_H_

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if THREADX?? && Secure!="true"]
#include "tx_api.h"
[#else]
[#if FREERTOS?? && Secure!="true"]
#include "cmsis_os.h"
#if (osCMSIS >= 0x20000U)
#include "task.h"
#endif /* osCMSIS >= 0x20000U */
[#else]
#if defined(USE_STM32_UTILITY_OS)
#include "utilities_conf.h"
#endif /* USE_STM32_UTILITY_OS */
[/#if][#-- FREERTOS --]
[/#if][#-- THREADX --]

/** @addtogroup STM32_USBPD_LIBRARY
  * @{
  */

/** @addtogroup USBPD_CORE_OS
  * @{
  */

/** @addtogroup USBPD_CORE_OS_Macro
  * @{
  */
/* Exported define -----------------------------------------------------------*/
/**
  * @brief macro definition used to define the task function
  */
[#if THREADX?? && Secure!="true"]
#define DEF_TASK_FUNCTION(__FUNCTION__)   void (__FUNCTION__)(ULONG argument)
[#else]
#if (osCMSIS < 0x20000U)
#define DEF_TASK_FUNCTION(__FUNCTION__)   void (__FUNCTION__)(void const *argument)
#else
#define DEF_TASK_FUNCTION(__FUNCTION__)   void (__FUNCTION__)(void *argument)
#endif /* (osCMSIS < 0x20000U)*/
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to initialize the OS environment
  */
[#if THREADX?? && Secure!="true"]
#define OS_INIT()                                        \
    TX_BYTE_POOL *usbpd_pool = (TX_BYTE_POOL*)MemoryPtr; \
    char *ptr;                                           \
    uint32_t _retr = TX_SUCCESS;
[#else]
#define OS_INIT()   USBPD_StatusTypeDef _retr = USBPD_OK;
[/#if][#-- THREADX --]

/**
  * @brief macro definition the define a queue type
  */
[#if THREADX?? && Secure!="true"]
#define OS_QUEUE_ID TX_QUEUE
[#else]
#define OS_QUEUE_ID osMessageQId
[/#if][#-- THREADX --]

/**
  * @brief macro definition the define a queue type
  */
[#if THREADX?? && Secure!="true"]
#define OS_ELEMENT_SIZE TX_1_ULONG
[#else]
#define OS_ELEMENT_SIZE sizeof(uint16_t)
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to define a queue
  */
[#if THREADX?? && Secure!="true"]
#define OS_CREATE_QUEUE(_ID_,_NAME_, _ELT_,_ELTSIZE_)                                                  \
  do{                                                                                                  \
    _retr = tx_byte_allocate(usbpd_pool, (void **) &ptr,(_ELT_)*sizeof(ULONG)*(_ELTSIZE_),TX_NO_WAIT); \
    if(_retr != TX_SUCCESS)                                                                            \
    {                                                                                                  \
      goto error;                                                                                      \
    }                                                                                                  \
    _retr = tx_queue_create(&(_ID_),(_NAME_), (_ELTSIZE_), ptr ,(_ELT_)*sizeof(ULONG)*(_ELTSIZE_));    \
    if(_retr != TX_SUCCESS)                                                                            \
    {                                                                                                  \
      goto error;                                                                                      \
    }                                                                                                  \
  } while(0);
[#else]
#if (osCMSIS < 0x20000U)
#define OS_CREATE_QUEUE(_ID_,_NAME_,_ELT_,_ELTSIZE_)   do {                                                      \
                                                            osMessageQDef(queuetmp, (_ELT_), (_ELTSIZE_));       \
                                                            (_ID_) = osMessageCreate(osMessageQ(queuetmp), NULL);\
                                                            if((_ID_) == 0)                                      \
                                                            {                                                    \
                                                              _retr = USBPD_ERROR;                               \
                                                              goto error;                                        \
                                                            }                                                    \
                                                          } while(0)
#else
#define OS_CREATE_QUEUE(_ID_,_NAME_,_ELT_,_ELTSIZE_) do {                                                       \
                                                          (_ID_) = osMessageQueueNew((_ELT_),(_ELTSIZE_), NULL);\
                                                        }while(0)
#endif /* osCMSIS < 0x20000U */
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to read a queue message
  */
[#if THREADX?? && Secure!="true"]
#define OS_GETMESSAGE_QUEUE(_ID_, _TIME_)                                      \
  do {                                                                         \
    ULONG value;                                                               \
    tx_queue_receive(&(_ID_), (void*)&value, (_TIME_));                        \
  } while(0)
[#else]
#if (osCMSIS < 0x20000U)
#define OS_GETMESSAGE_QUEUE(_ID_, _TIME_)  osMessageGet((_ID_),(_TIME_))
#else
#define OS_GETMESSAGE_QUEUE(_ID_, _TIME_)  do {                                                      \
                                                uint32_t event;                                      \
                                                (void)osMessageQueueGet((_ID_),&event,NULL,(_TIME_));\
                                              } while(0)
#endif /* (osCMSIS < 0x20000U) */
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to define put a message inside the queue
  */
[#if THREADX?? && Secure!="true"]
#define OS_PUT_MESSAGE_QUEUE(_ID_,_MSG_,_TIMEOUT_)                               \
  do{                                                                            \
    ULONG _msg = _MSG_;                                                          \
    (void)tx_queue_send(&(_ID_), &_msg,(_TIMEOUT_));                             \
  }while(0)
[#else]
#if (osCMSIS < 0x20000U)
#define OS_PUT_MESSAGE_QUEUE(_ID_,_MSG_,_TIMEOUT_)  do{                                                \
                                                        (void)osMessagePut((_ID_),(_MSG_),(_TIMEOUT_));\
                                                      }while(0)
#else
#define OS_PUT_MESSAGE_QUEUE(_ID_,_MSG_,_TIMEOUT_)  do {                                                         \
                                                         uint32_t event = (_MSG_);                               \
                                                         (void)osMessageQueuePut((_ID_), &event, 0U,(_TIMEOUT_));\
                                                       } while(0)
#endif /* osCMSIS < 0x20000U */
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to define a task
  */
[#if THREADX?? && Secure!="true"]
#define OS_DEFINE_TASK(_NAME_,_FUNC_,_PRIORITY_,_STACK_SIZE_, _PARAM_)
[#else]
#if (osCMSIS < 0x20000U)
#define OS_DEFINE_TASK(_NAME_,_FUNC_,_PRIORITY_,_STACK_SIZE_, _PARAM_)
#else
#define OS_DEFINE_TASK(_NAME_,_FUNC_,_PRIORITY_,_STACK_SIZE_, _PARAM_)
#endif /* osCMSIS < 0x20000U */
[/#if][#-- THREADX --]

/**
  * @brief macro definition of the TASK id
  */
[#if THREADX?? && Secure!="true"]
#define OS_TASK_ID   TX_THREAD
[#else]
#define OS_TASK_ID   osThreadId
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to create a task
  */
[#if THREADX?? && Secure!="true"]
#define OS_CREATE_TASK(_ID_,_NAME_,_FUNC_,_PRIORITY_,_STACK_SIZE_, _PARAM_)           \
  do {                                                                                \
    _retr = tx_byte_allocate(usbpd_pool, (void **)&ptr,(_STACK_SIZE_),TX_NO_WAIT);    \
    if(_retr != TX_SUCCESS)                                                           \
    {                                                                                 \
      goto error;                                                                     \
    }                                                                                 \
    _retr = tx_thread_create(&(_ID_),#_NAME_,(_FUNC_), _PARAM_,                       \
                         ptr,(_STACK_SIZE_),                                          \
                         _PRIORITY_, 1, TX_NO_TIME_SLICE,                             \
                         TX_AUTO_START);                                              \
    if(_retr != TX_SUCCESS)                                                           \
    {                                                                                 \
      goto error;                                                                     \
    }                                                                                 \
  } while(0);
[#else]
#if (osCMSIS < 0x20000U)
#define OS_CREATE_TASK(_ID_,_NAME_,_FUNC_,_PRIORITY_,_STACK_SIZE_, _PARAM_) \
  do {                                                           \
    osThreadDef(_NAME_, _FUNC_, _PRIORITY_, 0, _STACK_SIZE_);    \
    (_ID_) = osThreadCreate(osThread(_NAME_), (void *)(_PARAM_));\
    if (NULL == (_ID_))                                          \
    {                                                            \
      _retr = USBPD_ERROR;                                       \
      goto error;                                                \
    }                                                            \
  } while(0)
#else
#define OS_CREATE_TASK(_ID_,_NAME_,_FUNC_,_PRIORITY_,_STACK_SIZE_, _PARAM_) \
  do {                                                 \
    osThreadAttr_t Thread_Atrr =                       \
    {                                                  \
      .name       = #_NAME_,                           \
      .priority   = (_PRIORITY_),                      \
      .stack_size = (_STACK_SIZE_)                     \
    };                                                 \
    (_ID_) = osThreadNew(_FUNC_, (void *)(_PARAM_),    \
                         &Thread_Atrr);                \
    if (NULL == (_ID_))                                \
    {                                                  \
      _retr = USBPD_ERROR;                             \
      goto error;                                      \
    }                                                  \
  } while(0)
#endif /* osCMSIS < 0x20000U */
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to check is task is suspended
  */
[#if THREADX?? && Secure!="true"]
#define OS_TASK_IS_SUPENDED(_ID_) (TX_SUSPENDED == (_ID_).tx_thread_state)
[#else]
#define OS_TASK_IS_SUPENDED(_ID_) (eSuspended == eTaskGetState((_ID_)))
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to get the task ID
  */
[#if THREADX?? && Secure!="true"]
#define OS_TASK_GETID()          tx_thread_identify()
[#else]
#define OS_TASK_GETID()          osThreadGetId()
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to suspend a task
  */
[#if THREADX?? && Secure!="true"]
#define OS_TASK_SUSPEND(_ID_)    tx_thread_suspend(_ID_)
[#else]
#define OS_TASK_SUSPEND(_ID_)    osThreadSuspend(_ID_)
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to resume a task
  */
[#if THREADX?? && Secure!="true"]
#define OS_TASK_RESUME(_ID_)     tx_thread_resume(&_ID_)
[#else]
#define OS_TASK_RESUME(_ID_)     osThreadResume(_ID_)
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to manage the delay
  */
[#if THREADX?? && Secure!="true"]
#define OS_DELAY(_TIME_)   tx_thread_sleep(_TIME_)
[#else]
#define OS_DELAY(_TIME_)   osDelay(_TIME_)
[/#if][#-- THREADX --]

/**
  * @brief macro definition used to start the task scheduling
  */
[#if THREADX?? && Secure!="true"]
#define OS_KERNEL_START() /* This function is not managed at usbpd level in the case of threadX */
[#else]
#if (osCMSIS >= 0x20000U)
#define OS_KERNEL_START()  do { (void)osKernelInitialize(); \
                                (void)osKernelStart();      \
                              } while(0)
#else
#define OS_KERNEL_START()  (void)osKernelStart()
#endif /* osCMSIS >= 0x20000U */
[/#if][#-- THREADX --]

/* Exported types ------------------------------------------------------------*/
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
#endif /* USBPD_CORE_OSPORT_H_ */

