[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : usbh_platform.c

  * @brief          : This file implements the USB platform
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- BspIpDatas is a list of SWIPconfigModel --]  
[#assign instNameFS = ""]
[#assign instNameHS = ""]

[#assign IpNameFS = ""]
[#assign IpInstanceFS = ""]
[#assign I2CRegFS = "0"]
[#assign I2CAddrFS = "0"]
[#assign IpNameHS = ""]
[#assign IpInstanceHS = ""]
[#assign I2CRegHS = "0"]
[#assign I2CAddrHS = "0"]

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
		[/#list]
	[/#if]
[/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "usbh_platform.h"

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

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
[#if IpInstanceFS !=IpInstanceHS]
extern ${IpNameHS}_HandleTypeDef h${IpInstanceHS?lower_case};
[/#if]
[/#if]
[/#if]

[#if IpNameFS != ""]
/**
  * @brief  Drive VBUS.
  * @param  state : VBUS state
  *          This parameter can be one of the these values:
  *           - 1 : VBUS Active
  *           - 0 : VBUS Inactive
  */
void MX_DriverVbusFS(uint8_t state)
{ 
[#if IpNameFS?contains("GPIO")]
  uint8_t data = state; 
  /* USER CODE BEGIN PREPARE_GPIO_DATA_VBUS_FS */
  if(state == 0)
  {
    /* Drive high Charge pump */ 	     
    data = GPIO_PIN_RESET;
  }
  else
  {
    /* Drive low Charge pump */
    data = GPIO_PIN_SET;
  }
  /* USER CODE END PREPARE_GPIO_DATA_VBUS_FS */
  HAL_GPIO_WritePin(${IpNameFS},${IpInstanceFS},(GPIO_PinState)data);
[#else] 
  [#if IpNameFS?contains("I2C")]
  /* USER CODE BEGIN PREPARE_I2C_REG_VBUS_FS */
  uint8_t Component_Reg  = ${I2CRegFS};
  /* USER CODE END PREPARE_I2C_REG_VBUS_FS */
  HAL_StatusTypeDef status = HAL_OK;
  [/#if]   
  [#if IpNameFS?contains("I2C")]
  /* USER CODE BEGIN PREPARE_I2C_ADDR_VBUS_FS */
  uint8_t Component_Addr = ${I2CAddrFS} << 1;  
  /* USER CODE END PREPARE_I2C_ADDR_VBUS_FS */ 
  /* USER CODE BEGIN PREPARE_I2C_DATA_VBUS_FS */
  uint8_t data = state;
  /* USER CODE END PREPARE_I2C_DATA_VBUS_FS */
  uint8_t data_tmp = 0;
  status = HAL_${IpNameFS}_Mem_Read(&h${IpInstanceFS?lower_case}, Component_Addr, (uint16_t)Component_Reg, ${IpNameFS}_MEMADD_SIZE_8BIT, &data_tmp, 1, 100);
  data |= data_tmp;
  status = HAL_${IpNameFS}_Mem_Write(&h${IpInstanceFS?lower_case},Component_Addr,(uint16_t)Component_Reg, ${IpNameFS}_MEMADD_SIZE_8BIT,&data, 1, 100);
  /* USER CODE BEGIN CHECK_STATUS_VBUS_FS */
  /* Check the communication status */
  if(status != HAL_OK)
  {
  
  }
  /* USER CODE END CHECK_STATUS_VBUS_FS */
  [/#if]
[/#if]
}
[/#if]

[#if IpNameHS != ""]
/**
  * @brief  Drive VBUS.
  * @param  state : VBUS state
  *          This parameter can be one of the these values:
  *          - 1 : VBUS Active
  *          - 0 : VBUS Inactive
  */
void MX_DriverVbusHS(uint8_t state)
{ 
[#if IpNameHS?contains("GPIO")]
  uint8_t data = state; 
  /* USER CODE BEGIN PREPARE_GPIO_DATA_VBUS_HS */
  if(state == 0)
  {
    /* Drive high Charge pump */ 	     
    data = GPIO_PIN_SET;
  }
  else
  {
    /* Drive low Charge pump */
    data = GPIO_PIN_RESET;
  }
  /* USER CODE END PREPARE_GPIO_DATA_VBUS_HS */
  HAL_GPIO_WritePin(${IpNameHS},${IpInstanceHS},(GPIO_PinState)data);
[#else] 
  [#if IpNameHS?contains("I2C")]
  /* USER CODE BEGIN PREPARE_I2C_REG_VBUS_HS */
  uint8_t Component_Reg  = ${I2CRegHS};
  /* USER CODE END PREPARE_I2C_REG_VBUS_HS */
  HAL_StatusTypeDef status = HAL_OK;
  [/#if]   
  [#if IpNameHS?contains("I2C")]
   /* USER CODE BEGIN PREPARE_I2C_ADDR_VBUS_HS */
  uint8_t Component_Addr = ${I2CAddrHS} << 1;  
  /* USER CODE END PREPARE_I2C_ADDR_VBUS_HS */ 
  /* USER CODE BEGIN PREPARE_DATA_VBUS_HS */
  uint8_t data = state;
  /* USER CODE END PREPARE_DATA_VBUS_HS */
  uint8_t data_tmp = 0;
  status = HAL_${IpNameHS}_Mem_Read(&h${IpInstanceHS?lower_case}, Component_Addr, (uint16_t)Component_Reg, ${IpNameHS}_MEMADD_SIZE_8BIT, &data_tmp, 1, 100); 
  data |= data_tmp;
  status = HAL_${IpNameHS}_Mem_Write(&h${IpInstanceHS?lower_case},Component_Addr,(uint16_t)Component_Reg, ${IpNameHS}_MEMADD_SIZE_8BIT,&data, 1, 100);  
  /* USER CODE BEGIN CHECK_STATUS_VBUS_HS */
  /* Check the communication status */
  if(status != HAL_OK)
  {
  
  }
  /* USER CODE END CHECK_STATUS_VBUS_HS */
  [/#if]
[/#if]
}
[/#if]

