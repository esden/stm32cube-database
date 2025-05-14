[#ftl]
#!/bin/bash -
# Absolute path to this script  
[#assign DOLLAR = "$"]
[#assign BASH = "{BASH_SOURCE[0]}"]
[#-- we must be able to find the user name --]
[#--  [#assign user = "pwe"]--]
if [ $# -ge 1 ] && [ -d $1 ]; then
    projectdir=$1
else
    projectdir=$( cd -- "$( dirname -- "${DOLLAR}${BASH}" )" &> /dev/null && pwd )
fi
# ==============================================================================
#                               General
# ==============================================================================
#Configure tools installation path
VAR1=$OSTYPE
VAR2="Windows_NT"
user="" 
if [ "$VAR1" = "$VAR2" ]; then
    stm32programmercli="C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe"
    stm32tpccli="${tpcPath}"
else	
    PATH="/home/${user}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin":$PATH
    PATH="${tpcPath}":$PATH
    stm32programmercli="/home/${user}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI"
    stm32tpccli="${tpcPath}"
fi
# ==============================================================================
#               !!!! DOT NOT EDIT --- UPDATED AUTOMATICALLY !!!!
# ==============================================================================
PROJECT_GENERATED_BY_CUBEMX=true
cube_fw_path="${CubeFwPath}"


[#-- STiRoT --]
[#if BootPathType?? && BootPathType=="ST_IROT"]
# ==============================================================================
#                            STiRoT bootpath
# ==============================================================================
[#if appli_assembly_sign?? && appli_assembly_sign!=""]
stirot_appli=${appli_assembly_sign}
stirot_appli_bin=${appli_secure}
[#elseif appli_secure??] 
stirot_appli=${appli_secure}
[/#if]
isFullSecure=${isFullSecure}
stirot_boot_path_project=$projectdir"/../"
[#--  rot_provisioning_path=$projectdir"/../Binary"--]
	[#if appli_non_secure??] 
# ==============================================================================
#                            For Assembly Python script
# ==============================================================================
appli_path=$projectdir"${appli_secure_path}"
appli_non_secure=${appli_non_secure}
appli_non_secure_path=$projectdir"${appli_non_secure_path}"
appli_assembly=${appli_assembly_file_name}
appli_assembly_path=$projectdir"${appli_assembly_path}"
code_size=${secure_code_size}
code_image_path=$projectdir"${code_image_path}"
	[/#if]
[#--  
stirot_boot_path_project=${boot_path_project}
rot_provisioning_path=${boot_path_project}\ROT_provisioning
--]

[/#if]
[#-- OEMiRoT --]
[#if BootPathType?? && (BootPathType=="OEM_IROT" || BootPathType=="ST_IROT_UROT")]
# ==============================================================================
#                            ${BootPathType} bootpath
# ==============================================================================
[#if appli_secure??] 
oemirot_appli_secure=${appli_secure}
[/#if]
[#if appli_non_secure??] 
oemirot_appli_non_secure=${appli_non_secure}
[/#if]
[#if appli_assembly??]
	[#if appli_assembly_sign??]
[#--set oemirot_urot_appli_assembly_sign=${appli_assembly_sign} --]
[#-- from CubeFw STM32H5 1.1.0 --]
oemirot_appli_assembly_sign=${appli_assembly_sign}
	[/#if]
[/#if]
oemirot_boot_path_project=$projectdir"/../"
rot_provisioning_path=$projectdir"/../"
	[#if appli_assembly??]
# ==============================================================================
#                            For Assembly Python script
# ==============================================================================
appli_path=$projectdir"${appli_secure_path}"
appli_non_secure_path=$projectdir"${appli_non_secure_path}"
appli_assembly_path=$projectdir"${appli_assembly_path}"
appli_assembly=${appli_assembly_file_name}
code_size=${secure_code_size}
code_image_path=$projectdir"${code_image_path}"
isFullSecure=${isFullSecure}
	[/#if]
[#--
set oemirot_boot_path_project=${boot_path_project}
set rot_provisioning_path=${boot_path_project}\ROT_provisioning
--]

[/#if]

[#-- SMAK --]
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
# ==============================================================================
#                            SMAK bootpath
# ==============================================================================
[#-- set smak_appli=${appli_non_secure} --]
[#--  
# Select secure manager binaries version
rsse_binary=RSSe_SFI_v1.0.0.rc1.bin
ssfi_binary=SecureManagerPackage_v1.0.0.rc1.ssfi
--]
# Configure Virtual Com Port
com_port=COM4
[/#if]
[#--  echo $rot_provisioning_path--]

