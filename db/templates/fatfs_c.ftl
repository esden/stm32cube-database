[#ftl]
[#--  Default template in Config file of old series --]
[#-- IPdatas is a list of IPconfigModel --]  
[#list IPdatas as IP]  
	[#assign ipvar = IP] 
	[#-- Section3: Create the void mx_<IpInstance>_init() function for each middle ware instance --] 
	[#list IP.configModelList as instanceData]
		[#assign instName = instanceData.instanceName]   
		[#assign halMode= instanceData.halMode]
		[#assign ipName = instanceData.ipName]
#t/*## FatFS: Link the ${instName} driver ###########################*/
#tret${instName} = FATFS_LinkDriver(&${instName}_Driver, ${instName}Path);
	[/#list]
[/#list]
