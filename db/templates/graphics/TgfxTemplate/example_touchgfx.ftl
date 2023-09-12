[#ftl]
[#list parameters as params]
[#assign Target = params.EA_3_in_file1_param1]
[#assign Width = params.EA_3_in_file1_param2]
[#assign Height = params.EA_3_in_file1_param3]
[#assign FW_Install_PATH = params.EA_3_in_file1_param5 ]
[#assign RelativePath = "" ]
[#assign MXProjectName = params.EA_3_in_file1_param4 ]
[#assign Depth = params.EA_3_in_file1_param6 ]
[#assign IDE = params.EA_3_in_file1_param7 ]
[#assign RGBFormat = params.EA_3_in_file1_param9 ]
[#assign imageFormat = params.imageFormat ]


[#assign EA_PATH = params.EA_PATH ]
[#assign FW_PATH = params.FWPath ]
[#assign MXPRojectRootPath = params.MXProjectRootPath]
[#assign ideProjectFile = params.ideProjectFile]
[#assign EA_PATH = params.EA_PATH ]
[#assign underRoot = params.underRoot ]
[#assign ToolChainLocation = params.ToolChainLocation]
[#if params.dualCore??]
[#assign dualCore = params.dualCore]
[/#if]

[#--assign version = params.EA_3_in_file1_param8 --]
[/#list]
{
  "Application": {
    "Screens": [
      {
       "Components": [],
        "Interactions": [],
        "Name": "Screen1"
      }
    ],
    "CustomContainerDefinitions": [],
    "Name": "MyApplication",
    "Resolution": {
      "Width": ${Width},
      "Height": ${Height}
    },
    "StartupScreenName": "Screen1",
    "SelectedColorDepth": ${Depth},    
    "SelectedStartupLanguage": "GB",
    "Skin": "Blue",
    "TouchGfxPath": "[#if dualCore??]../[/#if]../Middlewares/ST/TouchGFX/touchgfx/",
    "UIPath": ".",
    "ApplicationTemplate": {
      "Name": "Simulator",
      "Version": "1.0.0",
      "Description": "STM32CubeMX Generated Simulator Application Template",
      "NativeResolution": {
        "Width": ${Width},
        "Height": ${Height}
      },
      "AvailableColorDepths": [
        ${Depth}
      ],
      "AvailableImageFormats": {
        "${Depth}": {
          "Opaque": "${imageFormat}",
          "NonOpaque": "ARGB8888"
        }
      },
      "AvailableResolutions": [],
      "PhysicalButtons": [],
      "GenerateAssetsCommand": "make -f simulator/gcc/Makefile assets -j10",
      [#if IDE == "SW4STM32" || IDE == "STM32CubeIDE"]
      "PostGenerateCommand": [#if underRoot?? && underRoot=="true"]"touchgfx update_project --project-file=[#if dualCore??]../[/#if]../.project "[#else]"touchgfx update_project --project-file=${ideProjectFile?replace(MXPRojectRootPath,"..")}  --gui-group-name=Application/User/TouchGFX/gui --generated-group-name=Application/User/TouchGFX/generated"[/#if],      
      [#else]
      "PostGenerateCommand":[#if IDE?contains("EWARM")]"touchgfx update_project --project-file=[#if dualCore??]..\\[/#if]${ideProjectFile?replace(MXPRojectRootPath,"..")}"[#else]"touchgfx update_project --project-file=${ideProjectFile?replace(MXPRojectRootPath,"..")} --gui-group-name=Application/User/TouchGFX/gui --generated-group-name=Application/User/TouchGFX/generated"[/#if],
      [/#if]
      "CompileSimulatorCommand": "make -f simulator/gcc/Makefile -j10",
      "RunSimulatorCommand": "build\\bin\\simulator.exe",
      "CompileTargetCommand": "",
      "FlashTargetCommand": ""
    }
  },
  "Version": "4.10.0"
}