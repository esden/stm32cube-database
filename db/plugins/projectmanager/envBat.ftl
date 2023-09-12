[#ftl]
@ECHO OFF
:: ==============================================================================
::                               General
:: ==============================================================================
set stm32programmercli="C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe"
set stm32tpccli="C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32TrustedPackageCreator_CLI.exe"

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
[#if appli_secure??] 
set stirot_appli=${appli_secure}
[/#if]
[#if appli_non_secure??] 
set appli_non_secure=${appli_non_secure}
[/#if]
set isFullSecure=${isFullSecure}
set stirot_boot_path_project=${stirot_boot_path_project}
set rot_provisioning_path=${stirot_boot_path_project}\ROT_provisioning
[/#if]
[#-- OEMiRoT --]
[#if BootPathType?? && (BootPathType=="OEM_IROT" || BootPathType=="OEM_UROT")]
:: ==============================================================================
::                            OEMiROT bootpath
:: ==============================================================================
[#if appli_secure??] 
set oemirot_appli_secure=${appli_secure}
[/#if]
[#if appli_non_secure??] 
set oemirot_appli_non_secure=${appli_non_secure}
[/#if]
[#--  set isFullSecure=${isFullSecure}--]
set oemirot_boot_path_project=${oemirot_boot_path_project}
set rot_provisioning_path=${oemirot_boot_path_project}\ROT_provisioning
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

