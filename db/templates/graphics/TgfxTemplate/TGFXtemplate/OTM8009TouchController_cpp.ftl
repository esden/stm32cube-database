
#include <OTM8009TouchController.hpp>
#n
/* USER CODE BEGIN user includes */

/* USER CODE END user includes */
#n
extern "C"
{

uint32_t LCD_GetXSize();
uint32_t LCD_GetYSize();
}

void OTM8009TouchController::init()
{
/* USER CODE BEGIN OTM8009TouchController_init */
    /* Add code for touch controller Initialization */
   /* BSP_TS_Init(LCD_GetXSize(), LCD_GetYSize()); */
    
/* USER CODE END OTM8009TouchController_init */
}

bool OTM8009TouchController::sampleTouch(int32_t& x, int32_t& y)
{
/* USER CODE BEGIN OTM8009TouchController_sampleTouch */
   /* TS_StateTypeDef state;
      BSP_TS_GetState(&state);
      if (state.touchDetected)
      {
       x = state.touchX[0];
       y = state.touchY[0];
       return true;
    }
*/
    return false; 
/* USER CODE END OTM8009TouchController_sampleTouch */
}
