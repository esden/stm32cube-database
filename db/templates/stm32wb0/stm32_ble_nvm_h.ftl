[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    nvm.h
  * @author  GPM WBL Application Team
  * @brief   Header file of NVM module.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef NVM_H
#define NVM_H


typedef enum
{
  NVM_STATUS_OK    =  0,
  NVM_STATUS_FULL  = -1,
  NVM_STATUS_BUSY  = -2,
  NVM_STATUS_EOF   = -3
} NVM_StatusTypeDef;


/* Enumerated values used for the 'type' of NVM functions: */

typedef enum
{
  NVM_TYPE_SEC        =  0,
  NVM_TYPE_GATT       =  1,
  NVM_TYPE_DEVICE_ID  =  2,
} NVM_RecordTypeDef;


/* Enumerated values used for the 'mode' of NVM functions: */

typedef enum
{
  NVM_RECORD_FIRST    =  0,
  NVM_RECORD_NEXT     =  1,
  NVM_RECORD_CURRENT  =  2,
  NVM_RECORD_ALL      =  3
} NVM_ModeTypeDef;

#endif /* NVM_H */
