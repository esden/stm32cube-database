[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file  : ${BoardName}.c
  * @brief : Source file for the BSP Common driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder + "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */
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

[#assign useDefine = false]
[#assign useEXTI = false]

[#assign halMode = false]
[#assign halModeName = ""]
[#if HalExtiUseDefine??]
[#if HalExtiUseDefine == "true"]
[#assign useDefine = true]
[/#if]
[/#if]

[#assign numLed = NumberOfLed?number]
[#assign numButton = NumberOfButton?number]

[#if numLed > 0]
	[#assign useLED = true]		
[/#if] 

[#if numButton > 0]
	[#assign useBUTTON = true]		
[/#if]

[#if FamilyName?matches("STM32W(B0|L3)*")]
    [#assign virtualEXTI=true]
[#else]
    [#assign virtualEXTI=false]
[/#if]

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
	[#-- BZ 94093 --]
    [#if SWIP.bsp??]    
     	[#list SWIP.bsp as bsp]
     		[#if bsp.bspName?contains("BSP BUTTON")]
     			[#if bsp.bspIpModeName?contains("EXTI")]
     				[#assign useEXTI = true]  
     				[/#if]  
     		[/#if]
     		[#if bsp.bspName?contains("BSP USART")]
     			[#assign ipName = bsp.ipNameUsed]
     			[#if bsp.halMode == ipName]
     				[#assign halMode = true]
     			[#else]	  
     				[#assign halModeName = bsp.halMode]	
     			[/#if]  
     		[/#if]     		
     	[/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/ 
[#--#include "${FamilyName?lower_case}${BoardName}.h"--]
#include "${BoardName}.h"
[#if useBUTTON && !virtualEXTI ]
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

/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Defines ${BoardName?upper_case} LOW LEVEL Private Defines
 * @{
 */ 


/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_FunctionPrototypes ${BoardName?upper_case} LOW LEVEL Private Function Prototypes
 * @{
 */
[#if useBUTTON] 
typedef void (* BSP_EXTI_LineCallback) (void);
typedef void (* BSP_BUTTON_GPIO_Init) (void);
[/#if]

/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Variables ${BoardName?upper_case} LOW LEVEL Private Variables
 * @{
 */
[#if useLED]
typedef void (* BSP_LED_GPIO_Init) (void);
	[#if numLed = 1]
static GPIO_TypeDef*  LED_PORT[LEDn] = {LED2_GPIO_PORT};
static const uint16_t LED_PIN[LEDn]  = {LED2_PIN};
static void LED_USER_GPIO_Init(void);
	[#else]
		[#-- assign first value for the LED --]
		[#assign LED_GPIO_PORT=""]
		[#assign LED_PIN=""]
		[#list BspIpDatas as SWIP] 
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            		
            		[#-- User BSP Led --]
            		[#if variables.value?contains("BSP LED ") ] 
              			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]            
						[#assign LED_GPIO_PORT = LED_GPIO_PORT + "LED" + i + "_GPIO_PORT" + ","]
						[#assign LED_PIN = LED_PIN + "LED" + i + "_PIN" + ","]
static void LED_USER_${i}_GPIO_Init(void);
			 		[/#if]                   												                       
        		[/#list]
    		[/#if]
		[/#list] 
static GPIO_TypeDef*  LED_PORT[LEDn] = {${LED_GPIO_PORT}};
static const uint16_t LED_PIN[LEDn]  = {${LED_PIN}};
	[/#if]
[/#if]



[#if useBUTTON]
	[#if numButton = 1]
static GPIO_TypeDef*   BUTTON_PORT[BUTTONn] = {USER_BUTTON_GPIO_PORT}; 
static const uint16_t  BUTTON_PIN[BUTTONn]  = {USER_BUTTON_PIN}; 		
static const IRQn_Type BUTTON_IRQn[BUTTONn] = {USER_BUTTON_EXTI_IRQn};		
	[/#if]
	[#assign BUTTON_EXTI_LINE= ""]
	[#if numButton > 1]
		[#assign BUTTON_GPIO_PORT=""]
		[#assign BUTTON_PIN=""]
		[#assign BUTTON_IRQN=""]
		[#assign BUTTON_EXTI_LINE= ""]
		[#list BspIpDatas as SWIP] 
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            
            		[#if variables.name?contains("GPIO_INT_NUM")]
                		[#assign IrqNumber = variables.value]				
            		[/#if]
            		[#if variables.name?contains("EXTI_LINE_NUMBER")]
                		[#assign ExtiLine = variables.value]				
            		[/#if]		
            		[#-- User BSP Button --]
            		[#if variables.value?contains("BSP BUTTON ") ]             		 	
            			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
            			[#assign BUTTON_GPIO_PORT = BUTTON_GPIO_PORT + "USER_BUTTON_" + i + "_GPIO_PORT" + ","]
						[#assign BUTTON_PIN = BUTTON_PIN + "USER_BUTTON_" + i + "_PIN" + ","]
						[#if useEXTI] 							
							[#assign BUTTON_IRQN = BUTTON_IRQN + "USER_BUTTON_" + i + "_EXTI_IRQn" + ","]  
							[#assign BUTTON_EXTI_LINE = BUTTON_EXTI_LINE + ".Line = USER_BUTTON_" + i + "_EXTI_LINE" + ","] 
						[/#if]        
            		[/#if]
            	[/#list]
			[/#if]
		[/#list]
static GPIO_TypeDef*   BUTTON_PORT[BUTTONn] = {${BUTTON_GPIO_PORT}}; 
static const uint16_t  BUTTON_PIN[BUTTONn]  = {${BUTTON_PIN}}; 
			[#if useEXTI]
static const IRQn_Type BUTTON_IRQn[BUTTONn] = {${BUTTON_IRQN}};
			[/#if]
	[/#if]
[#if !virtualEXTI ]
[#if useDefine]
	[#if numButton = 1]
EXTI_HandleTypeDef hpb_exti[BUTTONn] = {{.Line = EXTI_LINE_${BUTTON_EXTI}}};
	[#else]	
EXTI_HandleTypeDef hpb_exti[BUTTONn] = {{${BUTTON_EXTI_LINE}}};
	[/#if]
[#else]
EXTI_HandleTypeDef* hpb_exti[BUTTONn];
[/#if]
[/#if]
[/#if]
[#if useUSART]
USART_TypeDef* COM_USART[COMn] = {COM1_UART};
[#--UART_HandleTypeDef hComHandle[COMn];--]
[#-- Bug 61525 --]
UART_HandleTypeDef hcom_uart[COMn];
#if (USE_COM_LOG > 0)
static COM_TypeDef COM_ActiveLogPort;
#endif
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartInstance?lower_case?replace("u","U")}MspCbValid = 0;
#endif
[#if halMode]
__weak HAL_StatusTypeDef MX_${UsartInstance}_Init(UART_HandleTypeDef* huart);
[#else]
__weak HAL_StatusTypeDef MX_${UsartInstance}_${halModeName}_Init(UART_HandleTypeDef* huart);
[/#if]
[/#if]
[#if useBUTTON]
[#-- Bug 60723 --]
[#-- Bug 50684 --]
[#if useDefine]
[#-- here we must initialize the handle with the correct exti line number --]
[#else]
	[#if numButton = 1]
EXTI_HandleTypeDef hexti${BUTTON_EXTI} = {.Line = EXTI_LINE_${BUTTON_EXTI}};
    [/#if]
	[#if numButton > 1]	
[#-- A verifier --]		
EXTI_HandleTypeDef hpb_exti[BUTTONn] = {{${BUTTON_EXTI_LINE}}};
	[/#if]
[/#if]
[/#if]
/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Private_Functions ${BoardName?upper_case} LOW LEVEL Private Functions
 * @{
 */ 
[#if useBUTTON]
	[#if numButton = 1]
        [#if virtualEXTI ]
void HAL_GPIO_EXTI_Callback(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
        [#else]
static void BUTTON_USER_EXTI_Callback(void);
        [/#if]
static void BUTTON_USER_GPIO_Init(void);
	[/#if]
	[#if numButton > 1]
		[#list BspIpDatas as SWIP] 
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            
            		[#if variables.name?contains("GPIO_INT_NUM")]
                		[#assign IrqNumber = variables.value]				
            		[/#if]
            		[#if variables.name?contains("EXTI_LINE_NUMBER")]
                		[#assign ExtiLine = variables.value]				
            		[/#if]		
            		[#-- User BSP Button --]
            		[#if variables.value?contains("BSP BUTTON ") ] 	
            			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]            	
static void BUTTON_USER_${i}_EXTI_Callback(void);
static void BUTTON_USER_${i}_GPIO_Init(void);
             		[/#if]
            	[/#list]
			[/#if]
		[/#list]
	[/#if]
[/#if]
[#if useUSART]
#if (USE_BSP_COM_FEATURE > 0)
static void ${UsartInstance}_MspInit(UART_HandleTypeDef *huart);
static void ${UsartInstance}_MspDeInit(UART_HandleTypeDef *huart); 
#endif
[/#if]
/**
 * @brief  This method returns the ${FamilyName?upper_case}xx NUCLEO BSP Driver revision
 * @retval version: 0xXYZR (8bits for each decimal, R for RC)
 */
int32_t BSP_GetVersion(void)
{
  return (int32_t)__${BoardName?upper_case}_BSP_VERSION;
}

[#if useLED]
/**
 * @brief  Configures LED on GPIO and/or on MFX.
 * @param  Led: LED to be configured. 
 *              This parameter can be one of the following values:
 *              @arg  LED2, LED4, ...            
 * @retval HAL status
 */
int32_t BSP_LED_Init(Led_TypeDef Led)
{
[#if numLed = 1]
  static const BSP_LED_GPIO_Init LedGpioInit[LEDn] = {LED_USER_GPIO_Init};
[#else]
	[#assign LED_USER_GPIO_Init=""]
	[#list BspIpDatas as SWIP] 			
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            		
            		[#-- User BSP Led --]
            		[#if variables.value?contains("BSP LED ") ]             		
              			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]                			        
						[#assign LED_USER_GPIO_Init = LED_USER_GPIO_Init + "LED_USER_" + i + "_GPIO_Init" + ","]						
			 		[/#if]                   												                       
        		[/#list]
    		[/#if]
		[/#list] 
  static const BSP_LED_GPIO_Init LedGpioInit[LEDn] = {${LED_USER_GPIO_Init}};
[/#if]
  [#-- 
  GPIO_InitTypeDef GPIO_InitStruct;
  
  /* LED2 is on the same GPIO Port */
  LED2_GPIO_CLK_ENABLE();    
  
  /* Configure the GPIO_LED pin */
  GPIO_InitStruct.Pin   = LED_PIN [Led];
  GPIO_InitStruct.Mode  = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull  = GPIO_PULLUP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH; 
  
  HAL_GPIO_Init(LED_PORT [Led], &GPIO_InitStruct); 
  HAL_GPIO_WritePin(LED_PORT [Led], LED_PIN [Led], GPIO_PIN_RESET);
  --]
  LedGpioInit[Led]();
  return BSP_ERROR_NONE;
}

/**
 * @brief  DeInit LEDs.
 * @param  Led: LED to be configured. 
 *              This parameter can be one of the following values:
 *              @arg  LED2, LED4, ... 
 * @note Led DeInit does not disable the GPIO clock nor disable the Mfx 
 * @retval HAL status
 */
int32_t BSP_LED_DeInit(Led_TypeDef Led)
{
  GPIO_InitTypeDef  gpio_init_structure;

  /* Turn off LED */
  HAL_GPIO_WritePin(LED_PORT[Led], LED_PIN[Led], GPIO_PIN_RESET);
  /* DeInit the GPIO_LED pin */
  gpio_init_structure.Pin = LED_PIN[Led];
  HAL_GPIO_DeInit(LED_PORT[Led], gpio_init_structure.Pin);

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
  HAL_GPIO_WritePin(LED_PORT [Led], LED_PIN [Led], GPIO_PIN_SET);
  
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
  HAL_GPIO_WritePin(LED_PORT [Led], LED_PIN [Led], GPIO_PIN_RESET);
  
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
  HAL_GPIO_TogglePin(LED_PORT[Led], LED_PIN[Led]);

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
  return (int32_t)(HAL_GPIO_ReadPin (LED_PORT [Led], LED_PIN [Led]) == GPIO_PIN_RESET);
}
/**
  * @brief  
  * @retval None
  */
[#if numLed = 1]  
static void LED_USER_GPIO_Init(void) {
[@common.optinclude name=mxTmpFolder+"/bsp_led_GPIO.tmp"/]   
}
[/#if]
[#if numLed > 1]
	[#list BspIpDatas as SWIP] 
			[#assign LED_USER_GPIO_Init="LED_USER_GPIO_Init" + ","]
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            		
            		[#-- User BSP Led --]
            		[#if variables.value?contains("BSP LED ") ] 
              			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]            
/**
  * @brief  
  * @retval None
  */
static void LED_USER_${i}_GPIO_Init(void) {
[@common.optinclude name=mxTmpFolder+"/bsp_led_" + i + "_GPIO.tmp"/]   
}
			 		[/#if]                   												                       
        		[/#list]
    		[/#if]
    		
		[/#list] 

[/#if]
[/#if]

[#if useBUTTON]
/**
  * @brief  Configures button GPIO and EXTI Line.
  * @param  Button: Button to be configured
  *                 This parameter can be one of the following values: 
  *                 @arg  BUTTON_USER: User Push Button
  * @param  ButtonMode Button mode
  *                    This parameter can be one of the following values:
  *                    @arg  BUTTON_MODE_GPIO: Button will be used as simple IO
  *                    @arg  BUTTON_MODE_EXTI: Button will be connected to EXTI line 
  *                                            with interrupt generation capability
  * @retval BSP status
  */
int32_t BSP_PB_Init(Button_TypeDef Button, ButtonMode_TypeDef ButtonMode)
{
  int32_t ret = BSP_ERROR_NONE;
  [#--  BZ  89608
  GPIO_InitTypeDef gpio_init_structure;
  --]
[#if useDefine == false]  
  hpb_exti[Button] = &hexti${BUTTON_EXTI};
  [#if numButton > 1]
  	[#list BspIpDatas as SWIP] 
    	[#if SWIP.variables??]
        	[#list SWIP.variables as variables]       
            	[#if variables.name?contains("IpInstance")]
                	[#assign IpInstance = variables.value]
            	[/#if]
            	[#if variables.name?contains("IpName")]
                	[#assign IpName = variables.value]
            	[/#if]	            
            	[#if variables.name?contains("GPIO_INT_NUM")]
                	[#assign IrqNumber = variables.value]
				
            	[/#if]
            	[#if variables.name?contains("EXTI_LINE_NUMBER")]
                	[#assign ExtiLine = variables.value]				
            	[/#if]		
            	[#-- User BSP Button --]
            	[#if variables.value?contains("BSP BUTTON ") ] 
              		[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]  
  hpb_exti[Button] = &hexti${ExtiLine};
				[/#if]
			[/#list]
		[/#if]
	[/#list]
  [/#if]
[/#if]
  
[#if numButton = 1]
    [#if !virtualEXTI ]
  static const BSP_EXTI_LineCallback ButtonCallback[BUTTONn] ={BUTTON_USER_EXTI_Callback};
  static const uint32_t  BSP_BUTTON_PRIO [BUTTONn] ={BSP_BUTTON_USER_IT_PRIORITY};
  static const uint32_t BUTTON_EXTI_LINE[BUTTONn] ={USER_BUTTON_EXTI_LINE};
    [/#if]
  static const BSP_BUTTON_GPIO_Init ButtonGpioInit[BUTTONn] = {BUTTON_USER_GPIO_Init};
[/#if]
[#if numButton > 1]
		[#assign BUTTON_USER_EXTI_CALLBACK=""]
		[#assign BSP_BUTTON_USER_IT_PRIORITY=""]
		[#assign USER_BUTTON_EXTI_LINE=""]
		[#assign BUTTON_USER_GPIO_Init= ""]
		[#list BspIpDatas as SWIP] 
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            
            		[#if variables.name?contains("GPIO_INT_NUM")]
                		[#assign IrqNumber = variables.value]				
            		[/#if]
            		[#if variables.name?contains("EXTI_LINE_NUMBER")]
                		[#assign ExtiLine = variables.value]				
            		[/#if]		
            		[#-- User BSP Button --]
            		[#if variables.value?contains("BSP BUTTON ") ] 
            			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
            			[#assign BUTTON_USER_EXTI_CALLBACK = BUTTON_USER_EXTI_CALLBACK + "BUTTON_USER_" + i + "_EXTI_Callback" + ","]
						[#assign BSP_BUTTON_USER_IT_PRIORITY = BSP_BUTTON_USER_IT_PRIORITY + "BSP_BUTTON_USER_IT_PRIORITY"  + ","] 
						[#assign USER_BUTTON_EXTI_LINE = USER_BUTTON_EXTI_LINE + "USER_BUTTON_" + i + "_EXTI_LINE" + ","]  
						[#assign BUTTON_USER_GPIO_Init = BUTTON_USER_GPIO_Init + "BUTTON_USER_" + i + "_GPIO_Init" + ","]         
            		[/#if]
            	[/#list]
			[/#if]
		[/#list]
  static const BSP_EXTI_LineCallback ButtonCallback[BUTTONn] ={${BUTTON_USER_EXTI_CALLBACK}};                                                
  static const uint32_t  BSP_BUTTON_PRIO [BUTTONn] ={${BSP_BUTTON_USER_IT_PRIORITY}};  											     
  static const uint32_t BUTTON_EXTI_LINE[BUTTONn] ={${USER_BUTTON_EXTI_LINE}};
  static const BSP_BUTTON_GPIO_Init ButtonGpioInit[BUTTONn] = {${BUTTON_USER_GPIO_Init}};		
	[/#if]
  
  
  [#-- BZ 68256 --]
  [#--  [@common.optinclude name=mxTmpFolder+"/bsp_button_GPIO.tmp"/]--]
  [#--  
  /* Enable the BUTTON clock*/ 
  USER_BUTTON_GPIO_CLK_ENABLE();
  gpio_init_structure.Pin = BUTTON_PIN [Button];
  gpio_init_structure.Pull = GPIO_PULLDOWN;
  gpio_init_structure.Speed = GPIO_SPEED_FREQ_HIGH;
  
  if(ButtonMode == BUTTON_MODE_GPIO)
  {
    /* Configure Button pin as input */
    gpio_init_structure.Mode = GPIO_MODE_INPUT;
    HAL_GPIO_Init(BUTTON_PORT [Button], &gpio_init_structure);
  }
  --]
  ButtonGpioInit[Button]();
  
  if (ButtonMode == BUTTON_MODE_EXTI) 
  {  
  	[#--  BZ 89339    
    /* Configure Button pin as input with External interrupt */    
    gpio_init_structure.Mode = GPIO_MODE_IT_RISING;
    
    HAL_GPIO_Init(BUTTON_PORT[Button], &gpio_init_structure);
    --]
   [#if !virtualEXTI ]
    [#if useDefine]
    if(HAL_EXTI_GetHandle(&hpb_exti[Button], BUTTON_EXTI_LINE[Button]) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    else if (HAL_EXTI_RegisterCallback(&hpb_exti[Button],  HAL_EXTI_COMMON_CB_ID, ButtonCallback[Button]) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    [#else]
    if(HAL_EXTI_GetHandle(hpb_exti[Button], BUTTON_EXTI_LINE[Button]) != HAL_OK)
    {
	  ret = BSP_ERROR_PERIPH_FAILURE;
    }
    else if(HAL_EXTI_RegisterCallback(hpb_exti[Button],  HAL_EXTI_COMMON_CB_ID, ButtonCallback[Button]) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    [/#if]
	else
    {
      /* Enable and set Button EXTI Interrupt to the lowest priority */     
      HAL_NVIC_SetPriority((BUTTON_IRQn[Button]), BSP_BUTTON_PRIO[Button], 0x00);
      HAL_NVIC_EnableIRQ((BUTTON_IRQn[Button]));      
    }
  }
 [#elseif useDefine]
      /* Enable and set Button EXTI Interrupt to the lowest priority */
      HAL_NVIC_SetPriority((BUTTON_IRQn[Button]), NVIC_LOW_PRIORITY, 0x00);
      HAL_NVIC_EnableIRQ((BUTTON_IRQn[Button]));
  }
 [/#if]
  
  return ret;
}

/**
 * @brief  Push Button DeInit.
 * @param  Button Button to be configured
 *                This parameter can be one of the following values:
 *                @arg  BUTTON_USER: Wakeup Push Button
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
 * @param  Button Button to be addressed
 *                This parameter can be one of the following values:
 *                @arg  BUTTON_USER
 * @retval The Button GPIO pin value (GPIO_PIN_RESET = button pressed)
 */
int32_t BSP_PB_GetState(Button_TypeDef Button)
{
  return (int32_t)(HAL_GPIO_ReadPin(BUTTON_PORT[Button], BUTTON_PIN[Button]) == GPIO_PIN_RESET);
}

/**
 * @brief  User EXTI line detection callbacks.
 * @retval None
 */
[#if virtualEXTI ]
void BSP_PB_IRQHandler(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
  HAL_GPIO_EXTI_IRQHandler( GPIOx, GPIO_Pin);
}
[#else]
void BSP_PB_IRQHandler (Button_TypeDef Button)
{
[#if useDefine]
  HAL_EXTI_IRQHandler( &hpb_exti[Button] );
[#else]
  HAL_EXTI_IRQHandler( hpb_exti[Button] );
[/#if]
}
[/#if]

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

[#if numButton = 1]
/**
  * @brief  User EXTI line detection callbacks.
  * @retval None
  */
 [#if virtualEXTI ]
void HAL_GPIO_EXTI_Callback(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
  if( (GPIOx == BUTTON_PORT[BUTTON_USER]) && (GPIO_Pin == BUTTON_PIN[BUTTON_USER]) )
  {
    BSP_PB_Callback(BUTTON_USER);
  }
}
 [#else]
static void BUTTON_USER_EXTI_Callback(void)
{   
  BSP_PB_Callback(BUTTON_USER);
}
 [/#if]
[/#if]
[#if numButton > 1]
	[#list BspIpDatas as SWIP] 
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            
            		[#if variables.name?contains("GPIO_INT_NUM")]
                		[#assign IrqNumber = variables.value]				
            		[/#if]
            		[#if variables.name?contains("EXTI_LINE_NUMBER")]
                		[#assign ExtiLine = variables.value]				
            		[/#if]		
            		[#-- User BSP Button --]
            		[#if variables.value?contains("BSP BUTTON ") ] 
            			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
 /**
  * @brief  User EXTI line detection callbacks.
  * @retval None
  */
static void BUTTON_USER_${i}_EXTI_Callback(void)
{   
  /* USER CODE BEGIN USER_${i}_EXTI_CallBack */
  BSP_PB_Callback(BUTTON_USER_${i});
  /* USER CODE END USER_${i}_EXTI_CallBack */
}
            		[/#if]
            	[/#list]
			[/#if]
		[/#list]
[/#if]

[#if numButton = 1]
/**
  * @brief  
  * @retval None
  */
static void BUTTON_USER_GPIO_Init(void) {
[@common.optinclude name=mxTmpFolder+"/bsp_button_GPIO.tmp"/]
[#if virtualEXTI]
  __HAL_RCC_SYSCFG_CLK_ENABLE();
  if( LL_PWR_IsEnabledPUPDCfg() != 0)
  {
    if (BUS_BSP_BUTTON_GPIO_PORT == GPIOA)
    {
      LL_PWR_EnableGPIOPullUp( LL_PWR_GPIO_A, GPIO_InitStruct.Pin);
    }
    if (BUS_BSP_BUTTON_GPIO_PORT== GPIOB)
    {
      LL_PWR_EnableGPIOPullUp( LL_PWR_GPIO_B, GPIO_InitStruct.Pin);
    }
  }
[/#if]
}
[/#if]
[#if numButton > 1]
	[#list BspIpDatas as SWIP] 
    		[#if SWIP.variables??]
        		[#list SWIP.variables as variables]       
            		[#if variables.name?contains("IpInstance")]
                		[#assign IpInstance = variables.value]
            		[/#if]
            		[#if variables.name?contains("IpName")]
                		[#assign IpName = variables.value]
            		[/#if]	            
            		[#if variables.name?contains("GPIO_INT_NUM")]
                		[#assign IrqNumber = variables.value]				
            		[/#if]
            		[#if variables.name?contains("EXTI_LINE_NUMBER")]
                		[#assign ExtiLine = variables.value]				
            		[/#if]		
            		[#-- User BSP Button --]
            		[#if variables.value?contains("BSP BUTTON ") ] 
            			[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
 /**
  * @brief  
  * @retval None
  */
static void BUTTON_USER_${i}_GPIO_Init(void) {
[@common.optinclude name=mxTmpFolder+"/bsp_button_" + i + "_GPIO.tmp"/]   
}
            		[/#if]
            	[/#list]
			[/#if]
		[/#list]
	[/#if]
[/#if] [#-- /useButton --]

[#if useUSART]
#if (USE_BSP_COM_FEATURE > 0)
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
  int32_t ret = BSP_ERROR_NONE;
  
  if(COM > COMn)
  {
    ret = BSP_ERROR_WRONG_PARAM;
  }
  else
  {  
     hcom_uart[COM].Instance = COM_USART[COM];
#if (USE_HAL_UART_REGISTER_CALLBACKS == 0U)
    /* Init the UART Msp */
    ${UsartInstance}_MspInit(&hcom_uart[COM]);
#else
    if(Is${UsartInstance?lower_case?replace("u","U")}MspCbValid == 0U)
    {
      if(BSP_COM_RegisterDefaultMspCallbacks(COM) != BSP_ERROR_NONE)
      {
        return BSP_ERROR_MSP_FAILURE;
      }
    }
#endif
[#if halMode]
    if (MX_${UsartInstance}_Init(&hcom_uart[COM]))
[#else]
    if (MX_${UsartInstance}_${halModeName}_Init(&hcom_uart[COM]))
[/#if]    
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
  }

  return ret;
}

/**
 * @brief  DeInit COM port.
 * @param  COM COM port to be configured.
 *             This parameter can be COM1
 * @retval BSP status
 */
int32_t BSP_COM_DeInit(COM_TypeDef COM)
{
  int32_t ret = BSP_ERROR_NONE;
  
  if(COM > COMn)
  {
    ret = BSP_ERROR_WRONG_PARAM;
  }
  else
  {  
    /* USART configuration */
    hcom_uart[COM].Instance = COM_USART[COM];
  
    #if (USE_HAL_UART_REGISTER_CALLBACKS == 0U)  
      ${UsartInstance}_MspDeInit(&hcom_uart[COM]);  
    #endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 0U) */
  
    if(HAL_UART_DeInit(&hcom_uart[COM]) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
  }
  
  return ret;
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

#endif 
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U) 
/**
 * @brief Register Default ${UsartInstance} Bus Msp Callbacks
 * @retval BSP status
 */
int32_t BSP_COM_RegisterDefaultMspCallbacks(COM_TypeDef COM)
{
  int32_t ret = BSP_ERROR_NONE;
  
  if(COM >= COMn)
  {
    ret = BSP_ERROR_WRONG_PARAM;
  }
  else
  {  
    
    __HAL_UART_RESET_HANDLE_STATE(&hcom_uart[COM]);
  
    /* Register default MspInit/MspDeInit Callback */
    if(HAL_UART_RegisterCallback(&hcom_uart[COM], HAL_UART_MSPINIT_CB_ID, ${UsartInstance?replace("s","")}_MspInit) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    else if(HAL_UART_RegisterCallback(&hcom_uart[COM], HAL_UART_MSPDEINIT_CB_ID, ${UsartInstance?replace("s","")}_MspDeInit) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    else
    {
      Is${UsartInstance?lower_case?replace("u","U")}MspCbValid = 1U;
    }
  }
  
  /* BSP status */  
  return ret;
}

/**
 * @brief Register ${UsartInstance} Bus Msp Callback registering
 * @param Callbacks pointer to ${UsartInstance} MspInit/MspDeInit callback functions
 * @retval BSP status
 */
int32_t BSP_COM_RegisterMspCallbacks (COM_TypeDef COM , BSP_COM_Cb_t *Callback)
{
  int32_t ret = BSP_ERROR_NONE;
  
  if(COM >= COMn)
  {
    ret = BSP_ERROR_WRONG_PARAM;
  }
  else
  {
    __HAL_UART_RESET_HANDLE_STATE(&hcom_uart[COM]);
  
    /* Register MspInit/MspDeInit Callbacks */
    if(HAL_UART_RegisterCallback(&hcom_uart[COM], HAL_UART_MSPINIT_CB_ID, Callback->pMspInitCb) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    else if(HAL_UART_RegisterCallback(&hcom_uart[COM], HAL_UART_MSPDEINIT_CB_ID, Callback->pMspDeInitCb) != HAL_OK)
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
    else
    {
      Is${UsartInstance?lower_case?replace("u","U")}MspCbValid = 1U;
    }
  }
  
  /* BSP status */  
  return ret; 
}
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */

#if (USE_COM_LOG > 0)
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
 
#if defined(__CC_ARM) /* For arm compiler 5 */
#if !defined(__MICROLIB) /* If not Microlib */

struct __FILE
{
  int dummyVar; //Just for the sake of redefining __FILE, we won't we using it anyways ;)
};

FILE __stdout;

#endif /* If not Microlib */
#elif defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6010050) /* For arm compiler 6 */
#if !defined(__MICROLIB) /* If not Microlib */

FILE __stdout;

#endif /* If not Microlib */
#endif /* For arm compiler 5 */
#if defined(__ICCARM__) /* For IAR */
size_t __write(int Handle, const unsigned char *Buf, size_t Bufsize)
{
  int i;

  for(i=0; i<Bufsize; i++)
  {
    (void)HAL_UART_Transmit(&hcom_uart[COM_ActiveLogPort], (uint8_t *)&Buf[i], 1, COM_POLL_TIMEOUT);
  }

  return Bufsize;  
}
#elif defined(__CC_ARM) || (defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6010050)) /* For ARM Compiler 5 and 6 */
int fputc (int ch, FILE *f)
{
  (void)HAL_UART_Transmit(&hcom_uart[COM_ActiveLogPort], (uint8_t *)&ch, 1, COM_POLL_TIMEOUT);
  return ch;
}
#else /* For GCC Toolchains */
int __io_putchar (int ch)
{
  (void)HAL_UART_Transmit(&hcom_uart[COM_ActiveLogPort], (uint8_t *)&ch, 1, COM_POLL_TIMEOUT);
  return ch;
}
#endif /* For IAR */
#endif /* USE_COM_LOG */ 
/**
 * @brief  Initializes ${UsartInstance} MSP.
 * @param  huart ${UsartInstance} handle
 * @retval None
 */
[@common.optinclude name=mxTmpFolder+"/${UsartInstance?lower_case}_CommonD_Msp.tmp"/]

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




