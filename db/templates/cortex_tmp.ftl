[#ftl]
[#list IPdatas as IP]  
[#assign ipvar = IP]
[#assign useGpio = false]
[#assign useDma = false]
[#assign useNvic = false]
[#assign familyName=FamilyName?lower_case]

[#assign initServicesList = {"test0":"test1"}]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]

[#-- Global variables --]#n 
[#list IP.configModelList as instanceData]
[#if instanceData.isMWUsed=="false" && instanceData.isBusDriverUSed=="false"]
     [#assign instName = instanceData.instanceName]
        [#assign halMode= instanceData.halMode]
    [#if  FamilyName=="STM32H7RS"]
#nstatic void MPU_Config(void)
    [#else]
#nvoid MPU_Config(void)
    [/#if]
{
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""] 	
[@common.getLocalVariableList instanceData=instanceData/]
[#if  FamilyName=="STM32N6"]
#tuint32_t primask_bit = __get_PRIMASK();
#t__disable_irq();
[/#if]
#n      
#t/* Disables the MPU */
[#if LL_Used?? && LL_Used=="true"]
#tLL_MPU_Disable();
[#else]
#tHAL_MPU_Disable(); 
#n
[#if FamilyName=="STM32H7RS" && projectStructureMap.contains("App") && projectStructureMap.contains("Boot")]
#t/* Disables all MPU regions */
#tfor(uint8_t i=0; i<__MPU_REGIONCOUNT; i++)
#t{
#t#tHAL_MPU_DisableRegion(i);
#t}
[/#if]
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
[#if  FamilyName=="STM32N6"]
#n
#t/* Exit critical section to lock the system and avoid any issue around MPU mechanism */
#t__set_PRIMASK(primask_bit);
[/#if]
#n}
[/#list]

[/#compress]
[/#list]