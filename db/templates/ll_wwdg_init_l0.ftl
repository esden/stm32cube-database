[#ftl]
[#list configs as config]
  [#assign peripheralParams = config.peripheralParams]
  [#assign usedIPs = config.usedIPs]

  [#list usedIPs as ip]
    [#if ip=="WWDG"]
      [#if peripheralParams.get(ip)??]

        [#assign counter = peripheralParams.get(ip).get("Counter")]
        [#assign window = peripheralParams.get(ip).get("Window")]
        [#assign prescaler = peripheralParams.get(ip).get("Prescaler")]

#t/* Set WWDG Counter */
#tWRITE_REG(WWDG->CR, (WWDG_CR_WDGA | ${counter}));
#tWRITE_REG(WWDG->CFR, (LL_${prescaler} | ${window}));
      [/#if]
    [/#if]
  [/#list]
[/#list]
