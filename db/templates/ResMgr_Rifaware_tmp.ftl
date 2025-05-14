 [#ftl]
             [#list configs as mxMcuDataModel]
               [#assign index = 0]
               [#assign FeatureIDUIIndex = index][#assign index += 1]
               [#assign mx_RIF_Params = mxMcuDataModel.peripheralRIFParams]
               [#assign RifAwarePrefix = "RIFAware_"]
               [#assign RifAwareIPName=""]
               [#list mx_RIF_Params.entrySet() as RIF_Params]
               	[#if (RIF_Params.key)?? && RIF_Params.key?matches("^"+RifAwarePrefix+".+")]
               		[#compress]
               			[#assign RifAwareIPName=RIF_Params.key?keep_after(RifAwarePrefix)]
               			[#assign RifAwareIPFeatures = RIF_Params.value]
               			[#assign FeatureNamesList=[]]
               			[#assign FeatureIDList=[]]
               				[/#compress]
               		[#list RifAwareIPFeatures.entrySet() as RifAwareIPFeatureList]
               				[#-- Populate FeatureNamesList --]
               				[#assign FeatureNamesList+=[RifAwareIPFeatureList.key]]
               				[#-- Populate FeatureIDList --]
               				[#assign FeatureIDList+=[(RifAwareIPFeatureList.value[FeatureIDUIIndex])?matches("[0-9]\\d{0,9}")?then("("+RifAwareIPFeatureList.value[FeatureIDUIIndex]+")","_"+RifAwareIPFeatureList.value[FeatureIDUIIndex]?substring(0, 3)+"("+RifAwareIPFeatureList.value[FeatureIDUIIndex]?substring(3)+")")]]
               							[#list FeatureNamesList as FeatureName]
                       	                        [#if RifAwareIPName?starts_with("PWR") && !RifAwareIPFeatureList.value[1]?matches("-")]
                                                					[#assign ParamPrefix="_RESOURCE"]
                                                						[#assign RESMGR_IP=RifAwareIPName]
                                                			     	[#assign val= RifAwareIPFeatureList.value[0]]
                                                				[#if  FeatureIDList[FeatureName?index]?contains(val)]

                                                				   #tif (ResMgr_Request(RESMGR_RESOURCE_RIF_${RifAwareIPName}, RESMGR_${RifAwareIPName?upper_case}${ParamPrefix}${FeatureIDList[FeatureName?index]}) != RESMGR_STATUS_ACCESS_OK) /* ${FeatureName} */
                                                				   #t{
                                                                   #t#tError_Handler();
                                                                   #t}
                                                               	[/#if]
                                                [/#if]
                 	                               [#if  RifAwareIPName?starts_with("RTC")   && !RifAwareIPFeatureList.value[1]?matches("-")]
                                                					[#assign ParamPrefix="_RESOURCE"]
                                                						[#assign RESMGR_IP=RifAwareIPName]
                                                			     	[#assign val= RifAwareIPFeatureList.value[0]]
                                                				[#if  FeatureIDList[FeatureName?index]?contains(val) ]

                                                				   #tif (ResMgr_Request(RESMGR_RESOURCE_RIF_${RifAwareIPName}, RESMGR_${RifAwareIPName?upper_case}${ParamPrefix}${FeatureIDList[FeatureName?index]}) != RESMGR_STATUS_ACCESS_OK) /* ${FeatureName} */
                                                				   #t{
                                                                   #t#tError_Handler();
                                                                   #t}
                                                               	[/#if]
                                           [/#if]
                  	                                     [#if  RifAwareIPName?starts_with("FMC")   && !RifAwareIPFeatureList.value[1]?matches("-")]
                                                 					[#assign ParamPrefix="_RESOURCE"]
                                                 						[#assign RESMGR_IP=RifAwareIPName]
                                                 			     	[#assign val= RifAwareIPFeatureList.value[0]]
                                                 				[#if  FeatureIDList[FeatureName?index]?contains(val) &&  FeatureName?contains("FMC")]

                                                 				   #tif (ResMgr_Request(RESMGR_RESOURCE_RIF_${RifAwareIPName}, RESMGR_${RifAwareIPName?upper_case}${ParamPrefix}${FeatureIDList[FeatureName?index]}) != RESMGR_STATUS_ACCESS_OK) /* ${FeatureName} */
                                                 				   #t{
                                                                    #t#tError_Handler();
                                                                    #t}
                                                               	[/#if]
                                                         [/#if]
                               			[/#list]
               		[/#list]
               	[/#if]
               [/#list]
               [/#list]