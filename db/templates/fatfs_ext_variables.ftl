[#ftl]
[#list IPdatas as IP]  
[#assign ipvar = IP]
[#list IP.configModelList as instanceData]
        [#assign instName = instanceData.instanceName]
        [#assign instMode= instanceData.halMode]
		[#assign ipName = instanceData.ipName]	
extern uint8_t ret${instName};    /* Return value for ${instName} */
extern char ${instName}_Path[4];  /* ${instName} logical drive path */
[#-- FATFS ${instName}_FatFs; --]
[#-- extern Diskio_drvTypeDef ${instName}_Driver; --]
[/#list]
[/#list]
