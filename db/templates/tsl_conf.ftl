[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name    tsl_conf.h
  * Description   TSC configuration file.
  ******************************************************************************
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TOUCHSENSING_MODE"]
                [#assign touchsensing_mode = definition.value]
			[/#if]
		[/#list]
	[/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __TSL_CONF_H
#define __TSL_CONF_H
[#assign familyName=FamilyName?lower_case]

#include "main.h"

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*+++++++++++++++++++++++++++ COMMON PARAMETERS ++++++++++++++++++++++++++++++*/
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/** @defgroup Common_Parameters Common Parameters
  * @{ */

/*============================================================================*/
/* Number of elements                                                         */
/*============================================================================*/

/** @defgroup Common_Parameters_Number_Of_Elements 01 - Number of elements
  * @{ */

/** Total number of channels in application (range=1..255)
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_CHANNELS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Total number of banks in application (range=1..255)
*/

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as define]
            [#assign bankNb = 0]
            [#assign i = 0]
            [#if define.name == "TSLPRM_SENSORS_DATAS"]
                [#assign wordsArray = define.value?split(" ")]
                [#assign wordsArraySize = wordsArray?size -1]
                [#list 0..wordsArraySize as i]
                    [#assign wordsArrayItem = wordsArray[i]]
                    [#if wordsArrayItem?contains("TSLPRM")]
                        [#assign wordsArrayItemNext = wordsArray[i+1]]
                        [#assign wordsArrayItemNextNbr = wordsArrayItemNext?number - 1]
                        [#assign bankNb = wordsArrayItemNextNbr + 1 + bankNb]
                    [/#if]
                [/#list]
                [#lt]#define TSLPRM_TOTAL_BANKS (${bankNb})
            [/#if]
        [/#list]
	[/#if]
[/#list]

/** Total number of "Extended" TouchKeys in application (range=0..255)
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_TOUCHKEYS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Total number of "Basic" TouchKeys in application (range=0..255)
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_TOUCHKEYS_B"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Total number of "Extended" Linear and Rotary sensors in application (range=0..255)
  - Count also the 1-channel linear sensor used as TouchKey
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_LINROTS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Total number of "Basic" Linear and Rotary sensors in application (range=0..255)
  - Count also the 1-channel linear sensor used as TouchKey
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_LINROTS_B"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Total number of "Extended & Basic" Linear and Rotary sensors in application (range=0..255)
  - Count also the 1-channel linear sensor used as TouchKey
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_ALL_LINROTS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Total number of sensors/objects in application (range=1..255)
  - Count all TouchKeys, Linear and Rotary sensors
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TOTAL_OBJECTS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_Number_Of_Elements */

/*============================================================================*/
/* Optional features                                                          */
/*============================================================================*/

/** @defgroup Common_Parameters_Options 02 - Optional features
  * @{ */

/** Record the last measure (0=No, 1=Yes)
  - If No the measure is recalculated using the Reference and Delta
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_MEAS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Proximity detection usage (0=No, 1=Yes)
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_PROX"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]


/** @} Common_Parameters_Options */

/*============================================================================*/
/* Acquisition limits                                                         */
/*============================================================================*/

/** @defgroup Common_Parameters_Acquisition_Limits 03 - Acquisition limits
  * @{ */

/** Minimum acquisition measurement (range=0..65535)
  - This is the minimum acceptable value for the acquisition measure.
  - The acquisition will be in error if the measure is below this value.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_ACQ_MIN"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Maximum acquisition measurement (range=255, 511, 1023, 2047, 8191, 16383)
  - This is the maximum acceptable value for the acquisition measure.
  - The acquisition will be in error if the measure is above this value.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_ACQ_MAX"]
                [#if familyName="stm32l1"]
                    [#lt]#define ${definition.name} (${definition.value})
                [#else]
                    [#lt]#define ${definition.name} (${definition.value?substring((definition.value?last_index_of("_") + 1) ,definition.value?length)})
                [/#if]
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_Acquisition_Limits */

/*============================================================================*/
/* Calibration                                                                */
/*============================================================================*/

/** @defgroup Common_Parameters_Calibration 04 - Calibration
  * @{ */

/** Number of calibration samples (range=4, 8, 16)
  - Low value = faster calibration but less precision.
  - High value = slower calibration but more precision.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_CALIB_SAMPLES"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Delay in measurement samples before starting the calibration (range=0..40)
  - This is useful if a noise filter is used.
  - Write 0 to disable the delay.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_CALIB_DELAY"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_Calibration */

/*============================================================================*/
/* Thresholds for TouchKey sensors                                            */
/*============================================================================*/

/** @defgroup Common_Parameters_TouchKey_Thresholds 05 - Thresholds for TouchKey sensors
  * @{ */

/** TouchKeys Proximity state input threshold (range=0..255)
  - Enter Proximity state if delta is above
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TKEY_PROX_IN_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** TouchKeys Proximity state output threshold (range=0..255)
  - Exit Proximity state if delta is below
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TKEY_PROX_OUT_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** TouchKeys Detect state input threshold (range=0..255)
  - Enter Detect state if delta is above
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TKEY_DETECT_IN_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** TouchKeys Detect state output threshold (range=0..255)
  - Exit Detect state if delta is below
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TKEY_DETECT_OUT_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** TouchKeys re-Calibration threshold (range=0..255)
  - @warning The value is inverted in the sensor state machine
  - Enter Calibration state if delta is below
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TKEY_CALIB_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]

[/#list]

/** TouchKey, Linear and Rotary sensors thresholds coefficient (range=0..4)
    This multiplier coefficient is applied on Detect and Re-Calibration thresholds only.
  - 0: feature disabled
  - 1: thresholds x 2
  - 2: thresholds x 4
  - 3: thresholds x 8
  - 4: thresholds x 16
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_COEFF_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_TouchKey_Thresholds */

/*============================================================================*/
/* Thresholds for Linear and Rotary sensors                                   */
/*============================================================================*/

/** @defgroup Common_Parameters_LinRot_Thresholds 06 - Thresholds for Linear and Rotary sensors
  * @{ */

/** Linear/Rotary Proximity state input threshold (range=0..255)
  - Enter Proximity state if delta is above
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_PROX_IN_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Linear/Rotary Proximity state output threshold (range=0..255)
  - Exit Proximity state if delta is below
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_PROX_OUT_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Linear/Rotary Detect state input threshold (range=0..255)
  - Enter Detect state if delta is above
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_DETECT_IN_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Linear/Rotary Detect state output threshold (range=0..255)
  - Exit Detect state if delta is below
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_DETECT_OUT_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Linear/Rotary re-Calibration threshold (range=0..255)
  - @warning The value is inverted in the sensor state machine
  - Enter Calibration state if delta is below
  - A low absolute value will result in a higher sensitivity and thus some spurious
    recalibration may be issued.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_CALIB_TH"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Linear/Rotary Delta normalization (0=No, 1=Yes)
  - When this parameter is set, a coefficient is applied on all Delta of all sensors
    in order to normalize them and to improve the position calculation.
  - These coefficients must be defined in a constant table in the application (see Library examples).
  - The MSB is the coefficient integer part, the LSB is the coefficient real part.
  - Examples:
    - To apply a factor 1.10:
      0x01 to the MSB
      0x1A to the LSB (0.10 x 256 = 25.6 -> rounded to 26 = 0x1A)
    - To apply a factor 0.90:
      0x00 to the MSB
      0xE6 to the LSB (0.90 x 256 = 230.4 -> rounded to 230 = 0xE6)
    - To apply no factor:
      0x01 to the MSB
      0x00 to the LSB
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_USE_NORMDELTA"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_LinRot_Thresholds */

/*============================================================================*/
/* Linear/Rotary sensors used                                                 */
/*============================================================================*/

/** @defgroup Common_Parameters_LinRot_Used 07 - Linear/Rotary sensors used
  * @{ */

/** Select which Linear and Rotary sensors you use in your application.
    - 0 = Not Used
    - 1 = Used

  LIN = Linear sensor
  ROT = Rotary sensor
  M1 = Mono electrodes design with 0/255 position at extremities of the sensor
  M2 = Mono electrodes design
  H = Half-ended electrodes design
  D = Dual electrodes design
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_3CH_LIN_M1"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_3CH_LIN_M2"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_3CH_LIN_H"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_3CH_ROT_M"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_4CH_LIN_M1"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_4CH_LIN_M2"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_4CH_LIN_H"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_4CH_ROT_M"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_5CH_LIN_M1"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_5CH_LIN_M2"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_5CH_LIN_H"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_5CH_ROT_M"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_5CH_ROT_D"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_6CH_LIN_M1"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_6CH_LIN_M2"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_6CH_LIN_H"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_6CH_ROT_M"]
				[#lt]#define ${definition.name}  (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_LinRot_used */

/*============================================================================*/
/* Linear/Rotary sensors position                                             */
/*============================================================================*/

/** @defgroup Common_Parameters_LinRot_Position 08 - Linear/Rotary sensors position
  * @{ */

/** Position resolution in number of bits (range=1..8)
  - A Low value will result in a low resolution and will be less subject to noise.
  - A High value will result in a high resolution and will be more subject to noise.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_RESOLUTION"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Direction change threshold in position unit (range=0..255)
  - Defines the default threshold used during the change direction process.
  - A Low value will result in a faster direction change.
  - A High value will result in a slower direction change.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_DIR_CHG_POS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Direction change debounce (range=0..63)
  - Defines the default integrator counter used during the change direction process.
  - This counter is decremented when the same change in the position is detected and the direction will
    change after this counter reaches zero.
  - A Low value will result in a faster direction change.
  - A High value will result in a slower direction change.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_LINROT_DIR_CHG_DEB"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_LinRot_Position */

/*============================================================================*/
/* Debounce counters                                                          */
/*============================================================================*/

/** @defgroup Common_Parameters_Debounce 09 - Debounce counters
  * @{ */

/** Proximity state debounce in samples unit (range=0..63)
  - A Low value will result in a higher sensitivity during the Proximity detection but with less noise filtering.
  - A High value will result in improving the system noise immunity but will increase the system response time.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DEBOUNCE_PROX"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Detect state debounce in samples unit (range=0..63)
  - A Low value will result in a higher sensitivity during the detection but with less noise filtering.
  - A High value will result in improving the system noise immunity but will increase the system response time.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DEBOUNCE_DETECT"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Release state debounce in samples unit (range=0..63)
  - A Low value will result in a higher sensitivity during the end-detection but with less noise filtering.
  - A High value will result in a lower sensitivity during the end-detection but with more noise filtering.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DEBOUNCE_RELEASE"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Re-calibration state debounce in samples unit (range=0..63)
  - A Low value will result in a higher sensitivity during the recalibration but with less noise filtering.
  - A High value will result in a lower sensitivity during the recalibration but with more noise filtering.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DEBOUNCE_CALIB"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Error state debounce in samples unit (range=0..63)
  - A Low value will result in a higher sensitivity to enter in error state.
  - A High value will result in a lower sensitivity to enter in error state.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DEBOUNCE_ERROR"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_Debounce */

/*============================================================================*/
/* Environment Change System (ECS)                                            */
/*============================================================================*/

/** @defgroup Common_Parameters_ECS 10 - ECS
  * @{ */

/** Environment Change System Slow K factor (range=0..255)
  - The higher value is K, the faster is the response time.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_ECS_K_SLOW"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Environment Change System Fast K factor (range=0..255)
  - The higher value is K, the faster is the response time.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_ECS_K_FAST"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** Environment Change System delay in msec (range=0..5000)
  - The ECS will be started after this delay and when all sensors are in Release state.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_ECS_DELAY"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_ECS */

/*============================================================================*/
/* Detection Time Out (DTO)                                                   */
/*============================================================================*/

/** @defgroup Common_Parameters_DTO 11 - DTO
  * @{ */

/** Detection Time Out delay in seconds (range=0..63)
  - Value 0: DTO processing not compiled in the code (to gain size if not used).
  - Value 1: Default time out infinite.
  - Value between 2 and 63: Default time out between value n-1 and n.
  - Examples:
      - With a DTO equal to 2, the time out is between 1s and 2s.
      - With a DTO equal to 63, the time out is between 62s and 63s.

@note The DTO can be changed in run-time by the application only if the
      default value is between 1 and 63.
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DTO"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_DTO */

/*============================================================================*/
/* Detection Exclusion System (DXS)                                           */
/*============================================================================*/

/** @defgroup Common_Parameters_DXS 12 - DXS
  * @{ */

/** Detection Exclusion System (0=No, 1=Yes)
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_USE_DXS"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_DXS */

/*============================================================================*/
/* Miscellaneous parameters                                                   */
/*============================================================================*/

/** @defgroup Common_Parameters_Misc 13 - Miscellaneous
  * @{ */

/** Timing tick frequency in Hz (range=125, 250, 500, 1000, 2000)
  - Result to a timing interrupt respectively every 8ms, 4ms, 2ms, 1ms, 0.5ms
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_TICK_FREQ"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]
/** Delay for discharging Cx and Cs capacitors (range=0..65535)
    - The value corresponds to the Softdelay function parameter.
    -  500 gives around  63 microseconds delay whatever HCLK
    - 1000 gives around 125 microseconds delay whatever HCLK
    - 2000 gives around 250 microseconds delay whatever HCLK
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_DELAY_DISCHARGE_ALL"]
				[#lt]#define ${definition.name} (${definition.value})
			[/#if]
		[/#list]
	[/#if]
[/#list]

/** IOs default mode when no on-going acquisition (range=0..1)
    - 0: Output push-pull low
    - 1: Input floating
@note To ensure a correct operation in noisy environment, this parameter should
be configured to output push-pull low (excepted for Linear sensors).
*/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="TSLPRM_IODEF"]
                [#if familyName="stm32l1"]
                    [#lt]#define ${definition.name} (${definition.value})
                [#else]
                    [#if definition.value="TSC_IODEF_OUT_PP_LOW"]
                        [#lt]#define ${definition.name} 0
                    [#else]
                        [#lt]#define ${definition.name} 1
                    [/#if]
                [/#if]
            [/#if]
		[/#list]
	[/#if]
[/#list]

/** @} Common_Parameters_Misc */

/** @} Common_Parameters */
[#if familyName = "stm32l1"]
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*+++++++++++++++++++++++++++++ MCU PARAMETERS +++++++++++++++++++++++++++++++*/
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/** @defgroup STM32L1xx_Parameters STM32L1xx Parameters
  * @{ */

/** @defgroup STM32L1xx_Parameters_Misc 01 - Miscellaneous
  * @{ */

/** Shield with a channel (0=No, 1=Yes)
*/

    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name="TSLPRM_USE_SHIELD"]
                    [#lt]#define ${definition.name} (${definition.value})
                [/#if]
            [/#list]
        [/#if]
    [/#list]

    [#if touchsensing_mode = "hardware"]
    /** Charge/transfer Period (in  microseconds) (= high pulse + low pulse)
        - This is used to calculate the Timer reload value.
    @note For HW acquisition only
      */
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_CT_PERIOD"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]

/** Timer frequency (in MHz)
    - This is used to calculate the Timer reload value.
@note For HW acquisition only
  */
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_TIMER_FREQ"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]

    [#if touchsensing_mode = "software"]
    /** Delay for transferring charges from Cx to Cs capacitor and then discharge Cx
   (range=0..65535)
   - 0: no delay (it takes about 2.8 microseconds for a CT cycle)
   - (1..65535): delay (in  microseconds) = 0.75 * TSLPRM_DELAY_TRANSFER + 1
@note for SW acquisition only
*/
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_DELAY_TRANSFER"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]

/**Use Spread Spectrum (0=No, 1=Yes)
@note for SW acquisition only
*/
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_USE_SPREAD_SPECTRUM"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]

/** Spread min value (range=0..(TSLPRM_SPREAD_MAX-1))
@note for SW acquisition only
*/
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_SPREAD_MIN"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]

/** Spread max value (range=2..255)
@note for SW acquisition only
*/
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_SPREAD_MAX"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]

/** IT disabling for IO protection (range=0..1)
    - 0: IO not protected
    - 1: IO protected
@note for SW acquisition only
*/
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_PROTECT_IO_ACCESS"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]

/** Which GPIO will be used (range=0..1)
    - 0: Not used
    - 1: Used
@note for SW acquisition only
*/
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_USE_GPIOA"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_USE_GPIOB"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_USE_GPIOC"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_USE_GPIOF"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#list SWIPdatas as SWIP]
            [#if SWIP.defines??]
                [#list SWIP.defines as definition]
                    [#if definition.name="TSLPRM_USE_GPIOG"]
                        [#lt]#define ${definition.name} (${definition.value})
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]
/** @} STM32L1xx_Parameters_Misc */

/** @} STM32L1xx_Parameters */
[/#if]
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*+++++++++++++++++++++++++ MCU AND ACQUISITION SELECTION ++++++++++++++++++++*/
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#include "${FamilyName?lower_case}xx.h" 
/* Select the file corresponding to the device in use (i.e. stm32f3xx.h, stm32f0xx.h, ...) */
[#if familyName = "stm32l1"]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name="TOUCHSENSING_MODE"]
                    [#if definition.value="software"]
                        [#lt]//#include "tsl_acq_stm32l1xx_hw.h" /* Select this file if hardware acquisition is used */
                        [#lt]#include "tsl_acq_stm32l1xx_sw.h" /* Select this file if software acquisition is used */
                    [#else]
                        [#lt]#include "tsl_acq_stm32l1xx_hw.h" /* Select this file if hardware acquisition is used */
                        [#lt]//#include "tsl_acq_stm32l1xx_sw.h" /* Select this file if software acquisition is used */
                    [/#if]    
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[#else ]
#include "tsl_acq_tsc.h" /* The TSC acquisition is used for this device. Do not change it! */
[/#if]

#endif /* __TSL_CONF_H */

