[#ftl]
/* USER CODE BEGIN Header */
/**
  ***************************************************************************************
  * @file    stm32_lpm_if.c
  * @author  MCD Application Team
  * @brief   Low layer function to enter/exit low power modes (stop, sleep).
  ***************************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */


/* Includes ------------------------------------------------------------------*/
[#if HALCompliant??]
#include "main.h"
[#else]
#include "gpio.h"
#include "rng.h"
[/#if]
#include "scm.h"
#include "stm32_lpm_if.h"
#include "stm32_lpm.h"
#include "stm32wbaxx_hal_pwr.h"
#include "stm32wba52xx.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* External variables -----------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
const struct UTIL_LPM_Driver_s UTIL_PowerDriver = 
{
  PWR_EnterSleepMode,
  PWR_ExitSleepMode,
  
  PWR_EnterStopMode,
  PWR_ExitStopMode, 
  
  PWR_EnterOffMode,
  PWR_ExitOffMode,
};

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* Variable to store the MainStackPointer before entering standby wfi */
uint32_t backup_MSP;
static uint32_t boot_after_standby;

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

void PWR_EnterOffMode( void )
{
  /* USER CODE BEGIN PWR_EnterOffMode_1 */

  /* USER CODE END PWR_EnterOffMode_1 */
  
  /*
   * There is no risk to clear all the WUF here because in the current implementation, this API is called
   * in critical section. If an interrupt occurs while in that critical section before that point,
   * the flag is set and will be cleared here but the system will not enter Off Mode
   * because an interrupt is pending in the NVIC. The ISR will be executed when moving out
   * of this critical section
   */

  scm_setwaitstates(LP);

  /* Set low power mode to standby */
  LL_PWR_SetPowerMode( LL_PWR_MODE_STANDBY );

  /* Set SLEEPDEEP bit of Cortex System Control Register */
  LL_LPM_EnableDeepSleep( );
  
  /* This option is used to ensure that store operations are completed */
  #if defined ( __CC_ARM)
    __force_stores( );
  #endif
  /* Wait for VOS to be ready */
  while(LL_PWR_IsActiveFlag_ACTVOS( ) == 0);

  /* Save all Cortex regiters on stack and call WFI instruction */
  CPUcontextSave();
  
  /* USER CODE BEGIN PWR_EnterOffMode_2 */

  /* USER CODE END PWR_EnterOffMode_2 */
}

void PWR_ExitOffMode( void )
{
  /* USER CODE BEGIN PWR_ExitOffMode_1 */

  /* USER CODE END PWR_ExitOffMode_1 */
  
  if( 1UL == boot_after_standby )
  {
    boot_after_standby = 0;

    /* Enable WKUP IRQ handler and radio */
    HAL_NVIC_SetPriority(WKUP_IRQn, 0x07, 0);
    HAL_NVIC_EnableIRQ(WKUP_IRQn);
    HAL_NVIC_SetPriority(RADIO_INTR_NUM, RADIO_INTR_PRIO_HIGH, 0);
    HAL_NVIC_EnableIRQ(RADIO_INTR_NUM);
    HAL_NVIC_SetPriority(RADIO_SW_LOW_INTR_NUM, RADIO_SW_LOW_INTR_PRIO, 0);
    HAL_NVIC_EnableIRQ(RADIO_SW_LOW_INTR_NUM);
    HAL_NVIC_SetPriority(RTC_IRQn, 0x07, 0);
    HAL_NVIC_EnableIRQ(RTC_IRQn);

    /*
     ***********************************
     * Restore SoC HW configuration
     ***********************************
     */
    MX_GPIO_Init();

    /* Output Sysclock on MCO1 pin (PA8) */
    HAL_RCC_MCOConfig(RCC_MCO1, RCC_MCO1SOURCE_SYSCLK, RCC_MCODIV_16);
    HAL_PWREx_EnableStandbyIORetention(PWR_GPIO_A, GPIO_PIN_8);

    /* RNG */
    MX_RNG_Init();

    /* Restore ICACHE */
    HAL_ICACHE_Enable();

    /* Restore clock and HSE 32MHz */
    scm_setup();

    /* Only RTC MSPInit is required since not retained in registers*/
    //HAL_RTC_MspInit( &hrtc );
  }
  else
  {
    if (LL_PWR_IsActiveFlag_STOP() == 1U)
    {
      scm_setup();
    }
    else
    {
      scm_setwaitstates( RUN );
    }
  }
  
  /* USER CODE BEGIN PWR_ExitOffMode_2 */

  /* USER CODE END PWR_ExitOffMode_2 */
}

void PWR_EnterStopMode( void )
{
  /* USER CODE BEGIN PWR_EnterStopMode_1 */

  /* USER CODE END PWR_EnterStopMode_1 */
  
  scm_setwaitstates(LP);

  LL_PWR_SetPowerMode(LL_PWR_MODE_STOP1);
  LL_LPM_EnableDeepSleep();

  while(LL_PWR_IsActiveFlag_ACTVOS( ) == 0);
  
  __WFI( );
  
  /* USER CODE BEGIN PWR_EnterStopMode_2 */

  /* USER CODE END PWR_EnterStopMode_2 */
}

void PWR_ExitStopMode( void )
{
  /* USER CODE BEGIN PWR_ExitStopMode_1 */
  
  /* USER CODE END PWR_ExitStopMode_1 */
  
  if (LL_PWR_IsActiveFlag_STOP() != 0U)
  {
    scm_setup();
  }
  else
  {
    scm_setwaitstates(RUN);
  }

  /* USER CODE BEGIN PWR_ExitStopMode_2 */
  
  /* USER CODE END PWR_ExitStopMode_2 */
}

void PWR_EnterSleepMode( void )
{
  /* USER CODE BEGIN PWR_EnterSleepMode_1 */

  /* USER CODE END PWR_EnterSleepMode_1 */
  
  LL_LPM_EnableSleep();
  __WFI();
  
  /* USER CODE BEGIN PWR_EnterSleepMode_2 */

  /* USER CODE END PWR_EnterSleepMode_2 */
}

void PWR_ExitSleepMode( void )
{
  /* USER CODE BEGIN PWR_ExitSleepMode */

  /* USER CODE END PWR_ExitSleepMode */
}

static uint32_t standby_cnt = 0; // Debug only
uint32_t is_boot_from_standby(void)
{
  __HAL_RCC_PWR_CLK_ENABLE();

  standby_cnt++;
  
  /* Ensure this is a return from Standby, and not a reset */
  if( (LL_PWR_IsActiveFlag_SB() == 1UL ) &&
      (READ_REG(RCC->CSR) == 0U)
    )
  {
    /* When exit from standby, disable IRQ so that restore and PWR_ExitOffMode are in critical section */
    __disable_irq( );

    boot_after_standby = 1;
  }
  else
  {
    boot_after_standby = 0;
  }
  
  return boot_after_standby;
}

void gpio_enter_stdby(void)
{
  //HAL_GPIO_WritePin(DBG_GPIO_PORT, DBG_GPIO_PIN_bis, GPIO_PIN_RESET);
}

void gpio_exit_stdby(void)
{
  //HAL_GPIO_WritePin(DBG_GPIO_PORT, DBG_GPIO_PIN_bis, GPIO_PIN_SET);
}

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

