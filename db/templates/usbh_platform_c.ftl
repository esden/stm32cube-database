[#ftl]
/**
  ******************************************************************************
  * @file           : usbh_platform.c
  * @brief          : source file for the usbh_platform file
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
[#-- BspIpDatas is a list of SWIPconfigModel --]  
[#assign instNameFS = ""]
[#assign instNameHS = ""]

[#assign IpNameFS = ""]
[#assign IpInstanceFS = ""]
[#assign I2CRegFS = ""]
[#assign I2CAddrFS = ""]
[#assign IpNameHS = ""]
[#assign IpInstanceHS = ""]
[#assign I2CRegHS = ""]
[#assign I2CAddrHS = ""]


[#list BspIpDatas as SWIP] 
[#if SWIP.ipName?contains("FS")]
	[#assign instNameFS = "FS"] 
	[#if SWIP.variables??]
		[#list SWIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpNameFS = variables.value]
		[/#if]
		[#if variables.name?contains("IpInstance")]
			[#assign IpInstanceFS = variables.value]
		[/#if]	
		[#if variables.name?contains("I2CAddr")]
			[#assign I2CAddrFS = variables.value]
		[/#if]
		[#if variables.name?contains("I2CReg")]
			[#assign I2CRegFS = variables.value]
		[/#if]		
		[/#list]
	[/#if]
[/#if]

[#if SWIP.ipName?contains("HS")]
	[#assign instNameHS = "HS"] 
	[#if SWIP.variables??]
		[#list SWIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpNameHS = variables.value]
		[/#if]
		[#if variables.name?contains("IpInstance")]
			[#assign IpInstanceHS = variables.value]
		[/#if]	
		[#if variables.name?contains("I2CAddr")]
			[#assign I2CAddrHS = variables.value]
		[/#if]
		[#if variables.name?contains("I2CReg")]
			[#assign I2CRegHS = variables.value]
		[/#if]		
		[/#list]
	[/#if]
[/#if]
[/#list]

#include "usbh_platform.h"
[#if instNameFS == "FS"]
[#if IpNameFS?contains("GPIO")]
[#else]
/* External variables ---------------------------------------------------------*/
extern ${IpNameFS}_HandleTypeDef h${IpInstanceFS?lower_case};
[/#if]
[/#if]
[#if instNameHS == "HS"]
[#if IpNameHS?contains("GPIO")]
[#else]
/* External variables ---------------------------------------------------------*/
extern ${IpNameHS}_HandleTypeDef h${IpInstanceHS?lower_case};
[/#if]
[/#if]


/**
  * @brief  MX_DriverVBUS 
  *         Drive VBUS.
  * @param  state : VBUS state
  *          This parameter can be one of the these values:
  *           0 : VBUS Active 
  *           1 : VBUS Inactive
  */
void MX_DriverVbusFS( uint8_t state) 
{ 
[#if IpNameFS?contains("GPIO")]
  if(state == 0)
  {
    /* Drive high Charge pump */
    HAL_GPIO_WritePin(${IpNameFS},${IpInstanceFS},GPIO_PIN_SET);
  }
  else
  {
    /* Drive low Charge pump */
    HAL_GPIO_WritePin(${IpNameFS},${IpInstanceFS},GPIO_PIN_RESET);
  }
[#else] 
  [#if IpNameFS="I2C"]
  uint8_t Component_Reg  = ${I2CRegFS};
  HAL_StatusTypeDef status = HAL_OK;
  [/#if]   
  [#if IpNameFS="I2C"]
  uint8_t Component_Addr = ${I2CAddrFS} << 1;    
  /* USER CODE BEGIN PREPARE_DATA */    
  uint8_t data = state;
  /* USER CODE END PREPARE_DATA */  
  uint8_t data_tmp = 0;
  status = HAL_${IpNameFS}_Mem_Read(&h${IpInstanceFS?lower_case}, Component_Addr, (uint16_t)Component_Reg, I2C_MEMADD_SIZE_8BIT, &data_tmp, 1, 100);
  data |= data_tmp;
  status = HAL_${IpNameFS}_Mem_Write(&h${IpInstanceFS?lower_case},Component_Addr,(uint16_t)Component_Reg, I2C_MEMADD_SIZE_8BIT,&data, 1, 100); 
  /* USER CODE BEGIN CHECK_STATUS */   
  /* Check the communication status */
  if(status != HAL_OK)
  {
  
  }
  /* USER CODE END CHECK_STATUS */  
  [/#if]
[/#if]
}


/**
  * @brief  MX_DriverVbusHS
  *         Drive VBUS.
  * @param  state : VBUS state
  *          This parameter can be one of the these values:
  *           0 : VBUS Active 
  *           1 : VBUS Inactive
  */
void MX_DriverVbusHS( uint8_t state) 
{ 
[#if IpNameHS?contains("GPIO")]
  if(state == 0)
  {
    /* Drive high Charge pump */
    HAL_GPIO_WritePin(${IpNameHS},${IpInstanceHS},GPIO_PIN_SET);
  }
  else
  {
    /* Drive low Charge pump */
    HAL_GPIO_WritePin(${IpNameHS},${IpInstanceHS},GPIO_PIN_RESET);
  }
[#else] 
  [#if IpNameHS="I2C"]
  uint8_t Component_Reg  = ${I2CRegHS};
  HAL_StatusTypeDef status = HAL_OK;
  [/#if]   
  [#if IpNameHS="I2C"]
  uint8_t Component_Addr = ${I2CAddrHS} << 1;  
  uint8_t data = state;
  uint8_t data_tmp = 0;
  status = HAL_${IpNameHS}_Mem_Read(&h${IpInstanceHS?lower_case}, Component_Addr, (uint16_t)Component_Reg, I2C_MEMADD_SIZE_8BIT, &data_tmp, 1, 100);
  data |= data_tmp;
  status = HAL_${IpNameHS}_Mem_Write(&h${IpInstanceHS?lower_case},Component_Addr,(uint16_t)Component_Reg, I2C_MEMADD_SIZE_8BIT,&data, 1, 100);   
  /* Check the communication status */
  if(status != HAL_OK)
  {
  
  }
  /* USER CODE BEGIN 1 */  
  /* USER CODE END 1 */  
  [/#if]
[/#if]
}