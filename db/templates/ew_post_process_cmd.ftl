[#ftl]
[#list parameters as params]
[#assign FW_Path = params.EA_2_in_file4_param1]
[#assign MX_Path = params.EA_2_in_file4_param2]
[/#list]
@echo off
SETLOCAL EnableDelayedExpansion

set out_file="%EmWi_OutputDirectory%/../EmbeddedWizard.extSettings"

if not exist "${FW_Path}/Middlewares/ST/EmbeddedWizard/PlatformPackage/%EmWi_ColorFormat%" (
echo "ERROR: The requested color format %EmWi_ColorFormat% is not supported for this platform!"
exit /B 1
)

SET _xsize=%EmWi_ScreenSize:~0,3%
SET _ysize=%EmWi_ScreenSize:~3,3%
SET MX_PATH=%EmWi_OutputDirectory:${MX_Path}\=%
if exist ../../PlatformPackage/RTE/ewcolor.c (
  set EmWi_RTESrcFiles=ewcolor.c ewdebug.c ewextrte.c ewobject.c ewpoint.c ewrect.c ewref.c ewresource.c ewscalars.c ewslot.c ewstring.c ewtimer.c
  
  if %EmWi_ColorFormat% == Index8 (
    set EmWi_GFX_SrcFiles=ewextbmp_Index8.c ewextfnt.c ewextgfx.c ewextpxl_Index8.c ewgfx.c ewgfxattrtext.c ewgfxcore.c ewgfxdriver.c ewgfxtasks.c
  )
  if %EmWi_ColorFormat% == LumA44 (
    set EmWi_GFX_SrcFiles=ewextbmp_LumA44.c ewextfnt.c ewextgfx.c ewextpxl_LumA44.c ewgfx.c ewgfxattrtext.c ewgfxcore.c ewgfxdriver.c ewgfxtasks.c
  )
  if %EmWi_ColorFormat% == RGB565 (
    set EmWi_GFX_SrcFiles=ewextbmp_RGB565_RGBA8888.c ewextfnt.c ewextgfx.c ewextpxl_RGB565_RGBA8888.c ewgfx.c ewgfxattrtext.c ewgfxcore.c ewgfxdriver.c ewgfxtasks.c
  )
  if %EmWi_ColorFormat% == RGB888 (
    set EmWi_GFX_SrcFiles=ewextbmp_RGB888_RGBA8888.c ewextfnt.c ewextgfx.c ewextpxl_RGB888_RGBA8888.c ewgfx.c ewgfxattrtext.c ewgfxcore.c ewgfxdriver.c ewgfxtasks.c
  )
  if %EmWi_ColorFormat% == RGBA4444 (
    set EmWi_GFX_SrcFiles=ewextbmp_RGBA4444.c ewextfnt.c ewextgfx.c ewextpxl_RGBA4444.c ewgfx.c ewgfxattrtext.c ewgfxcore.c ewgfxdriver.c ewgfxtasks.c
  )
  if %EmWi_ColorFormat% == RGBA8888 (
    set EmWi_GFX_SrcFiles=ewextbmp_RGBA8888.c ewextfnt.c ewextgfx.c ewextpxl_RGBA8888.c ewgfx.c ewgfxattrtext.c ewgfxcore.c ewgfxdriver.c ewgfxtasks.c
  )
) ELSE (
  set EmWi_RTESrcFiles=ewextrte.c libewrte-m7-iar.a
  if %EmWi_SurfaceRotation% == 0 (
    set EmWi_GFX_SrcFiles=ewextgfx.c libewgfx-m7-iar.a
  ) else (
    set EmWi_GFX_SrcFiles=ewextgfx.c libewgfx-m7-r%EmWi_SurfaceRotation%-iar.a
  )
)


@echo [Others] > %out_file%

IFS=$OIFS
@echo [ProjectFiles] >>  %out_file%
@echo HeaderPath=%MX_PATH% >>  %out_file%
@echo [Groups] >>  %out_file%
set EmWi_OutputSrcFiles=%EmWi_OutputSrcFiles:.c =.c;%
set EmWi_OutputSrcFiles=%EmWi_OutputSrcFiles:;=;!MX_PATH!\%
@echo Application/User/EmbeddedWizard/GeneratedCode/%EmWi_ColorFormat%=%MX_PATH%\%EmWi_OutputSrcFiles% >>  %out_file%
