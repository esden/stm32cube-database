[#ftl]

[#--ETZPC binding: soc specific binding--]
[#--/////////////--]

[#--
SP-MIN specific configuration
--]
[#t]
[#include "st-stm32-etzpc_v1.0_mp15_Binding.ftl"]
[#t]
[#assign etzpc_map_periphIds = etzpc_map_periphIds + {"rng1":[[], ["Non Secured"]]} ][#--no service for RNG1 in SP-MIN--]
[#t]
[#include "st-stm32-etzpc_v1.0_Binding.ftl"]
[#t]
[#macro bind_etzpc	pElmt pDtLevel]
	[@bind_etzpc_genericBinding  pElmt=pElmt pDtLevel=pDtLevel/]
[/#macro]
