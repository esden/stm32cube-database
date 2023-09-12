[#ftl]
[#compress]
<?xml version="1.0" encoding="UTF-8"?>
[#macro getGroups groupArg]
[#assign grouplibExist = "0"]
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
<ScratchFile FileVersion="${FileVersion}">
<FileVersion>${FileVersion}</FileVersion> [#-- add file version for UC30 --]
<Workspace>
<WorkspaceType>${WorkspaceType}</WorkspaceType>
<WorkspacePath>${WorkspacePath}</WorkspacePath>
<underRoot>${underRoot}</underRoot>
<TrustZone>${TrustZone}</TrustZone>

 [#if Multi_folder == "true"] 
<ProjectStructure>${ProjectStructure}</ProjectStructure>
 [/#if]
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
[#if MultiProject=="0"]
[@generateProject prjSecure="-1"/]
[#else]
[#--[#list ProjectConfigs?keys as configName]--]
[@generateProject  prjSecure="1"/]
[@generateProject  prjSecure="0"/]

[#--[/#list]--]
[/#if]

[#--[/#list]--]
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
[#if dataKey=="memoriesList"]
               [#assign memoriesList =  elem[dataKey]]           
            [/#if]
            [#if dataKey=="CdefinesList"]
               [#assign CdefinesList =  elem[dataKey]]
            [/#if]
            [#if dataKey=="HeapSize"]
               [#assign HeapSize =  elem[dataKey]]
            [/#if]
            [#if dataKey=="StackSize"]
               [#assign StackSize =  elem[dataKey]]
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

    <memories>  [#-- add MemoriesList for UC30 --] 
    [#list memoriesList as memory]
        <memory ${memory} />
    [/#list]
[#if LinkerFilesUpdate??]
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

        </memories>
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
[#if TrustZone == "1" && prj_ctx=="0"]
	<lib>${LinkAdditionalLibs}</lib>
[/#if]
	</LinkAdditionalLibs>
[#if TrustZone == "1" && prj_ctx=="1"]
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
        <define>${define?replace("+", "PLUS")}</define>
            [#assign deflist = deflist + " - " + define]
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
				[#if FilesFromFW??]
                <IDELockFiles>
                    [#list cFileIDEList as cFileIDE]
                        <cFile>${cFileIDE}</cFile>
                    [/#list]
                    [#list hFileIDEList as hFileIDE]
                        <hFile>${hFileIDE}</hFile>
                    [/#list]
                </IDELockFiles>

                <UserLockFiles>
                    <Inc>
                        [#list hFileUserList as hFileUser]
                            <hFile>${hFileUser}</hFile>
                        [/#list]
                    </Inc>
                </UserLockFiles>
				[/#if]
        </ThreadSafeSupport>
    [/#if]

    </config>
[/#macro]

[#-- Marco generateProject --]
[#macro generateProject prjSecure]


[#list ProjectConfigs?keys as configName]
[#assign elem = ProjectConfigs[configName]]
[#if prjSecure=="-1"]
[#assign selectedConfig =  configName]
[/#if]


[#assign ConfigSecure = "-2"]
[#if elem??]
    [#list elem?keys as dataKey]
        [#if dataKey=="Secure" ]
           [#assign ConfigSecure =  elem[dataKey]]
        [/#if]
        [#if dataKey=="cmsisSourceFileNameList"]
               [#assign cmsisSourceFileNameList =  elem[dataKey]]            
        [/#if]   
    [#if MultiProject=="1" && dataKey=="SourceFilesToRemove"]
        [#assign SourceFilesToRemove =  elem[dataKey]]
    [/#if]
    [/#list]
    [#if prjSecure == ConfigSecure && MultiProject=="1"]
        [#assign selectedConfig =  configName]

        [#list elem?keys as dataKey]
            [#if dataKey=="ApplicationGroups"]
               [#assign ApplicationGroups =  elem[dataKey]]
            [/#if]       
            [#if dataKey=="bspComponentGroups"]
               [#assign bspComponentGroups =  elem[dataKey]]
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
            [#--if dataKey=="MiddlewareList"]
               [#assign MiddlewareList =  elem[dataKey]]
            [/#if--] 
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
            [#if dataKey=="HeapSize"]
               [#assign HeapSize =  elem[dataKey]]
            [/#if]
            [#if dataKey=="StackSize"]
               [#assign StackSize =  elem[dataKey]]
            [/#if]
        [/#list]
        [#break]
    [/#if]
[/#if]

[/#list]
<Project>    
[#-- <ProjectPath>${ProjectPath}</ProjectPath>  --][#-- added to give project path --]
    <ProjectName>${projectName}[#if TrustZone=="1"][#if prjSecure=="1"]_S[#else]_NS[/#if][/#if][#if (MultiProject == "1")][#if prjSecure=="1"]_${cpuCore?replace("ARM Cortex-", "C")?replace("+", "PLUS")}[#else]_CM4[/#if][/#if]</ProjectName> [#-- modified to give only the project name without path --]
    <ProjectNature>${ProjectNature}</ProjectNature> [#-- Cpp --]
    [#if CompilerVersionCte??]
    <CompilerVersion>${CompilerVersionCte}</CompilerVersion>
    [/#if]
 [#if TrustZone == "1"]     
<Secure>${prjSecure}</Secure>
[#else]
<Secure/>
 [/#if]
    
  <filestoremove>
        
[#assign listFTR = " "]
[#list SourceFilesToRemove as SourceFile]
        [#if SourceFile!="null" && !listFTR?contains(SourceFile)]
<file>
            <name>${SourceFile}</name>
 </file>
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
[#-- [#list SourceEntryToRemove as SourceEntry]--]
        [#-- [#if SourceEntry!="null"]--]
 [#-- [/#if]--]
[#-- [/#list]--]
</sourceEntry>
</sourceEntriesToRemove>
[/#if]
    <configs>
[#if ProjectConfigs?size > 1]
[#list ProjectConfigs?keys as configName]
[#assign elemConfig = ProjectConfigs[configName] ]
        [#list elemConfig?keys as dataKey]
            [#if dataKey=="Secure"]
               [#assign Secure =  elemConfig[dataKey]]
            [/#if]
        [/#list]
[#if prjSecure=Secure]
[@generateConfig multiConfig="true" elem=ProjectConfigs[configName]/]
[/#if]
[/#list]
[#else]
[@generateConfig multiConfig="false" elem=""/]
[/#if]
        </configs> 

   [#--  <underRoot>${underRoot}</underRoot>--]
<copyAsReference>${copyAsReference}</copyAsReference>
[#if underRoot == "true"]
    
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
                    [#if (TrustZone == "0") || (MultiProject == "1" && configName==selectedConfig)]                   
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
                            [#if dataKey=="GFXSource"]
                            <sourceEntry>
                            <name>${elem[dataKey]}</name>
                            </sourceEntry>            
                            [/#if]                    
                        [/#list] 
                    [/#if]
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
            [#if MultiProject == "0"]
                    <sourceEntry>
                    <name>${Middleware}</name>
                [#if multiConfigurationProject?? && family!="STM32MP1xx" && family!="STM32WLxx"]
                    [#if Middleware?starts_with("CM4")]
                        <excluded>
                            <configuration>${Configuration}_CM7</configuration>
                        </excluded>
                    [/#if]
                    [#if Middleware?starts_with("CM7")]
                        <excluded>
                            <configuration>${Configuration}_CM4</configuration>
                        </excluded>
                    [/#if]
                [/#if]
                    </sourceEntry>
            [#else] [#-- trustzone == 1 --]
                [#if Middleware?starts_with("Secure") && prjSecure=="1"]
                    <sourceEntry>
                            <name>${Middleware}</name>
                    </sourceEntry>
                [/#if]
                [#if Middleware?starts_with("NonSecure") && prjSecure=="0"]
                    <sourceEntry>
                            <name>${Middleware}</name>
                    </sourceEntry>
                [/#if]
            [/#if]
        [/#list]
        [/#if]
	[#-- MZA Bug41441 --]			
	[#--if atLeastOneCmsisPackIsUsed]
            <sourceEntry>
            <name>Packs</name>
            </sourceEntry>
	[/#if--]
        [#if ResMgr_Utility?? || UtilitiesGroup??]
            <sourceEntry>
                <name>Utilities</name>
            </sourceEntry>
        [/#if]

        [#if ThirdPartyPackList??]
            [#list  ThirdPartyPackList as pack]
[#if pack !=  ""]
        <sourceEntry>
            <name>${pack}</name>
            </sourceEntry>
[/#if]
            [/#list]
        [/#if]
                </sourceEntries>
<Groups>
        [#if atLeastOneMiddlewareIsUsed]

    <group>
        <name>Middlewares</name>  
            [#list groups as group]
                [#if group.name!="App" && group.name!="Target" && group.name!="target"]
        <group>
            <name>${group.name!''}</name>
                    [#if group.sourceFilesNameList??]
                        [#list group.sourceFilesNameList as filesName]
                            [#-- selectedConfig --]
                            [#assign removeFromConfig = "0"]
                            [#if multiConfigurationProject?? && ConfigsAndFiles??  && (MultiProject=="1")]
                                [#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                                                [#assign removeFromConfig = "1"]
                                [/#if]
                            [/#if]
[#if removeFromConfig == "0"]
            <file>
                <name>${filesName!''}</name>
[#if multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\")) && MultiProject=="0"]
                <excluded>
                    <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                    </excluded>
[/#if]
[/#list]
[/#if]
                </file>
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
[#if multiConfigurationProject?? && ConfigsAndFiles?? && (MultiProject=="1")]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
                <file>
                    <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\")) && MultiProject=="0"]
                    <excluded>
                        <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                        </excluded>
[/#if]
[/#list]
[/#if]
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
        [/#if]
        [#list externalGroups as grp] 
            [@getGroups groupArg=grp/]
        [/#list]
    <group>
        <name>Drivers</name> 
         
        [#if atLeastDeviceDriverIsUsed]
        <group>					
            [#if deviceDriverGroups??]	
            	[#list deviceDriverGroups as grp]
            		<name>${grp.name!''}</name>
            		[#if grp.sourceFilesNameList??]
        				[#list grp.sourceFilesNameList as filesName]	
        				<file>
        					<name>${filesName!''}</name>
        				</file>        					
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
[#-- selectedConfig --]
[#assign removeFromConfig = "0"]
[#assign excludeFromConfig = "0"]
[#if multiConfigurationProject?? && ConfigsAndFiles?? && (MultiProject=="1")]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
            <file>
                <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))  && MultiProject=="0"]

                <excluded>
                    <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                    </excluded>
[/#if]
[/#list]
[/#if]


                </file>
[/#if]
        [/#list]
    [/#if]
            </group>		    
        </group>   
        [#if UtilitiesGroup??]
    <group>
        <name>${UtilitiesGroup.name!''}</name>
            [#if UtilitiesGroup.sourceFilesNameList??]
                [#list UtilitiesGroup.sourceFilesNameList as filesName]
[#-- selectedConfig --]
[#assign removeFromConfig = "0"]
[#if multiConfigurationProject?? && ConfigsAndFiles?? && (MultiProject=="1" )]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
        <file>
            <name>${filesName!''}</name>
                    [#if ConfigsAndFiles??]
[#list ConfigsAndFiles?keys as configKey]
[#if  multiConfigurationProject?? && !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\")) && MultiProject=="0"]
            <excluded>
                <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                </excluded>
[/#if]
[/#list]
[/#if]
            </file>
[/#if]
                [/#list]
            [/#if]
        </group>
        [/#if]
        [#list externalGroups as grp]
            [@getGroups groupArg=grp/]
        [/#list]
 
</Groups>
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
                    [#if dataKey=="GFXSource"]
                    <sourceEntry>
                        <name>${elem[dataKey]}</name>
                    </sourceEntry>            
                    [/#if]                    
                [/#list] 
                [/#if] 
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
        [#if  MultiProject=="1"]    
              <sourceEntry>
                    <name>Middlewares</name> 
                        [#--list usedMWPerCore?keys as mwcore--]
                        [#assign usedMw =  usedMWPerCore[selectedConfig]]
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
                           [#if used==true]
                                [#assign MwRoot =  usedMWandRootFolder[middName]] 
                
                    <file>
                        <name>${MwRoot?replace("Middlewares/","")}</name>                
                    </file>
                                            [/#if]   
                             
                                    [/#list]  
              </sourceEntry>                                       
                    [#--[/#list] --]         
        [#else]
            <sourceEntry>
            <name>Middlewares</name>
            </sourceEntry>
            
        [/#if]       
        [/#if]
        [#list MiddlewareList as Middleware] 
            [#if MultiProject == "0"]
                    <sourceEntry>
                    <name>${Middleware}</name>
                [#if multiConfigurationProject?? && family!="STM32MP1xx"]
                    [#if Middleware?starts_with("CM4")]
                        <excluded>
                            <configuration>${Configuration}_CM7</configuration>
                        </excluded>
                    [/#if]
                    [#if Middleware?starts_with("CM7")]
                        <excluded>
                            <configuration>${Configuration}_CM4</configuration>
                        </excluded>
                    [/#if]
                [/#if]
                    </sourceEntry>
            [#else] [#-- trustzone == 1 --]
                [#if Middleware?starts_with("Secure") && prjSecure=="1"]
                    <sourceEntry>
                            <name>${Middleware}</name>
                    </sourceEntry>
                [/#if]
                [#if Middleware?starts_with("NonSecure") && prjSecure=="0"]
                    <sourceEntry>
                            <name>${Middleware}</name>
                    </sourceEntry>
                [/#if]
            [/#if]
        [/#list]
        [#-- ************************* --]
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
<Groups>
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
    </Groups>
    [/#if]

[/#if] [#-- End if under root --]

[#-- project groups and files --]
[#if underRoot == "false"]
<Groups>
[#-- project groups and files --]
    [#if atLeastOneMiddlewareIsUsed]
[#assign isMWUsed = "false"]
[#list groups as group]
[#-- search atleastoneMW used --]                 
                [#if multiConfigurationProject?? && usedMWPerCore??]                    
                    [#--list usedMWPerCore?keys as mwcore--]
                        [#assign exclude = true]
                        [#assign usedMw =  usedMWPerCore[selectedConfig]]  
                        [#if usedMw?? && usedMw?size>0]  

                            [#assign isMWUsed = "true"]

                        [/#if]                                
                    [#--[/#list] --]
                [/#if]
[/#list]
[#-- End search excluded groups --]
[#if isMWUsed == "true" || MultiProject=="0"]
    <group>
        <name>Middlewares</name> 
        [#assign grpList = []]
        [#list groups as group]
[#-- search excluded groups --] 
                [#assign excludedGroup = "false"]
                [#if multiConfigurationProject?? && usedMWPerCore?? && MultiProject=="0"]                    
                                        [#assign exclude = true]
                                        [#assign usedMw =  usedMWPerCore[selectedConfig]]
                                        [#if usedMw??]  
                                            [#list usedMw as mw][#assign n = group.name]
                                                [#assign used = false]
                                                [#assign mwName= mw?replace("_M7","")?replace("_M4","")]
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
                                        [#if (MultiProject=="1") && exclude] 
                                            [#assign excludedGroup = "true"]
                                        [/#if]                                
                                    
                                [/#if]
[#-- End search excluded groups --]
                    [#if !grpList?seq_contains(group.name) && excludedGroup=="false"]

            [#assign grpList = grpList + [group.name]]
            [#if group.name!="App" && group.name!="Target" && group.name!="target"]
        <group>
            <name>${group.name!''}</name>[#assign nnnnn = group.name]
            [#-- ************************* --]
           [#if  multiConfigurationProject?? && usedMWPerCore?? && MultiProject=="0"]                    
                    [#list usedMWPerCore?keys as mwcore]
                        [#assign exclude = true]
                        [#assign used = false]
                        [#assign usedMw =  usedMWPerCore[mwcore]]
                        [#if usedMw??] 
                            [#list usedMw as mw][#assign n = group.name]
                                [#assign used = false]
                                [#assign mwName= mw?replace("_M7","")?replace("_M7","")]
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
    
                        [#if exclude && MultiProject=="0"]
            <excluded>
                <configuration>${Configuration}_${mwcore?replace("CortexM", "CM")}</configuration>
            </excluded>
                        [/#if]                       
                    [/#list]  
                [/#if]
                [#if group.sourceFilesNameList??]
                    [#list group.sourceFilesNameList as filesName]
[#-- selectedConfig --]
[#assign removeFromConfig = "0"]
[#if multiConfigurationProject?? && ConfigsAndFiles?? && (MultiProject=="1" )]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
            <file>
                <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\")) && MultiProject=="0"]
                    <excluded>
                        <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                        </excluded>
[/#if]
[/#list]
[/#if]
                </file>
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
[#if multiConfigurationProject?? && ConfigsAndFiles?? && (MultiProject=="1")]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
                <file>
                    <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))]
                    <excluded>
                        <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                        </excluded>
[/#if]
[/#list]
[/#if]
                    </file>
[/#if]
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
    [/#if]
    [#list externalGroups as grp]

        [@getGroups groupArg=grp/]
    [/#list]
    <group>
        <name>Drivers</name>         
        [#if atLeastDeviceDriverIsUsed]
        <group>					
            [#if deviceDriverGroups??]	
            	[#list deviceDriverGroups as grp]
            	 <name>${grp.name!''}</name>
            		[#if grp.sourceFilesNameList??]
        				[#list grp.sourceFilesNameList as filesName]
        				<file>	
        					 <name>${filesName!''}</name>
        				</file>        				
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
[#-- selectedConfig --]
[#assign removeFromConfig = "0"]
[#if multiConfigurationProject?? && ConfigsAndFiles?? && (TrustZone=="1" | family!="STM32H7xx")]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
            <file>
                <name>${filesName!''}</name>
[#if  multiConfigurationProject?? && ConfigsAndFiles??]
    [#list ConfigsAndFiles?keys as configKey]
[#if !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))  && MultiProject=="0"]
                <excluded>
                    <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                    </excluded>
[/#if]
[/#list]
[/#if]


                </file>
[/#if]
        [/#list]
    [/#if]
            </group>
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
        </group>   
    [#if UtilitiesGroup??]
    <group>
        <name>${UtilitiesGroup.name!''}</name>
        [#if UtilitiesGroup.sourceFilesNameList??]
            [#list UtilitiesGroup.sourceFilesNameList as filesName]
[#-- selectedConfig --]
[#assign removeFromConfig = "0"]
[#if multiConfigurationProject?? && ConfigsAndFiles??  && (MultiProject=="1")]
[#if !ConfigsAndFiles[selectedConfig]?seq_contains(filesName?replace("/","\\"))]
                [#assign removeFromConfig = "1"]
[/#if]
[/#if]
[#if removeFromConfig == "0"]
        <file>
            <name>${filesName!''}</name>
                                   [#if ConfigsAndFiles??]
[#list ConfigsAndFiles?keys as configKey]
[#if  multiConfigurationProject?? && !ConfigsAndFiles[configKey]?seq_contains(filesName?replace("/","\\"))  && MultiProject=="0"]
            <excluded>
                <configuration>${Configuration}_${configKey?replace("CortexM", "CM")}</configuration>
                </excluded>
[/#if]
[/#list]
[/#if]
            </file>
[/#if]
            [/#list]
        [/#if]
        </group>
    [/#if]
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
</Groups>
[/#if]
</Project>
[/#macro]
