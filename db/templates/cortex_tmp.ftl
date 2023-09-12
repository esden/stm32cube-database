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
[#if instanceData.isMWUsed=="false" && instanceData.isBusDriverUSed=="false"]
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
[#if LL_Used?? && LL_Used=="true"]
#tLL_MPU_Disable();
[#else]
#tHAL_MPU_Disable();
[/#if]
    [#if instanceData.instIndex??]
        [@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/]
    [#else]
        [@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/]
    [/#if]
        
[/#if]
#t/* Enables the MPU */
[#if LL_Used?? && LL_Used=="true"]
#tLL_MPU_Enable(${mpuControl});
[#else]
#tHAL_MPU_Enable(${mpuControl});
[/#if]
#n}
[/#list]

[/#compress]
[/#list]