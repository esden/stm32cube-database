[#ftl]
[#assign coreDir=sourceDir]
  /**
  ******************************************************************************
  * @file    HW_Init.c
  * @author  MCD Application Team
  * @brief   This file implements the hardware configuration for the GUI library
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2018 STMicroelectronics International N.V. 
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

/* Includes ------------------------------------------------------------------*/
#include "HW_Init.h"

/** @addtogroup HARDWARE CONFIGURATION
* @{
*/

/** @defgroup HARDWARE CONFIGURATION_Private_Variables
* @{
*/
LTDC_HandleTypeDef            hltdc; 
[#assign  UseQuadSPI ="0"]
[#assign USE_EmbeddedWizard="0"]
[#assign USE_STTouchGFX="0"]
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
[#if definition.name = "USE_Embedded_Wizard"]
[#if definition.value != "0" ]
[#assign USE_EmbeddedWizard="1"]
[/#if]
[#elseif definition.name = "USE_STTouchGFX"]
[#if definition.value != "0" ]
[#assign USE_STTouchGFX="1"]
[/#if]
[#elseif definition.name = "DMA2D_Graphics" ]
[#if definition.value != "0"  ]
[#assign dma2dvalue="1"] 
DMA2D_HandleTypeDef           hdma2d;
[/#if]
DSI_HandleTypeDef             hdsi;
[#assign UseSDRAM="0"]
[#-- ELSE IF --]
[#elseif definition.name = "Use_SDRAM"]
[#if definition.value != "0" ]
[#assign UseSDRAM="1"]
  [#if definition.value == "SDRAM1_BANK1" | definition.value == "SDRAM2_BANK1"  ]
  [#assign UseSDRAM="1"] 
  [#assign AutoRefreshNumber ="8"] 
  [#assign sdramBank ="FMC_SDRAM_CMD_TARGET_BANK1"] 
   [/#if]
   [#if definition.value == "SDRAM1_BANK2" |  definition.value == "SDRAM2_BANK2" ]
   [#assign UseSDRAM="1"] 
   [#assign AutoRefreshNumber ="4"] 
   [#assign sdramBank ="FMC_SDRAM_CMD_TARGET_BANK2"] 
   [/#if]
[#if definition.value == "SDRAM1_BANK1" | definition.value == "SDRAM1_BANK2"]
                    [#assign  hsdramvalue="hsdram1"]
[/#if]
[#if definition.value == "SDRAM2_BANK1" | definition.value == "SDRAM2_BANK2"]
                     [#assign  hsdramvalue="hsdram2"]
[/#if]
[/#if]
[#if USE_EmbeddedWizard?? && USE_EmbeddedWizard =="1"] 
LTDC_LayerCfgTypeDef          pLayerCfg;
[/#if] 

[@common.optinclude name="ST-EmbeddedWizard/Ew_QUADSPI_tmp.c"/] 

[@common.optinclude name=coreDir+"Src/fmc_vars.tmp"/] 
[#-- ELSE IF --]
[#elseif definition.name = "RefreshCount_SDRAM_Param"]
[#if definition.value != "0" ]
static FMC_SDRAM_CommandTypeDef Command;

#define REFRESH_COUNT   #t#t ${definition.value}

#define SDRAM_TIMEOUT                            ((uint32_t)0xFFFF)
#define SDRAM_MODEREG_BURST_LENGTH_1             ((uint16_t)0x0000)
#define SDRAM_MODEREG_BURST_LENGTH_2             ((uint16_t)0x0001)
#define SDRAM_MODEREG_BURST_LENGTH_4             ((uint16_t)0x0002)
#define SDRAM_MODEREG_BURST_LENGTH_8             ((uint16_t)0x0004)
#define SDRAM_MODEREG_BURST_TYPE_SEQUENTIAL      ((uint16_t)0x0000)
#define SDRAM_MODEREG_BURST_TYPE_INTERLEAVED     ((uint16_t)0x0008)
#define SDRAM_MODEREG_CAS_LATENCY_2              ((uint16_t)0x0020)
#define SDRAM_MODEREG_CAS_LATENCY_3              ((uint16_t)0x0030)
#define SDRAM_MODEREG_OPERATING_MODE_STANDARD    ((uint16_t)0x0000)
#define SDRAM_MODEREG_WRITEBURST_MODE_PROGRAMMED ((uint16_t)0x0000) 
#define SDRAM_MODEREG_WRITEBURST_MODE_SINGLE     ((uint16_t)0x0200) 
[/#if]

 [#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
 
 [#assign file1 = objectConstructor("java.io.File",workspace+"/"+"ST-EmbeddedWizard/Ew_QUADSPI_tmp.c")]
 [#assign file2 = objectConstructor("java.io.File",workspace+"/"+"ST-TouchGFX/Ew_QUADSPI_tmp.c")]
 
  [#if file1.exists() | file2.exists()]
  [#assign  UseQuadSPI ="1"]

/* QSPI Error codes */
/*    #define QSPI_OK            ((uint8_t)0x00) 
    #define QSPI_ERROR         ((uint8_t)0x01)
*/
[/#if]




[#if dma2dvalue?? && dma2dvalue=="1" ]



/**
  * @brief  Initialize the DMA2D.
  * @param  None
  * @retval None
  */
void MX_DMA2D_Init(void) 
{
   /* Configure the DMA2D default mode */ 
 [@common.optinclude name=coreDir+"Src/dma2d_HalInit.tmp"/] 
}
[/#if]
/**
  * @brief  Initialize the LCD Controller.
  * @param  LayerIndex : layer Index.
  * @retval None
  */
void MX_LCD_Init(void) 
{
[#if USE_EmbeddedWizard !="1"]
  LTDC_LayerCfgTypeDef             pLayerCfg;
[/#if]
   [#-- ELSE IF --]
[#elseif definition.name = "GUI_NUM_LAYERS"]
 [#if definition.value == "2" ]
  LTDC_LayerCfgTypeDef pLayerCfg1;
[/#if]


/* De-Initialize LTDC */
  HAL_LTDC_DeInit(&hltdc);
/* Configure LTDC */
 [@common.optinclude name=coreDir+"Src/ltdc_HalInit.tmp"/] 
}

 
[#if   UseSDRAM?? && UseSDRAM!="0"    ]
/**
  * @brief  Initializes LCD IO.
  */ 
void MX_FMC_Init(void) 
{  
 [@common.optinclude name=coreDir+"Src/fmc_HalInit.tmp"/] 
}
[/#if]
[#if  UseSDRAM?? && UseSDRAM!="0" ]
/**
  * @brief  Programs the SDRAM device.
  * @retval None
  */
void MX_SDRAM_InitEx(void)
{
  __IO uint32_t tmpmrd = 0;
  
  /* Step 1: Configure a clock configuration enable command */
  Command.CommandMode            = FMC_SDRAM_CMD_CLK_ENABLE;
  Command.CommandTarget          =  ${sdramBank};
  Command.AutoRefreshNumber      = 1;
  Command.ModeRegisterDefinition = 0;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);

  /* Step 2: Insert 100 us minimum delay */ 
  /* Inserted delay is equal to 1 ms due to systick time base unit (ms) */
  HAL_Delay(1);
    
  /* Step 3: Configure a PALL (precharge all) command */ 
  Command.CommandMode            = FMC_SDRAM_CMD_PALL;
  Command.CommandTarget          = ${sdramBank};
  Command.AutoRefreshNumber      = 1;
  Command.ModeRegisterDefinition = 0;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);  
  
  /* Step 4: Configure an Auto Refresh command */ 
  Command.CommandMode            = FMC_SDRAM_CMD_AUTOREFRESH_MODE;
  Command.CommandTarget          = ${sdramBank};
  Command.AutoRefreshNumber      = ${AutoRefreshNumber};
  Command.ModeRegisterDefinition = 0;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);
  
  /* Step 5: Program the external memory mode register */
  tmpmrd = (uint32_t)SDRAM_MODEREG_BURST_LENGTH_1          |\
                     SDRAM_MODEREG_BURST_TYPE_SEQUENTIAL   |\
                     SDRAM_MODEREG_CAS_LATENCY_3           |\
                     SDRAM_MODEREG_OPERATING_MODE_STANDARD |\
                     SDRAM_MODEREG_WRITEBURST_MODE_SINGLE;

  Command.CommandMode            = FMC_SDRAM_CMD_LOAD_MODE;
  Command.CommandTarget          = ${sdramBank};
  Command.AutoRefreshNumber      = 1;
  Command.ModeRegisterDefinition = tmpmrd;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);
  
  /* Step 6: Set the refresh rate counter */
  /* Set the device refresh rate */
  HAL_SDRAM_ProgramRefreshRate(&${hsdramvalue}, REFRESH_COUNT); 
}

[/#if]

/* DSI init function */
void MX_DSI_Init(void)
{
  DSI_PHY_TimerTypeDef      PhyTimings;
  DSI_HOST_TimeoutTypeDef   HostTimeouts;
  DSI_CmdCfgTypeDef         CmdCfg;
  DSI_LPCmdTypeDef          LPCmd;
  DSI_PLLInitTypeDef        PLLInit;
  
/* Base address of DSI Host/Wrapper registers to be set before calling De-Init */

 
[@common.optinclude name=coreDir+"Src/dsihost_HalInit.tmp"/]  
 
 /* Start DSI */
  HAL_DSI_Start(&(hdsi));

[#assign OTM="0"] 
[#elseif definition.name = "OTM8009A_Orientation" ]
[#if definition.value != "0" ]
[#assign OTM="1"] 

  /* Initialize the OTM8009A LCD Display IC Driver (KoD LCD IC Driver)
   *  depending on configuration set in 'hdsivideo_handle'.
   */

  /* Send Display off DCS Command to display */
  HAL_DSI_ShortWrite(&(hdsi),
                     0,
                     DSI_DCS_SHORT_PKT_WRITE_P1,
                     OTM8009A_CMD_DISPOFF,
                     0x00);

  OTM8009A_Init(OTM8009A_FORMAT, ${definition.value});
[/#if]
[#if OTM?? && OTM == "0" ]
/* Initialize the  LCD Display IC Driver (KoD LCD IC Driver)
   *  depending on configuration set in 'hdsivideo_handle'.
   */

[/#if]

  LPCmd.LPGenShortWriteNoP    = DSI_LP_GSW0P_DISABLE;
  LPCmd.LPGenShortWriteOneP   = DSI_LP_GSW1P_DISABLE;
  LPCmd.LPGenShortWriteTwoP   = DSI_LP_GSW2P_DISABLE;
  LPCmd.LPGenShortReadNoP     = DSI_LP_GSR0P_DISABLE;
  LPCmd.LPGenShortReadOneP    = DSI_LP_GSR1P_DISABLE;
  LPCmd.LPGenShortReadTwoP    = DSI_LP_GSR2P_DISABLE;
  LPCmd.LPGenLongWrite        = DSI_LP_GLW_DISABLE;
  LPCmd.LPDcsShortWriteNoP    = DSI_LP_DSW0P_DISABLE;
  LPCmd.LPDcsShortWriteOneP   = DSI_LP_DSW1P_DISABLE;
  LPCmd.LPDcsShortReadNoP     = DSI_LP_DSR0P_DISABLE;
  LPCmd.LPDcsLongWrite        = DSI_LP_DLW_DISABLE;
  HAL_DSI_ConfigCommand(&hdsi, &LPCmd);

  /* Refresh the display */
  HAL_DSI_Refresh(&hdsi);
    
  }
[#if USE_EmbeddedWizard?? && USE_EmbeddedWizard =="1"] 

/**
  * @brief  DCS or Generic short/long write command
  * @param  NbParams: Number of parameters. It indicates the write command mode:
  *                 If inferior to 2, a long write command is performed else short.
  * @param  pParams: Pointer to parameter values table.
  * @retval HAL status
  */
void DSI_IO_WriteCmd(uint32_t NbrParams, uint8_t *pParams)
{
  if(NbrParams <= 1)
  {
    HAL_DSI_ShortWrite(&hdsi, 0, DSI_DCS_SHORT_PKT_WRITE_P1, pParams[0], pParams[1]); 
  }
  else
  {
    HAL_DSI_LongWrite(&hdsi,  0, DSI_DCS_LONG_PKT_WRITE, NbrParams, pParams[NbrParams], pParams); 
  } 
}
[/#if]

  [#if UseQuadSPI?? &&  UseQuadSPI =="1"]
/**
  * @brief  Configure the QSPI in memory-mapped mode
  * @retval QSPI memory status
  */

/* USER CODE BEGIN Configure_QSPI */

/* uint8_t QSPI_EnableMemoryMappedMode(void)
{

  QSPI_CommandTypeDef      s_command;
  QSPI_MemoryMappedTypeDef s_mem_mapped_cfg;

  // Configure the command for the read instruction 
  s_command.InstructionMode   = QSPI_INSTRUCTION_4_LINES;
  s_command.Instruction       = 0xEC;
  s_command.AddressMode       = QSPI_ADDRESS_4_LINES;
  s_command.AddressSize       = QSPI_ADDRESS_32_BITS;
  s_command.AlternateByteMode = QSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode          = QSPI_DATA_4_LINES;
  s_command.DummyCycles       = 10;
  s_command.DdrMode           = QSPI_DDR_MODE_DISABLE;
  s_command.DdrHoldHalfCycle  = QSPI_DDR_HHC_ANALOG_DELAY;
  s_command.SIOOMode          = QSPI_SIOO_INST_EVERY_CMD;
  
  // Configure the memory mapped mode 
  s_mem_mapped_cfg.TimeOutActivation = QSPI_TIMEOUT_COUNTER_DISABLE;
  s_mem_mapped_cfg.TimeOutPeriod     = 0;
  
  if (HAL_QSPI_MemoryMapped(&hqspi, &s_command, &s_mem_mapped_cfg) != HAL_OK)
  {
    return QSPI_ERROR;
  }   
  return QSPI_OK;
}*/

/* USER CODE END Configure_QSPI */


 [/#if]

  /*  MSPInit/deInit Implementation */
[@common.optinclude name=coreDir+"Src/ltdc_MSP.tmp"/] 
[@common.optinclude name=coreDir+"Src/dsihost_MSP.tmp"/] 
[#if dma2dvalue?? && dma2dvalue=="1"]
[@common.optinclude name=coreDir+"Src/dma2d_MSP.tmp"/] 
[/#if]
[#if   UseSDRAM?? && UseSDRAM!="0"    ]
[@common.optinclude name=coreDir+"Src/fmc_MSP.tmp"/] 
[/#if]

[/#if]
[/#list]
[/#if]
[/#list]
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
