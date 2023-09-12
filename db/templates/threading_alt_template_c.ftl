[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * File Name          : ${name}
  * @author  MCD Application Team
  * @brief   mutex management functions implementation based on cmsis-os V1/V2
             API. This file to be copied under the application project source tree.
 ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/*
 * This files implements the mbedTLS mutex management API using the CMSIS-RTOS
 * V1 & V2 API. To correctly use this file make sure that:
 *
 *  - this file as well as the "threading_alt_template.h" files are renamed
 *     and copied under the project source tree.
 *
 *  - The project seetings are pointing to the correct CMSIS-RTOS files
 *
 *  - the mbedTLS config file is enabling the flags "MBEDTLS_THREADING_C" and
 *    "MBEDTLS_THREADING_ALT"
 *
 *  - the mbedtls_set_threading_alt(...) is called before any other mbedtls
 *   API, in order to register the cmisis_os_mutex_xxx() API.
 *
 */

#include "threading_alt.h"

#if defined(MBEDTLS_THREADING_ALT)

void cmsis_os_mutex_init( mbedtls_threading_mutex_t *mutex )
{
#if (osCMSIS < 0x20000U)
  osMutexDef(thread_mutex);
  mutex->mutex_id = osMutexCreate(osMutex(thread_mutex));
#else
  mutex->mutex_id = osMutexNew(NULL);
#endif
  if (mutex->mutex_id != NULL)
  {
    mutex->status = osOK;
  }
  else
  {
    mutex->status = osErrorOS;
  }

}

void cmsis_os_mutex_free( mbedtls_threading_mutex_t *mutex )
{
  if (mutex->mutex_id != NULL)
  {
    osMutexDelete(mutex->mutex_id);
  }
}

int cmsis_os_mutex_lock( mbedtls_threading_mutex_t *mutex )
{
  if ((mutex == NULL) || (mutex->mutex_id == NULL) || (mutex->status != osOK))
  {
    return MBEDTLS_ERR_THREADING_BAD_INPUT_DATA;
  }
#if (osCMSIS < 0x20000U)
  mutex->status = osMutexWait(mutex->mutex_id, osWaitForever);
#else
  mutex->status = osMutexAcquire(mutex->mutex_id, osWaitForever);
#endif
  if (mutex->status != osOK)
  {
    return MBEDTLS_ERR_THREADING_MUTEX_ERROR;
  }

  return 0;
}

int cmsis_os_mutex_unlock( mbedtls_threading_mutex_t *mutex )
{
   if((mutex == NULL) || (mutex->mutex_id == NULL) || (mutex->status != osOK))
   {
     return MBEDTLS_ERR_THREADING_BAD_INPUT_DATA;
   }

   mutex->status = osMutexRelease(mutex->mutex_id);
   if (mutex->status != osOK)
   {
     return MBEDTLS_ERR_THREADING_MUTEX_ERROR;
   }

   return 0;
}
#endif
