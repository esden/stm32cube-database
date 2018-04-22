[#ftl]
  /**
  ******************************************************************************
  * @file    STemWin_wrapper.c
  * @author  MCD Application Team
  * @brief   This file implements the configuration for the GUI library
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright © 2018 STMicroelectronics International N.V. 
  * All rights reserved.</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

#include "GUIDRV_FlexColor.h"
#include "STemWin_wrapper.h"

/*********************************************************************
*
*       Layer configuration (to be modified)
*
**********************************************************************
*/
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]


[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
	[#-- IF to take care of the specific formatting of each argument of this file  --]
        [#if definition.name = "Xsize_PHYS" ]
//
// Physical display size
//
#define XSIZE_PHYS  #t#t ${definition.value} 
[#-- ELSE IF --]
[#elseif definition.name = "Ysize_PHYS"]
#define YSIZE_PHYS  #t#t ${definition.value} 

extern volatile GUI_TIMER_TIME OS_TimeMS;
/*********************************************************************
*
*       Configuration checking
*
**********************************************************************
*/
#ifndef   VXSIZE_PHYS
  #define VXSIZE_PHYS XSIZE_PHYS
#endif
#ifndef   VYSIZE_PHYS
  #define VYSIZE_PHYS YSIZE_PHYS
#endif

/*********************************************************************
*
*       Defines, sfrs
*
**********************************************************************
*/
//
// COG interface register addr.
//

typedef struct
{
  __IO uint16_t REG;
  __IO uint16_t RAM;

}LCD_CONTROLLER_TypeDef;

/* The Bank address need to be entred by the USER */

[#-- ELSE IF --]
[#elseif definition.name = "STWin_Color_FrameBuffer_StartAdress_DBI"]
  

#define FMC_BANK_BASE  ((uint32_t)  #t#t ${definition.value}  )
#define FMC_BANK       ((LCD_CONTROLLER_TypeDef *) FMC_BANK_BASE)

/*********************************************************************
*
*       Local functions
*
**********************************************************************
*/

static void     FMC_BANK_WriteData(uint16_t Data);
static void     FMC_BANK_WriteReg(uint8_t Reg);
static uint16_t FMC_BANK_ReadData(void);

static void     LCDController_Init(void);

/********************************************************************
*
*       LcdWriteReg
*
* Function description:
*   Sets display register
*/
static void LcdWriteReg(U16 Data) 
{
  FMC_BANK_WriteReg(Data);
}

/********************************************************************
*
*       LcdWriteData
*
* Function description:
*   Writes a value to a display register
*/
static void LcdWriteData(U16 Data) 
{
  FMC_BANK_WriteData(Data);
}

/********************************************************************
*
*       LcdWriteDataMultiple
*
* Function description:
*   Writes multiple values to a display register.
*/
static void LcdWriteDataMultiple(U16 * pData, int NumItems) 
{
  while (NumItems--) 
  {
    FMC_BANK_WriteData(*pData++);
  }
}

/********************************************************************
*
*       LcdReadDataMultiple
*
* Function description:
*   Reads multiple values from a display register.
*/
static void LcdReadDataMultiple(U16 * pData, int NumItems) 
{
  while (NumItems--) 
  {
    *pData++ = FMC_BANK_ReadData();
  }
}


/*********************************************************************
*
*       LCD_X_Config
*
* Function description:
*   Called during the initialization process in order to set up the
*   display driver configuration.
*
*/
void LCD_X_Config(void) 
{
  GUI_DEVICE * pDevice;
  CONFIG_FLEXCOLOR Config = {0};
  GUI_PORT_API PortAPI = {0};

  /* Set display driver and color conversion */
[#-- ELSE IF --]
[#elseif definition.name = "FLEX_Color_Conversion"]
  pDevice = GUI_DEVICE_CreateAndLink(GUIDRV_FLEXCOLOR, ${definition.value} , 0, 0);
 
  /* Display driver configuration, required for Lin-driver */
  LCD_SetSizeEx (0, XSIZE_PHYS , YSIZE_PHYS);
  LCD_SetVSizeEx(0, VXSIZE_PHYS, VYSIZE_PHYS);

  /* supported parameters: GUI_SWAP_XY, GUI_MIRROR_X, GUI_MIRROR_Y or any combination of these paramters */
  /* Orientation */
[#elseif definition.name = "FLEX_Orientation"]
  Config.Orientation = ${definition.value};
    
 #if (NUM_BUFFERS > 1)
      GUI_MULTIBUF_ConfigEx(0, NUM_BUFFERS);
  #endif

  GUIDRV_FlexColor_Config(pDevice, &Config);
  //
  // Set controller and operation mode
  //
  PortAPI.pfWrite16_A0  = LcdWriteReg;
  PortAPI.pfWrite16_A1  = LcdWriteData;
  PortAPI.pfWriteM16_A1 = LcdWriteDataMultiple;
  PortAPI.pfReadM16_A1  = LcdReadDataMultiple;

[#elseif definition.name = "FLEX_Display_Driver"]
[#assign displayDriver = definition.value] 

[#elseif definition.name = "FLEX_Display_Controller_Mode"]
[#assign controllerMode = definition.value] 

  GUIDRV_FlexColor_SetFunc(pDevice, &PortAPI, ${displayDriver} , ${controllerMode});

[/#if]
[/#list]
[/#if]
[/#list] 
}


/*********************************************************************
*
*       LCD_X_DisplayDriver
*
* Function description:
*   This function is called by the display driver for several purposes.
*   To support the according task the routine needs to be adapted to
*   the display controller. Please note that the commands marked with
*   'optional' are not cogently required and should only be adapted if
*   the display controller supports these features.
*
* Parameter:
*   LayerIndex - Index of layer to be configured
*   Cmd        - Please refer to the details in the switch statement below
*   pData      - Pointer to a LCD_X_DATA structure
*
* Return Value:
*   < -1 - Error
*     -1 - Command not handled
*      0 - Ok
*/
int LCD_X_DisplayDriver(unsigned LayerIndex, unsigned Cmd, void * pData) {
  int r;
  (void) LayerIndex;
  (void) pData;
  
  switch (Cmd) {
  case LCD_X_INITCONTROLLER: {
   
    /* Component Initialization */
    LCDController_Init(); 
    
    return 0;
  }
  default:
    r = -1;
  }
  return r;
}

/**
  * @brief  Writes register value.
  * @param  Data: 
  * @retval None
  */
static void FMC_BANK_WriteData(uint16_t Data) 
{
  /* Write 16-bit Reg */
  FMC_BANK->RAM = Data;
}

/**
  * @brief  Writes register address.
  * @param  Reg: 
  * @retval None
  */
static void FMC_BANK_WriteReg(uint8_t Reg) 
{
  /* Write 16-bit Index, then write register */
  FMC_BANK->REG = Reg;
}

/**
  * @brief  Reads register value.
  * @param  None
  * @retval Read value
  */
static uint16_t FMC_BANK_ReadData(void) 
{
  return FMC_BANK->RAM;
}


void GRAPHICS_IncTick(void){
  
    OS_TimeMS++;
} 

void GRAPHICS_HW_Init(void)
{ 
  MX_FMC_Init();  
}

void GRAPHICS_Init(void)
{ 
 
  /* Initialize the GUI */
  GUI_Init();
   
  /* Activate the use of memory device feature */
     /* USER CODE BEGIN memory_device */

       //WM_SetCreateFlags(WM_CF_MEMDEV);

     /* USER CODE END memory_device */
}

/**
  * @brief  Initializes the LCD.
  * @param  None
  * @retval None
  */
static void LCDController_Init(void)
{ 
/* special hardware initialization may be needed before controller iniialization */

/* Initialize LCD controller */
    /* USER CODE BEGIN LCD_controller */

         //component_init();

    /* USER CODE END LCD_controller */

}
  
/*************************** End of file ****************************/

