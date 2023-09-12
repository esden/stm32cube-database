[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : Hardware configuration file for STM32WPAN Middleware.
 ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign LPUART1baudrate = ""]
[#assign LPUART1wordlength = ""]
[#assign LPUART1stopbits = ""]
[#assign LPUART1parity = ""]
[#assign LPUART1hwflowctl = ""]
[#assign LPUART1mode = ""]
[#assign LPUART1advfeatureinit = ""]

[#assign CFG_HW_LPUART1_ENABLED = ""]
[#assign CFG_HW_LPUART1_DMA_TX_SUPPORTED = ""]

[#assign LPUART1_TX_PIN = ""]
[#assign LPUART1_TX_GPIO_PORT = ""]
[#assign LPUART1_TX_GPIO_PIN = ""]
[#assign LPUART1_TX_SELECT_AF = ""]
[#assign LPUART1_RX_PIN = ""]
[#assign LPUART1_RX_GPIO_PORT = ""]
[#assign LPUART1_RX_GPIO_PIN = ""]
[#assign LPUART1_RX_SELECT_AF = ""]
[#assign LPUART1_CTS_PIN = ""]
[#assign LPUART1_CTS_GPIO_PORT = ""]
[#assign LPUART1_CTS_GPIO_PIN = ""]
[#assign LPUART1_CTS_SELECT_AF = ""]

[#assign LPUART1_TX_DMA_CHANNEL = ""]
[#assign LPUART1_TX_DMA_REQUEST = ""]
[#assign LPUART1_TX_DMA = ""]
[#assign LPUART1_TX_DMA_LL_CHANNEL = ""]

[#assign USART1baudrate = ""]
[#assign USART1wordlength = ""]
[#assign USART1stopbits = ""]
[#assign USART1parity = ""]
[#assign USART1hwflowctl = ""]
[#assign USART1mode = ""]
[#assign USART1advfeatureinit = ""]
[#assign USART1oversampling = ""]

[#assign CFG_HW_USART1_ENABLED = ""]
[#assign CFG_HW_USART1_DMA_TX_SUPPORTED = ""]

[#assign USART1_TX_PIN = ""]
[#assign USART1_TX_GPIO_PORT = ""]
[#assign USART1_TX_GPIO_PIN = ""]
[#assign USART1_TX_SELECT_AF = ""]
[#assign USART1_RX_PIN = ""]
[#assign USART1_RX_GPIO_PORT = ""]
[#assign USART1_RX_GPIO_PIN = ""]
[#assign USART1_RX_SELECT_AF = ""]
[#assign USART1_CTS_PIN = ""]
[#assign USART1_CTS_GPIO_PORT = ""]
[#assign USART1_CTS_GPIO_PIN = ""]
[#assign USART1_CTS_SELECT_AF = ""]

[#assign USART1_TX_DMA_CHANNEL = ""]
[#assign USART1_TX_DMA_REQUEST = ""]
[#assign USART1_TX_DMA = ""]
[#assign USART1_TX_DMA_LL_CHANNEL = ""]

[#assign FREERTOS_STATUS = 0]
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "LPUART1baudrate"]
                [#assign LPUART1baudrate = definition.value]
            [/#if]
            [#if definition.name == "LPUART1wordlength"]
                [#assign LPUART1wordlength = definition.value]
            [/#if]
            [#if definition.name == "LPUART1stopbits"]
                [#assign LPUART1stopbits = definition.value]
            [/#if]
            [#if definition.name == "LPUART1parity"]
                [#assign LPUART1parity = definition.value]
            [/#if]
            [#if definition.name == "LPUART1hwflowctl"]
                [#assign LPUART1hwflowctl = definition.value]
            [/#if]
            [#if definition.name == "LPUART1mode"]
                [#assign LPUART1mode = definition.value]
            [/#if]
            [#if definition.name == "LPUART1advfeatureinit"]
                [#assign LPUART1advfeatureinit = definition.value]
            [/#if]

            [#if definition.name="CFG_HW_LPUART1_ENABLED"]
                [#assign CFG_HW_LPUART1_ENABLED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_LPUART1_DMA_TX_SUPPORTED"]
                [#assign CFG_HW_LPUART1_DMA_TX_SUPPORTED = definition.value]
            [/#if]

            [#if definition.name == "LPUART1_TX_PIN"]
                [#assign LPUART1_TX_PIN = definition.value]
                [#if LPUART1_TX_PIN != "" && LPUART1_TX_PIN != "valueNotSetted"]
                    [#assign LPUART1_TX_PIN_elems = LPUART1_TX_PIN.split("_")]
                    [#assign LPUART1_TX_GPIO_PORT = LPUART1_TX_PIN_elems[1]]
                    [#assign LPUART1_TX_GPIO_PIN = LPUART1_TX_PIN_elems[2]]
                    [#assign LPUART1_TX_SELECT_AF = LPUART1_TX_PIN_elems[4]]
                [#else]
                    [#assign LPUART1_TX_GPIO_PORT = "valueNotSetted"]
                    [#assign LPUART1_TX_GPIO_PIN = "valueNotSetted"]
                    [#assign LPUART1_TX_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "LPUART1_RX_PIN"]
                [#assign LPUART1_RX_PIN = definition.value]
                [#if LPUART1_RX_PIN != "" && LPUART1_RX_PIN != "valueNotSetted"]
                    [#assign LPUART1_RX_PIN_elems = LPUART1_RX_PIN.split("_")]
                    [#assign LPUART1_RX_GPIO_PORT = LPUART1_RX_PIN_elems[1]]
                    [#assign LPUART1_RX_GPIO_PIN = LPUART1_RX_PIN_elems[2]]
                    [#assign LPUART1_RX_SELECT_AF = LPUART1_RX_PIN_elems[4]]
                [#else]
                    [#assign LPUART1_RX_GPIO_PORT = "valueNotSetted"]
                    [#assign LPUART1_RX_GPIO_PIN = "valueNotSetted"]
                    [#assign LPUART1_RX_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "LPUART1_CTS_PIN"]
                [#assign LPUART1_CTS_PIN = definition.value]
                [#if LPUART1_CTS_PIN != "" && LPUART1_CTS_PIN != "valueNotSetted"]
                    [#assign LPUART1_CTS_PIN_elems = LPUART1_CTS_PIN.split("_")]
                    [#assign LPUART1_CTS_GPIO_PORT = LPUART1_CTS_PIN_elems[1]]
                    [#assign LPUART1_CTS_GPIO_PIN = LPUART1_CTS_PIN_elems[2]]
                    [#assign LPUART1_CTS_SELECT_AF = LPUART1_CTS_PIN_elems[4]]
                [#else]
                    [#assign LPUART1_CTS_GPIO_PORT = "valueNotSetted"]
                    [#assign LPUART1_CTS_GPIO_PIN = "valueNotSetted"]
                    [#assign LPUART1_CTS_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]

            [#if definition.name == "LPUART1_TX_DMA_CHANNEL"]
                [#assign LPUART1_TX_DMA_CHANNEL = definition.value]
                [#if LPUART1_TX_DMA_CHANNEL != "" && LPUART1_TX_DMA_CHANNEL != "valueNotSetted"]
                    [#assign LPUART1_TX_DMA_CHANNEL_elems = LPUART1_TX_DMA_CHANNEL.split("_")]
                    [#assign LPUART1_TX_DMA_REQUEST = LPUART1_TX_DMA_CHANNEL_elems[0] + "_" + LPUART1_TX_DMA_CHANNEL_elems[1]]
                    [#assign LPUART1_TX_DMA = LPUART1_TX_DMA_CHANNEL_elems[2]]
                    [#assign LPUART1_TX_DMA_LL_CHANNEL = LPUART1_TX_DMA_CHANNEL_elems[3] + LPUART1_TX_DMA_CHANNEL_elems[4]]
                [#else]
                    [#assign LPUART1_TX_DMA_REQUEST = "valueNotSetted"]
                    [#assign LPUART1_TX_DMA = "valueNotSetted"]
                    [#assign LPUART1_TX_DMA_LL_CHANNEL = "valueNotSetted"]
                [/#if]
            [/#if]

            [#if definition.name == "USART1baudrate"]
                [#assign USART1baudrate = definition.value]
            [/#if]
            [#if definition.name == "USART1wordlength"]
                [#assign USART1wordlength = definition.value]
            [/#if]
            [#if definition.name == "USART1stopbits"]
                [#assign USART1stopbits = definition.value]
            [/#if]
            [#if definition.name == "USART1parity"]
                [#assign USART1parity = definition.value]
            [/#if]
            [#if definition.name == "USART1hwflowctl"]
                [#assign USART1hwflowctl = definition.value]
            [/#if]
            [#if definition.name == "USART1mode"]
                [#assign USART1mode = definition.value]
            [/#if]
            [#if definition.name == "USART1advfeatureinit"]
                [#assign USART1advfeatureinit = definition.value]
            [/#if]
            [#if definition.name == "USART1oversampling"]
                [#assign USART1oversampling = definition.value]
            [/#if]

            [#if definition.name="CFG_HW_USART1_ENABLED"]
                [#assign CFG_HW_USART1_ENABLED = definition.value]
            [/#if]
            [#if definition.name="CFG_HW_USART1_DMA_TX_SUPPORTED"]
                [#assign CFG_HW_USART1_DMA_TX_SUPPORTED = definition.value]
            [/#if]

            [#if definition.name == "USART1_TX_PIN"]
                [#assign USART1_TX_PIN = definition.value]
                [#if USART1_TX_PIN != "" && USART1_TX_PIN != "valueNotSetted"]
                    [#assign USART1_TX_PIN_elems = USART1_TX_PIN.split("_")]
                    [#assign USART1_TX_GPIO_PORT = USART1_TX_PIN_elems[1]]
                    [#assign USART1_TX_GPIO_PIN = USART1_TX_PIN_elems[2]]
                    [#assign USART1_TX_SELECT_AF = USART1_TX_PIN_elems[4]]
                [#else]
                    [#assign USART1_TX_GPIO_PORT = "valueNotSetted"]
                    [#assign USART1_TX_GPIO_PIN = "valueNotSetted"]
                    [#assign USART1_TX_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "USART1_RX_PIN"]
                [#assign USART1_RX_PIN = definition.value]
                [#if USART1_RX_PIN != "" && USART1_RX_PIN != "valueNotSetted"]
                    [#assign USART1_RX_PIN_elems = USART1_RX_PIN.split("_")]
                    [#assign USART1_RX_GPIO_PORT = USART1_RX_PIN_elems[1]]
                    [#assign USART1_RX_GPIO_PIN = USART1_RX_PIN_elems[2]]
                    [#assign USART1_RX_SELECT_AF = USART1_RX_PIN_elems[4]]
                [#else]
                    [#assign USART1_RX_GPIO_PORT = "valueNotSetted"]
                    [#assign USART1_RX_GPIO_PIN = "valueNotSetted"]
                    [#assign USART1_RX_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if definition.name == "USART1_CTS_PIN"]
                [#assign USART1_CTS_PIN = definition.value]
                [#if USART1_CTS_PIN != "" && USART1_CTS_PIN != "valueNotSetted"]
                    [#assign USART1_CTS_PIN_elems = USART1_CTS_PIN.split("_")]
                    [#assign USART1_CTS_GPIO_PORT = USART1_CTS_PIN_elems[1]]
                    [#assign USART1_CTS_GPIO_PIN = USART1_CTS_PIN_elems[2]]
                    [#assign USART1_CTS_SELECT_AF = USART1_CTS_PIN_elems[4]]
                [#else]
                    [#assign USART1_CTS_GPIO_PORT = "valueNotSetted"]
                    [#assign USART1_CTS_GPIO_PIN = "valueNotSetted"]
                    [#assign USART1_CTS_SELECT_AF = "valueNotSetted"]
                [/#if]
            [/#if]

            [#if definition.name == "USART1_TX_DMA_CHANNEL"]
                [#assign USART1_TX_DMA_CHANNEL = definition.value]
                [#if USART1_TX_DMA_CHANNEL != "" && USART1_TX_DMA_CHANNEL != "valueNotSetted"]
                    [#assign USART1_TX_DMA_CHANNEL_elems = USART1_TX_DMA_CHANNEL.split("_")]
                    [#assign USART1_TX_DMA_REQUEST = USART1_TX_DMA_CHANNEL_elems[0] + "_" + USART1_TX_DMA_CHANNEL_elems[1]]
                    [#assign USART1_TX_DMA = USART1_TX_DMA_CHANNEL_elems[2]]
                    [#assign USART1_TX_DMA_LL_CHANNEL = USART1_TX_DMA_CHANNEL_elems[3] + USART1_TX_DMA_CHANNEL_elems[4]]
                [#else]
                    [#assign USART1_TX_DMA_REQUEST = "valueNotSetted"]
                    [#assign USART1_TX_DMA = "valueNotSetted"]
                    [#assign USART1_TX_DMA_LL_CHANNEL = "valueNotSetted"]
                [/#if]
            [/#if]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef HW_CONF_H
#define HW_CONF_H

[#if (FREERTOS_STATUS = 1)]
#include "FreeRTOSConfig.h"

[/#if]
/******************************************************************************
 * Semaphores
 * THIS SHALL NO BE CHANGED AS THESE SEMAPHORES ARE USED AS WELL ON THE CM0+
 *****************************************************************************/
/**
*  Index of the semaphore used by CPU2 to prevent the CPU1 to either write or erase data in flash
*  The CPU1 shall not either write or erase in flash when this semaphore is taken by the CPU2
*  When the CPU1 needs to either write or erase in flash, it shall first get the semaphore and release it just
*  after writing a raw (64bits data) or erasing one sector.
*  Once the Semaphore has been released, there shall be at least 1us before it can be taken again. This is required
*  to give the opportunity to CPU2 to take it.
*  On v1.4.0 and older CPU2 wireless firmware, this semaphore is unused and CPU2 is using PES bit.
*  By default, CPU2 is using the PES bit to protect its timing. The CPU1 may request the CPU2 to use the semaphore
*  instead of the PES bit by sending the system command SHCI_C2_SetFlashActivityControl()
*/
#define CFG_HW_BLOCK_FLASH_REQ_BY_CPU2_SEMID                    7

/**
*  Index of the semaphore used by CPU1 to prevent the CPU2 to either write or erase data in flash
*  In order to protect its timing, the CPU1 may get this semaphore to prevent the  CPU2 to either
*  write or erase in flash (as this will stall both CPUs)
*  The PES bit shall not be used as this may stall the CPU2 in some cases.
*/
#define CFG_HW_BLOCK_FLASH_REQ_BY_CPU1_SEMID                    6

/**
*  Index of the semaphore used to manage the CLK48 clock configuration
*  When the USB is required, this semaphore shall be taken before configuring te CLK48 for USB
*  and should be released after the application switch OFF the clock when the USB is not used anymore
*  When using the RNG, it is good enough to use CFG_HW_RNG_SEMID to control CLK48.
*  More details in AN5289
*/
#define CFG_HW_CLK48_CONFIG_SEMID                               5

/* Index of the semaphore used to manage the entry Stop Mode procedure */
#define CFG_HW_ENTRY_STOP_MODE_SEMID                            4

/* Index of the semaphore used to access the RCC */
#define CFG_HW_RCC_SEMID                                        3

/* Index of the semaphore used to access the FLASH */
#define CFG_HW_FLASH_SEMID                                      2

/* Index of the semaphore used to access the PKA */
#define CFG_HW_PKA_SEMID                                        1

/* Index of the semaphore used to access the RNG */
#define CFG_HW_RNG_SEMID                                        0

/******************************************************************************
 * HW TIMER SERVER
 *****************************************************************************/
/**
 * The user may define the maximum number of virtual timers supported.
 * It shall not exceed 255
 */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="CFG_HW_TS_MAX_NBR_CONCURRENT_TIMER"]
				[#lt]#define ${definition.name}  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
 * The user may define the priority in the NVIC of the RTC_WKUP interrupt handler that is used to manage the
 * wakeup timer.
 * This setting is the preemptpriority part of the NVIC.
 */
[#if (FREERTOS_STATUS = 1)]
#define CFG_HW_TS_NVIC_RTC_WAKEUP_IT_PREEMPTPRIO    (configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY + 1) /* FreeRTOS requirement */
[#else]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="CFG_HW_TS_NVIC_RTC_WAKEUP_IT_PREEMPTPRIO"]
				[#lt]#define ${definition.name}  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[/#if]

/**
 * The user may define the priority in the NVIC of the RTC_WKUP interrupt handler that is used to manage the
 * wakeup timer.
 * This setting is the subpriority part of the NVIC. It does not exist on all processors. When it is not supported
 * on the CPU, the setting is ignored
 */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="CFG_HW_TS_NVIC_RTC_WAKEUP_IT_SUBPRIO"]
				[#lt]#define ${definition.name}  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
 *  Define a critical section in the Timer server
 *  The Timer server does not support the API to be nested
 *  The  Application shall either:
 *    a) Ensure this will never happen
 *    b) Define the critical section
 *  The default implementations is masking all interrupts using the PRIMASK bit
 *  The TimerServer driver uses critical sections to avoid context corruption. This is achieved with the macro
 *  TIMER_ENTER_CRITICAL_SECTION and TIMER_EXIT_CRITICAL_SECTION. When CFG_HW_TS_USE_PRIMASK_AS_CRITICAL_SECTION is set
 *  to 1, all STM32 interrupts are masked with the PRIMASK bit of the CortexM CPU. It is possible to use the BASEPRI
 *  register of the CortexM CPU to keep allowed some interrupts with high priority. In that case, the user shall
 *  re-implement TIMER_ENTER_CRITICAL_SECTION and TIMER_EXIT_CRITICAL_SECTION and shall make sure that no TimerServer
 *  API are called when the TIMER critical section is entered
 */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="CFG_HW_TS_USE_PRIMASK_AS_CRITICAL_SECTION"]
				[#lt]#define ${definition.name}  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
   * This value shall reflect the maximum delay there could be in the application between the time the RTC interrupt
   * is generated by the Hardware and the time when the  RTC interrupt handler is called. This time is measured in
   * number of RTCCLK ticks.
   * A relaxed timing would be 10ms
   * When the value is too short, the timerserver will not be able to count properly and all timeout may be random.
   * When the value is too long, the device may wake up more often than the most optimal configuration. However, the
   * impact on power consumption would be marginal (unless the value selected is extremely too long). It is strongly
   * recommended to select a value large enough to make sure it is not too short to ensure reliability of the system
   * as this will have marginal impact on low power mode
   */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="CFG_HW_TS_RTC_HANDLER_MAX_DELAY"]
				[#lt]#define ${definition.name}  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

  /**
   * Interrupt ID in the NVIC of the RTC Wakeup interrupt handler
   * It shall be type of IRQn_Type
   */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="CFG_HW_TS_RTC_WAKEUP_HANDLER_ID"]
				[#lt]#define ${definition.name}  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]


/******************************************************************************
 * HW UART
 *****************************************************************************/
[#if CFG_HW_LPUART1_ENABLED != "" ]
    [#lt]#define CFG_HW_LPUART1_ENABLED           ${CFG_HW_LPUART1_ENABLED}
[/#if]
[#if CFG_HW_LPUART1_DMA_TX_SUPPORTED != ""]
    [#lt]#define CFG_HW_LPUART1_DMA_TX_SUPPORTED  ${CFG_HW_LPUART1_DMA_TX_SUPPORTED}
[/#if]

[#if CFG_HW_USART1_ENABLED != "" ]
    [#lt]#define CFG_HW_USART1_ENABLED           ${CFG_HW_USART1_ENABLED}
[/#if]
[#if CFG_HW_USART1_DMA_TX_SUPPORTED != ""]
    [#lt]#define CFG_HW_USART1_DMA_TX_SUPPORTED  ${CFG_HW_USART1_DMA_TX_SUPPORTED}
[/#if]

[#if CFG_HW_LPUART1_ENABLED == "1"]
/**
 * LPUART1
 */
#define CFG_HW_LPUART1_PREEMPTPRIORITY         0x0F
#define CFG_HW_LPUART1_SUBPRIORITY             0

/** < The application shall check the selected source clock is enable */
#define CFG_HW_LPUART1_SOURCE_CLOCK             RCC_LPUART1CLKSOURCE_SYSCLK

#define CFG_HW_LPUART1_BAUDRATE                ${LPUART1baudrate}
#define CFG_HW_LPUART1_WORDLENGTH              ${LPUART1wordlength}
#define CFG_HW_LPUART1_STOPBITS                ${LPUART1stopbits}
#define CFG_HW_LPUART1_PARITY                  ${LPUART1parity}
#define CFG_HW_LPUART1_HWFLOWCTL               ${LPUART1hwflowctl}
#define CFG_HW_LPUART1_MODE                    ${LPUART1mode}
#define CFG_HW_LPUART1_ADVFEATUREINIT          ${LPUART1advfeatureinit}
#define CFG_HW_LPUART1_OVERSAMPLING            UART_OVERSAMPLING_8

#define CFG_HW_LPUART1_TX_PORT_CLK_ENABLE      __HAL_RCC_GPIO${LPUART1_TX_GPIO_PORT}_CLK_ENABLE
#define CFG_HW_LPUART1_TX_PORT                 GPIO${LPUART1_TX_GPIO_PORT}
#define CFG_HW_LPUART1_TX_PIN                  GPIO_PIN_${LPUART1_TX_GPIO_PIN}
#define CFG_HW_LPUART1_TX_MODE                 GPIO_MODE_AF_PP
#define CFG_HW_LPUART1_TX_PULL                 GPIO_NOPULL
#define CFG_HW_LPUART1_TX_SPEED                GPIO_SPEED_FREQ_VERY_HIGH
#define CFG_HW_LPUART1_TX_ALTERNATE            GPIO_AF${LPUART1_TX_SELECT_AF}_LPUART1

#define CFG_HW_LPUART1_RX_PORT_CLK_ENABLE      __HAL_RCC_GPIO${LPUART1_RX_GPIO_PORT}_CLK_ENABLE
#define CFG_HW_LPUART1_RX_PORT                 GPIO${LPUART1_RX_GPIO_PORT}
#define CFG_HW_LPUART1_RX_PIN                  GPIO_PIN_${LPUART1_RX_GPIO_PIN}
#define CFG_HW_LPUART1_RX_MODE                 GPIO_MODE_AF_PP
#define CFG_HW_LPUART1_RX_PULL                 GPIO_NOPULL
#define CFG_HW_LPUART1_RX_SPEED                GPIO_SPEED_FREQ_VERY_HIGH
#define CFG_HW_LPUART1_RX_ALTERNATE            GPIO_AF${LPUART1_RX_SELECT_AF}_LPUART1

[#if LPUART1_CTS_PIN != "" && LPUART1_CTS_PIN != "valueNotSetted"]
#define CFG_HW_LPUART1_CTS_PORT_CLK_ENABLE     __HAL_RCC_GPIO${LPUART1_CTS_GPIO_PORT}_CLK_ENABLE
#define CFG_HW_LPUART1_CTS_PORT                GPIO${LPUART1_CTS_GPIO_PORT}
#define CFG_HW_LPUART1_CTS_PIN                 GPIO_PIN_${LPUART1_CTS_GPIO_PIN}
#define CFG_HW_LPUART1_CTS_MODE                GPIO_MODE_AF_PP
#define CFG_HW_LPUART1_CTS_PULL                GPIO_PULLDOWN
#define CFG_HW_LPUART1_CTS_SPEED               GPIO_SPEED_FREQ_VERY_HIGH
#define CFG_HW_LPUART1_CTS_ALTERNATE           GPIO_AF${LPUART1_CTS_SELECT_AF}_LPUART1
[/#if]

[#if CFG_HW_LPUART1_DMA_TX_SUPPORTED == "1" &&  LPUART1_TX_DMA != "" && LPUART1_TX_DMA != "valueNotSetted"]
#define CFG_HW_LPUART1_DMA_TX_PREEMPTPRIORITY  0x0F
#define CFG_HW_LPUART1_DMA_TX_SUBPRIORITY      0

#define CFG_HW_LPUART1_DMAMUX_CLK_ENABLE       __HAL_RCC_DMAMUX1_CLK_ENABLE
#define CFG_HW_LPUART1_DMA_CLK_ENABLE          __HAL_RCC_${LPUART1_TX_DMA}_CLK_ENABLE
#define CFG_HW_LPUART1_TX_DMA_REQ              DMA_REQUEST_${LPUART1_TX_DMA_REQUEST}
#define CFG_HW_LPUART1_TX_DMA_CHANNEL          ${LPUART1_TX_DMA}_${LPUART1_TX_DMA_LL_CHANNEL}
#define CFG_HW_LPUART1_TX_DMA_IRQn             ${LPUART1_TX_DMA}_${LPUART1_TX_DMA_LL_CHANNEL}_IRQn
#define CFG_HW_LPUART1_DMA_TX_IRQHandler       ${LPUART1_TX_DMA}_${LPUART1_TX_DMA_LL_CHANNEL}_IRQHandler
[/#if]
[/#if]

[#if CFG_HW_USART1_ENABLED == "1"]
/**
 * UART1
 */
#define CFG_HW_USART1_PREEMPTPRIORITY         0x0F
#define CFG_HW_USART1_SUBPRIORITY             0

/** < The application shall check the selected source clock is enable */
#define CFG_HW_USART1_SOURCE_CLOCK              RCC_USART1CLKSOURCE_SYSCLK

#define CFG_HW_USART1_BAUDRATE                ${USART1baudrate}
#define CFG_HW_USART1_WORDLENGTH              UART_${USART1wordlength}
#define CFG_HW_USART1_STOPBITS                UART_${USART1stopbits}
#define CFG_HW_USART1_PARITY                  UART_${USART1parity}
#define CFG_HW_USART1_HWFLOWCTL               ${USART1hwflowctl}
#define CFG_HW_USART1_MODE                    UART_${USART1mode}
#define CFG_HW_USART1_ADVFEATUREINIT          ${USART1advfeatureinit}
#define CFG_HW_USART1_OVERSAMPLING            ${USART1oversampling}

#define CFG_HW_USART1_TX_PORT_CLK_ENABLE      __HAL_RCC_GPIO${USART1_TX_GPIO_PORT}_CLK_ENABLE
#define CFG_HW_USART1_TX_PORT                 GPIO${USART1_TX_GPIO_PORT}
#define CFG_HW_USART1_TX_PIN                  GPIO_PIN_${USART1_TX_GPIO_PIN}
#define CFG_HW_USART1_TX_MODE                 GPIO_MODE_AF_PP
#define CFG_HW_USART1_TX_PULL                 GPIO_NOPULL
#define CFG_HW_USART1_TX_SPEED                GPIO_SPEED_FREQ_VERY_HIGH
#define CFG_HW_USART1_TX_ALTERNATE            GPIO_AF${USART1_TX_SELECT_AF}_USART1

#define CFG_HW_USART1_RX_PORT_CLK_ENABLE      __HAL_RCC_GPIO${USART1_RX_GPIO_PORT}_CLK_ENABLE
#define CFG_HW_USART1_RX_PORT                 GPIO${USART1_RX_GPIO_PORT}
#define CFG_HW_USART1_RX_PIN                  GPIO_PIN_${USART1_RX_GPIO_PIN}
#define CFG_HW_USART1_RX_MODE                 GPIO_MODE_AF_PP
#define CFG_HW_USART1_RX_PULL                 GPIO_NOPULL
#define CFG_HW_USART1_RX_SPEED                GPIO_SPEED_FREQ_VERY_HIGH
#define CFG_HW_USART1_RX_ALTERNATE            GPIO_AF${USART1_RX_SELECT_AF}_USART1

[#if USART1_CTS_PIN != "" && USART1_CTS_PIN != "valueNotSetted"]
#define CFG_HW_USART1_CTS_PORT_CLK_ENABLE     __HAL_RCC_GPIO${USART1_CTS_GPIO_PORT}_CLK_ENABLE
#define CFG_HW_USART1_CTS_PORT                GPIO${USART1_CTS_GPIO_PORT}
#define CFG_HW_USART1_CTS_PIN                 GPIO_PIN_${USART1_CTS_GPIO_PIN}
#define CFG_HW_USART1_CTS_MODE                GPIO_MODE_AF_PP
#define CFG_HW_USART1_CTS_PULL                GPIO_PULLDOWN
#define CFG_HW_USART1_CTS_SPEED               GPIO_SPEED_FREQ_VERY_HIGH
#define CFG_HW_USART1_CTS_ALTERNATE           GPIO_AF${USART1_CTS_SELECT_AF}_USART1
[/#if]

[#if CFG_HW_USART1_DMA_TX_SUPPORTED == "1" &&  USART1_TX_DMA != "" && USART1_TX_DMA != "valueNotSetted"]
#define CFG_HW_USART1_DMA_TX_PREEMPTPRIORITY  0x0F
#define CFG_HW_USART1_DMA_TX_SUBPRIORITY      0

#define CFG_HW_USART1_DMAMUX_CLK_ENABLE       __HAL_RCC_DMAMUX1_CLK_ENABLE
#define CFG_HW_USART1_DMA_CLK_ENABLE          __HAL_RCC_${USART1_TX_DMA}_CLK_ENABLE
#define CFG_HW_USART1_TX_DMA_REQ			  DMA_REQUEST_${USART1_TX_DMA_REQUEST}
#define CFG_HW_USART1_TX_DMA_CHANNEL          ${USART1_TX_DMA}_${USART1_TX_DMA_LL_CHANNEL}
#define CFG_HW_USART1_TX_DMA_IRQn             ${USART1_TX_DMA}_${USART1_TX_DMA_LL_CHANNEL}_IRQn
#define CFG_HW_USART1_DMA_TX_IRQHandler       ${USART1_TX_DMA}_${USART1_TX_DMA_LL_CHANNEL}_IRQHandler
[/#if]
[/#if]


#endif /*HW_CONF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
