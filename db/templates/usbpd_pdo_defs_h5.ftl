[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_pdo_defs.h
  * @author  MCD Application Team
  * @brief   Header file for definition of PDO/APDO values for 2 ports(DRP/SNK) configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef __USBPD_PDO_DEF_H_
#define __USBPD_PDO_DEF_H_

#ifdef __cplusplus
 extern "C" {
#endif 

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
			[#if definition.name=="PORT0_UCPD_MODE"]
                [#assign PORT0_UCPD_MODE = definition.value]
            [/#if]
            [#if definition.name=="USBPD_NbPorts"]
                [#assign nbPorts = definition.value]
            [/#if]
            [#if definition.name=="PORT0_NB_SOURCEPDO"]
                [#assign PORT0_NB_SOURCEPDO = definition.value]
            [/#if]
            [#if definition.name=="PORT1_NB_SOURCEPDO"]
                [#assign PORT1_NB_SOURCEPDO = definition.value]
            [/#if]
            [#if definition.name=="PORT0_NB_SINKPDO"]
                [#assign PORT0_NB_SINKPDO = definition.value]
            [/#if]
            [#if definition.name=="PORT1_NB_SINKPDO"]
                [#assign PORT1_NB_SINKPDO = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO1"]
                [#assign PORT0_SOURCE_PDO1 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO2"]
                [#assign PORT0_SOURCE_PDO2 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO3"]
                [#assign PORT0_SOURCE_PDO3 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO4"]
                [#assign PORT0_SOURCE_PDO4 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO5"]
                [#assign PORT0_SOURCE_PDO5 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO6"]
                [#assign PORT0_SOURCE_PDO6 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SOURCE_PDO7"]
                [#assign PORT0_SOURCE_PDO7 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO1"]
                [#assign PORT1_SOURCE_PDO1 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO2"]
                [#assign PORT1_SOURCE_PDO2 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO3"]
                [#assign PORT1_SOURCE_PDO3 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO4"]
                [#assign PORT1_SOURCE_PDO4 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO5"]
                [#assign PORT1_SOURCE_PDO5 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO6"]
                [#assign PORT1_SOURCE_PDO6 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SOURCE_PDO7"]
                [#assign PORT1_SOURCE_PDO7 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO1"]
                [#assign PORT0_SINK_PDO1 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO2"]
                [#assign PORT0_SINK_PDO2 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO3"]
                [#assign PORT0_SINK_PDO3 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO4"]
                [#assign PORT0_SINK_PDO4 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO5"]
                [#assign PORT0_SINK_PDO5 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO6"]
                [#assign PORT0_SINK_PDO6 = definition.value]
            [/#if]
            [#if definition.name=="PORT0_SINK_PDO7"]
                [#assign PORT0_SINK_PDO7 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO1"]
                [#assign PORT1_SINK_PDO1 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO2"]
                [#assign PORT1_SINK_PDO2 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO3"]
                [#assign PORT1_SINK_PDO3 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO4"]
                [#assign PORT1_SINK_PDO4 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO5"]
                [#assign PORT1_SINK_PDO5 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO6"]
                [#assign PORT1_SINK_PDO6 = definition.value]
            [/#if]
            [#if definition.name=="PORT1_SINK_PDO7"]
                [#assign PORT1_SINK_PDO7 = definition.value]
            [/#if]
        [/#list]
    [/#if]
    [#assign instName = SWIP.ipName]
    [#assign fileName = SWIP.fileName]
    [#assign version = SWIP.version]
[/#list]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_NB"]
                    [#assign USBPD_PORT0_PDO_SRC_NB = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_UNCHUNK_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_UNCHUNK_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_DRD_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_DRD_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_USBCOMM_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_USBCOMM_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_EXT_POWER_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_EXT_POWER_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_USBSUSPEND_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_USBSUSPEND_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_DRP_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_DRP_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_NB"]
                    [#assign USBPD_PORT0_PDO_SNK_NB = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_FRS_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_FRS_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_DRD_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_DRD_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_USBCOMM_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_USBCOMM_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_EXT_POWER_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_EXT_POWER_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_HIGHERCAPAB_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_HIGHERCAPAB_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_DRP_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_DRP_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_0"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_0"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_0"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_0"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_0"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_0"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_0"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_0"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_0"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_0 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_1"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_1"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_1"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_1"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_1"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_1"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_1"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_1"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_1"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_1 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_2"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_2"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_2"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_2"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_2"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_2"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_2"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_2"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_2"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_2 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_3"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_3"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_3"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_3"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_3"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_3"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_3"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_3"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_3"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_3 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_4"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_4"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_4"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_4"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_4"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_4"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_4"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_4"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_4"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_4 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_5"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_5"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_5"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_5"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_5"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_5"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_5"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_5"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_5"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_5 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_6"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_6"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_6"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_6"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_6"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_6"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_6"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_6"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_6"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_6 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_TYPE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_TYPE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_7"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_7"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_7"]
                    [#assign USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SRC_WORD_7"]
                    [#assign USBPD_PORT0_PDO_SRC_WORD_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_TYPE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_TYPE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_7"]
                    [#assign USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_PPS_7"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_PPS_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_7"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_7"]
                    [#assign USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_7 = definition.value]
                [/#if]
                [#if definition.name == "USBPD_PORT0_PDO_SNK_WORD_7"]
                    [#assign USBPD_PORT0_PDO_SNK_WORD_7 = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]


/* Includes ------------------------------------------------------------------*/
[#if GUI_INTERFACE??]
#include "main.h"
[/#if]
#include "usbpd_def.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Define   ------------------------------------------------------------------*/
#define PORT0_NB_SOURCEPDO         ${PORT0_NB_SOURCEPDO}U   /* Number of Source PDOs (applicable for port 0)   */
#define PORT0_NB_SINKPDO           ${PORT0_NB_SINKPDO}U   /* Number of Sink PDOs (applicable for port 0)     */
[#if nbPorts=="2"]
#define PORT1_NB_SOURCEPDO         ${PORT1_NB_SOURCEPDO}U   /* Number of Source PDOs (applicable for port 1)   */
#define PORT1_NB_SINKPDO           ${PORT1_NB_SINKPDO}U   /* Number of Sink PDOs (applicable for port 1)     */
[#else]
#define PORT1_NB_SOURCEPDO         0U   /* Number of Source PDOs (applicable for port 1)   */
#define PORT1_NB_SINKPDO           0U   /* Number of Sink PDOs (applicable for port 1)     */
[/#if]

/* USER CODE BEGIN Define */

/* USER CODE END Define */

/* Exported typedef ----------------------------------------------------------*/

/* USER CODE BEGIN typedef */

/**
  * @brief  USBPD Port PDO Structure definition
  *
  */

/* USER CODE END typedef */

/* Exported define -----------------------------------------------------------*/

/* USER CODE BEGIN Exported_Define */

#define USBPD_CORE_PDO_SRC_FIXED_MAX_CURRENT 3
#define USBPD_CORE_PDO_SNK_FIXED_MAX_CURRENT 1500

/* USER CODE END Exported_Define */

/* Exported constants --------------------------------------------------------*/

/* USER CODE BEGIN constants */

/* USER CODE END constants */

/* Exported macro ------------------------------------------------------------*/

/* USER CODE BEGIN macro */

/* USER CODE END macro */

/* Exported variables --------------------------------------------------------*/

/* USER CODE BEGIN variables */

/* USER CODE END variables */

#ifndef __USBPD_PWR_IF_C
[#if GUI_INTERFACE??]
extern uint8_t USBPD_NbPDO[4];
[/#if]
extern uint32_t PORT0_PDO_ListSRC[USBPD_MAX_NB_PDO];
extern uint32_t PORT0_PDO_ListSNK[USBPD_MAX_NB_PDO];
[#if nbPorts=="2"]
extern uint32_t PORT1_PDO_ListSRC[USBPD_MAX_NB_PDO];
extern uint32_t PORT1_PDO_ListSNK[USBPD_MAX_NB_PDO];
[/#if]
#else
[#if GUI_INTERFACE??]
uint8_t USBPD_NbPDO[4] = {(PORT0_NB_SINKPDO),
                          (PORT0_NB_SOURCEPDO)[#rt]
[#if nbPorts=="2"][#lt],
                          (PORT1_NB_SINKPDO),
                          (PORT1_NB_SOURCEPDO)
[/#if][#lt]};
[/#if]
/* Definition of Source PDO for Port 0 */
uint32_t PORT0_PDO_ListSRC[USBPD_MAX_NB_PDO] =
{
[#if ((USBPD_PORT0_PDO_SRC_NB?eval >0) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 1 */
  (
    USBPD_PDO_TYPE_FIXED                 | /* Fixed supply PDO            */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_0}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_0}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_0}          | /* Peak Current info           */
   
    /* Common definitions applicable to all PDOs, defined only in PDO 1 */
    ${USBPD_PORT0_PDO_SRC_FIXED_UNCHUNK_0}      | /* Unchunked Extended Messages */
    ${USBPD_PORT0_PDO_SRC_FIXED_DRD_0}          | /* Dual-Role Data              */
    ${USBPD_PORT0_PDO_SRC_FIXED_USBCOMM_0}      | /* USB Communications          */
    ${USBPD_PORT0_PDO_SRC_FIXED_EXT_POWER_0}    | /* External Power              */
    ${USBPD_PORT0_PDO_SRC_FIXED_USBSUSPEND_0}   | /* USB Suspend Supported		 */
    ${USBPD_PORT0_PDO_SRC_FIXED_DRP_0}            /* Dual-Role Power             */
  ),
[#else]
  /* PDO 1 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SRC_NB?eval > 1) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 2 */
  (
    [#if USBPD_PORT0_PDO_SRC_TYPE_1 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_1}                        | /* Fixed supply                */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_1}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_1}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_1}            /* Peak Current info           */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_1 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_1}                        | /* Battery                */
    
    USBPD_PDO_SRC_BATTERY_SET_MAX_POWER(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_1}U)         | /* Power mW               */
    USBPD_PDO_SRC_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_1}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_1}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_1 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_1}                        | /* Variable Supply                */
    
    USBPD_PDO_SRC_VARIABLE_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_1}U)         | /* Max Current mA           */
    USBPD_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_1}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_1}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SRC_TYPE_1}                             | /* APDO                        */
   
    USBPD_PDO_SRC_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_1}U)       | /* Min voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_1}U)       | /* Max voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_1}U)       | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_1}          /* PPS Power Limited bit       */   
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 2 */ (0x00000000U),
[/#if]

[#if ((USBPD_PORT0_PDO_SRC_NB?eval > 2) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 3 */
  (
    [#if USBPD_PORT0_PDO_SRC_TYPE_2 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_2}                        | /* Fixed supply                */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_2}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_2}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_2}            /* Peak Current info           */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_2 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_2}                        | /* Battery                */
    
    USBPD_PDO_SRC_BATTERY_SET_MAX_POWER(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_2}U)         | /* Power mW               */
    USBPD_PDO_SRC_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_2}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_2}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_2 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_2}                        | /* Variable Supply                */
    
    USBPD_PDO_SRC_VARIABLE_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_2}U)         | /* Max Current mA           */
    USBPD_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_2}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_2}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SRC_TYPE_2}                             | /* APDO                        */
   
    USBPD_PDO_SRC_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_2}U)       | /* Min voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_2}U)       | /* Max voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_2}U)       | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_2}          /* PPS Power Limited bit       */   
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 3 */ (0x00000000U),
[/#if]

[#if ((USBPD_PORT0_PDO_SRC_NB?eval > 3) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 4 */
  (
    [#if USBPD_PORT0_PDO_SRC_TYPE_3 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_3}                        | /* Fixed supply                */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_3}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_3}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_3}            /* Peak Current info           */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_3 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_3}                        | /* Battery                */
    
    USBPD_PDO_SRC_BATTERY_SET_MAX_POWER(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_3}U)         | /* Power mW               */
    USBPD_PDO_SRC_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_3}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_3}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_3 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_3}                        | /* Variable Supply                */
    
    USBPD_PDO_SRC_VARIABLE_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_3}U)         | /* Max Current mA           */
    USBPD_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_3}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_3}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SRC_TYPE_3}                             | /* APDO                        */
   
    USBPD_PDO_SRC_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_3}U)       | /* Min voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_3}U)       | /* Max voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_3}U)       | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_3}          /* PPS Power Limited bit       */   
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 4 */ (0x00000000U),
[/#if]

[#if ((USBPD_PORT0_PDO_SRC_NB?eval > 4) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 5 */
  (
    [#if USBPD_PORT0_PDO_SRC_TYPE_4 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_4}                        | /* Fixed supply                */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_4}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_4}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_4}            /* Peak Current info           */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_4 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_4}                        | /* Battery                */
    
    USBPD_PDO_SRC_BATTERY_SET_MAX_POWER(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_4}U)         | /* Power mW               */
    USBPD_PDO_SRC_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_4}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_4}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_4 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_4}                        | /* Variable Supply                */
    
    USBPD_PDO_SRC_VARIABLE_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_4}U)         | /* Max Current mA           */
    USBPD_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_4}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_4}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SRC_TYPE_4}                             | /* APDO                        */
   
    USBPD_PDO_SRC_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_4}U)       | /* Min voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_4}U)       | /* Max voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_4}U)       | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_4}          /* PPS Power Limited bit       */   
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 5 */ (0x00000000U),
[/#if]

[#if ((USBPD_PORT0_PDO_SRC_NB?eval > 5) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 6 */
  (
    [#if USBPD_PORT0_PDO_SRC_TYPE_5 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_5}                        | /* Fixed supply                */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_5}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_5}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_5}            /* Peak Current info           */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_5 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_5}                        | /* Battery                */
    
    USBPD_PDO_SRC_BATTERY_SET_MAX_POWER(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_5}U)         | /* Power mW               */
    USBPD_PDO_SRC_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_5}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_5}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_5 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_5}                        | /* Variable Supply                */
    
    USBPD_PDO_SRC_VARIABLE_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_5}U)         | /* Max Current mA           */
    USBPD_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_5}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_5}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SRC_TYPE_5}                             | /* APDO                        */
   
    USBPD_PDO_SRC_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_5}U)       | /* Min voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_5}U)       | /* Max voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_5}U)       | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_5}          /* PPS Power Limited bit       */   
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 6 */ (0x00000000U),
[/#if]

[#if ((USBPD_PORT0_PDO_SRC_NB?eval > 6) && (PORT0_UCPD_MODE != "Sink_UCPD1"))]
  /* PDO 7 */
  (
    [#if USBPD_PORT0_PDO_SRC_TYPE_6 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_6}                        | /* Fixed supply                */
    
    USBPD_PDO_SRC_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SRC_FIXED_SET_VOLTAGE_6}U)         | /* Voltage in mV               */
    USBPD_PDO_SRC_FIXED_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_FIXED_SET_MAX_CURRENT_6}U)     | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_FIXED_PEAKCURRENT_6}            /* Peak Current info           */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_6 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_6}                        | /* Battery                */
    
    USBPD_PDO_SRC_BATTERY_SET_MAX_POWER(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_POWER_6}U)         | /* Power mW               */
    USBPD_PDO_SRC_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MAX_VOLTAGE_6}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_BATTERY_SET_MIN_VOLTAGE_6}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_6 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_6}                        | /* Variable Supply                */
    
    USBPD_PDO_SRC_VARIABLE_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_CURRENT_6}U)         | /* Max Current mA           */
    USBPD_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MAX_VOLTAGE_6}U)     | /* Max Voltage mV           */
    USBPD_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_VARIABLE_SET_MIN_VOLTAGE_6}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SRC_TYPE_6}                             | /* APDO                        */
   
    USBPD_PDO_SRC_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MIN_VOLTAGE_6}U)       | /* Min voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_VOLTAGE_6}U)       | /* Max voltage in mV           */
    USBPD_PDO_SRC_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SRC_APDO_SET_MAX_CURRENT_6}U)       | /* Max current in mA           */
    ${USBPD_PORT0_PDO_SRC_APDO_PPS_PWR_LIMITED_6}          /* PPS Power Limited bit       */   
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 7 */ (0x00000000U),
[/#if]

};

/* Definition of Sink PDO for Port 0 */
uint32_t PORT0_PDO_ListSNK[USBPD_MAX_NB_PDO] =
{

[#if ((USBPD_PORT0_PDO_SNK_NB?eval >0) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 1 */
  (
    USBPD_PDO_TYPE_FIXED                 | /* Fixed supply PDO            */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_0}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_0}U)     | /* Operating current in  mA            */
   
    /* Common definitions applicable to all PDOs, defined only in PDO 1 */
    ${USBPD_PORT0_PDO_SNK_FIXED_FRS_0}          | /* Fast Role Swap				 */
    ${USBPD_PORT0_PDO_SNK_FIXED_DRD_0}          | /* Dual-Role Data              */
    ${USBPD_PORT0_PDO_SNK_FIXED_USBCOMM_0}      | /* USB Communications          */
    ${USBPD_PORT0_PDO_SNK_FIXED_EXT_POWER_0}    | /* External Power              */
    ${USBPD_PORT0_PDO_SNK_FIXED_HIGHERCAPAB_0}   | /* Higher Capability           */
    ${USBPD_PORT0_PDO_SNK_FIXED_DRP_0}            /* Dual-Role Power             */
  ),
[#else]
  /* PDO 1 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SNK_NB?eval > 1) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 2 */
  (
    [#if USBPD_PORT0_PDO_SNK_TYPE_1 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SNK_TYPE_1}                        | /* Fixed supply                */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_1}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_1}U)       /* Operating current in  mA            */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_1 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_1}                        | /* Battery                */
    
    USBPD_PDO_SNK_BATTERY_SET_OP_POWER(${USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_1}U)         | /* Power mW               */
    USBPD_PDO_SNK_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_1}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_1}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_1 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_1}                        | /* Variable Supply                */
    
    USBPD_PDO_SNK_VARIABLE_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_1}U)         | /* Max Current mA           */
    USBPD_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_1}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_1}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SNK_TYPE_1}                             | /* APDO                        */
   
    USBPD_PDO_SNK_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_1}U)       | /* Min voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_1}U)       | /* Max voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_1}U)        /* Max current in mA           */
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 2 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SNK_NB?eval > 2) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 3 */
  (
    [#if USBPD_PORT0_PDO_SNK_TYPE_2 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SNK_TYPE_2}                        | /* Fixed supply                */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_2}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_2}U)       /* Operating current in  mA            */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_2 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_2}                        | /* Battery                */
    
    USBPD_PDO_SNK_BATTERY_SET_OP_POWER(${USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_2}U)         | /* Power mW               */
    USBPD_PDO_SNK_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_2}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_2}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_2 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_2}                        | /* Variable Supply                */
    
    USBPD_PDO_SNK_VARIABLE_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_2}U)         | /* Max Current mA           */
    USBPD_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_2}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_2}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SNK_TYPE_2}                             | /* APDO                        */
   
    USBPD_PDO_SNK_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_2}U)       | /* Min voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_2}U)       | /* Max voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_2}U)        /* Max current in mA           */
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 3 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SNK_NB?eval > 3) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 4 */
  (
    [#if USBPD_PORT0_PDO_SNK_TYPE_3 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SNK_TYPE_3}                        | /* Fixed supply                */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_3}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_3}U)       /* Operating current in  mA            */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_3 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_3}                        | /* Battery                */
    
    USBPD_PDO_SNK_BATTERY_SET_OP_POWER(${USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_3}U)         | /* Power mW               */
    USBPD_PDO_SNK_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_3}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_3}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_3 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_3}                        | /* Variable Supply                */
    
    USBPD_PDO_SNK_VARIABLE_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_3}U)         | /* Max Current mA           */
    USBPD_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_3}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_3}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SNK_TYPE_3}                             | /* APDO                        */
   
    USBPD_PDO_SNK_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_3}U)       | /* Min voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_3}U)       | /* Max voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_3}U)        /* Max current in mA           */
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 4 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SNK_NB?eval > 4) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 5 */
  (
    [#if USBPD_PORT0_PDO_SNK_TYPE_4 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SNK_TYPE_4}                        | /* Fixed supply                */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_4}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_4}U)       /* Operating current in  mA            */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_4 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_4}                        | /* Battery                */
    
    USBPD_PDO_SNK_BATTERY_SET_OP_POWER(${USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_4}U)         | /* Power mW               */
    USBPD_PDO_SNK_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_4}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_4}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_4 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_4}                        | /* Variable Supply                */
    
    USBPD_PDO_SNK_VARIABLE_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_4}U)         | /* Max Current mA           */
    USBPD_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_4}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_4}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SNK_TYPE_4}                             | /* APDO                        */
   
    USBPD_PDO_SNK_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_4}U)       | /* Min voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_4}U)       | /* Max voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_4}U)        /* Max current in mA           */
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 5 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SNK_NB?eval > 5) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 6 */
  (
    [#if USBPD_PORT0_PDO_SNK_TYPE_5 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SNK_TYPE_5}                        | /* Fixed supply                */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_5}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_5}U)       /* Operating current in  mA            */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_5 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_5}                        | /* Battery                */
    
    USBPD_PDO_SNK_BATTERY_SET_OP_POWER(${USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_5}U)         | /* Power mW               */
    USBPD_PDO_SNK_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_5}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_5}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_5 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_5}                        | /* Variable Supply                */
    
    USBPD_PDO_SNK_VARIABLE_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_5}U)         | /* Max Current mA           */
    USBPD_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_5}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_5}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SNK_TYPE_5}                             | /* APDO                        */
   
    USBPD_PDO_SNK_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_5}U)       | /* Min voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_5}U)       | /* Max voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_5}U)        /* Max current in mA           */
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 6 */ (0x00000000U),
[/#if]


[#if ((USBPD_PORT0_PDO_SNK_NB?eval > 6) && (PORT0_UCPD_MODE != "Source_UCPD1"))]
  /* PDO 7 */
  (
    [#if USBPD_PORT0_PDO_SNK_TYPE_6 == "USBPD_PDO_TYPE_FIXED"] 
    ${USBPD_PORT0_PDO_SNK_TYPE_6}                        | /* Fixed supply                */
    
    USBPD_PDO_SNK_FIXED_SET_VOLTAGE(${USBPD_PORT0_PDO_SNK_FIXED_SET_VOLTAGE_6}U)         | /* Voltage in mV               */
    USBPD_PDO_SNK_FIXED_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_FIXED_SET_OP_CURRENT_6}U)       /* Operating current in  mA            */
    [#else]
       [#if USBPD_PORT0_PDO_SRC_TYPE_6 == "USBPD_PDO_TYPE_BATTERY"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_6}                        | /* Battery                */
    
    USBPD_PDO_SNK_BATTERY_SET_OP_POWER(${USBPD_PORT0_PDO_SNK_BATTERY_SET_OP_POWER_6}U)         | /* Power mW               */
    USBPD_PDO_SNK_BATTERY_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MAX_VOLTAGE_6}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_BATTERY_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_BATTERY_SET_MIN_VOLTAGE_6}U)            /* Min Voltage mV           */
       [#else]
          [#if USBPD_PORT0_PDO_SRC_TYPE_6 == "USBPD_PDO_TYPE_VARIABLE"] 
    ${USBPD_PORT0_PDO_SRC_TYPE_6}                        | /* Variable Supply                */
    
    USBPD_PDO_SNK_VARIABLE_SET_OP_CURRENT(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_OP_CURRENT_6}U)         | /* Max Current mA           */
    USBPD_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MAX_VOLTAGE_6}U)     | /* Max Voltage mV           */
    USBPD_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_VARIABLE_SET_MIN_VOLTAGE_6}U)            /* Min Voltage mV           */
          [#else]
    ${USBPD_PORT0_PDO_SNK_TYPE_6}                             | /* APDO                        */
   
    USBPD_PDO_SNK_APDO_SET_MIN_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MIN_VOLTAGE_6}U)       | /* Min voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_VOLTAGE(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_VOLTAGE_6}U)       | /* Max voltage in mV           */
    USBPD_PDO_SNK_APDO_SET_MAX_CURRENT(${USBPD_PORT0_PDO_SNK_APDO_SET_MAX_CURRENT_6}U)        /* Max current in mA           */
          [/#if]
       [/#if]
    [/#if]
  ),
[#else]
  /* PDO 7 */ (0x00000000U),
[/#if]
};

[#if nbPorts=="2"]
/* Definition of Source PDO for Port 1 */
uint32_t PORT1_PDO_ListSRC[USBPD_MAX_NB_PDO] =
{
  /* PDO 1 */
        (${PORT1_SOURCE_PDO1}U),
  /* PDO 2 */
        (${PORT1_SOURCE_PDO2}U),
  /* PDO 3 */
        (${PORT1_SOURCE_PDO3}U),
  /* PDO 4 */
        (${PORT1_SOURCE_PDO4}U),
  /* PDO 5 */
        (${PORT1_SOURCE_PDO5}U),
  /* PDO 6 */
        (${PORT1_SOURCE_PDO6}U),
  /* PDO 7 */
        (${PORT1_SOURCE_PDO7}U)
};

/* Definition of Sink PDO for Port 1 */
uint32_t PORT1_PDO_ListSNK[USBPD_MAX_NB_PDO] =
{
  /* PDO 1 */
        (${PORT1_SINK_PDO1}U),
  /* PDO 2 */
        (${PORT1_SINK_PDO2}U),
  /* PDO 3 */
        (${PORT1_SINK_PDO3}U),
  /* PDO 4 */
        (${PORT1_SINK_PDO4}U),
  /* PDO 5 */
        (${PORT1_SINK_PDO5}U),
  /* PDO 6 */
        (${PORT1_SINK_PDO6}U),
  /* PDO 7 */
        (${PORT1_SINK_PDO7}U)
};
[/#if]
#endif

/* Exported functions --------------------------------------------------------*/

/* USER CODE BEGIN functions */

/* USER CODE END functions */

#ifdef __cplusplus
}
#endif

#endif /* __USBPD_PDO_DEF_H_ */