[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    simple_nvm_arbiter_conf.h
  * @author  MCD Application Team
  * @brief   Configuration header for simple_nvm_arbiter.c module
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef SIMPLE_NVM_ARBITER_CONF_H
#define SIMPLE_NVM_ARBITER_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "utilities_common.h"

#include "simple_nvm_arbiter_common.h"

#include "stm32wbaxx_hal_flash.h"

/* Exported constants --------------------------------------------------------*/

/* ========================================================================== */
/* +                            NVM part - USER DEFINED                     + */
/* ========================================================================== */

/**
 * @brief Number of managed NVMs
 *
 * @details This number must be lower than SNVMA_MAX_NUMBER_NVM
 *
 */
#define SNVMA_NVM_NUMBER                1u

/**
 * @brief Polynomial value for CRC16
 *
 */
#define SNVMA_POLY_CRC16                0x1DB7u

/* Check that NVM number does not exceed limitations */
#if SNVMA_NVM_NUMBER > SNVMA_MAX_NUMBER_NVM
#error Number of NVM to manage is to high
#endif /* SNVMA_NVM_NUMBER > SNVMA_MAX_NUMBER_NVM */

/* ========================================================================== */
/* +                        NVM IDs part - USER DEFINED                     + */
/* ========================================================================== */

/* NVM ID #1 */
#if SNVMA_NVM_NUMBER > 0
#define SNVMA_NVM_ID_1
#define SNVMA_NVM_ID_1_BANK_NUMBER      2u
#define SNVMA_NVM_ID_1_BANK_SIZE        1u

#if (SNVMA_NVM_ID_1_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_1_BANK_SIZE == 0u)
#error NVM ID #1 => Bank not initialized
#elif (SNVMA_NVM_ID_1_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #1 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 0 */

/* NVM ID #2 */
#if SNVMA_NVM_NUMBER > 1
#define SNVMA_NVM_ID_2
#define SNVMA_NVM_ID_2_BANK_NUMBER      3u
#define SNVMA_NVM_ID_2_BANK_SIZE        2u

#if (SNVMA_NVM_ID_2_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_2_BANK_SIZE == 0u)
#error NVM ID #2 => Bank not initialized
#elif (SNVMA_NVM_ID_2_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #2 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 1 */

/* NVM ID #3 */
#if SNVMA_NVM_NUMBER > 2
#define SNVMA_NVM_ID_3
#define SNVMA_NVM_ID_3_BANK_NUMBER      2u
#define SNVMA_NVM_ID_3_BANK_SIZE        3u

#if (SNVMA_NVM_ID_3_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_3_BANK_SIZE == 0u)
#error NVM ID #3 => Bank not initialized
#elif (SNVMA_NVM_ID_3_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #3 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 2 */

/* NVM ID #4 */
#if SNVMA_NVM_NUMBER > 3
#define SNVMA_NVM_ID_4
#define SNVMA_NVM_ID_4_BANK_NUMBER      2u
#define SNVMA_NVM_ID_4_BANK_SIZE        2u

#if (SNVMA_NVM_ID_4_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_4_BANK_SIZE == 0u)
#error NVM ID #4 => Bank not initialized
#elif (SNVMA_NVM_ID_4_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #4 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 3 */

/* NVM ID #5 */
#if SNVMA_NVM_NUMBER > 4
#define SNVMA_NVM_ID_5
#define SNVMA_NVM_ID_5_BANK_NUMBER      3u
#define SNVMA_NVM_ID_5_BANK_SIZE        3u

#if (SNVMA_NVM_ID_5_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_5_BANK_SIZE == 0u)
#error NVM ID #5 => Bank not initialized
#elif (SNVMA_NVM_ID_5_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #5 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 4 */

/* NVM ID #6 */
#if SNVMA_NVM_NUMBER > 5
#define SNVMA_NVM_ID_6
#define SNVMA_NVM_ID_6_BANK_NUMBER      0u
#define SNVMA_NVM_ID_6_BANK_SIZE        0u

#if (SNVMA_NVM_ID_6_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_6_BANK_SIZE == 0u)
#error NVM ID #6 => Bank not initialized
#elif (SNVMA_NVM_ID_6_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #6 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 5 */

/* NVM ID #7 */
#if SNVMA_NVM_NUMBER > 6
#define SNVMA_NVM_ID_7
#define SNVMA_NVM_ID_7_BANK_NUMBER      0u
#define SNVMA_NVM_ID_7_BANK_SIZE        0u

#if (SNVMA_NVM_ID_7_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_7_BANK_SIZE == 0u)
#error NVM ID #7 => Bank not initialized
#elif (SNVMA_NVM_ID_7_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #7 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 6 */

/* NVM ID #8 */
#if SNVMA_NVM_NUMBER > 7
#define SNVMA_NVM_ID_8
#define SNVMA_NVM_ID_8_BANK_NUMBER      0u
#define SNVMA_NVM_ID_8_BANK_SIZE        0u

#if (SNVMA_NVM_ID_8_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_8_BANK_SIZE == 0u)
#error NVM ID #8 => Bank not initialized
#elif (SNVMA_NVM_ID_8_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #8 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 7 */

/* NVM ID #9 */
#if SNVMA_NVM_NUMBER > 8
#define SNVMA_NVM_ID_9
#define SNVMA_NVM_ID_9_BANK_NUMBER      0u
#define SNVMA_NVM_ID_9_BANK_SIZE        0u

#if (SNVMA_NVM_ID_9_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_9_BANK_SIZE == 0u)
#error NVM ID #9 => Bank not initialized
#elif (SNVMA_NVM_ID_9_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #9 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 8 */

/* NVM ID #10 */
#if SNVMA_NVM_NUMBER > 9
#define SNVMA_NVM_ID_10
#define SNVMA_NVM_ID_10_BANK_NUMBER      0u
#define SNVMA_NVM_ID_10_BANK_SIZE        0u

#if (SNVMA_NVM_ID_10_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_10_BANK_SIZE == 0u)
#error NVM ID #10 => Bank not initialized
#elif (SNVMA_NVM_ID_10_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #10 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 9 */

/* NVM ID #11 */
#if SNVMA_NVM_NUMBER > 10
#define SNVMA_NVM_ID_11
#define SNVMA_NVM_ID_11_BANK_NUMBER      0u
#define SNVMA_NVM_ID_11_BANK_SIZE        0u

#if (SNVMA_NVM_ID_11_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_11_BANK_SIZE == 0u)
#error NVM ID #11 => Bank not initialized
#elif (SNVMA_NVM_ID_11_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #11 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 10 */

/* NVM ID #12 */
#if SNVMA_NVM_NUMBER > 11
#define SNVMA_NVM_ID_12
#define SNVMA_NVM_ID_12_BANK_NUMBER      0u
#define SNVMA_NVM_ID_12_BANK_SIZE        0u

#if (SNVMA_NVM_ID_12_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_12_BANK_SIZE == 0u)
#error NVM ID #12 => Bank not initialized
#elif (SNVMA_NVM_ID_12_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #12 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 11 */

/* NVM ID #13 */
#if SNVMA_NVM_NUMBER > 12
#define SNVMA_NVM_ID_13
#define SNVMA_NVM_ID_13_BANK_NUMBER      0u
#define SNVMA_NVM_ID_13_BANK_SIZE        0u

#if (SNVMA_NVM_ID_13_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_13_BANK_SIZE == 0u)
#error NVM ID #13 => Bank not initialized
#elif (SNVMA_NVM_ID_13_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #13 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 12 */

/* NVM ID #14 */
#if SNVMA_NVM_NUMBER > 13
#define SNVMA_NVM_ID_14
#define SNVMA_NVM_ID_14_BANK_NUMBER      0u
#define SNVMA_NVM_ID_14_BANK_SIZE        0u

#if (SNVMA_NVM_ID_14_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_14_BANK_SIZE == 0u)
#error NVM ID #14 => Bank not initialized
#elif (SNVMA_NVM_ID_14_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #14 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 13 */

/* NVM ID #15 */
#if SNVMA_NVM_NUMBER > 14
#define SNVMA_NVM_ID_15
#define SNVMA_NVM_ID_15_BANK_NUMBER      0u
#define SNVMA_NVM_ID_15_BANK_SIZE        0u

#if (SNVMA_NVM_ID_15_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_15_BANK_SIZE == 0u)
#error NVM ID #15 => Bank not initialized
#elif (SNVMA_NVM_ID_15_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #15 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 14 */

/* NVM ID #16 */
#if SNVMA_NVM_NUMBER > 15
#define SNVMA_NVM_ID_16
#define SNVMA_NVM_ID_16_BANK_NUMBER      0u
#define SNVMA_NVM_ID_16_BANK_SIZE        0u

#if (SNVMA_NVM_ID_16_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_16_BANK_SIZE == 0u)
#error NVM ID #16 => Bank not initialized
#elif (SNVMA_NVM_ID_16_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #16 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 15 */

/* NVM ID #17 */
#if SNVMA_NVM_NUMBER > 16
#define SNVMA_NVM_ID_17
#define SNVMA_NVM_ID_17_BANK_NUMBER      0u
#define SNVMA_NVM_ID_17_BANK_SIZE        0u

#if (SNVMA_NVM_ID_17_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_17_BANK_SIZE == 0u)
#error NVM ID #17 => Bank not initialized
#elif (SNVMA_NVM_ID_17_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #17 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 16 */

/* NVM ID #18 */
#if SNVMA_NVM_NUMBER > 17
#define SNVMA_NVM_ID_18
#define SNVMA_NVM_ID_18_BANK_NUMBER      0u
#define SNVMA_NVM_ID_18_BANK_SIZE        0u

#if (SNVMA_NVM_ID_18_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_18_BANK_SIZE == 0u)
#error NVM ID #18 => Bank not initialized
#elif (SNVMA_NVM_ID_18_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #18 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 17 */

/* NVM ID #19 */
#if SNVMA_NVM_NUMBER > 18
#define SNVMA_NVM_ID_19
#define SNVMA_NVM_ID_19_BANK_NUMBER      0u
#define SNVMA_NVM_ID_19_BANK_SIZE        0u

#if (SNVMA_NVM_ID_19_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_19_BANK_SIZE == 0u)
#error NVM ID #19 => Bank not initialized
#elif (SNVMA_NVM_ID_19_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #19 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 18 */

/* NVM ID #20 */
#if SNVMA_NVM_NUMBER > 19
#define SNVMA_NVM_ID_20
#define SNVMA_NVM_ID_20_BANK_NUMBER      0u
#define SNVMA_NVM_ID_20_BANK_SIZE        0u

#if (SNVMA_NVM_ID_20_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_20_BANK_SIZE == 0u)
#error NVM ID #20 => Bank not initialized
#elif (SNVMA_NVM_ID_20_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #20 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 19 */

/* NVM ID #21 */
#if SNVMA_NVM_NUMBER > 20
#define SNVMA_NVM_ID_21
#define SNVMA_NVM_ID_21_BANK_NUMBER      0u
#define SNVMA_NVM_ID_21_BANK_SIZE        0u

#if (SNVMA_NVM_ID_21_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_21_BANK_SIZE == 0u)
#error NVM ID #21 => Bank not initialized
#elif (SNVMA_NVM_ID_21_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #21 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 20 */

/* NVM ID #22 */
#if SNVMA_NVM_NUMBER > 21
#define SNVMA_NVM_ID_22
#define SNVMA_NVM_ID_22_BANK_NUMBER      0u
#define SNVMA_NVM_ID_22_BANK_SIZE        0u

#if (SNVMA_NVM_ID_22_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_22_BANK_SIZE == 0u)
#error NVM ID #22 => Bank not initialized
#elif (SNVMA_NVM_ID_22_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #22 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 21 */

/* NVM ID #23 */
#if SNVMA_NVM_NUMBER > 22
#define SNVMA_NVM_ID_23
#define SNVMA_NVM_ID_23_BANK_NUMBER      0u
#define SNVMA_NVM_ID_23_BANK_SIZE        0u

#if (SNVMA_NVM_ID_23_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_23_BANK_SIZE == 0u)
#error NVM ID #23 => Bank not initialized
#elif (SNVMA_NVM_ID_23_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #23 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 22 */

/* NVM ID #24 */
#if SNVMA_NVM_NUMBER > 23
#define SNVMA_NVM_ID_24
#define SNVMA_NVM_ID_24_BANK_NUMBER      0u
#define SNVMA_NVM_ID_24_BANK_SIZE        0u

#if (SNVMA_NVM_ID_24_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_24_BANK_SIZE == 0u)
#error NVM ID #24 => Bank not initialized
#elif (SNVMA_NVM_ID_24_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #24 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 23 */

/* NVM ID #25 */
#if SNVMA_NVM_NUMBER > 24
#define SNVMA_NVM_ID_25
#define SNVMA_NVM_ID_25_BANK_NUMBER      0u
#define SNVMA_NVM_ID_25_BANK_SIZE        0u

#if (SNVMA_NVM_ID_25_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_25_BANK_SIZE == 0u)
#error NVM ID #25 => Bank not initialized
#elif (SNVMA_NVM_ID_25_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #25 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 24 */

/* NVM ID #26 */
#if SNVMA_NVM_NUMBER > 25
#define SNVMA_NVM_ID_26
#define SNVMA_NVM_ID_26_BANK_NUMBER      0u
#define SNVMA_NVM_ID_26_BANK_SIZE        0u

#if (SNVMA_NVM_ID_26_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_26_BANK_SIZE == 0u)
#error NVM ID #26 => Bank not initialized
#elif (SNVMA_NVM_ID_26_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #26 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 25 */

/* NVM ID #27 */
#if SNVMA_NVM_NUMBER > 26
#define SNVMA_NVM_ID_27
#define SNVMA_NVM_ID_27_BANK_NUMBER      0u
#define SNVMA_NVM_ID_27_BANK_SIZE        0u

#if (SNVMA_NVM_ID_27_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_27_BANK_SIZE == 0u)
#error NVM ID #27 => Bank not initialized
#elif (SNVMA_NVM_ID_27_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #27 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 26 */

/* NVM ID #28 */
#if SNVMA_NVM_NUMBER > 27
#define SNVMA_NVM_ID_28
#define SNVMA_NVM_ID_28_BANK_NUMBER      0u
#define SNVMA_NVM_ID_28_BANK_SIZE        0u

#if (SNVMA_NVM_ID_28_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_28_BANK_SIZE == 0u)
#error NVM ID #28 => Bank not initialized
#elif (SNVMA_NVM_ID_28_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #28 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 27 */

/* NVM ID #29 */
#if SNVMA_NVM_NUMBER > 28
#define SNVMA_NVM_ID_29
#define SNVMA_NVM_ID_29_BANK_NUMBER      0u
#define SNVMA_NVM_ID_29_BANK_SIZE        0u

#if (SNVMA_NVM_ID_29_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_29_BANK_SIZE == 0u)
#error NVM ID #29 => Bank not initialized
#elif (SNVMA_NVM_ID_29_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #29 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 28 */

/* NVM ID #30 */
#if SNVMA_NVM_NUMBER > 29
#define SNVMA_NVM_ID_30
#define SNVMA_NVM_ID_30_BANK_NUMBER      0u
#define SNVMA_NVM_ID_30_BANK_SIZE        0u

#if (SNVMA_NVM_ID_30_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_30_BANK_SIZE == 0u)
#error NVM ID #30 => Bank not initialized
#elif (SNVMA_NVM_ID_30_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #30 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 29 */

/* NVM ID #31 */
#if SNVMA_NVM_NUMBER > 30
#define SNVMA_NVM_ID_31
#define SNVMA_NVM_ID_31_BANK_NUMBER      0u
#define SNVMA_NVM_ID_31_BANK_SIZE        0u

#if (SNVMA_NVM_ID_31_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_31_BANK_SIZE == 0u)
#error NVM ID #31 => Bank not initialized
#elif (SNVMA_NVM_ID_31_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #31 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 30 */

/* NVM ID #32 */
#if SNVMA_NVM_NUMBER > 31
#define SNVMA_NVM_ID_32
#define SNVMA_NVM_ID_32_BANK_NUMBER      0u
#define SNVMA_NVM_ID_32_BANK_SIZE        0u

#if (SNVMA_NVM_ID_32_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_32_BANK_SIZE == 0u)
#error NVM ID #32 => Bank not initialized
#elif (SNVMA_NVM_ID_32_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #32 => Not enough bank
#endif
#endif /* SNVMA_NVM_NUMBER > 31 */

/* ========================================================================== */
/* +                       Check part - NOT USER DEFINED                    + */
/* ========================================================================== */

/* Compute the number of sectors required */
#if defined( SNVMA_NVM_ID_32 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_27_BANK_NUMBER * SNVMA_NVM_ID_27_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_28_BANK_NUMBER * SNVMA_NVM_ID_28_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_29_BANK_NUMBER * SNVMA_NVM_ID_29_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_30_BANK_NUMBER * SNVMA_NVM_ID_30_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_31_BANK_NUMBER * SNVMA_NVM_ID_31_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_32_BANK_NUMBER * SNVMA_NVM_ID_32_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER +  \
                               SNVMA_NVM_ID_27_BANK_NUMBER + SNVMA_NVM_ID_28_BANK_NUMBER +  \
                               SNVMA_NVM_ID_29_BANK_NUMBER + SNVMA_NVM_ID_30_BANK_NUMBER +  \
                               SNVMA_NVM_ID_31_BANK_NUMBER + SNVMA_NVM_ID_32_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_31 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_27_BANK_NUMBER * SNVMA_NVM_ID_27_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_28_BANK_NUMBER * SNVMA_NVM_ID_28_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_29_BANK_NUMBER * SNVMA_NVM_ID_29_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_30_BANK_NUMBER * SNVMA_NVM_ID_30_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_31_BANK_NUMBER * SNVMA_NVM_ID_31_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER +  \
                               SNVMA_NVM_ID_27_BANK_NUMBER + SNVMA_NVM_ID_28_BANK_NUMBER +  \
                               SNVMA_NVM_ID_29_BANK_NUMBER + SNVMA_NVM_ID_30_BANK_NUMBER +  \
                               SNVMA_NVM_ID_31_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_30 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_27_BANK_NUMBER * SNVMA_NVM_ID_27_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_28_BANK_NUMBER * SNVMA_NVM_ID_28_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_29_BANK_NUMBER * SNVMA_NVM_ID_29_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_30_BANK_NUMBER * SNVMA_NVM_ID_30_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER +  \
                               SNVMA_NVM_ID_27_BANK_NUMBER + SNVMA_NVM_ID_28_BANK_NUMBER +  \
                               SNVMA_NVM_ID_29_BANK_NUMBER + SNVMA_NVM_ID_30_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_29 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_27_BANK_NUMBER * SNVMA_NVM_ID_27_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_28_BANK_NUMBER * SNVMA_NVM_ID_28_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_29_BANK_NUMBER * SNVMA_NVM_ID_29_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER +  \
                               SNVMA_NVM_ID_27_BANK_NUMBER + SNVMA_NVM_ID_28_BANK_NUMBER +  \
                               SNVMA_NVM_ID_29_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_28 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_27_BANK_NUMBER * SNVMA_NVM_ID_27_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_28_BANK_NUMBER * SNVMA_NVM_ID_28_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER +  \
                               SNVMA_NVM_ID_27_BANK_NUMBER + SNVMA_NVM_ID_28_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_27 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_27_BANK_NUMBER * SNVMA_NVM_ID_27_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER +  \
                               SNVMA_NVM_ID_27_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_26 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_26_BANK_NUMBER * SNVMA_NVM_ID_26_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER + SNVMA_NVM_ID_26_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_25 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_25_BANK_NUMBER * SNVMA_NVM_ID_25_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER +  \
                               SNVMA_NVM_ID_25_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_24 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_24_BANK_NUMBER * SNVMA_NVM_ID_24_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER + SNVMA_NVM_ID_24_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_23 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_23_BANK_NUMBER * SNVMA_NVM_ID_23_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER +  \
                               SNVMA_NVM_ID_23_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_22 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_22_BANK_NUMBER * SNVMA_NVM_ID_22_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER + SNVMA_NVM_ID_22_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_21 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_21_BANK_NUMBER * SNVMA_NVM_ID_21_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER +  \
                               SNVMA_NVM_ID_21_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_20 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_20_BANK_NUMBER * SNVMA_NVM_ID_20_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER + SNVMA_NVM_ID_20_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_19 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_19_BANK_NUMBER * SNVMA_NVM_ID_19_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER +  \
                               SNVMA_NVM_ID_19_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_18 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_18_BANK_NUMBER * SNVMA_NVM_ID_18_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER + SNVMA_NVM_ID_18_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_17 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_17_BANK_NUMBER * SNVMA_NVM_ID_17_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER +  \
                               SNVMA_NVM_ID_17_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_16 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_16_BANK_NUMBER * SNVMA_NVM_ID_16_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER + SNVMA_NVM_ID_16_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_15 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_15_BANK_NUMBER * SNVMA_NVM_ID_15_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER +  \
                               SNVMA_NVM_ID_15_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_14 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_14_BANK_NUMBER * SNVMA_NVM_ID_14_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER + SNVMA_NVM_ID_14_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_13 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_13_BANK_NUMBER * SNVMA_NVM_ID_13_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER +  \
                               SNVMA_NVM_ID_13_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_12 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_12_BANK_NUMBER * SNVMA_NVM_ID_12_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER + SNVMA_NVM_ID_12_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_11 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_11_BANK_NUMBER * SNVMA_NVM_ID_11_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER +  \
                               SNVMA_NVM_ID_11_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_10 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_10_BANK_NUMBER * SNVMA_NVM_ID_10_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER  + SNVMA_NVM_ID_10_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_9 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_9_BANK_NUMBER * SNVMA_NVM_ID_9_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_9_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_8 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_8_BANK_NUMBER * SNVMA_NVM_ID_8_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER  + SNVMA_NVM_ID_8_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_7 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_7_BANK_NUMBER * SNVMA_NVM_ID_7_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_7_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_6 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_6_BANK_NUMBER * SNVMA_NVM_ID_6_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER  + SNVMA_NVM_ID_6_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_5 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_5_BANK_NUMBER * SNVMA_NVM_ID_5_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_5_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_4 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_4_BANK_NUMBER * SNVMA_NVM_ID_4_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER  + SNVMA_NVM_ID_4_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_3 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_3_BANK_NUMBER * SNVMA_NVM_ID_3_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER  +  \
                               SNVMA_NVM_ID_3_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_2 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE) + \
                                      (SNVMA_NVM_ID_2_BANK_NUMBER * SNVMA_NVM_ID_2_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER  + SNVMA_NVM_ID_2_BANK_NUMBER)

