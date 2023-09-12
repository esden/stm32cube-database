[#ftl]
/**
  ******************************************************************************
  * @file           : ${BoardName}_bus.h
  * @brief          : source file for the BSP BUS IO driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/

                                              
/* Includes ------------------------------------------------------------------*/
#include "${BoardName}_bus.h"
#include "${BoardName}_errno.h"
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]

#define TIMEOUT_DURATION 1000
/** @addtogroup BSP
  * @{
  */
[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
[#-- extern SPI_HandleTypeDef hbus${SpiIpInstance?lower_case};						--]
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- extern SPI_HandleTypeDef hbus${SpiIpInstance?lower_case};--]
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]	
						[#assign I2CIpInstanceList = bsp.solution]
[#-- extern I2C_HandleTypeDef hbus${I2CIpInstance?lower_case};	--]										
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- extern I2C_HandleTypeDef hbus${I2CIpInstance?lower_case}; --]
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]
[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${SpiIpInstance}_Init(SPI_HandleTypeDef* hspi);
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${SpiIpInstance}_Init(SPI_HandleTypeDef* hspi);
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${I2CIpInstance}_Init(I2C_HandleTypeDef* hi2c);											
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${I2CIpInstance}_Init(I2C_HandleTypeDef* hi2c);
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]


/** @addtogroup ${BoardName?upper_case}
  * @{
  */

/** @defgroup ${BoardName?upper_case}_BUS ${BoardName?upper_case} BUS
  * @{
  */

/** @defgroup ${BoardName?upper_case}_Private_Variables BUS Private Variables
  * @{
  */
[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
SPI_HandleTypeDef hbus${SpiIpInstance?lower_case};						
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
SPI_HandleTypeDef hbus${SpiIpInstance?lower_case};
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
I2C_HandleTypeDef hbus${I2CIpInstance?lower_case};											
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
I2C_HandleTypeDef hbus${I2CIpInstance?lower_case};
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]
[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)						
static uint32_t Is${SpiIpInstance}MspCbValid = 0;	
#endif /* USE_HAL_SPI_REGISTER_CALLBACKS */			
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)
static uint32_t Is${SpiIpInstance}MspCbValid = 0;	
#endif /* USE_HAL_SPI_REGISTER_CALLBACKS */
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)
static uint32_t Is${I2CIpInstance}MspCbValid = 0;										
#endif /* USE_HAL_I2C_REGISTER_CALLBACKS */				
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)
static uint32_t Is${I2CIpInstance}MspCbValid = 0;											
#endif /* USE_HAL_I2C_REGISTER_CALLBACKS */
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]  
/**
  * @}
  */


/** @defgroup ${BoardName?upper_case}_Private_FunctionPrototypes  Private Function Prototypes
  * @{
  */  

[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
static void ${SpiIpInstance}_MspInit(SPI_HandleTypeDef* spiHandle); 
static void ${SpiIpInstance}_MspDeInit(SPI_HandleTypeDef* spiHandle);
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
static void ${SpiIpInstance}_MspInit(SPI_HandleTypeDef* spiHandle); 
static void ${SpiIpInstance}_MspDeInit(SPI_HandleTypeDef* spiHandle);
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
static void ${I2CIpInstance}_MspInit(I2C_HandleTypeDef* i2cHandle); 
static void ${I2CIpInstance}_MspDeInit(I2C_HandleTypeDef* i2cHandle);
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
static void ${I2CIpInstance}_MspInit(I2C_HandleTypeDef* i2cHandle); 
static void ${I2CIpInstance}_MspDeInit(I2C_HandleTypeDef* i2cHandle);
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]

