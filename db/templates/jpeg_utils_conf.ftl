[#ftl]
/*
 * jpeg_utils_conf.h
 *
 * Copyright (C) 1991-1997, Thomas G. Lane.
 * Modified 1997-2011 by Guido Vollbeding.
 * This file is part of the Independent JPEG Group's software.
 * For conditions of distribution and use, see the accompanying README file.
 *
 * This file contains additional configuration options that customize the
 * JPEG HW configuration.  Most users will not need to touch this file.
 */

 /* Define to prevent recursive inclusion -------------------------------------*/

#ifndef  __JPEG_UTILS_CONF_H__
#define  __JPEG_UTILS_CONF_H__


/* Includes ------------------------------------------------------------------*/

#include "${FamilyName?lower_case}xx_hal.h"
#include "${FamilyName?lower_case}xx_hal_jpeg.h"


/* Private define ------------------------------------------------------------*/
/** @addtogroup JPEG_Private_Defines
  * @{
  */
/* RGB Color format definition for JPEG encoding/Decoding : Should not be modified*/
#define JPEG_ARGB8888            0  /* ARGB8888 Color Format */
#define JPEG_RGB888              1  /* RGB888 Color Format   */
#define JPEG_RGB565              2  /* RGB565 Color Format   */

/*
 * Define USE_JPEG_DECODER 
 */
[#list configs as config]
  [#assign peripheralParams = config.peripheralParams]
  [#assign usedIPs = config.usedIPs]

  [#list usedIPs as ip]
    [#if ip=="JPEG"]
      [#if peripheralParams.get(ip)??]

        [#assign USE_JPEG_DECODER = peripheralParams.get(ip).get("USE_JPEG_DECODER")]
        [@compress single_line=true]
        [#lt]#define USE_JPEG_DECODER  ${USE_JPEG_DECODER}  /* 1 or 0

        [#if USE_JPEG_DECODER = "0"]
                [#lt] */
        [#else]
                [#lt] ********* Value different from default value : 1 ********** */
        [/#if]
        [/@compress]

/*
 * Define USE_JPEG_ENCODER 
 */

        [#assign USE_JPEG_ENCODER = peripheralParams.get(ip).get("USE_JPEG_ENCODER")]
        [@compress single_line=true]
        [#lt]#define USE_JPEG_ENCODER  ${USE_JPEG_ENCODER}  /* 1 or 0

        [#if USE_JPEG_ENCODER = "0"]
                [#lt] */
        [#else]
                [#lt] ********* Value different from default value : 1 ********** */
        [/#if]
        [/@compress]
			

/*
 * Define JPEG_RGB_FORMAT 
 */
        [#assign JPEG_RGB_FORMAT = peripheralParams.get(ip).get("JPEG_RGB_FORMAT")]
        [@compress single_line=true]
        [#lt]#define JPEG_RGB_FORMAT  ${JPEG_RGB_FORMAT}  /* JPEG_ARGB8888, JPEG_RGB888, JPEG_RGB565

        [#if JPEG_RGB_FORMAT = "1"]
                [#lt] */
        [#else]
                [#lt] ********* Value different from default value : 0 ********** */
        [/#if]
        [/@compress]

            	
/*
 * Define JPEG_SWAP_RG 
 */
        [#assign JPEG_SWAP_RG = peripheralParams.get(ip).get("JPEG_SWAP_RG")]
        [@compress single_line=true]
        [#lt]#define JPEG_SWAP_RG  ${JPEG_SWAP_RG}  /* 0 or 1

        [#if JPEG_SWAP_RG = "1"]
                [#lt] */
        [#else]
                [#lt] ********* Value different from default value : 0 ********** */
        [/#if]
        [/@compress]

            [/#if]
        [/#if]		
		
    [/#list]
 [/#list]
 
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

#endif /* __JPEG_UTILS_CONF_H__ */