#elif defined ( SNVMA_NVM_ID_1 )
#define SNVMA_NUMBER_OF_SECTOR_NEEDED (SNVMA_NVM_ID_1_BANK_NUMBER * SNVMA_NVM_ID_1_BANK_SIZE)

#define SNVMA_NUMBER_OF_BANKS (SNVMA_NVM_ID_1_BANK_NUMBER)
#else
#define SNVMA_NUMBER_OF_SECTOR_NEEDED   0u

#define SNVMA_NUMBER_OF_BANKS 0u
#endif /* SNVMA_NUMBER_OF_SECTOR_NEEDED > 0 */

/* Check that required number of sector does not exceed Flash capacities */
#if SNVMA_NUMBER_OF_SECTOR_NEEDED == 0u
#error SNVMA_NUMBER_OF_SECTOR_NEEDED shall not be zero
#elif SNVMA_NUMBER_OF_BANKS == 0u
#error SNVMA_NUMBER_OF_BANKS shall not be zero
#endif /* SNVMA_NUMBER_OF_SECTOR_NEEDED == 0 */

/* Exported types ------------------------------------------------------------*/

/* ========================================================================== */
/* +                    Buffer ID part - CAN BE USER DEFINED                + */
/* ========================================================================== */

/**
 * @brief Enumeration of the Buffer IDs availble
 *
 * @details Each NVM can handle up to 4 user IDs
 *
 * @details Enumeration member can be renamed to fit user needs - ie: SNVMA_BufferId_4 => SNVMA_BleNvmId
 *
 */
