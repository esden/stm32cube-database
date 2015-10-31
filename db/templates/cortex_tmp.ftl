[#ftl]
[#list IPdatas as IP]  
[#assign ipvar = IP]
[#assign useGpio = false]
[#assign useDma = false]
[#assign useNvic = false]

[#assign initServicesList = {"test0":"test1"}]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]

[#-- Global variables --]#n 
[#list IP.configModelList as instanceData]
[#if instanceData.isMWUsed=="false"]
     [#assign instName = instanceData.instanceName]
        [#assign halMode= instanceData.halMode]
#nvoid MPU_Config(void)
{
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""] 	
[@common.getLocalVariableList instanceData=instanceData/]      
#n      
#t/* Disables the MPU */
#tHAL_MPU_Disable();
    [#if instanceData.instIndex??]
        [@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/]
    [#else]
        [@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/]
    [/#if]
        
[/#if]
#t/* Enables the MPU */
#tHAL_MPU_Enable(${mpuControl});
#n}
[/#list]

[/#compress]
[/#list]