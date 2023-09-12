[#ftl]

[#--ETZPC binding: soc specific binding--]
[#--/////////////--]

[#--Identifiers list of peripherals under ETZPC control.
ETZPC peripheral Ids definitions are part of ETZPC binding, this is why they
are defined in this file.
	*key = MX device name (regexp) - only one regexp group possible corresponding to device index
	*value = [0]: ETZPC Peripheral Ids list - if empty value, keep MX device name
			 [1]: security areas conrols list
				-"areaName": forces the device association to the 1st specified area (so, single area spec expected)
				-"!areaName": forbids the device association to the specified areas - exclusion rule is priority to forcing
NB: if the device name does not match, the device is skipped from ETZPC list. The default HW reset
value will be applied.
--]
[#assign etzpc_map_periphIds={
	 "adc1":[]
	,"adc2":[]
	,"cryp":[]
	,"dcmipp":[]
	,"ddr":[["DDRCTRLPHY"], ["NS_R S_W"]]
	,"eth1":[]
	,"eth2":[]
	,"fmc":[]
	,"hash":[]
	,"i2c([345])":[]
	,"i2s4":[["SPI4"]]
	,"iwdg1":[]
	,"lptim([23])":[]
	,"ltdc":[]
	,"pka":[]
	,"quadspi":[["QSPI"]]
	,"rng":[]
	,"saes":[]
	,"sdmmc([12])":[]
	,"spi([45])":[]
	,"tim(12|13|14|15|16|17)":[]
	,"usart([12])":[]
	,"usb_otg_hs":[["OTG"]]
	,"usbphyc":[["USBPHYCTRL"]]
	,"vrefbuf":[]
}]

[#--Not managed peripheral ids--]
[#assign etzpc_list_notManagedPeriphIds=["SRAMx", "BKPSRAM"]]
[#t]
[#include "st-stm32-etzpc_v1.0_Binding.ftl"]
[#t]
[#macro bind_etzpc	pElmt pDtLevel][#t]
	[@bind_etzpc_genericBinding  pElmt=pElmt pDtLevel=pDtLevel/]
[/#macro]
