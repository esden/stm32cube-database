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
[/#if]
[/#macro]
<ScratchFile FileVersion="${FileVersion}">
<FileVersion>${FileVersion}</FileVersion> [#-- add file version for UC30 --]
<Workspace>

<WorkspaceType>Single-project</WorkspaceType>
<WorkspacePath>${WorkspacePath}</WorkspacePath>
<underRoot>${underRoot}</underRoot> [#-- ${underRoot}--]

[#-- list of toolchains to be generated: EWARM,MDK-ARM,TrueSTUDIO,RIDE: This tag can contain one or more than one toolchain: EWARM,MDK-ARM,TrueSTUDIO,RIDE --]

    <Toolchain>${ide}</Toolchain>

[#if staticLibraryProject??]<StaticLibraryProject>true</StaticLibraryProject> [#-- Static Library Project --][/#if]

    [#--<Version>${version}</Version>--]
<IocFile>${projectName}.ioc</IocFile>

[#if (IdeMode?? || ide=="STM32CubeIDE") && family=="STM32MP1xx"]
<Project>    
    <ProjectName>${projectName}_DTS</ProjectName>
    <ProjectNature>DTS</ProjectNature>
    <DeviceTree>${DeviceTree}</DeviceTree>
    <ManifestVersion>${ManifestVersion}</ManifestVersion>
    <configs>
<config>
<name>Tiny</name>
<device>${project.deviceId}</device>
</config>
</configs>
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
        [/#list]
        [#--break--]
    [#--/#if--]
    [/#if]

[#--/#list--]

    
 

   
[/#macro]