typedef enum SNVMA_BufferId
{
#ifdef SNVMA_NVM_ID_1
  APP_BLE_NvmBuffer,/* SNVMA_BufferId_0, */
  SNVMA_BufferId_1,
  SNVMA_BufferId_2,
  SNVMA_BufferId_3,
#endif
#ifdef SNVMA_NVM_ID_2
  SNVMA_BufferId_4,
  SNVMA_BufferId_5,
  SNVMA_BufferId_6,
  SNVMA_BufferId_7,
#endif
#ifdef SNVMA_NVM_ID_3
  SNVMA_BufferId_8,
  SNVMA_BufferId_9,
  SNVMA_BufferId_10,
  SNVMA_BufferId_11,
#endif
#ifdef SNVMA_NVM_ID_4
  SNVMA_BufferId_12,
  SNVMA_BufferId_13,
  SNVMA_BufferId_14,
  SNVMA_BufferId_15,
#endif
#ifdef SNVMA_NVM_ID_5
  SNVMA_BufferId_16,
  SNVMA_BufferId_17,
  SNVMA_BufferId_18,
  SNVMA_BufferId_19,
#endif
#ifdef SNVMA_NVM_ID_6
  SNVMA_BufferId_20,
  SNVMA_BufferId_21,
  SNVMA_BufferId_22,
  SNVMA_BufferId_23,
#endif
#ifdef SNVMA_NVM_ID_7
  SNVMA_BufferId_24,
  SNVMA_BufferId_25,
  SNVMA_BufferId_26,
  SNVMA_BufferId_27,
#endif
#ifdef SNVMA_NVM_ID_8
  SNVMA_BufferId_28,
  SNVMA_BufferId_29,
  SNVMA_BufferId_30,
  SNVMA_BufferId_31,
#endif
#ifdef SNVMA_NVM_ID_9
  SNVMA_BufferId_32,
  SNVMA_BufferId_33,
  SNVMA_BufferId_34,
  SNVMA_BufferId_35,
#endif
#ifdef SNVMA_NVM_ID_10
  SNVMA_BufferId_36,
  SNVMA_BufferId_37,
  SNVMA_BufferId_38,
  SNVMA_BufferId_39,
#endif
#ifdef SNVMA_NVM_ID_11
  SNVMA_BufferId_40,
  SNVMA_BufferId_41,
  SNVMA_BufferId_42,
  SNVMA_BufferId_43,
#endif
#ifdef SNVMA_NVM_ID_12
  SNVMA_BufferId_44,
  SNVMA_BufferId_45,
  SNVMA_BufferId_46,
  SNVMA_BufferId_47,
#endif
#ifdef SNVMA_NVM_ID_13
  SNVMA_BufferId_48,
  SNVMA_BufferId_49,
  SNVMA_BufferId_50,
  SNVMA_BufferId_51,
#endif
#ifdef SNVMA_NVM_ID_14
  SNVMA_BufferId_52,
  SNVMA_BufferId_53,
  SNVMA_BufferId_54,
  SNVMA_BufferId_55,
#endif
#ifdef SNVMA_NVM_ID_15
  SNVMA_BufferId_56,
  SNVMA_BufferId_57,
  SNVMA_BufferId_58,
  SNVMA_BufferId_59,
#endif
#ifdef SNVMA_NVM_ID_16
  SNVMA_BufferId_60,
  SNVMA_BufferId_61,
  SNVMA_BufferId_62,
  SNVMA_BufferId_63,
#endif
#ifdef SNVMA_NVM_ID_17
  SNVMA_BufferId_64,
  SNVMA_BufferId_65,
  SNVMA_BufferId_66,
  SNVMA_BufferId_67,
#endif
#ifdef SNVMA_NVM_ID_18
  SNVMA_BufferId_68,
  SNVMA_BufferId_69,
  SNVMA_BufferId_70,
  SNVMA_BufferId_71,
#endif
#ifdef SNVMA_NVM_ID_19
  SNVMA_BufferId_72,
  SNVMA_BufferId_73,
  SNVMA_BufferId_74,
  SNVMA_BufferId_75,
#endif
#ifdef SNVMA_NVM_ID_20
  SNVMA_BufferId_76,
  SNVMA_BufferId_77,
  SNVMA_BufferId_78,
  SNVMA_BufferId_79,
#endif
#ifdef SNVMA_NVM_ID_21
  SNVMA_BufferId_80,
  SNVMA_BufferId_81,
  SNVMA_BufferId_82,
  SNVMA_BufferId_83,
#endif
#ifdef SNVMA_NVM_ID_22
  SNVMA_BufferId_84,
  SNVMA_BufferId_85,
  SNVMA_BufferId_86,
  SNVMA_BufferId_87,
#endif
#ifdef SNVMA_NVM_ID_23
  SNVMA_BufferId_88,
  SNVMA_BufferId_89,
  SNVMA_BufferId_90,
  SNVMA_BufferId_91,
#endif
#ifdef SNVMA_NVM_ID_24
  SNVMA_BufferId_92,
  SNVMA_BufferId_93,
  SNVMA_BufferId_94,
  SNVMA_BufferId_95,
#endif
#ifdef SNVMA_NVM_ID_25
  SNVMA_BufferId_96,
  SNVMA_BufferId_97,
  SNVMA_BufferId_98,
  SNVMA_BufferId_99,
#endif
#ifdef SNVMA_NVM_ID_26
  SNVMA_BufferId_100,
  SNVMA_BufferId_101,
  SNVMA_BufferId_102,
  SNVMA_BufferId_103,
#endif
#ifdef SNVMA_NVM_ID_27
  SNVMA_BufferId_104,
  SNVMA_BufferId_105,
  SNVMA_BufferId_106,
  SNVMA_BufferId_107,
#endif
#ifdef SNVMA_NVM_ID_28
  SNVMA_BufferId_108,
  SNVMA_BufferId_109,
  SNVMA_BufferId_110,
  SNVMA_BufferId_111,
#endif
#ifdef SNVMA_NVM_ID_29
  SNVMA_BufferId_112,
  SNVMA_BufferId_113,
  SNVMA_BufferId_114,
  SNVMA_BufferId_115,
#endif
#ifdef SNVMA_NVM_ID_30
  SNVMA_BufferId_116,
  SNVMA_BufferId_117,
  SNVMA_BufferId_118,
  SNVMA_BufferId_119,
#endif
#ifdef SNVMA_NVM_ID_31
  SNVMA_BufferId_120,
  SNVMA_BufferId_121,
  SNVMA_BufferId_122,
  SNVMA_BufferId_123,
#endif
#ifdef SNVMA_NVM_ID_32
  SNVMA_BufferId_124,
  SNVMA_BufferId_125,
  SNVMA_BufferId_126,
  SNVMA_BufferId_127,
#endif
  SNVMA_BufferId_Max  /* End of the enumeration */
}SNVMA_BufferId_t;

/* Exported variables --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

#ifdef __cplusplus
}
#endif

#endif /* SIMPLE_NVM_ARBITER_CONF_H */
