[#ftl]
/**
  ******************************************************************************
  * @file  : ${BoardName}.h
  * @brief : header file for the BSP Common driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+ "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
[#assign IpInstance = ""]
[#assign IpName = ""]
[#assign IrqNumber = ""]
[#assign ExtiLine = ""]

[#assign useLED = false]
[#assign LED2_PORT = ""]
[#assign LED2_PIN = ""]

[#assign useBUTTON = false]
[#assign BUTTON_PORT = ""]
[#assign BUTTON_PIN = ""]
[#assign BUTTON_IRQn = ""]
[#assign BUTTON_EXTI = ""]

[#assign useUSART = false]
[#assign UsartInstance = ""]
[#assign UART_PORT = ""]
[#assign UART_PIN = ""]
 
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
[/#list] 
 
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${BoardName?upper_case}_H
#define __${BoardName?upper_case}_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/ 
#include "${FamilyName?lower_case}xx_hal.h"
#include <stdio.h>
#include "main.h"

/** @addtogroup BSP
 * @{
 */

/** @addtogroup ${BoardName?upper_case}
 * @{
 */

/** @addtogroup ${BoardName?upper_case}_LOW_LEVEL
 * @{
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Types ${BoardName?upper_case} LOW LEVEL Exported Types
 * @{
 */
typedef enum 
{
  LED2 = 0U
} Led_TypeDef;

typedef enum 
{  
  BUTTON_USER = 0U,
  /* Alias */
  BUTTON_KEY  = BUTTON_USER
} Button_TypeDef;

typedef enum 
{  
  BUTTON_MODE_GPIO = 0U,
  BUTTON_MODE_EXTI = 1U
} ButtonMode_TypeDef;

typedef enum 
{
  COM1 = 0U,
} COM_TypeDef;
[#if useUSART]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
typedef struct
{
  pUART_CallbackTypeDef  pMspUartInitCb;
  pUART_CallbackTypeDef  pMspUartDeInitCb;
} BSP_UART_Cb_t;
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 1) */
[/#if]

/**
 * @}
 */ 

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Constants ${BoardName?upper_case} LOW LEVEL Exported Constants
 * @{
 */ 
/** 
 * @brief Define for ${BoardName?upper_case} board  
 */ 
/* Common Error codes */
#define BSP_ERROR_NONE                    0
#define BSP_ERROR_NO_INIT                -1
#define BSP_ERROR_WRONG_PARAM            -2
#define BSP_ERROR_BUSY                   -3
#define BSP_ERROR_PERIPH_FAILURE         -4
#define BSP_ERROR_COMPONENT_FAILURE      -5
#define BSP_ERROR_UNKNOWN_FAILURE        -6
#define BSP_ERROR_UNKNOWN_COMPONENT      -7 
#define BSP_ERROR_BUS_FAILURE            -8 
#define BSP_ERROR_CLOCK_FAILURE          -9  
#define BSP_ERROR_MSP_FAILURE            -10  
#define BSP_ERROR_FEATURE_NOT_SUPPORTED  -11

[#if useLED]
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_LED ${BoardName?upper_case} LOW LEVEL LED
 * @{
 */  
#define LEDn                              1U

#define LED2_GPIO_PORT                    ${LED2_PORT}
#define LED2_GPIO_CLK_ENABLE()            __HAL_RCC_${LED2_PORT}_CLK_ENABLE()
#define LED2_GPIO_CLK_DISABLE()           __HAL_RCC_${LED2_PORT}_CLK_DISABLE()  
#define LED2_GPIO_PIN                     ${LED2_PIN}
[/#if]
/**
 * @}
 */ 

[#if useBUTTON] 
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_BUTTON ${BoardName?upper_case} LOW LEVEL BUTTON
 * @{
 */ 
/* Button state */
#define BUTTON_RELEASED                   0U
#define BUTTON_PRESSED                    1U 

#define BUTTONn                           1U

/**
 * @brief Key push-button
 */
#define KEY_BUTTON_GPIO_PIN               ${BUTTON_PIN}
#define KEY_BUTTON_GPIO_PORT              ${BUTTON_PORT}
#define KEY_BUTTON_GPIO_CLK_ENABLE()      __HAL_RCC_${BUTTON_PORT}_CLK_ENABLE()   
#define KEY_BUTTON_GPIO_CLK_DISABLE()     __HAL_RCC_${BUTTON_PORT}_CLK_DISABLE()  
#define KEY_BUTTON_EXTI_IRQn              ${BUTTON_IRQn}
#define KEY_BUTTON_EXTI_LINE              EXTI_LINE_${BUTTON_EXTI} 
#define BSP_BUTTON_KEY_IT_PRIORITY        0xF
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
#define COMn                             1U 
#define COM1_UART                        ${UsartInstance}

#define COM_POLL_TIMEOUT                 1000

#define USE_COM_LOG                      1U

#define UartHandle h${UsartInstance?lower_case?replace("usart", "uart")}

typedef enum
{          
 COM_STOPBITS_1 =   UART_STOPBITS_1,                                 
 COM_STOPBITS_2 =   UART_STOPBITS_2,
} COM_StopBitsTypeDef;

typedef enum
{
 COM_PARITY_NONE =  UART_PARITY_NONE,                  
 COM_PARITY_EVEN =  UART_PARITY_EVEN,                  
 COM_PARITY_ODD  =  UART_PARITY_ODD,                   
} COM_ParityTypeDef;


typedef enum
{
 COM_HWCONTROL_NONE    =  UART_HWCONTROL_NONE,               
 COM_HWCONTROL_RTS     =  UART_HWCONTROL_RTS,                
 COM_HWCONTROL_CTS     =  UART_HWCONTROL_CTS,                
 COM_HWCONTROL_RTS_CTS =  UART_HWCONTROL_RTS_CTS, 
} COM_HwFlowCtlTypeDef;

typedef struct
{
  uint32_t             BaudRate;      
  uint32_t             WordLength;    
  COM_StopBitsTypeDef  StopBits;      
  COM_ParityTypeDef    Parity;               
  COM_HwFlowCtlTypeDef HwFlowCtl;                           
} COM_InitTypeDef;
[/#if]
/**
 * @}
 */
  
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Functions ${BoardName?upper_case} LOW LEVEL Exported Functions
 * @{
 */ 
/* Exported Functions --------------------------------------------------------*/
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
[/#if]
[#if useUSART]
int32_t  BSP_COM_Init(COM_TypeDef COM);
int32_t  BSP_COM_DeInit(COM_TypeDef COM);

#if (USE_COM_LOG == 1)
int32_t  BSP_COM_SelectLogPort(COM_TypeDef COM);
#endif

#if (USE_HAL_UART_REGISTER_CALLBACKS == 1) 
int32_t BSP_${UsartInstance}_RegisterDefaultMspCallbacks(void);
int32_t BSP_${UsartInstance}_RegisterMspCallbacks(BSP_UART_Cb_t *Callback);
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
    
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
