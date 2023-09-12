[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${name}
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : This file implements the board support package for the USB device library
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
[#if SWIncludes??]
[#list SWIncludes as include]
#include "${include}"
[/#list]
[/#if]
#include "usbd_core.h"

[#assign handleNameFS = ""]
[#assign handleNameUSB_FS = ""]
[#assign handleNameHS = ""]
[#assign instanceNb = 0]
[#assign includeMspDone = 0]
[#assign className = ""]
[#assign useLPM = false]
[#assign useBCD=false]
[#assign BspUsed = false]
[#-- IPdatas is a list of IPconfigModel --]
[#if configs??]
   [#list configs as config]
        [#list config.peripheralParams?keys as PeripheralParams]
            [#if PeripheralParams=="USB"]
                [#assign values = config.peripheralParams[PeripheralParams]][#-- values is a hash list --]
                [#if values["battery_charging_enable"]=="ENABLE"]	
[#assign useBCD=true]			 
                [/#if]
            [/#if]
        [/#list]
    [/#list]
 [/#if]
 
[#assign IpInstance = ""]
[#assign ExtiLine = ""]
[#assign IrqNumber = ""]
[#assign IpName = ""]


[#assign BCD_PORT = ""]
[#assign BCD_PIN = ""]
[#assign BCD_IRQn = ""]
[#assign BCD_EXTI = ""]

[#if BspIpDatas??]
[#list BspIpDatas as SWIP] 
	[#if SWIP.variables??]
[#assign BspUsed = true]	
		[#list SWIP.variables as variables]
			[#if variables.name?contains("IpInstance")]
				[#assign IpInstance = variables.value]
			[/#if]		
			[#if variables.name?contains("IpName")]
				[#assign IpName = variables.value]				
			[/#if]	
			[#if variables.name?contains("GPIO_INT_NUM")]
				[#assign IrqNumber = variables.value]				
			[/#if]					
			[#if variables.name?contains("EXTI_LINE_NUMBER")]
				[#assign ExtiLine = variables.value]
			[/#if]
			[#if variables.value?contains("BCD Detection")]										
				[#assign BCD_EXTI = ExtiLine]
				[#assign BCD_PORT = IpName]
				[#assign BCD_PIN  = IpInstance]
				[#assign BCD_IRQn = IrqNumber]									
			[/#if]	
		[/#list]
	[/#if]
[/#list]
[/#if]


[#list SWIPdatas as SWIP]
[#compress]
[#-- Section2: Create global Variables for each middle ware instance --]
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
		[#-- extern ${variable.type} --][#if variable.value??][#--${variable.value};--]
		[#if variable.value == "MSC"][#assign className = "MSC"][/#if]
		[#if variable.value == "DFU"][#assign className = "DFU"][/#if]
		[#if variable.value == "HID"][#assign className = "HID"][/#if]
		[#if variable.value == "AUDIO"][#assign className = "AUDIO"][/#if]
		[#if variable.value == "CCID"][#assign className = "CCID"][/#if]
		[#if variable.value == "MTP"][#assign className = "MTP"][/#if]
		[#if variable.value == "CDC"][#assign className = "CDC"][/#if]
		[#if variable.value == "CUSTOM_HID"][#assign className = "CUSTOM_HID"][/#if]
		[#if variable.value?contains("OTG_FS")][#assign handleNameFS = "FS"][/#if]
		[#if variable.value?contains("USB_FS")][#assign handleNameUSB_FS = "FS"][/#if]
		[#if variable.value?contains("OTG_HS")][#assign handleNameHS = "HS"][/#if]
		[#if variable.name?contains("USBD_LPM_ENABLED")]
			[#if variable.value = "1"]
				[#assign useLPM = true]
			[/#if]
		[/#if]
		[/#if]
	[/#list]
[/#if]
[#-- Global variables --]
[/#compress]
[/#list]
[#if className == "AUDIO"]
#include "usbd_audio.h"
[/#if]
[#if className == "DFU"]
#include "usbd_dfu.h"
[/#if]
[#if className == "HID"]
#include "usbd_hid.h"
[/#if]
[#if className == "MSC"]
#include "usbd_msc.h"
[/#if]
[#if className == "CDC"]
#include "usbd_cdc.h"
[/#if]
[#if className == "CUSTOM_HID"]
#include "usbd_customhid.h"
[/#if]
[#if className == "CCID"]
#include "usbd_ccid.h"
[/#if]
[#if className == "MTP"]
#include "usbd_mtp.h"
[/#if]


/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/


/* Private variables ---------------------------------------------------------*/
[#if useBCD=true]
USB_BCD_Status USBD_BCD_PortState = USB_BCD_IDLE;
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

[#if handleNameFS == "FS"]
[#include mxTmpFolder+"/usb_otg_fs_vars.tmp"]
[/#if]
[#if handleNameUSB_FS = "FS"]
[#include mxTmpFolder+"/usb_vars.tmp"]
[/#if]
[#if handleNameHS == "HS"]
[#include mxTmpFolder+"/usb_otg_hs_vars.tmp"]
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Exported function prototypes ----------------------------------------------*/
[#if useBCD=true]

[/#if]

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */

/* Private functions ---------------------------------------------------------*/
static USBD_StatusTypeDef USBD_Get_USB_Status(HAL_StatusTypeDef hal_status);
/* USER CODE BEGIN 1 */
static void SystemClockConfig_Resume(void);

/* USER CODE END 1 */
extern void SystemClock_Config(void);

/*******************************************************************************
                       LL Driver Callbacks (PCD -> USB Device Library)
*******************************************************************************/
/* MSP Init */
[#if handleNameFS == "FS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include mxTmpFolder+"/usb_otg_fs_Msp.tmp"]
[/#if]
[/#if]

[#if handleNameHS == "HS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include mxTmpFolder+"/usb_otg_hs_Msp.tmp"]
[/#if]
[/#if]

[#if handleNameUSB_FS == "FS"]
[#if includeMspDone == 0]
[#assign includeMspDone = 1]
[#include mxTmpFolder+"/usb_Msp.tmp"]
[/#if]
[/#if]

/**
  * @brief  Setup stage callback
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_SetupStageCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_SetupStageCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_SetupStageCallback_PreTreatment */
  
  /* USER CODE END  HAL_PCD_SetupStageCallback_PreTreatment */
  USBD_LL_SetupStage((USBD_HandleTypeDef*)hpcd->pData, (uint8_t *)hpcd->Setup);  
  /* USER CODE BEGIN HAL_PCD_SetupStageCallback_PostTreatment */
  
  /* USER CODE END  HAL_PCD_SetupStageCallback_PostTreatment */
}

/**
  * @brief  Data Out stage callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_DataOutStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_DataOutStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_DataOutStageCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_DataOutStageCallback_PreTreatment */
  USBD_LL_DataOutStage((USBD_HandleTypeDef*)hpcd->pData, epnum, hpcd->OUT_ep[epnum].xfer_buff);  
  /* USER CODE BEGIN HAL_PCD_DataOutStageCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_DataOutStageCallback_PostTreatment */
}

/**
  * @brief  Data In stage callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_DataInStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_DataInStageCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_DataInStageCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_DataInStageCallback_PreTreatment */  
  USBD_LL_DataInStage((USBD_HandleTypeDef*)hpcd->pData, epnum, hpcd->IN_ep[epnum].xfer_buff);  
  /* USER CODE BEGIN HAL_PCD_DataInStageCallback_PostTreatment  */
  
  /* USER CODE END HAL_PCD_DataInStageCallback_PostTreatment */
}

/**
  * @brief  SOF callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_SOFCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_SOFCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_SOFCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_SOFCallback_PreTreatment */  
  USBD_LL_SOF((USBD_HandleTypeDef*)hpcd->pData);  
  /* USER CODE BEGIN HAL_PCD_SOFCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_SOFCallback_PostTreatment */
}

/**
  * @brief  Reset callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ResetCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_ResetCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{ 
  /* USER CODE BEGIN HAL_PCD_ResetCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_ResetCallback_PreTreatment */
  USBD_SpeedTypeDef speed = USBD_SPEED_FULL;

  if ( hpcd->Init.speed != PCD_SPEED_FULL)
  {
    Error_Handler();
  }
    /* Set Speed. */
  USBD_LL_SetSpeed((USBD_HandleTypeDef*)hpcd->pData, speed);

  /* Reset Device. */
  USBD_LL_Reset((USBD_HandleTypeDef*)hpcd->pData);
  /* USER CODE BEGIN HAL_PCD_ResetCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_ResetCallback_PostTreatment */
}

/**
  * @brief  Suspend callback.
  * When Low power mode is enabled the debug cannot be used (IAR, Keil doesn't support it)
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_SuspendCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_SuspendCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_SuspendCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_SuspendCallback_PreTreatment */
[#if handleNameFS == "FS"]
  __HAL_PCD_GATE_PHYCLOCK(hpcd);
[/#if]
  /* Inform USB library that core enters in suspend Mode. */
  USBD_LL_Suspend((USBD_HandleTypeDef*)hpcd->pData);
  /* Enter in STOP mode. */
  /* USER CODE BEGIN 2 */
  if (hpcd->Init.low_power_enable)
  {
    /* Set SLEEPDEEP bit and SleepOnExit of Cortex System Control Register. */
    SCB->SCR |= (uint32_t)((uint32_t)(SCB_SCR_SLEEPDEEP_Msk | SCB_SCR_SLEEPONEXIT_Msk));
  }
  /* USER CODE END 2 */
  /* USER CODE BEGIN HAL_PCD_SuspendCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_SuspendCallback_PostTreatment */
}

/**
  * @brief  Resume callback.
  * When Low power mode is enabled the debug cannot be used (IAR, Keil doesn't support it)
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ResumeCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_ResumeCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_ResumeCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_ResumeCallback_PreTreatment */
[#if handleNameFS == "FS"]
  __HAL_PCD_UNGATE_PHYCLOCK(hpcd);
[/#if]

  /* USER CODE BEGIN 3 */
  if (hpcd->Init.low_power_enable)
  {
    /* Reset SLEEPDEEP bit of Cortex System Control Register. */
    SCB->SCR &= (uint32_t)~((uint32_t)(SCB_SCR_SLEEPDEEP_Msk | SCB_SCR_SLEEPONEXIT_Msk));
    SystemClockConfig_Resume();
  }
  /* USER CODE END 3 */
 
  USBD_LL_Resume((USBD_HandleTypeDef*)hpcd->pData);
  /* USER CODE BEGIN HAL_PCD_ResumeCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_ResumeCallback_PostTreatment */
}

/**
  * @brief  ISOOUTIncomplete callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ISOOUTIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_ISOOUTIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_ISOOUTIncompleteCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_ISOOUTIncompleteCallback_PreTreatment */
  USBD_LL_IsoOUTIncomplete((USBD_HandleTypeDef*)hpcd->pData, epnum);
  /* USER CODE BEGIN HAL_PCD_ISOOUTIncompleteCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_ISOOUTIncompleteCallback_PostTreatment */
}

/**
  * @brief  ISOINIncomplete callback.
  * @param  hpcd: PCD handle
  * @param  epnum: Endpoint number
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ISOINIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#else
void HAL_PCD_ISOINIncompleteCallback(PCD_HandleTypeDef *hpcd, uint8_t epnum)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_ISOINIncompleteCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_ISOINIncompleteCallback_PreTreatment */
  USBD_LL_IsoINIncomplete((USBD_HandleTypeDef*)hpcd->pData, epnum);
  /* USER CODE BEGIN HAL_PCD_ISOINIncompleteCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_ISOINIncompleteCallback_PostTreatment */
}

/**
  * @brief  Connect callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_ConnectCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_ConnectCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_ConnectCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_ConnectCallback_PreTreatment */
  USBD_LL_DevConnected((USBD_HandleTypeDef*)hpcd->pData);
  /* USER CODE BEGIN HAL_PCD_ConnectCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_ConnectCallback_PostTreatment */
}

/**
  * @brief  Disconnect callback.
  * @param  hpcd: PCD handle
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCD_DisconnectCallback(PCD_HandleTypeDef *hpcd)
#else
void HAL_PCD_DisconnectCallback(PCD_HandleTypeDef *hpcd)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCD_DisconnectCallback_PreTreatment */
  
  /* USER CODE END HAL_PCD_DisconnectCallback_PreTreatment */
  USBD_LL_DevDisconnected((USBD_HandleTypeDef*)hpcd->pData);
  /* USER CODE BEGIN HAL_PCD_DisconnectCallback_PostTreatment */
  
  /* USER CODE END HAL_PCD_DisconnectCallback_PostTreatment */
}

[#if useBCD=true]
/**
  * @brief  Send BCD message to user layer
  * @param  hpcd: PCD handle
  * @param  msg: LPM message
  * @retval None
  */
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCDEx_BCDCallback(PCD_HandleTypeDef *hpcd, PCD_BCD_MsgTypeDef msg)
#else
void HAL_PCDEx_BCD_Callback(PCD_HandleTypeDef *hpcd, PCD_BCD_MsgTypeDef msg)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN HAL_PCDEx_BCD_Callback_PreTreatment */
  
  /* USER CODE END HAL_PCDEx_BCD_Callback_PreTreatment */
  switch(msg)
  {
    case PCD_BCD_CONTACT_DETECTION:
      USBD_BCD_PortState = USB_BCD_CONTACT_DETECTION;
    break;

    case PCD_BCD_STD_DOWNSTREAM_PORT:
      USBD_BCD_PortState = USB_BCD_STD_DOWNSTREAM_PORT;
    break;

    case PCD_BCD_CHARGING_DOWNSTREAM_PORT:
      USBD_BCD_PortState = USB_BCD_CHARGING_DOWNSTREAM_PORT;
    break;

    case PCD_BCD_DEDICATED_CHARGING_PORT:
      USBD_BCD_PortState = USB_BCD_DEDICATED_CHARGING_PORT;
    break;

    case PCD_BCD_DISCOVERY_COMPLETED:
      HAL_Delay(20);
      /* Start USB */
      USBD_Start(hpcd->pData);
      USBD_BCD_PortState = USB_BCD_DISCOVERY_COMPLETED;
    break;

    case PCD_BCD_ERROR:
      Error_Handler();
    break;

    default:
    break;
  }
  /* USER CODE BEGIN HAL_PCDEx_BCD_Callback_PostTreatment */
  
  /* USER CODE END HAL_PCDEx_BCD_Callback_PostTreatment */
} 
[/#if]          
  /* USER CODE BEGIN LowLevelInterface */
  
  /* USER CODE END LowLevelInterface */

/*******************************************************************************
                       LL Driver Interface (USB Device Library --> PCD)
*******************************************************************************/

/**
  * @brief  Initializes the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Init(USBD_HandleTypeDef *pdev)
{
#t/* Init USB Ip. */
[#if handleNameFS == "FS"]
#tif (pdev->id == DEVICE_FS) {
#t/* Link the driver to the stack. */
#thpcd_USB_OTG_FS.pData = pdev;
#tpdev->pData = &hpcd_USB_OTG_FS;
#t/* Enable USB power on Pwrctrl CR2 register. */
[#-- bug 322072 moved to MspInit #tHAL_PWREx_EnableVddUSB();--]
#t[#include mxTmpFolder+"/usb_otg_fs_HalInit.tmp"]
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
  /* Register USB PCD CallBacks */
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_SOF_CB_ID, PCD_SOFCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_SETUPSTAGE_CB_ID, PCD_SetupStageCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_RESET_CB_ID, PCD_ResetCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_SUSPEND_CB_ID, PCD_SuspendCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_RESUME_CB_ID, PCD_ResumeCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_CONNECT_CB_ID, PCD_ConnectCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_FS, HAL_PCD_DISCONNECT_CB_ID, PCD_DisconnectCallback);
  /* USER CODE BEGIN RegisterCallBackFirstPart_FS */
  
  /* USER CODE END RegisterCallBackFirstPart_FS */
  [#if useLPM]
  HAL_PCD_RegisterLpmCallback(&hpcd_USB_OTG_FS, PCDEx_LPM_Callback);
  [/#if]
  [#if useBCD]
  HAL_PCD_RegisterBcdCallback(&hpcd_USB_OTG_FS, PCDEx_BCDCallback);
  [/#if]
  HAL_PCD_RegisterDataOutStageCallback(&hpcd_USB_OTG_FS, PCD_DataOutStageCallback);
  HAL_PCD_RegisterDataInStageCallback(&hpcd_USB_OTG_FS, PCD_DataInStageCallback);
  HAL_PCD_RegisterIsoOutIncpltCallback(&hpcd_USB_OTG_FS, PCD_ISOOUTIncompleteCallback);
  HAL_PCD_RegisterIsoInIncpltCallback(&hpcd_USB_OTG_FS, PCD_ISOINIncompleteCallback);
   /* USER CODE BEGIN RegisterCallBackSecondPart_FS */
  
  /* USER CODE END RegisterCallBackSecondPart_FS */
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
#tHAL_PCDEx_SetRxFiFo(&hpcd_USB_OTG_FS, 0x80);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_FS, 0, 0x40);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_FS, 1, 0x80);
#t}
[/#if]
[#if handleNameHS == "HS"]
#tif (pdev->id == DEVICE_HS) {
#t/* Link the driver to the stack. */
#thpcd_USB_OTG_HS.pData = pdev;
#tpdev->pData = &hpcd_USB_OTG_HS;
#t/* Enable USB power on Pwrctrl CR2 register. */
#tHAL_PWREx_EnableVddUSB();
[#include mxTmpFolder+"/usb_otg_hs_HalInit.tmp"]
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
  /* Register USB PCD CallBacks */
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_SOF_CB_ID, PCD_SOFCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_SETUPSTAGE_CB_ID, PCD_SetupStageCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_RESET_CB_ID, PCD_ResetCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_SUSPEND_CB_ID, PCD_SuspendCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_RESUME_CB_ID, PCD_ResumeCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_CONNECT_CB_ID, PCD_ConnectCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_OTG_HS, HAL_PCD_DISCONNECT_CB_ID, PCD_DisconnectCallback);
  /* USER CODE BEGIN RegisterCallBackFirstPart_HS */
  
  /* USER CODE END RegisterCallBackFirstPart_HS */
  [#if useLPM]
  HAL_PCD_RegisterLpmCallback(&hpcd_USB_OTG_HS, PCDEx_LPM_Callback);
  [/#if]
  [#if useBCD]
  HAL_PCD_RegisterBcdCallback(&hpcd_USB_OTG_HS, PCDEx_BCDCallback);
  [/#if]
  HAL_PCD_RegisterDataOutStageCallback(&hpcd_USB_OTG_HS, PCD_DataOutStageCallback);
  HAL_PCD_RegisterDataInStageCallback(&hpcd_USB_OTG_HS, PCD_DataInStageCallback);
  HAL_PCD_RegisterIsoOutIncpltCallback(&hpcd_USB_OTG_HS, PCD_ISOOUTIncompleteCallback);
  HAL_PCD_RegisterIsoInIncpltCallback(&hpcd_USB_OTG_HS, PCD_ISOINIncompleteCallback);
  /* USER CODE BEGIN RegisterCallBackSecondPart_HS */
  
  /* USER CODE END RegisterCallBackSecondPart_HS */
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
#tHAL_PCDEx_SetRxFiFo(&hpcd_USB_OTG_HS, 0x200);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_HS, 0, 0x80);
#tHAL_PCDEx_SetTxFiFo(&hpcd_USB_OTG_HS, 1, 0x174);
#t}
[/#if]
[#if handleNameUSB_FS == "FS"]
#thpcd_USB_FS.pData = pdev;
#t/* Link the driver to the stack. */
#tpdev->pData = &hpcd_USB_FS;
[#if DIE == "DIE472" || DIE == "DIE476" || DIE="DIE495" || DIE="DIE496"]
/* Enable USB power on Pwrctrl CR2 register. */
#tHAL_PWREx_EnableVddUSB();
[/#if]
[#include mxTmpFolder+"/usb_HalInit.tmp"]
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
  /* Register USB PCD CallBacks */
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_SOF_CB_ID, PCD_SOFCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_SETUPSTAGE_CB_ID, PCD_SetupStageCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_RESET_CB_ID, PCD_ResetCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_SUSPEND_CB_ID, PCD_SuspendCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_RESUME_CB_ID, PCD_ResumeCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_CONNECT_CB_ID, PCD_ConnectCallback);
  HAL_PCD_RegisterCallback(&hpcd_USB_FS, HAL_PCD_DISCONNECT_CB_ID, PCD_DisconnectCallback);
  /* USER CODE BEGIN RegisterCallBackFirstPart */
  
  /* USER CODE END RegisterCallBackFirstPart */
  [#if useLPM]
  HAL_PCD_RegisterLpmCallback(&hpcd_USB_FS, PCDEx_LPM_Callback);
  [/#if]
  [#if useBCD]
  HAL_PCD_RegisterBcdCallback(&hpcd_USB_FS, PCDEx_BCDCallback);
  [/#if]
  HAL_PCD_RegisterDataOutStageCallback(&hpcd_USB_FS, PCD_DataOutStageCallback);
  HAL_PCD_RegisterDataInStageCallback(&hpcd_USB_FS, PCD_DataInStageCallback);
  HAL_PCD_RegisterIsoOutIncpltCallback(&hpcd_USB_FS, PCD_ISOOUTIncompleteCallback);
  HAL_PCD_RegisterIsoInIncpltCallback(&hpcd_USB_FS, PCD_ISOINIncompleteCallback);
  /* USER CODE BEGIN RegisterCallBackSecondPart */
  
  /* USER CODE END RegisterCallBackSecondPart */
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
[#if className != "AUDIO"]
#t/* USER CODE BEGIN EndPoint_Configuration */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x00 , PCD_SNG_BUF, 0x18);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x80 , PCD_SNG_BUF, 0x58);
#t/* USER CODE END EndPoint_Configuration */
[/#if]
[#if className == "MSC"]
#t/* USER CODE BEGIN EndPoint_Configuration_MSC */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x81 , PCD_SNG_BUF, 0x98);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x01 , PCD_SNG_BUF, 0xD8);
#t/* USER CODE END EndPoint_Configuration_MSC */
[/#if]
[#if className == "AUDIO"]
#t/* USER CODE BEGIN EndPoint_Configuration */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData, 0x00, PCD_SNG_BUF, 0x10);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData, 0x80, PCD_SNG_BUF, 0x50);
#t/* USER CODE END EndPoint_Configuration */
#t/* USER CODE BEGIN EndPoint_Configuration_AUDIO */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData, AUDIO_OUT_EP, PCD_DBL_BUF, 0x01500090);
#t/* USER CODE END EndPoint_Configuration_AUDIO */
[/#if]
[#if className == "HID"]
#t/* USER CODE BEGIN EndPoint_Configuration_HID */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x81 , PCD_SNG_BUF, 0x100);
#t/* USER CODE END EndPoint_Configuration_HID */
[/#if]
[#if className == "CDC"]
#t/* USER CODE BEGIN EndPoint_Configuration_CDC */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x81 , PCD_SNG_BUF, 0xC0);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x01 , PCD_SNG_BUF, 0x110);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , 0x82 , PCD_SNG_BUF, 0x100);
#t/* USER CODE END EndPoint_Configuration_CDC */
[/#if]
[#if className == "CUSTOM_HID"]
#t/* USER CODE BEGIN EndPoint_Configuration_CUSTOM_HID */
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , CUSTOM_HID_EPIN_ADDR , PCD_SNG_BUF, 0x98);
#tHAL_PCDEx_PMAConfig((PCD_HandleTypeDef*)pdev->pData , CUSTOM_HID_EPOUT_ADDR , PCD_SNG_BUF, 0xD8);
#t/* USER CODE END EndPoint_Configuration_CUSTOM_HID */
[/#if]
[/#if]
#treturn USBD_OK;
}

/**
  * @brief  De-Initializes the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_DeInit(USBD_HandleTypeDef *pdev)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_DeInit(pdev->pData);

  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status; 
}

/**
  * @brief  Starts the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
 
  hal_status = HAL_PCD_Start(pdev->pData);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;
}

/**
  * @brief  Stops the low level portion of the device driver.
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Stop(USBD_HandleTypeDef *pdev)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_Stop(pdev->pData);

  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;
}

/**
  * @brief  Opens an endpoint of the low level driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @param  ep_type: Endpoint type
  * @param  ep_mps: Endpoint max packet size
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_OpenEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr, uint8_t ep_type, uint16_t ep_mps)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_EP_Open(pdev->pData, ep_addr, ep_mps, ep_type);

  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status;
}

/**
  * @brief  Closes an endpoint of the low level driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_CloseEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_Close(pdev->pData, ep_addr);
      
  usb_status =  USBD_Get_USB_Status(hal_status);

  return usb_status;  
}

/**
  * @brief  Flushes an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_FlushEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_Flush(pdev->pData, ep_addr);
      
  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;  
}

/**
  * @brief  Sets a Stall condition on an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_StallEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_SetStall(pdev->pData, ep_addr);

  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status;  
}

/**
  * @brief  Clears a Stall condition on an endpoint of the Low Level Driver.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_ClearStallEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_EP_ClrStall(pdev->pData, ep_addr);  
     
  usb_status =  USBD_Get_USB_Status(hal_status);

  return usb_status; 
}

/**
  * @brief  Returns Stall condition.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  PCD_HandleTypeDef *hpcd = (PCD_HandleTypeDef*) pdev->pData;
  
  if((ep_addr & 0x80) == 0x80)
  {
    return hpcd->IN_ep[ep_addr & 0x7F].is_stall; 
  }
  else
  {
    return hpcd->OUT_ep[ep_addr & 0x7F].is_stall; 
  }
}

/**
  * @brief  Assigns a USB address to the device.
  * @param  pdev: Device handle
  * @param  dev_addr: Device address
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_SetUSBAddress(USBD_HandleTypeDef *pdev, uint8_t dev_addr)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;
  
  hal_status = HAL_PCD_SetAddress(pdev->pData, dev_addr);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
 
  return usb_status;  
}

/**
  * @brief  Transmits data over an endpoint.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @param  pbuf: Pointer to data to be sent
  * @param  size: Data size    
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_Transmit(USBD_HandleTypeDef *pdev, uint8_t ep_addr, uint8_t *pbuf, uint16_t size)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_EP_Transmit(pdev->pData, ep_addr, pbuf, size);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
  
  return usb_status;    
}

/**
  * @brief  Prepares an endpoint for reception.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @param  pbuf: Pointer to data to be received
  * @param  size: Data size
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, uint8_t ep_addr, uint8_t *pbuf, uint16_t size)
{
  HAL_StatusTypeDef hal_status = HAL_OK;
  USBD_StatusTypeDef usb_status = USBD_OK;

  hal_status = HAL_PCD_EP_Receive(pdev->pData, ep_addr, pbuf, size);
     
  usb_status =  USBD_Get_USB_Status(hal_status);
  	
  return usb_status; 
}

/**
  * @brief  Returns the last transferred packet size.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint number
  * @retval Received Data Size
  */
uint32_t USBD_LL_GetRxDataSize(USBD_HandleTypeDef *pdev, uint8_t ep_addr)
{
  return HAL_PCD_EP_GetRxCount((PCD_HandleTypeDef*) pdev->pData, ep_addr);
}

[#if useBCD=true]
/**
  * @brief  
  * @param  pdev: Device handle
  * @retval USBD status
  */
USBD_StatusTypeDef USBD_LL_BatterryCharging(USBD_HandleTypeDef *pdev)
{
[#if BspUsed=true]
#tif (HAL_GPIO_ReadPin(${BCD_PORT}, ${BCD_PIN}) == GPIO_PIN_SET)
  {
    /*wait for bus stabilization*/
    HAL_Delay(450);
    /*Start BCD Detect*/
    HAL_PCDEx_ActivateBCD (pdev->pData);
    HAL_PCDEx_BCD_VBUSDetect(pdev->pData);
  }
[/#if]  
  return USBD_OK;
}
[/#if]

[#if useBCD=true]			
 /**
   * @brief  Handle USB VBUS detection upon external interrupt
   * @param  GPIO_Pin
   */
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
[#if BspUsed=true]
  if (GPIO_Pin == ${BCD_PIN})
  {
    if (HAL_GPIO_ReadPin(${BCD_PORT}, ${BCD_PIN}) == GPIO_PIN_SET)
    {
      /*wait for bus stabilization*/
      HAL_Delay(450);
      /*Start BCD Detect*/
      HAL_PCDEx_ActivateBCD (&hpcd_USB_FS);
      HAL_PCDEx_BCD_VBUSDetect(&hpcd_USB_FS);
    }
    else
    {
      HAL_PCD_DevDisconnect(&hpcd_USB_FS);

      USBD_BCD_PortState = USB_BCD_DEVICE_DISCONNECTED;
    }
  }
[/#if]  
}
[/#if]
          
[#if useLPM]
/**
  * @brief  Send LPM message to user layer
  * @param  hpcd: PCD handle
  * @param  msg: LPM message
  * @retval None
  */          
#if (USE_HAL_PCD_REGISTER_CALLBACKS == 1U)
static void PCDEx_LPM_Callback(PCD_HandleTypeDef *hpcd, PCD_LPM_MsgTypeDef msg)
#else
void HAL_PCDEx_LPM_Callback(PCD_HandleTypeDef *hpcd, PCD_LPM_MsgTypeDef msg)
#endif /* USE_HAL_PCD_REGISTER_CALLBACKS */
{
  /* USER CODE BEGIN LPM_Callback */
  switch (msg)
  {
  case PCD_LPM_L0_ACTIVE:
    if (hpcd->Init.low_power_enable)
    {
      SystemClockConfig_Resume();
      
      /* Reset SLEEPDEEP bit of Cortex System Control Register. */
      SCB->SCR &= (uint32_t)~((uint32_t)(SCB_SCR_SLEEPDEEP_Msk | SCB_SCR_SLEEPONEXIT_Msk));
    }
[#if handleNameFS == "FS"]
    __HAL_PCD_UNGATE_PHYCLOCK(hpcd);
[/#if]
    USBD_LL_Resume(hpcd->pData);
    break;
    
  case PCD_LPM_L1_ACTIVE:
[#if handleNameFS == "FS"]
    __HAL_PCD_GATE_PHYCLOCK(hpcd);
[/#if]
    USBD_LL_Suspend(hpcd->pData);
    
    /* Enter in STOP mode. */
    if (hpcd->Init.low_power_enable)
    {   
      /* Set SLEEPDEEP bit and SleepOnExit of Cortex System Control Register. */
      SCB->SCR |= (uint32_t)((uint32_t)(SCB_SCR_SLEEPDEEP_Msk | SCB_SCR_SLEEPONEXIT_Msk));
    }
    break;   
  }
  /* USER CODE END LPM_Callback */
}
[/#if]

/**
  * @brief  Delays routine for the USB Device Library.
  * @param  Delay: Delay in ms
  * @retval None
  */
void USBD_LL_Delay(uint32_t Delay)
{
  HAL_Delay(Delay);
}

/**
  * @brief  Static single allocation.
  * @param  size: Size of allocated memory
  * @retval None
  */
void *USBD_static_malloc(uint32_t size)
{
[#if className == "AUDIO"]
  static uint32_t mem[(sizeof(USBD_AUDIO_HandleTypeDef)/4)+1];/* On 32-bit boundary */ 
[/#if]
[#if className == "DFU"]
  static uint32_t mem[(sizeof(USBD_DFU_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "HID"]
  static uint32_t mem[(sizeof(USBD_HID_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "MSC"]
  static uint32_t mem[(sizeof(USBD_MSC_BOT_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "CDC"]
  static uint32_t mem[(sizeof(USBD_CDC_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "CUSTOM_HID"]
  static uint32_t mem[(sizeof(USBD_CUSTOM_HID_HandleTypeDef)/4+1)];/* On 32-bit boundary */
[/#if]
[#if className == "CCID"]
  static uint32_t mem[(sizeof(USBD_CCID_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
[#if className == "MTP"]
  static uint32_t mem[(sizeof(USBD_MTP_HandleTypeDef)/4)+1];/* On 32-bit boundary */
[/#if]
  return mem;
}

/**
  * @brief  Dummy memory free
  * @param  p: Pointer to allocated  memory address
  * @retval None
  */
void USBD_static_free(void *p)
{

}

/* USER CODE BEGIN 5 */
/**
  * @brief  Configures system clock after wake-up from USB resume callBack:
  *         enable HSI, PLL and select PLL as system clock source.
  * @retval None
  */
static void SystemClockConfig_Resume(void)
{
  SystemClock_Config();
}
/* USER CODE END 5 */

/**
  * @brief  Returns the USB status depending on the HAL status:
  * @param  hal_status: HAL status
  * @retval USB status
  */
USBD_StatusTypeDef USBD_Get_USB_Status(HAL_StatusTypeDef hal_status)
{
  USBD_StatusTypeDef usb_status = USBD_OK;

  switch (hal_status)
  {
    case HAL_OK :
      usb_status = USBD_OK;
    break;
    case HAL_ERROR :
      usb_status = USBD_FAIL;
    break;
    case HAL_BUSY :
      usb_status = USBD_BUSY;
    break;
    case HAL_TIMEOUT :
      usb_status = USBD_FAIL;
    break;
    default :
      usb_status = USBD_FAIL;
    break;
  }
  return usb_status;
}
