[#ftl]
[#list configs as dt]
[#assign data = dt]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralGPIOParams =dt.peripheralGPIOParams]
[#assign peripheralDMAParams =dt.peripheralDMAParams]
[#assign peripheralNVICParams =dt.peripheralNVICParams]


[#assign usedIPs =dt.usedIPs]

/**
  ******************************************************************************
  * File Name          : 
  * Date               : ${date}
  * Description        :
  ******************************************************************************
**/

/*---------------------------- MCU Configuration data -------------------------*/

/* Mcu characteristics */

/* List of used IPs */
- RCC
[#list usedIPs as ip]
- ${ip} 
[/#list]
#t------------------------------------------------------------------------------ 
#t-                         Clock Configuration data 
#t------------------------------------------------------------------------------ 
[#list peripheralParams.get("RCC").entrySet() as paramEntry]
[#if paramEntry.value??]#t#t- ${paramEntry.key} :  ${paramEntry.value}[/#if]    #t [peripheralParams.get("RCC").get("${paramEntry.key}")]
    [/#list]

[#list usedIPs as ip ] [#-- For each used ip, list all configuration data --]
[#if peripheralParams.get(ip).entrySet()?size>0]
#t------------------------------------------------------------------------------ 
#t-                         ${ip} Configuration data  : Driver type = ${peripheralParams.get(ip).get("driver")}
#t------------------------------------------------------------------------------
[#if peripheralGPIOParams.get(ip)?? && peripheralGPIOParams.get(ip).entrySet()?size>0]
#t#t GPIO configuration 
#t#t-------------------
[#list peripheralGPIOParams.get(ip).entrySet() as gpioparamEntry]
#t#t- ${gpioparamEntry.key} :  
[#list gpioparamEntry.value.entrySet() as gpioparam]
#t#t#t - ${gpioparam.key} : ${gpioparam.value}      #t [peripheralGPIOParams.get("${ip}").get("${gpioparamEntry.key}").value.get("${gpioparam.key}")]
[/#list]
    [/#list]
#n
[/#if]
[#if peripheralParams.get(ip)?? ]
#t#t IP paramters configuration
#t#t---------------------------  
  [#list peripheralParams.get(ip).entrySet() as paramEntry]
[#if paramEntry.value??]#t#t- ${paramEntry.key} :  ${paramEntry.value}[/#if]    #t [peripheralParams.get("${ip}").get("${paramEntry.key}")]
    [/#list]
[/#if]
#n
[#if peripheralDMAParams.get(ip)?? && peripheralDMAParams.get(ip).entrySet()?size>0]
#t#t DMA IP paramters configuration
#t#t---------------------------  
[#list peripheralDMAParams.get(ip).entrySet() as dmaParamEntry]
#t#t- ${dmaParamEntry.key} :  
[#list dmaParamEntry.value.entrySet() as dmaParam]
#t#t#t - ${dmaParam.key} : ${dmaParam.value}      #t [peripheralDMAParams.get("${ip}").get("${dmaParamEntry.key}").value.get("${dmaParam.key}")]
[/#list]
    [/#list]
#n
[/#if]
#n
[#if peripheralNVICParams.get(ip)?? && peripheralNVICParams.get(ip).entrySet()?size>0]
#t#t Interrupt IP paramters configuration
#t#t---------------------------  
[#list peripheralNVICParams.get(ip).entrySet() as nvicParamEntry]
#t#t- ${nvicParamEntry.key} :  
[#list nvicParamEntry.value.entrySet() as nvicParam]
#t#t#t - ${nvicParam.key} : ${nvicParam.value}      #t [peripheralNVICParams.get("${ip}").get("${nvicParamEntry.key}").value.get("${nvicParam.key}")]
[/#list]
    [/#list]
#n
[/#if]

[/#if]
[/#list]


[/#list]