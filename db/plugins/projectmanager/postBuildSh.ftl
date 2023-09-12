[#ftl]
#!/bin/bash -

# arg1 is the binary type (1 nonsecure, 2 secure)
signing=$1

# Getting the Trusted Package Creator and STM32CubeProgammer CLI path 
[#assign DOLLAR = "$"]
[#assign BASH = "{BASH_SOURCE[0]}"]
if [ $# -ge 1 ] && [ -d $1 ]; then
    projectdir=$1
else
    projectdir=$( cd -- "$( dirname -- "${DOLLAR}${BASH}" )" &> /dev/null && pwd )
fi
provisioningdir=$(pwd)
source "$provisioningdir/env.sh"
# Environement variable for log file
current_log_file="$projectdir/postbuild.log"
[#if appli_assembly??]
app_image_number=1
[#else]
app_image_number=2
[/#if]
[#-- STiRoT --]
[#if BootPathType?? && BootPathType=="ST_IROT"]
# ==============================================================================
#                            ${BootPathType} bootpath
# ==============================================================================
	[#if Secure_Code_Image??]
s_code_xml="$provisioningdir/${ProvisioningFolderName}/Image/${Secure_Code_Image}"
	[/#if]	
	[#if appli_assembly??]	
ns_code_xml="$provisioningdir/${ProvisioningFolderName}/Image/${Secure_Code_Image}"
appli_secure=$stirot_appli_bin
appli_secure_path=$appli_path
appli_non_secure=$appli_non_secure
appli_non_secure_path=$appli_non_secure_path
appli_assembly=$appli_assembly
appli_assembly_path=$appli_assembly_path
secure_code_size=$code_size
	[/#if]
[/#if]
[#-- OEMiRoT --]
[#if BootPathType?? && (BootPathType=="OEM_IROT" || BootPathType=="ST_IROT_UROT")]
# ==============================================================================
#                            ${BootPathType} bootpath
# ==============================================================================
	[#if Secure_Code_Image??]
s_code_xml="$provisioningdir/${ProvisioningFolderName}/Images/${Secure_Code_Image}"
	[/#if]
	[#if NonSecure_Code_Image??]
ns_code_xml="$provisioningdir/${ProvisioningFolderName}/Images/${NonSecure_Code_Image}"
	[/#if]
	[#if appli_assembly??]
appli_secure=$oemirot_appli_secure
appli_secure_path=$appli_path
appli_non_secure=$oemirot_appli_non_secure
appli_non_secure_path=$appli_non_secure_path
appli_assembly=$appli_assembly
appli_assembly_path=$appli_assembly_path
secure_code_size=$code_size
	[/#if]
[/#if]
[#-- SMAK --]
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
# ==============================================================================
#                            SMAK bootpath
# ==============================================================================
	[#if NonSecure_Code_Image??]
ns_code_xml="$provisioningdir/${ProvisioningFolderName}/Images/${NonSecure_Code_Image}"
	[/#if]
[/#if]

applicfg="$cube_fw_path/Utilities/PC_Software/ROT_AppliConfig/dist/AppliCfg.exe"
uname | grep -i -e windows -e mingw
if [ $? == 0 ] && [ -e "$applicfg" ]; then
  #line for window executable
  echo AppliCfg with windows executable
  python=""
else
  #line for python
  echo AppliCfg with python script
  applicfg="$cube_fw_path/Utilities/PC_Software/ROT_AppliConfig/AppliCfg.py"
  #determine/check python version command
  python="python "
fi
# postbuild
echo "Postbuild $signing image" >> $current_log_file

if  [ $app_image_number -eq 1 ] && [ $signing == "nonsecure" ]; then
  echo "Creating only one image" >> $current_log_file
  $python$applicfg oneimage -fb $s_code_bin -o $image_s_size -sb $ns_code_bin -i 0x0 -ob $one_code_bin$ --vb >> $current_log_file
  if [ $? != 0 ]; then 
  	echo "Error with TPC see $current_log_file"
  fi
fi

if [ $signing == "secure" ]; then
  echo "Creating secure image"  >> $current_log_file
  "$stm32tpccli" -pb $s_code_xml >> $current_log_file
  if [ $? != 0 ]; then 
  	echo "Error with TPC see $current_log_file"
  fi
fi

if [ $signing == "nonsecure" ]; then
  echo "Creating nonsecure image"  >> $current_log_file
  "$stm32tpccli" -pb $ns_code_xml >> $current_log_file
  if [ $? != 0 ]; then 
  	echo "Error with TPC see $current_log_file"
  fi
fi

exit 0

