[#ftl]
[#compress]
[#assign threadControlBlock = "NULL"]
[#assign nbThreads = 0]
[#assign nbM = 0]
[#assign nbRM = 0]
[#assign nbTimers = 0]
[#assign nbQueues = 0]
[#assign nbSemaphores = 0]
[#assign mutexControl = "NULL"] 
[#assign threadAllocation = "Dynamic"]
[#assign mutexAllocation = "Dynamic"]
[#assign semaphoreAllocation = "Dynamic"]
[#assign queueAllocation = "Dynamic"]
[#assign timerAllocation = "Dynamic"]
[#assign queueThreadId = "NULL"]
[#assign apiUsed = "0"]  [#-- Default is CMSIS-RTOS-V1 --]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
      [#if variable.name=="FreeRTOS_API"]
        [#assign apiUsed = variable.valueList]
      [/#if] 	
    [/#list]
  [/#if] 
[/#list]

osKernelInitialize();                 // Initialize CMSIS-RTOS

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
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
          [#assign nbM = nbM + 1]
          [#if nbM == 1]
            #n#t/* Create the mutex(es) */
          [/#if]
            #t/* definition and creation of ${mutexName} */
          [#if mutexAllocation == "Dynamic"]
            #tconst osMutexAttr_t ${mutexName}_attributes = {
            #t#t.name = "${mutexName}"
            #t};
          [#else]
            #tconst osMutexAttr_t ${mutexName}_attributes = {
            #t#t.name = "${mutexName}",
            #t#t.cb_mem = &${mutexControl},
            #t#t.cb_size = sizeof(${mutexControl}),
            #t};
          [/#if]
            #t${mutexName}Handle = osMutexNew(&${mutexName}_attributes);
            #n
        [/#if]
      [/#if] 	
    [/#list]
  [/#if] 
[/#list]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
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
          [#assign nbRM = nbRM + 1]
          [#if nbRM == 1]
            #n#t/* Create the recursive mutex(es) */
          [/#if]
            #t/* definition and creation of ${mutexName} */
          [#if mutexAllocation == "Dynamic"]
            #tconst osMutexAttr_t ${mutexName}_attributes = {
            #t#t.name = "${mutexName}",
            #t#t.attr_bits = osMutexRecursive, 
            #t};
          [#else]
            #tconst osMutexAttr_t ${mutexName}_attributes = {
            #t#t.name = "${mutexName}",
            #t#t.attr_bits = osMutexRecursive, 
            #t#t.cb_mem = &${mutexControl},
            #t#t.cb_size = sizeof(${mutexControl}),
            #t};
          [/#if]
            #t${mutexName}Handle = osMutexNew(&${mutexName}_attributes);
            #n
        [/#if]
      [/#if] 	
    [/#list]
  [/#if] 
[/#list]

#n
#t/* USER CODE BEGIN RTOS_MUTEX */
#t/* add mutexes, ... */         
#t/* USER CODE END RTOS_MUTEX */

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
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
          [#assign nbSemaphores = nbSemaphores + 1]
          [#if nbSemaphores == 1]
            #n#t/* Create the semaphores(s) */
          [/#if]
            #t/* definition and creation of ${semaphoreName} */
          [#if semaphoreAllocation == "Dynamic"]
            #tconst osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t#t.name = "${semaphoreName}"
            #t};
          [#else]
            #tconst osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t#t.name = "${semaphoreName}",
            #t#t.cb_mem = &${semaphoreControl},
            #t#t.cb_size = sizeof(${semaphoreControl}),            
            #t};
          [/#if]
          #t${semaphoreName}Handle = osSemaphoreNew(1, 1, &${semaphoreName}_attributes);
          #n
        [/#if]
      [/#if]
    [/#list]
  [/#if]
[/#list]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
      [#if variable.name=="Semaphores"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign semaphoreName = i]
          [/#if]
          [#if index == 1]
            [#assign semaphoreCount = i]
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
          [#assign nbSemaphores = nbSemaphores + 1]
          [#if nbSemaphores == 1]
            #n#t/* Create the semaphores(s) */
          [/#if]
          #t/* definition and creation of ${semaphoreName} */
          [#if semaphoreAllocation == "Dynamic"]
            #tconst osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t#t.name = "${semaphoreName}"
            #t};
          [#else]
            #tconst osSemaphoreAttr_t ${semaphoreName}_attributes = {
            #t#t.name = "${semaphoreName}",
            #t#t.cb_mem = &${semaphoreControl},
            #t#t.cb_size = sizeof(${semaphoreControl}),            
            #t};
          [/#if]
          #t${semaphoreName}Handle = osSemaphoreNew(${semaphoreCount}, ${semaphoreCount}, &${semaphoreName}_attributes);
          #n
        [/#if]
      [/#if]
    [/#list]
  [/#if]
[/#list]

#n
#t/* USER CODE BEGIN RTOS_SEMAPHORES */
#t/* add semaphores, ... */               
#t/* USER CODE END RTOS_SEMAPHORES */

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
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
          [#assign nbTimers = nbTimers + 1]
          [#if nbTimers == 1]
            #n#t/* Create the timer(s) */
          [/#if]
          #t/* definition and creation of ${timerName} */   
          [#if timerAllocation == "Dynamic"]
          #tconst osTimerAttr_t ${timerName}_attributes = {
          #t#t.name = "${timerName}"
          #t};
          [#else]
          #tconst osTimerAttr_t ${timerName}_attributes = {
          #t#t.name = "${timerName}",
          #t#t.cb_mem = &${timerControlBlock},
          #t#t.cb_size = sizeof(${timerControlBlock}), 
          #t};
          [/#if]
          #t${timerName}Handle = osTimerNew(${timerCallback}, ${timerType}, ${timerParameters}, &${timerName}_attributes);
          #n
        [/#if]
      [/#if]
	[/#list]
  [/#if]
[/#list]

#n
#t/* USER CODE BEGIN RTOS_TIMERS */
#t/* start timers, add new ones, ... */
#t/* USER CODE END RTOS_TIMERS */

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
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
          [#assign nbQueues = nbQueues + 1]
          [#if nbQueues == 1]
            #n#t/* Create the queue(s) */
          [/#if]
          #t/* definition and creation of ${queueName} */
          [#if queueAllocation == "Dynamic"]
            #tconst osMessageQueueAttr_t ${queueName}_attributes = {
            #t#t.name = "${queueName}"
            #t};
          [#else]
            #tconst osMessageQueueAttr_t ${queueName}_attributes = {
            #t#t.name = "${queueName}",
            #t#t.cb_mem = &${queueControlBlock},
            #t#t.cb_size = sizeof(${queueControlBlock}),
            #t#t.mq_mem = &${queueBuffer},
            #t#t.mq_size = sizeof(${queueBuffer})         
            #t};
          [/#if]
          [#-- what about the sizeof here??? cd native code  --]
          [#if queueIsIntegerType = "0"]
          #t${queueName}Handle = osMessageQueueNew (${queueSize}, sizeof(${queueElementType}), &${queueName}_attributes);
          [#else]
          #t${queueName}Handle = osMessageQueueNew (${queueSize}, ${queueElementType}, &${queueName}_attributes);
          [/#if]
          #n
        [/#if]
      [/#if]
	[/#list]
  [/#if]
[/#list]
      
#n
#t/* USER CODE BEGIN RTOS_QUEUES */
#t/* add queues, ... */          
#t/* USER CODE END RTOS_QUEUES */

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
        [#assign nbThreads = nbThreads + 1]
        [#if nbThreads == 1]
          #n#t/* Create the thread(s) */
        [/#if]
        #t/* definition and creation of ${threadName} */
        [#if threadAllocation == "Dynamic"]
         #tconst osThreadAttr_t ${threadName}_attributes = {
         #t#t.name = "${threadName}",
         #t#t.priority = (osPriority_t) ${threadPriority},
         #t#t.stack_size = ${threadStackSize}
         #t};
        [#else]
         #tconst osThreadAttr_t ${threadName}_attributes = {
         #t#t.name = "${threadName}",
         #t#t.stack_mem = &${threadBuffer}[0],
         #t#t.stack_size = sizeof(${threadBuffer}),
         #t#t.cb_mem = &${threadControlBlock},
         #t#t.cb_size = sizeof(${threadControlBlock}),
         #t#t.priority = (osPriority_t) ${threadPriority},
         #t};
        [/#if]
         #t${threadName}Handle = osThreadNew(${threadFunction}, NULL, &${threadName}_attributes);
         #n
      [/#if]
	[/#list]
  [/#if]
[/#list]

#n
#t/* USER CODE BEGIN RTOS_THREADS */
#t/* add threads, ... */          
#t/* USER CODE END RTOS_THREADS */
#n

[/#compress]