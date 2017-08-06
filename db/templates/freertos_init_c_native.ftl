[#ftl]
[#compress]

[#assign nbThreads = 0]
[#assign nbM = 0]
[#assign nbRM = 0]
[#assign nbTimers = 0]
[#assign nbQueues = 0]
[#assign nbSemaphores = 0]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
	[#list SWIP.variables as variable]
	  [#if variable.name=="Mutexes"]
	    [#assign s = variable.valueList]
        [#list s as mutexName]
        [#if mutexName != "0"]
          [#assign nbM = nbM + 1]
          [#if nbM == 1]
            #n#t/* Create the mutex(es) */
          [/#if]
          #t/* definition and creation of ${mutexName} */
          #t${mutexName}Handle = xSemaphoreCreateMutex(); 
          #n       
        [/#if]
        [/#list]
      [/#if] 	
	[/#list]
  [/#if]
[/#list]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
	[#list SWIP.variables as variable]
	  [#if variable.name=="RecursiveMutexes"]
	    [#assign s = variable.valueList]
        [#list s as mutexName]
        [#if mutexName != "0"]
          [#assign nbRM = nbRM + 1]
          [#if nbRM == 1]
            #n#t/* Create the recursive mutex(es) */
          [/#if]
          #t/* definition and creation of ${mutexName} */
          #t${mutexName}Handle = xSemaphoreCreateRecursiveMutex();
          #n       
        [/#if]
        [/#list]
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
            [#assign semaphoreCount = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if semaphoreName != "0"] 
          [#assign nbSemaphores = nbSemaphores + 1]
          [#if nbSemaphores == 1]
            #n#t/* Create the semaphores(s) */
          [/#if]
          #t/* definition and creation of ${semaphoreName} */        
          #t${semaphoreName}Handle = xSemaphoreCreateBinary();
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
          [#assign index = index + 1]
        [/#list]
        [#if semaphoreName != "0"] 
          [#assign nbSemaphores = nbSemaphores + 1]
          [#if nbSemaphores == 1]
            #n#t/* Create the semaphores(s) */
          [/#if]
          #t/* definition and creation of ${semaphoreName} */        
          #t${semaphoreName}Handle = xSemaphoreCreateCounting( ${semaphoreCount}, 0 );
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
          [#assign index = index + 1]
        [/#list]
        [#if timerName != "0"] 
          [#assign nbTimers = nbTimers + 1]
          [#if nbTimers == 1]
            #n#t/* Create the timer(s) */
          [/#if]
          #t/* definition and creation of ${timerName} */    
          [#if timerType == "osTimerPeriodic"]    
          #t${timerName}Handle = xTimerCreate("${timerName}", 1, pdTRUE, NULL, ${timerCallback});
          [#else]
          #t${timerName}Handle = xTimerCreate("${timerName}", 1, pdFALSE, NULL, ${timerCallback});
          [/#if]   
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
            [#assign threadInstances = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#assign nbThreads = nbThreads + 1]
        [#if nbThreads == 1]
          #n#t/* Create the thread(s) */
        [/#if]
        #t/* definition and creation of ${threadName} */
        #txTaskCreate( ${threadFunction}, "${threadName}", ${threadStackSize}, NULL, ${threadPriority} + 3, &${threadName}Handle );
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
            [#assign queueThreadId = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if queueName != "0"]       
          [#assign nbQueues = nbQueues + 1]
          [#if nbQueues == 1]
            #n#t/* Create the queue(s) */
          [/#if]
          #t/* definition and creation of ${queueName} */
          #t${queueName}Handle = xQueueCreate( ${queueSize}, sizeof( ${queueElementType} ) );
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

[/#compress]
