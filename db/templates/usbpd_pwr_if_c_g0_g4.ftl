[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_pwr_if.c
  * @author  MCD Application Team
  * @brief   This file contains power interface control functions.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign SRC = false]
[#assign SNK = false]
[#assign DRP = false]
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name=="USBPD_NbPorts"]
                [#assign nbPorts = definition.value]
            [/#if]
            [#if definition.name == "SRC" && definition.value == "true"]
                [#assign SRC = true]
            [/#if]
            [#if definition.name == "SNK" && definition.value == "true"]
                [#assign SNK = true]
            [/#if]
            [#if definition.name == "DRP" && definition.value == "true"]
                [#assign DRP = true]
            [/#if]
        [/#list]
    [/#if]
    [#assign instName = SWIP.ipName]
    [#assign fileName = SWIP.fileName]
    [#assign version = SWIP.version]
[/#list]

#define __USBPD_PWR_IF_C

/* Includes ------------------------------------------------------------------*/
#include "usbpd_pwr_if.h"
#include "usbpd_hw_if.h"
#include "usbpd_pwr_if.h"
#include "usbpd_dpm_core.h"
#include "usbpd_dpm_conf.h"
#include "usbpd_pdo_defs.h"
#include "usbpd_core.h"
#if defined(_TRACE)
#include "usbpd_trace.h"
#endif /* _TRACE */
#include "string.h"
[#if GUI_INTERFACE??]
#include "gui_api.h"
[/#if]
/* USER CODE BEGIN Include */

/* USER CODE END Include */

/** @addtogroup STM32_USBPD_APPLICATION
  * @{
  */

/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF_Private_TypeDef
  * @{
  */
/* USER CODE BEGIN Private_Typedef */

/* USER CODE END Private_Typedef */
/**
  * @}
  */

/* Private define ------------------------------------------------------------*/
/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF_Private_Defines
  * @{
  */
/* USER CODE BEGIN Private_Define */

/* USER CODE END Private_Define */
/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF_Private_Macros
  * @{
  */
#if defined(_TRACE)
#define PWR_IF_DEBUG_TRACE(_PORT_, __MESSAGE__)  USBPD_TRACE_Add(USBPD_TRACE_DEBUG,    (_PORT_), 0u,(__MESSAGE__), sizeof(__MESSAGE__) - 1u)
#else
#define PWR_IF_DEBUG_TRACE(_PORT_, __MESSAGE__)
#endif /* _TRACE */
/* USER CODE BEGIN Private_Macro */

/* USER CODE END Private_Macro */
/**
  * @}
  */

/* Private variables ---------------------------------------------------------*/
/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF_Private_Variables
  * @{
  */
/* USER CODE BEGIN Private_Variables */

/* USER CODE END Private_Variables */
/**
  * @}
  */

/* Private function prototypes -----------------------------------------------*/
/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF_Private_Functions
  * @{
  */
/* USER CODE BEGIN USBPD_USER_PRIVATE_FUNCTIONS_Prototypes */

/* USER CODE END USBPD_USER_PRIVATE_FUNCTIONS_Prototypes */
/**
  * @}
  */

/** @addtogroup STM32_USBPD_APPLICATION_POWER_IF_Exported_Functions
  * @{
  */

/**
  * @brief  Initialize structures and variables related to power board profiles
  *         used by Sink and Source, for all available ports.
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_PWR_IF_Init(void)
{
/* USER CODE BEGIN USBPD_PWR_IF_Init */
  return USBPD_ERROR;
/* USER CODE END USBPD_PWR_IF_Init */
}

/**
  * @brief  Sets the required power profile, now it works only with Fixed ones
  * @param  PortNum Port number
  * @retval USBPD status
*/
USBPD_StatusTypeDef USBPD_PWR_IF_SetProfile(uint8_t PortNum)
{
/* USER CODE BEGIN USBPD_PWR_IF_SetProfile */
  USBPD_StatusTypeDef      _status = USBPD_ERROR;
[#if SRC || DRP]
  PWR_IF_DEBUG_TRACE(PortNum, "HELP: update USBPD_PWR_IF_SetProfile");
/*   if (BSP_ERROR_NONE == BSP_USBPD_PWR_VBUSSetVoltage_Fixed(PortNum, 5000, 3000, 3000))
  {
     _status = USBPD_OK;
  }
 */
[/#if]
  return _status;
/* USER CODE END USBPD_PWR_IF_SetProfile */
}

/**
  * @brief  Checks if the power on a specified port is ready
  * @param  PortNum Port number
  * @param  Vsafe   Vsafe status based on @ref USBPD_VSAFE_StatusTypeDef
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_PWR_IF_SupplyReady(uint8_t PortNum, USBPD_VSAFE_StatusTypeDef Vsafe)
{
/* USER CODE BEGIN USBPD_PWR_IF_SupplyReady */
  return USBPD_ERROR;
/* USER CODE END USBPD_PWR_IF_SupplyReady */
}

/**
  * @brief  Enables VBUS power on a specified port
  * @param  PortNum Port number
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_PWR_IF_VBUSEnable(uint8_t PortNum)
{
/* USER CODE BEGIN USBPD_PWR_IF_VBUSEnable */
[#if SRC || DRP]
  USBPD_StatusTypeDef _status = (USBPD_StatusTypeDef)HW_IF_PWR_Enable(PortNum, USBPD_ENABLE, CCNONE, USBPD_FALSE, USBPD_PORTPOWERROLE_SRC);
  return _status;
[#else]
  return USBPD_ERROR;
[/#if]
/* USER CODE END USBPD_PWR_IF_VBUSEnable */
}

/**
  * @brief  Disbale VBUS/VCONN the power on a specified port
  * @param  PortNum Port number
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_PWR_IF_VBUSDisable(uint8_t PortNum)
{
/* USER CODE BEGIN USBPD_PWR_IF_VBUSDisable */
[#if SRC || DRP]
  USBPD_StatusTypeDef _status = (USBPD_StatusTypeDef)HW_IF_PWR_Enable(PortNum, USBPD_DISABLE, CCNONE, USBPD_FALSE, USBPD_PORTPOWERROLE_SRC);
  return _status;
[#else]
  return USBPD_ERROR;
[/#if]
/* USER CODE END USBPD_PWR_IF_VBUSDisable */
}

/**
  * @brief  Checks if the power on a specified port is enabled
  * @param  PortNum Port number
  * @retval USBPD_ENABLE or USBPD_DISABLE
  */
USBPD_FunctionalState USBPD_PWR_IF_VBUSIsEnabled(uint8_t PortNum)
{
  /* Get the Status of the port */
  return USBPD_PORT_IsValid(PortNum) ? (USBPD_FunctionalState)HW_IF_PWR_VBUSIsEnabled(PortNum) : USBPD_DISABLE;
}

/**
  * @brief  Reads the voltage and the current on a specified port
  * @param  PortNum Port number
  * @param  pVoltage: The Voltage in mV
  * @param  pCurrent: The Current in mA
  * @retval USBPD_ERROR or USBPD_OK
  */
USBPD_StatusTypeDef USBPD_PWR_IF_ReadVA(uint8_t PortNum, uint16_t *pVoltage, uint16_t *pCurrent)
{
/* USER CODE BEGIN USBPD_PWR_IF_ReadVA */
  return USBPD_ERROR;
/* USER CODE END USBPD_PWR_IF_ReadVA */
}

/**
  * @brief  Enables the VConn on the port.
  * @param  PortNum Port number
  * @param  CC      Specifies the CCx to be selected based on @ref CCxPin_TypeDef structure
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_PWR_IF_Enable_VConn(uint8_t PortNum, CCxPin_TypeDef CC)
{
/* USER CODE BEGIN USBPD_PWR_IF_Enable_VConn */
  return USBPD_ERROR;
/* USER CODE END USBPD_PWR_IF_Enable_VConn */
}

/**
  * @brief  Disable the VConn on the port.
  * @param  PortNum Port number
  * @param  CC      Specifies the CCx to be selected based on @ref CCxPin_TypeDef structure
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_PWR_IF_Disable_VConn(uint8_t PortNum, CCxPin_TypeDef CC)
{
/* USER CODE BEGIN USBPD_PWR_IF_Disable_VConn */
  return USBPD_ERROR;
/* USER CODE END USBPD_PWR_IF_Disable_VConn */
}

/**
  * @brief  Allow PDO data reading from PWR_IF storage.
  * @param  PortNum Port number
  * @param  DataId Type of data to be read from PWR_IF
  *         This parameter can be one of the following values:
  *           @arg @ref USBPD_CORE_DATATYPE_SRC_PDO Source PDO reading requested
  *           @arg @ref USBPD_CORE_DATATYPE_SNK_PDO Sink PDO reading requested
  * @param  Ptr Pointer on address where PDO values should be written (u8 pointer)
  * @param  Size Pointer on nb of u32 written by PWR_IF (nb of PDOs)
  * @retval None
  */
void USBPD_PWR_IF_GetPortPDOs(uint8_t PortNum, USBPD_CORE_DataInfoType_TypeDef DataId, uint8_t *Ptr, uint32_t *Size)
{
[#if nbPorts=="2"]
  if (USBPD_PORT_0 == PortNum)
  {
[/#if]
[#if SRC || DRP]
    if (DataId == USBPD_CORE_DATATYPE_SRC_PDO)
    {
[#if GUI_INTERFACE??]
      *Size = GUI_NbPDO[1];
      memcpy(Ptr,PORT0_PDO_ListSRC, sizeof(uint32_t) * GUI_NbPDO[1]);
[#else]
      *Size = PORT0_NB_SOURCEPDO;
      memcpy(Ptr,PORT0_PDO_ListSRC, sizeof(uint32_t) * PORT0_NB_SOURCEPDO);
[/#if]
    }
[/#if]
[#if DRP]
    else
[/#if]
[#if SNK || DRP]
    {
[#if GUI_INTERFACE??]
      *Size = GUI_NbPDO[0];
      memcpy(Ptr,PORT0_PDO_ListSNK, sizeof(uint32_t) * GUI_NbPDO[0]);
[#else]
      *Size = PORT0_NB_SINKPDO;
      memcpy(Ptr,PORT0_PDO_ListSNK, sizeof(uint32_t) * PORT0_NB_SINKPDO);
[/#if]
    }
[/#if]
[#if nbPorts=="2"]
  }
  else
  {
[#if SRC || DRP]
    if (DataId == USBPD_CORE_DATATYPE_SRC_PDO)
    {
[#if GUI_INTERFACE??]
      *Size = GUI_NbPDO[3];
      memcpy(Ptr,PORT1_PDO_ListSRC, sizeof(uint32_t) * GUI_NbPDO[3]);
[#else]
      *Size = PORT1_NB_SOURCEPDO;
      memcpy(Ptr,PORT1_PDO_ListSRC, sizeof(uint32_t) * PORT1_NB_SOURCEPDO);
[/#if]
    }
[/#if]
[#if DRP]
    else
[/#if]
[#if SNK || DRP]
    {
[#if GUI_INTERFACE??]
      *Size = GUI_NbPDO[2];
      memcpy(Ptr,PORT1_PDO_ListSNK, sizeof(uint32_t) * GUI_NbPDO[2]);
[#else]
      *Size = PORT1_NB_SINKPDO;
      memcpy(Ptr,PORT1_PDO_ListSNK, sizeof(uint32_t) * PORT1_NB_SINKPDO);
[/#if]
    }
[/#if]
  }
[/#if]
/* USER CODE BEGIN USBPD_PWR_IF_GetPortPDOs */

/* USER CODE END USBPD_PWR_IF_GetPortPDOs */
}

/**
  * @brief  Find out SRC PDO pointed out by a position provided in a Request DO (from Sink).
  * @param  PortNum Port number
  * @param  RdoPosition RDO Position in list of provided PDO
  * @param  Pdo Pointer on PDO value pointed out by RDO position (u32 pointer)
  * @retval Status of search
  *         USBPD_OK : Src PDO found for requested DO position (output Pdo parameter is set)
  *         USBPD_FAIL : Position is not compliant with current Src PDO for this port (no corresponding PDO value)
  */
USBPD_StatusTypeDef USBPD_PWR_IF_SearchRequestedPDO(uint8_t PortNum, uint32_t RdoPosition, uint32_t *Pdo)
{
/* USER CODE BEGIN USBPD_PWR_IF_SearchRequestedPDO */
  return USBPD_FAIL;
/* USER CODE END USBPD_PWR_IF_SearchRequestedPDO */
}

/**
  * @brief  the function is called in case of critical issue is detected to switch in safety mode.
  * @retval None
  */
void USBPD_PWR_IF_Alarm()
{
/* USER CODE BEGIN USBPD_PWR_IF_Alarm */

/* USER CODE END USBPD_PWR_IF_Alarm */
}

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
