[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${BoardName}_bus.c
  * @brief          : source file for the BSP BUS IO driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "${BoardName}_bus.h"

[#assign IpName = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#assign SPIDmaIsTrue = false]

[#assign I2C = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2CDmaIsTrue = false]

[#assign USART = ""]
[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USARTDmaIsTrue = false]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
                        [#assign SPIDmaIsTrue = bsp.dmaUsed]
[#-- extern SPI_HandleTypeDef h${SpiIpInstance?lower_case};                     --]
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- extern SPI_HandleTypeDef h${SpiIpInstance?lower_case};--]
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
                        [#assign I2CDmaIsTrue = bsp.dmaUsed]
[#-- extern I2C_HandleTypeDef h${I2CIpInstance?lower_case}; --]
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- extern I2C_HandleTypeDef h${I2CIpInstance?lower_case}; --]
                    [/#if]
                [#break]
                [#case "USART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [#assign USARTDmaIsTrue = bsp.dmaUsed]
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case};  --]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case}; --]
                    [/#if]
                [#break]
                [#case "UART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [#assign USARTDmaIsTrue = bsp.dmaUsed]
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case};  --]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case}; --]
                    [/#if]
                [#break]
                [#case "LPUART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [#assign USARTDmaIsTrue = bsp.dmaUsed]
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case};  --]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case}; --]
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIisTrue = false]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2C = ""]
[#assign I2CisTrue = false]
[#assign I2CInstance = ""]
[#assign I2CIpInstanceList = ""]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#assign SPIisTrue = true]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${SpiIpInstance}_Init(SPI_HandleTypeDef* hspi);
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${SpiIpInstance}_Init(SPI_HandleTypeDef* hspi);
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#assign I2CisTrue = true]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${I2CIpInstance}_Init(I2C_HandleTypeDef* hi2c);
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${I2CIpInstance}_Init(I2C_HandleTypeDef* hi2c);
                    [/#if]
                [#break]
                [#case "USART"]
                    [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_UART_Init(UART_HandleTypeDef* huart);
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_UART_Init(UART_HandleTypeDef* huart);
                    [/#if]
                [#break]
                [#case "UART"]
                    [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_UART_Init(UART_HandleTypeDef* huart);
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_UART_Init(UART_HandleTypeDef* huart);
                    [/#if]
                [#break]
                [#case "LPUART"]
                    [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_UART_Init(UART_HandleTypeDef* huart);
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after review with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_UART_Init(UART_HandleTypeDef* huart);
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/** @addtogroup BSP
  * @{
  */

/** @addtogroup ${BoardName?upper_case}
  * @{
  */

/** @defgroup ${BoardName?upper_case}_BUS ${BoardName?upper_case} BUS
  * @{
  */

[#if I2CDmaIsTrue || SPIDmaIsTrue || USARTDmaIsTrue]
extern void Error_Handler(void);
[/#if]
[#if I2CisTrue]
[#if FamilyName?starts_with("STM32L4")]
#define DIV_ROUND_CLOSEST(x, d)  (((x) + ((d) / 2U)) / (d))

#define I2C_ANALOG_FILTER_DELAY_MIN            50U     /* ns */
#define I2C_ANALOG_FILTER_DELAY_MAX            260U    /* ns */
#define I2C_ANALOG_FILTER_DELAY_DEFAULT        2U      /* ns */

#ifndef I2C_VALID_TIMING_NBR
  #define I2C_VALID_TIMING_NBR                 128U
#endif

#define I2C_SPEED_STANDARD                     0U    /* 100 kHz */
#define I2C_SPEED_FAST                         1U    /* 400 kHz */
#define I2C_SPEED_FAST_PLUS                    2U    /* 1 MHz */

#define I2C_PRESC_MAX                          16U
#define I2C_SCLDEL_MAX                         16U
#define I2C_SDADEL_MAX                         16U
#define I2C_SCLH_MAX                           256U
#define I2C_SCLL_MAX                           256U
#define SEC2NSEC                               1000000000UL


#if (USE_CUBEMX_BSP_V2 == 1)
/**
  * @brief I2C_charac
  *  freq: I2C bus speed (Hz)
  *  freq_min: 80% of I2C bus speed (Hz)
  *  freq_max: 100% of I2C bus speed (Hz)
  *  fall_max: Max fall time of both SDA and SCL signals (ns)
  *  rise_max: Max rise time of both SDA and SCL signals (ns)
  *  hddat_min: Min data hold time (ns)
  *  vddat_max: Max data valid time (ns)
  *  sudat_min: Min data setup time (ns)
  *  lscl_min: Min low period of the SCL clock (ns)
  *  hscl_min: Min high period of the SCL clock (ns)
  *  trise: Rise time (ns)
  *  tfall: Fall time (ns)
  *  dnf: Digital filter coefficient (0-16)
  */
typedef struct
{
  uint32_t freq;
  uint32_t freq_min;
  uint32_t freq_max;
  uint32_t hddat_min;
  uint32_t vddat_max;
  uint32_t sudat_min;
  uint32_t lscl_min;
  uint32_t hscl_min;
  uint32_t trise;
  uint32_t tfall;
  uint32_t dnf;
}I2C_Charac_t;

/**
  * @brief I2C timings parameters
  *  presc: Prescaler value
  *  tscldel: Data setup time
  *  tsdadel: Data hold time
  *  sclh: SCL high period (master mode)
  *  scll: SCL low period (master mode)
  */
typedef struct
{
  uint32_t presc;
  uint32_t tscldel;
  uint32_t tsdadel;
  uint32_t sclh;
  uint32_t scll;
}I2C_Timings_t;

static const I2C_Charac_t I2C_Charac[] =
{
  [I2C_SPEED_STANDARD] =
  {
    .freq = 100000,
    .freq_min = 80000,
    .freq_max = 120000,
    .hddat_min = 0,
    .vddat_max = 3450,
    .sudat_min = 250,
    .lscl_min = 4700,
    .hscl_min = 4000,
    .trise = 400,
    .tfall = 100,
    .dnf = I2C_ANALOG_FILTER_DELAY_DEFAULT,
  },
  [I2C_SPEED_FAST] =
  {
    .freq = 400000,
    .freq_min = 320000,
    .freq_max = 480000,
    .hddat_min = 0,
    .vddat_max = 900,
    .sudat_min = 100,
    .lscl_min = 1300,
    .hscl_min = 600,
    .trise = 250,
    .tfall = 100,
    .dnf = I2C_ANALOG_FILTER_DELAY_DEFAULT,
  },
  [I2C_SPEED_FAST_PLUS] =
  {
    .freq = 1000000,
    .freq_min = 800000,
    .freq_max = 1200000,
    .hddat_min = 0,
    .vddat_max = 450,
    .sudat_min = 50,
    .lscl_min = 500,
    .hscl_min = 260,
    .trise = 60,
    .tfall = 100,
    .dnf = I2C_ANALOG_FILTER_DELAY_DEFAULT,
  },
};
static I2C_Timings_t valid_timing[I2C_VALID_TIMING_NBR];
static uint32_t valid_timing_nbr = 0;
#endif
[/#if]
[/#if]

/** @defgroup ${BoardName?upper_case}_BUS_Exported_Variables BUS Exported Variables
  * @{
  */
[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
[#-- extern : A.T removed after review with Maher --]
SPI_HandleTypeDef h${SpiIpInstance?lower_case};
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after review with Maher --]
SPI_HandleTypeDef h${SpiIpInstance?lower_case};
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
[#-- extern : A.T removed after review with Maher --]
I2C_HandleTypeDef h${I2CIpInstance?lower_case};
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after review with Maher --]
I2C_HandleTypeDef h${I2CIpInstance?lower_case};
                    [/#if]
                [#break]
                [#case "USART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- extern : A.T removed after review with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after review with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [/#if]
                [#break]
                [#case "UART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- extern : A.T removed after review with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after review with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
                    [/#if]
                [#break]
                [#case "LPUART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- extern : A.T removed after review with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after review with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_BUS_Private_Variables BUS Private Variables
  * @{
  */
[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIisTrue = false]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2CisTrue = false]
[#assign I2C = ""]
[#assign I2CInstance = ""]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#assign SPIisTrue = true]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1U)
static uint32_t Is${SpiIpInstance}MspCbValid = 0;
#endif /* USE_HAL_SPI_REGISTER_CALLBACKS */
static uint32_t ${SpiIpInstance}InitCounter = 0;
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1U)
static uint32_t Is${SpiIpInstance}MspCbValid = 0;
#endif /* USE_HAL_SPI_REGISTER_CALLBACKS */
static uint32_t ${SpiIpInstance}InitCounter = 0;
                    [/#if]
                [#break]
                [#case "I2C"]
                [#assign I2CisTrue = true]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1U)
static uint32_t Is${I2CIpInstance}MspCbValid = 0;
#endif /* USE_HAL_I2C_REGISTER_CALLBACKS */
static uint32_t ${I2CIpInstance}InitCounter = 0;
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1U)
static uint32_t Is${I2CIpInstance}MspCbValid = 0;
#endif /* USE_HAL_I2C_REGISTER_CALLBACKS */
static uint32_t ${I2CIpInstance}InitCounter = 0;
                    [/#if]
                [#break]
                [#case "UART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
static uint32_t ${UsartIpInstance}InitCounter = 0;
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
static uint32_t ${UsartIpInstance}InitCounter = 0;
                    [/#if]
                [#break]
                [#case "USART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
static uint32_t ${UsartIpInstance}InitCounter = 0;
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
static uint32_t ${UsartIpInstance}InitCounter = 0;
                    [/#if]
                [#break]
                [#case "LPUART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
static uint32_t ${UsartIpInstance}InitCounter = 0;
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
static uint32_t ${UsartIpInstance}InitCounter = 0;
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/**
  * @}
  */


/** @defgroup ${BoardName?upper_case}_BUS_Private_FunctionPrototypes  BUS Private Function
  * @{
  */

[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]


[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
static void ${SpiIpInstance}_MspInit(SPI_HandleTypeDef* hSPI);
static void ${SpiIpInstance}_MspDeInit(SPI_HandleTypeDef* hSPI);
#if (USE_CUBEMX_BSP_V2 == 1)
static uint32_t SPI_GetPrescaler( uint32_t clk_src_hz, uint32_t baudrate_mbps );
#endif
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
static void ${SpiIpInstance}_MspInit(SPI_HandleTypeDef* hSPI);
static void ${SpiIpInstance}_MspDeInit(SPI_HandleTypeDef* hSPI);
#if (USE_CUBEMX_BSP_V2 == 1)
static uint32_t SPI_GetPrescaler( uint32_t clk_src_hz, uint32_t baudrate_mbps );
#endif
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
static void ${I2CIpInstance}_MspInit(I2C_HandleTypeDef* hI2c);
static void ${I2CIpInstance}_MspDeInit(I2C_HandleTypeDef* hI2c);
#if (USE_CUBEMX_BSP_V2 == 1)
static uint32_t I2C_GetTiming(uint32_t clock_src_hz, uint32_t i2cfreq_hz);
static void Compute_PRESC_SCLDEL_SDADEL(uint32_t clock_src_freq, uint32_t I2C_Speed);
static uint32_t Compute_SCLL_SCLH (uint32_t clock_src_freq, uint32_t I2C_speed);
#endif
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
static void ${I2CIpInstance}_MspInit(I2C_HandleTypeDef* hI2c);
static void ${I2CIpInstance}_MspDeInit(I2C_HandleTypeDef* hI2c);
[#if FamilyName?starts_with("STM32L4")]
#if (USE_CUBEMX_BSP_V2 == 1)
static uint32_t I2C_GetTiming(uint32_t clock_src_hz, uint32_t i2cfreq_hz);
static void Compute_PRESC_SCLDEL_SDADEL(uint32_t clock_src_freq, uint32_t I2C_Speed);
static uint32_t Compute_SCLL_SCLH (uint32_t clock_src_freq, uint32_t I2C_speed);
#endif
[/#if]
                    [/#if]
                    [#break]
                    [#case "UART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
static void ${UsartIpInstance}_MspInit(UART_HandleTypeDef* huart);
static void ${UsartIpInstance}_MspDeInit(UART_HandleTypeDef* huart);
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
static void ${UsartIpInstance}_MspInit(UART_HandleTypeDef* huart);
static void ${UsartIpInstance}_MspDeInit(UART_HandleTypeDef* huart);
                    [/#if]
                [#break]
                [#case "USART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
static void ${UsartIpInstance}_MspInit(UART_HandleTypeDef* huart);
static void ${UsartIpInstance}_MspDeInit(UART_HandleTypeDef* huart);
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
static void ${UsartIpInstance}_MspInit(UART_HandleTypeDef* huart);
static void ${UsartIpInstance}_MspDeInit(UART_HandleTypeDef* huart);
                    [/#if]
                [#break]
                [#case "LPUART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
static void ${UsartIpInstance}_MspInit(UART_HandleTypeDef* huart);
static void ${UsartIpInstance}_MspDeInit(UART_HandleTypeDef* huart);
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
static void ${UsartIpInstance}_MspInit(UART_HandleTypeDef* huart);
static void ${UsartIpInstance}_MspDeInit(UART_HandleTypeDef* huart);
                    [/#if]
                [#break]
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

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#if SpiIpInstanceList == ""]
/* BUS IO driver over SPI Peripheral */
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
                        [@generateBspSPI_Driver SpiIpInstance bsp/]
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
                        [@generateBspSPI_Driver SpiIpInstance bsp/]
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#if I2CIpInstanceList == ""]
/* BUS IO driver over I2C Peripheral */
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
                        [@generateBspI2C_Driver I2CIpInstance bsp/]
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
                        [@generateBspI2C_Driver I2CIpInstance bsp/]
                    [/#if]
                [#break]
                [#case "USART"]
                    [#if UsartIpInstanceList == ""]
/* BUS IO driver over USART Peripheral */
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [@generateBspUSART_Driver UsartIpInstance bsp/]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
                        [@generateBspUSART_Driver UsartIpInstance bsp/]
                    [/#if]
                [#break]
                [#case "UART"]
                    [#if UsartIpInstanceList == ""]
/* BUS IO driver over UART Peripheral */
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [@generateBspUSART_Driver UsartIpInstance bsp/]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
                        [@generateBspUSART_Driver UsartIpInstance bsp/]
                    [/#if]
                [#break]
                [#case "LPUART"]
                    [#if UsartIpInstanceList == ""]
/* BUS IO driver over UART Peripheral */
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [@generateBspUSART_Driver UsartIpInstance bsp/]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
                        [@generateBspUSART_Driver UsartIpInstance bsp/]
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
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
                                [#case "UART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [@registerMspUSARTCallBack IpName UsartIpInstance UsartIpInstance/]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
                        [@registerMspUSARTCallBack IpName UsartIpInstance UsartIpInstance/]
                    [/#if]
                [#break]
                [#case "USART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [@registerMspUSARTCallBack IpName UsartIpInstance UsartIpInstance/]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
                        [@registerMspUSARTCallBack IpName UsartIpInstance UsartIpInstance/]
                    [/#if]
                [#break]
                [#case "LPUART"]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
                        [@registerMspUSARTCallBack IpName UsartIpInstance UsartIpInstance/]
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
                        [@registerMspUSARTCallBack IpName UsartIpInstance UsartIpInstance/]
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#-- macro generateBspI2C_Driver --]
[#macro generateBspI2C_Driver IpInstance bsp]
/*******************************************************************************
                            BUS OPERATIONS OVER I2C
*******************************************************************************/
/**
  * @brief  Initialize I2C HAL
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void)
{

  int32_t ret = BSP_ERROR_NONE;

  h${IpInstance?lower_case}.Instance  = ${IpInstance?upper_case};

  if(${I2CIpInstance}InitCounter++ == 0)
  {
    if (HAL_I2C_GetState(&h${IpInstance?lower_case}) == HAL_I2C_STATE_RESET)
    {
    #if (USE_HAL_I2C_REGISTER_CALLBACKS == 0U)
      /* Init the I2C Msp */
      ${IpInstance?upper_case}_MspInit(&h${IpInstance?lower_case});
    #else
      if(Is${I2CIpInstance}MspCbValid == 0U)
      {
        if(BSP_${IpInstance?upper_case}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
        {
          return BSP_ERROR_MSP_FAILURE;
        }
      }
    #endif
      if(ret == BSP_ERROR_NONE)
      {
        /* Init the I2C */
        if(MX_${IpInstance}_Init(&h${IpInstance?lower_case}) != HAL_OK)
        {
          ret = BSP_ERROR_BUS_FAILURE;
        }
    [#if FamilyName.contains("STM32L1") || FamilyName.contains("STM32F1") || FamilyName.contains("STM32F2") || FamilyName.contains("STM32F4")]
    [#else]
        else if(HAL_I2CEx_ConfigAnalogFilter(&h${IpInstance?lower_case}, I2C_ANALOGFILTER_ENABLE) != HAL_OK)
        {
          ret = BSP_ERROR_BUS_FAILURE;
        }
    [/#if]
        else
        {
          ret = BSP_ERROR_NONE;
        }
      }
    }
  }
  return ret;
}


/**
  * @brief  DeInitialize I2C HAL.
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void)
{
  int32_t ret = BSP_ERROR_NONE;

  if (${I2CIpInstance}InitCounter > 0)
  {
    if (--${I2CIpInstance}InitCounter == 0)
    {
  #if (USE_HAL_I2C_REGISTER_CALLBACKS == 0U)
      /* DeInit the I2C */
      ${IpInstance?upper_case}_MspDeInit(&h${IpInstance?lower_case});
  #endif
      /* DeInit the I2C */
      if (HAL_I2C_DeInit(&h${IpInstance?lower_case}) != HAL_OK)
      {
        ret = BSP_ERROR_BUS_FAILURE;
      }
    }
  }
  return ret;
}

/**
  * @brief  Check whether the I2C bus is ready.
  * @param DevAddr : I2C device address
  * @param Trials : Check trials number
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_IsReady(uint16_t DevAddr, uint32_t Trials)
{
  int32_t ret = BSP_ERROR_NONE;

  if (HAL_I2C_IsDeviceReady(&h${IpInstance?lower_case}, DevAddr, Trials, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    ret = BSP_ERROR_BUSY;
  }

  return ret;
}


/**
  * @brief  Write a value in a register of the device through BUS.
  * @param  DevAddr Device address on Bus.
  * @param  Reg    The target register address to write
  * @param  pData  Pointer to data buffer to write
  * @param  Length Data Length
  * @retval BSP status
  */

int32_t BSP_${IpInstance}_WriteReg(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if (HAL_I2C_Mem_Write(&h${IpInstance?lower_case}, DevAddr,Reg, I2C_MEMADD_SIZE_8BIT,pData, Length, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    if (HAL_I2C_GetError(&h${IpInstance?lower_case}) == HAL_I2C_ERROR_AF)
    {
      ret = BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
  }
  return ret;
}


/**
  * @brief  Read a register of the device through BUS
  * @param  DevAddr Device address on Bus.
  * @param  Reg    The target register address to read
  * @param  pData  Pointer to data buffer to read
  * @param  Length Data Length
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_ReadReg(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if (HAL_I2C_Mem_Read(&h${IpInstance?lower_case}, DevAddr, Reg, I2C_MEMADD_SIZE_8BIT, pData, Length, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    if (HAL_I2C_GetError(&h${IpInstance?lower_case}) == HAL_I2C_ERROR_AF)
    {
      ret = BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret = BSP_ERROR_PERIPH_FAILURE;
    }
  }
  return ret;
}


/**

  * @brief  Write a value in a register of the device through BUS.
  * @param  DevAddr Device address on Bus.
  * @param  Reg    The target register address to write

  * @param  pData  Pointer to data buffer to write
  * @param  Length Data Length
  * @retval BSP statu
  */
int32_t BSP_${IpInstance}_WriteReg16(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;


  if (HAL_I2C_Mem_Write(&h${IpInstance?lower_case}, DevAddr, Reg, I2C_MEMADD_SIZE_16BIT, pData, Length, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    if (HAL_I2C_GetError(&h${IpInstance?lower_case}) == HAL_I2C_ERROR_AF)
    {
      ret = BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
  }
  return ret;
}


/**
  * @brief  Read registers through a bus (16 bits)
  * @param  DevAddr: Device address on BUS
  * @param  Reg: The target register address to read
  * @param  Length Data Length
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_ReadReg16(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if (HAL_I2C_Mem_Read(&h${IpInstance?lower_case}, DevAddr, Reg, I2C_MEMADD_SIZE_16BIT, pData, Length, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    if (HAL_I2C_GetError(&h${IpInstance?lower_case}) != HAL_I2C_ERROR_AF)
    {
      ret =  BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
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
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t Length) {
  int32_t ret = BSP_ERROR_NONE;

  if (HAL_I2C_Master_Transmit(&h${IpInstance?lower_case}, DevAddr, pData, Length, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    if (HAL_I2C_GetError(&h${IpInstance?lower_case}) != HAL_I2C_ERROR_AF)
    {
      ret = BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
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
int32_t BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t Length) {
  int32_t ret = BSP_ERROR_NONE;

  if (HAL_I2C_Master_Receive(&h${IpInstance?lower_case}, DevAddr, pData, Length, BUS_${I2CIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
    if (HAL_I2C_GetError(&h${IpInstance?lower_case}) != HAL_I2C_ERROR_AF)
    {
      ret = BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
  }
  return ret;
}

[#if bsp.dmaTx]
/**
  * @brief  Write Data through I2C BUS with DMA.
  * @param  pData: Pointer to data buffer to send
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send_DMA(uint16_t DevAddr, uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_I2C_Master_Transmit_DMA(&h${IpInstance?lower_case}, DevAddr, pData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]
[#if bsp.dmaRx]
/**
  * @brief  Receive Data from I2C BUS with DMA
  * @param  pData: Pointer to data buffer to receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv_DMA(uint16_t DevAddr, uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_I2C_Master_Receive_DMA(&h${IpInstance?lower_case}, DevAddr, pData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]
[#-- // LC: commented out, it does not make sense. Also the case for polling mode is commented
/**
  * @brief  Send and Receive data to/from I2C BUS (Full duplex) with DMA
  * @param  pData: Pointer to data buffer to send/receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv_DMA(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  //if(HAL_I2C_TransmitReceive_DMA(&h${IpInstance?lower_case}, pTxData, pRxData, Length) != HAL_OK)
  //{
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  //}

--]

[#--
/**
  * @brief  Send and receive an amount of data through bus (Full duplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pTxdata: Transmit data pointer
  * @param  pRxdata: Receive data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxdata, uint8_t *pRxdata, uint16_t Length) {
    int32_t ret = BSP_ERROR_BUS_FAILURE;

    /*
     * Send and receive an amount of data through bus (Full duplex)
     * I2C is Half-Duplex protocol
     */
    if ((BSP_${IpInstance}_Send(DevAddr, pTxdata, Length) == Length) && \
        (BSP_${IpInstance}_Recv(DevAddr, pRxdata, Length) == Length))
            {
                ret = Length;
            }

    return ret;
}
--]
[/#macro]
[#-- End macro generateBspI2C_Driver --]

[#-- macro generateBspSPI_Driver --]
[#macro generateBspSPI_Driver IpInstance bsp]
/*******************************************************************************
                            BUS OPERATIONS OVER SPI
*******************************************************************************/
/**
  * @brief  Initializes SPI HAL.
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void)
{
  int32_t ret = BSP_ERROR_NONE;

  h${IpInstance?lower_case}.Instance  = ${IpInstance?upper_case};

  if(${SpiIpInstance}InitCounter++ == 0)
  {
    if (HAL_SPI_GetState(&h${IpInstance?lower_case}) == HAL_SPI_STATE_RESET)
    {
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 0U)
        /* Init the SPI Msp */
        ${IpInstance?upper_case}_MspInit(&h${IpInstance?lower_case});
#else
        if(Is${SpiIpInstance}MspCbValid == 0U)
        {
            if(BSP_${IpInstance?upper_case}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
            {
                return BSP_ERROR_MSP_FAILURE;
            }
        }
#endif
        if(ret == BSP_ERROR_NONE)
        {
            /* Init the SPI */
            if (MX_${IpInstance}_Init(&h${IpInstance?lower_case}) != HAL_OK)
            {
                ret = BSP_ERROR_BUS_FAILURE;
            }
        }
    }
  }

  return ret;
}


/**
  * @brief  DeInitializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void)
{
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  if (${SpiIpInstance}InitCounter > 0)
  {
    if (--${SpiIpInstance}InitCounter == 0)
    {
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 0U)
      ${IpInstance?upper_case}_MspDeInit(&h${IpInstance?lower_case});
#endif
      /* DeInit the SPI*/
      if (HAL_SPI_DeInit(&h${IpInstance?lower_case}) == HAL_OK)
      {
        ret = BSP_ERROR_NONE;
      }
    }
  }
  return ret;
}


/**
  * @brief  Write Data through SPI BUS.
  * @param  pData: Pointer to data buffer to send
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_SPI_Transmit(&h${IpInstance?lower_case}, pData, Length, BUS_${SpiIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}


/**
  * @brief  Receive Data from SPI BUS
  * @param  pData: Pointer to data buffer to receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_SPI_Receive(&h${IpInstance?lower_case}, pData, Length, BUS_${SpiIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}


/**
  * @brief  Send and Receive data to/from SPI BUS (Full duplex)
  * @param  pData: Pointer to data buffer to send/receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_SPI_TransmitReceive(&h${IpInstance?lower_case}, pTxData, pRxData, Length, BUS_${SpiIpInstance}_POLL_TIMEOUT) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}

[#if bsp.dmaTx]
/**
  * @brief  Write Data through SPI BUS with DMA.
  * @param  pData: Pointer to data buffer to send
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send_DMA(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_SPI_Transmit_DMA(&h${IpInstance?lower_case}, pData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]

[#if bsp.dmaRx]
/**
  * @brief  Receive Data from SPI BUS with DMA
  * @param  pData: Pointer to data buffer to receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv_DMA(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_SPI_Receive_DMA(&h${IpInstance?lower_case}, pData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]

[#if bsp.dmaUsed]
/**
  * @brief  Send and Receive data to/from SPI BUS (Full duplex) with DMA
  * @param  pData: Pointer to data buffer to send/receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv_DMA(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_SPI_TransmitReceive_DMA(&h${IpInstance?lower_case}, pTxData, pRxData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]
[/#macro]
[#-- End macro generateBspSPI_Driver --]

[#-- macro generateBspUSART_Driver --]
[#macro generateBspUSART_Driver IpInstance bsp]
[#assign ipName = bsp.ipNameUsed]
[#assign halMode = false]
[#if bsp.halMode == ipName]
    [#assign halMode = true]
[#else]	  
	[#assign halModeName = bsp.halMode]	
[/#if]
/*******************************************************************************
                            BUS OPERATIONS OVER USART
*******************************************************************************/
/**
  * @brief  Initializes USART HAL.
  * @param  Init : UART initialization parameters
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void)
{
  int32_t ret = BSP_ERROR_NONE;

  h${IpInstance?lower_case?replace("s","")}.Instance  = ${IpInstance?upper_case};

  if(${UsartIpInstance}InitCounter++ == 0)
  {
    if (HAL_UART_GetState(&h${IpInstance?lower_case?replace("s","")}) == HAL_UART_STATE_RESET)
    {
#if (USE_HAL_UART_REGISTER_CALLBACKS == 0U)
      /* Init the UART Msp */
      ${IpInstance?upper_case}_MspInit(&h${IpInstance?lower_case?replace("s","")});
#else
      if(Is${UsartIpInstance}MspCbValid == 0U)
      {
        if(BSP_${IpInstance?upper_case?replace("s","")}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
        {
          return BSP_ERROR_MSP_FAILURE;
        }
      }
#endif
      if(ret == BSP_ERROR_NONE)
      {
        /* Init the UART */
        [#if halMode]
        if (MX_${IpInstance}_Init(&h${IpInstance?lower_case?replace("s","")}) != HAL_OK)
        [#else]
        if (MX_${IpInstance}_UART_Init(&h${IpInstance?lower_case?replace("s","")}) != HAL_OK)
        [/#if]
        {
          ret = BSP_ERROR_BUS_FAILURE;
        }
      }
    }
  }
  return ret;
}


/**
  * @brief  DeInitializes UART HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void)
{
  int32_t ret = BSP_ERROR_BUS_FAILURE;

  if (${UsartIpInstance}InitCounter > 0)
  {
    if (--${UsartIpInstance}InitCounter == 0)
    {
#if (USE_HAL_UART_REGISTER_CALLBACKS == 0U)
      ${IpInstance?upper_case}_MspDeInit(&h${IpInstance?lower_case?replace("s","")});
#endif
      /* DeInit the UART*/
      if (HAL_UART_DeInit(&h${IpInstance?lower_case?replace("s","")}) == HAL_OK)
      {
        ret = BSP_ERROR_NONE;
      }
    }
  }
  return ret;
}


/**
  * @brief  Write Data through UART BUS.
  * @param  pData: Pointer to data buffer to send
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;

  if(HAL_UART_Transmit(&h${IpInstance?lower_case?replace("s","")}, pData, Length, BUS_${UsartIpInstance}_POLL_TIMEOUT) == HAL_OK)
  {
      ret = BSP_ERROR_NONE;
  }
  return ret;
}


/**
  * @brief  Receive Data from UART BUS
  * @param  pData: Pointer to data buffer to receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;

  if(HAL_UART_Receive(&h${IpInstance?lower_case?replace("s","")}, pData, Length, BUS_${UsartIpInstance}_POLL_TIMEOUT) == HAL_OK)
  {
      ret = BSP_ERROR_NONE;
  }
  return ret;
}
[#if bsp.dmaTx]
/**
  * @brief  Write Data through USART BUS with DMA.
  * @param  pData: Pointer to data buffer to send
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send_DMA(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_UART_Transmit_DMA(&h${IpInstance?lower_case?replace("s","")}, pData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]

[#if bsp.dmaRx]
/**
  * @brief  Receive Data from USART BUS with DMA
  * @param  pData: Pointer to data buffer to receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv_DMA(uint8_t *pData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  if(HAL_UART_Receive_DMA(&h${IpInstance?lower_case?replace("s","")}, pData, Length) != HAL_OK)
  {
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  }
  return ret;
}
[/#if]
[#-- //LC: comment... this is an open point to me... also how UART is implemented. USART has a transmitreceive method, other functions no...

/**
  * @brief  Send and Receive data to/from USART BUS (Full duplex) with DMA
  * @param  pData: Pointer to data buffer to send/receive
  * @param  Length: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv_DMA(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length)
{
  int32_t ret = BSP_ERROR_NONE;

  //if(HAL_USART_TransmitReceive_DMA(&h${IpInstance?lower_case}, pTxData, pRxData, Length) != HAL_OK)
  //{
      ret = BSP_ERROR_UNKNOWN_FAILURE;
  //}
  return ret;
}

 --]


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
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1U)
/**
  * @brief Register Default BSP ${IpInstance} Bus Msp Callbacks
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void)
{

  __HAL_${IpName}_RESET_HANDLE_STATE(&h${IpHandle?lower_case});

  /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, ${IpInstance}_MspInit)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, ${IpInstance}_MspDeInit) != HAL_OK)
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
  __HAL_${IpName}_RESET_HANDLE_STATE(&h${IpHandle?lower_case});

   /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, Callbacks->pMspInitCb)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, Callbacks->pMspDeInitCb) != HAL_OK)
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
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1U)
/**
  * @brief Register Default BSP ${IpInstance} Bus Msp Callbacks
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void)
{

  __HAL_${IpName}_RESET_HANDLE_STATE(&h${IpHandle?lower_case});

  /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, ${IpInstance}_MspInit)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, ${IpInstance}_MspDeInit) != HAL_OK)
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
  __HAL_${IpName}_RESET_HANDLE_STATE(&h${IpHandle?lower_case});

   /* Register MspInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPINIT_CB_ID, Callbacks->pMspInitCb)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  /* Register MspDeInit Callback */
  if (HAL_${IpName}_RegisterCallback(&h${IpHandle?lower_case}, HAL_${IpName}_MSPDEINIT_CB_ID, Callbacks->pMspDeInitCb) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  Is${IpInstance}MspCbValid = 1;

  return BSP_ERROR_NONE;
}
#endif /* USE_HAL_I2C_REGISTER_CALLBACKS */
[/#macro]
[#-- End macro registerMspI2CCallBack --]

[#-- macro registerMspUSARTCallBack --]
[#macro registerMspUSARTCallBack IpName IpInstance IpHandle]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
/**
  * @brief Register Default BSP ${IpInstance} Bus Msp Callbacks
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void)
{

  __HAL_${IpName?replace("S","")?replace("LP","")}_RESET_HANDLE_STATE(&h${IpHandle?lower_case?replace("s","")});

  /* Register MspInit Callback */
  if (HAL_${IpName?replace("S","")?replace("LP","")}_RegisterCallback(&h${IpHandle?lower_case?replace("s","")}, HAL_${IpName?replace("S","")?replace("LP","")}_MSPINIT_CB_ID, ${IpInstance}_MspInit)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  /* Register MspDeInit Callback */
  if (HAL_${IpName?replace("S","")?replace("LP","")}_RegisterCallback(&h${IpHandle?lower_case?replace("s","")}, HAL_${IpName?replace("S","")?replace("LP","")}_MSPDEINIT_CB_ID, ${IpInstance}_MspDeInit) != HAL_OK)
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
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_${IpName?replace("S","")?replace("LP","")}_Cb_t *Callbacks)
{
  /* Prevent unused argument(s) compilation warning */
  __HAL_${IpName?replace("S","")?replace("LP","")}_RESET_HANDLE_STATE(&h${IpHandle?lower_case?replace("s","")});

   /* Register MspInit Callback */
  if (HAL_${IpName?replace("S","")?replace("LP","")}_RegisterCallback(&h${IpHandle?lower_case?replace("s","")}, HAL_${IpName?replace("S","")?replace("LP","")}_MSPINIT_CB_ID, Callbacks->pMspInitCb)  != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  /* Register MspDeInit Callback */
  if (HAL_${IpName?replace("S","")?replace("LP","")}_RegisterCallback(&h${IpHandle?lower_case?replace("s","")}, HAL_${IpName?replace("S","")?replace("LP","")}_MSPDEINIT_CB_ID, Callbacks->pMspDeInitCb) != HAL_OK)
  {
    return BSP_ERROR_PERIPH_FAILURE;
  }

  Is${IpInstance}MspCbValid = 1;

  return BSP_ERROR_NONE;
}
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
[/#macro]
[#-- End macro registerMspUSARTCallBack --]

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
[#if UsartIpInstanceList??]
    [#assign usartInsts = UsartIpInstanceList?split(",")]
    [#list usartInsts as UsartIpInst]
        [#if UsartIpInst??]
            [@common.optinclude name=mxTmpFolder+"/${UsartIpInst?lower_case}_IOBus_HalInit.tmp"/]
            [@common.optinclude name=mxTmpFolder+"/${UsartIpInst?lower_case}_IOBus_Msp.tmp"/]
        [/#if]
    [/#list]
[/#if]


[#if I2CisTrue]
[#if FamilyName?starts_with("STM32L4")]
#if (USE_CUBEMX_BSP_V2 == 1)
/**
  * @brief  Convert the I2C Frequency into I2C timing.
  * @note   The algorithm to compute the different fields of the Timings register
  *         is described in the AN4235 and the charac timings are inline with
  *         the product RM.
  * @param  clock_src_freq : I2C source clock in HZ.
  * @param  i2c_freq : I2C frequency in Hz.
  * @retval I2C timing value
  */
static uint32_t I2C_GetTiming(uint32_t clock_src_freq, uint32_t i2c_freq)
{
  uint32_t ret = 0;
  uint32_t speed;
  uint32_t idx;

  if((clock_src_freq != 0U) && (i2c_freq != 0U))
  {
    for ( speed = 0 ; speed <=  (uint32_t)I2C_SPEED_FAST_PLUS ; speed++)
    {
      if ((i2c_freq >= I2C_Charac[speed].freq_min) &&
          (i2c_freq <= I2C_Charac[speed].freq_max))
      {
        Compute_PRESC_SCLDEL_SDADEL(clock_src_freq, speed);
        idx = Compute_SCLL_SCLH(clock_src_freq, speed);

        if (idx < I2C_VALID_TIMING_NBR)
        {
          ret = ((valid_timing[idx].presc  & 0x0FU) << 28) |\
                ((valid_timing[idx].tscldel & 0x0FU) << 20) |\
                ((valid_timing[idx].tsdadel & 0x0FU) << 16) |\
                ((valid_timing[idx].sclh & 0xFFU) << 8) |\
                ((valid_timing[idx].scll & 0xFFU) << 0);
        }
        break;
      }
    }
  }

  return ret;
}


/**
  * @brief  Compute PRESC, SCLDEL and SDADEL.
  * @param  clock_src_freq : I2C source clock in HZ.
  * @param  I2C_Speed : I2C frequency (index).
  * @retval None
  */
static void Compute_PRESC_SCLDEL_SDADEL(uint32_t clock_src_freq, uint32_t I2C_Speed)
{
  uint32_t prev_presc = I2C_PRESC_MAX;
  uint32_t ti2cclk;
  int32_t  tsdadel_min, tsdadel_max;
  int32_t  tscldel_min;
  uint32_t presc, scldel, sdadel;

  ti2cclk   = (SEC2NSEC + (clock_src_freq / 2U))/ clock_src_freq;

  /* tDNF = DNF x tI2CCLK
     tPRESC = (PRESC+1) x tI2CCLK
     SDADEL >= {tf +tHD;DAT(min) - tAF(min) - tDNF - [3 x tI2CCLK]} / {tPRESC}
     SDADEL <= {tVD;DAT(max) - tr - tAF(max) - tDNF- [4 x tI2CCLK]} / {tPRESC} */

  tsdadel_min = (int32_t)I2C_Charac[I2C_Speed].tfall + (int32_t)I2C_Charac[I2C_Speed].hddat_min -
    (int32_t)I2C_ANALOG_FILTER_DELAY_MIN - (int32_t)(((int32_t)I2C_Charac[I2C_Speed].dnf + 3) * (int32_t)ti2cclk);

  tsdadel_max = (int32_t)I2C_Charac[I2C_Speed].vddat_max - (int32_t)I2C_Charac[I2C_Speed].trise -
    (int32_t)I2C_ANALOG_FILTER_DELAY_MAX - (int32_t)(((int32_t)I2C_Charac[I2C_Speed].dnf + 4) * (int32_t)ti2cclk);


  /* {[tr+ tSU;DAT(min)] / [tPRESC]} - 1 <= SCLDEL */
  tscldel_min = (int32_t)I2C_Charac[I2C_Speed].trise + (int32_t)I2C_Charac[I2C_Speed].sudat_min;

  if (tsdadel_min <= 0)
  {
    tsdadel_min = 0;
  }

  if (tsdadel_max <= 0)
  {
    tsdadel_max = 0;
  }

  for (presc = 0; presc < I2C_PRESC_MAX; presc++)
  {
    for (scldel = 0; scldel < I2C_SCLDEL_MAX; scldel++)
    {
      /* TSCLDEL = (SCLDEL+1) * (PRESC+1) * TI2CCLK */
      uint32_t tscldel = (scldel + 1U) * (presc + 1U) * ti2cclk;

      if (tscldel >= (uint32_t)tscldel_min)
      {
        for (sdadel = 0; sdadel < I2C_SDADEL_MAX; sdadel++)
        {
          /* TSDADEL = SDADEL * (PRESC+1) * TI2CCLK */
          uint32_t tsdadel = (sdadel * (presc + 1U)) * ti2cclk;

          if ((tsdadel >= (uint32_t)tsdadel_min) && (tsdadel <= (uint32_t)tsdadel_max))
          {
            if(presc != prev_presc)
            {
              valid_timing[valid_timing_nbr].presc = presc;
              valid_timing[valid_timing_nbr].tscldel = scldel;
              valid_timing[valid_timing_nbr].tsdadel = sdadel;
              prev_presc = presc;
              valid_timing_nbr ++;

              if(valid_timing_nbr >= I2C_VALID_TIMING_NBR)
              {
                return;
              }
            }
          }
        }
      }
    }
  }
}

/**
  * @brief  Calculate SCLL and SCLH and find best configuration.
  * @param  clock_src_freq : I2C source clock in HZ.
  * @param  I2C_Speed : I2C frequency (index).
  * @retval config index (0 to I2C_VALID_TIMING_NBR], 0xFFFFFFFF : no valid config
  */
static uint32_t Compute_SCLL_SCLH (uint32_t clock_src_freq, uint32_t I2C_speed)
{
  uint32_t ret = 0xFFFFFFFFU;
  uint32_t ti2cclk;
  uint32_t ti2cspeed;
  uint32_t prev_error;
  uint32_t dnf_delay;
  uint32_t clk_min, clk_max;
  uint32_t scll, sclh;

  ti2cclk   = (SEC2NSEC + (clock_src_freq / 2U))/ clock_src_freq;
  ti2cspeed   = (SEC2NSEC + (I2C_Charac[I2C_speed].freq / 2U))/ I2C_Charac[I2C_speed].freq;

  /* tDNF = DNF x tI2CCLK */
  dnf_delay = I2C_Charac[I2C_speed].dnf * ti2cclk;

  clk_max = SEC2NSEC / I2C_Charac[I2C_speed].freq_min;
  clk_min = SEC2NSEC / I2C_Charac[I2C_speed].freq_max;

  prev_error = ti2cspeed;

  for (uint32_t count = 0; count < valid_timing_nbr; count++)
  {
    /* tPRESC = (PRESC+1) x tI2CCLK*/
    uint32_t tpresc = (valid_timing[count].presc + 1U) * ti2cclk;

    for (scll = 0; scll < I2C_SCLL_MAX; scll++)
    {
      /* tLOW(min) <= tAF(min) + tDNF + 2 x tI2CCLK + [(SCLL+1) x tPRESC ] */
      uint32_t tscl_l = I2C_ANALOG_FILTER_DELAY_MIN + dnf_delay + (2U * ti2cclk) + (scll + 1U) * tpresc;


      /* The I2CCLK period tI2CCLK must respect the following conditions:
      tI2CCLK < (tLOW - tfilters) / 4 and tI2CCLK < tHIGH */
      if ((tscl_l > I2C_Charac[I2C_speed].lscl_min) && (ti2cclk < ((tscl_l - I2C_ANALOG_FILTER_DELAY_MIN - dnf_delay) / 4U)))
      {
        for (sclh = 0; sclh < I2C_SCLH_MAX; sclh++)
        {
          /* tHIGH(min) <= tAF(min) + tDNF + 2 x tI2CCLK + [(SCLH+1) x tPRESC] */
          uint32_t tscl_h = I2C_ANALOG_FILTER_DELAY_MIN + dnf_delay + (2U * ti2cclk) + (sclh + 1U) * tpresc;

          /* tSCL = tf + tLOW + tr + tHIGH */
          uint32_t tscl = tscl_l + tscl_h + I2C_Charac[I2C_speed].trise + I2C_Charac[I2C_speed].tfall;

          if ((tscl >= clk_min) && (tscl <= clk_max) && (tscl_h >= I2C_Charac[I2C_speed].hscl_min) && (ti2cclk < tscl_h))
          {
            int32_t error = (int32_t)tscl - (int32_t)ti2cspeed;

            if (error < 0)
            {
              error = -error;
            }

            /* look for the timings with the lowest clock error */
            if ((uint32_t)error < prev_error)
            {
              prev_error = (uint32_t)error;
              valid_timing[count].scll = scll;
              valid_timing[count].sclh = sclh;
              ret = count;
            }
          }
        }
      }
    }
  }

  return ret;
}
#endif
[/#if]
[/#if]

[#if SPIisTrue]
#if (USE_CUBEMX_BSP_V2 == 1)
/**
  * @brief  Convert the SPI baudrate into prescaler.
  * @param  clock_src_hz : SPI source clock in HZ.
  * @param  baudrate_mbps : SPI baud rate in mbps.
  * @retval Prescaler divisor
  */
static uint32_t SPI_GetPrescaler( uint32_t clock_src_hz, uint32_t baudrate_mbps )
{
  uint32_t divisor = 0;
  uint32_t spi_clk = clock_src_hz;
  uint32_t presc = 0;

  static const uint32_t baudrate[]=
  {
    SPI_BAUDRATEPRESCALER_2,
    SPI_BAUDRATEPRESCALER_4,
    SPI_BAUDRATEPRESCALER_8,
    SPI_BAUDRATEPRESCALER_16,
    SPI_BAUDRATEPRESCALER_32,
    SPI_BAUDRATEPRESCALER_64,
    SPI_BAUDRATEPRESCALER_128,
    SPI_BAUDRATEPRESCALER_256,
  };

  while( spi_clk > baudrate_mbps)
  {
    presc = baudrate[divisor];
    if (++divisor > 7)
      break;

    spi_clk= ( spi_clk >> 1);
  }

  return presc;
}
#endif
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

