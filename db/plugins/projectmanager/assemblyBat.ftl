[#ftl]
@ECHO OFF
set "projectdir=%~dp0"
set env_script="%projectdir%\..\ROT_Provisioning\env.bat"
call %env_script%
[#-- STiRoT --]
[#if BootPathType?? && BootPathType=="ST_IROT"]
:: ==============================================================================
::                            STiRoT bootpath
:: ==============================================================================
set appli_secure=%stirot_appli%
set appli_secure_path=%appli_path%
set appli_non_secure=%appli_non_secure%
set appli_non_secure_path=%appli_non_secure_path%
set appli_assembly=%appli_assembly%
set appli_assembly_path=%appli_assembly_path%
set secure_code_size=%code_size%
[/#if]
[#-- OEMiRoT --]
[#if BootPathType?? && (BootPathType=="OEM_IROT" || BootPathType=="ST_IROT_UROT")]
:: ==============================================================================
::                            ${BootPathType} bootpath
:: ==============================================================================
set appli_secure=%oemirot_appli_secure%
set appli_non_secure=%oemirot_appli_non_secure%
[#if appli_assembly??]
set appli_secure_path=%appli_path%
set appli_non_secure_path=%appli_non_secure_path%
set appli_assembly=%appli_assembly%
set appli_assembly_path=%appli_assembly_path%
set secure_code_size=%code_size%
[/#if]
[/#if]
"%cube_fw_path%\Utilities\PC_Software\ROT_AppliConfig\dist\AppliCfg.exe" oneimage -fb "%appli_secure_path%\%appli_secure%" -sb "%appli_non_secure_path%\%appli_non_secure%" -o %secure_code_size% -ob "%appli_assembly_path%\%appli_assembly%" --vb
%stm32tpccli% -pb %code_image_path%



