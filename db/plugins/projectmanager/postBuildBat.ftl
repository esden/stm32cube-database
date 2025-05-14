[#ftl]
@ECHO OFF
:: Getting the Trusted Package Creator and STM32CubeProgammer CLI path 
:: arg1 is the binary type (1 nonsecure, 2 secure)
set "projectdir=%~dp0"
set signing=%1
pushd %projectdir%
set provisioningdir=%cd%
set env_script="%provisioningdir%\env.bat"
call %env_script%
popd


:: Enable delayed expansion
setlocal EnableDelayedExpansion
::default use case for image non assembly
[#if appli_assembly??]
set app_image_number=1
[#else]
set app_image_number=2
[/#if]
[#-- STiRoT --]
[#if BootPathType?? && BootPathType=="ST_IROT"]
:: ==============================================================================
::                            ${BootPathType} bootpath
:: ==============================================================================
	[#if Secure_Code_Image??]
set s_code_xml="%provisioningdir%\${ProvisioningFolderName}\Image\${Secure_Code_Image}"
	[/#if]	
	[#if appli_assembly??]	
set ns_code_xml="%provisioningdir%\${ProvisioningFolderName}\Image\${Secure_Code_Image}"
set appli_secure=%stirot_appli_bin%
set appli_secure_path=%appli_path%
set appli_non_secure=%appli_non_secure%
set appli_non_secure_path=%appli_non_secure_path%
set appli_assembly=%appli_assembly%
set appli_assembly_path=%appli_assembly_path%
set secure_code_size=%code_size%
	[/#if]
[/#if]
[#-- OEMiRoT --]
[#if BootPathType?? && (BootPathType=="OEM_IROT" || BootPathType=="ST_IROT_UROT")]
:: ==============================================================================
::                            ${BootPathType} bootpath
:: ==============================================================================
	[#if Secure_Code_Image??]
set s_code_xml="%provisioningdir%\${ProvisioningFolderName}\Images\${Secure_Code_Image}"
	[/#if]
	[#if NonSecure_Code_Image??]
set ns_code_xml="%provisioningdir%\${ProvisioningFolderName}\Images\${NonSecure_Code_Image}"
	[/#if]
	[#if appli_assembly??]
set appli_secure=%oemirot_appli_secure%
set appli_secure_path=%appli_path%
set appli_non_secure=%oemirot_appli_non_secure%
set appli_non_secure_path=%appli_non_secure_path%
set appli_assembly=%appli_assembly%
set appli_assembly_path=%appli_assembly_path%
set secure_code_size=%code_size%
	[/#if]
[/#if]
[#-- SMAK --]
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
:: ==============================================================================
::                            SMAK bootpath
:: ==============================================================================
	[#if NonSecure_Code_Image??]
set ns_code_xml="%provisioningdir%\${ProvisioningFolderName}\Images\${NonSecure_Code_Image}"
	[/#if]
	[#if NonSecure_Bin_Code_Image??]
set ns_code_bin_xml="%provisioningdir%\${ProvisioningFolderName}\Images\${NonSecure_Bin_Code_Image}"
	[/#if]
[/#if]


:start
goto exe:
goto py:
:exe
::line for window executable
set "applicfg=%cube_fw_path%\Utilities\PC_Software\ROT_AppliConfig\dist\AppliCfg.exe"
set "python="
if exist %applicfg% (
goto postbuild
)
:py
::called if we just want to use AppliCfg python (think to comment "goto exe:")
set "applicfg=%cube_fw_path%\Utilities\PC_Software\ROT_AppliConfig\AppliCfg.py"
set "python=python "

:postbuild
echo Postbuild %signing% image > %projectdir%\output.txt 2>&1

if "%app_image_number%" == "2" (
goto :continue
)
if %signing% == "nonsecure" (
echo Creating only one image >> %projectdir%\output.txt 2>&1
%python%%applicfg% oneimage -fb "%appli_secure_path%\%appli_secure%" -sb "%appli_non_secure_path%\%appli_non_secure%" -o %secure_code_size% -ob "%appli_assembly_path%\%appli_assembly%" --vb
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
%stm32tpccli% -pb %ns_code_xml%
%stm32tpccli% -pb %ns_code_bin_xml%
[#else]
"%stm32tpccli%" -pb %ns_code_xml%
[/#if]
if !errorlevel! neq 0 goto :error
)


:continue
if %signing% == "secure" (
echo Creating secure image  >> %projectdir%\output.txt 2>&1
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
%stm32tpccli% -pb %s_code_xml% >> %projectdir%\output.txt 2>&1
[#else]
"%stm32tpccli%" -pb %s_code_xml% >> %projectdir%\output.txt 2>&1
[/#if]
if !errorlevel! neq 0 goto :error
)

if %signing% == "nonsecure" (
echo Creating nonsecure image  >> %projectdir%\output.txt 2>&1
[#if BootPathType?? && (BootPathType=="ST_IROT_UROT_SECURE_MANAGER")]
%stm32tpccli% -pb %ns_code_xml% >> "%projectdir%"\output.txt 2>&1
%stm32tpccli% -pb %ns_code_bin_xml% >> "%projectdir%"\output.txt 2>&1
[#else]
"%stm32tpccli%" -pb %ns_code_xml% >> %projectdir%\output.txt 2>&1
[/#if]
if !errorlevel! neq 0 goto :error
)

exit 0

:error
exit 1

