[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_nvm.h
  * @author  GPM WBL Application Team
  * @brief   Nonvolatile memory (NVM) contents.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "wl3sfx_flash_utils.h"
#include "stm32wl3x_hal.h"

#ifndef __WL3SFX_NVM_H
#define __WL3SFX_NVM_H

#define QUOTEME(a) #a

#if defined   (__GNUC__)
  #define REQUIRED(var)                   var __attribute__((used))
  #define SECTION(name)                   __attribute__((section(name)))
#else
  #if defined   (__CC_ARM)
    #define REQUIRED(decl)                      decl __attribute__((used))
    #define SECTION(name)                   __attribute__((section(name)))
  /* IAR Compiler */
  #elif defined (__ICCARM__)    
    #define REQUIRED(decl)                 __root decl
    #define SECTION(name)                  _Pragma(QUOTEME(location=name))
  #endif 
#endif /* __GNUC__ */

#if defined(__ICCARM__) || defined(__IAR_SYSTEMS_ASM__)    
  #define NO_INIT(var)                          __no_init var
  #define NO_INIT_SECTION(var, sect)            SECTION(sect) __no_init var
#else
#if defined(__CC_ARM) || (defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6100100))
  #if defined(__CC_ARM)  
    #define NO_INIT(var)                        var __attribute__((section( ".noinit.data" ), zero_init))
    #define NO_INIT_SECTION(var, sect)          var __attribute__((section( sect ), zero_init))
  #elif defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6100100)
    #define NO_INIT(var)                        var __attribute__((section(".bss.noinit.data")))
    #define NO_INIT_SECTION(var, sect)          var __attribute__((section(".bss" sect)))
  #endif    
#else
  #ifdef __GNUC__
    #define NO_INIT(var)                        var  __attribute__((section(".noinit")))
    #define NO_INIT_SECTION(var, sect)          var  __attribute__((section(sect)))
  #endif
#endif
#endif

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_NVM Nonvolatile Memory
 * @brief Sections of nonvolatile flash memory dedicated to Sigfox
 * @{
 */

/** Boarddata: Provisioned once (at the factory, during setup). Contains credentials and key-value store for calibration offset
 * configuration. */
extern const uint8_t wl3sfx_nvm_boarddata[FLASH_PAGE_SIZE];

/** Records: Contains Sigfox library protocol state, e.g. sequence numbers, frequency-hopping pattern. */
extern const uint8_t wl3sfx_nvm_records[FLASH_PAGE_SIZE];

/** Record Backup: Before flash page containing records is erased (because it is full), backup of latest record is written to this address.
 */
extern const uint8_t wl3sfx_nvm_records_backup[FLASH_PAGE_SIZE];

/** @}@} */

#endif