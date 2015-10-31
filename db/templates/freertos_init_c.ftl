[#ftl]
[#compress]
#t/* Init code generated for FreeRTOS */
#t/* Create Start thread */
#tosThreadDef(USER_Thread, StartThread, osPriorityNormal, 0, configMINIMAL_STACK_SIZE);
#tosThreadCreate (osThread(USER_Thread), NULL);
#n#t/* Start scheduler */
#tosKernelStart(NULL, NULL);
#n#t/* We should never get here as control is now taken by the scheduler */
#n
[/#compress]
