[#ftl]
/**
  ******************************************************************************
  * @file           : ${BoardName}_bus.c
  * @brief          : source file for the BSP BUS IO driver over SPI
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
[#assign IpInstance = ""]
[#assign IpHandle = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.variables??]
		[#list SWIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
		[/#if]
		[#if variables.name?contains("IpInstance")]
			[#assign IpInstance = variables.value]
			[#assign IpHandle = IpInstance?lower_case]
		[/#if]	
		[/#list]
	[/#if]
[/#list]	
                                              
/* Includes ------------------------------------------------------------------*/
#include "${BoardName}_bus.h"
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]
/** @defgroup BSP BSP
  * @{
  */ 

/** @defgroup ${BoardName?upper_case}
  * @{
  */
  
extern void MX_${IpInstance}_Init(void);
extern SPI_HandleTypeDef h${IpHandle};

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)
uint32_t IsSpi1MspCbValid = 0;
#endif /* USE_HAL_SPI_REGISTER_CALLBACKS */

/**
  * @}
  */ 

/** @defgroup ${BoardName?upper_case}_Private_FunctionPrototypes  Private Function Prototypes
  * @{
  */  
#define TIMEOUT_DURATION 1000

/* To be updtated with Amel
static void SPI1_MspInit(SPI_HandleTypeDef* spiHandle);
static void SPI1_MspDeInit(SPI_HandleTypeDef* spiHandle);
*/
[#-- A.T/ Include SPIx_MspInit() --]
[@common.optinclude name=mxTmpFolder+"/${IpInstance?lower_case}_IOBus_Msp.tmp"/]

/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Functions ${BoardName?upper_case} LOW LEVEL Private Functions
  * @{
  */ 

  
/*******************************************************************************
                            BUS OPERATIONS
*******************************************************************************/
/**
  * @brief  Initializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void) {

  if (HAL_SPI_GetState(&h${IpHandle}) == HAL_SPI_STATE_RESET) {
		MX_${IpInstance}_Init();
  }

  return BSP_ERROR_NONE;
}


/**
  * @brief  DeInitializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if (HAL_SPI_DeInit(&h${IpHandle}) == HAL_OK) {
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
  
  if(HAL_SPI_Transmit(&h${IpHandle}, pData, len, TIMEOUT_DURATION) == HAL_OK)
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
  
  if(HAL_SPI_Receive(&h${IpHandle}, pData, len, TIMEOUT_DURATION) == HAL_OK)
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
  
  if(HAL_SPI_TransmitReceive(&h${IpHandle}, pTxData, pRxData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}


/**
  * @brief  Return system tick (ms) function .
  * @retval Current HAL time base time stamp
  */
int32_t BSP_GetTick(void)
{
  return HAL_GetTick();
}

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)  
/**
  * @brief Default BSP I2C2 Bus Msp Callbacks
  * @param Instance    I2C instance
  * @retval BSP status
  */
int32_t BSP_BUS_RegisterDefaultMspCallbacks (uint32_t Instance)
{
  /* Prevent unused argument(s) compilation warning */  
  UNUSED(Instance);

  __HAL_SPI_RESET_HANDLE_STATE(&h{IpHandle},);
  
  /* Register MspInit Callback */
  HAL_SPI_RegisterCallback(&h{IpHandle}, HAL_SPI_MSPINIT_CB_ID, SPI1_MspInit);
  
  /* Register MspDeInit Callback */
  HAL_SPI_RegisterCallback(&h{IpHandle}, HAL_SPI_MSPDEINIT_CB_ID, SPI1_MspDeInit);
  
  IsSpi1MspCbValid = 1;
  
  return BSP_ERROR_NONE;  
}
#endif
/**
  * @}
  */

/** @addtogroup ${BoardName?upper_case}_BUS_Private_Function_Prototypes
  * @{
  */
/**
  * @brief  Initializes SPI MSP.
  * @param  spiHandle  SPI handler
  * @retval None
  */
/*  
static void ${IpInstance}_MspInit(SPI_HandleTypeDef* spiHandle)
{
 
}
*/

/**
  * @brief  DeInitializes SPI MSP.
  * @param  spiHandle  SPI handler
  * @retval None
  */
/*  
static void ${IpInstance}_MspDeInit(SPI_HandleTypeDef* spiHandle)
{
 
} 
*/ 

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
