[#ftl]
/*********************************************************************
*                SEGGER MICROCONTROLLER SYSTEME GmbH                 *
*        Solutions for real time microcontroller applications        *
**********************************************************************
*                                                                    *
*        (c) 1996 - 2004  SEGGER Microcontroller Systeme GmbH        *
*                                                                    *
*        Internet: www.segger.com    Support:  support@segger.com    *
*                                                                    *
**********************************************************************

***** emWin - Graphical user interface for embedded applications *****
emWin is protected by international copyright laws.   Knowledge of the
source code may not be used to write a similar product.  This file may
only be used in accordance with a license and should not be re-
distributed in any way. We appreciate your understanding and fairness.
----------------------------------------------------------------------
File        : GUI_App.c
Purpose     : Simple demo drawing "Hello world"
----------------------------------------------------------------------
*/

#include "GUI_App.h"

/*********************************************************************
*
*       Public code
*
**********************************************************************
*/
/*********************************************************************
*
*       MainTask
*/
[#assign GFXType = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
    [#-- Global variables --]        
        [#if SWIP.defines??]
                [#list SWIP.defines as definition]	
                [#-- IF to take care of the specific formatting of each argument of this file  --]
                       [#if definition?? && definition.name == "EA_1_Apptype" ]
                            [#if definition??][#assign GFXType = definition.value] [/#if]
                        [/#if]
                [/#list]
        [/#if]
    [/#list]
[/#if]
[#if GFXType == "FrameWindow"||GFXType == "Window"]
#include "DIALOG.h"
[/#if]
[#if GFXType == "FrameWindow"]
extern  WM_HWIN CreateFramewin(void); 
[/#if]
[#if GFXType == "Window"]
extern  WM_HWIN CreateWindow(void);  
[/#if]  
  #n
  #n
void GRAPHICS_MainTask(void) {
[#if GFXType == "FrameWindow"]
  /* 1- Create a FrameWin using GUIBuilder */
  CreateFramewin();
[/#if]
[#if GFXType == "Window"]
  /* 2- Create a Window using GUIBuilder */
  CreateWindow();
[/#if]  
/* USER CODE BEGIN GRAPHICS_MainTask */
 /* User can implement his graphic application here */
  /* Hello Word example */
  /*GUI_Clear();
    GUI_SetColor(GUI_WHITE);
    GUI_SetFont(&GUI_Font32_1);
    GUI_DispStringAt("Hello world!", (LCD_GetXSize()-150)/2, (LCD_GetYSize()-20)/2);
    */
/* USER CODE END GRAPHICS_MainTask */
  while(1)
{
      GUI_Delay(100);
}
}

/*************************** End of file ****************************/
