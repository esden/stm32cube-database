[#ftl]
[#-- To be generated in the fatfs.c file --]
[#list IPdatas as IP]  
[#assign ipvar = IP]
[#list IP.configModelList as instanceData]
        [#assign instName = instanceData.instanceName]
        [#assign instMode= instanceData.halMode]
		[#assign ipName = instanceData.ipName]	
uint8_t ret${instName};    /* Return value for ${instName} */
char ${instName}Path[4];   /* ${instName} logical drive path */
FATFS ${instName}FatFS;    /* File system object for ${instName} logical drive */
FIL ${instName}File;       /* File object for ${instName} */
[#-- FATFS ${instName}_FatFs; --]
[#-- extern Diskio_drvTypeDef ${instName}_Driver; --]
[/#list]
[/#list]
