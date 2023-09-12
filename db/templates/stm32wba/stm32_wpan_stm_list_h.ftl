[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    stm_list.h
  * @author  MCD Application Team
  * @brief   Header file for linked list library.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef STM_LIST_H
#define STM_LIST_H

/* Includes ------------------------------------------------------------------*/
#include "stm32_wpan_common.h"

typedef __PACKED_STRUCT _tListNode {
    struct _tListNode * next;
    struct _tListNode * prev;
} tListNode;

void LST_init_head (tListNode * listHead);

uint8_t LST_is_empty (tListNode * listHead);

void LST_insert_head (tListNode * listHead, tListNode * node);

void LST_insert_tail (tListNode * listHead, tListNode * node);

void LST_remove_node (tListNode * node);

void LST_remove_head (tListNode * listHead, tListNode ** node );

void LST_remove_tail (tListNode * listHead, tListNode ** node );

void LST_insert_node_after (tListNode * node, tListNode * ref_node);

void LST_insert_node_before (tListNode * node, tListNode * ref_node);

int LST_get_size (tListNode * listHead);

void LST_get_next_node (tListNode * ref_node, tListNode ** node);

void LST_get_prev_node (tListNode * ref_node, tListNode ** node);

#endif /* STM_LIST_H */
