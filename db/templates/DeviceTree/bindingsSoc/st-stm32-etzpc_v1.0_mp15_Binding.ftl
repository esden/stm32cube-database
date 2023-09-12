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
	 "adc":[]
	,"crc2":[]
	,"cryp(.+)":[]
	,"dac1":[["DAC"]]
	,"dcmi":[]
	,"ddr":[["DDRCTRL", "DDRPHYC"], ["NS_R S_W"]]
	,"dfsdm":[["DFSDM"]]
	,"dma(\\w)":[]
	,"dmamux1":[["DMAMUX"]]
	,"eth1":[["ETH"]]
	,"fdcan1":[["TT_FDCAN"]]
	,"hdmi_cec":[["CEC"]]
	,"fmc":[]
	,"hash(.+)":[]
	,"i2c(.+)":[]
	,"i2s(.+)":[["SPI$1"]]
	,"iwdg1":[]
	,"lptim(.+)":[]
	,"mdios":[]
	,"quadspi":[["QSPI", "DLYBQ"]]
	,"rng1":[]
	,"rng2":[]
	,"sai(.+)":[]
	,"sdmmc3":[["SDMMC3", "DLYBSD3"]]
	,"spdifrx":[]
	,"spi(.+)":[]
	,"tim((?!(15))(.+))":[]
	,"tim15":[[], ["!Secured"]][#--HW restriction (Wildcat specific): TIM15 cannot be declared Secured--]
	,"uart(.+)":[]
	,"usart(.+)":[]
	,"usb_otg_hs":[["OTG"]]
	,"vrefbuf":[]
	,"wwdg1":[]
}]

[#--Not managed peripheral ids--]
[#assign etzpc_list_notManagedPeriphIds=["SRAMx", "RETRAM", "BKPSRAM"]]
[#t]
[#include "st-stm32-etzpc_v1.0_Binding.ftl"]
[#t]
[#macro bind_etzpc	pElmt pDtLevel]
	[@bind_etzpc_genericBinding  pElmt=pElmt pDtLevel=pDtLevel/]
[/#macro]
