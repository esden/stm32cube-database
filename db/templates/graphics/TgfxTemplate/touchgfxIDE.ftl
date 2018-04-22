[#ftl]
[#list parameters as params]

[#assign IDE = params.EA_3_in_file2_param1 ]
[#assign MXProjectName = params.EA_3_in_file2_param2 ]


[/#list]
[#if IDE == "EWARM"]
    "IARPath": "..\\EWARM\\${MXProjectName}.ewp",
[/#if]
[#if IDE?contains("MDK-ARM")]
    "KeilPath": "..\\MDK-ARM\\${MXProjectName}.uvprojx",
[/#if]
[#if IDE == "SW4STM32"]
   
[/#if]
