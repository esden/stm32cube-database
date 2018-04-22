[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
[#macro getGroups groupArg]
<group>
    <name>${groupArg.name}</name>
    [#if groupArg.sourceFilesNameList??]
        [#list groupArg.sourceFilesNameList as filesName]
            <file>
                    <name>${filesName!''}</name>
            </file>
        [/#list]
    [/#if]
    [#if groupArg.subGroups??]
        [#list groupArg.subGroups as subGrp]
            [@getGroups groupArg=subGrp/]
        [/#list]
    [/#if]
</group>
[/#macro]
<Project>
<ProjectName>${projectName}</ProjectName>
<ProjectNature>${ProjectNature}</ProjectNature> [#-- Cpp --]
<CMSIS>${CMSISPath}</CMSIS>
<HAL_Driver>${HAL_Driver}</HAL_Driver>
 [#-- list of toolchains to be generated: EWARM,MDK-ARM,TrueSTUDIO,RIDE: This tag can contain one or more than one toolchain: EWARM,MDK-ARM,TrueSTUDIO,RIDE --]
<Toolchain>${ide}</Toolchain>
[#if ide=="EWARM" || ide=="MDK-ARM"]
	<Toolversion>${Toolversion}</Toolversion>
[/#if]
<Version>${version}</Version>

<filestoremove>
    <file>
[#list SourceFilesToRemove as SourceFile]
        [#if SourceFile!="null"]
    <name>${SourceFile}</name>
    [/#if]
[/#list]
    </file>
</filestoremove>

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

<configs>
  <config>
    <name>${Configuration}</name>				[#-- project configuration name. Ex: STM32F407_EVAL --]
    <device>${project.deviceId}</device>		 [#--  STM32 selected device. Ex: STM32F407ZE --]
    <heapSize>${HeapSize}</heapSize>
    <stackSize>${StackSize}</stackSize>
    
    [#if ide=="EWARM" || ide=="MDK-ARM"]
    	<cpuclock>${cpuclock}</cpuclock>
    [/#if]
    [#if boardName != ""]
    	<board>${boardName}</board>
    [/#if]
			
    [#--optional part--]
    <usedDebug>${usedDebug}</usedDebug>
    [#if usedDebug == "true"]
    	<debugprobe>${DebugMode}</debugprobe>
    [/#if]
    [#-- <optimization>${project.compilerOptimization}</optimization> --]
    <optimization>${optimization}</optimization>
    <icfloc>${icfloc}</icfloc>
    <Adefines>
        <define></define>
    </Adefines>   

    <UsedFreeRTOS>${usedfreeRTOS}</UsedFreeRTOS>
    <Aincludes>
    	[#if usedfreeRTOS=="true"]
	   		[#if ide=="EWARM" ]
		   		<include>$PROJ_DIR$\${RelativePath}Inc</include>
	   		[#elseif ide=="MDK-ARM" ]
	   			<include>${RelativePath}Inc</include>
   			[#elseif ide=="Makefile" ]
	   			<include>${RelativePath}Inc</include>
                        [#else]
		   		<include></include>
                        [/#if]
	[#else]


	    	<include></include>
    	[/#if]
    </Aincludes>
    <Cdefines>
	[#list CdefinesList as define]
        <define>${define}</define>
        [/#list]
	   [#-- <define>__weak=__attribute__((weak))</define> --]
    </Cdefines>
    [#-- defines to remove --]
    <definestoremove>
        <Adefines>
            <define></define>
        </Adefines>
        <Cdefines>
        [#if cDefineToRemove??]
        [#list cDefineToRemove as defineToRemove]
            <define>${defineToRemove}</define>
        [/#list]
        [/#if]
        </Cdefines>         
    </definestoremove>
    
    [#-- End of optional part--]
	<Cincludes>
	 [#-- required includes for all generated projects --]
        [#list mxIncludePaths as halIncludePath]
	   <include>${halIncludePath}</include>
        [/#list]
     [#-- <include>${CMSISPath}\Device\ST\${family}\Include</include>
     <include>${CMSISPath}\Include</include> --]
	[#list halIncludePaths as halIncludePath]
	   <include>${halIncludePath}</include>
        [/#list]

    </Cincludes>
      </config>
    </configs> 

    <underRoot>${underRoot}</underRoot>
    [#if underRoot == "true"]
    	<copyAsReference>${copyAsReference}</copyAsReference>
    	[#if copyAsReference == "true"]
            <sourceEntries>               
                <sourceEntry>
                        <name>${inc}</name>
                </sourceEntry>
                [#if src??]
                <sourceEntry>
                        <name>${src}</name>
                </sourceEntry>
                [/#if]
                [#if GFXSource??]
                        <sourceEntry>
                                <name>${GFXSource}</name>
                        </sourceEntry>                
                        [/#if]
		    	<sourceEntry>
		    		<name>${HALDriver}</name>
		    	</sourceEntry>
		    	[#if atLeastOneMiddlewareIsUsed]
		    		<sourceEntry>
		    			<name>Middlewares</name>
		    		</sourceEntry>
		    	 [/#if]
				 [#-- MZA Bug41441 --]			
				[#if atLeastOneCmsisPackIsUsed]
                    <sourceEntry>
                        <name>Packs</name>
                    </sourceEntry>
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
		    	<sourceEntry>
		    		<name>${inc}</name>
		    	</sourceEntry>
		    	[#if src??]
                <sourceEntry>
                        <name>${src}</name>
                </sourceEntry>
                [/#if]
                        [#if GFXSource??]
                        <sourceEntry>
                                <name>${GFXSource}</name>
                        </sourceEntry>                
                        [/#if]
		    	<sourceEntry>
		    		<name>${HALDriver}</name>
		    	</sourceEntry>
		    	[#if atLeastOneMiddlewareIsUsed]
		    		<sourceEntry>
		    			<name>Middlewares</name>
		    		</sourceEntry>
		    	 [/#if]
				 [#-- MZA Bug41441 --]			
				[#if atLeastOneCmsisPackIsUsed]
                    <sourceEntry>
                        <name>Packs</name>
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
           [#list groups as group]
              [#if group.name!="App" && group.name!="Target" ] 

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

              [/#if]
           [/#list]
          </group> 
          [/#if]
[/#if]
[#-- end lib path --]
    	[/#if]
		[#--list externalGroups as grp]
                [@getGroups groupArg=grp/]
		[/#list--]
    [/#if]

[#-- project groups and files --]
[#if underRoot == "false"]
[#-- project groups and files --]
[#--
 private String m_sGroup = null;
    private List<String> m_sSubGroup = null;
    private List<String> m_sSourceFilesNameList;
--]
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
		    <group>
		    	<name>CMSIS</name>
			 			[#list cmsisSourceFileNameList as filesName]
							<file>
								<name>${filesName}</name>
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
                             </file>
                         [/#list]
                     [/#if]
         </group>
        [/#if]
	  <group>
	  <name>Application</name>
	    <group>
	      <name>User</name>  
                [#if mxSourceDir == "Core/Src"]
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
                [#if mxSourceDir == "Core/Src"]
                                </group>                  
                [/#if]

[#-- Other source groups --]  
    [#if USE_Touch_GFX_STACK??]
    <group>
        <name>ST-TouchGFX</name>         
                <group>
                    <name>gui</name>
                </group>
                <group>
                    <name>generated</name>
                </group>
    </group> 
    [/#if]

[#-- App Group Case of Graphics--]
[#list ApplicationGroups as grp]        
    <group>
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
    </group>
[/#list]

</group> 
  </group>
[/#if]
</Project>
