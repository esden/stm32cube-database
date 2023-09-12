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
            #t/* Create the mutex(es) */
          [/#if]
            #t/* creation of ${mutexName} */
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
            #t/* creation of ${mutexName} */
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
          #t/* creation of ${semaphoreName} */
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
          #t/* creation of ${semaphoreName} */
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
          #t/* creation of ${timerName} */
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
          #t/* creation of ${queueName} */
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
        #t/* creation of ${threadName} */
        #t${threadName}Handle = osThreadNew(${threadFunction}, ${threadArguments}, &${threadName}_attributes); 
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

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
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
          [#assign nbM = nbM + 1]
          [#if nbM == 1]
            #t/* Create the event(s) */
          [/#if]
            #t/* creation of ${eventName} */
            #t${eventName}Handle = osEventFlagsNew(&${eventName}_attributes);
            #n
        [/#if]
      [/#if]
    [/#list]
  [/#if] 
[/#list]

#n
#t/* USER CODE BEGIN RTOS_EVENTS */
#t/* add events, ... */          
#t/* USER CODE END RTOS_EVENTS */
#n

[/#compress]
