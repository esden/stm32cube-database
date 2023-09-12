[#ftl]
[#compress]
[#assign threadControlBlock = "NULL"]
[#assign mutexControl       = "NULL"]
[#assign timerControlBlock  = "NULL"]
[#assign queueControlBlock  = "NULL"]
[#assign semaphoreControl   = "NULL"]

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
         const osThreadAttr_t ${threadName}_attributes = {
         #t.name = "${threadName}",
         #t.priority = (osPriority_t) ${threadPriority},
         #t.stack_size = ${threadStackSize}
         };
        [#else]
         const osThreadAttr_t ${threadName}_attributes = {
         #t.name = "${threadName}",
         #t.stack_mem = &${threadBuffer}[0],
         #t.stack_size = sizeof(${threadBuffer}),
         #t.cb_mem = &${threadControlBlock},
         #t.cb_size = sizeof(${threadControlBlock}),
         #t.priority = (osPriority_t) ${threadPriority},
         };
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
      
    [/#list] 
     
  [/#if]
[/#list]
[/#compress]
