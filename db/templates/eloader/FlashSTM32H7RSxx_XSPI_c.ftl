[#ftl]
/*************************************************************************
*
*   Used with ICCARM and AARM.
*
*    (c) Copyright IAR Systems 2015
*
*    File name   : FlashSTM32H7rsxx_OSPI.c
*    Description : Flash Loader For Serial NOR flash
*
*    History :
*    1. Date        : April, 2022
*       Description : Initial OSPI flashloader 
*
*
*    $Revision: 39 $
**************************************************************************/
#include "extmem.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#include "Loader_Src.h"
/* The flash loader framework API declarations */
#include "flash_loader.h"
#include "flash_loader_extra.h"

char buff_address_zero[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
                             0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF };

/** external functions **/

/** external data **/

/** internal functions **/


/** public data **/
/** private data **/
/** public functions **/

/*************************************************************************
* Function Name: FlashMain
* Parameters: Flash Base Address
*
* Return: 1 : result_OK
*         
*
* Description: Init OSPI flash driver.
*************************************************************************/
#ifdef DEBUG_EN
uint32_t FlashMain(void *base_of_flash, uint32_t image_size,
                   uint32_t link_address)
{

 main();
 return 1; 
}
#endif
/*************************************************************************
* Function Name: FlashInit
* Parameters: Flash Base Address
*
* Return: 0: RESULT_OK
*         1: RESULT_Fail
*
* Description: Init OSPI flash driver.
*************************************************************************/
#if USE_ARGC_ARGV
uint32_t FlashInit(void *base_of_flash, uint32_t image_size,
                   uint32_t link_address, uint32_t flags,
                   int argc, char const *argv[])
#else
uint32_t FlashInit(void *base_of_flash, uint32_t image_size,
                   uint32_t link_address, uint32_t flags)
#endif  /*USE_ARGC_ARGV*/
{

 if(Init()!=0)
   return 0;
 else 
   return 1;
  
}

/*************************************************************************
* Function Name: FlashWrite
* Parameters: block base address, offset in block, data size, ram buffer
*             pointer
* Return: 0: RESULT_OK
*         1: RESULT_Fail
*
* Description. Writes data to OSPI flash
*************************************************************************/
uint32_t FlashWrite(void *block_start,
                    uint32_t offset_into_block,
                    uint32_t count,
                    char const *buffer)
{
  /* Set destination address */
  uint32_t Dest =  0;
  Dest = (uint32_t)block_start + offset_into_block;
  /* Set source address */
  uint8_t * Src;
  Src = (uint8_t *)(buffer);
  uint32_t size =  0;
  size = count;
  if(Write(Dest,size, Src)!=0)
   return 0;
  else
   return 1;
  
}

/*************************************************************************
* Function Name: FlashErase
* Parameters:  Block Address, Block Size
*
* Return: 0:RESULT_OK
*         1:RESULT_Fail
*
* Description: Erase block
*************************************************************************/
uint32_t FlashErase(void *block_start,
                    uint32_t block_size)
{
  int result = 0;
  result = SectorErase ((uint32_t) block_start & 0xffffffff ,((uint32_t) block_start & 0xffffffff) + block_size);
  if (result == 1)   
    return 0;   //OK
  else 
    return result;
  
  
}

/*************************************************************************
* Function Name: FlashSignoff
* Parameters: none
*
* Return: 0: RESULT_OK
*         1: RESULT_Fail
*
* Description:
*************************************************************************/
#if USE_ARGC_ARGV
OPTIONAL_SIGNOFF
uint32_t FlashSignoff(void)
{

  return RESULT_OK;
}
#endif

/*************************************************************************
* Function Name: FlashChecksum
* Parameters: none
*
* Return: 0:RESULT_OK
*         wrong address
*
* Description:
*************************************************************************/

OPTIONAL_CHECKSUM 

uint32_t FlashChecksum(void const *begin, uint32_t count)
{
/* Disable memory mapped mode if enabled */
    if (EXTMEM_MemoryMappedMode(EXTMEMORY_1, EXTMEM_ENABLE) != EXTMEM_OK)
    {
      return 0;
    }
 return Crc16((uint8_t const *)begin, count);
} 

/** private functions **/
  