/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Functions ${BoardName?upper_case} LOW LEVEL Private Functions
  * @{
  */ 
  
/** @defgroup ${BoardName?upper_case}_BUS_Exported_Functions ${BoardName?upper_case}_BUS Exported Functions
  * @{
  */   
[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
/* BUS IO driver over SPI Peripheral */
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
						[@generateBspSPI_Driver SpiIpInstance/]						
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
						[@generateBspSPI_Driver SpiIpInstance/]
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
/* BUS IO driver over I2C Peripheral */
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
						[@generateBspI2C_Driver I2CIpInstance/]						
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
						[@generateBspI2C_Driver I2CIpInstance/]
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]

[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
						[@registerMspSpiCallBack IpName SpiIpInstance SpiIpInstance/]						
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
						[@registerMspSpiCallBack IpName SpiIpInstance SpiIpInstance/]
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
						[@registerMspI2CCallBack IpName I2CIpInstance I2CIpInstance/]						
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
						[@registerMspI2CCallBack IpName I2CIpInstance I2CIpInstance/]
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]

[#-- macro generateBspI2C_Driver --]
[#macro generateBspI2C_Driver IpInstance]
/*******************************************************************************
                            BUS OPERATIONS OVER I2C
*******************************************************************************/
/**
  * @brief  Initialize a bus
  * @param None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void) {

  int32_t ret = BSP_ERROR_NONE;
  
  hbus${IpInstance?lower_case}.Instance  = ${IpInstance?upper_case};

  if (HAL_I2C_GetState(&hbus${IpInstance?lower_case}) == HAL_I2C_STATE_RESET)
  {  
    #if (USE_HAL_I2C_REGISTER_CALLBACKS == 0)
      /* Init the I2C Msp */
      ${IpInstance?upper_case}_MspInit(&hbus${IpInstance?lower_case});
    #else
      if(Is${I2CIpInstance}MspCbValid == 0U)
      {
        if(BSP_${IpInstance?upper_case}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
        {
          return BSP_ERROR_MSP_FAILURE;
        }
      }
    #endif

    /* Init the I2C */
    if(MX_${IpInstance}_Init(&hbus${IpInstance?lower_case}) != HAL_OK)
    {
      ret = BSP_ERROR_BUS_FAILURE;
    }
	[#if FamilyName.contains("STM32L1")]
	[#else]
    else if(HAL_I2CEx_ConfigAnalogFilter(&hbus${IpInstance?lower_case}, I2C_ANALOGFILTER_ENABLE) != HAL_OK) 
    {
      ret = BSP_ERROR_BUS_FAILURE;
    }
	[/#if]
    else
    {
      ret = BSP_ERROR_NONE;
    }	
  }

  return ret;
}


/**
  * @brief  DeInitialize a bus
  * @param None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  #if (USE_HAL_I2C_REGISTER_CALLBACKS == 0)
    /* DeInit the I2C */ 
    ${IpInstance?upper_case}_MspDeInit(&hbus${IpInstance?lower_case});
  #endif  
  
  if (HAL_I2C_DeInit(&hbus${IpInstance?lower_case}) == HAL_OK) {
    ret = BSP_ERROR_NONE;
  }
  
  return ret;
}

/**
  * @brief Return the status of the Bus
  *	@retval bool
  */
int32_t BSP_${IpInstance}_IsReady(void) {
	return (HAL_I2C_GetState(&hbus${IpInstance?lower_case}) == HAL_I2C_STATE_READY);
}


/**
  * @brief  Write registers through bus (8 bits)
  * @param  Addr: Device address on Bus.
  * @param  Reg: The target register address to write
  * @param  Value: The target register value to be written
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_WriteReg(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;

  if(HAL_I2C_Mem_Write(&hbus${IpInstance?lower_case}, (uint8_t)DevAddr,
                       (uint16_t)Reg, I2C_MEMADD_SIZE_8BIT,
                       (uint8_t *)pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }

  return ret;
}


/**
  * @brief  Read registers through a bus (8 bits)
  * @param  DevAddr: Device address on BUS
  * @param  Reg: The target register address to read
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_ReadReg(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;

  if (HAL_I2C_Mem_Read(&hbus${IpInstance?lower_case}, DevAddr, (uint16_t)Reg,
                       I2C_MEMADD_SIZE_8BIT, pData,
                       len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = HAL_OK;
  }

  return ret;
}


/**
  * @brief  Write registers through bus (16 bits)
  * @param  Addr: Device address on Bus.
  * @param  Reg: The target register address to write
  * @param  Value: The target register value to be written
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_WriteReg16(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if(HAL_I2C_Mem_Write(&hbus${IpInstance?lower_case}, (uint8_t)DevAddr,
                       (uint16_t)Reg, I2C_MEMADD_SIZE_16BIT,
                       (uint8_t *)pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
 
  return ret;
}


/**
  * @brief  Read registers through a bus (16 bits)
  * @param  DevAddr: Device address on BUS
  * @param  Reg: The target register address to read
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_ReadReg16(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if (HAL_I2C_Mem_Read(&hbus${IpInstance?lower_case}, DevAddr, (uint16_t)Reg,
                       I2C_MEMADD_SIZE_16BIT, pData,
                       len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  
  return ret;
}


/**
  * @brief  Send an amount width data through bus (Simplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pData: Data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t len) {
	int32_t ret = BSP_ERROR_BUS_FAILURE;

	if (HAL_I2C_Master_Transmit (&hbus${IpInstance?lower_case}, DevAddr, pData, len, TIMEOUT_DURATION) == HAL_OK) {
		ret = len;
	}

	return ret;
}


/**
  * @brief  Receive an amount of data through a bus (Simplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pData: Data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t len) {
	int32_t ret = BSP_ERROR_BUS_FAILURE;

	if (HAL_I2C_Master_Receive (&hbus${IpInstance?lower_case}, DevAddr, pData, len, TIMEOUT_DURATION) == HAL_OK) {
		ret = len;
	}

	return ret;
}

/**
  * @brief  Send and receive an amount of data through bus (Full duplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pTxdata: Transmit data pointer
  * @param 	pRxdata: Receive data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxdata, uint8_t *pRxdata, uint16_t len) {
	int32_t ret = BSP_ERROR_BUS_FAILURE;
	
	/*
	 * Send and receive an amount of data through bus (Full duplex)
	 * I2C is Half-Duplex protocol
	 */
	if ((BSP_${IpInstance}_Send(DevAddr, pTxdata, len) == len) && \
		(BSP_${IpInstance}_Recv(DevAddr, pRxdata, len) == len))
			{
				ret = len;
			}
			
	return ret;
}
[/#macro]
[#-- End macro generateBspI2C_Driver --]

[#-- macro generateBspSPI_Driver --]
[#macro generateBspSPI_Driver IpInstance]
/*******************************************************************************
                            BUS OPERATIONS OVER SPI
*******************************************************************************/
/**
  * @brief  Initializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void) {
  int32_t ret = BSP_ERROR_NONE;
  
  hbus${IpInstance?lower_case}.Instance  = ${IpInstance?upper_case};
  if (HAL_SPI_GetState(&hbus${IpInstance?lower_case}) == HAL_SPI_STATE_RESET) 
  { 
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 0)
    /* Init the SPI Msp */
    ${IpInstance?upper_case}_MspInit(&hbus${IpInstance?lower_case});
#else
    if(Is${SpiIpInstance}MspCbValid == 0U)
    {
      if(BSP_${IpInstance?upper_case}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
      {
        return BSP_ERROR_MSP_FAILURE;
      }
    }
#endif   
    
    /* Init the SPI */
    if (MX_${IpInstance}_Init(&hbus${IpInstance?lower_case}) != HAL_OK)
    {
      ret = BSP_ERROR_BUS_FAILURE;
    }
  } 

  return ret;
}


/**
  * @brief  DeInitializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 0)
  ${IpInstance?upper_case}_MspDeInit(&hbus${IpInstance?lower_case});
#endif  
  
  if (HAL_SPI_DeInit(&hbus${IpInstance?lower_case}) == HAL_OK) {
    ret = BSP_ERROR_NONE;
  }
  
  return ret;
}


/**
  * @brief  Write Data through SPI BUS.
  * @param  pData: Data
  * @param  len: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t len)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_Transmit(&hbus${IpInstance?lower_case}, pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}


/**
  * @brief  Receive Data from SPI BUS
  * @param  pData: Data
  * @param  len: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t len)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_Receive(&hbus${IpInstance?lower_case}, pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}


/**
  * @brief  Send and Receive data to/from SPI BUS (Full duplex)
  * @param  pData: Data
  * @param  len: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv(uint8_t *pTxData, uint8_t *pRxData, uint16_t len)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_TransmitReceive(&hbus${IpInstance?lower_case}, pTxData, pRxData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}
[/#macro]
[#-- End macro generateBspSPI_Driver --]

/**
  * @brief  Return system tick in ms
  * @retval Current HAL time base time stamp
  */
int32_t BSP_GetTick(void) {
  return HAL_GetTick();
}

[#-- macro registerMspSpiCallBack --]
[#macro registerMspSpiCallBack IpName IpInstance IpHandle]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)  
/**
  * @brief Register Default BSP ${IpInstance} Bus Msp Callbacks
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void)
{

  __HAL_${IpName}_RESET_HANDLE_STATE(&hbus${IpHandle?lower_case});
  
  /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, ${IpInstance}_MspInit)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, ${IpInstance}_MspDeInit) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  Is${IpInstance}MspCbValid = 1;
  
  return BSP_ERROR_NONE;  
}

/**
  * @brief BSP ${IpInstance} Bus Msp Callback registering
  * @param Callbacks     pointer to ${IpInstance} MspInit/MspDeInit callback functions
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_${IpName}_Cb_t *Callbacks)
{
  /* Prevent unused argument(s) compilation warning */
  __HAL_${IpName}_RESET_HANDLE_STATE(&hbus${IpHandle?lower_case});  
 
   /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, Callbacks->pMspSpiInitCb)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, Callbacks->pMspSpiDeInitCb) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  Is${IpInstance}MspCbValid = 1;
  
  return BSP_ERROR_NONE;  
}
#endif /* USE_HAL_SPI_REGISTER_CALLBACKS */
[/#macro]
[#-- End macro registerMspSpiCallBack --]

[#-- macro registerMspI2CCallBack --]
[#macro registerMspI2CCallBack IpName IpInstance IpHandle]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)  
/**
  * @brief Register Default BSP ${IpInstance} Bus Msp Callbacks
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void)
{

  __HAL_${IpName}_RESET_HANDLE_STATE(&hbus${IpHandle?lower_case});
  
  /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, ${IpInstance}_MspInit)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, ${IpInstance}_MspDeInit) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  Is${IpInstance}MspCbValid = 1;
  
  return BSP_ERROR_NONE;  
}

/**
  * @brief BSP ${IpInstance} Bus Msp Callback registering
  * @param Callbacks     pointer to ${IpInstance} MspInit/MspDeInit callback functions
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_${IpName}_Cb_t *Callbacks)
{
  /* Prevent unused argument(s) compilation warning */
  __HAL_${IpName}_RESET_HANDLE_STATE(&hbus${IpHandle?lower_case});  
 
   /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, Callbacks->pMspI2cInitCb)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&hbus${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, Callbacks->pMspI2cDeInitCb) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  Is${IpInstance}MspCbValid = 1;
  
  return BSP_ERROR_NONE;  
}
#endif /* USE_HAL_I2C_REGISTER_CALLBACKS */
[/#macro]
[#-- End macro registerMspI2CCallBack --]

[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
[#if SpiIpInstanceList??]
    [#assign spiInsts = SpiIpInstanceList?split(",")]
    [#list spiInsts as SpiIpInst]
        [#if SpiIpInst??]
            [@common.optinclude name=mxTmpFolder+"/${SpiIpInst?lower_case}_IOBus_HalInit.tmp"/]
            [@common.optinclude name=mxTmpFolder+"/${SpiIpInst?lower_case}_IOBus_Msp.tmp"/]
        [/#if]
    [/#list]
[/#if]
[#if I2CIpInstanceList??]
    [#assign i2cInsts = I2CIpInstanceList?split(",")]
    [#list i2cInsts as I2CIpInst]
        [#if I2CIpInst??]
            [@common.optinclude name=mxTmpFolder+"/${I2CIpInst?lower_case}_IOBus_HalInit.tmp"/]
            [@common.optinclude name=mxTmpFolder+"/${I2CIpInst?lower_case}_IOBus_Msp.tmp"/]
        [/#if]
    [/#list]
[/#if]

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
