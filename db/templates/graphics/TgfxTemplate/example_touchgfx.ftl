[#ftl]
[#list parameters as params]
[#assign Target = params.EA_3_in_file1_param1]
[#assign Width = params.EA_3_in_file1_param2]
[#assign Height = params.EA_3_in_file1_param3]
[#assign FW_PATH = params.EA_3_in_file1_param5 ]
[#assign RelativePath = "" ]
[#assign MXProjectName = params.EA_3_in_file1_param4 ]
[#assign Depth = params.EA_3_in_file1_param6 ]
[#assign IDE = params.EA_3_in_file1_param7 ]

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
    "Name": "${MXProjectName}",
    "Width": ${Width},
    "Height": ${Height},
    "Target": "${FamilyName}",
    "TargetBpp": 16,
    "StartupScreenName": "Screen1",
    "Skin": "Blue",
    "TouchGfxPath": "${FW_PATH?replace("\\","\\\\")}\\Middlewares\\ST\\TouchGFX\\",
    "UIPath": ".",
[#if IDE == "EWARM"]
    "IARPath": "..\\EWARM\\${MXProjectName}.ewp",
[/#if]
[#if IDE?contains("MDK-ARM")]
    "KeilPath": "..\\MDK-ARM\\${MXProjectName}.uvprojx",
[/#if]
[#if IDE == "SW4STM32"]
   
[/#if]
[@common.optinclude name="TouchGFX/idePath.tmp"/] 
    "TargetFixed": true
  },
  "Version": "4.8.0"
}