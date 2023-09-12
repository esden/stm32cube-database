[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    board_resources.c
  * @author  MCD Application Team
  * @brief   Source file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#--
********************************
BSP IP Data:
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
SWIP Data:
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
[#assign numLed = 0]
[#assign numButton = 0]
[#assign useDefine = false]
[#assign useBUTTON = false]
[#assign useLED = false]
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

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "board_resources.h"
[#if useBUTTON]
#include "${FamilyName?lower_case}xx_hal_exti.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/**
  * @brief Exti Line callback function definition
  */
typedef void (* SYS_RES_EXTI_LineCallback)(void);

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if useLED]
    [#if numLed > 0]
        [#-- assign first value for the LED --]
        [#assign LED_GPIO_PORT=""]
        [#assign LED_PIN=""]
        [#if BspIpDatas??]
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
                            [#assign LED_GPIO_PORT = LED_GPIO_PORT + "SYS_LED" + i + "_GPIO_PORT" + ", "]
                            [#assign LED_PIN = LED_PIN + "SYS_LED" + i + "_PIN" + ", "]
                        [/#if]
                    [/#list]
                [/#if]
            [/#list]
        [/#if]
    [/#if]
/**
  * @brief Ports led list
  */
static GPIO_TypeDef  *SYS_LED_PORT[SYS_LEDn] = {${LED_GPIO_PORT}};

/**
  * @brief Pins led list
  */
static const uint16_t SYS_LED_PIN[SYS_LEDn] = {${LED_PIN}};
[/#if]

[#assign BUTTON_GPIO_PORT=""]
[#assign BUTTON_PIN=""]
[#assign BUTTON_IRQN=""]
[#assign BUTTON_EXTI_LINE= ""]
[#if numButton > 0]
    [#if BspIpDatas??]
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
                        [#assign BUTTON_GPIO_PORT = BUTTON_GPIO_PORT + "SYS_BUTTON" + i + "_GPIO_PORT" + ", "]
                        [#assign BUTTON_PIN = BUTTON_PIN + "SYS_BUTTON" + i + "_PIN" + ", "]
                        [#assign BUTTON_IRQN = BUTTON_IRQN + "SYS_BUTTON" + i + "_EXTI_IRQn" + ", "]
                        [#assign BUTTON_EXTI_LINE = BUTTON_EXTI_LINE + ".Line = SYS_BUTTON" + i + "_EXTI_LINE" + ", "]
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]
/**
  * @brief Ports button list
  */
static GPIO_TypeDef   *SYS_BUTTON_PORT[SYS_BUTTONn] = {${BUTTON_GPIO_PORT}};

/**
  * @brief Pins button list
  */
static const uint16_t  SYS_BUTTON_PIN[SYS_BUTTONn] = {${BUTTON_PIN}};

/**
  * @brief IRQ button IDs list
  */
static const IRQn_Type SYS_BUTTON_IRQn[SYS_BUTTONn] = {${BUTTON_IRQN}};
[/#if]
[#if useDefine]
    [#-- EXTI_HandleTypeDef sys_hpb_exti[SYS_BUTTONn] = {{${BUTTON_EXTI_LINE}}}; --]
EXTI_HandleTypeDef sys_hpb_exti[SYS_BUTTONn];
[#else]
EXTI_HandleTypeDef* sys_hpb_exti[SYS_BUTTONn];
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
int32_t SYS_LED_Init(Sys_Led_TypeDef Led)
{
  GPIO_InitTypeDef  gpio_init_structure = {0};
  /* Enable the GPIO_SYS_LED Clock */
  SYS_LEDx_GPIO_CLK_ENABLE(Led);

  /* Configure the GPIO_SYS_LED pin */
  gpio_init_structure.Pin = SYS_LED_PIN[Led];
  gpio_init_structure.Mode = GPIO_MODE_OUTPUT_PP;
  gpio_init_structure.Pull = GPIO_NOPULL;
  gpio_init_structure.Speed = GPIO_SPEED_FREQ_HIGH;

  HAL_GPIO_Init(SYS_LED_PORT[Led], &gpio_init_structure);
  HAL_GPIO_WritePin(SYS_LED_PORT[Led], SYS_LED_PIN[Led], GPIO_PIN_RESET);

  return 0;
}

int32_t SYS_LED_DeInit(Sys_Led_TypeDef Led)
{
  /* Turn off SYS_LED */
  HAL_GPIO_WritePin(SYS_LED_PORT[Led], SYS_LED_PIN[Led], GPIO_PIN_RESET);

  /* DeInit the GPIO_SYS_LED pin */
  HAL_GPIO_DeInit(SYS_LED_PORT[Led], SYS_LED_PIN[Led]);

  return 0;
}

int32_t SYS_LED_On(Sys_Led_TypeDef Led)
{
  HAL_GPIO_WritePin(SYS_LED_PORT[Led], SYS_LED_PIN[Led], GPIO_PIN_SET);

  return 0;
}

int32_t SYS_LED_Off(Sys_Led_TypeDef Led)
{
  HAL_GPIO_WritePin(SYS_LED_PORT[Led], SYS_LED_PIN[Led], GPIO_PIN_RESET);

  return 0;
}

int32_t SYS_LED_Toggle(Sys_Led_TypeDef Led)
{
  HAL_GPIO_TogglePin(SYS_LED_PORT[Led], SYS_LED_PIN[Led]);

  return 0;
}

int32_t SYS_LED_GetState(Sys_Led_TypeDef Led)
{
  return (int32_t)HAL_GPIO_ReadPin(SYS_LED_PORT[Led], SYS_LED_PIN[Led]);
}

int32_t SYS_PB_Init(Sys_Button_TypeDef Button, Sys_ButtonMode_TypeDef ButtonMode)
{
  GPIO_InitTypeDef gpio_init_structure = {0};

[#assign j = 0]
[#assign SYS_BUTTON_EXTI_Callback =""]
[#assign SYS_BUTTONx_IT_PRIORITY =""]
[#assign SYS_BUTTON_EXTI_LINE =""]
[#if BspIpDatas??]
  [#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
      [#list SWIP.variables as variables]
        [#-- User BSP Button --]
        [#if variables.value?contains("BUTTON ") ]
          [#assign i=(variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
        [#assign SYS_BUTTON_EXTI_Callback = SYS_BUTTON_EXTI_Callback + ", SYS_BUTTON"+ i + "_EXTI_Callback"]
        [#assign SYS_BUTTONx_IT_PRIORITY = SYS_BUTTONx_IT_PRIORITY + ", SYS_BUTTONx_IT_PRIORITY"]
        [#assign SYS_BUTTON_EXTI_LINE = SYS_BUTTON_EXTI_LINE + ", SYS_BUTTON" + i + "_EXTI_LINE"]
          [#assign j = j+1]
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]
  static SYS_RES_EXTI_LineCallback button_callback[SYS_BUTTONn] = {${SYS_BUTTON_EXTI_Callback?remove_beginning(", ")}};
  static uint32_t button_interrupt_priority[SYS_BUTTONn] = {${SYS_BUTTONx_IT_PRIORITY?remove_beginning(", ")}};
  static const uint32_t button_exti_line[SYS_BUTTONn] = {${SYS_BUTTON_EXTI_LINE?remove_beginning(", ")}};

  /* Enable the SYS_BUTTON Clock */
  SYS_BUTTONx_GPIO_CLK_ENABLE(Button);

  gpio_init_structure.Pin = SYS_BUTTON_PIN[Button];
  gpio_init_structure.Pull = GPIO_PULLUP;
  gpio_init_structure.Speed = GPIO_SPEED_FREQ_HIGH;

  if (ButtonMode == SYS_BUTTON_MODE_GPIO)
  {
    /* Configure Button pin as input */
    gpio_init_structure.Mode = GPIO_MODE_INPUT;
    HAL_GPIO_Init(SYS_BUTTON_PORT[Button], &gpio_init_structure);
  }
  else /* (ButtonMode == SYS_BUTTON_MODE_EXTI) */
  {
    /* Configure Button pin as input with External interrupt */
    gpio_init_structure.Mode = GPIO_MODE_IT_FALLING;

    HAL_GPIO_Init(SYS_BUTTON_PORT[Button], &gpio_init_structure);

    (void)HAL_EXTI_GetHandle(&sys_hpb_exti[Button], button_exti_line[Button]);
    (void)HAL_EXTI_RegisterCallback(&sys_hpb_exti[Button],  HAL_EXTI_COMMON_CB_ID, button_callback[Button]);

    /* Enable and set Button EXTI Interrupt to the lowest priority */
    HAL_NVIC_SetPriority((SYS_BUTTON_IRQn[Button]), button_interrupt_priority[Button], 0x00);
    HAL_NVIC_EnableIRQ((SYS_BUTTON_IRQn[Button]));
  }

  return 0;
}

int32_t SYS_PB_DeInit(Sys_Button_TypeDef Button)
{
  HAL_NVIC_DisableIRQ((SYS_BUTTON_IRQn[Button]));
  HAL_GPIO_DeInit(SYS_BUTTON_PORT[Button], SYS_BUTTON_PIN[Button]);

  return 0;
}

int32_t SYS_PB_GetState(Sys_Button_TypeDef Button)
{
  return (int32_t)HAL_GPIO_ReadPin(SYS_BUTTON_PORT[Button], SYS_BUTTON_PIN[Button]);
}

void SYS_PB_IRQHandler(Sys_Button_TypeDef Button)
{
  HAL_EXTI_IRQHandler(&sys_hpb_exti[Button]);
}

[#assign j = 0]
[#if BspIpDatas??]
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
__weak void SYS_BUTTON${i}_EXTI_Callback(void)
{
  /* This function should be implemented by the user application.
     It is called into this driver when an event on Button is triggered.*/
}

          [#assign j = j+1]
        [/#if]
      [/#list]
    [/#if]
  [/#list]
[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
