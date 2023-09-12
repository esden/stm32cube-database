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

[#assign IpName = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2C = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]

[#assign USART = ""]
[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]


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
[#-- extern SPI_HandleTypeDef h${SpiIpInstance?lower_case};						--]
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
[#-- extern I2C_HandleTypeDef h${I2CIpInstance?lower_case};	--]										
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
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case};	--]										
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
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case};	--]										
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
[#-- extern UART_HandleTypeDef h${UsartIpInstance?lower_case};	--]										
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
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]
					[#assign SPIisTrue = true]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
[#--__weak HAL_StatusTypeDef MX_${SpiIpInstance}_Init(SPI_HandleTypeDef* hspi);--]
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${SpiIpInstance}_Init(SPI_HandleTypeDef* hspi);
					[/#if]
				[#break]
				[#case "I2C"]
					[#assign I2CisTrue = true]
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
				[#case "USART"]
					[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_Init(UART_HandleTypeDef* huart);								
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_Init(UART_HandleTypeDef* huart);
					[/#if]
				[#break] 
				[#case "UART"]
					[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_Init(UART_HandleTypeDef* huart);								
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_Init(UART_HandleTypeDef* huart);
					[/#if]
				[#break] 
				[#case "LPUART"]
					[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_Init(UART_HandleTypeDef* huart);								
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T MX_PPPx_Init prototype updated after reveiw with Maher --]
__weak HAL_StatusTypeDef MX_${UsartIpInstance}_Init(UART_HandleTypeDef* huart);
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
  
[#if I2CisTrue]
[#if FamilyName?starts_with("STM32L4")]
#define DIV_ROUND_CLOSEST(x, d)  (((x) + ((d) / 2)) / (d))

#define I2C_ANALOG_FILTER_ENABLE	1
#define I2C_ANALOG_FILTER_DELAY_MIN	50	/* ns */
#define I2C_ANALOG_FILTER_DELAY_MAX	260	/* ns */
#define I2C_ANALOG_FILTER_DELAY_DEFAULT	2	/* ns */

#define VALID_PRESC_NBR     100
#define PRESC_MAX			16
#define SCLDEL_MAX			16
#define SDADEL_MAX			16
#define SCLH_MAX			256
#define SCLL_MAX			256
#define I2C_DNF_MAX			16

#define NSEC_PER_SEC	                1000000000L

/**
 * struct i2c_charac - private i2c specification timing
 * @rate: I2C bus speed (Hz)
 * @rate_min: 80% of I2C bus speed (Hz)
 * @rate_max: 100% of I2C bus speed (Hz)
 * @fall_max: Max fall time of both SDA and SCL signals (ns)
 * @rise_max: Max rise time of both SDA and SCL signals (ns)
 * @hddat_min: Min data hold time (ns)
 * @vddat_max: Max data valid time (ns)
 * @sudat_min: Min data setup time (ns)
 * @l_min: Min low period of the SCL clock (ns)
 * @h_min: Min high period of the SCL clock (ns)
 */
struct i2c_specs {
	uint32_t rate;
	uint32_t rate_min;
	uint32_t rate_max;
	uint32_t fall_max;
	uint32_t rise_max;
	uint32_t hddat_min;
	uint32_t vddat_max;
	uint32_t sudat_min;
	uint32_t l_min;
	uint32_t h_min;
};

enum i2c_speed {
	I2C_SPEED_STANDARD, /* 100 kHz */
	I2C_SPEED_FAST, /* 400 kHz */
	I2C_SPEED_FAST_PLUS, /* 1 MHz */
};

/**
 * struct i2c_setup - private I2C timing setup parameters
 * @rise_time: Rise time (ns)
 * @fall_time: Fall time (ns)
 * @dnf: Digital filter coefficient (0-16)
 * @analog_filter: Analog filter delay (On/Off)
 */
struct i2c_setup {
	uint32_t rise_time;
	uint32_t fall_time;
	uint8_t dnf;
	uint8_t analog_filter;
};


/**
 * struct i2c_timings - private I2C output parameters
 * @node: List entry
 * @presc: Prescaler value
 * @scldel: Data setup time
 * @sdadel: Data hold time
 * @sclh: SCL high period (master mode)
 * @scll: SCL low period (master mode)
 */
struct i2c_timings {
	uint8_t presc;
	uint8_t scldel;
	uint8_t sdadel;
	uint8_t sclh;
	uint8_t scll;
};

const struct i2c_specs i2c_specs[] = {
	[I2C_SPEED_STANDARD] = {
		.rate = 100000,
		.rate_min = 100000,
		.rate_max = 120000,
		.fall_max = 300,
		.rise_max = 1000,
		.hddat_min = 0,
		.vddat_max = 3450,
		.sudat_min = 250,
		.l_min = 4700,
		.h_min = 4000,
	},
	[I2C_SPEED_FAST] = {
		.rate = 400000,
		.rate_min = 320000,
		.rate_max = 400000,
		.fall_max = 300,
		.rise_max = 300,
		.hddat_min = 0,
		.vddat_max = 900,
		.sudat_min = 100,
		.l_min = 1300,
		.h_min = 600,
	},
	[I2C_SPEED_FAST_PLUS] = {
		.rate = 1000000,
		.rate_min = 800000,
		.rate_max = 1000000,
		.fall_max = 120,
		.rise_max = 120,
		.hddat_min = 0,
		.vddat_max = 450,
		.sudat_min = 50,
		.l_min = 500,
		.h_min = 260,
	},
};

const struct i2c_setup i2c_user_setup[] = {
  [I2C_SPEED_STANDARD] = {
	.rise_time = 400,
	.fall_time = 100,
	.dnf = I2C_ANALOG_FILTER_DELAY_DEFAULT,
	.analog_filter = 1,
 },
 [I2C_SPEED_FAST] = {
	.rise_time = 250,
	.fall_time = 100,
	.dnf = I2C_ANALOG_FILTER_DELAY_DEFAULT,
	.analog_filter = 1,
 },
 [I2C_SPEED_FAST_PLUS] = { 
	.rise_time = 60,
	.fall_time = 100,
	.dnf = I2C_ANALOG_FILTER_DELAY_DEFAULT,
	.analog_filter = 1,
 }
};
[/#if]  
[/#if]

/** @defgroup ${BoardName?upper_case}_Private_Variables BUS Private Variables
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
SPI_HandleTypeDef h${SpiIpInstance?lower_case};						
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
SPI_HandleTypeDef h${SpiIpInstance?lower_case};
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
I2C_HandleTypeDef h${I2CIpInstance?lower_case};											
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
I2C_HandleTypeDef h${I2CIpInstance?lower_case};
					[/#if]
				[#break]  
				[#case "USART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]	
						[#assign UsartIpInstanceList = bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
					[/#if]
				[#break] 
				[#case "UART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]	
						[#assign UsartIpInstanceList = bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
					[/#if]
				[#break]	
				[#case "LPUART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]	
						[#assign UsartIpInstanceList = bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- extern : A.T removed after reveiw with Maher --]
UART_HandleTypeDef h${UsartIpInstance?lower_case};
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
				[#case "UART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;										
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */				
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;											
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
					[/#if]
				[#break] 
				[#case "USART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;										
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */				
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;											
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
					[/#if]
				[#break] 				
				[#case "LPUART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;										
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */				
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
static uint32_t Is${UsartIpInstance}MspCbValid = 0;											
#endif /* USE_HAL_UART_REGISTER_CALLBACKS */
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


/** @defgroup ${BoardName?upper_case}_Private_FunctionPrototypes  Private Function Prototypes
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
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
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
#endif
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
static void ${I2CIpInstance}_MspInit(I2C_HandleTypeDef* hI2c); 
static void ${I2CIpInstance}_MspDeInit(I2C_HandleTypeDef* hI2c);
[#if FamilyName?starts_with("STM32L4")]
#if (USE_CUBEMX_BSP_V2 == 1)
static uint32_t I2C_GetTiming(uint32_t clock_src_hz, uint32_t i2cfreq_hz);
#endif
[/#if]
					[/#if]
					[#break]
					[#case "UART"]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
static void ${UsartIpInstance}_MspInit(I2C_HandleTypeDef* huart); 
static void ${UsartIpInstance}_MspDeInit(I2C_HandleTypeDef* huart);
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
				[#case "USART"]
					[#if UsartIpInstanceList == ""]
/* BUS IO driver over USART Peripheral */
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]
					[/#if]
				[#break]  
				[#case "UART"]
					[#if UsartIpInstanceList == ""]
/* BUS IO driver over UART Peripheral */
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]
					[/#if]
				[#break]  
				[#case "LPUART"]
					[#if UsartIpInstanceList == ""]
/* BUS IO driver over UART Peripheral */
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]
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
[#macro generateBspI2C_Driver IpInstance]
/*******************************************************************************
                            BUS OPERATIONS OVER I2C
*******************************************************************************/
/**
  * @brief  Initialize a bus
  * @param None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void) 
{

  int32_t ret = BSP_ERROR_NONE;
  
  h${IpInstance?lower_case}.Instance  = ${IpInstance?upper_case};

  if (HAL_I2C_GetState(&h${IpInstance?lower_case}) == HAL_I2C_STATE_RESET)
  {  
    #if (USE_HAL_I2C_REGISTER_CALLBACKS == 0)
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

    /* Init the I2C */
    if(MX_${IpInstance}_Init(&h${IpInstance?lower_case}) != HAL_OK)
    {
      ret = BSP_ERROR_BUS_FAILURE;
    }
	[#if FamilyName.contains("STM32L1") || FamilyName.contains("STM32F1") || FamilyName.contains("STM32F2")]
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

  return ret;
}


/**
  * @brief  DeInitialize a bus
  * @param None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void) 
{
  int32_t ret = BSP_ERROR_NONE;
  
  #if (USE_HAL_I2C_REGISTER_CALLBACKS == 0)
    /* DeInit the I2C */ 
    ${IpInstance?upper_case}_MspDeInit(&h${IpInstance?lower_case});
  #endif  
  /* DeInit the I2C */ 
  if (HAL_I2C_DeInit(&h${IpInstance?lower_case}) != HAL_OK) 
  {
    ret = BSP_ERROR_BUS_FAILURE;
  }
  
  return ret;
}

/**
  * @brief Return the status of the Bus
  *	@retval bool
  */
int32_t BSP_${IpInstance}_IsReady(uint16_t DevAddr, uint32_t Trials) 
{
  int32_t ret;
  if (HAL_I2C_IsDeviceReady(&h${IpInstance?lower_case}, DevAddr, Trials, BUS_I2C1_POLL_TIMEOUT) != HAL_OK)
  {
    ret = BSP_ERROR_BUSY;
  } 
  else
  { 
    ret = BSP_ERROR_NONE; 
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
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  uint32_t hal_error = HAL_OK;
  
  if (HAL_I2C_Mem_Write(&h${IpInstance?lower_case}, (uint8_t)DevAddr,
                       (uint16_t)Reg, I2C_MEMADD_SIZE_8BIT,
                       (uint8_t *)pData, Length, BUS_I2C1_POLL_TIMEOUT) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  else
  {
    hal_error = HAL_I2C_GetError(&h${IpInstance?lower_case});
    if( hal_error == HAL_I2C_ERROR_AF)
    {
      return BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
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
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  uint32_t hal_error = HAL_OK;
  
  if (HAL_I2C_Mem_Read(&h${IpInstance?lower_case}, DevAddr, (uint16_t)Reg,
                       I2C_MEMADD_SIZE_8BIT, pData,
                       Length, 0x1000) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  else
  {
    hal_error = HAL_I2C_GetError(&h${IpInstance?lower_case});
    if( hal_error == HAL_I2C_ERROR_AF)
    {
      return BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
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
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  uint32_t hal_error = HAL_OK;
  
  if (HAL_I2C_Mem_Write(&h${IpInstance?lower_case}, (uint8_t)DevAddr,
                       (uint16_t)Reg, I2C_MEMADD_SIZE_16BIT,
                       (uint8_t *)pData, Length, 0x1000) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  else
  {
    hal_error = HAL_I2C_GetError(&h${IpInstance?lower_case});
    if ( hal_error == HAL_I2C_ERROR_AF)
    {
      return BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
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
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  uint32_t hal_error = HAL_OK;
 
  if (HAL_I2C_Mem_Read(&h${IpInstance?lower_case}, DevAddr, (uint16_t)Reg,
                       I2C_MEMADD_SIZE_16BIT, pData,
                       Length, 0x1000) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  else
  {
    hal_error = HAL_I2C_GetError(&h${IpInstance?lower_case});
    if( hal_error == HAL_I2C_ERROR_AF)
    {
      return BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
  }
  return ret;
}

[#--
/**
  * @brief  Send an amount width data through bus (Simplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pData: Data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t Length) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;	
  uint32_t hal_error = HAL_OK;
  
  if (HAL_I2C_Master_Transmit(&h${IpInstance?lower_case}, 
                              DevAddr, 
                              pData, 
                              Length, 
                              BUS_I2C1_POLL_TIMEOUT) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  else
  {
    hal_error = HAL_I2C_GetError(&h${IpInstance?lower_case});
    if( hal_error == HAL_I2C_ERROR_AF)
    {
      return BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
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
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  uint32_t hal_error = HAL_OK;
  
  if (HAL_I2C_Master_Receive(&h${IpInstance?lower_case}, 
                              DevAddr, 
                              pData, 
                              Length, 
                              BUS_I2C1_POLL_TIMEOUT) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  else
  {
    hal_error = HAL_I2C_GetError(&h${IpInstance?lower_case});
    if( hal_error == HAL_I2C_ERROR_AF)
    {
      return BSP_ERROR_BUS_ACKNOWLEDGE_FAILURE;
    }
    else
    {
      ret =  BSP_ERROR_PERIPH_FAILURE;
    }
  }
  return ret;

	return ret;
}

[!--
/**
  * @brief  Send and receive an amount of data through bus (Full duplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pTxdata: Transmit data pointer
  * @param 	pRxdata: Receive data pointer
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
[#macro generateBspSPI_Driver IpInstance]
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
  if (HAL_SPI_GetState(&h${IpInstance?lower_case}) == HAL_SPI_STATE_RESET) 
  { 
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 0)
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
    
    /* Init the SPI */
    if (MX_${IpInstance}_Init(&h${IpInstance?lower_case}) != HAL_OK)
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
int32_t BSP_${IpInstance}_DeInit(void) 
{
  int32_t ret = BSP_ERROR_BUS_FAILURE;

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 0)
  ${IpInstance?upper_case}_MspDeInit(&h${IpInstance?lower_case});
#endif  
  /* DeInit the SPI*/
  if (HAL_SPI_DeInit(&h${IpInstance?lower_case}) == HAL_OK) {
    ret = BSP_ERROR_NONE;
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
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_Transmit(&h${IpInstance?lower_case}, pData, Length, BUS_SPI1_POLL_TIMEOUT) == HAL_OK)
  {
      ret = BSP_ERROR_NONE;
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
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_Receive(&h${IpInstance?lower_case}, pData, Length, BUS_SPI1_POLL_TIMEOUT) == HAL_OK)
  {
      ret = BSP_ERROR_NONE;
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
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_TransmitReceive(&h${IpInstance?lower_case}, pTxData, pRxData, Length, BUS_SPI1_POLL_TIMEOUT) == HAL_OK)
  {
      ret = BSP_ERROR_NONE;
  }
  return ret;
}
[/#macro]
[#-- End macro generateBspSPI_Driver --]

[#-- macro generateBspUSART_Driver --]
[#macro generateBspUSART_Driver IpInstance]
/*******************************************************************************
                            BUS OPERATIONS OVER USART
*******************************************************************************/
/**
  * @brief  Initializes USART HAL. 
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(BUS_UART_InitTypeDef *Init) 
{
  int32_t ret = BSP_ERROR_NONE;
  
  h${IpInstance?lower_case}.Instance  = ${IpInstance?upper_case};
  if (HAL_UART_GetState(&h${IpInstance?lower_case}) == HAL_UART_STATE_RESET) 
  { 
#if (USE_HAL_UART_REGISTER_CALLBACKS == 0)
    /* Init the UART Msp */
    ${IpInstance?upper_case}_MspInit(&h${IpInstance?lower_case});
#else
    if(Is${UsartIpInstance}MspCbValid == 0U)
    {
      if(BSP_${IpInstance?upper_case}_RegisterDefaultMspCallbacks() != BSP_ERROR_NONE)
      {
        return BSP_ERROR_MSP_FAILURE;
      }
    }
#endif   
    
    /* Init the UART */
    if (MX_${IpInstance}_Init(&h${IpInstance?lower_case}) != HAL_OK)
    {
      ret = BSP_ERROR_BUS_FAILURE;
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

#if (USE_HAL_UART_REGISTER_CALLBACKS == 0)
  ${IpInstance?upper_case}_MspDeInit(&h${IpInstance?lower_case});
#endif  
  /* DeInit the UART*/
  if (HAL_UART_DeInit(&h${IpInstance?lower_case}) == HAL_OK) {
    ret = BSP_ERROR_NONE;
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
  
  if(HAL_UART_Transmit(&h${IpInstance?lower_case}, pData, Length, BUS_UART1_POLL_TIMEOUT) == HAL_OK)
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
  
  if(HAL_UART_Receive(&h${IpInstance?lower_case}, pData, Length, BUS_UART1_POLL_TIMEOUT) == HAL_OK)
  {
      ret = BSP_ERROR_NONE;
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
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)  
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
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)  
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
  * @param  clock_src_hz : I2C source clock in HZ.
  * @param  i2cfreq_hz : I2C frequency in Hz.
  * @retval Prescaler dividor
  */        
static uint32_t I2C_GetTiming(uint32_t clock_src_hz, uint32_t i2cfreq_hz)
{
  uint32_t ret = 0;
  uint32_t speed = 0;
  uint32_t is_valid_speed = 0; 
  uint32_t p_prev = PRESC_MAX;
  uint32_t i2cclk;
  uint32_t i2cspeed;
  uint32_t clk_error_prev;
  uint32_t tsync;
  uint32_t af_delay_min, af_delay_max;
  uint32_t dnf_delay;
  uint32_t clk_min, clk_max;
  int32_t sdadel_min, sdadel_max;
  int32_t scldel_min;
  struct i2c_timings *s = 0;
  struct i2c_timings valid_timing[VALID_PRESC_NBR];
  uint16_t p, l, a, h;
  uint32_t valid_timing_nbr = 0;  
  
  for (speed =0 ; speed<=  I2C_SPEED_FAST_PLUS ; speed++)
  {
    if ((i2cfreq_hz >= i2c_specs[speed].rate_min) &&
        (i2cfreq_hz <= i2c_specs[speed].rate_max))
    {
      is_valid_speed = 1;
      break;
    }
  }
  
  if(is_valid_speed)
  {
    i2cclk = DIV_ROUND_CLOSEST(NSEC_PER_SEC, clock_src_hz);
    i2cspeed = DIV_ROUND_CLOSEST(NSEC_PER_SEC, i2cfreq_hz);
    clk_error_prev = i2cspeed;
    
    /*  Analog and Digital Filters */
    af_delay_min =(i2c_user_setup[speed].analog_filter ? I2C_ANALOG_FILTER_DELAY_MIN : 0);
    af_delay_max =(i2c_user_setup[speed].analog_filter ? I2C_ANALOG_FILTER_DELAY_MAX : 0);
    
    dnf_delay = i2c_user_setup[speed].dnf * i2cclk;
    
    sdadel_min = i2c_user_setup[speed].fall_time - i2c_specs[speed].hddat_min -
      af_delay_min - (i2c_user_setup[speed].dnf + 3) * i2cclk;
    
    sdadel_max = i2c_specs[speed].vddat_max - i2c_user_setup[speed].rise_time -
      af_delay_max - (i2c_user_setup[speed].dnf + 4) * i2cclk;
    
    scldel_min = i2c_user_setup[speed].rise_time + i2c_specs[speed].sudat_min;
    
    if (sdadel_min < 0)
      sdadel_min = 0;
    if (sdadel_max < 0)
      sdadel_max = 0;
    
    /* Compute possible values for PRESC, SCLDEL and SDADEL */
    for (p = 0; p < PRESC_MAX; p++) {
      for (l = 0; l < SCLDEL_MAX; l++) {
        uint32_t scldel = (l + 1) * (p + 1) * i2cclk;
        
        if (scldel < scldel_min)
          continue;
        
        for (a = 0; a < SDADEL_MAX; a++) {
          uint32_t sdadel = (a * (p + 1) + 1) * i2cclk;
          
          if (((sdadel >= sdadel_min) &&
               (sdadel <= sdadel_max))&&
              (p != p_prev)) {
                valid_timing[valid_timing_nbr].presc = p;
                valid_timing[valid_timing_nbr].scldel = l;
                valid_timing[valid_timing_nbr].sdadel = a;
                p_prev = p;
                valid_timing_nbr ++;
                
                if(valid_timing_nbr >= VALID_PRESC_NBR)
                {
                  /* max valid timing buffer is full, use only these values*/
                  goto  Compute_scll_sclh;
                }
              }
        }
      }
    }
    
    if (!valid_timing_nbr) {
      return 0;
    }
	
Compute_scll_sclh:    
    tsync = af_delay_min + dnf_delay + (2 * i2cclk);
    s = NULL;
    clk_max = NSEC_PER_SEC / i2c_specs[speed].rate_min;
    clk_min = NSEC_PER_SEC / i2c_specs[speed].rate_max;
    
    /*
    * Among Prescaler possibilities discovered above figures out SCL Low
    * and High Period. Provided:
    * - SCL Low Period has to be higher than Low Period of tehs SCL Clock
    *   defined by I2C Specification. I2C Clock has to be lower than
    *   (SCL Low Period - Analog/Digital filters) / 4.
    * - SCL High Period has to be lower than High Period of the SCL Clock
    *   defined by I2C Specification
    * - I2C Clock has to be lower than SCL High Period
    */
    for (int32_t count = 0; count < valid_timing_nbr; count++) {          
      uint32_t prescaler = (valid_timing[count].presc + 1) * i2cclk;
      
      for (l = 0; l < SCLL_MAX; l++) {
        uint32_t tscl_l = (l + 1) * prescaler + tsync;
        
        if ((tscl_l < i2c_specs[speed].l_min) ||
            (i2cclk >= ((tscl_l - af_delay_min - dnf_delay) / 4))) {
              continue;
            }
        
        for (h = 0; h < SCLH_MAX; h++) {
          uint32_t tscl_h = (h + 1) * prescaler + tsync;
          uint32_t tscl = tscl_l + tscl_h + i2c_user_setup[speed].rise_time + i2c_user_setup[speed].fall_time;
          
          if ((tscl >= clk_min) && (tscl <= clk_max) &&
              (tscl_h >= i2c_specs[speed].h_min) &&
                (i2cclk < tscl_h)) {
                  int clk_error = tscl - i2cspeed;
                  
                  if (clk_error < 0)
                    clk_error = -clk_error;
                  
                  /* save the solution with the lowest clock error */
                  if (clk_error < clk_error_prev) {
                    clk_error_prev = clk_error;
                    valid_timing[count].scll = l;
                    valid_timing[count].sclh = h;
                    s = &valid_timing[count];
                  }
                }
        }
      }
    }
    
    if (!s) {
      return 0;
    }
    
    ret = ((s->presc  & 0xF) << 28) |
      ((s->scldel & 0xF) << 20) |
        ((s->sdadel & 0xF) << 16) |
          ((s->sclh & 0xFF) << 8) |
            ((s->scll & 0xFF) << 0);
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
  * @retval Prescaler dividor
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
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
