[#ftl]
/**
  ******************************************************************************
  * @file    usbpd_vdm_user.c
  * @author  MCD Application Team
  * @brief   USBPD provider demo file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "usbpd_core.h"
#include "usbpd_dpm_conf.h"
#include "usbpd_vdm_user.h"
#include "usbpd_dpm_user.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN Private_define */

/* USER CODE END Private_define */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN Private_typedef */

/* USER CODE END Private_typedef */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN Private_macro */

/* USER CODE END Private_macro */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN Private_prototypes */

/* USER CODE END Private_prototypes */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Private_prototypes */
const USBPD_VDM_Callbacks vdmCallbacks =
{
  USBPD_VDM_DiscoverIdentity,
  USBPD_VDM_DiscoverSVIDs,
  USBPD_VDM_DiscoverModes,
  USBPD_VDM_ModeEnter,
  USBPD_VDM_ModeExit,
  USBPD_VDM_InformIdentity,
  USBPD_VDM_InformSVID,
  USBPD_VDM_InformMode,
  USBPD_VDM_InformModeEnter,
  USBPD_VDM_InformModeExit,
  USBPD_VDM_SendAttention,
  USBPD_VDM_ReceiveAttention,
  USBPD_VDM_SendSpecific,
  USBPD_VDM_ReceiveSpecific,
  USBPD_VDM_InformSpecific,
  USBPD_VDM_SendUVDM,
  USBPD_VDM_ReceiveUVDM,
};
/* USER CODE END Private_prototypes */

/* Private functions ---------------------------------------------------------*/
/* USER CODE BEGIN Private_functions */
/**
  * @brief  VDM Discovery identity callback (answer to Discover Identity request message)
  * @param  PortNum current port number
  * @param  pIdentity Pointer on USBPD_DiscoveryIdentity_TypeDef structure
  * @retval USBPD status : USBPD_BUSY, USBPD_ACK or USBPD_NAK
  */
static USBPD_StatusTypeDef USBPD_VDM_DiscoverIdentity(uint8_t PortNum, USBPD_DiscoveryIdentity_TypeDef *pIdentity)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Discover SVID callback (retrieve SVID supported by device for answer to Discovery mode)
  * @param  PortNum        current port number
  * @param  p_SVID_Info Pointer on USBPD_SVIDInfo_TypeDef structure
  * @retval USBPD status : USBPD_BUSY, USBPD_ACK or USBPD_NAK
  */
static USBPD_StatusTypeDef USBPD_VDM_DiscoverSVIDs(uint8_t PortNum, uint16_t **p_SVID_Info, uint8_t *nb)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Discover Mode callback (report all the modes supported by SVID)
  * @param  PortNum current port number
  * @param  SVID SVID ID
  * @param  p_ModeInfo Pointer on USBPD_ModeInfo_TypeDef structure
  * @retval USBPD status : USBPD_BUSY, USBPD_ACK or USBPD_NAK
  */
static USBPD_StatusTypeDef USBPD_VDM_DiscoverModes(uint8_t PortNum, uint16_t SVID, uint32_t **p_ModeInfo, uint8_t *nbMode)
{
  return USBPD_NAK;
}
/**
  * @brief  VDM Mode enter callback
  * @param  PortNum current port number
  * @param  SVID      SVID ID
  * @param  ModeIndex Index of the mode to be entered
  * @retval USBPD status : USBPD_BUSY, USBPD_ACK or USBPD_NAK
  */
static USBPD_StatusTypeDef USBPD_VDM_ModeEnter(uint8_t PortNum, uint16_t SVID, uint32_t ModeIndex)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Mode exit callback
  * @param  PortNum current port number
  * @param  SVID      SVID ID
  * @param  ModeIndex Index of the mode to be exited
  * @retval USBPD status : USBPD_BUSY, USBPD_ACK or USBPD_NAK
  */
static USBPD_StatusTypeDef USBPD_VDM_ModeExit(uint8_t PortNum, uint16_t SVID, uint32_t ModeIndex)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Discovery identity callback (answer after sending a Discover Identity req message)
  * @param  PortNum       current port number
  * @param  SOPType       SOP type
  * @param  CommandStatus Command status based on @ref USBPD_VDM_CommandType_Typedef
  * @param  pIdentity     Pointer on the discovery identity information based on @ref USBPD_DiscoveryIdentity_TypeDef
  * @retval None
*/
static void USBPD_VDM_InformIdentity(uint8_t PortNum, USBPD_SOPType_TypeDef SOPType, USBPD_VDM_CommandType_Typedef CommandStatus, USBPD_DiscoveryIdentity_TypeDef *pIdentity)
{
  switch(CommandStatus)
  {
  case SVDM_RESPONDER_ACK :
    break;
  case SVDM_RESPONDER_NAK :
    break;
  case SVDM_RESPONDER_BUSY :
    break;
  default :
    break;
  }
}


/**
  * @brief  Inform SVID callback
  * @param  PortNum       current port number
  * @param  SOPType       SOP type
  * @param  CommandStatus Command status based on @ref USBPD_VDM_CommandType_Typedef
  * @param  pListSVID     Pointer of list of SVID based on @ref USBPD_SVIDInfo_TypeDef
  * @retval USBPD status
  */
static USBPD_StatusTypeDef USBPD_VDM_InformSVID(uint8_t PortNum, USBPD_SOPType_TypeDef SOPType, USBPD_VDM_CommandType_Typedef CommandStatus, USBPD_SVIDInfo_TypeDef *pListSVID)
{
  switch(CommandStatus)
  {
  case SVDM_RESPONDER_ACK :
    break;
  case SVDM_RESPONDER_NAK :
    break;
  case SVDM_RESPONDER_BUSY :
    break;
  default :
      break;
  }

  return USBPD_OK;
}

/**
  * @brief  Inform Mode callback
  * @param  PortNum         current port number
  * @param  SOPType         SOP type
  * @param  CommandStatus   Command status based on @ref USBPD_VDM_CommandType_Typedef
  * @param  pModesInfo      Pointer of Modes info based on @ref USBPD_ModeInfo_TypeDef
  * @retval USBPD status
  */
static USBPD_StatusTypeDef USBPD_VDM_InformMode(uint8_t PortNum, USBPD_SOPType_TypeDef SOPType, USBPD_VDM_CommandType_Typedef CommandStatus, USBPD_ModeInfo_TypeDef *pModesInfo)
{
  switch(CommandStatus)
  {
  case SVDM_RESPONDER_ACK :
    break;
  case SVDM_RESPONDER_NAK :
    break;
  case SVDM_RESPONDER_BUSY :
    break;
  default :
    break;
  }

  return USBPD_OK;
}

/**
  * @brief  Inform Mode enter callback
  * @param  PortNum   current port number
  * @param  SVID      SVID ID
  * @param  ModeIndex Index of the mode to be entered
  * @retval USBPD status
  */
static USBPD_StatusTypeDef USBPD_VDM_InformModeEnter(uint8_t PortNum, USBPD_SOPType_TypeDef SOPType, USBPD_VDM_CommandType_Typedef CommandStatus, uint16_t SVID, uint32_t ModeIndex)
{
  USBPD_StatusTypeDef status = USBPD_OK;
  switch(CommandStatus)
  {
  case SVDM_RESPONDER_ACK :
    break;
  case SVDM_RESPONDER_NAK :
    break;
  case SVDM_RESPONDER_BUSY :
    /* retry in 50ms */
    break;
  default :
    break;
  }
  return USBPD_OK;
}

/**
  * @brief  Inform Exit enter callback
  * @param  PortNum   current port number
  * @param  SVID      SVID ID
  * @param  ModeIndex Index of the mode to be entered
  * @retval USBPD status
  */
static USBPD_StatusTypeDef USBPD_VDM_InformModeExit(uint8_t PortNum, USBPD_SOPType_TypeDef SOPType, USBPD_VDM_CommandType_Typedef CommandStatus, uint16_t SVID, uint32_t ModeIndex)
{
  USBPD_StatusTypeDef status = USBPD_OK;
  switch(CommandStatus)
  {
  case SVDM_RESPONDER_ACK :
    break;
  case SVDM_RESPONDER_NAK :
    break;
  case SVDM_RESPONDER_BUSY :
    /* retry in 50ms */
    break;
  default :
    break;
  }
  return USBPD_OK;
}


/**
  * @brief  VDM Send Specific message callback
  * @param  PortNum    current port number
  * @param  NbData     Pointer of number of VDO to send
  * @param  VDO        Pointer of VDO to send
  * @retval USBPD status : USBPD_BUSY, USBPD_ACK or USBPD_NAK
  */
static USBPD_StatusTypeDef USBPD_VDM_SendAttention(uint8_t PortNum, uint8_t *NbData, uint32_t *VDO)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Attention callback to forward information from PE stack
  * @param  PortNum   current port number
  * @param  NbData    Number of received VDO
  * @param  VDO       Received VDO
  * @retval status
  */
static void USBPD_VDM_ReceiveAttention(uint8_t PortNum, uint8_t NbData, uint32_t VDO)
{
}

/**
  * @brief  VDM Send Specific message callback
  * @param  PortNum    current port number
  * @param  VDMCommand VDM command based on @ref USBPD_VDM_Command_Typedef
  * @param  NbData     Pointer of number of VDO to send
  * @param  VDO        Pointer of VDO to send
  * @retval status
  */
static USBPD_StatusTypeDef USBPD_VDM_SendSpecific(uint8_t PortNum, USBPD_VDM_Command_Typedef VDMCommand, uint8_t *NbData, uint32_t *VDO)
{
  return USBPD_ACK;
}

/**
  * @brief  VDM Receive Specific message callback
  * @param  PortNum     Current port number
  * @param  VDMCommand  VDM command based on @ref USBPD_VDM_Command_Typedef
  * @param  pNbData     Pointer of number of received VDO and used for the answer
  * @param  pVDO        Pointer of received VDO and use for the answer
  * @retval USBPD status
  */
static USBPD_StatusTypeDef USBPD_VDM_ReceiveSpecific(uint8_t PortNum, USBPD_VDM_Command_Typedef VDMCommand, uint8_t *pNbData, uint32_t *pVDO)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Inform Specific callback
  * @param  PortNum    current port number
  * @param  VDMCommand VDM command based on @ref USBPD_VDM_Command_Typedef
  * @param  NbData     Pointer of number of received VDO
  * @param  VDO        Pointer of received VDO
  * @retval status
  */
static USBPD_StatusTypeDef USBPD_VDM_InformSpecific(uint8_t PortNum, USBPD_VDM_Command_Typedef VDMCommand, uint8_t *NbData, uint32_t *VDO)
{
  return USBPD_NAK;
}

/**
  * @brief  VDM Send UVDM
  * @param  PortNum    current port number
  * @param  pUVDM_Header UVDM header
  * @param  NbData     Pointer on the number of VDO to send 
  * @param  VDO        Pointer VDO
  * @retval status
  */
static USBPD_StatusTypeDef USBPD_VDM_SendUVDM(uint8_t PortNum, USBPD_UVDMHeader_TypeDef *pUVDM_Header, uint8_t *pNbData, uint32_t *pVDO)
{
  return USBPD_ERROR;
}


/**
  * @brief  VDM Receive UVDM 
  * @param  PortNum    current port number
  * @param  VDMCommand VDM command based on @ref USBPD_VDM_Command_Typedef
  * @param  NbData     Pointer of number of received VDO
  * @param  VDO        Pointer of received VDO
  * @retval status
  */
static USBPD_StatusTypeDef USBPD_VDM_ReceiveUVDM(uint8_t PortNum, USBPD_UVDMHeader_TypeDef UVDM_Header, uint8_t *pNbData, uint32_t *pVDO)
{
  return USBPD_ERROR;
}
/* USER CODE END Private_functions */


/* Exported functions ---------------------------------------------------------*/
/**
  * @brief  VDM Initialization function
  * @param  PortNum     Index of current used port
  * @param  pSettings   Pointer on @ref USBPD_VDM_SettingsTypeDef structure
  * @param  pParams     Pointer on @ref USBPD_ParamsTypeDef structure
  * @retval status
  */
USBPD_StatusTypeDef USBPD_VDM_UserInit(uint8_t PortNum)
{
/* USER CODE BEGIN USBPD_VDM_UserInit */
    return USBPD_OK;
/* USER CODE END USBPD_VDM_UserInit */
}

/**
  * @brief  VDM Reset function
  * @retval status
  */
void USBPD_VDM_UserReset(uint8_t PortNum)
{
/* USER CODE BEGIN USBPD_VDM_UserReset */

/* USER CODE END USBPD_VDM_UserReset */
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/