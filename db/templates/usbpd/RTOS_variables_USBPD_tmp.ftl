[#ftl]
/* USER CODE BEGIN USBPD_Pool_Buffer */

/* USER CODE END USBPD_Pool_Buffer */
#if defined ( __ICCARM__ )
#pragma data_alignment=4
#endif
static UCHAR usbpd_byte_pool_buffer[USBPD_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL usbpd_app_byte_pool;