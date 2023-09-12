[#ftl]
#include "STM32H7TouchController.hpp"
#include "stm32h7xx.h"


#n
/* USER CODE BEGIN BSP user includes */

/* USER CODE END BSP user includes */
#n
extern "C"
{
uint32_t LCD_GetXSize();
uint32_t LCD_GetYSize();

}

using namespace touchgfx;

void STM32H7TouchController::init()
{
 /* USER CODE BEGIN H7TouchController_init */

  /* Add code for touch controller Initialization */
  
  /*
   BSP_TS_Init(LCD_GetXSize(), LCD_GetYSize());
 */

/* USER CODE END H7TouchController_init */
}
static int32_t lastTime, lastX, lastY;

bool STM32H7TouchController::sampleTouch(int32_t& x, int32_t& y)
{
/* USER CODE BEGIN  H7TouchController_sampleTouch  */

   /*
    TS_StateTypeDef state = { 0 };
    unsigned int time;
    BSP_TS_GetState(&state);
    if (state.touchDetected)
    {
        x = lastX = state.x;
        y = lastY = state.y;
        lastTime = HAL_GetTick();

        return true;

    }
     time = HAL_GetTick();
     if (((lastTime + 120) > time)
        && (lastX > 0) && (lastY > 0)) {
        x = lastX;
        y = lastY;
        return true;
    }

    */
    return false; 

/* USER CODE END H7TouchController_sampleTouch  */
}
