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
            [#if definition.name=="USBPD_NbPorts"]
                [#assign nbPorts = definition.value]
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

/* Includes ------------------------------------------------------------------*/

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Define   ------------------------------------------------------------------*/

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
extern const uint32_t PORT0_PDO_ListSRC[USBPD_MAX_NB_PDO];
extern const uint32_t PORT0_PDO_ListSNK[USBPD_MAX_NB_PDO];
extern const uint32_t PORT1_PDO_ListSRC[USBPD_MAX_NB_PDO];
extern const uint32_t PORT1_PDO_ListSNK[USBPD_MAX_NB_PDO];
#else
/* Definition of Source PDO for Port 0 */
const uint32_t PORT0_PDO_ListSRC[USBPD_MAX_NB_PDO] =
{
  /* PDO 1 */
        (${PORT0_SOURCE_PDO1}U),
  /* PDO 2 */
        (${PORT0_SOURCE_PDO2}U),
  /* PDO 3 */
        (${PORT0_SOURCE_PDO3}U),
  /* PDO 4 */
        (${PORT0_SOURCE_PDO4}U),
  /* PDO 5 */
        (${PORT0_SOURCE_PDO5}U),
  /* PDO 6 */
        (${PORT0_SOURCE_PDO6}U),
  /* PDO 7 */
        (${PORT0_SOURCE_PDO7}U)
};

/* Definition of Sink PDO for Port 0 */
const uint32_t PORT0_PDO_ListSNK[USBPD_MAX_NB_PDO] = 
{
  /* PDO 1 */
        (${PORT0_SINK_PDO1}U),
  /* PDO 2 */
        (${PORT0_SINK_PDO2}U),
  /* PDO 3 */
        (${PORT0_SINK_PDO3}U),
  /* PDO 4 */
        (${PORT0_SINK_PDO4}U),
  /* PDO 5 */
        (${PORT0_SINK_PDO5}U),
  /* PDO 6 */
        (${PORT0_SINK_PDO6}U),
  /* PDO 7 */
        (${PORT0_SINK_PDO7}U)
};

[#if nbPorts=="2"]
/* Definition of Source PDO for Port 1 */
const uint32_t PORT1_PDO_ListSRC[USBPD_MAX_NB_PDO] = 
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
const uint32_t PORT1_PDO_ListSNK[USBPD_MAX_NB_PDO] = 
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

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
