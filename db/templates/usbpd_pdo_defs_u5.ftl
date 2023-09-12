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
uint32_t PORT0_PDO_ListSNK[USBPD_MAX_NB_PDO] =
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