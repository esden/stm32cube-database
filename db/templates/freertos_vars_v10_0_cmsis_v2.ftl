[#ftl]
[#compress]
[#assign familyName=FamilyName?lower_case]
[#assign threadControlBlock = "NULL"]
[#assign mutexControl       = "NULL"]
[#assign timerControlBlock  = "NULL"]
[#assign queueControlBlock  = "NULL"]
[#assign semaphoreControl   = "NULL"]
[#assign eventControl       = "NULL"]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]  
    [#list SWIP.variables as variable]
      [#if variable.name=="Threads"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign threadName = i]
          [/#if]
          [#if index == 1]
            [#assign threadPriority = i]
          [/#if]
          [#if index == 2]
            [#assign threadStackSize = i]
          [/#if]
          [#if index == 3]
            [#assign threadFunction = i]
          [/#if]
          [#if index == 4]
            [#assign generateFunction = i]
          [/#if]
          [#if index == 5]
            [#assign codegenOption = i]
          [/#if]
          [#if index == 6]
            [#assign threadArguments = i]
          [/#if] 
          [#if index == 7]
            [#assign threadAllocation = i]
          [/#if]
          [#if index == 8]
            [#assign threadBuffer = i]
          [/#if]
          [#if index == 9]
            [#assign threadControlBlock = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        /* Definitions for ${threadName} */
        osThreadId_t ${threadName}Handle;
        [#if threadControlBlock != "NULL"]
          uint32_t ${threadBuffer}[ ${threadStackSize} ];
          osStaticThreadDef_t ${threadControlBlock};
        [/#if]
        [#-- Moved here, cf BZ 74919 --]
        [#if threadAllocation == "Dynamic"]
         [#if familyName == "stm32g0" || familyName == "stm32g4" || familyName == "stm32wb" || familyName == "stm32wl"] [#-- avoid impact on V2 examples --]
         const osThreadAttr_t ${threadName}_attributes = {
         #t.name = "${threadName}",
         #t.priority = (osPriority_t) ${threadPriority},
         #t.stack_size = ${threadStackSize} * 4  [#-- cf BZ 78929 --]
         };
         [#else]
         const osThreadAttr_t ${threadName}_attributes = {
         #t.name = "${threadName}",
         #t.stack_size = ${threadStackSize} * 4,
         #t.priority = (osPriority_t) ${threadPriority},
         };
         [/#if]
        [#else]
         [#if familyName == "stm32g0" || familyName == "stm32g4" || familyName == "stm32wb" || familyName == "stm32wl"] [#-- avoid impact on V2 examples --]
         const osThreadAttr_t ${threadName}_attributes = {
         #t.name = "${threadName}",
         #t.stack_mem = &${threadBuffer}[0],
         #t.stack_size = sizeof(${threadBuffer}),
         #t.cb_mem = &${threadControlBlock},
         #t.cb_size = sizeof(${threadControlBlock}),
         #t.priority = (osPriority_t) ${threadPriority},
         };
         [#else]
         const osThreadAttr_t ${threadName}_attributes = {
         #t.name = "${threadName}",
         #t.cb_mem = &${threadControlBlock},
         #t.cb_size = sizeof(${threadControlBlock}),
         #t.stack_mem = &${threadBuffer}[0],
         #t.stack_size = sizeof(${threadBuffer}),
         #t.priority = (osPriority_t) ${threadPriority},
         };
         [/#if]
        [/#if]
      [/#if]
      
      [#if variable.name=="Mutexes"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign mutexName = i]
          [/#if]
          [#if index == 1]
            [#assign mutexAllocation = i]
          [/#if]
          [#if index == 2]
            [#assign mutexControl = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if mutexName != "0"]
          /* Definitions for ${mutexName} */
          osMutexId_t ${mutexName}Handle;
          [#if mutexControl != "NULL"]
          osStaticMutexDef_t ${mutexControl};
          [/#if]
          [#-- Moved here, cf BZ 74919 --]
          [#if mutexAllocation == "Dynamic"]
            const osMutexAttr_t ${mutexName}_attributes = {
            #t.name = "${mutexName}"
            };
          [#else]
            const osMutexAttr_t ${mutexName}_attributes = {
            #t.name = "${mutexName}",
            #t.cb_mem = &${mutexControl},
            #t.cb_size = sizeof(${mutexControl}),
            };
          [/#if]
        [/#if]
      [/#if]
     
      [#if variable.name=="RecursiveMutexes"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign mutexName = i]
          [/#if]
          [#if index == 1]
            [#assign mutexAllocation = i]
          [/#if]
          [#if index == 2]
            [#assign mutexControl = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if mutexName != "0"]
          /* Definitions for ${mutexName} */
          osMutexId_t ${mutexName}Handle;
          [#if mutexControl != "NULL"]
          osStaticMutexDef_t ${mutexControl};
          [/#if]
          [#-- Moved here, cf BZ 74919 --]
          [#if mutexAllocation == "Dynamic"]
            const osMutexAttr_t ${mutexName}_attributes = {
            #t.name = "${mutexName}",
            #t.attr_bits = osMutexRecursive, 
            };
          [#else]
            const osMutexAttr_t ${mutexName}_attributes = {
            #t.name = "${mutexName}",
            #t.attr_bits = osMutexRecursive, 
            #t.cb_mem = &${mutexControl},
            #t.cb_size = sizeof(${mutexControl}),
            };
          [/#if]
        [/#if]
      [/#if]
      
      [#if variable.name=="Timers"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign timerName = i]
          [/#if]
          [#if index == 1]
            [#assign timerCallback = i]
          [/#if]
          [#if index == 2]
            [#assign timerType = i]
          [/#if]
          [#if index == 3]
            [#assign generateCallback = i]
          [/#if]
          [#if index == 4]
            [#assign timerCodeGen = i]
          [/#if]
          [#if index == 5]
            [#assign timerParameters = i]
          [/#if]
          [#if index == 6]
            [#assign timerAllocation = i]
          [/#if]
          [#if index == 7]
            [#assign timerControlBlock = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if timerName != "0"]
          /* Definitions for ${timerName} */
          osTimerId_t ${timerName}Handle;
          [#if timerControlBlock != "NULL"]
          osStaticTimerDef_t ${timerControlBlock};
          [/#if]
          [#-- Moved here, cf BZ 74919 --]
          [#if timerAllocation == "Dynamic"]
          const osTimerAttr_t ${timerName}_attributes = {
          #t.name = "${timerName}"
          };
          [#else]
          const osTimerAttr_t ${timerName}_attributes = {
          #t.name = "${timerName}",
          #t.cb_mem = &${timerControlBlock},
          #t.cb_size = sizeof(${timerControlBlock}), 
          };
          [/#if]       
        [/#if]  
      [/#if]
      
      [#if variable.name=="Queues"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign queueName = i]
          [/#if]
          [#if index == 1]
            [#assign queueSize = i]
          [/#if]
          [#if index == 2]
            [#assign queueElementType = i]
          [/#if]
          [#if index == 3]
            [#assign queueIsIntegerType = i]
          [/#if]
          [#if index == 4]
            [#assign queueAllocation = i]
          [/#if]
          [#if index == 5]
            [#assign queueBuffer = i]
          [/#if]
          [#if index == 6]
            [#assign queueControlBlock = i]
          [/#if] 
          [#assign index = index + 1]
        [/#list] 
        [#if queueName != "0"]
           /* Definitions for ${queueName} */
           osMessageQueueId_t ${queueName}Handle;
          [#if queueControlBlock != "NULL"]
           [#if queueIsIntegerType = "0"]
           uint8_t ${queueBuffer}[ ${queueSize} * sizeof( ${queueElementType} ) ];
           [#else]
           uint8_t ${queueBuffer}[ ${queueSize} * ${queueElementType} ];
           [/#if]
           osStaticMessageQDef_t ${queueControlBlock};
          [/#if]
          [#-- Moved here, cf BZ 74919 --]
          [#if queueAllocation == "Dynamic"]
            const osMessageQueueAttr_t ${queueName}_attributes = {
            #t.name = "${queueName}"
            };
          [#else]
            const osMessageQueueAttr_t ${queueName}_attributes = {
            #t.name = "${queueName}",
            #t.cb_mem = &${queueControlBlock},
            #t.cb_size = sizeof(${queueControlBlock}),
            #t.mq_mem = &${queueBuffer},
            #t.mq_size = sizeof(${queueBuffer})         
            };
          [/#if]
        [/#if]  
      [/#if]
    
      [#if variable.name=="Semaphores"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign semaphoreName = i]
          [/#if]
          [#if index == 2]
            [#assign semaphoreAllocation = i]
          [/#if]
          [#if index == 3]
            [#assign semaphoreControl = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if semaphoreName != "0"]
          /* Definitions for ${semaphoreName} */
          osSemaphoreId_t ${semaphoreName}Handle;
          [#if semaphoreControl != "NULL"]
          osStaticSemaphoreDef_t ${semaphoreControl};
          [/#if]
          [#-- Moved here, cf BZ 74919 --]
          [#if semaphoreAllocation == "Dynamic"]
            const osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t.name = "${semaphoreName}"
            };
          [#else]
            const osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t.name = "${semaphoreName}",
            #t.cb_mem = &${semaphoreControl},
            #t.cb_size = sizeof(${semaphoreControl}),            
            };
          [/#if]
        [/#if]
      [/#if]
      
      [#if variable.name=="BinarySemaphores"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign semaphoreName = i]
          [/#if]
          [#if index == 1]
            [#assign semaphoreAllocation = i]
          [/#if]
          [#if index == 2]
            [#assign semaphoreControl = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if semaphoreName != "0"]
          /* Definitions for ${semaphoreName} */
          osSemaphoreId_t ${semaphoreName}Handle;
          [#if semaphoreControl != "NULL"]
          osStaticSemaphoreDef_t ${semaphoreControl};
          [/#if]
          [#-- Moved here, cf BZ 74919 --]
          [#if semaphoreAllocation == "Dynamic"]
            const osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t.name = "${semaphoreName}"
            };
          [#else]
            const osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t.name = "${semaphoreName}",
            #t.cb_mem = &${semaphoreControl},
            #t.cb_size = sizeof(${semaphoreControl}),            
            };
          [/#if]
        [/#if]
      [/#if]
      
      [#if variable.name=="Events"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign eventName = i]
          [/#if]
          [#if index == 1]
            [#assign eventAllocation = i]
          [/#if]
          [#if index == 2]
            [#assign eventControl = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if eventName != "0"]
          /* Definitions for ${eventName} */
          osEventFlagsId_t ${eventName}Handle;
          [#if eventControl != "NULL"]
          osStaticEventGroupDef_t ${eventControl};
          [/#if]
          [#if eventAllocation == "Dynamic"]
            const osEventFlagsAttr_t ${eventName}_attributes = {
            #t.name = "${eventName}"
            };
          [#else]
            const osEventFlagsAttr_t ${eventName}_attributes = {
            #t.name = "${eventName}",
            #t.cb_mem = &${eventControl},
            #t.cb_size = sizeof(${eventControl}),            
            };
          [/#if]          
          
        [/#if] 
      [/#if]
      
    [/#list] 
     
  [/#if]
[/#list]
[/#compress]
