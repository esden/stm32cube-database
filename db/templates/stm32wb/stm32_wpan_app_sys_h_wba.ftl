#ifndef APP_SYS_H
#define APP_SYS_H

/*
 * high ceil for standby exit -> 500us in theory NOTE: Minimum value for UTIL Timer is 1ms
 * high ceil for radio exit deep sleep -> 300us
 * high ceil for radio entry deep ceil -> 50us
 */
#define SYSTEM_IDLE_THRESHOLD_US (2 * 1000)
#define RADIO_IDLE_THRESHOLD_US (2000 + 50)

void APP_SYS_LPM_Init(void);
void APP_SYS_LPM_EnterLowPowerMode(void);

void APP_SYS_LinkLayer_BackgroundProcessInit(void);

#endif /* APP_SYS_H */