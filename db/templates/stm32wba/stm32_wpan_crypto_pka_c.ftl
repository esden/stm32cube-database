[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    crypto_pka.c
  * @author  MCD Application Team
  * @brief   Cryptography operation for PKA
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */


/* Includes ------------------------------------------------------------------*/
#include "crypto_pka_if.h"
#include "crypto.h"
  

/* Private define ------------------------------------------------------------*/

enum
{
  PKA_IDLE = 0,
  PKA_P256_KEY_ALLOCATE,
  PKA_P256_KEY_GEN,
  PKA_POINT_CHECK,
  PKA_DH_KEY_GEN,
};


#define KDF_ALG                                 PSA_ALG_ECDH( PSA_ALG_SELECT_RAW )

#define PSA_BYTES_TO_BITS(bytes)                ((bytes) * 8)
#define KEY_SIZE_BYTES                          (32u)
#define P256_PUBLIC_KEY_LENGTH                  (64u)
#define DH_KEY_LENGTH                           (KEY_SIZE_BYTES)



/* Private Variables ------------------------------------------------------------*/
static psa_key_handle_t key_handle = 0;
static psa_crypto_generator_t generator = PSA_CRYPTO_GENERATOR_INIT;
static uint8_t pka_state = PKA_IDLE;
static uint8_t pka_error;
static uint8_t key_data[P256_PUBLIC_KEY_LENGTH+1u];
static uint8_t remotePublicKey[P256_PUBLIC_KEY_LENGTH+1u];

/* Private Prototype ------------------------------------------------------------*/
static void* reversememcpy(void *to, const void *from, uint16_t n);

/* Exported functions ---------------------------------------------------------*/

int CRYPTO_PkaStartP256Key(const uint8_t* local_private_key)
{
  psa_status_t status;

  psa_key_policy_t policy = PSA_KEY_POLICY_INIT;
  
  if(pka_state != PKA_IDLE){
    return CRYPTO_BUSY;
  }
  /* Enable PSA crypto */
  status = psa_crypto_init();
  if( status != PSA_SUCCESS ){
    return CRYPTO_ERROR;
  }
  
  /* Close a key handle.
   * If the handle designates a volatile key, destroy the key material and
   * free all associated resources
   */
  (void) psa_close_key( key_handle );
  
  psa_allocate_key( &key_handle );
  psa_key_policy_set_usage( &policy,
                        PSA_KEY_USAGE_DERIVE | PSA_KEY_USAGE_EXPORT,
                        KDF_ALG );
  
  psa_set_key_policy( key_handle, &policy );
  status = psa_import_key( key_handle,
                           PSA_KEY_TYPE_ECC_KEYPAIR(PSA_ECC_CURVE_SECP256R1),
                           local_private_key,
                           32);
 
  pka_state = PKA_P256_KEY_GEN;
  pka_error = 1;

  return CRYPTO_OK;
}

int CRYPTO_PkaStatus( void )
{
  int pka_status = CRYPTO_OK; 
  size_t key_size;

  switch ( pka_state )
  {
  default:
  case PKA_IDLE:
    return CRYPTO_OK;
    
  case PKA_P256_KEY_ALLOCATE:
   /* Generate a key or key pair. */
    if(psa_generate_key( key_handle,
                        PSA_KEY_TYPE_ECC_KEYPAIR(PSA_ECC_CURVE_SECP256R1),
                        PSA_BYTES_TO_BITS( KEY_SIZE_BYTES ),
                        NULL, 
                        0 ) != PSA_SUCCESS ){
      pka_status = CRYPTO_ERROR;
      pka_error = 0;   
    }
    else{
      pka_state = PKA_P256_KEY_GEN;
      return CRYPTO_BUSY;
    }
    break;
    
  case PKA_P256_KEY_GEN:

    if(psa_export_public_key( key_handle,
                              key_data, 
                              sizeof( key_data ),
                              &key_size ) != PSA_SUCCESS ){
      pka_status = CRYPTO_ERROR;
    }
    pka_error = 0;                          
    break;
    
    
      
  case PKA_POINT_CHECK:
    if(psa_key_agreement(&generator,
                    key_handle,
                    remotePublicKey,
                    65u,
                    KDF_ALG)!= PSA_SUCCESS ){
                      
      pka_status = CRYPTO_ERROR;
      pka_error = 0; 
    }
    else{
      pka_state = PKA_DH_KEY_GEN;
      return CRYPTO_BUSY;
    }                       
    break;
      
  case PKA_DH_KEY_GEN:
    pka_error = 0;                          
    break;
    
  }

  pka_state = PKA_IDLE;

  return pka_status;
}

int CRYPTO_PkaReadP256Key( uint32_t* local_public_key )
{
  uint8_t *p = (uint8_t *) &local_public_key[0u];
  if ( pka_error )
    return CRYPTO_EOF;

  /* Get local public key from buffer */
  reversememcpy(&p[0u], &key_data[1u], 32u );
  reversememcpy(&p[32u], &key_data[33u], 32u );
      
  return CRYPTO_OK;
}

int CRYPTO_GenerateRNG( uint8_t n, uint32_t* val )
{
  psa_status_t status;
  uint8_t *random = (uint8_t* ) val;
    
  /* Enable PSA crypto */
  status = psa_crypto_init();
  if( status != PSA_SUCCESS ){
    return CRYPTO_ERROR;
  }
  /* Generate random bytes */
  psa_generate_random(random, (n*4u));
      
  return CRYPTO_OK;
}

int CRYPTO_PkaStartDhKey(const uint8_t* local_private_key,
                         const uint8_t* remote_public_key )
{
  psa_status_t status;
  
  psa_key_policy_t policy = PSA_KEY_POLICY_INIT;
  
  if(pka_state != PKA_IDLE){
    return CRYPTO_BUSY;
  }
  /* Enable PSA crypto */
  status = psa_crypto_init();
  if( status != PSA_SUCCESS ){
    return CRYPTO_ERROR;
  }
  
  /* Close a key handle.
   * If the handle designates a volatile key, destroy the key material and
   * free all associated resources
   */
  (void) psa_close_key( key_handle );
  
  psa_allocate_key( &key_handle );
  psa_key_policy_set_usage( &policy,
                        PSA_KEY_USAGE_DERIVE | PSA_KEY_USAGE_EXPORT,
                        KDF_ALG );
  
  psa_set_key_policy( key_handle, &policy );
  status = psa_import_key( key_handle,
                           PSA_KEY_TYPE_ECC_KEYPAIR(PSA_ECC_CURVE_SECP256R1),
                           local_private_key,
                           32);
  if( status != PSA_SUCCESS ){
    return CRYPTO_ERROR;
  }
  
  remotePublicKey[0] = 0x04;
  
  reversememcpy( &remotePublicKey[1], &remote_public_key[0], 32 );
  reversememcpy( &remotePublicKey[33], &remote_public_key[32], 32 );
  pka_state = PKA_POINT_CHECK;
#if 0    
    
  status = psa_key_agreement(&generator,
                            key_handle,
                            remotePublicKey,
                            65,
                            KDF_ALG);  
  if( status != PSA_SUCCESS ){
    return CRYPTO_ERROR;
  }
  
  pka_state = PKA_DH_KEY_GEN;
#endif 
  
  pka_error = 1;

  return CRYPTO_OK;
}

int CRYPTO_PkaReadDhKey( uint32_t* dh_key )
{
  uint8_t *p = (uint8_t *) &dh_key[0u];
  if ( pka_error ){
    return CRYPTO_EOF;
  }
  /* Get local public key from buffer */
  reversememcpy( &p[0], &generator.ctx.buffer.data[0], generator.ctx.buffer.size );
  return CRYPTO_OK;
}

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void* reversememcpy(void *to, const void *from, uint16_t n){

    uint16_t count = n;
    if ( count > 0u ) {
        /* cast it in uint8_t */
        uint8_t       *s1 = (uint8_t *) to;
        const uint8_t *s2 = (((( const uint8_t *)from )+ count) - 1);

        do {
            *s1 = *s2;
            s1++;
            s2--;
        } while (--count != 0u);
    }

    return (to);
}

