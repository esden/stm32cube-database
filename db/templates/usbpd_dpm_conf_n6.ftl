[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_dpm_conf.h
  * @author  MCD Application Team
  * @brief   Header file for stack/application settings file
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
[#assign nbPorts = "1"]
[#assign USBPD_CoreLib = ""]
[#assign SRC = false]
[#assign SNK = false]
[#assign DRP = false]
[#assign BATT_FEATURE = false]
[#assign DR_SWAP_TO_XFP_FEATURE = false]
[#assign GUI_V1_8_0_OR_NEWER = false]
[#assign REV3_SUPPORT = false]

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "PE_SpecRevision_P0" && definition.value == "USBPD_SPECIFICATION_REV3"]
                [#assign REV3_SUPPORT = true]
            [/#if]
            [#if definition.name == "PE_SpecRevision_P1" && definition.value == "USBPD_SPECIFICATION_REV3"]
                [#assign REV3_SUPPORT = true]
            [/#if]
            [#if definition.name == "USBPD_CoreLib" && definition.value != ""]
                [#assign USBPD_CoreLib = definition.value]
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
            [#if definition.name=="USBPD_NbPorts"]
                [#assign nbPorts = definition.value]
            [/#if]
            [#if definition.name=="USBPD_PortConfig"]
                [#assign valueUSBPD_PortConfig = definition.value]
            [/#if]
            [#if definition.name=="GUI_V1_8_0_OR_NEWER" && definition.value == "true"]
                [#assign GUI_V1_8_0_OR_NEWER = true]
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
            [#if definition.name=="PE_VconnSwap_P0"]
                [#assign valuePE_VconnSwap_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_DataSwap_P0"]
                [#assign valuePE_DataSwap_P0 = definition.value]
            [/#if]
            [#if definition.name=="PE_DR_Swap_To_DFP_P0"]
                [#assign valuePE_DR_Swap_To_DFP_P0 = definition.value]
                [#assign DR_SWAP_TO_XFP_FEATURE = true]
            [/#if]
            [#if definition.name=="PE_DR_Swap_To_UFP_P0"]
                [#assign valuePE_DR_Swap_To_UFP_P0 = definition.value]
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
            [#if definition.name=="Is_GetBattery_Supported_P0"]
                [#assign valueIs_GetBattery_Supported_P0 = definition.value]
                [#assign BATT_FEATURE = true]
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
                [#if definition.name=="PE_VconnSwap_P1"]
                    [#assign valuePE_VconnSwap_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_DataSwap_P1"]
                    [#assign valuePE_DataSwap_P1 = definition.value]
                [/#if]
                [#if definition.name=="PE_DR_Swap_To_DFP_P1"]
                    [#assign valuePE_DR_Swap_To_DFP_P1 = definition.value]
                    [#assign DR_SWAP_TO_XFP_FEATURE = true]
                [/#if]
                [#if definition.name=="PE_DR_Swap_To_UFP_P1"]
                    [#assign valuePE_DR_Swap_To_UFP_P1 = definition.value]
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
                [#if definition.name=="Is_GetBattery_Supported_P1"]
                    [#assign valueIs_GetBattery_Supported_P1 = definition.value]
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
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
#include "usbpd_pdo_defs.h"
[/#if]
#include "usbpd_dpm_user.h"
[#if USBPD_CoreLib == "USBPDCORE_LIB_PD3_FULL" | USBPD_CoreLib == "USBPDCORE_LIB_PD3_CONFIG_1"]
#include "usbpd_vdm_user.h"
[/#if]

[#if GUI_INTERFACE??]
#include "gui_api.h"
#include "usbpd_gui_memmap.h"
[/#if]

/* USER CODE BEGIN Includes */
/* Section where include file can be added */

/* USER CODE END Includes */

/* Define   ------------------------------------------------------------------*/
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
/* Define VID, PID,... manufacturer parameters */
#define USBPD_VID (${valueUSBPD_VID}u)     /*!< Vendor ID (assigned by the USB-IF)                     */
#define USBPD_PID (${valueUSBPD_PID}u)     /*!< Product ID (assigned by the manufacturer)              */
#define USBPD_XID (${valueUSBPD_XID}u) /*!< Value provided by the USB-IF assigned to the product   */

[/#if]
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
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
[#if !GUI_INTERFACE?? || GUI_V1_8_0_OR_NEWER]
extern USBPD_IdSettingsTypeDef          DPM_ID_Settings[USBPD_PORT_COUNT];
extern USBPD_USER_SettingsTypeDef       DPM_USER_Settings[USBPD_PORT_COUNT];
[/#if]
[/#if]
#else /* __USBPD_DPM_CORE_C */
USBPD_SettingsTypeDef       DPM_Settings[USBPD_PORT_COUNT] =
{
  {
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .PE_SupportedSOP = ${valuePE_SupportedSOP_P0}[#rt]
    [#if valuePE_SupportedSOPapos_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPapos_P0}[/#if][#t]
    [#if valuePE_SupportedSOPquot_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquot_P0}[/#if][#t]
    [#if valuePE_SupportedSOPaposDBG_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPaposDBG_P0}[/#if][#t]
    [#if valuePE_SupportedSOPquotDBG_P0!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquotDBG_P0}[/#if], /* Supported SOP : SOP, SOP' SOP" SOP'Debug SOP"Debug */
    .PE_SpecRevision = ${valuePE_SpecRevision_P0},/* spec revision value                                     */
[/#if]
    .PE_DefaultRole = ${valuePE_DefaultRole_P0},  /* Default port role                                       */    
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .PE_RoleSwap = ${valuePE_RoleSwap_P0},                  /* support port role swap                                  */
    .PE_VDMSupport = ${valuePE_VDMSupport_P0},
    .PE_RespondsToDiscovSOP = ${valuePE_RespondsToDiscovSOP_P0},      /*!< Can respond successfully to a Discover Identity */
    .PE_AttemptsDiscovSOP = ${valuePE_AttemptsDiscovSOP_P0},        /*!< Can send a Discover Identity */
    .PE_PingSupport = ${valuePE_PingSupport_P0},              /* support Ping (only for PD3.0)                                            */
    .PE_CapscounterSupport = ${valuePE_CapscounterSupport_P0},       /* support caps counter                                    */
    .CAD_RoleToggle = ${valueCAD_RoleToggle_P0},               /* CAD role toggle                                         */
[/#if]
[#if SRC || DRP]
    .CAD_DefaultResistor = ${valueCAD_DefaultResistor_P0},
[/#if]
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .CAD_TryFeature = ${valueCAD_TryFeature_P0},              /* CAD try feature                                         */
    .CAD_AccesorySupport = ${valueCAD_AccesorySupport_P0},         /* CAD accessory support                                   */
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .PE_PD3_Support.d =                           /*!< PD3 SUPPORT FEATURE                                              */
    {
      .PE_UnchunkSupport                = ${valuePE_UnchunkSupport_P0},  /* support Unchunked mode (valid only spec revision 3.0)   */
      .PE_FastRoleSwapSupport           = ${valuePE_FastRoleSwapSupport_P0},   /* support fast role swap only spec revision 3.0            */
      .Is_GetPPSStatus_Supported        = ${valueIs_GetPPSStatus_Supported_P0},  /*!< PPS message NOT supported by PE stack */
      .Is_SrcCapaExt_Supported          = ${valueIs_SrcCapaExt_Supported_P0},  /*!< Source_Capabilities_Extended message supported or not by DPM */
      .Is_Alert_Supported               = ${valueIs_Alert_Supported_P0},   /*!< Alert message supported or not by DPM */
      .Is_GetStatus_Supported           = ${valueIs_GetStatus_Supported_P0},   /*!< Status message supported or not by DPM (Is_Alert_Supported should be enabled) */
      .Is_GetManufacturerInfo_Supported = ${valueIs_GetManufacturerInfo_Supported_P0},  /*!< Manufacturer_Info message supported or not by DPM */
      .Is_GetCountryCodes_Supported     = ${valueIs_GetCountryCodes_Supported_P0},  /*!< Country_Codes message supported or not by DPM */
      .Is_GetCountryInfo_Supported      = ${valueIs_GetCountryInfo_Supported_P0},  /*!< Country_Info message supported or not by DPM */
      .Is_SecurityRequest_Supported     = ${valueIs_SecurityRequest_Supported_P0},  /*!< Security_Response message supported or not by DPM */
      .Is_FirmUpdateRequest_Supported   = ${valueIs_FirmUpdateRequest_Supported_P0},  /*!< Firmware update response message supported by PE */
[#if BATT_FEATURE]
      .Is_GetBattery_Supported          = ${valueIs_GetBattery_Supported_P0},  /*!< Get Battery Capabitity and Status messages supported by PE */
[/#if]
    },
[/#if]

    .CAD_SRCToggleTime = ${valueCAD_SRCToggleTime_P0},                    /* uint8_t CAD_SRCToggleTime; */
    .CAD_SNKToggleTime = ${valueCAD_SNKToggleTime_P0},                    /* uint8_t CAD_SNKToggleTime; */
[/#if]
[#if nbPorts=="2"]
#if USBPD_PORT_COUNT >= 2
  },
  {
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .PE_SupportedSOP = ${valuePE_SupportedSOP_P1}[#rt]
    [#if valuePE_SupportedSOPapos_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPapos_P1}[/#if][#t]
    [#if valuePE_SupportedSOPquot_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquot_P1}[/#if][#t]
    [#if valuePE_SupportedSOPaposDBG_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPaposDBG_P1}[/#if][#t]
    [#if valuePE_SupportedSOPquotDBG_P1!="USBPD_SUPPORTED_SOP_NONE"]|${valuePE_SupportedSOPquotDBG_P1}[/#if], /* Supported SOP : SOP, SOP' SOP" SOP'Debug SOP"Debug      */
    .PE_SpecRevision = ${valuePE_SpecRevision_P1},/* spec revision value                                     */
[/#if]
    .PE_DefaultRole = ${valuePE_DefaultRole_P1},  /* Default port role                                       */
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .PE_RoleSwap = ${valuePE_RoleSwap_P1},                 /* support port role swap                                  */
    .PE_VDMSupport = ${valuePE_VDMSupport_P1},
    .PE_RespondsToDiscovSOP = ${valuePE_RespondsToDiscovSOP_P1},      /*!< Can respond successfully to a Discover Identity */
    .PE_AttemptsDiscovSOP = ${valuePE_AttemptsDiscovSOP_P1},        /*!< Can send a Discover Identity */
    .PE_PingSupport = ${valuePE_PingSupport_P1},              /* support Ping (only for PD3.0)                                     */
    .PE_CapscounterSupport = ${valuePE_CapscounterSupport_P1},       /* support caps counter                                    */
    .CAD_RoleToggle = ${valueCAD_RoleToggle_P1},              /* CAD role toggle                                         */
[/#if]
[#if SRC || DRP]
    .CAD_DefaultResistor = ${valueCAD_DefaultResistor_P1},
[/#if]
[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
    .CAD_TryFeature = ${valueCAD_TryFeature_P1},              /* CAD try feature                                         */
    .CAD_AccesorySupport = ${valueCAD_AccesorySupport_P1},         /* CAD accessory support                                   */
    .PE_PD3_Support.d =                         /*!< PD3 SUPPORT FEATURE                                              */
    {
      .PE_UnchunkSupport                = ${valuePE_UnchunkSupport_P1},  /* support Unchunked mode (valid only spec revision 3.0)   */
      .PE_FastRoleSwapSupport           = ${valuePE_FastRoleSwapSupport_P1},  /* support fast role swap only spec revision 3.0            */
      .Is_GetPPSStatus_Supported        = ${valueIs_GetPPSStatus_Supported_P1},  /*!< PPS message NOT supported by PE stack */
      .Is_SrcCapaExt_Supported          = ${valueIs_SrcCapaExt_Supported_P1},  /*!< Source_Capabilities_Extended message supported or not by DPM */
      .Is_Alert_Supported               = ${valueIs_Alert_Supported_P1},   /*!< Alert message supported or not by DPM */
      .Is_GetStatus_Supported           = ${valueIs_GetStatus_Supported_P1},   /*!< Status message supported or not by DPM (Is_Alert_Supported should be enabled) */
      .Is_GetManufacturerInfo_Supported = ${valueIs_GetManufacturerInfo_Supported_P1},  /*!< Manufacturer_Info message supported or not by DPM */
      .Is_GetCountryCodes_Supported     = ${valueIs_GetCountryCodes_Supported_P1},  /*!< Country_Codes message supported or not by DPM */
      .Is_GetCountryInfo_Supported      = ${valueIs_GetCountryInfo_Supported_P1},  /*!< Country_Info message supported or not by DPM */
      .Is_SecurityRequest_Supported     = ${valueIs_SecurityRequest_Supported_P1},  /*!< Security_Response message supported or not by DPM */
      .Is_FirmUpdateRequest_Supported   = ${valueIs_FirmUpdateRequest_Supported_P1},  /*!< Firmware update response message supported by PE */
[#if BATT_FEATURE]
      .Is_GetBattery_Supported          = ${valueIs_GetBattery_Supported_P1},  /*!< Get Battery Capabitity and Status messages supported by PE */
[/#if]
    },

    .CAD_SRCToggleTime = ${valueCAD_SRCToggleTime_P1},                    /* uint8_t CAD_SRCToggleTime; */
    .CAD_SNKToggleTime = ${valueCAD_SNKToggleTime_P1},                    /* uint8_t CAD_SNKToggleTime; */
[/#if]
#endif
[/#if]
  }
};

[#if USBPD_CoreLib != "USBPDCORE_LIB_NO_PD"]
[#if !GUI_INTERFACE?? || GUI_V1_8_0_OR_NEWER]
USBPD_IdSettingsTypeDef          DPM_ID_Settings[USBPD_PORT_COUNT] =
{
  {
    .XID = USBPD_XID,     /*!< Value provided by the USB-IF assigned to the product   */
    .VID = USBPD_VID,     /*!< Vendor ID (assigned by the USB-IF)                     */
    .PID = USBPD_PID,     /*!< Product ID (assigned by the manufacturer)              */
  },
[#if nbPorts=="2"]
#if USBPD_PORT_COUNT >= 2
  {
    .XID = USBPD_XID,     /*!< Value provided by the USB-IF assigned to the product   */
    .VID = USBPD_VID,     /*!< Vendor ID (assigned by the USB-IF)                     */
    .PID = USBPD_PID,     /*!< Product ID (assigned by the manufacturer)              */
  }
#endif /* USBPD_PORT_COUNT >= 2 */
[/#if]
};

USBPD_USER_SettingsTypeDef       DPM_USER_Settings[USBPD_PORT_COUNT] =
{
  {
    .PE_DataSwap = ${valuePE_DataSwap_P0},                  /* support data swap                                       */
    .PE_VconnSwap = ${valuePE_VconnSwap_P0},                 /* support VCONN swap                                  */
[#if DR_SWAP_TO_XFP_FEATURE]
    .PE_DR_Swap_To_DFP = ${valuePE_DR_Swap_To_DFP_P0},                  /*  Support of DR Swap to DFP                                  */
    .PE_DR_Swap_To_UFP = ${valuePE_DR_Swap_To_UFP_P0},                  /*  Support of DR Swap to UFP                                  */
[/#if]
[#if REV3_SUPPORT]
#if _MANU_INFO
    .DPM_ManuInfoPort =                      /*!< Manufacturer information used for the port            */
    {
      .VID = USBPD_VID,                      /*!< Vendor ID (assigned by the USB-IF)        */
      .PID = USBPD_PID,                      /*!< Product ID (assigned by the manufacturer) */
      .ManuString = "STMicroelectronics",    /*!< Vendor defined byte array                 */
    },
#endif /* _MANU_INFO */
[/#if]
  },
[#if nbPorts=="2"]
#if USBPD_PORT_COUNT >= 2
  {
    .PE_DataSwap = ${valuePE_DataSwap_P1},                  /* support data swap                                       */
    .PE_VconnSwap = ${valuePE_VconnSwap_P0},                /* support VCONN swap                                  */
[#if DR_SWAP_TO_XFP_FEATURE]
    .PE_DR_Swap_To_DFP = ${valuePE_DR_Swap_To_DFP_P1},                  /*  Support of DR Swap to DFP                                  */
    .PE_DR_Swap_To_UFP = ${valuePE_DR_Swap_To_UFP_P1},                  /*  Support of DR Swap to UFP                                  */
[/#if]
[#if REV3_SUPPORT]
#if _MANU_INFO
    .DPM_ManuInfoPort =                      /*!< Manufacturer information used for the port            */
    {
      .VID = USBPD_VID,                      /*!< Vendor ID (assigned by the USB-IF)        */
      .PID = USBPD_PID,                      /*!< Product ID (assigned by the manufacturer) */
      .ManuString = "STMicroelectronics",    /*!< Vendor defined byte array                 */
    },
#endif /* _MANU_INFO */
[/#if]
  }
#endif /* USBPD_PORT_COUNT >= 2 */
[/#if]
};
[/#if]
[/#if]

#endif /* !__USBPD_DPM_CORE_C */

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
