[#ftl]
/**
  ******************************************************************************
  * @file    sgfx_eeprom_if.c
  * @author  MCD Application Team
  * @brief   eeprom interface to the sigfox component
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "sgfx_eeprom_if.h"
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
#include "ee.h"
[#elseif CPUCORE == "CM4"]
#include "system_mbwrapper.h"
[/#if]
#include "st_sigfox_api.h"
#include "se_nvm.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
[#if CPUCORE == "CM4"]
#define EEPROM_IF_FLASH_LOCK()
#define EEPROM_IF_FLASH_UNLOCK()
[/#if]
enum
{
  EE_BANK_0 = 0,
  EE_BANK_1 = 1
};

enum
{
  EE_CLEAN_MODE_POLLING = 0,
  EE_CLEAN_MODE_IT = 1
};

enum
{
  NO_FORMAT =         0,
  FORMAT =            1
};

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

/* Private function prototypes -----------------------------------------------*/
static void E2P_Read(e_EE_ID addr, uint32_t *data);

static void E2P_Write(e_EE_ID addr, uint32_t data);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
void E2P_Init(void)
{
  /* USER CODE BEGIN E2P_Init_1 */

  /* USER CODE END E2P_Init_1 */
  HAL_FLASH_Unlock();

  if (EE_Init(NO_FORMAT, EE_BASE_ADRESS) != EE_OK)
  {
    if (EE_Init(FORMAT, EE_BASE_ADRESS) == EE_OK)
    {
      E2P_RestoreFs();
    }
    else
    {
      Error_Handler();
    }
  }
  HAL_FLASH_Lock();
  /* USER CODE BEGIN E2P_Init_2 */

  /* USER CODE END E2P_Init_2 */
}
[/#if]

void E2P_RestoreFs(void)
{
  /* USER CODE BEGIN E2P_RestoreFs_1 */

  /* USER CODE END E2P_RestoreFs_1 */
  uint32_t rc3a_config[] = RC3A_CONFIG;
  uint32_t rc3c_config[] = RC3C_CONFIG;
  uint32_t rc5_config[] = RC5_CONFIG;
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_RSSI_CAL_ID, 0);
  E2P_Write(EE_AT_ECHO_ID, 1);   /* AtEcho  =  Set */
  E2P_Write(EE_TX_POWER_RC1_ID, 13);
  E2P_Write(EE_TX_POWER_RC2_ID, 22);
  E2P_Write(EE_TX_POWER_RC3A_ID, 13);
  E2P_Write(EE_TX_POWER_RC3C_ID, 13);
  E2P_Write(EE_TX_POWER_RC4_ID, 22);
  E2P_Write(EE_TX_POWER_RC5_ID, 12);
  E2P_Write(EE_TX_POWER_RC6_ID, 13);
  E2P_Write(EE_TX_POWER_RC7_ID, 13);
  E2P_Write(EE_SGFX_RC_ID, SFX_RC1);    /* Default RC at device birth*/
  E2P_Write(EE_SGFX_KEYTYPE_ID, CREDENTIALS_KEY_PRIVATE);
  E2P_Write(EE_MACROCH_CONFIG_WORD0_RC2_ID, RC2_SET_STD_CONFIG_SM_WORD_0);
  E2P_Write(EE_MACROCH_CONFIG_WORD1_RC2_ID, RC2_SET_STD_CONFIG_SM_WORD_1);
  E2P_Write(EE_MACROCH_CONFIG_WORD2_RC2_ID, RC2_SET_STD_CONFIG_SM_WORD_2);
  E2P_Write(EE_MACROCH_CONFIG_WORD0_RC3A_ID, rc3a_config[0]);
  E2P_Write(EE_MACROCH_CONFIG_WORD1_RC3A_ID, rc3a_config[1]);
  E2P_Write(EE_MACROCH_CONFIG_WORD2_RC3A_ID, rc3a_config[2]);
  E2P_Write(EE_MACROCH_CONFIG_WORD0_RC3C_ID, rc3c_config[0]);
  E2P_Write(EE_MACROCH_CONFIG_WORD1_RC3C_ID, rc3c_config[1]);
  E2P_Write(EE_MACROCH_CONFIG_WORD2_RC3C_ID, rc3c_config[2]);
  E2P_Write(EE_MACROCH_CONFIG_WORD0_RC4_ID, RC4_SET_STD_CONFIG_SM_WORD_0);
  E2P_Write(EE_MACROCH_CONFIG_WORD1_RC4_ID, RC4_SET_STD_CONFIG_SM_WORD_1);
  E2P_Write(EE_MACROCH_CONFIG_WORD2_RC4_ID, RC4_SET_STD_CONFIG_SM_WORD_2);
  E2P_Write(EE_MACROCH_CONFIG_WORD0_RC5_ID, rc5_config[0]);
  E2P_Write(EE_MACROCH_CONFIG_WORD1_RC5_ID, rc5_config[1]);
  E2P_Write(EE_MACROCH_CONFIG_WORD2_RC5_ID, rc5_config[2]);
  E2P_Write(EE_SE_NVM_0_ID, 0xFF);
  E2P_Write(EE_SE_NVM_1_ID, 0x0F);
  E2P_Write(EE_SE_NVM_2_ID, 0);
  E2P_Write(EE_SE_NVM_3_ID, 0);
  E2P_Write(EE_SE_NVM_4_ID, 0xFF);
  E2P_Write(EE_MCU_NVM_0_ID, 0);
  E2P_Write(EE_MCU_NVM_1_ID, 0);
  E2P_Write(EE_MCU_NVM_2_ID, 0);
  E2P_Write(EE_MCU_NVM_3_ID, 0);
  E2P_Write(EE_SGFX_ENCRYPTIONFLAG_ID, 0);
  E2P_Write(EE_SGFX_VERBOSELEVEL_ID, 0);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_RestoreFs_2 */

  /* USER CODE END E2P_RestoreFs_2 */
}

int8_t E2P_Read_Power(sfx_rc_enum_t SgfxRc)
{
  /* USER CODE BEGIN E2P_Read_Power_1 */

  /* USER CODE END E2P_Read_Power_1 */
  uint32_t power ;
  switch (SgfxRc)
  {
    case SFX_RC1:
      E2P_Read(EE_TX_POWER_RC1_ID, &power);
      break;
    case SFX_RC2:
      E2P_Read(EE_TX_POWER_RC2_ID, &power);
      break;
    case SFX_RC3A:
      E2P_Read(EE_TX_POWER_RC3A_ID, &power);
      break;
    case SFX_RC3C:
      E2P_Read(EE_TX_POWER_RC3C_ID, &power);
      break;
    case SFX_RC4:
      E2P_Read(EE_TX_POWER_RC4_ID, &power);
      break;
    case SFX_RC5:
      E2P_Read(EE_TX_POWER_RC5_ID, &power);
      break;
    case SFX_RC6:
      E2P_Read(EE_TX_POWER_RC6_ID, &power);
      break;
    case SFX_RC7:
      E2P_Read(EE_TX_POWER_RC7_ID, &power);
      break;
    default:
      break;
  }
  return (int8_t) power;
  /* USER CODE BEGIN E2P_Read_Power_2 */

  /* USER CODE END E2P_Read_Power_2 */
}

void E2P_Write_Power(sfx_rc_enum_t SgfxRc, int8_t power)
{
  /* USER CODE BEGIN E2P_Write_Power_1 */

  /* USER CODE END E2P_Write_Power_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  switch (SgfxRc)
  {
    case SFX_RC1:
      E2P_Write(EE_TX_POWER_RC1_ID, (uint32_t) power);
      break;
    case SFX_RC2:
      E2P_Write(EE_TX_POWER_RC2_ID, (uint32_t) power);
      break;
    case SFX_RC3A:
      E2P_Write(EE_TX_POWER_RC3A_ID, (uint32_t) power);
      break;
    case SFX_RC3C:
      E2P_Write(EE_TX_POWER_RC3C_ID, (uint32_t) power);
      break;
    case SFX_RC4:
      E2P_Write(EE_TX_POWER_RC4_ID, (uint32_t) power);
      break;
    case SFX_RC5:
      E2P_Write(EE_TX_POWER_RC5_ID, (uint32_t) power);
      break;
    case SFX_RC6:
      E2P_Write(EE_TX_POWER_RC6_ID, (uint32_t) power);
      break;
    case SFX_RC7:
      E2P_Write(EE_TX_POWER_RC7_ID, (uint32_t) power);
      break;
    default:
      break;
  }

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_Power_2 */

  /* USER CODE END E2P_Write_Power_2 */
}

sfx_rc_enum_t E2P_Read_Rc(void)
{
  /* USER CODE BEGIN E2P_Read_Rc_1 */

  /* USER CODE END E2P_Read_Rc_1 */
  uint32_t SgfxRc ;
  E2P_Read(EE_SGFX_RC_ID, &SgfxRc);
  return (sfx_rc_enum_t) SgfxRc;
  /* USER CODE BEGIN E2P_Read_Rc_2 */

  /* USER CODE END E2P_Read_Rc_2 */
}

void E2P_Write_Rc(sfx_rc_enum_t SgfxRc)
{
  /* USER CODE BEGIN E2P_Write_Rc_1 */

  /* USER CODE END E2P_Write_Rc_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_SGFX_RC_ID, (uint32_t) SgfxRc);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_Rc_2 */

  /* USER CODE END E2P_Write_Rc_2 */
}

int16_t E2P_Read_RssiCal(void)
{
  /* USER CODE BEGIN E2P_Read_RssiCal_1 */

  /* USER CODE END E2P_Read_RssiCal_1 */
  uint32_t rssi_cal ;
  E2P_Read(EE_RSSI_CAL_ID, &rssi_cal);
  return (int16_t) rssi_cal;
  /* USER CODE BEGIN E2P_Read_RssiCal_2 */

  /* USER CODE END E2P_Read_RssiCal_2 */
}

void E2P_Write_RssiCal(int16_t rssi_cal)
{
  /* USER CODE BEGIN E2P_Write_RssiCal_1 */

  /* USER CODE END E2P_Write_RssiCal_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_RSSI_CAL_ID, (uint32_t) rssi_cal);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_RssiCal_2 */

  /* USER CODE END E2P_Write_RssiCal_2 */
}

uint32_t E2P_Read_AtEcho(void)
{
  /* USER CODE BEGIN E2P_Read_AtEcho_1 */

  /* USER CODE END E2P_Read_AtEcho_1 */
  uint32_t at_echo ;
  E2P_Read(EE_AT_ECHO_ID, &at_echo);
  return (E2P_flagStatus_t) at_echo;
  /* USER CODE BEGIN E2P_Read_AtEcho_2 */

  /* USER CODE END E2P_Read_AtEcho_2 */
}

void E2P_Write_AtEcho(uint32_t at_echo)
{
  /* USER CODE BEGIN E2P_Write_AtEcho_1 */

  /* USER CODE END E2P_Write_AtEcho_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_AT_ECHO_ID, (uint32_t) at_echo);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_AtEcho_2 */

  /* USER CODE END E2P_Write_AtEcho_2 */
}

sfx_key_type_t E2P_Read_KeyType(void)
{
  /* USER CODE BEGIN E2P_Read_KeyType_1 */

  /* USER CODE END E2P_Read_KeyType_1 */
  uint32_t data_from_eeprom;
  E2P_Read(EE_SGFX_KEYTYPE_ID, &data_from_eeprom);
  return (sfx_key_type_t) data_from_eeprom;
  /* USER CODE BEGIN E2P_Read_KeyType_2 */

  /* USER CODE END E2P_Read_KeyType_2 */
}

void E2P_Write_KeyType(sfx_key_type_t key_type)
{
  /* USER CODE BEGIN E2P_Write_KeyType_1 */

  /* USER CODE END E2P_Write_KeyType_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_SGFX_KEYTYPE_ID, (uint32_t) key_type);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_KeyType_2 */

  /* USER CODE END E2P_Write_KeyType_2 */
}

uint8_t E2P_Read_EncryptionFlag(void)
{
  /* USER CODE BEGIN E2P_Read_EncryptionFlag_1 */

  /* USER CODE END E2P_Read_EncryptionFlag_1 */
  uint32_t data_from_eeprom;
  E2P_Read(EE_SGFX_ENCRYPTIONFLAG_ID, &data_from_eeprom);
  return (uint8_t) data_from_eeprom;
  /* USER CODE BEGIN E2P_Read_EncryptionFlag_2 */

  /* USER CODE END E2P_Read_EncryptionFlag_2 */
}

void E2P_Write_EncryptionFlag(sfx_u8 encryption_flag)
{
  /* USER CODE BEGIN E2P_Write_EncryptionFlag_1 */

  /* USER CODE END E2P_Write_EncryptionFlag_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_SGFX_ENCRYPTIONFLAG_ID, (uint32_t) encryption_flag);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_EncryptionFlag_2 */

  /* USER CODE END E2P_Write_EncryptionFlag_2 */
}

uint8_t E2P_Read_VerboseLevel(void)
{
  /* USER CODE BEGIN E2P_Read_VerboseLevel_1 */

  /* USER CODE END E2P_Read_VerboseLevel_1 */
  uint32_t data_from_eeprom;
  E2P_Read(EE_SGFX_VERBOSELEVEL_ID, &data_from_eeprom);
  return (uint8_t) data_from_eeprom;
  /* USER CODE BEGIN E2P_Read_VerboseLevel_2 */

  /* USER CODE END E2P_Read_VerboseLevel_2 */
}

void E2P_Write_VerboseLevel(uint8_t verboselevel)
{
  /* USER CODE BEGIN E2P_Write_VerboseLevel_1 */

  /* USER CODE END E2P_Write_VerboseLevel_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  E2P_Write(EE_SGFX_VERBOSELEVEL_ID, (uint32_t) verboselevel);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_VerboseLevel_1 */

  /* USER CODE END E2P_Write_VerboseLevel_1 */
}

void E2P_Read_ConfigWords(sfx_rc_enum_t sfx_rc, sfx_u32 config_words[3])
{
  /* USER CODE BEGIN E2P_Read_ConfigWords_1 */

  /* USER CODE END E2P_Read_ConfigWords_1 */
  switch (sfx_rc)
  {
    case SFX_RC1:
    {
      break;
    }
    case SFX_RC2:
    {
      E2P_Read(EE_MACROCH_CONFIG_WORD0_RC2_ID, (uint32_t *) &config_words[0]);
      E2P_Read(EE_MACROCH_CONFIG_WORD1_RC2_ID, (uint32_t *) &config_words[1]);
      E2P_Read(EE_MACROCH_CONFIG_WORD2_RC2_ID, (uint32_t *) &config_words[2]);
      break;
    }
    case SFX_RC3A:
    {
      E2P_Read(EE_MACROCH_CONFIG_WORD0_RC3A_ID, (uint32_t *) &config_words[0]);
      E2P_Read(EE_MACROCH_CONFIG_WORD1_RC3A_ID, (uint32_t *) &config_words[1]);
      E2P_Read(EE_MACROCH_CONFIG_WORD2_RC3A_ID, (uint32_t *) &config_words[2]);

      break;
    }
    case SFX_RC3C:
    {

      E2P_Read(EE_MACROCH_CONFIG_WORD0_RC3C_ID, (uint32_t *) &config_words[0]);
      E2P_Read(EE_MACROCH_CONFIG_WORD1_RC3C_ID, (uint32_t *) &config_words[1]);
      E2P_Read(EE_MACROCH_CONFIG_WORD2_RC3C_ID, (uint32_t *) &config_words[2]);

      break;
    }
    case SFX_RC4:
    {
      E2P_Read(EE_MACROCH_CONFIG_WORD0_RC4_ID, (uint32_t *) &config_words[0]);
      E2P_Read(EE_MACROCH_CONFIG_WORD1_RC4_ID, (uint32_t *) &config_words[1]);
      E2P_Read(EE_MACROCH_CONFIG_WORD2_RC4_ID, (uint32_t *) &config_words[2]);
      break;
    }
    case SFX_RC5:
    {
      E2P_Read(EE_MACROCH_CONFIG_WORD0_RC5_ID, (uint32_t *) &config_words[0]);
      E2P_Read(EE_MACROCH_CONFIG_WORD1_RC5_ID, (uint32_t *) &config_words[1]);
      E2P_Read(EE_MACROCH_CONFIG_WORD2_RC5_ID, (uint32_t *) &config_words[2]);

      break;
    }
    case SFX_RC6:
    {
      break;
    }
    case SFX_RC7:
    {
      break;
    }
    default:
      break;
  }
  /* USER CODE BEGIN E2P_Read_ConfigWords_2 */

  /* USER CODE END E2P_Read_ConfigWords_2 */
}

void E2P_Write_ConfigWords(sfx_rc_enum_t sfx_rc, sfx_u32 config_words[3])
{
  /* USER CODE BEGIN E2P_Write_ConfigWords_1 */

  /* USER CODE END E2P_Write_ConfigWords_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();
[/#if]

  switch (sfx_rc)
  {
    case SFX_RC1:
    {
      break;
    }
    case SFX_RC2:
    {
      E2P_Write(EE_MACROCH_CONFIG_WORD0_RC2_ID, config_words[0]);
      E2P_Write(EE_MACROCH_CONFIG_WORD1_RC2_ID, config_words[1]);
      E2P_Write(EE_MACROCH_CONFIG_WORD2_RC2_ID, config_words[2]);
      break;
    }
    case SFX_RC3A:
    {
      E2P_Write(EE_MACROCH_CONFIG_WORD0_RC3A_ID, config_words[0]);
      E2P_Write(EE_MACROCH_CONFIG_WORD1_RC3A_ID, config_words[1]);
      E2P_Write(EE_MACROCH_CONFIG_WORD2_RC3A_ID, config_words[2]);

      break;
    }
    case SFX_RC3C:
    {

      E2P_Write(EE_MACROCH_CONFIG_WORD0_RC3C_ID, config_words[0]);
      E2P_Write(EE_MACROCH_CONFIG_WORD1_RC3C_ID, config_words[1]);
      E2P_Write(EE_MACROCH_CONFIG_WORD2_RC3C_ID, config_words[2]);

      break;
    }
    case SFX_RC4:
    {
      E2P_Write(EE_MACROCH_CONFIG_WORD0_RC4_ID, config_words[0]);
      E2P_Write(EE_MACROCH_CONFIG_WORD1_RC4_ID, config_words[1]);
      E2P_Write(EE_MACROCH_CONFIG_WORD2_RC4_ID, config_words[2]);
      break;
    }
    case SFX_RC5:
    {
      E2P_Write(EE_MACROCH_CONFIG_WORD0_RC5_ID, config_words[0]);
      E2P_Write(EE_MACROCH_CONFIG_WORD1_RC5_ID, config_words[1]);
      E2P_Write(EE_MACROCH_CONFIG_WORD2_RC5_ID, config_words[2]);
      break;
    }
    case SFX_RC6:
    {
      break;
    }
    case SFX_RC7:
    {
      break;
    }
    default:
      break;
  }

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();
[/#if]
  /* USER CODE BEGIN E2P_Write_ConfigWords_2 */

  /* USER CODE END E2P_Write_ConfigWords_2 */
}

E2P_ErrorStatus_t E2P_Read_SeNvm(sfx_u8 *read_data, uint32_t len)
{
  /* USER CODE BEGIN E2P_Read_SeNvm_1 */

  /* USER CODE END E2P_Read_SeNvm_1 */
  E2P_ErrorStatus_t error = E2P_OK;
  int32_t i = 0;
  uint32_t data_from_eeprom;

  E2P_Read(EE_SE_NVM_0_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  E2P_Read(EE_SE_NVM_1_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  E2P_Read(EE_SE_NVM_2_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;;
  E2P_Read(EE_SE_NVM_3_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  E2P_Read(EE_SE_NVM_4_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;

  if (i != len)
  {
    error =  E2P_KO;
  }
  return error;
  /* USER CODE BEGIN E2P_Read_SeNvm_2 */

  /* USER CODE END E2P_Read_SeNvm_2 */
}

E2P_ErrorStatus_t E2P_Write_SeNvm(sfx_u8 *data_to_write,  uint32_t len)
{
  /* USER CODE BEGIN E2P_Write_SeNvm_1 */

  /* USER CODE END E2P_Write_SeNvm_1 */
  E2P_ErrorStatus_t error = E2P_OK;
  int32_t i = 0;

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();

[/#if]
  E2P_Write(EE_SE_NVM_0_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_SE_NVM_1_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_SE_NVM_2_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_SE_NVM_3_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_SE_NVM_4_ID, (uint32_t) data_to_write[i++]);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();

[/#if]
  if (i != len)
  {
    error =  E2P_KO;
  }
  return error;
  /* USER CODE BEGIN E2P_Write_SeNvm_2 */

  /* USER CODE END E2P_Write_SeNvm_2 */
}

E2P_ErrorStatus_t E2P_Read_McuNvm(sfx_u8 *read_data, uint32_t len)
{
  /* USER CODE BEGIN E2P_Read_McuNvm_1 */

  /* USER CODE END E2P_Read_McuNvm_1 */
  E2P_ErrorStatus_t error = E2P_OK;
  int32_t i = 0;
  uint32_t data_from_eeprom;
  E2P_Read(EE_MCU_NVM_0_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  E2P_Read(EE_MCU_NVM_1_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  E2P_Read(EE_MCU_NVM_2_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  E2P_Read(EE_MCU_NVM_3_ID, &data_from_eeprom);
  read_data[i++] = (sfx_u8) data_from_eeprom;
  if (i != len)
  {
    error =  E2P_KO;
  }
  return error;
  /* USER CODE BEGIN E2P_Read_McuNvm_2 */

  /* USER CODE END E2P_Read_McuNvm_2 */
}

E2P_ErrorStatus_t E2P_Write_McuNvm(sfx_u8 *data_to_write, uint32_t len)
{
  /* USER CODE BEGIN E2P_Write_McuNvm_1 */

  /* USER CODE END E2P_Write_McuNvm_1 */
  E2P_ErrorStatus_t error = E2P_OK;
  int32_t i = 0;

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Unlock();

[/#if]
  E2P_Write(EE_MCU_NVM_0_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_MCU_NVM_1_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_MCU_NVM_2_ID, (uint32_t) data_to_write[i++]);
  E2P_Write(EE_MCU_NVM_3_ID, (uint32_t) data_to_write[i++]);

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  HAL_FLASH_Lock();

[/#if]
  if (i != len)
  {
    error =  E2P_KO;
  }
  return error;
  /* USER CODE BEGIN E2P_Write_McuNvm_2 */

  /* USER CODE END E2P_Write_McuNvm_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
static void E2P_Write(e_EE_ID addr, uint32_t data)
{
  /* USER CODE BEGIN E2P_Write_1 */

  /* USER CODE END E2P_Write_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  if (EE_Write(EE_BANK_0, (uint16_t) addr, data) == EE_CLEAN_NEEDED)
  {
    EE_Clean(EE_BANK_0, EE_CLEAN_MODE_POLLING);
  }
[#elseif CPUCORE == "CM4"]
  SYS_EE_WriteBuffer_mbwrapper(addr, data);
[/#if]
  /* USER CODE BEGIN E2P_Write_2 */

  /* USER CODE END E2P_Write_2 */
}

static void E2P_Read(e_EE_ID addr, uint32_t *data)
{
  /* USER CODE BEGIN E2P_Read_1 */

  /* USER CODE END E2P_Read_1 */
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  EE_Read(EE_BANK_0, (uint16_t) addr, data);
[#elseif CPUCORE == "CM4"]
  SYS_EE_ReadBuffer_mbwrapper(addr, data);
[/#if]
  /* USER CODE BEGIN E2P_Read_2 */

  /* USER CODE END E2P_Read_2 */
}

[#if (CPUCORE == "CM0PLUS")]
/*!
* \brief   Returns the last stored variable data, if found, which corresponds to
*          the passed virtual address
* \param   EEsgfxID:
*          data: to be read
* \retval  error status
*/
int32_t EE_ReadValue(e_EE_ID EEsgfxID,  uint32_t *data)
{
  /* USER CODE BEGIN EE_ReadValue_1 */

  /* USER CODE END EE_ReadValue_1 */
  int32_t  status;

  /* Prevent CM4 to read EEPROM private part of CM0 */
  if (EEsgfxID < MAX_CPU2_PRIVATE)
  {
    return ERROR_READ_WRITE_EEPROM;
  }
  else
  {
    status = EE_Read(EE_BANK_0, (uint16_t)EEsgfxID, data);
  }
  return status;
  /* USER CODE BEGIN EE_ReadValue_2 */

  /* USER CODE END EE_ReadValue_2 */
}

/*!
* \brief   Writes/updates variable data in EEPROM emulator.
* \param   EEsgfxID:
*          data: to be written
* \retval error status
*/
int32_t EE_WriteValue(e_EE_ID EEsgfxID,  uint32_t data)
{
  /* USER CODE BEGIN EE_WriteValue_1 */

  /* USER CODE END EE_WriteValue_1 */
  int32_t status;

  /* Prevent CM4 to write EEPROM private part of CM0 */
  if (EEsgfxID < MAX_CPU2_PRIVATE)
  {
    return ERROR_READ_WRITE_EEPROM;
  }
  else
  {
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
    HAL_FLASH_Unlock();
[/#if]

    status = EE_Write(EE_BANK_0, EEsgfxID, data);
    if (status  == EE_CLEAN_NEEDED)
    {
      EE_Clean(EE_BANK_0, EE_CLEAN_MODE_POLLING);
    }

[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
    HAL_FLASH_Lock();
[/#if]
  }

  return status;
  /* USER CODE BEGIN EE_WriteValue_2 */

  /* USER CODE END EE_WriteValue_2 */
}

[/#if]
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
