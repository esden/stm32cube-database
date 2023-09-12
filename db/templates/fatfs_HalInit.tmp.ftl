[#ftl]
[#-- IPdatas is a list of IPconfigModel --] 
[#--  Default template in Config file of new series --]
[#list IPdatas as IP]  
	[#assign ipvar = IP] 
	[#assign initCondition = ""]
	[#assign value = 0]
	[#-- Prepare the condition possibly gathering different FatFS modes enabled --] 
	[#-- if((FATFS_LinkDriver(&SRAMDISK_Driver, RAMpath) == 0) && (FATFS_LinkDriver(&SD_Driver, SDpath) == 0)) --]
	[#list IP.configModelList as instanceData]
		[#assign instName = instanceData.instanceName]   
		[#assign halMode= instanceData.halMode]
		[#assign ipName = instanceData.ipName]
		[#assign linkDriverCall = "FATFS_LinkDriver(&" + instName + "_Driver, " + instName + "Path)"]
		[#if value == 0]
		  [#assign initCondition = "(" + linkDriverCall + " != 0)"]
		[#else]
		  [#assign initCondition = initCondition + " || (" + linkDriverCall + " != 0)"]
		[/#if]
		[#assign value = value + 1]
	[/#list]
  /*## FatFS: Link the disk I/O driver(s)  ###########################*/
[#if value == 1]
  if ${initCondition}
[#else]
  if (${initCondition})
[/#if]
  /* USER CODE BEGIN FATFS_Init */
  {
    return APP_ERROR;
  }
  else
  {
    Appli_state = APPLICATION_INIT;
    return APP_OK;
  }
  /* USER CODE END FATFS_Init */
[/#list]
