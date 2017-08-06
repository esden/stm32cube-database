[#ftl]
/**
 ******************************************************************************
  * File Name          : private_mib.h
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
  
 /******************************************************************************
 * If SNMP_PRIVATE_MIB option is enabled:
 *  - include this lwiprivatemibs.h file that that contains 
 *    a 'struct mib_array_node mib_private' which contains your MIB.
 *  - make sure you have private_mib.h in your include path.
 ******************************************************************************/
  
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]
[#assign use_private_mib = 0]
[#if SWIP.defines??]
	[#list SWIP.defines as definition] 	
		[#if (definition.name == "SNMP_PRIVATE_MIB")]
			[#if definition.value == "1"]
				[#assign use_private_mib = 1]
			[/#if]
		[/#if]
	[/#list]
[/#if]
[/#list]
  
[#if use_private_mib == 1]
/* SNMP_PRIVATE_MIB is enabled => This file is required by LwIP */
/* Warning: The following code is only given as an example */

#ifdef __cplusplus
 extern "C" {
#endif



#n#n/* USER CODE BEGIN 0 */
/* Warning 1: The following code is only given as an example */
/* To use this example code, uncomment it */
/* -------------- EXAMPLE of CODE ------------------------*/
/* Example of user code that can be added and customized in mib2.c */
/*
extern const struct mib_array_node mib_private;
const struct mib_array_node mib_private = {
  &noleafs_get_object_def,
  &noleafs_get_value,
  &noleafs_set_test,
  &noleafs_set_value,
  MIB_NODE_AR,
  3,
  NULL,
  NULL
};
*/
/* -------------- END of EXAMPLE of CODE -----------------*/
/* USER CODE END 0 */

#ifdef __cplusplus
}
#endif
[#else]
/* SNMP_PRIVATE_MIB is disabled => This file is not required by LwIP */
[/#if]

  
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/