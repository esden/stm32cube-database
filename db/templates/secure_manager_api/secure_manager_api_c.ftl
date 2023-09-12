[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${name?lower_case}.c
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : This file implements the Secure Manager Api
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- Create global variables --]


/* Includes ------------------------------------------------------------------*/
#include "secure_manager_api.h"
[#-- IPdatas is a list of IPconfigModel --]

[#compress]

[/#compress]
[#-- Define includes --]
#n



/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */

[#-- Global variables --]
#n
/*
 * -- Insert your variables declaration here --
 */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#n
/*
 * -- Insert your external function declaration here --
 */
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#n#n

/**
  * Init Secure Manager API
  * @retval None
  */
[#if THREADX??]  
unsigned int MX_${name}_Init(void *memory_ptr)
{
#tunsigned int ret = 0x01;
[#compress]

#t/* USER CODE BEGIN ${name}_Init_PreTreatment */
#t
#t/* USER CODE END ${name}_Init_PreTreatment */
#t
       
[/#compress]

#t/* USER CODE BEGIN ${name}_Init_PostTreatment */

#t
#t/* USER CODE END ${name}_Init_PostTreatment */

#treturn ret;
}

[#else]
void MX_${name}_Init(void)
{
[#compress]

#t/* USER CODE BEGIN ${name}_Init_PreTreatment */
#t
#t/* USER CODE END ${name}_Init_PreTreatment */
#t
       
[/#compress]

#t/* USER CODE BEGIN ${name}_Init_PostTreatment */

#t
#t/* USER CODE END ${name}_Init_PostTreatment */

}
[/#if]