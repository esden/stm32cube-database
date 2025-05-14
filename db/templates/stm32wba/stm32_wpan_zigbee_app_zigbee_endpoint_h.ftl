[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : app_zigbee_endpoint.h
  * Description        : Header for Zigbee Application and it endpoint.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]
[#assign EndNbr = myHash["ZGB_NB_ENDPOINTS"]]
[#assign item = 0]
[#assign otaUpgrade = 0]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as configParameter]
          [#if EndNbr?number!=0]
            [#if configParameter.name?starts_with("ZCL_") && configParameter.value != "NONE" && !configParameter.name?contains("BASIC")]
               [#assign item = item + 1]
            [/#if]
            [#if configParameter.name?contains("ZCL_OTA") && configParameter.value != "NONE"]
               [#assign otaUpgrade = otaUpgrade + 1]
            [/#if]
          [/#if]
        [/#list]
    [/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_ZIGBEE_ENDPOINT_H
#define APP_ZIGBEE_ENDPOINT_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "zigbee.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported defines ------------------------------------------------------------*/
[#if otaUpgrade?number!=0]

/* ZCL OTA FUOTA specific defines ----------------------------------------------------*/
#define FUOTA_MAGIC_KEYWORD_M4_APP              0x94448A29u       /* Keyword found at the end of Zigbee Ota file for M4 Application Processor binary */
#define FUOTA_MAGIC_KEYWORD_M33_APP             0xBF806133u       /* Keyword found at the end of Zigbee Ota file for M33 Application Processor binary */

#define CFG_APP_START_SECTOR_INDEX              0x40u             /* Define the start address where the application shall be located */
#define FUOTA_APP_FW_BINARY_ADDRESS             ( FLASH_BASE + ( CFG_APP_START_SECTOR_INDEX * FLASH_PAGE_SIZE ) )     /* Address for Application Processor FW Update */

#define FUOTA_NUMBER_WORDS_64BITS               50u
#define FUOTA_PAYLOAD_SIZE                      ( FUOTA_NUMBER_WORDS_64BITS * 8u )


/* ZCL OTA specific defines ------------------------------------------------------*/
#define ST_ZIGBEE_MANUFACTURER_CODE             0x1041u
#define RAM_FIRMWARE_BUFFER_SIZE                1024u

#define CURRENT_M3_HARDWARE_VERSION             0x01u       /* For WB compatibility */
#define CURRENT_M4_HARDWARE_VERSION             0x02u

#define CURRENT_FW_COPRO_WIRELESS_FILE_VERSION  0x01u       /* WB Wireless Coprocessor FW Version. For WB compatibility  */
#define CURRENT_FW_M4_APP_FILE_VERSION          0x01u       /* WB M4 Application Processor FW Version. For WB compatibility  */
#define CURRENT_FW_M33_APP_FILE_VERSION         0x01u       /* WBA M33 Application Processor FW Version */

#define FILE_VERSION_FW_COPRO_WIRELESS          0x02u       /* WB Wireless Coprocessor FW version. For WB compatibility  */
#define FILE_VERSION_FW_M4_APP                  0x02u       /* WB M4 Application Processor FW version. For WB compatibility */
#define FILE_VERSION_FW_M33_APP                 0x02u       /* WBA M33 Application Processor FW version */

#define IMAGE_TYPE_FW_COPRO_WIRELESS            0x01u       /* WB Wireless Coprocessor binary. For WB compatibility  */
#define IMAGE_TYPE_FW_M4_APP                    0x02u       /* WB M4 Application Processor binary. For WB compatibility  */
#define IMAGE_TYPE_FW_M33_APP                   0x03u       /* WBA M33 Application Processor binary. */


/* Define list of reboot reason (ZCL OTA) -------------------------------------------*/
#define CFG_REBOOT_ON_DOWNLOADED_FW             0x00u       /* Reboot on the downloaded Firmware */
#define CFG_REBOOT_ON_OTA_FW                    0x01u       /* Reboot on OTA FW */
#define CFG_REBOOT_ON_CPU2_UPGRADE              0x02u       /* Reboot on OTA FW to download CPU2. For WB Compatibility */

[/#if]
[#if item?number > 6]
#define CLUSTER_NB_MAX                          ${item}u          /* Maximum number of Clusters in this application */
[#else]
#define CLUSTER_NB_MAX                          6u          /* Maximum number of Clusters in this application */
[/#if]

/* USER CODE BEGIN ED */

/* USER CODE END ED */ 

/* Exported types ------------------------------------------------------------*/  
[#if otaUpgrade?number!=0]
/* OTA Structure Definition ------------------------------------------------------*/
enum APP_ZIGBEE_OtaFileTypeDef_t
{
  fileType_COPRO_WIRELESS   = IMAGE_TYPE_FW_COPRO_WIRELESS,   /* For WB Compatibility */
  fileType_M4_APP           = IMAGE_TYPE_FW_M4_APP,           /* For WB Compatibility */
  fileType_M33_APP          = IMAGE_TYPE_FW_M33_APP,
};


struct APP_ZIGBEE_OtaContext_t
{
  enum APP_ZIGBEE_OtaFileTypeDef_t  eFileType;
  uint8_t   cFileVersion;
  uint32_t  lBinarySize;
  uint32_t  lBinaryCrc;
  uint32_t  lBaseAddress;
  uint32_t  lMagicKeyword;
};

[/#if]
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants ------------------------------------------------------- */
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables ------------------------------------------------------- */
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes -------------------------------- */
extern void       APP_ZIGBEE_ApplicationInit              ( void );
extern void       APP_ZIGBEE_ApplicationStart             ( void );
extern void       APP_ZIGBEE_PersistenceStartup           ( void );
extern void       APP_ZIGBEE_ConfigEndpoints              ( void );
extern bool       APP_ZIGBEE_ConfigGroupAddr              ( void );

extern void       APP_ZIGBEE_GetStartupConfig             ( struct ZbStartupT * pstConfig );
extern void       APP_ZIGBEE_SetNewDevice                 ( uint16_t iShortAddress, uint64_t dlExtendedAddress, uint8_t cCapability );

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* APP_ZIGBEE_ENDPOINT_H */
