[#ftl]
[#compress]
[#assign MultiProject = "0"]
[#if multiConfigurationProject??]
    [#assign MultiProject = "1"]
[/#if]
<?xml version="1.0" encoding="UTF-8"?>
[#macro getGroups groupArg]
[#assign grouplibExist = "0"]
[#if  multiConfigurationProject?? && groupArg.excludedFrom!="" && TrustZone=="1" && groupArg.excludedFrom==selectedConfig]
    
[#else]
<group> 
    <name>${groupArg.name}</name>
    [#if  multiConfigurationProject?? && groupArg.excludedFrom!=""  && MultiProject=="0"]
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
                [#if underRoot != "true" || filesName?starts_with("..") || copyAsReference == "true"]
[#if !isExcludedFromBuild(filesName)]
        <file>
            <name>${filesName!''}</name>                    
        </file>
[/#if]
                [/#if]
            [/#if]
        [/#list]
        [#if grouplibExist=="1"]
            [#list groupArg.sourceFilesNameList as filesName]
                [#if filesName?ends_with(".a")||filesName?ends_with(".lib")]
[#if !isExcludedFromBuild(filesName)]
    <file>
        <name>${filesName!''}</name>
    </file>
[/#if]
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
[/#if]
[/#macro]
<ScratchFile FileVersion="${FileVersion}">
<FileVersion>${FileVersion}</FileVersion> [#-- add file version for UC30 --]
<Workspace>
[#if (IdeMode?? || ide=="STM32CubeIDE") && family=="STM32MP1xx"]
    [#assign WorkspaceType = "Multi-project"]
[/#if]
<WorkspaceType>${WorkspaceType}</WorkspaceType>
<WorkspacePath>${WorkspacePath}</WorkspacePath>
<underRoot>${underRoot}</underRoot>
<TrustZone>${TrustZone}</TrustZone>
<HAL_Driver>${HAL_Driver}</HAL_Driver>[#-- modified to give only the hal driver path --]
<CMSIS>${CMSISPath}</CMSIS> [#-- modified to give only the relatif path to cmsis folder --]
[#-- list of toolchains to be generated: EWARM,MDK-ARM,TrueSTUDIO,RIDE: This tag can contain one or more than one toolchain: EWARM,MDK-ARM,TrueSTUDIO,RIDE --]

    <Toolchain>${ide}</Toolchain>
[#if ide=="EWARM" || ide=="MDK-ARM"]
    <Toolversion>${Toolversion}</Toolversion>
[/#if]
[#if staticLibraryProject??]<StaticLibraryProject>true</StaticLibraryProject> [#-- Static Library Project --][/#if]

    [#--<Version>${version}</Version>--]
<IocFile>${projectName}.ioc</IocFile>
[#if MultiProject=="0" | family=="STM32MP1xx"]
[@generateProject prjSecure="-1" Prjconfig="null" configName=""/]
[#else]
[#list ProjectConfigs?keys as _configName]
[@generateProject  prjSecure="1" Prjconfig=ProjectConfigs[_configName] configName=_configName/]
[#--@generateProject  prjSecure="0"/--]
[/#list]

[#--[/#list]--]
[/#if]
[#if (IdeMode?? || ide=="STM32CubeIDE") && family=="STM32MP1xx"]
<Project>    
    <ProjectName>${projectName}_DTS</ProjectName>
    <ProjectNature>DTS</ProjectNature>
    <DeviceTree>${DeviceTree}</DeviceTree>
    <ManifestVersion>${ManifestVersion}</ManifestVersion>
</Project>
[/#if]
</Workspace>
</ScratchFile>
[/#compress]

[#-- Marco generateConfig --]
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
            [#if dataKey=="Secure"]
               [#assign Secure =  elem[dataKey]]
            [/#if]
            [#if dataKey=="mxIncDir"]
               [#assign mxIncDir =  elem[dataKey]]
            [/#if]
            [#if dataKey=="mainSourceRepo"]
                [#assign mainSourceRepo =  elem[dataKey]]
            [/#if]
            [#if dataKey=="sourceStructure"]
               [#assign sourceStructure =  elem[dataKey]]
            [/#if]
            [#if dataKey=="LinkerFile"]
               [#assign LinkerFile =  elem[dataKey]]
            [/#if]
            [#if dataKey=="HeapSize"]
               [#assign HeapSize =  elem[dataKey]]
            [/#if]
            [#if dataKey=="StackSize"]
               [#assign StackSize =  elem[dataKey]]
            [/#if]
            [#if dataKey=="startup"]
               [#assign startup =  elem[dataKey]]
            [/#if]
            [#if dataKey=="AdefinesList"]
               [#assign AdefinesList =  elem[dataKey]]
            [/#if]
            [#if dataKey=="aDefineToRemove"]
               [#assign aDefineToRemove =  elem[dataKey]]
            [/#if]
            [#if dataKey=="threadsafeCore"]
               [#assign threadsafeCore =  elem[dataKey]]
            [/#if]
        [/#list]   
    [/#if]
[/#if]
<config>
<name>${Configuration}[#if (multiConfig == "true")][#if Secure!="-1"][#if Secure=="1" && family!="STM32WLxx"]_S[/#if][#if Secure=="0" && family!="STM32WLxx"]_NS[/#if][#if Secure=="1" && family=="STM32WLxx"]_${cpuCore?replace("ARM Cortex-", "C")?replace("+", "PLUS")}[#else]_${cpuCore?replace("ARM Cortex-", "C")?replace("+", "PLUS")}[/#if][/#if][/#if]</name>	 [#-- project configuration name. Ex: STM32F407_EVAL --]
<mainSourceRepo>[#if mainSourceRepo??]${mainSourceRepo?replace("+", "PLUS")}[/#if]</mainSourceRepo>   
<sourceStructure>[#if sourceStructure??]${sourceStructure}[/#if]</sourceStructure>
 <device>${project.deviceId}</device>		 [#--  STM32 selected device. Ex: STM32F407ZE --]
    [#if IdeMode?? || ide=="STM32CubeIDE" || family=="STM32MP1xx"]
    <cpucore>${cpuCore}</cpucore>    
    [#else]
    <cpucore>[#if ((multiConfig == "true") && (TrustZone=="0"))|| multiToSingleCore=="true"]${cpuCore?replace("ARM Cortex-", "C")}[#else][/#if]</cpucore>
    [/#if]
    <fpu>${fpu}</fpu>  [#--add FPU for UC30 --]
    [#if !IdeMode?? && (multiConfig == "true")]
    <bootmode>${bootmode}</bootmode>  [#-- for boot mode could be equals to SRAM or FLASH --]
    [/#if]
     [#if TrustZone == "1" && prj_ctx=="1"]
    <ExePath>${ExePath}</ExePath>
    [/#if]
    [#if OutputFilesFormat??]
    <OutputFilesFormat>${OutputFilesFormat}</OutputFilesFormat>
    [/#if]
    [#if ReinitLink??]
    <ReInitLinker>true</ReInitLinker>
    [/#if]
    <memories>  [#-- add MemoriesList for UC30 --] 
    [#list memoriesList as memory]
        <memory ${memory} />
    [/#list]
        </memories>
[#if LinkerFilesUpdate??]
<ForceLinkerUpdate>true</ForceLinkerUpdate> 
<BootPathConfig>
[#------------------------ BootPath Linker Updates ------------------]
    [#list LinkerFilesUpdate?keys as linkerContext]
        [#if (Secure=="1" && linkerContext=="Secure") || (Secure=="0" && linkerContext=="NonSecure")]        
            [#assign ctxData = LinkerFilesUpdate[linkerContext]]
            [#list ctxData?keys as linkerData]
                <linkerSymbol name="${linkerData}" value="${ctxData[linkerData]}" />        
            [/#list]
        [/#if]
    [/#list]    
</BootPathConfig>
[#if ReInitLinkerFile??]
<ReInitLinkerFile>true</ReInitLinkerFile>
[/#if]
[/#if]
[#------------------------ BootPath Linker Updates ------------------]


[#if PostBuildCommand??]
<BuildAction>
[#------------------------ BootPath Linker Updates ------------------]
    [#list PostBuildCommand?keys as postBuildContext]
        [#if (Secure=="1" && postBuildContext=="Secure") || (Secure=="0" && postBuildContext=="NonSecure")]        
            [#assign ctxData = PostBuildCommand[postBuildContext]]
            <PostBuildCmd>${PostBuildCommand[postBuildContext]}</PostBuildCmd>
        [/#if]
    [/#list]
</BuildAction>
[/#if]
[#------------------------ BootPath Linker Updates ------------------]
    <startup>${startup}</startup> [#-- add relatif startup path needed for UC30 --]     
<LinkSettings>
        [#if LinkerFile??]
            [#list LinkerFile as linker]
            <LinkerFile>${linker}</LinkerFile>
            [/#list]
        [/#if]
	[#if !IdeMode??]
        <icfloc>${icfloc}</icfloc>
        [/#if]
	<LinkAdditionalLibs>
[#if TrustZone == "1" &&prj_ctx?? && prj_ctx=="0" && SecureOnly=="0"]
	<lib>${LinkAdditionalLibs}</lib>
[/#if]
	</LinkAdditionalLibs>
[#if TrustZone == "1" && prj_ctx?? && prj_ctx=="1" && SecureOnly=="0"]
	<TrustZoneLibName>${TrustZoneLibName}</TrustZoneLibName>
[/#if]
</LinkSettings>
    <heapSize>${HeapSize}</heapSize>
    <stackSize>${StackSize}</stackSize>

    <cpuclock>${cpuclock}</cpuclock>
 
    [#if boardName != ""]
    <board>${boardName}</board>
    [/#if]

    [#--optional part--]
    [#if usedDebug == "true"]
    <debugprobe>${DebugMode}</debugprobe>
    [/#if]
    [#-- <optimization>${project.compilerOptimization}</optimization> --]
    <optimization>${optimization}</optimization>
    [#if ForceDebugOptimization?? && ide?contains("STM32CubeIDE")]
    <ForceDebugOptimization>true</ForceDebugOptimization>
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
        <define>${define?replace("+","PLUS")}</define>
        [/#list]
        </Adefines>  
    <Cdefines>
        [#assign deflist =""]
	[#list CdefinesList as define]
        [#if !deflist?contains(define)]
        <define>${define?replace("+","PLUS")}</define>
            [#assign deflist = deflist + " - " + define]
        [/#if]
        [/#list]
	   [#-- <define>__weak=__attribute__((weak))</define> --]
        </Cdefines>
    <Ldefines>
	[#list LdefinesList as define]
        <define>${define?replace("+","PLUS")}</define>
        [/#list]
	   [#-- <define>__weak=__attribute__((weak))</define> --]
        </Ldefines>
        <Cincludes>		
	 [#-- required includes for all generated projects --]
        [#list mxIncludePaths as mxIncludePath]		
        <include>${mxIncludePath}</include>
        [/#list]     
	[#list halIncludePaths as halIncludePath]	
        <include>${halIncludePath}</include>
        [/#list]
        </Cincludes>

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
            [#assign def = ""]
            [#list cDefineToRemove as defineToRemove]
                [#if !def?contains(defineToRemove)]
                    <define>${defineToRemove}</define>
                    [#assign def = def + " - " +  defineToRemove]
                [/#if]
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
   
    [#-- End of optional part--]
    
    [#-- Linker Extra Lib --]
    [#if linkerExtraLibList??]
    <LinkAdditionalLibs>
        [#list linkerExtraLibList as extraLib]
        <lib>${extraLib}</lib>
        [/#list] 
        </LinkAdditionalLibs>
    [/#if]


    [#if ThreadSafeSupport?? && ThreadSafeStrategy[threadsafeCore]??]
        <ThreadSafeSupport>
            <ThreadSafeStrategy>${ThreadSafeStrategy[threadsafeCore].getStrategyValue()}</ThreadSafeStrategy>
        </ThreadSafeSupport>
    [/#if]

    </config>
[/#macro]

[#-- Marco generateProject --]
[#macro generateProject prjSecure Prjconfig configName]
[#--list ProjectConfigs?keys as configName--]
[#if configName != ""]
    [#assign elem = Prjconfig]
[/#if]

[#assign ConfigSecure = "-2"]
[#if elem??]
    [#list elem?keys as dataKey]
        [#if dataKey=="Secure"]
           [#assign ConfigSecure =  elem[dataKey]]
        [/#if]
        [#if dataKey=="cmsisSourceFileNameList"]
               [#assign cmsisSourceFileNameList =  elem[dataKey]]            
        [/#if]   
    [#if MultiProject=="1" && dataKey=="SourceFilesToRemove"]
        [#assign SourceFilesToRemove =  elem[dataKey]]
    [/#if]
    [/#list]
    [#--if PrjconfigName == configName && MultiProject=="1"--]
        [#assign selectedConfig =  configName]

        [#list elem?keys as dataKey]
            [#if dataKey=="ApplicationGroups"]            
               [#assign ApplicationGroups =  elem[dataKey]]
            [/#if]       
            [#if dataKey=="AppSourceEntries"]            
               [#assign AppSourceEntries =  elem[dataKey]]
            [/#if]
            [#if dataKey=="cpuCore" || dataKey=="cpucore"]
               [#assign cpuCore =  elem[dataKey]]           
            [/#if]
            [#if dataKey=="memoriesList"]
               [#assign memoriesList =  elem[dataKey]]           
            [/#if] 
            [#if dataKey=="bspComponentGroups"]            
               [#assign bspComponentGroups =  elem[dataKey]]
            [/#if] 
            [#--  BZ 81835 -- --]
            [#if dataKey=="docGroups"]            
               [#assign docGroups =  elem[dataKey]]
            [/#if] 

            [#if dataKey=="atLeastOneBspComponentIsUsed"]
               [#assign atLeastOneBspComponentIsUsed =  elem[dataKey]]
            [/#if]
            [#if dataKey=="deviceDriverGroups"]
               [#assign deviceDriverGroups =  elem[dataKey]]
            [/#if] 
             [#if dataKey=="atLeastDeviceDriverIsUsed"]
               [#assign atLeastDeviceDriverIsUsed =  elem[dataKey]]
            [/#if]              
            [#--if dataKey=="atLeastOneMiddlewareIsUsed"]
               [#assign atLeastOneMiddlewareIsUsed =  elem[dataKey]]
            [/#if--] 
            [#if dataKey=="MiddlewareList"]
               [#assign MiddlewareList =  elem[dataKey]]
            [/#if] 
            [#if dataKey=="externalGroups"]
               [#assign externalGroups =  elem[dataKey]]
            [/#if]
            [#if dataKey=="atLeastOneCmsisPackIsUsed"]
               [#assign atLeastOneCmsisPackIsUsed =  elem[dataKey]]
            [/#if]
            [#if dataKey=="externalGroups"]
               [#assign externalGroups =  elem[dataKey]]
            [/#if]
            [#if dataKey=="ResMgr_Utility"]
               [#assign ResMgr_Utility =  elem[dataKey]]
            [/#if]
            [#if dataKey=="ThirdPartyPackList"]
               [#assign ThirdPartyPackList =  elem[dataKey]]
            [/#if]
            [#if dataKey=="UtilitiesGroup"]
               [#assign UtilitiesGroup =  elem[dataKey]]
            [/#if]
            [#if dataKey=="cmsisSourceFileNameList"]
               [#assign cmsisSourceFileNameList =  elem[dataKey]]               
            [/#if]
            [#if dataKey=="ExePath"]
               [#assign ExePath =  elem[dataKey]]
            [/#if]
            [#if dataKey=="LinkAdditionalLibs"]
               [#assign LinkAdditionalLibs =  elem[dataKey]]
            [/#if]
            [#if dataKey=="TrustZoneLibName"]
               [#assign TrustZoneLibName =  elem[dataKey]]
            [/#if]
            [#if dataKey=="prj_ctx"]
               [#assign prj_ctx =  elem[dataKey]]
            [/#if]            
            [#if dataKey=="localMwDriver"]
               [#assign localMwDriver =  elem[dataKey]]
            [/#if]
[#if dataKey=="AdefinesList"]
               [#assign AdefinesList =  elem[dataKey]]
            [/#if]
[#if dataKey=="aDefineToRemove"]
               [#assign aDefineToRemove =  elem[dataKey]]
            [/#if]
            [#if dataKey=="HeapSize"]
               [#assign HeapSize =  elem[dataKey]]
            [/#if]
            [#if dataKey=="StackSize"]
               [#assign StackSize =  elem[dataKey]]
            [/#if]
            [#if dataKey=="Configuration"]
               [#assign Configuration =  elem[dataKey]]
            [/#if]
            [#if dataKey=="active"]
               [#assign active =  elem[dataKey]]
            [/#if]
        [/#list]
        [#--break--]
    [#--/#if--]
    [/#if]

[#--/#list--]
<Project>    
[#-- <ProjectPath>${ProjectPath}</ProjectPath>  --][#-- added to give project path --]
    <ProjectName>${projectName}[#if TrustZone=="1"][#if ConfigSecure=="1"]_S[#else]_NS[/#if][/#if][#if (MultiProject == "1")][#if MultiProject=="1" && cpuCore??]_${cpuCore?replace("ARM Cortex-", "C")?replace("+", "PLUS")}[#else]_CM4[/#if][/#if]</ProjectName> [#-- modified to give only the project name without path --]
    [#if active?? && !active]
    <Excluded>true</Excluded>
[/#if]
    <ProjectNature>${ProjectNature}</ProjectNature> [#-- Cpp --]
 [#if TrustZone == "1"]     
<Secure>${ConfigSecure}</Secure>
[#else]
<Secure/>
 [/#if]
    
  <filestoremove>
        
[#assign listFTR = " "]
[#list SourceFilesToRemove as SourceFile]
        [#if SourceFile!="null" && !listFTR?contains(SourceFile)]
[#if !isExcludedFromBuild(SourceFile)]
<file>
            <name>${SourceFile}</name>
 </file>
[/#if]
[#assign listFTR = listFTR +" "+ SourceFile]
    [/#if]
[/#list]
           
        </filestoremove>
[#if underRoot == "true"]
<sourceEntriesToRemove>
    <sourceEntry>
    [#if ide=="SW4STM32" &&  family=="STM32MP1xx"]
    <name>Src</name>
    [/#if]
    </sourceEntry>
</sourceEntriesToRemove>
[/#if]
<configs>
    [#if configName != ""]
        [#list Prjconfig?keys as dataKey]
            [#if dataKey=="Secure"]
               [#assign Secure =  Prjconfig[dataKey]]
            [/#if]
        [/#list]
    [@generateConfig multiConfig="true" elem=Prjconfig/]
    [#else]
    [@generateConfig multiConfig="false" elem=Prjconfig/]
    [/#if]

</configs> 

   [#--  <underRoot>${underRoot}</underRoot>--]
<copyAsReference>${copyAsReference}</copyAsReference>
[#if underRoot == "true"]
    [#if copyAsReference == "true"]
    [#-- UnderRoot_AsRefernce.ftl--]
<sourceEntries>
    	[#if src??]
            [#if !multiConfigurationProject??]
                <sourceEntry>
                <name>${src}</name>
                </sourceEntry>
                [#list AppSourceEntries as SrcEntry] [#-- add application Groups --]
                    [#if !SrcEntry?ends_with("FREERTOS")&& !SrcEntry?ends_with("ThreadX")]
            <sourceEntry>
            <name>${SrcEntry}</name>
            </sourceEntry>
                    [/#if]
                [/#list]
            [#else]
                [#list ProjectConfigs?keys as configName]
                    [#assign elem = Prjconfig]
                    [#if (MultiProject == "0") || (MultiProject == "1" && configName==selectedConfig)]
                        [#list elem?keys as dataKey]                    
                            [#if dataKey=="src"]
                            <sourceEntry>
                            <name>${elem[dataKey]}</name>                    
                            </sourceEntry> 
                            [/#if]             
                        [/#list] 
                        [#list AppSourceEntries as SrcEntry]
                            [#if !SrcEntry?ends_with("FREERTOS") && !SrcEntry?ends_with("ThreadX")]
                            <sourceEntry>
                            <name>${SrcEntry}</name>
                            </sourceEntry>
                            [/#if]
                        [/#list]
                    [/#if] 
                [/#list]
            [/#if]
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
            [#if  multiConfigurationProject?? && usedMWPerCore??  && MultiProject=="0"] 
                <sourceEntry>
                    <name>Middlewares</name>                        
                        [#list usedMWandRootFolder?keys as middName]
                            [#assign exclude = true] 
                            [#assign MwRoot =  usedMWandRootFolder[middName]] 
                            <file>
[#if !isExcludedFromBuild(filesName)]
                            [#if MwRoot?ends_with("/")]
                               [#assign MwRoot = MwRoot?keep_before_last("/")]
                            [/#if]
                            [#assign mwpathList = MwRoot?split("/")]
                            <name>${mwpathList[mwpathList?size - 1]}</name>

                            [#list usedMWPerCore?keys as mwcore]
                                [#assign usedMw =  usedMWPerCore[mwcore]]   
                                [#assign used = false] 
                                [#if usedMw??]  
                                    [#list usedMw as m]
                                        [#if m==middName]
                                           [#assign used = true]
                                        [/#if]
                                    [/#list]
                                [/#if]
                                [#if used==false]
                                    <excluded>  
                                    <configuration>${Configuration}_${mwcore?replace("CortexM", "CM")}</configuration>
                                    </excluded>
                                [/#if]
                            [/#list]
                        </file> 
[/#if]
                        [/#list]
                </sourceEntry>
            [#else]                
                [#if  MultiProject=="0" | (MultiProject=="1" && usedMWPerCore[selectedConfig]?size>0)]
                    <sourceEntry>
                       <name>Middlewares</name>
                    </sourceEntry>                   
                [/#if]
            [/#if]
        [#if sourceStructure == "Advanced"]
            [#list MiddlewareList as Middleware] 
                [#if !Middleware?ends_with("FREERTOS") && !Middleware?ends_with("ThreadX") && !AppSourceEntries?seq_contains(Middleware?replace("/","\\")?replace("CM0Plus","CM0PLUS"))]
                    [#if TrustZone == "0"]
                        <sourceEntry>
                        <name>${Middleware}</name>      
                        </sourceEntry>
                    [#else] [#-- trustzone == 1 --]
                        [#if Middleware?starts_with("Secure") && ConfigSecure=="1"]
                            <sourceEntry>
                                    <name>${Middleware}</name>
                            </sourceEntry>
                        [/#if]
                        [#if Middleware?starts_with("NonSecure") && ConfigSecure=="0"]
                            <sourceEntry>
                                    <name>${Middleware}</name>
                            </sourceEntry>
                        [/#if]
                    [/#if]
                [/#if]
            [/#list]
        [/#if]
        [#-- ************************* --]
	[/#if]
        [#if ResMgr_Utility?? || (UtilitiesGroup?? && UtilitiesGroup.sourceFilesNameList?size>0)]
            <sourceEntry>
                <name>Utilities</name>
            </sourceEntry>
        [/#if]
        [#if ThirdPartyPackList??]
            [#list ThirdPartyPackList as pack]
                [#if pack !=  ""]
                    <sourceEntry>
                        <name>${pack}</name>
                        </sourceEntry>
                [/#if]
            [/#list]
        [/#if]
	  
        </sourceEntries>
[#-- Groups definition --]   
<Groups>
[#-- HAL Drivers --]
    [#-- if WorkspaceType=="Multi-project" --]
    <group>
        <name>Drivers</name>          
        [#if atLeastDeviceDriverIsUsed]        
        <group>					
            [#if deviceDriverGroups??]	
            	[#list deviceDriverGroups as grp]
            <name>${grp.name!''}</name>
                    [#if grp.sourceFilesNameList??]
                        [#list grp.sourceFilesNameList as filesName]	
[#if !isExcludedFromBuild(filesName)]
            <file>
        	<name>${filesName!''}</name>
            </file>    
[/#if]    					
                        [/#list]				
                    [/#if]
            	[/#list]
            [/#if]     					
            </group>
        [/#if]
        
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
[#if !isExcludedFromBuild(filesName)]
                        <file>
                            <name>${filesName!''}</name>											
                        </file>
[/#if]
                                    [/#list]
                                [/#if]
                    </group>
                            [/#list]	
                        [/#if]
                    [/#list]
                [/#if]						
            </group>
        [/#if]
        [#if atLeastOneDocIsPresent]		
            <group>					
            [#if docGroups??]						
                [#list docGroups as grp]
                    <name>${grp.name!''}</name>
                    [#if grp.subGroups??]
                       [#list grp.subGroups as subGrp]	
                <group>
                <name>${subGrp.name!''}</name>
                            [#if subGrp.sourceFilesNameList??]
                                [#list subGrp.sourceFilesNameList as filesName]
[#if !isExcludedFromBuild(filesName)]
                    <file>
                        <name>${filesName!''}</name>											
                    </file>
[/#if]
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
                [#-- selectedConfig --]
                [#assign removeFromConfig = "0"]
                [#assign excludeFromConfig = "0"]
                [#if multiConfigurationProject?? && ConfigsAndFiles??]
                    [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                        [#assign removeFromConfig = "1"]
                    [/#if]
                [/#if]
                [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                    <file>
                        <name>${filesName!''}</name>                        
                    </file>
[/#if]
                [/#if]
            [/#list]
        [/#if]
        </group>		    
        </group>   
    [#--/#if--] [#-- if WorkspaceType=="Multi-project" End --]
[#-- HAL Drivers End --]
[#-- MW drivers --]
        [#if atLeastOneMiddlewareIsUsed && (WorkspaceType!="Multi-project" || (family=="STM32MP1xx") || (usedMWPerCore?? && selectedConfig?? && usedMWPerCore[selectedConfig]?size>0))]
            [#--if WorkspaceType=="Multi-project"--]
            <group>
                <name>Middlewares</name> 
                [#--list usedMWPerCore?keys as mwcore--]
                [#if selectedConfig??]
                    [#assign usedMw =  usedMWPerCore[selectedConfig]]
                [#else] [#-- case of MP1 multi-projrct but no slectedConfig --]
                    [#list usedMWPerCore?keys as mwKey]                        
                        [#assign usedMw =  usedMWPerCore[mwKey]]
                    [/#list]
                [/#if]
                [#list usedMWandRootFolder?keys as middName]
                    [#assign exclude = true]
                    [#assign used = false] 
                    [#if usedMw??]  
                        [#list usedMw as m]
                            [#if m==middName]
                                [#assign used = true]
                            [/#if]
                            [#if used==true]
                                [#assign MwRoot =  usedMWandRootFolder[middName]]                 
                                <group>
                                <name>${MwRoot?replace("Middlewares/","")}</name>                                             
                                    [#list groups as group]
                                        [#if (commponentAndGroupName[middName]?? && (group.name==commponentAndGroupName[middName] | group.name==middName))  || WorkspaceType!="Multi-project"]
                                            [#if group.sourceFilesNameList??]
                                                [#list group.sourceFilesNameList as filesName]
                                                    [#-- selectedConfig --]
                                                    [#assign removeFromConfig = "0"]
                                                    [#if multiConfigurationProject?? && ConfigsAndFiles??]
                                                        [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                                        [#assign removeFromConfig = "1"]
                                                        [/#if]
                                                    [/#if]
                                                    [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                                                        <file>
                                                            <name>${filesName!''}</name>                                                            
                                                        </file>
[/#if]
                                                    [/#if]
                                                [/#list]
                                            [/#if]
                                            [#if group.subGroups??]
                                                [#list group.subGroups as sgroup]
                                                    [#if sgroup.sourceFilesNameList??]
                                                        <group>
                                                        <name>${sgroup.name!''}</name>
                                                        [#list sgroup.sourceFilesNameList as filesName]
                                                            [#-- selectedConfig --]
                                                            [#assign removeFromConfig = "0"]
                                                            [#if multiConfigurationProject?? && ConfigsAndFiles?? && TrustZone=="1"]
                                                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                                                [#assign removeFromConfig = "1"]
                                                                [/#if]
                                                            [/#if]
                                                            [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                                                                <file>
                                                                    <name>${filesName!''}</name>                                                                    
                                                                </file>
[/#if]
                                                            [/#if]
                                                        [/#list]
                                                        </group>
                                                    [/#if]
                                                [/#list]
                                            [/#if]
                                        [/#if]
                                    [/#list]   
                                </group>
                            [/#if]    
                            
                        [/#list]
                    [/#if]      
                
                [/#list]            
                </group>
            [#--/#if--]      
        [/#if]
[#-- MW Driver End --]
        [#list externalGroups as grp]
            [@getGroups groupArg=grp/]
        [/#list]
[#-- Utilities Group --]        		
        [#if UtilitiesGroup?? && UtilitiesGroup.sourceFilesNameList?size>0]
            [#--if WorkspaceType=="Multi-project"--]
            <group>
                <name>${UtilitiesGroup.name!''}</name>
                        [#if UtilitiesGroup.sourceFilesNameList??]
                                [#list UtilitiesGroup.sourceFilesNameList as filesName]
                                        [#-- selectedConfig --]
                                        [#assign removeFromConfig = "0"]
                                        [#if ConfigsAndFiles?? && selectedConfig?? && MultiProject=="1"]
                                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                        [#assign removeFromConfig = "1"]
                                                [/#if]
                                        [/#if]
                                        [#if removeFromConfig == "0"]
                <file>
[#if !isExcludedFromBuild(filesName)]
                    <name>${filesName!''}</name>                    
                </file>
[/#if]
                                        [/#if]
                                [/#list]
                        [/#if]
            </group>
            [#-- /#if --]
        [/#if] [#-- End Utilities Group --]
    </Groups>

    [#else] [#-- Copy All/Needed option --]
    <sourceEntries>
       	[#if src??]
            [#if !multiConfigurationProject??]
                [#list AppSourceEntries as SrcEntry] [#-- add application Groups --]
                    [#if !SrcEntry?ends_with("FREERTOS") && !SrcEntry?ends_with("ThreadX")]
            <sourceEntry>
            <name>${SrcEntry}</name>
            </sourceEntry>
                    [/#if]
                [/#list]
            <sourceEntry>
            <name>${src}</name>
            </sourceEntry>
            [#else]
                [#list ProjectConfigs?keys as configName]
                    [#assign elem = Prjconfig]
                    [#if (MultiProject == "0") || (MultiProject == "1" && configName==selectedConfig)]
                    [#list elem?keys as dataKey]
                        [#if dataKey=="inc"]
                           [#--<sourceEntry>
                            <name>${elem[dataKey]}</name>
                            </sourceEntry> --]
                        [/#if]
                        [#if dataKey=="src"]
                        <sourceEntry>
                        <name>${elem[dataKey]}</name>

                        </sourceEntry> 
                        [/#if]                    
                                          
                    [/#list] 
                    [#list AppSourceEntries as SrcEntry]
                        [#if !SrcEntry?ends_with("FREERTOS") && !SrcEntry?ends_with("ThreadX")]
                        <sourceEntry>
                        <name>${SrcEntry}</name>
                        </sourceEntry>
                        [/#if]
                    [/#list]
                    [/#if] 
                [/#list]
            [/#if]
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
       
            [#if  multiConfigurationProject?? && usedMWPerCore??  && MultiProject=="0"]    
                <sourceEntry>
                    <name>Middlewares</name>                        
                [#list usedMWandRootFolder?keys as middName]
                    [#assign exclude = true]

                    [#assign MwRoot =  usedMWandRootFolder[middName]] 
                    <file>
                    <name>${MwRoot?replace("Middlewares/","")}</name>                        
                    [#list usedMWPerCore?keys as mwcore]
                        [#assign usedMw =  usedMWPerCore[mwcore]]   
                        [#assign used = false] 
                        [#if usedMw??]  
                            [#list usedMw as m]
                                [#if m==middName]
                                   [#assign used = true]
                                [/#if]
                            [/#list]
                        [/#if]
                        [#if used==false]
                            <excluded>
                            <configuration>${Configuration}_${mwcore?replace("CortexM", "CM")}</configuration>
                           </excluded>
                        [/#if]
                    [/#list]
                    </file>
                [/#list]
                </sourceEntry>
            [#else]
                [#if  MultiProject=="0" | (MultiProject=="1" && usedMWPerCore[selectedConfig]?size>0 && (!localMwDriver?? ||(localMwDriver?? && localMwDriver=="true")))]    
                    <sourceEntry>
                       <name>Middlewares</name>
                    </sourceEntry>                   
                [/#if]
            [/#if]
        
            [#if ResMgr_Utility?? || (UtilitiesGroup?? && UtilitiesGroup.sourceFilesNameList?size>0)]
                <sourceEntry>
                    <name>Utilities</name>
                </sourceEntry>
            [/#if]
            [#if sourceStructure == "Advanced"]
                [#list MiddlewareList as Middleware] 
                    [#if !Middleware?ends_with("FREERTOS") && !Middleware?ends_with("ThreadX") && !AppSourceEntries?seq_contains(Middleware?replace("/","\\")?replace("CM0Plus","CM0PLUS"))]
                        [#if TrustZone == "0"]
                            <sourceEntry>
                            <name>${Middleware}</name>
                            </sourceEntry>
                        [#else] [#-- trustzone == 1 --]
                            [#if Middleware?starts_with("Secure") && ConfigSecure=="1"]
                                <sourceEntry>
                                        <name>${Middleware}</name>
                                </sourceEntry>
                            [/#if]
                            [#if Middleware?starts_with("NonSecure") && ConfigSecure=="0"]
                                <sourceEntry>
                                        <name>${Middleware}</name>
                                </sourceEntry>
                            [/#if]
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [#-- ************************* --]
	[/#if] [#-- End of at least one mw--]
        [#if ResMgr_Utility?? || (UtilitiesGroup?? && UtilitiesGroup.sourceFilesNameList?size>0)]
            <sourceEntry>
                <name>Utilities</name>
            </sourceEntry>
        [/#if]
        [#if ThirdPartyPackList??]
            [#list ThirdPartyPackList as pack]
                [#if pack !=  ""]
                   [#-- <sourceEntry>
                        <name>${pack}</name>
                        </sourceEntry>--]
                [/#if]
            [/#list]
        [/#if]
	  
        </sourceEntries>

[#-- Groups definition --]   
<Groups>
[#-- HAL Drivers --]
[#if WorkspaceType=="Multi-project"]
<group>
    <name>Drivers</name>          
    [#if atLeastDeviceDriverIsUsed]        
    <group>					
        [#if deviceDriverGroups??]	
            [#list deviceDriverGroups as grp]
        <name>${grp.name!''}</name>
                [#if grp.sourceFilesNameList??]
                    [#list grp.sourceFilesNameList as filesName]
[#if !isExcludedFromBuild(filesName)]	
        <file>
            <name>${filesName!''}</name>
        </file>        			
[/#if]		
                    [/#list]				
                [/#if]
            [/#list]
        [/#if]     					
        </group>
    [/#if]
        
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
[#if !isExcludedFromBuild(filesName)]
                        <file>
                            <name>${filesName!''}</name>											
                        </file>
[/#if]
                                    [/#list]
                                [/#if]
                    </group>
                            [/#list]	
                        [/#if]
                    [/#list]
                [/#if]						
            </group>
        [/#if]
        [#if atLeastOneDocIsPresent]		
            <group>					
            [#if docGroups??]						
                [#list docGroups as grp]
                    <name>${grp.name!''}</name>
                    [#if grp.subGroups??]
                       [#list grp.subGroups as subGrp]	
                <group>
                <name>${subGrp.name!''}</name>
                            [#if subGrp.sourceFilesNameList??]
                                [#list subGrp.sourceFilesNameList as filesName]
[#if !isExcludedFromBuild(filesName)]
                    <file>
                        <name>${filesName!''}</name>											
                    </file>
[/#if]
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
                    [#-- selectedConfig --]
                    [#assign removeFromConfig = "0"]
                    [#assign excludeFromConfig = "0"]
                    [#if multiConfigurationProject?? && ConfigsAndFiles??]
                        [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                            [#assign removeFromConfig = "1"]
                        [/#if]
                    [/#if]
                    [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                        <file>
                            <name>${filesName!''}</name>                        
                        </file>
[/#if]
                    [/#if]
                [/#list]
            [/#if]
        </group>		   
			[#if family!="STM32L5xx" && family!="STM32U5xx" && family!="STM32H5xx" && family!="STM32WBAxx"&& cmsisSourceFileNameList?size>0]
            <group>			
                <name>CMSIS</name>
                [#assign cmsisFilesAdded = ""]
                [#list cmsisSourceFileNameList as filesName]
                   [#if !cmsisFilesAdded?contains(filesName?replace("\\","/"))]
                           <file>
                                       <name>${filesName?replace("\\","/")}</name>
                                       </file>

                       [#assign cmsisFilesAdded = cmsisFilesAdded + " - " + filesName?replace("\\","/")]
                   [/#if]
                [/#list]
            </group>
			[/#if]
        </group>   

[/#if] [#-- if WorkspaceType=="Multi-project" End --]
[#-- HAL Drivers End --]
[#-- MW drivers --]
        [#if atLeastOneMiddlewareIsUsed && (WorkspaceType!="Multi-project" || (family=="STM32MP1xx") || (usedMWPerCore?? && selectedConfig?? && usedMWPerCore[selectedConfig]?size>0))]
            [#if WorkspaceType=="Multi-project"]
            <group>
                <name>Middlewares</name> 
                [#--list usedMWPerCore?keys as mwcore--]
                [#if selectedConfig??]
                    [#assign usedMw =  usedMWPerCore[selectedConfig]]
                [#else] [#-- case of MP1 multi-projrct but no slectedConfig --]
                    [#list usedMWPerCore?keys as mwKey]         
                        [#assign usedMw =  usedMWPerCore[mwKey]]
                    [/#list]
                [/#if]
                [#assign declaredMW = ""]
                [#list usedMWandRootFolder?keys as middName]
                    
                    [#assign exclude = true]                    
                    [#assign used = false] 
                    [#if usedMw??]  
                        [#list usedMw as m]
                            [#if (m==middName)]
                                [#assign used = true]    
                                
                            [/#if]
                            [#assign MwRoot =  usedMWandRootFolder[middName]]  
                            [#if used==true  && !(declaredMW?contains(MwRoot?replace("Middlewares/","")))]
                                [#assign MwRoot =  usedMWandRootFolder[middName]]                 
                                <group>   
                                <name>${MwRoot?replace("Middlewares/","")}</name>                                             
                                    [#list groups as group]
                                        [#if commponentAndGroupName[middName]?? && (group.name==commponentAndGroupName[middName] | group.name==middName)]
                                            [#if group.name?lower_case=="lorawan" || (group.name?lower_case)?starts_with("sigfox") || (group.name?lower_case)?starts_with("subghz")]
                                                <group>
                                                    <name>${group.name}</name>
                                            [/#if]
                                            [#if group.sourceFilesNameList??]
                                                [#list group.sourceFilesNameList as filesName]
                                                    [#-- selectedConfig --]
                                                    [#assign removeFromConfig = "0"]
                                                    [#if multiConfigurationProject?? && ConfigsAndFiles??]
                                                        [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                                        [#assign removeFromConfig = "1"]
                                                        [/#if]
                                                    [/#if]
                                                    [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                                                        <file>
                                                            <name>${filesName!''}</name>                                                            
                                                        </file>
[/#if]
                                                    [/#if]
                                                [/#list]
                                            [/#if]
                                            [#if group.subGroups??]
                                                [#list group.subGroups as sgroup]
                                                    [#if sgroup.sourceFilesNameList??]
                                                        <group>
                                                        <name>${sgroup.name!''}</name>
                                                        [#list sgroup.sourceFilesNameList as filesName]
                                                            [#-- selectedConfig --]
                                                            [#assign removeFromConfig = "0"]
                                                            [#if multiConfigurationProject?? && ConfigsAndFiles??]
                                                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                                                [#assign removeFromConfig = "1"]
                                                                [/#if]
                                                            [/#if]
                                                            [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                                                                <file>
                                                                    <name>${filesName!''}</name>                                                                    
                                                                </file>
[/#if]
                                                            [/#if]
                                                        [/#list]
                                                        </group>
                                                    [/#if]
                                                [/#list]
                                            [/#if]
                                            [#if group.name?lower_case=="lorawan"|| (group.name?lower_case)?starts_with("sigfox")  || (group.name?lower_case)?starts_with("subghz")]
                                                </group>
                                            [/#if]

                                        [/#if]
                                
                                    [/#list]   
                                </group>
                                 [#assign declaredMW = declaredMW + " " + MwRoot?replace("Middlewares/","")]
                            [/#if]  
                               
                        [/#list]
                    [/#if]      
                
                [/#list]            
                </group>
            [/#if]      
        [/#if]
[#-- MW Driver End --]
        [#list externalGroups as grp]
            [@getGroups groupArg=grp/]
        [/#list]
[#-- Utilities Group --]        		
        [#if (UtilitiesGroup?? && UtilitiesGroup.sourceFilesNameList?size>0)]
            [#if WorkspaceType=="Multi-project"]
            <group>
                <name>${UtilitiesGroup.name!''}</name>
                        [#if UtilitiesGroup.sourceFilesNameList??]
                                [#list UtilitiesGroup.sourceFilesNameList as filesName]
                                        [#-- selectedConfig --]
                                        [#assign removeFromConfig = "0"]
                                        [#if ConfigsAndFiles?? && selectedConfig?? && MultiProject=="1"]
                                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                        [#assign removeFromConfig = "1"]
                                                [/#if]
                                        [/#if]
                                        [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                <file>
                    <name>${filesName!''}</name>                    
                </file>
[/#if]
                                        [/#if]
                                [/#list]
                        [/#if]
            </group>
            [/#if]
        [/#if] [#-- End Utilities Group --]
    </Groups>
    [/#if]

[/#if] [#-- End if under root --]

[#-- project groups and files --]
[#if underRoot == "false"]
[#-- NonUnderRoot.ftl --]
[#-- Groups definition --]   

<Groups>
[#-- HAL Drivers --]
[#--if WorkspaceType=="Multi-project"--]
<group>
        <name>Drivers</name>          
        [#if atLeastDeviceDriverIsUsed]        
        <group>					
            [#if deviceDriverGroups??]	
            	[#list deviceDriverGroups as grp]
            <name>${grp.name!''}</name>
                    [#if grp.sourceFilesNameList??]
                        [#list grp.sourceFilesNameList as filesName]	
[#if !isExcludedFromBuild(filesName)]
            <file>
        	<name>${filesName!''}</name>
            </file>        		
[/#if]			
                        [/#list]				
                    [/#if]
            	[/#list]
            [/#if]     					
            </group>
        [/#if]
        
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
[#if !isExcludedFromBuild(filesName)]
                        <file>
                            <name>${filesName!''}</name>											
                        </file>
[/#if]
                                    [/#list]
                                [/#if]
                    </group>
                            [/#list]	
                        [/#if]
                    [/#list]
                [/#if]						
            </group>
        [/#if]
        [#if atLeastOneDocIsPresent]		
            <group>					
            [#if docGroups??]						
                [#list docGroups as grp]
                    <name>${grp.name!''}</name>
                    [#if grp.subGroups??]
                       [#list grp.subGroups as subGrp]	
                <group>
                <name>${subGrp.name!''}</name>
                            [#if subGrp.sourceFilesNameList??]
                                [#list subGrp.sourceFilesNameList as filesName]
[#if !isExcludedFromBuild(filesName)]
                    <file>
                        <name>${filesName!''}</name>											
                    </file>
[/#if]
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
                    [#-- selectedConfig --]
                    [#assign removeFromConfig = "0"]
                    [#assign excludeFromConfig = "0"]
                    [#if multiConfigurationProject?? && ConfigsAndFiles??]
                        [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                            [#assign removeFromConfig = "1"]
                        [/#if]
                    [/#if]
                    [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                        <file>
                            <name>${filesName!''}</name>                        
                        </file>
[/#if]
                    [/#if]
                [/#list]
            [/#if]
        </group>	
            [#if cmsisSourceFileNameList?size>0]
            <group>    
                <name>CMSIS</name>
                [#assign cmsisFilesAdded = ""]
                [#list cmsisSourceFileNameList as filesName]
                   [#if !cmsisFilesAdded?contains(filesName?replace("\\","/"))]
[#if !isExcludedFromBuild(filesName)]
                           <file>
                                       <name>${filesName?replace("\\","/")}</name>
                                       </file>
[/#if]
                       [#assign cmsisFilesAdded = cmsisFilesAdded + " - " + filesName?replace("\\","/")]
                   [/#if]
                [/#list]
            </group>	    
            [/#if]
        </group>   
[#--/#if--] [#-- if WorkspaceType=="Multi-project" End --]
[#-- HAL Drivers End --]
[#-- MW drivers --]
        [#if atLeastOneMiddlewareIsUsed && (WorkspaceType!="Multi-project" || (family=="STM32MP1xx") || (usedMWPerCore?? && selectedConfig?? && usedMWPerCore[selectedConfig]?size>0))]
            [#--if WorkspaceType=="Multi-project"--]
            <group>
                <name>Middlewares</name> 
                [#--list usedMWPerCore?keys as mwcore--]
                [#if selectedConfig??]
                    [#assign usedMw =  usedMWPerCore[selectedConfig]]
                [#else] [#-- case of MP1 multi-projrct but no slectedConfig --]
                    [#list usedMWPerCore?keys as mwKey]                        
                        [#assign usedMw =  usedMWPerCore[mwKey]]
                    [/#list]
                [/#if]
                [#list usedMWandRootFolder?keys as middName]
                    [#assign exclude = true]
                    [#assign used = false] 
                    [#if usedMw??]  
                        [#list usedMw as m]
                            [#if m==middName]
                                [#assign used = true]
                            [#else]
                                [#assign used = false]
                            [/#if]
                            [#if used==true]
                                [#assign MwRoot =  usedMWandRootFolder[middName]]                 
                                <group>
                                [#if MwRoot?ends_with("/")]
                                    [#assign MwRoot = MwRoot?keep_before_last("/")]
                                [/#if]                                
                                [#assign mwpathList = MwRoot?split("/")]
                                <name>${mwpathList[mwpathList?size - 1]}</name>                                      
                                    [#list groups as group]
                                        [#if commponentAndGroupName[middName]?? && (group.name==commponentAndGroupName[middName] | group.name==middName)]
                                            [#if group.name?lower_case=="lorawan" || (group.name?lower_case)?starts_with("sigfox")||(group.name?lower_case)?starts_with("subghz")]
                                                <group>
                                                    <name>${group.name}</name>
                                            [/#if]
                                            [#if group.sourceFilesNameList??]
                                                [#list group.sourceFilesNameList as filesName]
                                                    [#-- selectedConfig --]
                                                    [#assign removeFromConfig = "0"]
                                                    [#if multiConfigurationProject?? && ConfigsAndFiles??]
                                                        [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                                        [#assign removeFromConfig = "1"]
                                                        [/#if]
                                                    [/#if]
                                                    [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                                                        <file>
                                                            <name>${filesName!''}</name>                                                            
                                                        </file>
[/#if]
                                                    [/#if]
                                                [/#list]
                                            [/#if]
                                            [#if group.subGroups??]
                                                [#list group.subGroups as sgroup]
                                                    [#if sgroup.sourceFilesNameList??]
                                                        <group>
                                                        <name>${sgroup.name!''}</name>
                                                        [#list sgroup.sourceFilesNameList as filesName]
                                                            [#-- selectedConfig --]
                                                            [#assign removeFromConfig = "0"]
                                                            [#if multiConfigurationProject?? && ConfigsAndFiles??]
                                                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                                                [#assign removeFromConfig = "1"]
                                                                [/#if]
                                                            [/#if]
                                                            [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                                                                <file>
                                                                    <name>${filesName!''}</name>                                                                    
                                                                </file>
[/#if]
                                                            [/#if]
                                                        [/#list]
                                                        </group>
                                                    [/#if]
                                                [/#list]
                                            [/#if]
                                            [#if group.name?lower_case=="lorawan" ||(group.name?lower_case)?starts_with("sigfox") || (group.name?lower_case)?starts_with("subghz")]
                                                </group>
                                            [/#if]
                                        [/#if]
                                        
                                    [/#list]   
                                </group>
                            [/#if]    
                            
                        [/#list]
                    [/#if]      
                
                [/#list]            
                </group>
            [#-- /#if --]      
        [/#if]
[#-- MW Driver End --]
        [#list externalGroups as grp]
            [@getGroups groupArg=grp/]
        [/#list]
[#-- Utilities Group --]        		
        [#if UtilitiesGroup?? && UtilitiesGroup.sourceFilesNameList?size>0]
            [#-- if WorkspaceType=="Multi-project"--]
            <group>
                <name>${UtilitiesGroup.name!''}</name>
                        [#if UtilitiesGroup.sourceFilesNameList??]
                                [#list UtilitiesGroup.sourceFilesNameList as filesName]
                                        [#-- selectedConfig --]
                                        [#assign removeFromConfig = "0"]
                                        [#if ConfigsAndFiles?? && selectedConfig?? && MultiProject=="1"]
                                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                        [#assign removeFromConfig = "1"]
                                                [/#if]
                                        [/#if]
                                        [#if removeFromConfig == "0"]
[#if !isExcludedFromBuild(filesName)]
                <file>
                    <name>${filesName!''}</name>                    
                </file>
[/#if]
                                        [/#if]
                                [/#list]
                        [/#if]
            </group>
            [#-- /#if --]
        [/#if] [#-- End Utilities Group --]
<group>
        <name>Application</name>
        <group>
            <name>User</name>
    [#if !multiConfigurationProject?? && family!="STM32MP1xx"] [#-- if not a multi config project --] 
        [#if mxSourceDir?replace("\\","/") == "Core/Src"]
            <group>
                <name>Core</name>  
        [/#if]
        [#list mxSourceFilesNameList as mxCFiles]
            [#if mxCFiles?contains("Src")]
[#if !isExcludedFromBuild(mxFiles)]
                <file>
                    <name>${mxCFiles}</name>
                    </file>
[/#if]
            [/#if]
        [/#list]
        [#if mxSourceDir?replace("\\","/") == "Core/Src"]
                </group>                  
        [/#if]
    [/#if]
[#-- Other source groups --]  



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
[#if !isExcludedFromBuild(filesName)]
            <file>
                <name>${filesName!''}</name>
                </file>
[/#if]
            [/#list]
        [/#if]
            [#if grp.subGroups??]
                    [#list grp.subGroups as subGrp]	
            <group>
                <name>${subGrp.name!''}</name>
                    [#if subGrp.sourceFilesNameList??]
                            [#list subGrp.sourceFilesNameList as filesName]
[#if !isExcludedFromBuild(filesName)]
                <file>
                    <name>${filesName!''}</name>
                    </file>
[/#if]
                            [/#list]
                    [/#if]
                </group>
                    [/#list]	
            [/#if]
            </group>
    [/#if]
[/#list] 
        </group>
    </Groups>
[/#if] [#-- End if Non under root --]

</Project>
[/#macro]
[#function isExcludedFromBuild(file)]
[#if excludedFilesFromBuild?? && excludedFilesFromBuild?size>0]
    [#list excludedFilesFromBuild as exFile]
        [#if file?replace("\\","/")?ends_with(exFile)]
        [#return true]
        [/#if]
    [/#list]
[/#if]
[#return false]
[/#function]