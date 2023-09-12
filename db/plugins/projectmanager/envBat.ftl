[#ftl]
@ECHO OFF
:: ==============================================================================
::                               General
:: ==============================================================================
set stm32programmercli="C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe"
set stm32tpccli=${tpcPath}
::~dp0 = represent the folder where the env.bat is started
:: ==============================================================================
::               !!!! DOT NOT EDIT --- UPDATED AUTOMATICALLY !!!!
:: ==============================================================================
set PROJECT_GENERATED_BY_CUBEMX=true
set cube_fw_path="${CubeFwPath}"


[#-- STiRoT --]
[#if BootPathType?? && BootPathType=="ST_IROT"]
:: ==============================================================================
::                            STiRoT bootpath
:: ==============================================================================
[#if appli_assembly_sign?? && appli_assembly_sign!=""]
set stirot_appli=${appli_assembly_sign}
set stirot_appli_bin=${appli_secure}
[#elseif appli_secure??] 
set stirot_appli=${appli_secure}
[/#if]
set isFullSecure=${isFullSecure}
set stirot_boot_path_project=%~dp0..\
set rot_provisioning_path=%~dp0
	[#if appli_non_secure??] 
:: ==============================================================================
::                            For Assembly Python script
:: ==============================================================================
set appli_path=${appli_secure_path}
set appli_non_secure=${appli_non_secure}
set appli_non_secure_path=${appli_non_secure_path}
set appli_assembly=${appli_assembly_file_name}
set appli_assembly_path=${appli_assembly_path}
set code_size=${secure_code_size}
set code_image_path=${code_image_path}
	[/#if]
[#--  
set stirot_boot_path_project=${boot_path_project}
set rot_provisioning_path=${boot_path_project}\ROT_provisioning
--]

[/#if]
[#-- OEMiRoT --]
[#if BootPathType?? && (BootPathType=="OEM_IROT" || BootPathType=="ST_IROT_UROT")]
:: ==============================================================================
::                            ${BootPathType} bootpath
:: ==============================================================================
[#if appli_secure??] 
set oemirot_appli_secure=${appli_secure}
[/#if]
[#if appli_non_secure??] 
set oemirot_appli_non_secure=${appli_non_secure}
[/#if]
[#if appli_assembly??]
	[#if appli_assembly_sign??]
[#--set oemirot_urot_appli_assembly_sign=${appli_assembly_sign} --]
[#-- from CubeFw STM32H5 1.1.0 --]
set oemirot_appli_assembly_sign=${appli_assembly_sign}
	[/#if]
[/#if]
set oemirot_boot_path_project=%~dp0..\
set rot_provisioning_path=%~dp0
	[#if appli_assembly??]
:: ==============================================================================
::                            For Assembly Python script
:: ==============================================================================
set appli_path=${appli_secure_path}
set appli_non_secure_path=${appli_non_secure_path}
set appli_assembly_path=${appli_assembly_path}
set appli_assembly=${appli_assembly_file_name}
set code_size=${secure_code_size}
set code_image_path=${code_image_path}
set isFullSecure=${isFullSecure}
	[/#if]
[#--
set oemirot_boot_path_project=${boot_path_project}
set rot_provisioning_path=${boot_path_project}\ROT_provisioning
--]

[/#if]

[#-- SMAK --]
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
:: ==============================================================================
::                            SMAK bootpath
:: ==============================================================================
[#-- set smak_appli=${appli_non_secure} --]
[#--  
:: Select secure manager binaries version
set rsse_binary=RSSe_SFI_v1.0.0.rc1.bin
set ssfi_binary=SecureManagerPackage_v1.0.0.rc1.ssfi
--]
:: Configure Virtual Com Port
set com_port=COM4
[/#if]

