[#ftl]
[#compress]
[#-- IPdatas is a list of IPconfigModel --]  
[#list IPdatas as IP]  
[#assign ipvar = IP] 

[#-- Section3: Create the void mx_<IpInstance>_init() function for each middle ware instance --] 
[#list IP.configModelList as instanceData]
   [#assign instName = instanceData.instanceName]   
   [#assign halMode= instanceData.halMode]
   [#assign ipName = instanceData.ipName]

#t/*## FatFS: Link the ${instName} disk I/O driver ###############################*/
#t${instName}_DriverNum = FATFS_LinkDriver(&${instName}_Driver, ${instName}_Path);
[/#list]
[/#list]
[/#compress]
