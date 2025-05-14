[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_threadx.c
  * @author  MCD Application Team
  * @brief   ThreadX applicative file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign DisplayPack = "false"]
[#assign TX_ENABLED = "true"]
[#assign FX_ENABLED = "false"]
[#assign NX_ENABLED = "false"]
[#assign UX_HOST_ENABLED = "false"]
[#assign UX_DEVICE_ENABLED = "false"]
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1"]
[#assign TX_APP_GENERATE_INIT_CODE_value = "false"]
[#assign WPAN_ENABLED = "0"]
[#assign familyName=FamilyName?lower_case]
[#compress]
[#if packs??]
[#list packs as variables]
[#if variables.value != "ThreadX" ] 
  [#if variables.value?lower_case=="display"]
    [#assign DisplayPack = "true"]
  [/#if]
[/#if]  
[/#list]
[/#if]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "WPAN_ENABLED" && value == "true"]
      [#assign WPAN_ENABLED = value]
    [/#if]
    [#if name == "FILEX_ENABLED" && value == "true"]
      [#assign FX_ENABLED = value]
    [/#if]
    [#if name == "NETXDUO_ENABLED" && value == "true"]
      [#assign NX_ENABLED = value]
    [/#if]
    [#if name == "USBXDEVICE_ENABLED" && value == "true"]
      [#assign UX_DEVICE_ENABLED = value]
    [/#if]
    [#if name == "USBXHOST_ENABLED" && value == "true"]
      [#assign UX_HOST_ENABLED = value]
    [/#if]
     [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
    [#if name == "TX_LOW_POWER"]
      [#assign TX_LOW_POWER_value = value]
    [/#if]


    [#if name == "TX_APP_GENERATE_INIT_CODE"]
      [#assign TX_APP_GENERATE_INIT_CODE_value = value]
    [/#if]

    [#if name == "TX_APP_CREATION"]
      [#assign TX_APP_CREATION_value = value]
    [/#if]

    [#if name == "TX_APP_THREAD_ENTRY"]
      [#assign TX_APP_THREAD_ENTRY_value = value]
    [/#if]

    [#if name == "TX_APP_THREAD_NAME"]
      [#assign TX_APP_THREAD_NAME_value = value]
    [/#if]

    [#if name == "TX_APP_SEM_CREATION"]
      [#assign TX_APP_SEM_CREATION_value = value]
    [/#if]

    [#if name == "TX_SEMAPHORE_NAME"]
      [#assign TX_SEMAPHORE_NAME_value = value]
    [/#if]

    [#if name == "TX_SEMAPHORE_COUNT"]
      [#assign TX_SEMAPHORE_COUNT_value = value]
    [/#if]

    [#if name == "TX_APP_MUTEX_CREATION"]
      [#assign TX_APP_MUTEX_CREATION_value = value]
    [/#if]

    [#if name == "TX_MUTEX_NAME"]
      [#assign TX_MUTEX_NAME_value = value]
    [/#if]

    [#if name == "TX_MUTEX_INHERITANCE"]
      [#assign TX_MUTEX_INHERITANCE_value = value]
    [/#if]

    [#if name == "TX_APP_MSG_QUEUE_CREATION"]
      [#assign TX_APP_MSG_QUEUE_CREATION_value = value]
    [/#if]

    
    [#if name == "TX_MSG_QUEUE_NAME"]
      [#assign TX_MSG_QUEUE_NAME_value = value]
    [/#if]

    [#if name == "TX_LOW_POWER_TIMER_SETUP"]
      [#assign TX_LOW_POWER_TIMER_SETUP_value = value]
    [/#if]
    
    [#if name == "TX_LOW_POWER_USER_ENTER"]
      [#assign TX_LOW_POWER_USER_ENTER_value = value]
    [/#if]
    
    [#if name == "TX_LOW_POWER_USER_EXIT"]
      [#assign TX_LOW_POWER_USER_EXIT_value = value]
    [/#if]
    
    [#if name == "TX_LOW_POWER_USER_TIMER_ADJUST"]
      [#assign TX_LOW_POWER_USER_TIMER_ADJUST_value = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]

/* Includes ------------------------------------------------------------------*/
#include "app_threadx.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
[#if TX_APP_CREATION_value != "0"]
TX_THREAD tx_app_thread;
[/#if]
[#if TX_APP_SEM_CREATION_value != "0"]
TX_SEMAPHORE tx_app_semaphore;
[/#if]
[#if TX_APP_MUTEX_CREATION_value != "0"]
TX_MUTEX tx_app_mutex;
[/#if]
[#if TX_APP_MSG_QUEUE_CREATION_value != "0"]
TX_QUEUE tx_app_msg_queue;
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/**
  * @brief  Application ThreadX Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
  */
UINT App_ThreadX_Init(VOID *memory_ptr)
{
  UINT ret = TX_SUCCESS;
  [#-- The condition for display pack is added as a workaround for ticket 145290, (void)byte_pool; in the user section App_ThreadX_MEM_POOL should be removed from examples in the next display pack release --]
[#if (familyName?starts_with("stm32u5")&&(DisplayPack=="true")&&(TX_APP_GENERATE_INIT_CODE_value == "false"))]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
  
   /* USER CODE BEGIN App_ThreadX_MEM_POOL */
  (void)byte_pool;
  /* USER CODE END App_ThreadX_MEM_POOL */
  
[#else]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
[#if TX_APP_CREATION_value != "0"]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]

[#if TX_APP_CREATION_value != "1"]
[#if TX_APP_MSG_QUEUE_CREATION_value != "0"]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]
[/#if]
[/#if]
  /* USER CODE BEGIN App_ThreadX_MEM_POOL */

  /* USER CODE END App_ThreadX_MEM_POOL */
[/#if]
[/#if]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
[#if TX_APP_CREATION_value != "0"]
  CHAR *pointer;

  /* Allocate the stack for ${TX_APP_THREAD_NAME_value}  */
  if (tx_byte_allocate(byte_pool, (VOID**) &pointer,
                       TX_APP_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    return TX_POOL_ERROR;
  }
  /* Create ${TX_APP_THREAD_NAME_value}.  */
  if (tx_thread_create(&tx_app_thread, "${TX_APP_THREAD_NAME_value}", ${TX_APP_THREAD_ENTRY_value}, 0, pointer,
                       TX_APP_STACK_SIZE, TX_APP_THREAD_PRIO, TX_APP_THREAD_PREEMPTION_THRESHOLD,
                       TX_APP_THREAD_TIME_SLICE, TX_APP_THREAD_AUTO_START) != TX_SUCCESS)
  {
    return TX_THREAD_ERROR;
  }
[/#if]
[#if TX_APP_CREATION_value != "1"]
[#if TX_APP_MSG_QUEUE_CREATION_value != "0"]
  CHAR *pointer;

[/#if]
[/#if]
[#if TX_APP_MSG_QUEUE_CREATION_value != "0"]
  /* Allocate the stack for ${TX_MSG_QUEUE_NAME_value}.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                       TX_APP_MSG_QUEUE_FULL_SIZE * sizeof(ULONG), TX_NO_WAIT) != TX_SUCCESS)
  {
    return TX_POOL_ERROR;
  }
  /* Create ${TX_MSG_QUEUE_NAME_value}.  */
  if (tx_queue_create(&tx_app_msg_queue, "${TX_MSG_QUEUE_NAME_value}", TX_APP_SINGLE_MSG_SIZE,
                      pointer, TX_APP_MSG_QUEUE_FULL_SIZE * sizeof(ULONG)) != TX_SUCCESS)
  {
    return TX_QUEUE_ERROR;
  }
[/#if]

[#if TX_APP_SEM_CREATION_value != "0"]
  /* Create ${TX_SEMAPHORE_NAME_value}.  */
  if (tx_semaphore_create(&tx_app_semaphore, "${TX_SEMAPHORE_NAME_value}", ${TX_SEMAPHORE_COUNT_value}) != TX_SUCCESS)
  {
    return TX_SEMAPHORE_ERROR;
  }
[/#if]

[#if TX_APP_MUTEX_CREATION_value != "0"]
  /* Create ${TX_MUTEX_NAME_value}.  */
  if (tx_mutex_create(&tx_app_mutex, "${TX_MUTEX_NAME_value}", ${TX_MUTEX_INHERITANCE_value}) != TX_SUCCESS)
  {
    return TX_MUTEX_ERROR;
  }
[/#if]
[/#if]
[/#if]
  /* USER CODE BEGIN App_ThreadX_Init */
  /* USER CODE END App_ThreadX_Init */
  
  return ret;
}
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
[#if TX_APP_CREATION_value != "0"]
/**
  * @brief  Function implementing the ${TX_APP_THREAD_ENTRY_value} thread.
  * @param  thread_input: Hardcoded to 0.
  * @retval None
  */
void ${TX_APP_THREAD_ENTRY_value}(ULONG thread_input)
{
  /* USER CODE BEGIN ${TX_APP_THREAD_ENTRY_value} */

  /* USER CODE END ${TX_APP_THREAD_ENTRY_value} */
}
[/#if]
[/#if]
[/#if]

  /**
[#if (familyName?starts_with("stm32wba") || familyName?starts_with("stm32u3") || familyName?starts_with("stm32u5") || familyName?starts_with("stm32u0") || familyName?starts_with("stm32h5") || familyName?starts_with("stm32c0"))]
  * @brief  Function that implements the kernel's initialization.
[#else]
  * @brief  MX_ThreadX_Init
[/#if]
  * @param  None 
  * @retval None
  */
void MX_ThreadX_Init(void)
{
  /* USER CODE BEGIN Before_Kernel_Start */

  /* USER CODE END Before_Kernel_Start */

  tx_kernel_enter();

  /* USER CODE BEGIN Kernel_Start_Error */

  /* USER CODE END Kernel_Start_Error */
}

[#if TX_LOW_POWER_value == "1"]
[#if TX_LOW_POWER_TIMER_SETUP_value != " " && TX_LOW_POWER_TIMER_SETUP_value != "" && TX_LOW_POWER_TIMER_SETUP_value!="valueNotSetted"]

/**
  * @brief  ${TX_LOW_POWER_TIMER_SETUP_value}
  * @param  count : TX timer count
  * @retval None
  */
[#if familyName?starts_with("stm32wba") && WPAN_ENABLED == "true"]
__weak void ${TX_LOW_POWER_TIMER_SETUP_value}(ULONG count)
[#else]
void ${TX_LOW_POWER_TIMER_SETUP_value}(ULONG count)
[/#if]
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_TIMER_SETUP_value} */

  /* USER CODE END  ${TX_LOW_POWER_TIMER_SETUP_value} */
}
[/#if]
[#if TX_LOW_POWER_USER_ENTER_value != " " && TX_LOW_POWER_USER_ENTER_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_ENTER_value}
  * @param  None
  * @retval None
  */
[#if familyName?starts_with("stm32wba") && WPAN_ENABLED == "true"]
__weak void ${TX_LOW_POWER_USER_ENTER_value}(void)
[#else]
void ${TX_LOW_POWER_USER_ENTER_value}(void)
[/#if]
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_ENTER_value} */

  /* USER CODE END  ${TX_LOW_POWER_USER_ENTER_value} */
}
[/#if]
[#if TX_LOW_POWER_USER_EXIT_value != " " && TX_LOW_POWER_USER_EXIT_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_EXIT_value}
  * @param  None
  * @retval None
  */
[#if familyName?starts_with("stm32wba") && WPAN_ENABLED == "true"]
__weak void ${TX_LOW_POWER_USER_EXIT_value}(void)
[#else]
void ${TX_LOW_POWER_USER_EXIT_value}(void)
[/#if]
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_EXIT_value} */

  /* USER CODE END  ${TX_LOW_POWER_USER_EXIT_value} */
}
[/#if]
[#if TX_LOW_POWER_USER_TIMER_ADJUST_value != " " && TX_LOW_POWER_USER_TIMER_ADJUST_value != "" && TX_LOW_POWER_USER_TIMER_ADJUST_value!="valueNotSetted"]

/**
  * @brief  ${TX_LOW_POWER_USER_TIMER_ADJUST_value}
  * @param  None
  * @retval Amount of time (in ticks)
  */
[#if familyName?starts_with("stm32wba") && WPAN_ENABLED == "true"]
__weak ULONG ${TX_LOW_POWER_USER_TIMER_ADJUST_value}(void)
[#else]
ULONG ${TX_LOW_POWER_USER_TIMER_ADJUST_value}(void)
[/#if]
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_TIMER_ADJUST_value} */
  return 0;
  /* USER CODE END  ${TX_LOW_POWER_USER_TIMER_ADJUST_value} */
}
[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */