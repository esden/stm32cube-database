[#ftl]
[#compress]
#include "FreeRTOS.h"
[#if FamilyName?lower_case == "stm32h7rs"]
    [#if S_LWIP == "false"]
        #include "cmsis_os2.h"
    [/#if]
[#else]
#include "cmsis_os2.h"
[/#if]
[/#compress]
