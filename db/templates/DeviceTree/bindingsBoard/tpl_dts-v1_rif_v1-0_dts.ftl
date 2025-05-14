
[#ftl]
[#assign supportAhbErrataList =["Risab3","Risab4","Risab5","HPDMA"]]
[#assign IsAhbErrata =false]
// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
/*
 * Copyright (C) ${year}, STMicroelectronics - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */
 [#--RIFSC Config for RISUP and RIMU--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "rifsc") pDtLevel=0 pOrdering=true/]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "risax") pDtLevel=0 pOrdering=true/]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "rif-core") pDtLevel=1 pOrdering=true/]

/* USER CODE BEGIN addons */
/* USER CODE END addons */