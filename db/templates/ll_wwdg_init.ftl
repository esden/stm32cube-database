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
        [#assign ewimode = peripheralParams.get(ip).get("EWIMode")]

#t/* Set WWDG Counter */
#tWRITE_REG(WWDG->CR, (WWDG_CR_WDGA | ${counter}));

#t/* Set WWDG EWI, Prescaler and Window */
        [#if ewimode=="WWDG_EWI_ENABLE"]
#tWRITE_REG(WWDG->CFR, (LL_WWDG_CFR_EWI | LL_${prescaler} | ${window}));
        [#else]
#tWRITE_REG(WWDG->CFR, (LL_${prescaler} | ${window}));
        [/#if]
      [/#if]
    [/#if]
  [/#list]
[/#list]
