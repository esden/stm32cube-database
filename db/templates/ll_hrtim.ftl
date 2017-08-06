[#ftl]
[#list configs as config]
  [#assign peripheralParams = config.peripheralParams]
  [#assign usedIPs = config.usedIPs]
  [#list usedIPs as ip]
    [#if ip=="HRTIM1"]
      [#if peripheralParams.get(ip)??]
        [#assign Timeout = peripheralParams.get(ip).get("Timeout")]
#tuint32_t Timeout = ${Timeout}; /* Timeout Initialization */
      [/#if]
    [/#if]
  [/#list]
[/#list]



