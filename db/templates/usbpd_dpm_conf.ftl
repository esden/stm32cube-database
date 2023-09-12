[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_dpm_core.h
  * @author  MCD Application Team
  * @brief   Header file for usbpd_dpm_core.c file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef __USBPD_DPM_CONF_H_
#define __USBPD_DPM_CONF_H_

#ifdef __cplusplus
 extern "C" {
#endif 

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
    	[#list SWIP.defines as definition]
            [#if definition.name=="USBPD_NbPorts"]
                [#assign nbPorts = definition.value]
            [/#if]
            [#if definition.name=="USBPD_PortConfig"]
                [#assign valueUSBPD_PortConfig = definition.value]
            [/#if]
            [#if definition.name=="USBPD_VID"]
                [#assign valueUSBPD_VID = definition.value]
            [/#if]
            [#if definition.name=="USBPD_PID"]
                [#assign valueUSBPD_PID = definition.value]
            [/#if]
            [#if definition.name=="USBPD_XID"]
                [#assign valueUSBPD_XID = definition.value]
            [/#if]
            [#if definition.name=="PE_SupportedSOP_P0"]
                [#assign valuePE_SupportedSOP_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_SupportedSOPapos_P0"]
                [#assign valuePE_SupportedSOPapos_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_SupportedSOPquot_P0"]
                [#assign valuePE_SupportedSOPquot_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_SupportedSOPaposDBG_P0"]
                [#assign valuePE_SupportedSOPaposDBG_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_SupportedSOPquotDBG_P0"]
                [#assign valuePE_SupportedSOPquotDBG_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_SpecRevision_P0"]
                [#assign valuePE_SpecRevision_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_DefaultRole_P0"]
                [#assign valuePE_DefaultRole_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_RoleSwap_P0"]
                [#assign valuePE_RoleSwap_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_DataSwap_P0"]
                [#assign valuePE_DataSwap_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_VDMSupport_P0"]
                [#assign valuePE_VDMSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_RespondsToDiscovSOP_P0"]
                [#assign valuePE_RespondsToDiscovSOP_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_AttemptsDiscovSOP_P0"]
                [#assign valuePE_AttemptsDiscovSOP_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_PingSupport_P0"]
                [#assign valuePE_PingSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_UnchunkSupport_P0"]
                [#assign valuePE_UnchunkSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_CapscounterSupport_P0"]
                [#assign valuePE_CapscounterSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_FastRoleSwapSupport_P0"]
                [#assign valuePE_FastRoleSwapSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="CAD_RoleToggle_P0"]
                [#assign valueCAD_RoleToggle_P0 = definition.value]
            [/#if]
            [#if definition.name=="CAD_DefaultResistor_P0"]
                [#assign valueCAD_DefaultResistor_P0 = definition.value]
            [/#if]
            [#if definition.name=="CAD_TryFeature_P0"]
                [#assign valueCAD_TryFeature_P0 = definition.value]
            [/#if]
            [#if definition.name=="CAD_AccesorySupport_P0"]
                [#assign valueCAD_AccesorySupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_GetPPSStatus_Supported_P0"]
                [#assign valueIs_GetPPSStatus_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_SrcCapaExt_Supported_P0"]
                [#assign valueIs_SrcCapaExt_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_Alert_Supported_P0"]
                [#assign valueIs_Alert_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_GetStatus_Supported_P0"]
                [#assign valueIs_GetStatus_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_GetBattery_Supported_P0"]
                [#assign valueIs_GetBattery_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_BatteryCapaSupport_P0"]
                [#assign valuePE_BatteryCapaSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_GetManufacturerInfo_Supported_P0"]
                [#assign valueIs_GetManufacturerInfo_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_GetCountryCodes_Supported_P0"]
                [#assign valueIs_GetCountryCodes_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_GetCountryInfo_Supported_P0"]
                [#assign valueIs_GetCountryInfo_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_SecurityRequest_Supported_P0"]
                [#assign valueIs_SecurityRequest_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_FirmUpdateRequest_Supported_P0"]
                [#assign valueIs_FirmUpdateRequest_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="Is_SnkCapaExt_Supported_P0"]
                [#assign valueIs_SnkCapaExt_Supported_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_XID_SOP_P0"]
                [#assign valueVDM_XID_SOP_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_PID_SOP_P0"]
                [#assign valueVDM_PID_SOP_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_ModalOperation_P0"]
                [#assign valueVDM_ModalOperation_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_bcdDevice_SOP_P0"]
                [#assign valueVDM_bcdDevice_SOP_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_USBHostSupport_P0"]
                [#assign valueVDM_USBHostSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_USBDeviceSupport_P0"]
                [#assign valueVDM_USBDeviceSupport_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_ProductTypeUFPorCP_P0"]
                [#assign valueVDM_ProductTypeUFPorCP_P0 = definition.value]
            [/#if]
            [#if definition.name=="VDM_ProductTypeDFP_P0"]
                [#assign valueVDM_ProductTypeDFP_P0 = definition.value]
            [/#if]
            [#if definition.name=="CAD_SRCToggleTime_P0"]
                [#assign valueCAD_SRCToggleTime_P0 = definition.value]
            [/#if]
            [#if definition.name=="CAD_SNKToggleTime_P0"]
                [#assign valueCAD_SNKToggleTime_P0 = definition.value]
            [/#if]
            [#if nbPorts=="2"]
                [#if definition.name=="PE_SupportedSOP_P1"]
                    [#assign valuePE_SupportedSOP_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_SupportedSOPapos_P1"]
                    [#assign valuePE_SupportedSOPapos_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_SupportedSOPquot_P1"]
                    [#assign valuePE_SupportedSOPquot_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_SupportedSOPaposDBG_P1"]
                    [#assign valuePE_SupportedSOPaposDBG_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_SupportedSOPquotDBG_P1"]
                    [#assign valuePE_SupportedSOPquotDBG_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_SpecRevision_P1"]
                    [#assign valuePE_SpecRevision_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_DefaultRole_P1"]
                    [#assign valuePE_DefaultRole_P1 = definition.value]
                    [#if valuePE_DefaultRole_P1 == ""]
                        [#assign valuePE_DefaultRole_P1 = "USBPD_FALSE"]
                    [/#if]
                [/#if]
                [#if definition.name=="PE_RoleSwap_P1"]
                    [#assign valuePE_RoleSwap_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_DataSwap_P1"]
                    [#assign valuePE_DataSwap_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_VDMSupport_P1"]
                    [#assign valuePE_VDMSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_RespondsToDiscovSOP_P1"]
                    [#assign valuePE_RespondsToDiscovSOP_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_AttemptsDiscovSOP_P1"]
                    [#assign valuePE_AttemptsDiscovSOP_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_PingSupport_P1"]
                    [#assign valuePE_PingSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_UnchunkSupport_P1"]
                    [#assign valuePE_UnchunkSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_CapscounterSupport_P1"]
                    [#assign valuePE_CapscounterSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_FastRoleSwapSupport_P1"]
                    [#assign valuePE_FastRoleSwapSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="CAD_RoleToggle_P1"]
                    [#assign valueCAD_RoleToggle_P1 = definition.value]
                [/#if]
                [#if definition.name=="CAD_DefaultResistor_P1"]
                    [#assign valueCAD_DefaultResistor_P1 = definition.value]
                [/#if]
                [#if definition.name=="CAD_TryFeature_P1"]
                    [#assign valueCAD_TryFeature_P1 = definition.value]
                [/#if]
                [#if definition.name=="CAD_AccesorySupport_P1"]
                    [#assign valueCAD_AccesorySupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_GetPPSStatus_Supported_P1"]
                    [#assign valueIs_GetPPSStatus_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_SrcCapaExt_Supported_P1"]
                    [#assign valueIs_SrcCapaExt_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_Alert_Supported_P1"]
                    [#assign valueIs_Alert_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_GetStatus_Supported_P1"]
                    [#assign valueIs_GetStatus_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_GetBattery_Supported_P1"]
                    [#assign valueIs_GetBattery_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_BatteryCapaSupport_P1"]
                    [#assign valuePE_BatteryCapaSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_GetManufacturerInfo_Supported_P1"]
                    [#assign valueIs_GetManufacturerInfo_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_GetCountryCodes_Supported_P1"]
                    [#assign valueIs_GetCountryCodes_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_GetCountryInfo_Supported_P1"]
                    [#assign valueIs_GetCountryInfo_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_SecurityRequest_Supported_P1"]
                    [#assign valueIs_SecurityRequest_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_FirmUpdateRequest_Supported_P1"]
                    [#assign valueIs_FirmUpdateRequest_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="Is_SnkCapaExt_Supported_P1"]
                    [#assign valueIs_SnkCapaExt_Supported_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_XID_SOP_P1"]
                    [#assign valueVDM_XID_SOP_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_PID_SOP_P1"]
                    [#assign valueVDM_PID_SOP_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_ModalOperation_P1"]
                    [#assign valueVDM_ModalOperation_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_bcdDevice_SOP_P1"]
                    [#assign valueVDM_bcdDevice_SOP_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_USBHostSupport_P1"]
                    [#assign valueVDM_USBHostSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_USBDeviceSupport_P1"]
                    [#assign valueVDM_USBDeviceSupport_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_ProductTypeUFPorCP_P1"]
                    [#assign valueVDM_ProductTypeUFPorCP_P1 = definition.value]
                [/#if]
                [#if definition.name=="VDM_ProductTypeDFP_P1"]
                    [#assign valueVDM_ProductTypeDFP_P1 = definition.value]
                [/#if]
                [#if definition.name=="CAD_SRCToggleTime_P1"]
                    [#assign valueCAD_SRCToggleTime_P1 = definition.value]
                [/#if]
                [#if definition.name=="CAD_SNKToggleTime_P1"]
                    [#assign valueCAD_SNKToggleTime_P1 = definition.value]
                [/#if]
            [/#if]
        [/#list]
    [/#if]

    [#assign instName = SWIP.ipName]
    [#assign fileName = SWIP.fileName]
    [#assign version = SWIP.version]

[/#list]

/* Includes ------------------------------------------------------------------*/
#include "usbpd_pdo_defs.h"
#include "usbpd_vdm_user.h"
#include "usbpd_dpm_user.h"

/* USER CODE BEGIN Includes */
/* Section where include file can be added */

/* USER CODE END Includes */

/* Define   ------------------------------------------------------------------*/
/* Define VID, PID,... manufacturer parameters */
#define USBPD_VID (${valueUSBPD_VID}u)     /*!< Vendor ID (assigned by the USB-IF)                     */
#define USBPD_PID (${valueUSBPD_PID}u)     /*!< Product ID (assigned by the manufacturer)              */
#define USBPD_XID (${valueUSBPD_XID}u) /*!< Value provided by the USB-IF assigned to the product   */

/* USER CODE BEGIN Define */
/* Section where Define can be added */

/* USER CODE END Define */

/* Exported typedef ----------------------------------------------------------*/
/* USER CODE BEGIN Typedef */
/* Section where Typedef can be added */

/* USER CODE END Typedef */

/* Private variables ---------------------------------------------------------*/
#ifndef __USBPD_DPM_CORE_C
extern USBPD_SettingsTypeDef            DPM_Settings[USBPD_PORT_COUNT];
#else
USBPD_SettingsTypeDef       DPM_Settings[USBPD_PORT_COUNT] =
{
  {
    .PE_SupportedSOP = ${valuePE_SupportedSOP_P0}[#rt]
    [#if valuePE_SupportedSOPapos_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPapos_P0}[/#if][#t]
    [#if valuePE_SupportedSOPquot_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquot_P0}[/#if][#t]
    [#if valuePE_SupportedSOPaposDBG_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPaposDBG_P0}[/#if][#t]
    [#if valuePE_SupportedSOPquotDBG_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquotDBG_P0}[/#if], /* Supported SOP : SOP, SOP' SOP" SOP'Debug SOP"Debug */
    .PE_SpecRevision = ${valuePE_SpecRevision_P0},/* spec revision value                                     */
    .PE_DefaultRole = ${valuePE_DefaultRole_P0},  /* Default port role                                       */    
    .PE_RoleSwap = ${valuePE_RoleSwap_P0},                  /* support port role swap                                  */
    .PE_VDMSupport = ${valuePE_VDMSupport_P0},
    .PE_RespondsToDiscovSOP = ${valuePE_RespondsToDiscovSOP_P0},      /*!< Can respond successfully to a Discover Identity */
    .PE_AttemptsDiscovSOP = ${valuePE_AttemptsDiscovSOP_P0},        /*!< Can send a Discover Identity */
    .PE_PingSupport = ${valuePE_PingSupport_P0},              /* support ping                                            */
    .PE_CapscounterSupport = ${valuePE_CapscounterSupport_P0},       /* support caps counter                                    */
    .CAD_RoleToggle = ${valueCAD_RoleToggle_P0},               /* cad role toggle                                         */
    .CAD_DefaultResistor = ${valueCAD_DefaultResistor_P0},
    .CAD_TryFeature = ${valueCAD_TryFeature_P0},              /* cad try feature                                         */
    .CAD_AccesorySupport = ${valueCAD_AccesorySupport_P0},         /* cas accessory support                                   */
    .PE_PD3_Support.d =                           /*!< PD3 SUPPORT FEATURE                                              */
    {
      .PE_UnchunkSupport                = ${valuePE_UnchunkSupport_P0},  /* support Unchunked mode (valid only spec revision 3.0)   */
      .PE_FastRoleSwapSupport           = ${valuePE_FastRoleSwapSupport_P0},   /* support fast role swap only spec revsion 3.0            */
      .Is_GetPPSStatus_Supported        = ${valueIs_GetPPSStatus_Supported_P0},  /*!< PPS message NOT supported by PE stack */
      .Is_SrcCapaExt_Supported          = ${valueIs_SrcCapaExt_Supported_P0},  /*!< Source_Capabilities_Extended message supported or not by DPM */
      .Is_Alert_Supported               = ${valueIs_Alert_Supported_P0},   /*!< Alert message supported or not by DPM */
      .Is_GetStatus_Supported           = ${valueIs_GetStatus_Supported_P0},   /*!< Status message supported or not by DPM (Is_Alert_Supported should be enabled) */
      .Is_GetManufacturerInfo_Supported = ${valueIs_GetManufacturerInfo_Supported_P0},  /*!< Manufacturer_Info message supported or not by DPM */
      .Is_GetCountryCodes_Supported     = ${valueIs_GetCountryCodes_Supported_P0},  /*!< Country_Codes message supported or not by DPM */
      .Is_GetCountryInfo_Supported      = ${valueIs_GetCountryInfo_Supported_P0},  /*!< Country_Info message supported or not by DPM */
      .Is_SecurityRequest_Supported     = ${valueIs_SecurityRequest_Supported_P0},  /*!< Security_Response message supported or not by DPM */
      .Is_FirmUpdateRequest_Supported   = ${valueIs_FirmUpdateRequest_Supported_P0},  /*!< Firmware update response message supported by PE */
      .Is_SnkCapaExt_Supported          = ${valueIs_SnkCapaExt_Supported_P0},  /*!< Sink_Capabilities_Extended message supported by PE */
    },

    .CAD_SRCToggleTime = ${valueCAD_SRCToggleTime_P0},                    /* uint8_t CAD_SRCToggleTime; */
    .CAD_SNKToggleTime = ${valueCAD_SNKToggleTime_P0},                    /* uint8_t CAD_SNKToggleTime; */
[#if nbPorts=="2"]
#if USBPD_PORT_COUNT >= 2
  },
  {
    .PE_SupportedSOP = ${valuePE_SupportedSOP_P1}[#rt]
    [#if valuePE_SupportedSOPapos_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPapos_P1}[/#if][#t]
    [#if valuePE_SupportedSOPquot_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquot_P1}[/#if][#t]
    [#if valuePE_SupportedSOPaposDBG_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPaposDBG_P1}[/#if][#t]
    [#if valuePE_SupportedSOPquotDBG_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquotDBG_P1}[/#if], /* Supported SOP : SOP, SOP' SOP" SOP'Debug SOP"Debug      */
    .PE_SpecRevision = ${valuePE_SpecRevision_P1},/* spec revision value                                     */
    .PE_DefaultRole = ${valuePE_DefaultRole_P1},  /* Default port role                                       */
    .PE_RoleSwap = ${valuePE_RoleSwap_P1},                 /* support port role swap                                  */
    .PE_VDMSupport = ${valuePE_VDMSupport_P1},
    .PE_RespondsToDiscovSOP = ${valuePE_RespondsToDiscovSOP_P1},      /*!< Can respond successfully to a Discover Identity */
    .PE_AttemptsDiscovSOP = ${valuePE_AttemptsDiscovSOP_P1},        /*!< Can send a Discover Identity */
    .PE_PingSupport = ${valuePE_PingSupport_P1},              /* support ping                                            */
    .PE_CapscounterSupport = ${valuePE_CapscounterSupport_P1},       /* support caps counter                                    */
    .CAD_RoleToggle = ${valueCAD_RoleToggle_P1},              /* cad role toggle                                         */
    .CAD_DefaultResistor = ${valueCAD_DefaultResistor_P1},
    .CAD_TryFeature = ${valueCAD_TryFeature_P1},              /* cad try feature                                         */
    .CAD_AccesorySupport = ${valueCAD_AccesorySupport_P1},         /* cas accessory support                                   */
    .PE_PD3_Support.d =                         /*!< PD3 SUPPORT FEATURE                                              */
    {
      .PE_UnchunkSupport                = ${valuePE_UnchunkSupport_P1},  /* support Unchunked mode (valid only spec revision 3.0)   */
      .PE_FastRoleSwapSupport           = ${valuePE_FastRoleSwapSupport_P1},  /* support fast role swap only spec revsion 3.0            */
      .Is_GetPPSStatus_Supported        = ${valueIs_GetPPSStatus_Supported_P1},  /*!< PPS message NOT supported by PE stack */
      .Is_SrcCapaExt_Supported          = ${valueIs_SrcCapaExt_Supported_P1},  /*!< Source_Capabilities_Extended message supported or not by DPM */
      .Is_Alert_Supported               = ${valueIs_Alert_Supported_P1},   /*!< Alert message supported or not by DPM */
      .Is_GetStatus_Supported           = ${valueIs_GetStatus_Supported_P1},   /*!< Status message supported or not by DPM (Is_Alert_Supported should be enabled) */
      .Is_GetManufacturerInfo_Supported = ${valueIs_GetManufacturerInfo_Supported_P1},  /*!< Manufacturer_Info message supported or not by DPM */
      .Is_GetCountryCodes_Supported     = ${valueIs_GetCountryCodes_Supported_P1},  /*!< Country_Codes message supported or not by DPM */
      .Is_GetCountryInfo_Supported      = ${valueIs_GetCountryInfo_Supported_P1},  /*!< Country_Info message supported or not by DPM */
      .Is_SecurityRequest_Supported     = ${valueIs_SecurityRequest_Supported_P1},  /*!< Security_Response message supported or not by DPM */
      .Is_FirmUpdateRequest_Supported   = ${valueIs_FirmUpdateRequest_Supported_P1},  /*!< Firmware update response message supported by PE */
      .Is_SnkCapaExt_Supported          = ${valueIs_SnkCapaExt_Supported_P1},  /*!< Sink_Capabilities_Extended message supported by PE */
    },

    .CAD_SRCToggleTime = ${valueCAD_SRCToggleTime_P1},                    /* uint8_t CAD_SRCToggleTime; */
    .CAD_SNKToggleTime = ${valueCAD_SNKToggleTime_P1},                    /* uint8_t CAD_SNKToggleTime; */
#endif
[/#if]
  }
};

#endif

/* USER CODE BEGIN Variable */
/* Section where Variable can be added */

/* USER CODE END Variable */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN Constant */
/* Section where Constant can be added */

/* USER CODE END Constant */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN Macro */
/* Section where Macro can be added */

/* USER CODE END Macro */

#ifdef __cplusplus
}
#endif

#endif /* __USBPD_DPM_CONF_H_ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
