[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file  : ${BoardName}.h
  * @brief : header file for the BSP Common driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+ "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */
[#assign IpInstance = ""]
[#assign IpName = ""]
[#assign IrqNumber = ""]
[#assign ExtiLine = ""]
[#assign BSP_MODE_NAME = ""]

[#assign useLED = false]
[#assign LED2_PORT = ""]
[#assign LED2_PIN = ""]
[#assign NUMBER_OF_LED = ""]

[#assign useBUTTON = false]
[#assign BUTTON_PORT = ""]
[#assign BUTTON_PIN = ""]
[#assign BUTTON_IRQn = ""]
[#assign BUTTON_EXTI = ""]
[#assign BUTTON_MODE = ""]

[#assign useUSART = false]
[#assign UsartInstance = ""]
[#assign UART_PORT = ""]
[#assign UART_PIN = ""]
[#assign useDefine = false]
[#assign useEXTI = false]

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

[#list BspIpDatas as SWIP] 
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]       
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
            [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
            [/#if]	
            [#if variables.name?contains("BspModeName")]            
                [#assign BSP_MODE_NAME = variables.value]
            [/#if]
            [#if variables.name?contains("GPIO_INT_NUM")]
                [#assign IrqNumber = variables.value]
				
            [/#if]
            [#if variables.name?contains("EXTI_LINE_NUMBER")]
                [#assign ExtiLine = variables.value]				
            [/#if]			
            [#-- Usual BSP Led --]
            [#if variables.value?contains("BSP LED")]            
                [#assign LED2_PORT = IpName]
                [#assign LED2_PIN = IpInstance]	
				[#assign useLED = true]								
            [/#if]
            [#if variables.value?contains("BSP BUTTON")]
                [#assign BUTTON_PORT = IpName]
                [#assign BUTTON_PIN = IpInstance]
                [#assign BUTTON_IRQn = IrqNumber]
                [#assign BUTTON_EXTI = ExtiLine]                            	
				[#assign useBUTTON = true]	
            [/#if]
            [#if variables.value?contains("BSP USART")]
                [#assign UsartInstance = IpInstance]
				[#assign UART_PORT = IpInstance]
				[#assign useUSART = true]
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
     	[/#list]
    [/#if]
[/#list] 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${BoardName?upper_case}_H
#define __${BoardName?upper_case}_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/ 
#include "${BoardName}_conf.h"
#include "${BoardName}_errno.h"
#include "main.h"

#if (USE_BSP_COM_FEATURE > 0)
  #if (USE_COM_LOG > 0)  
    #if defined(__ICCARM__) || defined(__CC_ARM) || (defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6010050)) /* For IAR and ARM Compiler 5 and 6*/ 
      #include <stdio.h>
    #endif
  #endif
#endif
/** @addtogroup BSP
 * @{
 */

/** @defgroup ${BoardName?upper_case}
 * @{
 */

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL
 * @{
 */ 

/** @defgroup STM32L4XX_NUCLEO_LOW_LEVEL_Exported_Constants LOW LEVEL Exported Constants
  * @{
  */
/**
 * @brief ${FamilyName?upper_case}XX NUCLEO BSP Driver version number V1.0.0
 */  
#define __${BoardName?upper_case}_BSP_VERSION_MAIN   (uint32_t)(0x01) /*!< [31:24] main version */
#define __${BoardName?upper_case}_BSP_VERSION_SUB1   (uint32_t)(0x00) /*!< [23:16] sub1 version */
#define __${BoardName?upper_case}_BSP_VERSION_SUB2   (uint32_t)(0x00) /*!< [15:8]  sub2 version */
#define __${BoardName?upper_case}_BSP_VERSION_RC     (uint32_t)(0x00) /*!< [7:0]  release candidate */ 
#define __${BoardName?upper_case}_BSP_VERSION        ((__${BoardName?upper_case}_BSP_VERSION_MAIN << 24)\
                                                    |(__${BoardName?upper_case}_BSP_VERSION_SUB1 << 16)\
                                                    |(__${BoardName?upper_case}_BSP_VERSION_SUB2 << 8 )\
                                                    |(__${BoardName?upper_case}_BSP_VERSION_RC))											
													
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Types ${BoardName?upper_case} LOW LEVEL Exported Types
 * @{
 */
 
 /** 
  * @brief Define for ${BoardName?upper_case} board  
  */ 
#if !defined (USE_${BoardName?upper_case})
 #define USE_${BoardName?upper_case}
#endif
#ifndef USE_BSP_COM_FEATURE
   #define USE_BSP_COM_FEATURE                  0U
#endif

[#if useLED]
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_LED ${BoardName?upper_case} LOW LEVEL LED
 * @{
 */  
[#if numLed = 1]
/** Define number of LED            **/
#define LEDn                              ${NumberOfLed}U
/**  Definition for BSP USER LED 2   **/
#define LED2_PIN                     	  ${LED2_PIN}
#define LED2_GPIO_PORT                    ${LED2_PORT}
#define LED2_GPIO_CLK_ENABLE()            __HAL_RCC_${LED2_PORT}_CLK_ENABLE()
#define LED2_GPIO_CLK_DISABLE()           __HAL_RCC_${LED2_PORT}_CLK_DISABLE()  

[@common.optinclude name=mxTmpFolder+"/bsp_led_define_GPIO.tmp"/]
[/#if]

[#if numLed > 1]
/** Define number of LED            **/
#define LEDn                              ${NumberOfLed}U
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


/**  Definition for BSP USER LED ${i}   **/
[@common.optinclude name=mxTmpFolder+"/bsp_led_" + i + "_define_GPIO.tmp"/]
#define LED${i}_PIN                          ${IpInstance}
#define LED${i}_GPIO_PORT                    ${IpName}
#define LED${i}_GPIO_CLK_ENABLE()            __HAL_RCC_${IpName}_CLK_ENABLE()
#define LED${i}_GPIO_CLK_DISABLE()           __HAL_RCC_${IpName}_CLK_DISABLE()   
			 	[/#if]                   												                       
        	[/#list]
    	[/#if]
	[/#list] 
[/#if]

[/#if]
/**
 * @}
 */ 
 
[#if useBUTTON] 
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_BUTTON ${BoardName?upper_case} LOW LEVEL BUTTON
 * @{
 */ 
/* Button state */
[#-- Bug 60928 Nucleo 144 pin and Nucleo L4 SMPS --]
[#if Board_RPN?upper_case?contains("Z") || Board_RPN?upper_case?contains("-P")]
#define BUTTON_RELEASED                   1U
#define BUTTON_PRESSED                    0U
[#else]
#define BUTTON_RELEASED                   0U
#define BUTTON_PRESSED                    1U
[/#if] 
/** Define number of BUTTON            **/
#define BUTTONn                           ${NumberOfButton}U

/**
 * @brief User push-button
 */
  [#-- BZ 68256 --]
[#if numButton = 1]  
  /**  Definition for BSP USER BUTTON   **/
[@common.optinclude name=mxTmpFolder+"/bsp_button_define_GPIO.tmp"/]

#define USER_BUTTON_PIN	                  ${BUTTON_PIN}
#define USER_BUTTON_GPIO_PORT              ${BUTTON_PORT}
[#-- BZ 94093 --]	
#define USER_BUTTON_EXTI_IRQn              ${BUTTON_IRQn}
#define USER_BUTTON_EXTI_LINE              EXTI_LINE_${BUTTON_EXTI} 
	[#if useDefine && useEXTI]
#define H_EXTI_${BUTTON_EXTI}			  hpb_exti[BUTTON_USER]		
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
            	[#if variables.name?contains("BspModeName")]
                	[#assign BSP_MODE_NAME = variables.value]
            	[/#if]         
            	[#if variables.name?contains("GPIO_INT_NUM")]
                	[#assign IrqNumber = variables.value]
				
            	[/#if]
            	[#if variables.name?contains("EXTI_LINE_NUMBER")]
                	[#assign ExtiLine = variables.value]				
            	[/#if]		
            	[#-- User BSP Button --]
            	[#if variables.value?contains("BSP BUTTON ") ] 
            		[#assign BUTTON_MODE = BSP_MODE_NAME]
              		[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]  
/**  Definition for BSP USER BUTTON ${i}   **/
[@common.optinclude name=mxTmpFolder+"/bsp_button_" + i + "_define_GPIO.tmp"/]          
#define USER_BUTTON_${i}_PIN	               ${IpInstance}
#define USER_BUTTON_${i}_GPIO_PORT              ${IpName} 
#define USER_BUTTON_${i}_EXTI_IRQn              ${IrqNumber}
#define USER_BUTTON_${i}_EXTI_LINE              EXTI_LINE_${ExtiLine} 
[#if useDefine && useEXTI]
#define H_EXTI_${ExtiLine}                      hpb_exti[BUTTON_USER_${i}]
[/#if]	
			 	[/#if]                   												                       
        	[/#list]
    	[/#if]
	[/#list] 
[/#if]
/**
 * @}
 */ 
[/#if]
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_COM ${BoardName?upper_case} LOW LEVEL COM
 * @{
 */
[#if useUSART]
/**
 * @brief Definition for COM portx, connected to ${UsartInstance}
 */
[@common.optinclude name=mxTmpFolder+"/${UsartInstance?lower_case}_define_h.tmp"/] 

[/#if]
/**
 * @}
 */
  


/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Types LOW LEVEL Exported Types
  * @{
  */  
#ifndef USE_BSP_COM
  #define USE_BSP_COM                           0U
#endif

 
#ifndef USE_COM_LOG
  #define USE_COM_LOG                           1U
#endif
  
[#if useBUTTON]
#ifndef BSP_BUTTON_USER_IT_PRIORITY
  #define BSP_BUTTON_USER_IT_PRIORITY            15U
#endif 
[/#if]

[#if useLED] 
typedef enum 
{
[#if numLed = 1]
  LED2 = 0,
  LED_GREEN = LED2,
[/#if]
[#if numLed > 1]
[#assign j = 0]
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
  LED${i} = ${j}, 
					[#assign j = j+1]                      
			 	[/#if]                   												                       
        	[/#list]
    	[/#if]
	[/#list] 
[/#if]
}Led_TypeDef;
[/#if]

[#if useBUTTON]
typedef enum 
{
[#if numButton = 1]
  BUTTON_USER = 0U,
[/#if]  
[#if numButton > 1]
	[#assign j = 0]
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
            	[#if variables.value?contains("BSP BUTTON ") ] 
              		[#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]            
  BUTTON_USER_${i} = ${j},
         			[#assign j = j+1]               
			 	[/#if]                   												                       
        	[/#list]
    	[/#if]
	[/#list] 
[/#if]
}Button_TypeDef;

/* Keep compatibility with CMSIS Pack already delivered */
#define BUTTON_KEY BUTTON_USER

typedef enum 
{  
  BUTTON_MODE_GPIO = 0,
  BUTTON_MODE_EXTI = 1
} ButtonMode_TypeDef;
[/#if]

#if (USE_BSP_COM_FEATURE > 0)
typedef enum 
{
  COM1 = 0U,
  COMn
}COM_TypeDef;

typedef enum
{                                          
 COM_WORDLENGTH_8B     =   UART_WORDLENGTH_8B,
 COM_WORDLENGTH_9B     =   UART_WORDLENGTH_9B, 
}COM_WordLengthTypeDef;

typedef enum
{          
 COM_STOPBITS_1     =   UART_STOPBITS_1,                                 
 COM_STOPBITS_2     =   UART_STOPBITS_2,
}COM_StopBitsTypeDef;

typedef enum
{
 COM_PARITY_NONE     =  UART_PARITY_NONE,                  
 COM_PARITY_EVEN     =  UART_PARITY_EVEN,                  
 COM_PARITY_ODD      =  UART_PARITY_ODD,                   
}COM_ParityTypeDef;

typedef enum
{
 COM_HWCONTROL_NONE    =  UART_HWCONTROL_NONE,               
 COM_HWCONTROL_RTS     =  UART_HWCONTROL_RTS,                
 COM_HWCONTROL_CTS     =  UART_HWCONTROL_CTS,                
 COM_HWCONTROL_RTS_CTS =  UART_HWCONTROL_RTS_CTS, 
}COM_HwFlowCtlTypeDef;

typedef struct
{
  uint32_t             BaudRate;      
  COM_WordLengthTypeDef  WordLength;
  COM_StopBitsTypeDef  StopBits;      
  COM_ParityTypeDef    Parity;               
  COM_HwFlowCtlTypeDef HwFlowCtl;                           
}COM_InitTypeDef;
#endif

#define MX_UART_InitTypeDef          COM_InitTypeDef
#define MX_UART_StopBitsTypeDef      COM_StopBitsTypeDef
#define MX_UART_ParityTypeDef        COM_ParityTypeDef
#define MX_UART_HwFlowCtlTypeDef     COM_HwFlowCtlTypeDef
[#if useUSART]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
typedef struct
{
  void (* pMspInitCb)(UART_HandleTypeDef *);
  void (* pMspDeInitCb)(UART_HandleTypeDef *);
} BSP_COM_Cb_t;
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 1U) */
[/#if]

/**
 * @}
 */ 


[#if useUSART]

#define COMn                             1U 
#define COM1_UART                        ${UsartInstance}

#define COM_POLL_TIMEOUT                 1000
[#-- Bug 61525--]
[#-- extern UART_HandleTypeDef hComHandle[COMn] --]
extern UART_HandleTypeDef hcom_uart[COMn];
[#-- Bug 61525--]
#define  h${UsartInstance?lower_case?replace("usart", "uart")} hcom_uart[COM1]
[#--#define UartHandle h${UsartInstance?lower_case?replace("usart", "uart")}--]

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


/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Variables LOW LEVEL Exported Constants
  * @{
  */   
[#if useBUTTON]
[#if useDefine]
extern EXTI_HandleTypeDef hpb_exti[BUTTONn];
[#else]
extern EXTI_HandleTypeDef* hpb_exti[BUTTONn];
[/#if]
[/#if]
/**
  * @}
  */ 
    
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Functions ${BoardName?upper_case} LOW LEVEL Exported Functions
 * @{
 */ 

int32_t  BSP_GetVersion(void);  
[#if useLED]
int32_t  BSP_LED_Init(Led_TypeDef Led);
int32_t  BSP_LED_DeInit(Led_TypeDef Led);
int32_t  BSP_LED_On(Led_TypeDef Led);
int32_t  BSP_LED_Off(Led_TypeDef Led);
int32_t  BSP_LED_Toggle(Led_TypeDef Led);
int32_t  BSP_LED_GetState(Led_TypeDef Led);
[/#if]
[#if useBUTTON]
int32_t  BSP_PB_Init(Button_TypeDef Button, ButtonMode_TypeDef ButtonMode);
int32_t  BSP_PB_DeInit(Button_TypeDef Button);
int32_t  BSP_PB_GetState(Button_TypeDef Button);
void     BSP_PB_Callback(Button_TypeDef Button);
void     BSP_PB_IRQHandler (Button_TypeDef Button);
[/#if]
[#if useUSART]
#if (USE_BSP_COM_FEATURE > 0)
int32_t  BSP_COM_Init(COM_TypeDef COM);
int32_t  BSP_COM_DeInit(COM_TypeDef COM);
#endif

#if (USE_COM_LOG > 0)
int32_t  BSP_COM_SelectLogPort(COM_TypeDef COM);
#endif

#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U) 
int32_t BSP_COM_RegisterDefaultMspCallbacks(COM_TypeDef COM);
int32_t BSP_COM_RegisterMspCallbacks(COM_TypeDef COM , BSP_COM_Cb_t *Callback);
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
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
#ifdef __cplusplus
}
#endif

#endif /* __${BoardName?upper_case}__H */

