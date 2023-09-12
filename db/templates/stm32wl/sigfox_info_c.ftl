[#ftl]
/**
  ******************************************************************************
  * @file    sigfox_info.c
  * @author  MCD Application Team
  * @brief   To give info to the application about Sigfox configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "sigfox_info.h"
#include "features_info.h"
#include "main.h"
#include "stm32_mem.h"
#include "sigfox_types.h"
#include "sigfox_monarch_api.h"

/* USER CODE BEGIN Includes */

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
UTIL_MEM_PLACE_IN_SECTION("MB_MEM2") SigfoxInfo_t SigfoxInfoTable;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief initialises the SigfoxInfo capabilities table
  * @param none
  * @retval  none
  */
static void StoreValueInFeatureListTable(void);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
/**
  * @brief initialises the SigfoxInfo capabilities table
  * @param none
  * @retval  none
  */
void SigfoxInfo_Init(void)
{
  /* USER CODE BEGIN SigfoxInfo_Init_1 */

  /* USER CODE END SigfoxInfo_Init_1 */
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC1) ;
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC2) ;
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC3) ;
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC4) ;
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC5) ;
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC6) ;
  SigfoxInfoTable.Region |= (1 << SFX_BITFIELD_SHIFT_RC7) ;

  /* For DualCore */
  StoreValueInFeatureListTable();
  return;
  /* USER CODE BEGIN SigfoxInfo_Init_2 */

  /* USER CODE END SigfoxInfo_Init_2 */
}

/**
  * @brief returns the pointer to the SigfoxInfo capabilities table
  * @param none
  * @retval  SigfoxInfoTable pointer
  */
SigfoxInfo_t *SigfoxInfo_GetPtr(void)
{
  /* USER CODE BEGIN SigfoxInfo_GetPtr_1 */

  /* USER CODE END SigfoxInfo_GetPtr_1 */
  return &SigfoxInfoTable;
  /* USER CODE BEGIN SigfoxInfo_GetPtr_2 */

  /* USER CODE END SigfoxInfo_GetPtr_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
static void StoreValueInFeatureListTable(void)
{
  /* USER CODE BEGIN StoreValueInFeatureListTable_1 */

  /* USER CODE END StoreValueInFeatureListTable_1 */
  FEAT_INFO_List_t *p_MBMUX_Cm0plusFeatureList = NULL;
  FEAT_INFO_Param_t  *p_feature;
  uint8_t i;
  uint8_t cm0plus_nr_of_supported_features;
  uint8_t found = 0;

  p_MBMUX_Cm0plusFeatureList = FEAT_INFO_GetListPtr();

  if (p_MBMUX_Cm0plusFeatureList != NULL)
  {
    cm0plus_nr_of_supported_features = p_MBMUX_Cm0plusFeatureList->Feat_Info_Cnt;

    for (i = 0; i < cm0plus_nr_of_supported_features;  i++)
    {
      p_feature = i + p_MBMUX_Cm0plusFeatureList->Feat_Info_TableAddress;
      if (p_feature->Feat_Info_Feature_Id == FEAT_INFO_SIGFOX_ID)
      {
        found = 1;
        break;
      }
    }
  }

  if (found)
  {
    p_feature->Feat_Info_Config_Size = sizeof(SigfoxInfo_t)/sizeof(uint32_t);
    p_feature->Feat_Info_Config_Ptr = &SigfoxInfoTable;
  }
  else
  {
    Error_Handler();
  }

  return;
  /* USER CODE BEGIN StoreValueInFeatureListTable_2 */

  /* USER CODE END StoreValueInFeatureListTable_2 */
}

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
