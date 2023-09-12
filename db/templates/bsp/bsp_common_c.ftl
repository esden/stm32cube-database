[#ftl]
/**
  ******************************************************************************
  * @file  : ${BoardName}.c
  * @brief : Source file for the BSP Common driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder + "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
[#assign IpInstance = ""]
[#assign UsartInstance = ""]
[#assign SpiInstance = ""]
[#assign ExtiLine = ""]
[#assign IrqNumber = ""]

[#assign useLED = false]
[#assign useBUTTON = false]
[#assign useUSART = false]

[#assign BUTTON_PORT = ""]
[#assign BUTTON_PIN = ""]
[#assign BUTTON_IRQn = ""]
[#assign BUTTON_EXTI = ""]

[#list BspIpDatas as SWIP] 
	[#if SWIP.variables??]
		[#list SWIP.variables as variables]
			[#if variables.name?contains("IpInstance")]
				[#assign IpInstance = variables.value]
			[/#if]		
			[#if variables.name?contains("GPIO_INT_NUM")]
				[#assign IrqNumber = variables.value]
			[/#if]			
			[#if variables.value?contains("BLE driver")]
				[#assign SpiInstance = IpInstance]
			[/#if]
			[#if variables.value?contains("BSP USART")]
				[#assign UsartInstance = IpInstance]
				[#assign useUSART = true]			
			[/#if]
			[#if variables.value?contains("BSP LED")]
				[#assign useLED = true]	
			[/#if]
			[#if variables.name?contains("EXTI_LINE_NUMBER")]
				[#assign ExtiLine = variables.value]
			[/#if]
			[#if variables.value?contains("BSP BUTTON")]				
				[#assign BUTTON_EXTI = ExtiLine]
				[#assign BUTTON_PORT = IpName]
				[#assign BUTTON_PIN  = IpInstance]
				[#assign BUTTON_IRQn = IrqNumber]	
				[#assign useBUTTON = true]				
			[/#if]	
		[/#list]
	[/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/ 
#include "${FamilyName?lower_case}xx_hal.h"
#include "${FamilyName?lower_case}xx_it.h"
#include "${FamilyName?lower_case}_${BoardName}.h"
[#if useBUTTON]
#include "${FamilyName?lower_case}xx_hal_exti.h"
[/#if] 

/** @defgroup BSP BSP
 * @{
 */ 

/** @defgroup ${BoardName?upper_case} ${BoardName?upper_case}
 * @{
 */   
    
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL ${BoardName?upper_case} LOW LEVEL
 *  @brief This file provides set of firmware functions to manage Leds and push-button
 *         available on ${FamilyName?upper_case}xx-Nucleo Kit from STMicroelectronics.
 * @{
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_TypesDefinitions ${BoardName?upper_case} LOW LEVEL Private TypesDefinitions
 * @{
 */
typedef void (* BSP_EXTI_LineCallback)(void);

/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Defines ${BoardName?upper_case} LOW LEVEL Private Defines
 * @{
 */ 

/**
 * @brief ${FamilyName?upper_case}XX NUCLEO BSP Driver version number V1.2.6
 */  
#define __${BoardName?upper_case}_BSP_VERSION_MAIN   (0x01) /*!< [31:24] main version */
#define __${BoardName?upper_case}_BSP_VERSION_SUB1   (0x02) /*!< [23:16] sub1 version */
#define __${BoardName?upper_case}_BSP_VERSION_SUB2   (0x06) /*!< [15:8]  sub2 version */
#define __${BoardName?upper_case}_BSP_VERSION_RC     (0x00) /*!< [7:0]  release candidate */ 
#define __${BoardName?upper_case}_BSP_VERSION        ((__${BoardName?upper_case}_BSP_VERSION_MAIN << 24)\
                                                    |(__${BoardName?upper_case}_BSP_VERSION_SUB1 << 16)\
                                                    |(__${BoardName?upper_case}_BSP_VERSION_SUB2 << 8 )\
                                                    |(__${BoardName?upper_case}_BSP_VERSION_RC))
/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_FunctionPrototypes ${BoardName?upper_case} LOW LEVEL Private Function Prototypes
 * @{
 */
[#if useBUTTON] 
static void BUTTON_KEY_EXTI_Callback(void);
[/#if]
[#if useUSART]
static void ${UsartInstance}_MspInit(UART_HandleTypeDef *huart);
static void ${UsartInstance}_MspDeInit(UART_HandleTypeDef *huart); 
[/#if]
/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Variables ${BoardName?upper_case} LOW LEVEL Private Variables
 * @{
 */
/* Private Variables -----------------------------------------------------------*/
[#if useLED]
static GPIO_TypeDef*  LED_GPIO_PORT[LEDn] = {LED2_GPIO_PORT};
static const uint16_t LED_GPIO_PIN[LEDn]  = {LED2_GPIO_PIN};
[/#if]
[#if useBUTTON]
static GPIO_TypeDef*   BUTTON_PORT[BUTTONn] = {KEY_BUTTON_GPIO_PORT}; 
static const uint16_t  BUTTON_PIN[BUTTONn]  = {KEY_BUTTON_GPIO_PIN}; 
static const IRQn_Type BUTTON_IRQn[BUTTONn] = {KEY_BUTTON_EXTI_IRQn};

EXTI_HandleTypeDef *hExtiButtonHandle[BUTTONn];
[/#if]
[#if useUSART]
USART_TypeDef* COM_USART[COMn] = {COM1_UART};
UART_HandleTypeDef hComHandle[COMn];
#if (USE_COM_LOG == 1)
static COM_TypeDef COM_ActiveLogPort;
#endif
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartInstance?lower_case?replace("u","U")}MspCbValid = 0;
#endif
__weak HAL_StatusTypeDef MX_${UsartInstance}_UART_Init(UART_HandleTypeDef* huart);
[/#if]
[#if useBUTTON]
EXTI_HandleTypeDef hexti${BUTTON_EXTI};
const uint32_t BUTTON_EXTI_LINE[BUTTONn] = {KEY_BUTTON_EXTI_LINE};
[/#if]
/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Functions ${BoardName?upper_case} LOW LEVEL Private Functions
 * @{
 */ 
/**
 * @brief  This method returns the ${FamilyName?upper_case}xx NUCLEO BSP Driver revision
 * @retval version: 0xXYZR (8bits for each decimal, R for RC)
 */
int32_t BSP_GetVersion(void)
{
  return __${BoardName?upper_case}_BSP_VERSION;
}

[#if useLED]
/**
 * @brief  Configures LED on GPIO and/or on MFX.
 * @param  Led: LED to be configured. 
 *              This parameter can be one of the following values:
 *              @arg  LED1
 *              @arg  LED2
 *              @arg  LED3
 *              @arg  LED4
 * @retval HAL status
 */
int32_t BSP_LED_Init(Led_TypeDef Led)
{
  GPIO_InitTypeDef gpio_init_structure;
  
  /* LED2 is on the same GPIO Port */
  LED2_GPIO_CLK_ENABLE();    
  
  /* Configure the GPIO_LED pin */
  gpio_init_structure.Mode  = GPIO_MODE_OUTPUT_PP;
  gpio_init_structure.Pull  = GPIO_PULLUP;
  gpio_init_structure.Speed = GPIO_SPEED_FREQ_HIGH; 
  gpio_init_structure.Pin   = LED_GPIO_PIN [Led];
  HAL_GPIO_Init(LED_GPIO_PORT [Led], &gpio_init_structure); 
  
  /* By default, turn off LED */
  HAL_GPIO_WritePin(LED_GPIO_PORT [Led], LED_GPIO_PIN [Led], GPIO_PIN_RESET);
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  DeInit LEDs.
 * @param  Led: LED to be configured. 
 *              This parameter can be one of the following values:
 *              @arg  LED1
 *              @arg  LED2
 *              @arg  LED3
 *              @arg  LED4
 * @note Led DeInit does not disable the GPIO clock nor disable the Mfx 
 * @retval HAL status
 */
int32_t BSP_LED_DeInit(Led_TypeDef Led)
{
  GPIO_InitTypeDef gpio_init_structure;
  
  /* DeInit the GPIO_LED pin */ 
  gpio_init_structure.Pin = LED_GPIO_PIN [Led];
  
  /* Turn off LED */ 
  HAL_GPIO_WritePin(LED_GPIO_PORT [Led], (uint16_t)LED_GPIO_PIN[Led], GPIO_PIN_RESET);
  HAL_GPIO_DeInit(LED_GPIO_PORT [Led], gpio_init_structure.Pin);
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Turns selected LED On.
 * @param  Led: LED to be set on 
 *              This parameter can be one of the following values:
 *              @arg  LED1
 *              @arg  LED2
 *              @arg  LED3
 *              @arg  LED4
 * @retval HAL status
 */
int32_t BSP_LED_On(Led_TypeDef Led)
{
  HAL_GPIO_WritePin(LED_GPIO_PORT [Led], (uint16_t)LED_GPIO_PIN [Led], GPIO_PIN_SET);
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Turns selected LED Off. 
 * @param  Led: LED to be set off
 *              This parameter can be one of the following values:
 *              @arg  LED1
 *              @arg  LED2
 *              @arg  LED3
 *              @arg  LED4
 * @retval HAL status
 */
int32_t BSP_LED_Off(Led_TypeDef Led)
{
  HAL_GPIO_WritePin(LED_GPIO_PORT [Led], (uint16_t)LED_GPIO_PIN [Led], GPIO_PIN_RESET);
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Toggles the selected LED.
 * @param  Led: LED to be toggled
 *              This parameter can be one of the following values:
 *              @arg  LED1
 *              @arg  LED2
 *              @arg  LED3
 *              @arg  LED4
 * @retval HAL status
 */
int32_t BSP_LED_Toggle(Led_TypeDef Led)
{
  HAL_GPIO_TogglePin(LED_GPIO_PORT[Led], (uint16_t)LED_GPIO_PIN[Led]);
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Get the status of the LED.
 * @param  Led: LED for which get the status
 *              This parameter can be one of the following values:
 *              @arg  LED1
 *              @arg  LED2
 *              @arg  LED3
 *              @arg  LED4
 * @retval HAL status (1=high, 0=low)
 */
int32_t BSP_LED_GetState(Led_TypeDef Led) 
{ 
  return (int32_t)HAL_GPIO_ReadPin(LED_GPIO_PORT [Led], LED_GPIO_PIN [Led]); 
}
[/#if]
[#if useBUTTON]
/**
  * @brief  Configures button GPIO and EXTI Line.
  * @param  Button: Button to be configured
  *                 This parameter can be one of the following values: 
  *                 @arg  BUTTON_KEY: Key Push Button
  * @param  ButtonMode Button mode
  *                    This parameter can be one of the following values:
  *                    @arg  BUTTON_MODE_GPIO: Button will be used as simple IO
  *                    @arg  BUTTON_MODE_EXTI: Button will be connected to EXTI line 
  *                                            with interrupt generation capability
  * @retval BSP status
  */
int32_t BSP_PB_Init(Button_TypeDef Button, ButtonMode_TypeDef ButtonMode)
{
  GPIO_InitTypeDef gpio_init_structure;
  hExtiButtonHandle[Button] = &hexti${BUTTON_EXTI};
  
  static BSP_EXTI_LineCallback ButtonCallback[BUTTONn] ={BUTTON_KEY_EXTI_Callback};                                                
  static uint32_t  BSP_BUTTON_PRIO [BUTTONn] ={BSP_BUTTON_KEY_IT_PRIORITY};  											     
  static const uint32_t BUTTON_EXTI_LINE[BUTTONn] ={KEY_BUTTON_EXTI_LINE};
  
  /* Enable the BUTTON clock*/ 
  KEY_BUTTON_GPIO_CLK_ENABLE();
  gpio_init_structure.Pin = BUTTON_PIN [Button];
  gpio_init_structure.Pull = GPIO_NOPULL;
  gpio_init_structure.Speed = GPIO_SPEED_FREQ_HIGH;
  
  if(ButtonMode == BUTTON_MODE_GPIO)
  {
    /* Configure Button pin as input */
    gpio_init_structure.Mode = GPIO_MODE_INPUT;    
    HAL_GPIO_Init(BUTTON_PORT [Button], &gpio_init_structure);
  }
  else if(ButtonMode == BUTTON_MODE_EXTI)
  {      
    /* Configure Button pin as input with External interrupt */    
    gpio_init_structure.Mode = GPIO_MODE_IT_RISING; 
    
    HAL_GPIO_Init(BUTTON_PORT[Button], &gpio_init_structure);
    
    HAL_EXTI_GetHandle(hExtiButtonHandle[Button], BUTTON_EXTI_LINE[Button]);  
    HAL_EXTI_RegisterCallback(hExtiButtonHandle[Button],  HAL_EXTI_COMMON_CB_ID, ButtonCallback[Button]);
      
    /* Enable and set Button EXTI Interrupt to the lowest priority */
    HAL_NVIC_SetPriority((BUTTON_IRQn[Button]), BSP_BUTTON_PRIO[Button], 0x00);
    HAL_NVIC_EnableIRQ((BUTTON_IRQn[Button]));
  }
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Push Button DeInit.
 * @param  Button Button to be configured
 *                This parameter can be one of the following values:
 *                @arg  BUTTON_KEY: Key Push Button
 * @note PB DeInit does not disable the GPIO clock
 * @retval BSP status
 */
int32_t BSP_PB_DeInit(Button_TypeDef Button)
{
  GPIO_InitTypeDef gpio_init_structure;
  
  gpio_init_structure.Pin = BUTTON_PIN[Button];
  HAL_NVIC_DisableIRQ((IRQn_Type)(BUTTON_IRQn[Button]));
  HAL_GPIO_DeInit(BUTTON_PORT[Button], gpio_init_structure.Pin);
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Returns the selected button state.
 * @param  Button Button to be checked
 *                This parameter can be one of the following values:
 *                @arg  BUTTON_KEY: Key Push Button
 * @retval The Button GPIO pin value
 */
int32_t BSP_PB_GetState(Button_TypeDef Button)
{
  return (int32_t)HAL_GPIO_ReadPin(BUTTON_PORT[Button], BUTTON_PIN[Button]);
}

/**
 * @brief  Key EXTI line detection callbacks.
 * @retval None
 */
static void BUTTON_KEY_EXTI_Callback(void)
{   
  BSP_PB_Callback(BUTTON_KEY);
}

/**
 * @brief  BSP Push Button callback
 * @param  Button Specifies the pin connected EXTI line
 * @retval None.
 */
__weak void BSP_PB_Callback(Button_TypeDef Button)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(Button);
  
  /* This function should be implemented by the user application.
     It is called into this driver when an event on Button is triggered. */   
}
[/#if]
[#if useUSART]
/**
 * @brief  Configures COM port.
 * @param  COM: COM port to be configured.
 *              This parameter can be COM1
 * @param  UART_Init: Pointer to a UART_HandleTypeDef structure that contains the
 *                    configuration information for the specified USART peripheral.
 * @retval BSP error code
 */
int32_t BSP_COM_Init(COM_TypeDef COM) 
{
#if (USE_HAL_UART_REGISTER_CALLBACKS == 0)
  /* Init the UART Msp */
  ${UsartInstance}_MspInit(&hComHandle[COM]);
#else
  if(Is${UsartInstance?lower_case?replace("u","U")}MspCbValid == 0U)
  {
    if(BSP_${UsartInstance}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
    {
      return BSP_ERROR_MSP_FAILURE;
    }
  }
#endif

  MX_${UsartInstance}_UART_Init(&hComHandle[COM]);

  return BSP_ERROR_NONE;
}

/**
 * @brief  DeInit COM port.
 * @param  COM COM port to be configured.
 *             This parameter can be COM1
 * @retval BSP status
 */
int32_t BSP_COM_DeInit(COM_TypeDef COM)
{
  /* USART configuration */
  hComHandle[COM].Instance = COM_USART[COM];
  
#if (USE_HAL_UART_REGISTER_CALLBACKS == 0)  
  ${UsartInstance}_MspDeInit(&hComHandle[COM]);  
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 0) */
  
  if(HAL_UART_DeInit(&hComHandle[COM]) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }
  
  return BSP_ERROR_NONE;
}

/**
 * @brief  Configures COM port.
 * @param  huart USART handle
 *               This parameter can be COM1
 * @param  COM_Init Pointer to a UART_HandleTypeDef structure that contains the
 *                  configuration information for the specified USART peripheral.
 * @retval HAL error code
 */
[@common.optinclude name=mxTmpFolder+"/${UsartInstance?lower_case}_CommonD_HalInit.tmp"/]

/**
 * @brief  Initializes ${UsartInstance} MSP.
 * @param  huart ${UsartInstance} handle
 * @retval None
 */
[@common.optinclude name=mxTmpFolder+"/${UsartInstance?lower_case}_CommonD_Msp.tmp"/]

#if (USE_HAL_UART_REGISTER_CALLBACKS == 1) 
/**
 * @brief Register Default ${UsartInstance} Bus Msp Callbacks
 * @retval BSP status
 */
int32_t BSP_${UsartInstance}_RegisterDefaultMspCallbacks(void)
{
  int32_t ret = BSP_ERROR_NONE;
  
  __HAL_UART_RESET_HANDLE_STATE(&hComHandle[COM1]);
  
  /* Register default MspInit/MspDeInit Callback */
  if(HAL_UART_RegisterCallback(&hComHandle[COM1], HAL_UART_MSPINIT_CB_ID, ${UsartInstance}_MspInit) != HAL_OK)
  {
    ret = BSP_ERROR_PERIPH_FAILURE;
  }
  else if(HAL_UART_RegisterCallback(&hComHandle[COM1], HAL_UART_MSPDEINIT_CB_ID, ${UsartInstance}_MspDeInit) != HAL_OK)
  {
    ret = BSP_ERROR_PERIPH_FAILURE;
  }
  else
  {
    Is${UsartInstance?lower_case?replace("u","U")}MspCbValid = 1U;
  }
  
  /* BSP status */  
  return ret;
}

/**
 * @brief Register ${UsartInstance} Bus Msp Callback registering
 * @param Callbacks pointer to ${UsartInstance} MspInit/MspDeInit callback functions
 * @retval BSP status
 */
int32_t BSP_${UsartInstance}_RegisterMspCallbacks (BSP_UART_Cb_t *Callback)
{
  int32_t ret = BSP_ERROR_NONE;
  
  __HAL_UART_RESET_HANDLE_STATE(&hComHandle[COM1]);
  
  /* Register MspInit/MspDeInit Callbacks */
  if(HAL_UART_RegisterCallback(&hComHandle[COM1], HAL_UART_MSPINIT_CB_ID, Callback->pMspUsartInitCb) != HAL_OK)
  {
    ret = BSP_ERROR_PERIPH_FAILURE;
  }
  else if(HAL_UART_RegisterCallback(&hComHandle[COM1], HAL_UART_MSPDEINIT_CB_ID, Callback->pMspUsartDeInitCb) != HAL_OK)
  {
    ret = BSP_ERROR_PERIPH_FAILURE;
  }
  else
  {
    Is${UsartInstance?lower_case?replace("u","U")}MspCbValid = 1U;
  }
  
  /* BSP status */  
  return ret; 
}
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */

#if (USE_COM_LOG == 1)
/**
 * @brief  Select the active COM port.
 * @param  COM COM port to be activated.
 *             This parameter can be COM1
 * @retval BSP status
 */
int32_t BSP_COM_SelectLogPort(COM_TypeDef COM)
{ 
  if(COM_ActiveLogPort != COM)
  {
    COM_ActiveLogPort = COM;
  } 
  return BSP_ERROR_NONE; 
}

#ifdef __GNUC__ 
 int __io_putchar (int ch) 
#else 
 int fputc (int ch, FILE *f) 
#endif /* __GNUC__ */ 
{ 
  HAL_UART_Transmit(&hComHandle[COM_ActiveLogPort], (uint8_t *)&ch, 1, COM_POLL_TIMEOUT); 
  return ch;
}
#endif /* USE_COM_LOG */ 
[/#if]

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




