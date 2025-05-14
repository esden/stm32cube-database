[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : zigbee_plat.h
  * Description        : Header for Zigbee platform adaptation layer.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef ZIGBEE_PLAT_H
#define ZIGBEE_PLAT_H

#ifdef __cplusplus
extern "C" {
#endif


/* Exported functions ------------------------------------------------------- */
extern void ZIGBEE_PLAT_Init                 ( void );

extern void ZIGBEE_PLAT_RngInit              ( void );
extern void ZIGBEE_PLAT_RngProcess           ( void );
extern void ZIGBEE_PLAT_RngGet               ( uint8_t cNumberOfBytes, uint8_t * pValue );

extern void ZIGBEE_PLAT_AesCrypt32           ( const uint32_t * pInput, uint32_t * pOutput );
extern void ZIGBEE_PLAT_AesCrypt             ( const uint8_t * pInput, uint8_t * pOutput );
extern void ZIGBEE_PLAT_AesEcbEncrypt        ( const uint8_t * pKey, const uint8_t * pInput, uint8_t * pOutput );
extern void ZIGBEE_PLAT_AesCmacSetKey        ( const uint8_t * pKey );
extern void ZIGBEE_PLAT_AesCmacSetVector     ( const uint8_t * pIV );
extern void ZIGBEE_PLAT_AesCmacCompute       ( const uint8_t * pInput, uint32_t lInputLength, uint8_t * pOutputTag );

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* ZIGBEE_PLAT_H */
