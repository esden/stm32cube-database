[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_sigfox.c
  * @author  GPM WBL Application Team
  * @brief   Application of the Sigfox Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if ("${definition.value}"=="valueNotSetted")]
              [#assign myHash = {definition.name:0} + myHash]
            [#else]
              [#assign myHash = {definition.name:definition.value} + myHash]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#assign IpInstance = ""]
[#assign IpName = ""]
[#assign CTX_PORT = ""]
[#assign CTX_PIN  = ""]
[#assign CPS_PORT = ""]
[#assign CPS_PIN  = ""]
[#assign CSD_PORT = ""]
[#assign CSD_PIN  = ""]
[#assign useCTX  = false]
[#assign useCPS  = false]
[#assign useCSD  = false]
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32_lpm.h"
#include "app_sigfox.h"
[#if (myHash["ST_SFX_FEM_MODULE"] == "ST_SFX_FEM_CUSTOM")]
#include "stm32wl3x_ll_gpio.h"
[/#if]

/* USER CODE BEGIN Includes */
#include <string.h>
/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */
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
            [#if variables.value?contains("CTX")]
                    [#assign CTX_PORT = IpName]
                    [#assign CTX_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("CPS")]
                    [#assign CPS_PORT = IpName]
                    [#assign CPS_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("CSD")]
                    [#assign CSD_PORT = IpName]
                    [#assign CSD_PIN  = IpInstance]
            [/#if]
	    [/#list]
    [/#if]
	[#if SWIP.bsp??]
      [#list SWIP.bsp as bsp]
	        [#if bsp.bspName?contains("CTX")]
                 [#assign useCTX = true]
            [/#if]
            [#if bsp.bspName?contains("CPS")]
                 [#assign useCPS = true]
            [/#if]
            [#if bsp.bspName?contains("CSD")]
                 [#assign useCSD = true]
            [/#if]
		[/#list]
	  [/#if]
[/#list]
[/#if]
/* Private function prototypes -----------------------------------------------*/
static void Fatal_Error(void);
static void SystemApp_Init(void);
static void Sigfox_Init(void);
PowerSaveLevels App_PowerSaveLevel_Check(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
void MX_Sigfox_Init(void)
{
  /* USER CODE BEGIN MX_Sigfox_Init_1 */

  /* USER CODE END MX_Sigfox_Init_1 */
  SystemApp_Init();
  /* USER CODE BEGIN MX_Sigfox_Init_1_1 */

  /* USER CODE END MX_Sigfox_Init_1_1 */
  Sigfox_Init();
  /* USER CODE BEGIN MX_Sigfox_Init_2 */

  /* USER CODE END MX_Sigfox_Init_2 */
}

void MX_Sigfox_Process(void)
{
  /* USER CODE BEGIN MX_Sigfox_Process_1 */
#if (CFG_LPM_SUPPORTED == 1)
  PowerSaveLevels app_powerSave_level, vtimer_powerSave_level, final_level;

  app_powerSave_level = App_PowerSaveLevel_Check();

  if(app_powerSave_level != POWER_SAVE_LEVEL_DISABLED)
  {
    vtimer_powerSave_level = HAL_MRSUBG_TIMER_PowerSaveLevelCheck();
    final_level = (PowerSaveLevels)MIN(vtimer_powerSave_level, app_powerSave_level);

    switch(final_level)
    {
    case POWER_SAVE_LEVEL_DISABLED:
      /* Not Power Save device is busy */
      return;
      break;
    case POWER_SAVE_LEVEL_SLEEP:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      break;
    case POWER_SAVE_LEVEL_DEEPSTOP_TIMER:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      break;
    case POWER_SAVE_LEVEL_DEEPSTOP_NOTIMER:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      break;
    }

    UTIL_LPM_EnterLowPower();
  }
#endif /* CFG_LPM_SUPPORTED */
  
  /* USER CODE END MX_Sigfox_Process_1 */

  /* USER CODE BEGIN MX_Sigfox_Process_2 */

  /* USER CODE END MX_Sigfox_Process_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/**
 * @brief  Application fatal error.
 * @param  None
 * @retval None
 */
static void Fatal_Error(void)
{
  /* USER CODE BEGIN Fatal_Error_1 */
  
  /* USER CODE END Fatal_Error_1 */

  while (1) {
  /* USER CODE BEGIN Fatal_Error_2 */
  
  /* USER CODE END Fatal_Error_2 */
  }
}

static void SystemApp_Init(void)
{
  /* USER CODE BEGIN SystemApp_Init_1 */
  
  /* USER CODE END SystemApp_Init_1 */

  if (__HAL_RCC_MRSUBG_IS_CLK_DISABLED())
  {
    /* Radio Peripheral reset */
    __HAL_RCC_MRSUBG_FORCE_RESET();
    __HAL_RCC_MRSUBG_RELEASE_RESET();

    /* Enable Radio peripheral clock */
    __HAL_RCC_MRSUBG_CLK_ENABLE();
  }

  /* USER CODE BEGIN SystemApp_Init_2 */

  /* USER CODE END SystemApp_Init_2 */
}

static void Sigfox_Init(void)
{
  /* USER CODE BEGIN Sigfox_Init_1 */

  /* USER CODE END Sigfox_Init_1 */
[#if (myHash["ST_SFX_FEM_MODULE"] == "ST_SFX_FEM_NONE")]
  const ST_SFX_FEMConfiguration fem_configuration = { .model = ${myHash["ST_SFX_FEM_MODULE"]} };
[#else]
  const ST_SFX_FEMConfiguration fem_configuration = {
    .model = ${myHash["ST_SFX_FEM_MODULE"]},
[#if useCTX]
	.ctx = { .port = ${CTX_PORT}, .pin = LL_${CTX_PIN}, .periph = LL_AHB1_GRP1_PERIPH_${CTX_PORT} },
[/#if]
[#if useCPS]
	.cps = { .port = ${CPS_PORT}, .pin = LL_${CPS_PIN}, .periph = LL_AHB1_GRP1_PERIPH_${CPS_PORT} },
[/#if]
[#if useCSD]
	.csd = { .port = ${CSD_PORT}, .pin = LL_${CSD_PIN}, .periph = LL_AHB1_GRP1_PERIPH_${CSD_PORT} },
[/#if]
    /* USER CODE BEGIN fem_configuration */

    /* USER CODE END fem_configuration */
    };
[/#if]

  /* STM32WL3-Specific Sigfox Low-Level Initialization */
  ST_SFX_BoardCredentials sfxCredentials;
  ST_SFX_StatusTypeDef stSfxRetErr = ST_SFX_Init(&sfxCredentials, &fem_configuration);

  if (stSfxRetErr != ST_SFX_OK) {
    /* If an error occurred reading Sigfox credentials (for example the board has never been registered)
     * automatically set the test mode. */
    if (stSfxRetErr == ST_SFX_ERR_CREDENTIALS) {
      /* USER CODE BEGIN Sigfox_Init_2 */

      /* USER CODE END Sigfox_Init_2 */
    } else
      Fatal_Error();
  }

  /* USER CODE BEGIN Sigfox_Init_3 */

  /* USER CODE END Sigfox_Init_3 */
}
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
