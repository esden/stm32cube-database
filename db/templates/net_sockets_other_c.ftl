[#ftl]
/* USER CODE BEGIN Header */
/** 
  ******************************************************************************
  * File Name       : ${name}.h
  * Description     : TCP/IP or UDP/IP networking empty functions
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#if !defined(MBEDTLS_CONFIG_FILE)
#include "mbedtls/config.h"
#else
#include MBEDTLS_CONFIG_FILE
#endif

#include <string.h>
#include <stdint.h>
#if defined(MBEDTLS_NET_C)

#if defined(MBEDTLS_PLATFORM_C)
#include "mbedtls/platform.h"
#else
#include <stdlib.h>
#endif

#include "mbedtls/net_sockets.h"

#include "ethernetif.h"
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]

#include "${main_h}"
/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */
static struct netif netif;

static int net_would_block( const mbedtls_net_context *ctx );
/* USER CODE BEGIN VARIABLES */

/* USER CODE END VARIABLES */
/*
 * Initialize TCP/IP stack and get a dynamic IP address.
 */
void mbedtls_net_init( mbedtls_net_context *ctx )
{
/* USER CODE BEGIN 0 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
/* USER CODE END 0 */
}

/*
 * Initiate a TCP connection with host:port and the given protocol
 */
int mbedtls_net_connect( mbedtls_net_context *ctx, const char *host, const char *port, int proto )
{
/* USER CODE BEGIN 1 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return MBEDTLS_ERR_NET_UNKNOWN_HOST;
/* USER CODE END 1 */
}

/*
 * Create a listening socket on bind_ip:port
 */
int mbedtls_net_bind( mbedtls_net_context *ctx, const char *bind_ip, const char *port, int proto )
{
  int ret = 0;
/* USER CODE BEGIN 2 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
/* USER CODE END 2 */
  return ret;
}

/*
 * Accept a connection from a remote client
 */
int mbedtls_net_accept( mbedtls_net_context *bind_ctx,
                        mbedtls_net_context *client_ctx,
                        void *client_ip, size_t buf_size, size_t *ip_len )
{
/* USER CODE BEGIN 3 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return 0;
/* USER CODE END 3 */
}

/*
 * Set the socket blocking or non-blocking
 */
int mbedtls_net_set_block( mbedtls_net_context *ctx )
{
/* USER CODE BEGIN 4 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return 0;
/* USER CODE END 4 */
}

int mbedtls_net_set_nonblock( mbedtls_net_context *ctx )
{
/* USER CODE BEGIN 5 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return 0;
/* USER CODE END 5 */
}

/*
 * Portable usleep helper
 */
void mbedtls_net_usleep( unsigned long usec )
{
/* USER CODE BEGIN 6 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
/* USER CODE END 6 */
}

/*
 * Read at most 'len' characters
 */
int mbedtls_net_recv( void *ctx, unsigned char *buf, size_t len )
{
/* USER CODE BEGIN 7 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return MBEDTLS_ERR_NET_INVALID_CONTEXT;
/* USER CODE END 7 */
}

/*
 * Read at most 'len' characters, blocking for at most 'timeout' ms
 */
int mbedtls_net_recv_timeout( void *ctx, unsigned char *buf, size_t len,
                      uint32_t timeout )
{
/* USER CODE BEGIN 8 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return 0;  
/* USER CODE END 8 */
}


static int net_would_block( const mbedtls_net_context *ctx )
{
/* USER CODE BEGIN 9 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return 0; 
/* USER CODE END 9 */
}

/*
 * Write at most 'len' characters
 */
int mbedtls_net_send( void *ctx, const unsigned char *buf, size_t len )
{
/* USER CODE BEGIN 10 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
  return MBEDTLS_ERR_NET_INVALID_CONTEXT;
/* USER CODE END 10 */
}

/*
 * Gracefully close the connection
 */
void mbedtls_net_free( mbedtls_net_context *ctx )
{
/* USER CODE BEGIN 11 */
  mbedtls_printf ("%s() NOT IMPLEMENTED!!\n", __FUNCTION__);
/* USER CODE END 11 */
 }

#endif /* MBEDTLS_NET_C */