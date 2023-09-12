[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
[#macro getGroups groupArg]
[#assign grouplibExist = "0"]
<group>
    <name>${groupArg.name}</name>
    [#if  multiConfigurationProject?? && groupArg.excludedFrom!=""]
    <excluded>
        <configuration>${Configuration}_C${groupArg.excludedFrom?replace("Config","C")}</configuration>
        </excluded>
        [/#if]

    [#if groupArg.sourceFilesNameList??]
        [#list groupArg.sourceFilesNameList as filesName]
            [#if filesName?ends_with(".a")||filesName?ends_with(".lib")]
                [#assign grouplibExist = "1"]
                [#break]
            [#else]
            [#if underRoot != "true"]
    <file>
        <name>${filesName!''}</name>                    
        </file>
            [/#if]
    [/#if]
        [/#list]
        [#if grouplibExist=="1"]
            [#list groupArg.sourceFilesNameList as filesName]
                [#if filesName?ends_with(".a")||filesName?ends_with(".lib")]
    <file>
        <name>${filesName!''}</name>
    </file>
    [/#if]             
            [/#list]
        [/#if]
    [/#if]
    [#if groupArg.subGroups??]
        [#list groupArg.subGroups as subGrp]
            [@getGroups groupArg=subGrp/]
        [/#list]
    [/#if]
    </group>
[/#macro]
<Project>
    <FileVersion>${FileVersion}</FileVersion> [#-- add file version for UC30 --]


    <ProjectPath>${ProjectPath}</ProjectPath> [#-- added to give project path --]

    <ProjectName>${projectName}</ProjectName> [#-- modified to give only the project name without path --]

    [#-- <ProjectNature>${ProjectNature}</ProjectNature> --][#-- Cpp --]
    <ProjectNature>${ProjectNature}</ProjectNature> [#-- Cpp --]
[#if staticLibraryProject??]<StaticLibraryProject>true</StaticLibraryProject> [#-- Static Library Project --][/#if]
    <HAL_Driver>${HAL_Driver}</HAL_Driver>[#-- modified to give only the hal driver path --]
    <CMSIS>${CMSISPath}</CMSIS> [#-- modified to give only the relatif path to cmsis folder --]

 [#-- list of toolchains to be generated: EWARM,MDK-ARM,TrueSTUDIO,RIDE: This tag can contain one or more than one toolchain: EWARM,MDK-ARM,TrueSTUDIO,RIDE --]

    <Toolchain>${ide}</Toolchain>
[#if ide=="EWARM" || ide=="MDK-ARM"]
    <Toolversion>${Toolversion}</Toolversion>
[/#if]
    <Version>${version}</Version>

    <configs>
[#if ProjectConfigs?size > 1]
[#list ProjectConfigs?keys as configName]
[@generateConfig multiConfig="true" elem=ProjectConfigs[configName]/]
[/#list]
[#else]
[@generateConfig multiConfig="false" elem=""/]
[/#if]
        </configs> 

    <underRoot>${underRoot}</underRoot>
[#if underRoot == "true"]
    <copyAsReference>${copyAsReference}</copyAsReference>
    [#if copyAsReference == "true"]
    <sourceEntries>
        [#if src??]
            [#if !multiConfigurationProject??]
        <sourceEntry>
            <name>${src}</name>
        </sourceEntry>
            [#else]
            [#list ProjectConfigs?keys as configName]
                [#assign elem = ProjectConfigs[configName]]
                [#list elem?keys as dataKey]
                    [#if dataKey=="inc"]
                       [#--<sourceEntry>
                        <name>${elem[dataKey]}</name>
                        </sourceEntry> --]
                    [/#if]
                    [#if dataKey=="src"]
                <sourceEntry>
                    <name>${elem[dataKey]}</name>toto
                    [#if elem[dataKey] == "CM4"]
                    <excluded>
                        <configuration>${Configuration}_CM7</configuration>
                    </excluded>
                    [/#if]
                    [#if elem[dataKey] == "CM7"]
                    <excluded>
                        <configuration>${Configuration}_CM4</configuration>
                    </excluded>
                    [/#if]
                </sourceEntry> 
                    [/#if]                    
                    [#if dataKey=="GFXSource"]
        <sourceEntry>
            <name>${elem[dataKey]}</name>
            </sourceEntry>            
                    [/#if]                    
                [/#list] 
            [/#list]
            [/#if]
        [/#if]
        [#if GFXSource??]
        <sourceEntry>
            <name>${GFXSource}</name>
            </sourceEntry>                
        [/#if]
        [#if common??]
        <sourceEntry>
            <name>${common}</name>
            </sourceEntry> 
         [/#if]
        <sourceEntry>
	<name>${HALDriver}</name>
    	</sourceEntry>
    	[#if atLeastOneMiddlewareIsUsed]                        
            <sourceEntry>
            <name>Middlewares</name>
            </sourceEntry>
            [#list MiddlewareList as Middleware]
                <sourceEntry>
                <name>${Middleware}</name>
                </sourceEntry>
            [/#list]
        [/#if]
	[#-- MZA Bug41441 --]			
	[#if atLeastOneCmsisPackIsUsed]
            <sourceEntry>
            <name>Packs</name>
            </sourceEntry>
	[/#if]
        [#if ResMgr_Utility??]
            <sourceEntry>
                <name>Utilities</name>
            </sourceEntry>
        [/#if]

        [#if ThirdPartyPackList??]
            [#list  ThirdPartyPackList as pack]
        <sourceEntry>
            <name>${pack}</name>
            </sourceEntry>
            [/#list]
        [/#if]
        </sourceEntries>
        [#if atLeastOneMiddlewareIsUsed]
    <group>
        <name>Middlewares</name>  
            [#list groups as group]
                [#if group.name!="App" && group.name!="Target" && group.name!="target"]
        <group>
            <name>${group.name!''}</name>
                    [#if group.sourceFilesNameList??]
                        [#list group.sourceFilesNameList as filesName]
            <file>
                <name>${filesName!''}</name>
[#if multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
                <excluded>
                    <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                    </excluded>
[/#if]
[/#list]
[/#if]
                </file>
                        [/#list]
                    [/#if]
                    [#if group.subGroups??]
                        [#list group.subGroups as sgroup]
                            [#if sgroup.sourceFilesNameList??]
            <group>
                <name>${sgroup.name!''}</name>
                                [#list sgroup.sourceFilesNameList as filesName]
                <file>
                    <name>${filesName!''}</name
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
                    <excluded>
                        <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                        </excluded>
[/#if]
[/#list]
[/#if]
                    </file>
                                [/#list]
                            [/#if]
                </group>
                        [/#list]
                    [/#if]
            </group>
                [/#if]
            [/#list]
        </group> 
        [/#if]
        [#list externalGroups as grp]
            [@getGroups groupArg=grp/]
        [/#list]
    <group>
        <name>Drivers</name> 
        [#if atLeastOneBspComponentIsUsed]
        <group>					
            [#if bspComponentGroups??]						
                 [#list bspComponentGroups as grp]
            <name>${grp.name!''}</name>
                      [#if grp.subGroups??]
                           [#list grp.subGroups as subGrp]	
            <group>
                <name>${subGrp.name!''}</name>
                                [#if subGrp.sourceFilesNameList??]
                                        [#list subGrp.sourceFilesNameList as filesName]
                <file>
                    <name>${filesName!''}</name>
                    </file>
                                        [/#list]
                                [/#if]
                </group>
                           [/#list]	
                      [/#if]
                 [/#list]
            [/#if]						
            </group>
        [/#if]
        <group>
            <name>${HALGroup.name!''}</name>
	[#if HALGroup.sourceFilesNameList??]
            [#list HALGroup.sourceFilesNameList as filesName]
            <file>
                <name>${filesName!''}</name>
                </file>
            [/#list]
	[/#if]
            </group>		    
        </group>   
        [#if UtilitiesGroup??]
    <group>
        <name>${UtilitiesGroup.name!''}</name>
            [#if UtilitiesGroup.sourceFilesNameList??]
                [#list UtilitiesGroup.sourceFilesNameList as filesName]
        <file>
            <name>${filesName!''}</name>
                    [#if ConfigsAndFiles??]
[#list ConfigsAndFiles?keys as configKey]
[#if  multiConfigurationProject?? && !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
            <excluded>
                <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                </excluded>
[/#if]
[/#list]
[/#if]
            </file>
                [/#list]
            [/#if]
        </group>
        [/#if]
        [#list externalGroups as grp]
            [@getGroups groupArg=grp/]
        [/#list]
    [#else] [#-- Copy All/Needed option --]
    <sourceEntries>
        [#--<sourceEntry>
	<name>${inc}</name>
	</sourceEntry>--]
	[#if src??]
            [#if !multiConfigurationProject??]
            <sourceEntry>
            <name>${src}</name>
            </sourceEntry>
            [#else]
            [#list ProjectConfigs?keys as configName]
                [#assign elem = ProjectConfigs[configName]]
                [#list elem?keys as dataKey]
                    [#if dataKey=="inc"]
                       [#--<sourceEntry>
                        <name>${elem[dataKey]}</name>
                        </sourceEntry> --]
                    [/#if]
                    [#if dataKey=="src"]
            <sourceEntry>
            <name>${elem[dataKey]}</name>
                    [#if elem[dataKey] == "CM4"]
                    <excluded>
                        <configuration>${Configuration}_CM7</configuration>
                    </excluded>
                    [/#if]
                    [#if elem[dataKey] == "CM7"]
                    <excluded>
                        <configuration>${Configuration}_CM4</configuration>
                    </excluded>
                    [/#if]
            </sourceEntry> 
                    [/#if]                    
                    [#if dataKey=="GFXSource"]
        <sourceEntry>
            <name>${elem[dataKey]}</name>
            </sourceEntry>            
                    [/#if]                    
                [/#list] 
            [/#list]
            [/#if]
        [/#if]
        [#if GFXSource??]
        <sourceEntry>
            <name>${GFXSource}</name>
            </sourceEntry>                
        [/#if]
        [#if common??]
        <sourceEntry>
            <name>${common}</name>
            </sourceEntry> 
         [/#if]
        <sourceEntry>
            <name>${HALDriver}</name>
           </sourceEntry>        
	[#if atLeastOneMiddlewareIsUsed]   
        [#-- ************************* --]
        [#if  multiConfigurationProject?? && usedMWPerCore??]    
            <sourceEntry>
                   <name>Middlewares</name>   
                        [#list usedMWPerCore?keys as mwcore]
                        [#assign usedMw =  usedMWPerCore[mwcore]]
                        [#list usedMWandRootFolder?keys as middName]
                        [#assign exclude = true]
                        [#assign used = false] 
                                        [#if usedMw??]  
                            [#list usedMw as m]
                                [#if m==middName]
                                                    [#assign used = true]
                                                [/#if]
                                            [/#list]
                                        [/#if]      
                           [#if used==false]
                                [#assign MwRoot =  usedMWandRootFolder[middName]] 
                <file>
                   <name>${MwRoot?replace("Middlewares/","")}</name>                
        <excluded>
            <configuration>${Configuration}_${mwcore?replace("ARM Cortex-", "C")}</configuration>
        </excluded>
               </file>
                                            [/#if]                                
                                    [/#list]  
                                                     
                    [/#list]  
        </sourceEntry>
        [#else]
         <sourceEntry>
            <name>Middlewares</name>
            </sourceEntry>
            [#list MiddlewareList as Middleware]
                <sourceEntry>
                <name>${Middleware}</name>
                </sourceEntry>
            [/#list]   
       [/#if]
    
        [#-- ************************* --]
	[/#if]
        [#if ThirdPartyPackList??]
            [#list ThirdPartyPackList as pack]
        <sourceEntry>
            <name>${pack}</name>
            </sourceEntry>
            [/#list]
        [/#if]
	[#-- MZA Bug41441 --]			
        [#if atLeastOneCmsisPackIsUsed]
        <sourceEntry>
            <name>Packs</name>
            </sourceEntry>
	[/#if]
        [#if ResMgr_Utility??]
        <sourceEntry>
            <name>Utilities</name>
            </sourceEntry>
        [/#if]
        </sourceEntries>
        [#-- add lib path --]        
        [#if atLeastOneMiddlewareIsUsed]
            [#assign libExist = "0"]
            [#list groups as group]
                [#if group.name!="App" && group.name!="Target" ] 
                    [#if group.sourceFilesNameList??]
                        [#list group.sourceFilesNameList as filesName]
                            [#if filesName?ends_with(".a")||filesName?ends_with(".lib")]
                                [#assign libExist = "1"]
                                [#break]
                            [/#if]
                        [/#list]
                    [/#if]
                [/#if]
            [/#list]
            [#if libExist=="1"]
    <group>
        <name>Middlewares</name>
                [#assign grpList =""]
                [#list groups as group]
                    [#if group.name!="App" && group.name!="Target" ]
                    [#if !grpList?contains(group.name)]
                        [#assign grpList =grpList + " - " + group.name]                    
                        [#if group.sourceFilesNameList?? && group.sourceFilesNameList?size>0]
                            [#assign containLib = "0"]
                            [#list group.sourceFilesNameList as filesName]
                                [#if filesName?ends_with(".a")||filesName?ends_with(".lib")]
                                  [#assign containLib = "1"]
                                  [#break]
                                [/#if]
                            [/#list]
                            [#if containLib=="1"]
        <group>
            <name>${group.name!''}</name>

                                [#if multiConfigurationProject?? && usedMWPerCore??]                    
                                    [#list usedMWPerCore?keys as mwcore]
                                        [#assign exclude = true]
                                        [#assign usedMw =  usedMWPerCore[mwcore]]
                                        [#if usedMw??]  
                                            [#list usedMw as mw][#assign n = group.name]
                                                [#assign used = false]
                                                [#assign mwName= mw?replace("_M7","")?replace("_M4","")]
                                                [#if (n?lower_case=="stemwin" || n?lower_case=="touchgfx") && mwName=="GRAPHICS"]
                                                    [#assign used = true]
                                                [/#if]
                                                [#if n?starts_with("USB_DEVICE") && mwName?starts_with("USB_DEVICE")]
                                                    [#assign used = true]
                                                [/#if]
                                                [#if n?starts_with("USB_Host") && mwName?starts_with("USB_HOST")]
                                                    [#assign used = true]
                                                [/#if]
                                                [#if n?starts_with("PDMFilter") && mwName?starts_with("PDM2PCM")]
                                                    [#assign used = true]
                                                [/#if]                                                
                                                [#if (mw?lower_case == n?lower_case) || used]
                                                [#assign exclude = false] 
                                                [/#if]
                                            [/#list]
                                        [/#if]      
                                        [#if exclude] 
            <excluded>
                <configuration>${Configuration}_${mwcore?replace("ARM Cortex-", "C")}</configuration>
                </excluded>
                                        [/#if]                                
                                    [/#list]  
                                [/#if]
                                [#list group.sourceFilesNameList as filesName]
                                    [#if filesName?ends_with(".a")||filesName?ends_with(".lib")]
            <file>
                <name>${filesName!''}</name>                          
                </file>
                                    [/#if]
                                [/#list]
            </group>
                            [/#if]
                        [/#if]
                    [#else]
                    [/#if]
                    [/#if]
                [/#list]
        </group> 
            [/#if]
        [/#if]
    [#list externalGroups as grp]
        [@getGroups groupArg=grp/]
    [/#list]
        [#-- end lib path --]
    [/#if]
[/#if] [#-- End if under root --]

[#-- project groups and files --]
[#if underRoot == "false"]
[#-- project groups and files --]
    [#if atLeastOneMiddlewareIsUsed]
    <group>
        <name>Middlewares</name> 
        [#assign grpList =""]
        [#list groups as group]
         [#if !grpList?contains(group.name)]
                        [#assign grpList =grpList + " - " + group.name]   
            [#if group.name!="App" && group.name!="Target" && group.name!="target"]
        <group>
            <name>${group.name!''}</name>[#assign nnnnn = group.name]
            [#-- ************************* --]
           [#if  multiConfigurationProject?? && usedMWPerCore??]                    
                    [#list usedMWPerCore?keys as mwcore]
                        [#assign exclude = true]
                        [#assign used = false]
                        [#assign usedMw =  usedMWPerCore[mwcore]]
                        [#if usedMw??]  
                            [#list usedMw as mw][#assign n = group.name]
                                [#assign used = false]
                                [#assign mwName= mw?replace("_M7","")?replace("_M7","")]
                                [#if (n?lower_case=="stemwin" || n?lower_case=="touchgfx") && mwName=="GRAPHICS"]
                                    [#assign used = true]
                                [/#if]
                                [#if n?starts_with("USB_Device") && mwName?starts_with("USB_DEVICE")]
                                                    [#assign used = true]
                                                [/#if]
                                                [#if n?starts_with("USB_HOST") && mwName?starts_with("USB_HOST")]
                                                    [#assign used = true]
                                                [/#if]
                                [#if n?starts_with("PDMFilter") && mwName?starts_with("PDM2PCM")]
                                    [#assign used = true]
                                [/#if]                
                                [#if (n?lower_case?starts_with(mw?lower_case)) || used]
                                [#assign exclude = false] 
                                [/#if]
                            [/#list]
                        [/#if]  
    
                        [#if exclude] 
            <excluded>
                <configuration>${Configuration}_${mwcore?replace("ARM Cortex-", "C")}</configuration>
            </excluded>
                        [/#if]                                
                    [/#list]  
                [/#if]
                [#if group.sourceFilesNameList??]
                    [#list group.sourceFilesNameList as filesName]
            <file>
                <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
                    <excluded>
                        <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                        </excluded>
[/#if]
[/#list]
[/#if]
                </file>
		    [/#list]
		[/#if]
		[#if group.subGroups??]
                    [#list group.subGroups as sgroup]
			[#if sgroup.sourceFilesNameList??]
            <group>
                <name>${sgroup.name!''}</name>
			    [#list sgroup.sourceFilesNameList as filesName]
                <file>
                    <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
                    <excluded>
                        <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                        </excluded>
[/#if]
[/#list]
[/#if]
                    </file>
                            [/#list]
                        [/#if]
                </group>
                    [/#list]
                [/#if]
            </group>
            [/#if]
        [#else]
        [/#if]
        [/#list]
        </group> 
    [/#if]
    [#list externalGroups as grp]
        [@getGroups groupArg=grp/]
    [/#list]
    <group>
        <name>Drivers</name> 
    [#if atLeastOneBspComponentIsUsed]
        <group>					
        [#if bspComponentGroups??]						
            [#list bspComponentGroups as grp]
            <name>${grp.name!''}</name>
                [#if grp.subGroups??]
                    [#list grp.subGroups as subGrp]	
            <group>
                <name>${subGrp.name!''}</name>
                        [#if subGrp.sourceFilesNameList??]
                            [#list subGrp.sourceFilesNameList as filesName]
                <file>
                    <name>${filesName!''}</name>
                    </file>
                            [/#list]
                        [/#if]
                </group>
                    [/#list]	
                [/#if]
            [/#list]
        [/#if]						
            </group>
    [/#if]
        <group>
            <name>${HALGroup.name!''}</name>
    [#if HALGroup.sourceFilesNameList??]
        [#list HALGroup.sourceFilesNameList as filesName]
            <file>
                <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
                <excluded>
                    <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                    </excluded>
[/#if]
[/#list]
[/#if]


                </file>
        [/#list]
    [/#if]
            </group>
        <group>
            <name>CMSIS</name>
    [#list cmsisSourceFileNameList as filesName]
            <file>
                <name>${filesName?replace("\\","/")}</name>
                </file>
    [/#list]
            </group>
        </group>   
    [#if UtilitiesGroup??]
    <group>
        <name>${UtilitiesGroup.name!''}</name>
        [#if UtilitiesGroup.sourceFilesNameList??]
            [#list UtilitiesGroup.sourceFilesNameList as filesName]
        <file>
            <name>${filesName!''}</name>
                                   [#if ConfigsAndFiles??]
[#list ConfigsAndFiles?keys as configKey]
[#if  multiConfigurationProject?? && !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
            <excluded>
                <configuration>${Configuration}_${configKey?replace("ARM Cortex-", "C")}</configuration>
                </excluded>
[/#if]
[/#list]
[/#if]
            </file>
            [/#list]
        [/#if]
        </group>
    [/#if]
    <group>
        <name>Application</name>
        <group>
            <name>User</name>
    [#if !multiConfigurationProject??] [#-- if not a multi config project --]
        [#if mxSourceDir?replace("\\","/") == "Core/Src"]
            <group>
                <name>Core</name>  
        [/#if]
        [#list mxSourceFilesNameList as mxCFiles]
            [#if mxCFiles?contains("Src")]
                <file>
                    <name>${mxCFiles}</name>
                    </file>
            [/#if]
        [/#list]
        [#if mxSourceDir?replace("\\","/") == "Core/Src"]
                </group>                  
        [/#if]
    [/#if]
[#-- Other source groups --]  
    [#if USE_Touch_GFX_STACK?? && ide!="MDK-ARM"]
            <group>
                <name>TouchGFX</name>         
                <group>
                    <name>gui</name> 
                    <file></file>
                    </group>
                <group>
                    <name>generated</name>
                    <file></file>
                    </group>
                </group> 
    [/#if]
    [#if USE_Touch_GFX_STACK_M4?? && ide!="MDK-ARM"]
            <group>
                <name>CM4</name> 
                <excluded>
                    <configuration>${Configuration}_CM7</configuration>
                    </excluded>
                <group>
                    <name>TouchGFX</name>         
                    <group>
                        <name>gui</name> 
                        <file></file>
                        </group>
                    <group>
                        <name>generated</name>
                        <file></file>
                        </group>
                    </group> 
                </group>
    [/#if]
     [#if USE_Touch_GFX_STACK_M7?? && ide!="MDK-ARM"]
            <group>
                <name>CM7</name> 
                <excluded>
                    <configuration>${Configuration}_CM4</configuration>
                    </excluded>
                <group>
                    <name>TouchGFX</name>         
                    <group>
                        <name>gui</name> 
                        <file></file>
                        </group>
                    <group>
                        <name>generated</name>
                        <file></file>
                        </group>
                    </group> 
                </group>
    [/#if]

[#-- App Group Case of Graphics--]
    [#list ApplicationGroups as grp]        
    [#if grp.name!="Remoteproc"]
        [@getGroups groupArg=grp/]
    [/#if]
    [/#list]
            </group> 
[#list ApplicationGroups as grp] 
    [#if grp.name=="Remoteproc"]
        <group>
            <name>${grp.name!''}</name>
        [#if grp.sourceFilesNameList??]
            [#list grp.sourceFilesNameList as filesName]
            <file>
                <name>${filesName!''}</name>
                </file>
            [/#list]
        [/#if]
            [#if grp.subGroups??]
                    [#list grp.subGroups as subGrp]	
            <group>
                <name>${subGrp.name!''}</name>
                    [#if subGrp.sourceFilesNameList??]
                            [#list subGrp.sourceFilesNameList as filesName]
                <file>
                    <name>${filesName!''}</name>
                    </file>
                            [/#list]
                    [/#if]
                </group>
                    [/#list]	
            [/#if]
            </group>
    [/#if]
[/#list] 
        </group>
[/#if]

    </Project>

[#macro generateConfig multiConfig elem]
[#if multiConfig == "true"]
    [#if elem??]
        [#list elem?keys as dataKey]
            [#if dataKey=="mxIncludePaths"]
               [#assign mxIncludePaths =  elem[dataKey]]
            [/#if]
            [#if dataKey=="halIncludePaths"]
               [#assign halIncludePaths =  elem[dataKey]]
            [/#if]
            [#if dataKey=="cpuCore" || dataKey=="cpucore"]
               [#assign cpuCore =  elem[dataKey]]            
            [/#if]
            [#if dataKey=="CdefinesList"]
               [#assign CdefinesList =  elem[dataKey]]
            [/#if]
            [#if dataKey=="linkerExtraLibList"]
               [#assign linkerExtraLibList =  elem[dataKey]]
            [/#if]
            [#if dataKey=="bootmode"]
               [#assign bootmode =  elem[dataKey]]
            [/#if]
            [#if dataKey=="mxIncDir"]
               [#assign mxIncDir =  elem[dataKey]]
            [/#if]
        [/#list]   
    [/#if]
[/#if]
<config>
    <name>${Configuration}[#if (multiConfig == "true")]_${cpuCore?replace("ARM Cortex-", "C")}[#else][/#if]</name>	 [#-- project configuration name. Ex: STM32F407_EVAL --]
    <device>${project.deviceId}</device>		 [#--  STM32 selected device. Ex: STM32F407ZE --]
    [#if IdeMode?? || ide=="STM32CubeIDE"]
    <cpucore>${cpuCore}</cpucore>    
    [#else]
    <cpucore>[#if (multiConfig == "true")]${cpuCore?replace("ARM Cortex-", "C")}[#else][/#if]</cpucore>
    [/#if]
    <fpu>${fpu}</fpu>  [#--add FPU for UC30 --]
    [#if !IdeMode?? && (multiConfig == "true")]
    <bootmode>${bootmode}</bootmode>  <!-- for boot mode could be equals to SRAM or FLASH -->
    [/#if]
    <memories>  [#-- add MemoriesList for UC30 --] 
    [#list memoriesList as memory]
        <memory ${memory} />
    [/#list]
        </memories>
    <startup>${startup}</startup> [#-- add relatif startup path needed for UC30 --]     

    <heapSize>${HeapSize}</heapSize>
    <stackSize>${StackSize}</stackSize>

    [#if ide=="EWARM" || ide=="MDK-ARM"]
    <cpuclock>${cpuclock}</cpuclock>
    [/#if]
    [#if boardName != ""]
    <board>${boardName}</board>
    [/#if]

    [#--optional part--]
    [#if usedDebug == "true"]
    <debugprobe>${DebugMode}</debugprobe>
    [/#if]
    [#-- <optimization>${project.compilerOptimization}</optimization> --]
    <optimization>${optimization}</optimization>
[#if !IdeMode??]
    <icfloc>${icfloc}</icfloc>
[/#if]

    <Aincludes>
        [#if usedfreeRTOS=="true" || (multiConfig == "true" && cpuCore=="ARM Cortex-M4" && usedfreeRTOS_M4?? && usedfreeRTOS_M4=="true")|| (multiConfig == "true" && cpuCore=="ARM Cortex-M7" && usedfreeRTOS_M7?? && usedfreeRTOS_M7=="true")]
	   		[#if ide=="EWARM" ]
        <include>$PROJ_DIR$\${RelativePath}[#if mxIncDir??]${mxIncDir}[#else]Inc[/#if]</include>
	   		[#elseif ide=="MDK-ARM" ]
        <include>${RelativePath}[#if mxIncDir??]${mxIncDir}[#else]Inc[/#if]</include>
   			[#elseif ide=="Makefile" ]
        <include>${RelativePath}[#if mxIncDir??]${mxIncDir}[#else]Inc[/#if]</include>
                        [#else]
        <include></include>
                        [/#if]
		[#else]
        <include></include>
    	[/#if]

        </Aincludes>
    <Adefines>
        [#list AdefinesList as define]
        <define>${define}</define>
        [/#list]
        </Adefines>  
    <Cdefines>
        [#assign deflist =""]
	[#list CdefinesList as define]
        [#if !deflist?contains(define)]
        <define>${define}</define>
            [#assign deflist = deflist + " - "]
        [/#if]
        [/#list]
	   [#-- <define>__weak=__attribute__((weak))</define> --]
        </Cdefines>
    <Ldefines>
	[#list LdefinesList as define]
        <define>${define}</define>
        [/#list]
	   [#-- <define>__weak=__attribute__((weak))</define> --]
        </Ldefines>
    [#-- defines to remove --]
    <definestoremove>
        <Adefines>
        [#if aDefineToRemove??]
            [#list aDefineToRemove as defineToRemove]
            <define>${defineToRemove}</define>
            [/#list]
        [/#if]
            </Adefines>
        <Cdefines>
        [#if cDefineToRemove??]
        [#list cDefineToRemove as defineToRemove]
            <define>${defineToRemove}</define>
        [/#list]
        [/#if]
            </Cdefines> 
        <Ldefines>
        [#if lDefineToRemove??]
            [#list lDefineToRemove as defineToRemove]
            <define>${defineToRemove}</define>
            [/#list]
        [/#if]
            </Ldefines> 
        </definestoremove>

    <inctoremove>
        <Aincludes>
            <include></include>
            </Aincludes>
        <Cincludes>
    [#list IncludePathsToRemove as IncludePath]
            <include>${IncludePath}</include>
    [/#list]
            </Cincludes>
        </inctoremove>
    <filestoremove>
        <file>
[#list SourceFilesToRemove as SourceFile]
        [#if SourceFile!="null"]
            <name>${SourceFile}</name>
    [/#if]
[/#list]
            </file>
        </filestoremove>
    [#-- End of optional part--]
    <Cincludes>
	 [#-- required includes for all generated projects --]
        [#list mxIncludePaths as mxIncludePath]
        <include>${mxIncludePath}</include>
        [/#list]     
	[#list halIncludePaths as halIncludePath]
        <include>${halIncludePath}</include>
        [/#list]

        </Cincludes>
    [#-- Linker Extra Lib --]
    [#if linkerExtraLibList??]
    <LinkAdditionalLibs>
        [#list linkerExtraLibList as extraLib]
        <lib>${extraLib}</lib>
        [/#list] 
        </LinkAdditionalLibs>
    [/#if]
    </config>
[/#macro]