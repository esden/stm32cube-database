[#ftl]
/**
 ******************************************************************************
  * File Name          : lwippools.h
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
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
  ******************************************************************************
  */
  
 /******************************************************************************
 * If MEMP_USE_CUSTOM_POOLS option is enabled:
 *  - include this lwippools.h file that defines additional pools beyond the 
 *    "standard" ones required by lwIP.
 *  - make sure you have lwippools.h in your include path.
 ******************************************************************************/
  
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]
[#assign use_custom_pools = 0]
[#if SWIP.defines??]
	[#list SWIP.defines as definition] 	
		[#if (definition.name == "MEMP_USE_CUSTOM_POOLS")]
			[#if definition.value == "1"]
				[#assign use_custom_pools = 1]
			[/#if]
		[/#if]
	[/#list]
[/#if]
[/#list]
  
[#if use_custom_pools == 1]
/* MEMP_USE_CUSTOM_POOLS is enabled => This file is required by LwIP */

#ifdef __cplusplus
 extern "C" {
#endif

#n#n/* USER CODE BEGIN 0 */
/* Warning 1: The following code is only given as an example */
/* You can use this example code by uncommenting it */
/* -------------- EXAMPLE of CODE ------------------------*/
/* Define three pools with sizes 256, 512, and 1512 bytes */
/* 
#if MEM_USE_POOLS
LWIP_MALLOC_MEMPOOL_START
LWIP_MALLOC_MEMPOOL(20, 256)
LWIP_MALLOC_MEMPOOL(10, 512)
LWIP_MALLOC_MEMPOOL(5, 1512)
LWIP_MALLOC_MEMPOOL_END
#endif
*/
/* -------------- END of EXAMPLE of CODE -----------------*/

/* USER CODE END 0 */

#ifdef __cplusplus
}
#endif
[#else]
/* MEMP_USE_CUSTOM_POOLS is disabled => This file is not required by LwIP */
[/#if]

  
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/