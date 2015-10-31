[#ftl]
/**
  ******************************************************************************
  * @file           : fatfs_f4xxsd_detect.c
  * @brief          : source file for the SD card detection
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  * 1. Redistributions of source code must retain the above copyright notice,
  * this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  * this list of conditions and the following disclaimer in the documentation
  * and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of its contributors
  * may be used to endorse or promote products derived from this software
  * without specific prior written permission.
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
#include "fatfs_f4xxsd_detect.h"
[#if GPIO_IP??] 
[#else]
/* External variables ---------------------------------------------------------*/
extern ${IpName}_HandleTypeDef h${IpInstance?lower_case};
[/#if]

/**
  * @brief  MX_SD_IsDetected  
  */
uint8_t MX_SD_IsDetected(void) 
{ 
[#if GPIO_IP??] 
 __IO uint8_t status = GPIO_PIN_RESET;

  /* TBI: add user code here depending on the hardware configuration used */
  if (HAL_GPIO_ReadPin(${IpName},${IpInstance}) == GPIO_PIN_SET) {
    status = GPIO_PIN_SET;
  }  
  return status;
 
[/#if]
}