[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    board_resources.h
  * @author  MCD Application Team
  * @brief   Header for driver at.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#--
********************************
BSP IP Datas:
[#if BspIpDatas??]
    [#list BspIpDatas as SWIP]
        [#if SWIP.defines??]
Defines:
            [#list SWIP.defines as defines]
                ${defines.name}: ${defines.value}
            [/#list]
        [/#if]
        [#if SWIP.variables??]
Variables:
            [#list SWIP.variables as variables]
                ${variables.name}: ${variables.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
********************************
SWIP Datas:
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
Defines:
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
********************************
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
#ifndef BOARD_RESOURCE_H
#define BOARD_RESOURCE_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "utilities_conf.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
[#assign numLed = 0]
[#assign numButton = 0]
[#assign useDefine = false]
[#if HalExtiUseDefine??]
    [#if HalExtiUseDefine == "true"]
        [#assign useDefine = true]
    [/#if]
[/#if]
[#if NumberOfUserLed??]
    [#assign numLed = NumberOfUserLed?number]
[/#if]
[#if NumberOfUserButton??]
    [#assign numButton = NumberOfUserButton?number]
[/#if]
[#if numLed > 0]
    [#assign useLED = true]
[/#if]
[#if numButton > 0]
    [#assign useBUTTON = true]
[/#if]
[#if numLed > 0]
/**
  * @brief Led enumeration
  */
typedef enum
{
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
                [#if variables.value?contains("LED ") ]
                    [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  SYS_LED${i} = ${j},
                    [#assign j = j+1]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
  /* Color SYS_LED aliases */
  SYS_LED_BLUE   = SYS_LED1,
    [#if numLed > 1]
  SYS_LED_GREEN  = SYS_LED2,
    [/#if]
    [#if numLed > 2]
  SYS_LED_RED    = SYS_LED3
    [/#if]
} Sys_Led_TypeDef;
[/#if]

[#if numButton > 0]
/**
  * @brief Button enumeration
  */
typedef enum
{
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
                [#if variables.value?contains("BUTTON ") ]
                    [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  SYS_BUTTON${i} = ${j},
                    [#assign j = j+1]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
} Sys_Button_TypeDef;
[/#if]

/**
  * @brief Button mode enumeration
  */
typedef enum
{
  SYS_BUTTON_MODE_GPIO = 0,
  SYS_BUTTON_MODE_EXTI = 1
} Sys_ButtonMode_TypeDef;

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if numLed > 0]
/**
  * @brief Number of leds
  */
#define SYS_LEDn                                     ${numLed}U
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
                [#if variables.value?contains("LED ") ]
                    [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]

/**  Definition for BSP USER LED ${i}  **/
/**
  * @brief Pin of Led${i}
  */
#define SYS_LED${i}_PIN                                ${IpInstance}
/**
  * @brief Port of Led${i}
  */
#define SYS_LED${i}_GPIO_PORT                          ${IpName}
/**
  * @brief Enable GPIOs clock of Led${i}
  */
#define SYS_LED${i}_GPIO_CLK_ENABLE()                  __HAL_RCC_${IpName}_CLK_ENABLE()
/**
  * @brief Disable GPIOs clock of Led${i}
  */
#define SYS_LED${i}_GPIO_CLK_DISABLE()                 __HAL_RCC_${IpName}_CLK_ENABLE()
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

[#if numButton > 0]
/**
  * @brief Number of buttons
  */
#define SYS_BUTTONn                                 ${numButton}U

/**
  * @brief Key push-buttons
  */
    [#assign useBUTTON = false]
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
                [#if variables.value?contains("BUTTON ") ]
                    [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
/**  Definition for BSP USER BUTTON ${i}   **/
[#--  [@common.optinclude name=mxTmpFolder+"/bsp_button_" + i + "_define_GPIO.tmp"/]  --]
/**
  * @brief Pin of Button${i}
  */
#define SYS_BUTTON${i}_PIN                    ${IpInstance}
/**
  * @brief Port of Button${i}
  */
#define SYS_BUTTON${i}_GPIO_PORT              ${IpName}
/**
  * @brief Enable GPIOs clock of Button${i}
  */
#define SYS_BUTTON${i}_GPIO_CLK_ENABLE()      __HAL_RCC_${IpName}_CLK_ENABLE()
/**
  * @brief Disable GPIOs clock of Button${i}
  */
#define SYS_BUTTON${i}_GPIO_CLK_DISABLE()     __HAL_RCC_${IpName}_CLK_ENABLE()
/**
  * @brief Interrupt number of Button${i}
  */
                    [#if CPUCORE != ""]
#if defined(CORE_CM0PLUS)
                        [#if ((ExtiLine == "0") || (ExtiLine == "1"))]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI1_0_IRQn
                        [#elseif ((ExtiLine == "2") || (ExtiLine == "3")) ]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI3_2_IRQn
                        [#else]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI15_4_IRQn
                        [/#if]
#else /* CORE_CM4 */
                        [#if (ExtiLine == "0")]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI0_IRQn
                        [#elseif (ExtiLine == "1")]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI1_IRQn
                        [#elseif (ExtiLine == "2")]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI2_IRQn
                        [#elseif (ExtiLine == "3")]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI3_IRQn
                        [#elseif (ExtiLine == "4")]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI4_IRQn
                        [#elseif (ExtiLine == "5") || (ExtiLine == "6") || (ExtiLine == "7") || (ExtiLine == "8") || (ExtiLine == "9") || (ExtiLine == "10")]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI9_5_IRQn
                        [#else]
#define SYS_BUTTON${i}_EXTI_IRQn              EXTI15_10_IRQn
                        [/#if]
#endif /* CORE_CM0PLUS | CORE_CM4 */
                    [#else]
#define SYS_BUTTON${i}_EXTI_IRQn              ${IrqNumber}
                    [/#if]
/**
  * @brief Interrupt line of Button${i}
  */
#define SYS_BUTTON${i}_EXTI_LINE              EXTI_LINE_${ExtiLine}
                    [#if useDefine]
/**
  * @brief Exti handle of Button${i}
  */
#define H_EXTI_${IpInstance}                  sys_hpb_exti[SYS_BUTTON${i}]
                    [/#if]
                [/#if]
            [/#list]
        [/#if]
    [/#list]

/**
  * IRQ priorities
  */
#define SYS_BUTTONx_IT_PRIORITY         15U
[/#if]

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/**
  * @brief Enable all Leds clock
  */
#define SYS_LEDx_GPIO_CLK_ENABLE(__INDEX__)         __HAL_RCC_GPIOB_CLK_ENABLE() /* All SYS_LED on same port */

/**
  * @brief Disable all Leds clock
  */
#define SYS_LEDx_GPIO_CLK_DISABLE(__INDEX__)        __HAL_RCC_GPIOB_CLK_ENABLE() /* All SYS_LED on same port */

/**
  * @brief Enable all Buttons clock
  */
#define SYS_BUTTONx_GPIO_CLK_ENABLE(__INDEX__)    do { if ((__INDEX__) == SYS_BUTTON1) SYS_BUTTON1_GPIO_CLK_ENABLE(); else \
                                                       if ((__INDEX__) == SYS_BUTTON2) SYS_BUTTON2_GPIO_CLK_ENABLE(); else \
                                                     if ((__INDEX__) == SYS_BUTTON3) SYS_BUTTON3_GPIO_CLK_ENABLE();} while(0)

/**
  * @brief Disable all Buttons clock
  */
#define SYS_BUTTONx_GPIO_CLK_DISABLE(__INDEX__)    do { if ((__INDEX__) == SYS_BUTTON1) SYS_BUTTON1_GPIO_CLK_DISABLE(); else \
                                                       if ((__INDEX__) == SYS_BUTTON2) SYS_BUTTON2_GPIO_CLK_DISABLE(); else \
                                                     if ((__INDEX__) == SYS_BUTTON3) SYS_BUTTON3_GPIO_CLK_DISABLE();} while(0)

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported variables ---------------------------------------------------------*/
[#if numButton > 0]
    [#if useDefine]
/**
  * @brief Exti handles list
  */
extern EXTI_HandleTypeDef sys_hpb_exti[SYS_BUTTONn];
    [/#if]
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported functions prototypes ---------------------------------------------*/
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_LED_Functions  LOW LEVEL LED Functions
  * @{
  */
/**
  * @brief  Configures SYS_LED GPIO.
  * @param  SYS_LED to be configured
  *         This parameter can be one of the following values:
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
            [#if variables.value?contains("LED ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_LED${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @return BSP status
  */
int32_t          SYS_LED_Init(Sys_Led_TypeDef SYS_LED);

/**
  * @brief  DeInit SYS_LEDs.
  * @param  SYS_LED to be de-init
  *         This parameter can be one of the following values:
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
            [#if variables.value?contains("LED ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_LED${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @note Led DeInit does not disable the GPIO clock nor disable the Mfx
  * @return BSP status
  */
int32_t          SYS_LED_DeInit(Sys_Led_TypeDef SYS_LED);

/**
  * @brief  Turns selected SYS_LED On.
  * @param  SYS_LED Specifies the Led to be set on
  *         This parameter can be one of the following values:
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
            [#if variables.value?contains("LED ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_LED${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @return BSP status
  */
int32_t          SYS_LED_On(Sys_Led_TypeDef SYS_LED);

/**
  * @brief  Turns selected SYS_LED Off.
  * @param  SYS_LED Specifies the Led to be set off
  *         This parameter can be one of the following values:
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
            [#if variables.value?contains("LED ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_LED${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @return BSP status
  */
int32_t          SYS_LED_Off(Sys_Led_TypeDef SYS_LED);

/**
  * @brief  Toggles the selected SYS_LED.
  * @param  SYS_LED Specifies the Led to be toggled
  *         This parameter can be one of the following values:
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
            [#if variables.value?contains("LED ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_LED${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @return BSP status
  */
int32_t          SYS_LED_Toggle(Sys_Led_TypeDef SYS_LED);

/**
  * @brief  Get the status of the selected SYS_LED.
  * @param  SYS_LED Specifies the Led to get its state
  *         This parameter can be one of following parameters:
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
            [#if variables.value?contains("LED ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_LED${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @return SYS_LED status
  */
int32_t          SYS_LED_GetState(Sys_Led_TypeDef SYS_LED);
/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_BUTTON_Functions  LOW LEVEL BUTTON Functions
  * @{
  */
/**
  * @brief  Configures Button GPIO and EXTI Line.
  * @param  Button Specifies the Button to be configured
  *         This parameter can be one of following parameters:
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
            [#-- User BSP Button --]
            [#if variables.value?contains("BUTTON ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_BUTTON${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @param  ButtonMode Specifies Button mode
  *   This parameter can be one of following parameters:
  *     @arg SYS_BUTTON_MODE_GPIO: Button will be used as simple IO
  *     @arg SYS_BUTTON_MODE_EXTI: Button will be connected to EXTI line with interrupt
  *                            generation capability
  * @return BSP status
  */
int32_t          SYS_PB_Init(Sys_Button_TypeDef Button, Sys_ButtonMode_TypeDef ButtonMode);

/**
  * @brief  Push Button DeInit.
  * @param  Button Button to be configured
  *         This parameter can be one of following parameters:
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
            [#-- User BSP Button --]
            [#if variables.value?contains("BUTTON ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_BUTTON${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @note PB DeInit does not disable the GPIO clock
  * @return BSP status
  */
int32_t          SYS_PB_DeInit(Sys_Button_TypeDef Button);

/**
  * @brief  Returns the selected Button state.
  * @param  Button Specifies the Button to be checked
  *         This parameter can be one of following parameters:
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
            [#-- User BSP Button --]
            [#if variables.value?contains("BUTTON ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_BUTTON${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  * @return The Button GPIO pin value.
  */
int32_t          SYS_PB_GetState(Sys_Button_TypeDef Button);

/**
  * @brief  BSP Push Button callback
  * @param  Button Specifies the Button to be checked
  *         This parameter can be one of following parameters:
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
            [#-- User BSP Button --]
            [#if variables.value?contains("BUTTON ") ]
                [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
  *            @arg SYS_BUTTON${i}
                [#assign j = j+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
  */
void             SYS_PB_Callback(Sys_Button_TypeDef Button);

/**
  * @brief  This function handles Push-Button interrupt requests.
  * @param  Button Specifies the pin connected EXTI line
  */
void             SYS_PB_IRQHandler(Sys_Button_TypeDef Button);

/**
  * @}
  */

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* BOARD_RESOURCE_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/