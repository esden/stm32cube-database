[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    debug_config.h
  * @author  MCD Application Team
  * @brief   Real Time Debug module general configuration file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign IpInstance = ""]
[#assign IpName = ""]
[#assign useSCMSYSTEM = false]
[#assign useSCMSETUP  = false]
[#assign useSCMHSERDY = false]
[#assign useSCMACT    = false]
[#assign useSCMDEACT  = false]
[#assign useSCMTEMP   = false]
[#assign useSCMRNGE   = false]
[#assign useSCMRNGD   = false]
[#assign useSCMRNGG   = false]
[#assign useSCMMODEN  = false]
[#assign useSCMMODEX  = false]
[#assign useSCMMODAC  = false]
[#assign useSCMSSEN   = false]
[#assign useSCMSSEX   = false]
[#assign useSCMSSAC   = false]
[#assign useSCMSTEN   = false]
[#assign useSCMSTEX   = false]
[#assign useSCMSTAC   = false]
[#assign useSCMHCRE   = false]
[#assign useSCMHCRC   = false]
[#assign useSCMHCWR   = false]
[#assign useSCMSCEVU  = false]
[#assign useSCMSCTI   = false]
[#assign useSCMSCPY   = false]
[#assign useSCMSCEVS  = false]
[#assign useSCMSCHN   = false]
[#assign useSCMACN    = false]
[#assign useSCMACNC   = false]
[#assign useSCMACNT   = false]
[#assign useSCMACNR   = false]
[#assign useSCMSCER   = false]
[#assign useSCMSCAC   = false]
[#assign useSCMSCHM   = false]
[#assign useSCMSCUE   = false]
[#assign useSCMSCET   = false]
[#assign useSCMSCEP   = false]
[#assign useSCMSCEE   = false]
[#assign useSCMSCWI   = false]
[#assign useSCMLLCM   = false]
[#assign useSCMLLHI   = false]
[#assign useSCMLLCI   = false]
[#assign useSCMLLCT   = false]
[#assign useSCMLLIS   = false]
[#assign useSCMLLSP   = false]
[#assign useSCMLLSG   = false]
[#assign useSCMLLLI   = false]
[#assign useSCMLLST   = false]
[#assign useSCMLLEA   = false]
[#assign useSCMLLPA   = false]
[#assign useSCMPOEV   = false]
[#assign useSCMHNAL   = false]
[#assign useSCMPREV   = false]
[#assign useSCMPRIS   = false]
[#assign useSCMPREM   = false]
[#assign useSCMFREM   = false]
[#assign useSCMREUN   = false]
[#assign useSCMREDA   = false]
[#assign useSCMRENO   = false]
[#assign useSCMRETR   = false]
[#assign useSCMISHN   = false]
[#assign useSCMLLIN   = false]
[#assign useSCMDATO   = false]
[#assign useSCMLLPK   = false]
[#assign useSCMPYIN   = false]
[#assign useSCMPYCL   = false]
[#assign useSCMPYST   = false]
[#assign useSCMPYEX   = false]
[#assign useSCMRCAC   = false]
[#assign useSCMRCST   = false]
[#assign useSCMSTRU   = false]
[#assign useSCMSTRC   = false]
[#assign useSCMRCIS   = false]
[#assign useSCMRCCO   = false]
[#assign useSCMRAST   = false]
[#assign useSCMRAER   = false]
[#assign useSCMRATR   = false]
[#assign useSCMRAOP   = false]
[#assign useSCMRARX   = false]
[#assign useSCMDOCL   = false]
[#assign useSCMRADO   = false]
[#assign useSCMRACL   = false]
[#assign useSCMRAED   = false]
[#assign useSCMERCA   = false]
[#assign useSCMERCO   = false]
[#assign useSCMPTIN   = false]
[#assign useSCMPTEN   = false]
[#assign useSCMPTSE   = false]
[#assign useSCMPTPA   = false]
[#assign useSCMCOST   = false]
[#assign useSCMCOAS   = false]
[#assign useSCMCOTI   = false]
[#assign useSCMCOON   = false]
[#assign useSCMCOFO   = false]
[#assign useSCMLLAD   = false]
[#assign useSCMLLSC   = false]
[#assign useSCMLLID   = false]
[#assign useSCMLLCO   = false]
[#assign useSCMLLGD   = false]
[#assign useSCMLLBI   = false]
[#assign useSCMLLTM   = false]
[#assign useSCMLLEX   = false]
[#assign useSCMLLDU   = false]
[#assign useSCMADPE   = false]
[#assign useSCMADEX   = false]
[#assign useSCMBITI   = false]
[#assign useSCMBITM   = false]
[#assign useSCMBITS   = false]
[#assign useSCMBIMO   = false]
[#assign useSCMISCB   = false]
[#assign useSCMISMO   = false]
[#assign useSCMCOTM   = false]
[#assign useSCMSCCB   = false]
[#assign useSCMHCPO   = false]
[#assign useSCMLLRR   = false]
[#assign useSCMENDE   = false]
[#assign useSCMPRPO   = false]
[#assign useSCMANTM   = false]
[#assign useSCMFRAI   = false]
[#assign useSCMMLEN   = false]
[#assign useSCMGNTM   = false]
[#assign useSCMMILS   = false]
[#assign useSCMPWPR   = false]
[#assign useSCMPRTM   = false]
[#assign useSCMRAPY   = false]
[#assign useSCMRACS   = false]
[#assign useSCMCSCB   = false]
[#assign useSCMEDCB   = false]
[#assign useSCMDIEX   = false]
[#assign useSCMRCCL   = false]
[#assign useSCMADMN   = false]
[#assign useSCMADCB   = false]
[#assign useSCMMNER   = false]
[#assign useSCMMNCN   = false]
[#assign useSCMPRER   = false]
[#assign useSCMBICB   = false]
[#assign useSCMBICK   = false]
[#assign useSCMSYCB   = false]
[#assign useSCMERRC   = false]
[#assign useSCMCITR   = false]
[#assign useSCMISBK   = false]
[#assign useSCMCONN   = false]
[#assign useSCMCLBR   = false]
[#assign useSCMPRDC   = false]
[#assign useSCMNCON   = false]
[#assign useSCMADVC   = false]
[#assign useSCMINIT   = false]
[#assign useSCMCMEV   = false]
[#assign useSCMEVCB   = false]
[#assign useSCMTMOU   = false]
[#assign useSCMDURE   = false]
[#assign useSCMEXSC   = false]
[#assign useSCMTMEV   = false]
[#assign useSCMPRCE   = false]
[#assign useSCMBIGT   = false]
[#assign useSCMMNCB   = false]
[#assign useSCMISSD   = false]
[#assign useSCMCISP   = false]
[#assign useSCMCONP   = false]
[#assign useSCMUPDT   = false]
[#assign useSCMSCHW   = false]
[#assign useSCMHNDL   = false]
[#assign useSCMMLTM   = false]
[#assign useSCMTXEV   = false]
[#assign useSCMINPK   = false]
[#assign useSCMRDCS   = false]
[#assign useSCMRADE   = false]
[#assign useSCMEDTM   = false]
[#assign useSCMOSTM   = false]
[#assign useSCMPYRC   = false]
[#assign useSCMPYCI   = false]
[#assign useSCMMAPH   = false]
[#assign useSCMENDR   = false]
[#assign useSCMPRRC   = false]
[#assign useSCMTIUP   = false]
[#assign useSCMMARE   = false]
[#assign useSCMMATX   = false]
[#assign useSCMAPCS   = false]
[#assign useSCMRATM   = false]
[#assign useSCMPRTX   = false]
[#assign useSCMRATD   = false]
[#assign useSCMRAIB   = false]
[#assign useSCMRARB   = false]
[#assign useSCMRACR   = false]
[#assign useSCMRAPC   = false]
[#assign useSCMRAET   = false]
[#assign useSCMLLG2   = false]
[#assign SYS_PORT  = ""]
[#assign SYS_PIN   = ""]
[#assign SET_PORT  = ""]
[#assign SET_PIN   = ""]
[#assign HSE_PORT  = ""]
[#assign HSE_PIN   = ""]
[#assign ACT_PORT  = ""]
[#assign ACT_PIN   = ""]
[#assign DEA_PORT  = ""]
[#assign DEA_PIN   = ""]
[#assign TEM_PORT  = ""]
[#assign TEM_PIN   = ""]
[#assign RNGE_PORT = ""]
[#assign RNGE_PIN  = ""]
[#assign RNGD_PORT = ""]
[#assign RNGD_PIN  = ""]
[#assign RNGG_PORT = ""]
[#assign RNGG_PIN  = ""]
[#assign MODEN_PORT = ""]
[#assign MODEN_PIN  = ""]
[#assign MODEX_PORT = ""]
[#assign MODEX_PIN  = ""]
[#assign MODAC_PORT = ""]
[#assign MODAC_PIN  = ""]
[#assign SSEN_PORT = ""]
[#assign SSEN_PIN  = ""]
[#assign SSEX_PORT = ""]
[#assign SSEX_PIN  = ""]
[#assign SSAC_PORT = ""]
[#assign SSAC_PIN  = ""]
[#assign STEN_PORT = ""]
[#assign STEN_PIN  = ""]
[#assign STEX_PORT = ""]
[#assign STEX_PIN  = ""]
[#assign STAC_PORT = ""]
[#assign STAC_PIN  = ""]
[#assign HCRE_PORT = ""]
[#assign HCRE_PIN  = ""]
[#assign HCRC_PORT = ""]
[#assign HCRC_PIN  = ""]
[#assign HCWR_PORT = ""]
[#assign HCWR_PIN  = ""]
[#assign SCEVU_PORT = ""]
[#assign SCEVU_PIN  = ""]
[#assign SCTI_PORT = ""]
[#assign SCTI_PIN  = ""]
[#assign SCPY_PORT = ""]
[#assign SCPY_PIN  = ""]
[#assign SCEVS_PORT = ""]
[#assign SCEVS_PIN  = ""]
[#assign SCHN_PORT = ""]
[#assign SCHN_PIN  = ""]
[#assign ACNT_PORT  = ""]
[#assign ACNT_PIN   = ""]
[#assign ACNR_PORT  = ""]
[#assign ACNR_PIN   = ""]
[#assign SCER_PORT  = ""]
[#assign SCER_PIN   = ""]
[#assign SCAC_PORT  = ""]
[#assign SCAC_PIN   = ""]
[#assign SCHM_PORT  = ""]
[#assign SCHM_PIN   = ""]
[#assign SCUE_PORT  = ""]
[#assign SCUE_PIN   = ""]
[#assign SCET_PORT  = ""]
[#assign SCET_PIN   = ""]
[#assign SCEP_PORT  = ""]
[#assign SCEP_PIN   = ""]
[#assign SCEE_PORT  = ""]
[#assign SCEE_PIN   = ""]
[#assign SCWI_PORT  = ""]
[#assign SCWI_PIN   = ""]
[#assign LLCI_PORT  = ""]
[#assign LLCI_PIN   = ""]
[#assign LLCH_PORT  = ""]
[#assign LLCH_PIN   = ""]
[#assign LLCM_PORT  = ""]
[#assign LLCM_PIN   = ""]
[#assign LLCT_PORT  = ""]
[#assign LLCT_PIN   = ""]
[#assign LLIS_PORT  = ""]
[#assign LLIS_PIN   = ""]
[#assign LLSP_PORT  = ""]
[#assign LLSP_PIN   = ""]
[#assign LLGE_PORT  = ""]
[#assign LLGE_PIN   = ""]
[#assign LLLI_PORT  = ""]
[#assign LLLI_PIN   = ""]
[#assign LLSS_PORT  = ""]
[#assign LLSS_PIN   = ""]
[#assign LLEA_PORT  = ""]
[#assign LLEA_PIN   = ""]
[#assign LHSC_PORT  = ""]
[#assign LHSC_PIN   = ""]
[#assign POEV_PORT  = ""]
[#assign POEV_PIN   = ""]
[#assign HNAL_PORT  = ""]
[#assign HNAL_PIN   = ""]
[#assign PREV_PORT  = ""]
[#assign PREV_PIN   = ""]
[#assign PRIS_PORT  = ""]
[#assign PRIS_PIN   = ""]
[#assign TXIS_PORT  = ""]
[#assign TXIS_PIN   = ""]
[#assign FREM_PORT  = ""]
[#assign FREM_PIN   = ""]
[#assign REUN_PORT  = ""]
[#assign REUN_PIN   = ""]
[#assign REDA_PORT  = ""]
[#assign REDA_PIN   = ""]
[#assign RENO_PORT  = ""]
[#assign RENO_PIN   = ""]
[#assign RETR_PORT  = ""]
[#assign RETR_PIN   = ""]
[#assign ISHN_PORT  = ""]
[#assign ISHN_PIN   = ""]
[#assign LLIN_PORT  = ""]
[#assign LLIN_PIN   = ""]
[#assign DATO_PORT  = ""]
[#assign DATO_PIN   = ""]
[#assign LLPK_PORT  = ""]
[#assign LLPK_PIN   = ""]
[#assign INCL_PORT  = ""]
[#assign INCL_PIN   = ""]
[#assign PYCL_PORT  = ""]
[#assign PYCL_PIN   = ""]
[#assign PYST_PORT  = ""]
[#assign PYST_PIN   = ""]
[#assign CLEX_PORT  = ""]
[#assign CLEX_PIN   = ""]
[#assign ROST_PORT  = ""]
[#assign ROST_PIN   = ""]
[#assign RCST_PORT  = ""]
[#assign RCST_PIN   = ""]
[#assign STRU_PORT  = ""]
[#assign STRU_PIN   = ""]
[#assign STRC_PORT  = ""]
[#assign STRC_PIN   = ""]
[#assign RCIS_PORT  = ""]
[#assign RCIS_PIN   = ""]
[#assign RCCO_PORT  = ""]
[#assign RCCO_PIN   = ""]
[#assign RAST_PORT  = ""]
[#assign RAST_PIN   = ""]
[#assign RAIS_PORT  = ""]
[#assign RAIS_PIN   = ""]
[#assign RATR_PORT  = ""]
[#assign RATR_PIN   = ""]
[#assign RAOP_PORT  = ""]
[#assign RAOP_PIN   = ""]
[#assign RARX_PORT  = ""]
[#assign RARX_PIN   = ""]
[#assign DOCL_PORT  = ""]
[#assign DOCL_PIN   = ""]
[#assign RADO_PORT  = ""]
[#assign RADO_PIN   = ""]
[#assign RACL_PORT  = ""]
[#assign RACL_PIN   = ""]
[#assign RAED_PORT  = ""]
[#assign RAED_PIN   = ""]
[#assign ERCA_PORT  = ""]
[#assign ERCA_PIN   = ""]
[#assign ERCO_PORT  = ""]
[#assign ERCO_PIN   = ""]
[#assign PTIN_PORT  = ""]
[#assign PTIN_PIN   = ""]
[#assign PTEN_PORT  = ""]
[#assign PTEN_PIN   = ""]
[#assign PTSE_PORT  = ""]
[#assign PTSE_PIN   = ""]
[#assign PTPA_PORT  = ""]
[#assign PTPA_PIN   = ""]
[#assign COST_PORT  = ""]
[#assign COST_PIN   = ""]
[#assign COAS_PORT  = ""]
[#assign COAS_PIN   = ""]
[#assign COTI_PORT  = ""]
[#assign COTI_PIN   = ""]
[#assign COON_PORT  = ""]
[#assign COON_PIN   = ""]
[#assign COFO_PORT  = ""]
[#assign COFO_PIN   = ""]
[#assign LLAD_PORT  = ""]
[#assign LLAD_PIN   = ""]
[#assign LLSC_PORT  = ""]
[#assign LLSC_PIN   = ""]
[#assign LLID_PORT  = ""]
[#assign LLID_PIN   = ""]
[#assign LLCO_PORT  = ""]
[#assign LLCO_PIN   = ""]
[#assign LLGD_PORT  = ""]
[#assign LLGD_PIN   = ""]
[#assign LLBI_PORT  = ""]
[#assign LLBI_PIN   = ""]
[#assign LLTM_PORT  = ""]
[#assign LLTM_PIN   = ""]
[#assign LLEX_PORT  = ""]
[#assign LLEX_PIN   = ""]
[#assign LLDU_PORT  = ""]
[#assign LLDU_PIN   = ""]
[#assign ADPE_PORT  = ""]
[#assign ADPE_PIN   = ""]
[#assign ADEX_PORT  = ""]
[#assign ADEX_PIN   = ""]
[#assign BITI_PORT  = ""]
[#assign BITI_PIN   = ""]
[#assign BITM_PORT  = ""]
[#assign BITM_PIN   = ""]
[#assign BITS_PORT  = ""]
[#assign BITS_PIN   = ""]
[#assign BIMO_PORT  = ""]
[#assign BIMO_PIN   = ""]
[#assign ISCB_PORT  = ""]
[#assign ISCB_PIN   = ""]
[#assign ISMO_PORT  = ""]
[#assign ISMO_PIN   = ""]
[#assign COTM_PORT  = ""]
[#assign COTM_PIN   = ""]
[#assign SCCB_PORT  = ""]
[#assign SCCB_PIN   = ""]
[#assign HCPO_PORT  = ""]
[#assign HCPO_PIN   = ""]
[#assign LLRR_PORT  = ""]
[#assign LLRR_PIN   = ""]
[#assign ENDE_PORT  = ""]
[#assign ENDE_PIN   = ""]
[#assign PRPO_PORT  = ""]
[#assign PRPO_PIN   = ""]
[#assign ANTM_PORT  = ""]
[#assign ANTM_PIN   = ""]
[#assign FRAI_PORT  = ""]
[#assign FRAI_PIN   = ""]
[#assign MLEN_PORT  = ""]
[#assign MLEN_PIN   = ""]
[#assign GNTM_PORT  = ""]
[#assign GNTM_PIN   = ""]
[#assign MILS_PORT  = ""]
[#assign MILS_PIN   = ""]
[#assign PWPR_PORT  = ""]
[#assign PWPR_PIN   = ""]
[#assign PRTM_PORT  = ""]
[#assign PRTM_PIN   = ""]
[#assign RAPY_PORT  = ""]
[#assign RAPY_PIN   = ""]
[#assign RACS_PORT  = ""]
[#assign RACS_PIN   = ""]
[#assign CSCB_PORT  = ""]
[#assign CSCB_PIN   = ""]
[#assign EDCB_PORT  = ""]
[#assign EDCB_PIN   = ""]
[#assign DIEX_PORT  = ""]
[#assign DIEX_PIN   = ""]
[#assign RCCL_PORT  = ""]
[#assign RCCL_PIN   = ""]
[#assign ADMN_PORT  = ""]
[#assign ADMN_PIN   = ""]
[#assign ADCB_PORT  = ""]
[#assign ADCB_PIN   = ""]
[#assign MNER_PORT  = ""]
[#assign MNER_PIN   = ""]
[#assign MNCN_PORT  = ""]
[#assign MNCN_PIN   = ""]
[#assign PRER_PORT  = ""]
[#assign PRER_PIN   = ""]
[#assign BICB_PORT  = ""]
[#assign BICB_PIN   = ""]
[#assign BICK_PORT  = ""]
[#assign BICK_PIN   = ""]
[#assign SYCB_PORT  = ""]
[#assign SYCB_PIN   = ""]
[#assign ERRC_PORT  = ""]
[#assign ERRC_PIN   = ""]
[#assign CITR_PORT  = ""]
[#assign CITR_PIN   = ""]
[#assign ISBK_PORT  = ""]
[#assign ISBK_PIN   = ""]
[#assign CONN_PORT  = ""]
[#assign CONN_PIN   = ""]
[#assign CLBR_PORT  = ""]
[#assign CLBR_PIN   = ""]
[#assign PRDC_PORT  = ""]
[#assign PRDC_PIN   = ""]
[#assign NCON_PORT  = ""]
[#assign NCON_PIN   = ""]
[#assign ADVC_PORT  = ""]
[#assign ADVC_PIN   = ""]
[#assign INIT_PORT  = ""]
[#assign INIT_PIN   = ""]
[#assign CMEV_PORT  = ""]
[#assign CMEV_PIN   = ""]
[#assign EVCB_PORT  = ""]
[#assign EVCB_PIN   = ""]
[#assign TMOU_PORT  = ""]
[#assign TMOU_PIN   = ""]
[#assign DURE_PORT  = ""]
[#assign DURE_PIN   = ""]
[#assign EXSC_PORT  = ""]
[#assign EXSC_PIN   = ""]
[#assign TMEV_PORT  = ""]
[#assign TMEV_PIN   = ""]
[#assign PRCE_PORT  = ""]
[#assign PRCE_PIN   = ""]
[#assign BIGT_PORT  = ""]
[#assign BIGT_PIN   = ""]
[#assign MNCB_PORT  = ""]
[#assign MNCB_PIN   = ""]
[#assign ISSD_PORT  = ""]
[#assign ISSD_PIN   = ""]
[#assign CISP_PORT  = ""]
[#assign CISP_PIN   = ""]
[#assign CONP_PORT  = ""]
[#assign CONP_PIN   = ""]
[#assign UPDT_PORT  = ""]
[#assign UPDT_PIN   = ""]
[#assign SCHW_PORT  = ""]
[#assign SCHW_PIN   = ""]
[#assign HNDL_PORT  = ""]
[#assign HNDL_PIN   = ""]
[#assign MLTM_PORT  = ""]
[#assign MLTM_PIN   = ""]
[#assign TXEV_PORT  = ""]
[#assign TXEV_PIN   = ""]
[#assign INPK_PORT  = ""]
[#assign INPK_PIN   = ""]
[#assign RDCS_PORT  = ""]
[#assign RDCS_PIN   = ""]
[#assign RADE_PORT  = ""]
[#assign RADE_PIN   = ""]
[#assign EDTM_PORT  = ""]
[#assign EDTM_PIN   = ""]
[#assign OSTM_PORT  = ""]
[#assign OSTM_PIN   = ""]
[#assign PYCT_PORT  = ""]
[#assign PYCT_PIN   = ""]
[#assign PYCI_PORT  = ""]
[#assign PYCI_PIN   = ""]
[#assign MAPH_PORT  = ""]
[#assign MAPH_PIN   = ""]
[#assign ENDR_PORT  = ""]
[#assign ENDR_PIN   = ""]
[#assign PRRC_PORT  = ""]
[#assign PRRC_PIN   = ""]
[#assign TIUP_PORT  = ""]
[#assign TIUP_PIN   = ""]
[#assign MARE_PORT  = ""]
[#assign MARE_PIN   = ""]
[#assign MATX_PORT  = ""]
[#assign MATX_PIN   = ""]
[#assign APCS_PORT  = ""]
[#assign APCS_PIN   = ""]
[#assign RATM_PORT  = ""]
[#assign RATM_PIN   = ""]
[#assign PRTX_PORT  = ""]
[#assign PRTX_PIN   = ""]
[#assign RATD_PORT  = ""]
[#assign RATD_PIN   = ""]
[#assign RAIB_PORT  = ""]
[#assign RAIB_PIN   = ""]
[#assign RARB_PORT  = ""]
[#assign RARB_PIN   = ""]
[#assign RACR_PORT  = ""]
[#assign RACR_PIN   = ""]
[#assign RAPC_PORT  = ""]
[#assign RAPC_PIN   = ""]
[#assign RAET_PORT  = ""]
[#assign RAET_PIN   = ""]
[#assign LLG2_PORT  = ""]
[#assign LLG2_PIN   = ""]
[#assign bspName    = ""]

/* USER CODE END Header */
#ifndef DEBUG_CONFIG_H
#define DEBUG_CONFIG_H

#ifdef __cplusplus
extern "C" {
#endif

#include "app_conf.h"

#if(CFG_RT_DEBUG_GPIO_MODULE == 1)

/***********************************/
/** Debug configuration selection **/
/***********************************/
/* Debug configuration for System purpose */
#define USE_RT_DEBUG_CONFIGURATION_SYSTEM                     (0)

/* Debug configuration for BLE purpose */
#define USE_RT_DEBUG_CONFIGURATION_BLE                        (0)

/* Debug configuration for MAC purpose */
#define USE_RT_DEBUG_CONFIGURATION_MAC                        (0)

/* Debug configuration for COEX purpose */
#define USE_RT_DEBUG_CONFIGURATION_COEX                       (0)

/*********************************/
/** GPIO debug signal selection **/
/*********************************/
[#if BspIpDatas??]
[#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
        [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
        [/#if]
        [#if variables.value?contains("DEBUG_SCM_SYSTEM_CLOCK_CONFIG")]
                    [#assign SYS_PORT = IpName]
                    [#assign SYS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCM_SETUP")]
                    [#assign SET_PORT = IpName]
                    [#assign SET_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCM_HSERDY_ISR")]
                    [#assign HSE_PORT = IpName]
                    [#assign HSE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADC_ACTIVATION")]
                    [#assign ACT_PORT = IpName]
            [#assign ACT_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADC_DEACTIVATION")]
                    [#assign DEA_PORT = IpName]
            [#assign DEA_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADC_TEMPERATURE_ACQUISITION")]
                    [#assign TEM_PORT = IpName]
                    [#assign TEM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RNG_ENABLE")]
                    [#assign RNGE_PORT = IpName]
                    [#assign RNGE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RNG_DISABLE")]
                    [#assign RNGD_PORT = IpName]
                    [#assign RNGD_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RNG_GEN_RAND_NUM")]
                    [#assign RNGG_PORT = IpName]
                    [#assign RNGG_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STOP_MODE_ENTER")]
                    [#assign MODEN_PORT = IpName]
                    [#assign MODEN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STOP_MODE_EXIT")]
                    [#assign MODEX_PORT = IpName]
                    [#assign MODEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STOP_MODE_ACTIVE")]
                    [#assign MODAC_PORT = IpName]
                    [#assign MODAC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STOP2_MODE_ENTER")]
                    [#assign SSEN_PORT = IpName]
                    [#assign SSEN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STOP2_MODE_EXIT")]
                    [#assign SSEX_PORT = IpName]
                    [#assign SSEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STOP2_MODE_ACTIVE")]
                    [#assign SSAC_PORT = IpName]
                    [#assign SSAC_PIN  = IpInstance]
            [/#if]			
            [#if variables.value?contains("DEBUG_LOW_POWER_STANDBY_MODE_ENTER")]
                    [#assign STEN_PORT = IpName]
                    [#assign STEN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STANDBY_MODE_EXIT")]
                    [#assign STEX_PORT = IpName]
                    [#assign STEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE")]
                    [#assign STAC_PORT = IpName]
                    [#assign STAC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_HCI_READ_DONE")]
                    [#assign HCRE_PORT = IpName]
                    [#assign HCRE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_HCI_RCVD_CMD")]
                    [#assign HCRC_PORT = IpName]
                    [#assign HCRC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_HCI_WRITE_DONE")]
                    [#assign HCWR_PORT = IpName]
                    [#assign HCWR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_EVNT_UPDATE")]
                    [#assign SCEVU_PORT = IpName]
                    [#assign SCEVU_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_TIMER_SET")]
                    [#assign SCTI_PORT = IpName]
                    [#assign SCTI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_PHY_CLBR_TIMER")]
                    [#assign SCPY_PORT = IpName]
                    [#assign SCPY_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_EVNT_SKIPPED")]
                    [#assign SCEVS_PORT = IpName]
                    [#assign SCEVS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_HNDL_NXT_TRACE")]
                    [#assign SCHN_PORT = IpName]
                    [#assign SCHN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED")]
                    [#assign ACND_PORT = IpName]
                    [#assign ACND_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK")]
                    [#assign ACNC_PORT = IpName]
                    [#assign ACNC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK")]
                    [#assign ACNT_PORT = IpName]
                    [#assign ACNT_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ACTIVE_SCHDLR_NEAR_TRACE")]
                    [#assign ACNR_PORT = IpName]
                    [#assign ACNR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_EVNT_RGSTR")]
                    [#assign SCER_PORT = IpName]
                    [#assign SCER_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_ADD_CONFLICT_Q")]
                    [#assign SCAC_PORT = IpName]
                    [#assign SCAC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_HNDL_MISSED_EVNT")]
                    [#assign SCHM_PORT = IpName]
                    [#assign SCHM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_UNRGSTR_EVNT")]
                    [#assign SCUE_PORT = IpName]
                    [#assign SCUE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_EXEC_EVNT_TRACE")]
                    [#assign SCET_PORT = IpName]
                    [#assign SCET_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_SCHDLR_EXEC_EVNT_PROFILE")]
                    [#assign SCEP_PORT = IpName]
                    [#assign SCEP_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_EXEC_EVNT_ERROR")]
                    [#assign SCEE_PORT = IpName]
                    [#assign SCEE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING")]
                    [#assign SCWI_PORT = IpName]
                    [#assign SCWI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_CMN_CLR_ISR")]
                    [#assign LLCI_PORT = IpName]
                    [#assign LLCI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLWCC_CMN_HG_ISR")]
                    [#assign LLCH_PORT = IpName]
                    [#assign LLCH_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_CMN_LW_ISR")]
                    [#assign LLCM_PORT = IpName]
                    [#assign LLCM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_CMN_CLR_TIMER_ERROR")]
                    [#assign LLCT_PORT = IpName]
                    [#assign LLCT_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_LL_ISR")]
                    [#assign LLIS_PORT = IpName]
                    [#assign LLIS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_SPLTMR_SET")]
                    [#assign LLSP_PORT = IpName]
                    [#assign LLSP_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_SPLTMR_GET")]
                    [#assign LLGE_PORT = IpName]
                    [#assign LLGE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_LOW_ISR")]
                    [#assign LLLI_PORT = IpName]
                    [#assign LLLI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_STOP_SCN")]
                    [#assign LLSS_PORT = IpName]
                    [#assign LLSS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_WAIT_ENVT_ON_AIR")]
                    [#assign LLEA_PORT = IpName]
                    [#assign LLEA_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_SET_CONN_EVNT_PARAM")]
                    [#assign LHSC_PORT = IpName]
                    [#assign LHSC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_POST_EVNT")]
                    [#assign POEV_PORT = IpName]
                    [#assign POEV_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_HNDL_ALL_EVNTS")]
                    [#assign HNAL_PORT = IpName]
                    [#assign HNAL_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PROCESS_EVNT")]
                    [#assign PREV_PORT = IpName]
                    [#assign PREV_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PROCESS_ISO_DATA")]
                    [#assign PRIS_PORT = IpName]
                    [#assign PRIS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ALLOC_TX_ISO_EMPTY_PKT")]
                    [#assign TXIS_PORT = IpName]
                    [#assign TXIS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIG_FREE_EMPTY_PKTS")]
                    [#assign FREM_PORT = IpName]
                    [#assign FREM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RECOMBINE_UNFRMD_DATA_OK")]
                    [#assign REUN_PORT = IpName]
                    [#assign REUN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RECOMBINE_UNFRMD_DATA_CRC")]
                    [#assign REDA_PORT = IpName]
                    [#assign REDA_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RECOMBINE_UNFRMD_DATA_NoRX")]
                    [#assign RENO_PORT = IpName]
                    [#assign RENO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RECOMBINE_UNFRMD_DATA_TRACE")]
                    [#assign RETR_PORT = IpName]
                    [#assign RETR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISO_HNDL_SDU")]
                    [#assign ISHN_PORT = IpName]
                    [#assign ISHN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LL_INTF_INIT")]
                    [#assign LLIN_PORT = IpName]
                    [#assign LLIN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_DATA_TO_CNTRLR")]
                    [#assign DATO_PORT = IpName]
                    [#assign DATO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_FREE_LL_PKT_HNDLR")]
                    [#assign LLPK_PORT = IpName]
                    [#assign LLPK_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PHY_INIT_CLBR_TRACE")]
                    [#assign INCL_PORT = IpName]
                    [#assign INCL_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_PHY_RUNTIME_CLBR_TRACE")]
                    [#assign PYCT_PORT = IpName]
                    [#assign PYCT_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_PHY_CLBR_ISR")]
                    [#assign PYCI_PORT = IpName]
                    [#assign PYCI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PHY_INIT_CLBR_SINGLE_CH")]
                    [#assign PYCL_PORT = IpName]
                    [#assign PYCL_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PHY_CLBR_STRTD")]
                    [#assign PYST_PORT = IpName]
                    [#assign PYST_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PHY_CLBR_EXEC")]
                    [#assign CLEX_PORT = IpName]
                    [#assign CLEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV")]
                    [#assign ROST_PORT = IpName]
                    [#assign ROST_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR")]
                    [#assign RCST_PORT = IpName]
                    [#assign RCST_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT")]
                    [#assign STRU_PORT = IpName]
                    [#assign STRU_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE")]
                    [#assign STRC_PORT = IpName]
                    [#assign STRC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RCO_ISR_TRACE")]
                    [#assign RCIS_PORT = IpName]
                    [#assign RCIS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RCO_ISR_COMPENDATE")]
                    [#assign RCCO_PORT = IpName]
                    [#assign RCCO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_STRT_TX")]
                    [#assign RAST_PORT = IpName]
                    [#assign RAST_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_ISR_TIMER_ERROR")]
                    [#assign RAIS_PORT = IpName]
                    [#assign RAIS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_ISR_TRACE")]
                    [#assign RATR_PORT = IpName]
                    [#assign RATR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_STOP_OPRTN")]
                    [#assign RAOP_PORT = IpName]
                    [#assign RAOP_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_STRT_RX")]
                    [#assign RARX_PORT = IpName]
                    [#assign RARX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_DONE_CLBK_TX")]
                    [#assign DOCL_PORT = IpName]
                    [#assign DOCL_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_DONE_CLBK_RX")]
                    [#assign RADO_PORT = IpName]
                    [#assign RADO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_DONE_CLBK_ED")]
                    [#assign RACL_PORT = IpName]
                    [#assign RACL_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_ED_SCAN")]
                    [#assign RAED_PORT = IpName]
                    [#assign RAED_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ERROR_MEM_CAP_EXCED")]
                    [#assign ERCA_PORT = IpName]
                    [#assign ERCA_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ERROR_COMMAND_DISALLOWED")]
                    [#assign ERCO_PORT = IpName]
                    [#assign ERCO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PTA_INIT")]
                    [#assign PTIN_PORT = IpName]
                    [#assign PTIN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PTA_EN")]
                    [#assign PTEN_PORT = IpName]
                    [#assign PTEN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_PTA_SET_EN")]
                    [#assign PTSE_PORT = IpName]
                    [#assign PTSE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_PTA_SET_PARAMS")]
                    [#assign PTPA_PORT = IpName]
                    [#assign PTPA_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_COEX_STRT_ON_IDLE")]
                    [#assign COST_PORT = IpName]
                    [#assign COST_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_COEX_ASK_FOR_AIR")]
                    [#assign COAS_PORT = IpName]
                    [#assign COAS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_COEX_TIMER_EVNT_CLBK")]
                    [#assign COTI_PORT = IpName]
                    [#assign COTI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_COEX_STRT_ONE_SHOT")]
                    [#assign COON_PORT = IpName]
                    [#assign COON_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_COEX_FORCE_STOP_RX")]
                    [#assign COFO_PORT = IpName]
                    [#assign COFO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_ADV_DONE")]
                    [#assign LLAD_PORT = IpName]
                    [#assign LLAD_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_SCN_DONE")]
                    [#assign LLSC_PORT = IpName]
                    [#assign LLSC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_INIT_DONE")]
                    [#assign LLID_PORT = IpName]
                    [#assign LLID_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_CONN_DONE")]
                    [#assign LLCO_PORT = IpName]
                    [#assign LLCO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_CIG_DONE")]
                    [#assign LLGD_PORT = IpName]
                    [#assign LLGD_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_BIG_DONE")]
                    [#assign LLBI_PORT = IpName]
                    [#assign LLBI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_OS_TMR_CREATE")]
                    [#assign LLTM_PORT = IpName]
                    [#assign LLTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_TIMEOUT_CBK")]
                    [#assign LLEX_PORT = IpName]
                    [#assign LLEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_SCN_DUR_CBK")]
                    [#assign LLDU_PORT = IpName]
                    [#assign LLDU_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_SCN_PERIOD_CBK")]
                    [#assign ADPE_PORT = IpName]
                    [#assign ADPE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK")]
                    [#assign ADEX_PORT = IpName]
                    [#assign ADEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK")]
                    [#assign BITI_PORT = IpName]
                    [#assign BITI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIS_TERM_TMR_CBK")]
                    [#assign BITM_PORT = IpName]
                    [#assign BITM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIS_TST_MODE_CBK")]
                    [#assign BITS_PORT = IpName]
                    [#assign BITS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIS_TST_MODE_TMR_CBK")]
                    [#assign BIMO_PORT = IpName]
                    [#assign BIMO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISO_POST_TMR_CBK")]
                    [#assign ISCB_PORT = IpName]
                    [#assign ISCB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISO_TST_MODE_TMR_CBK")]
                    [#assign ISMO_PORT = IpName]
                    [#assign ISMO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_CONN_POST_TMR_CBK")]
                    [#assign COTM_PORT = IpName]
                    [#assign COTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_EVNT_SCHDLR_TMR_CBK")]
                    [#assign SCCB_PORT = IpName]
                    [#assign SCCB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_HCI_POST_TMR_CBK")]
                    [#assign HCPO_PORT = IpName]
                    [#assign HCPO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLCP_POST_TMR_CBK")]
                    [#assign LLRR_PORT = IpName]
                    [#assign LLRR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_ENRGY_DETECT_CBK")]
                    [#assign ENDE_PORT = IpName]
                    [#assign ENDE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PRVCY_POST_TMR_CBK")]
                    [#assign PRPO_PORT = IpName]
                    [#assign PRPO_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ANT_PRPR_TMR_CBK")]
                    [#assign ANTM_PORT = IpName]
                    [#assign ANTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK")]
                    [#assign FRAI_PORT = IpName]
                    [#assign FRAI_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_MLME_RX_EN_TMR_CBK")]
                    [#assign MLEN_PORT = IpName]
                    [#assign MLEN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_MLME_GNRC_TMR_CBK")]
                    [#assign GNTM_PORT = IpName]
                    [#assign GNTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_MIB_JOIN_LST_TMR_CBK")]
                    [#assign MILS_PORT = IpName]
                    [#assign MILS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_MLME_PWR_PRES_TMR_CBK")]
                    [#assign PWPR_PORT = IpName]
                    [#assign PWPR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PRESISTENCE_TMR_CBK")]
                    [#assign PRTM_PORT = IpName]
                    [#assign PRTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK")]
                    [#assign RAPY_PORT = IpName]
                    [#assign RAPY_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RADIO_CSMA_TMR_CBK")]
                    [#assign RACS_PORT = IpName]
                    [#assign RACS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RADIO_CSL_RCV_TMR_CBK")]
                    [#assign CSCB_PORT = IpName]
                    [#assign CSCB_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_ED_TMR_CBK")]
                    [#assign EDCB_PORT = IpName]
				    [#assign EDCB_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_DIO_EXT_TMR_CBK")]
                    [#assign DIEX_PORT = IpName]
				    [#assign DIEX_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_RCO_CLBR_TMR_CBK")]
                    [#assign RCCL_PORT = IpName]
				    [#assign RCCL_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_ADV_EXT_MNGR_ADV_CBK")]
                    [#assign ADMN_PORT = IpName]
				    [#assign ADMN_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_ADV_EXT_MNGR_SCN_CBK")]
                    [#assign ADCB_PORT = IpName]
				    [#assign ADCB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK")]
                    [#assign MNER_PORT = IpName]
                    [#assign MNER_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK")]
                    [#assign MNCN_PORT = IpName]
                    [#assign MNCN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK")]
                    [#assign PRER_PORT = IpName]
                    [#assign PRER_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIG_ADV_CBK")]
                    [#assign BICB_PORT = IpName]
                    [#assign BICB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIG_ADV_ERR_CBK")]
                    [#assign BICK_PORT = IpName]
                    [#assign BICK_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIG_SYNC_CBK")]
                    [#assign SYCB_PORT = IpName]
                    [#assign SYCB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_DIO_EXT_TMR_CBK")]
                    [#assign DIEX_PORT = IpName]
                    [#assign DIEX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIG_SYNC_ERR_CBK")]
                    [#assign ERRC_PORT = IpName]
                    [#assign ERRC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK")]
                    [#assign CITR_PORT = IpName]
                    [#assign CITR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISO_CIG_ERR_CBK")]
                    [#assign ISBK_PORT = IpName]
                    [#assign ISBK_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK")]
                    [#assign CONN_PORT = IpName]
                    [#assign CONN_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PRDC_CLBR_EXTRL_CBK")]
                    [#assign CLBR_PORT = IpName]
                    [#assign CLBR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PTR_PRDC_ADV_SYNC_CBK")]
                    [#assign PRDC_PORT = IpName]
                    [#assign PRDC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_NCONN_SCN_CBK")]
                    [#assign NCON_PORT = IpName]
                    [#assign NCON_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_NCONN_ADV_CBK")]
                    [#assign ADVC_PORT = IpName]
                    [#assign ADVC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_NCONN_INIT_CBK")]
                    [#assign INIT_PORT = IpName]
                    [#assign INIT_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ANT_RADIO_CMPLT_EVNT_CBK")]
                    [#assign CMEV_PORT = IpName]
                    [#assign CMEV_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK")]
                    [#assign TMOU_PORT = IpName]
                    [#assign TMOU_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT")]
                    [#assign DURE_PORT = IpName]
                    [#assign DURE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT")]
                    [#assign EXSC_PORT = IpName]
                    [#assign EXSC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT")]
                    [#assign TMEV_PORT = IpName]
                    [#assign TMEV_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT")]
                    [#assign PRCE_PORT = IpName]
                    [#assign PRCE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIS_MNGR_BIG_TERM_CBK")]
                    [#assign BIGT_PORT = IpName]
                    [#assign BIGT_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_BIS_MNGR_SYNC_TMOUT_CBK")]
                    [#assign MNCB_PORT = IpName]
                    [#assign MNCB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISOAL_MNGR_SDU_GEN")]
                    [#assign ISSD_PORT = IpName]
                    [#assign ISSD_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK")]
                    [#assign CISP_PORT = IpName]
                    [#assign CISP_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK")]
                    [#assign CONP_PORT = IpName]
                    [#assign CONP_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK")]
                    [#assign UPDT_PORT = IpName]
                    [#assign UPDT_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT")]
                    [#assign SCHW_PORT = IpName]
                    [#assign SCHW_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_HCI_EVENT_HNDLR")]
                    [#assign HNDL_PORT = IpName]
                    [#assign HNDL_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_MLME_TMRS_CBK")]
                    [#assign MLTM_PORT = IpName]
                    [#assign MLTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_DIRECT_TX_EVNT_CBK")]
                    [#assign TXEV_PORT = IpName]
                    [#assign TXEV_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_INDIRECT_PKT_TOUR_CBK")]
                    [#assign INPK_PORT = IpName]
                    [#assign INPK_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RADIO_CSMA_TMR")]
                    [#assign RDCS_PORT = IpName]
                    [#assign RDCS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_SM_DONE_EVNT_CBK")]
                    [#assign RADE_PORT = IpName]
                    [#assign RADE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_ED_TMR_HNDL")]
                    [#assign EDTM_PORT = IpName]
                    [#assign EDTM_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_OS_TMR_EVNT_CBK")]
                    [#assign OSTM_PORT = IpName]
                    [#assign OSTM_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME")]
                    [#assign MAPH_PORT = IpName]
                    [#assign MAPH_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PROFILE_END_DRIFT_TIME")]
                    [#assign ENDR_PORT = IpName]
                    [#assign ENDR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_PROC_RADIO_RCV")]
                    [#assign PRRC_PORT = IpName]
                    [#assign PRRC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_EVNT_TIME_UPDT")]
                    [#assign TIUP_PORT = IpName]
                    [#assign TIUP_PIN  = IpInstance]
            [/#if]
			[#if variables.value?contains("DEBUG_MAC_RECEIVE_DONE")]
                    [#assign MARE_PORT = IpName]
                    [#assign MARE_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_MAC_TX_DONE")]
                    [#assign MATX_PORT = IpName]
                    [#assign MATX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RADIO_APPLY_CSMA")]
                    [#assign APCS_PORT = IpName]
                    [#assign APCS_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RADIO_TRANSMIT")]
                    [#assign RATM_PORT = IpName]
                    [#assign RATM_PIN  = IpInstance]
            [/#if]	
			[#if variables.value?contains("DEBUG_PROC_RADIO_TX")]
                    [#assign PRTX_PORT = IpName]
                    [#assign PRTX_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_TX_DONE")]
                    [#assign RATD_PORT = IpName]
                    [#assign RATD_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT")]
                    [#assign RAIB_PORT = IpName]
                    [#assign RAIB_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT")]
                    [#assign RARB_PORT = IpName]
                    [#assign RARB_PIN  = IpInstance]
            [/#if]	
			[#if variables.value?contains("DEBUG_RAL_CONTINUE_RX")]
                    [#assign RACR_PORT = IpName]
                    [#assign RACR_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_PERFORM_CCA")]
                    [#assign RAPC_PORT = IpName]
                    [#assign RAPC_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_RAL_ENABLE_TRANSMITTER")]
                    [#assign RAET_PORT = IpName]
                    [#assign RAET_PIN  = IpInstance]
            [/#if]
            [#if variables.value?contains("DEBUG_LLHWC_GET_CH_IDX_ALGO_2")]
                    [#assign LLG2_PORT = IpName]
                    [#assign LLG2_PIN  = IpInstance]
            [/#if]		
        [/#list]
    [/#if]
    [#if SWIP.bsp??]
      [#list SWIP.bsp as bsp]
            [#if bsp.bspName?contains("DEBUG_SCM_SYSTEM_CLOCK_CONFIG")]
                 [#assign useSCMSYSTEM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCM_SETUP")]
                 [#assign useSCMSETUP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCM_HSERDY_ISR")]
                 [#assign useSCMHSERDY = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADC_ACTIVATION")]
                 [#assign useSCMACT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADC_DEACTIVATION")]
                 [#assign useSCMDEACT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADC_TEMPERATURE_ACQUISITION")]
                 [#assign useSCMTEMP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RNG_ENABLE")]
                 [#assign useSCMRNGE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RNG_DISABLE")]
                 [#assign useSCMRNGD = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RNG_GEN_RAND_NUM")]
                 [#assign useSCMRNGG = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STOP_MODE_ENTER")]
                 [#assign useSCMMODEN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STOP_MODE_EXIT")]
                 [#assign useSCMMODEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STOP_MODE_ACTIVE")]
                 [#assign useSCMMODAC = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_LOW_POWER_STOP2_MODE_ENTER")]
                 [#assign useSCMSSEN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STOP2_MODE_EXIT")]
                 [#assign useSCMSSEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STOP2_MODE_ACTIVE")]
                 [#assign useSCMSSAC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STANDBY_MODE_ENTER")]
                 [#assign useSCMSTEN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STANDBY_MODE_EXIT")]
                 [#assign useSCMSTEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE")]
                 [#assign useSCMSTAC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_HCI_READ_DONE")]
                 [#assign useSCMHCRE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_HCI_RCVD_CMD")]
                [#assign useSCMHCRC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_HCI_WRITE_DONE")]
                [#assign useSCMHCWR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_EVNT_UPDATE")]
                [#assign useSCMSCEVU = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_TIMER_SET")]
                [#assign useSCMSCTI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_PHY_CLBR_TIMER")]
                [#assign useSCMSCPY = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_EVNT_SKIPPED")]
                [#assign useSCMSCEVS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_HNDL_NXT_TRACE")]
                [#assign useSCMSCHN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED")]
                [#assign useSCMACN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK")]
                [#assign useSCMACNC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK")]
                [#assign useSCMACNT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ACTIVE_SCHDLR_NEAR_TRACE")]
                [#assign useSCMACNR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_EVNT_RGSTR")]
                [#assign useSCMSCER = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_ADD_CONFLICT_Q")]
                [#assign useSCMSCAC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_HNDL_MISSED_EVNT")]
                [#assign useSCMSCHM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_UNRGSTR_EVNT")]
                [#assign useSCMSCUE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_EXEC_EVNT_TRACE")]
                [#assign useSCMSCET = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_SCHDLR_EXEC_EVNT_PROFILE")]
                [#assign useSCMSCEP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_EXEC_EVNT_ERROR")]
                [#assign useSCMSCEE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING")]
                [#assign useSCMSCWI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_CMN_CLR_ISR")]
                [#assign useSCMLLCM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLWCC_CMN_HG_ISR")]
                [#assign useSCMLLHI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_CMN_LW_ISR")]
                [#assign useSCMLLCI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_CMN_CLR_TIMER_ERROR")]
                [#assign useSCMLLCT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_LL_ISR")]
                [#assign useSCMLLIS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_SPLTMR_SET")]
                [#assign useSCMLLSP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_SPLTMR_GET")]
                [#assign useSCMLLSG = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_LOW_ISR")]
                [#assign useSCMLLLI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_STOP_SCN")]
                [#assign useSCMLLST = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_WAIT_ENVT_ON_AIR")]
                [#assign useSCMLLEA = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_SET_CONN_EVNT_PARAM")]
                [#assign useSCMLLPA = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_POST_EVNT")]
                [#assign useSCMPOEV = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_HNDL_ALL_EVNTS")]
                [#assign useSCMHNAL = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PROCESS_EVNT")]
                [#assign useSCMPREV = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PROCESS_ISO_DATA")]
                [#assign useSCMPRIS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ALLOC_TX_ISO_EMPTY_PKT")]
                [#assign useSCMPREM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIG_FREE_EMPTY_PKTS")]
                [#assign useSCMFREM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RECOMBINE_UNFRMD_DATA_OK")]
                [#assign useSCMREUN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RECOMBINE_UNFRMD_DATA_CRC")]
                [#assign useSCMREDA = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RECOMBINE_UNFRMD_DATA_NoRX")]
                [#assign useSCMRENO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RECOMBINE_UNFRMD_DATA_TRACE")]
                [#assign useSCMRETR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISO_HNDL_SDU")]
                [#assign useSCMISHN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LL_INTF_INIT")]
                [#assign useSCMLLIN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_DATA_TO_CNTRLR")]
                [#assign useSCMDATO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_FREE_LL_PKT_HNDLR")]
                [#assign useSCMLLPK = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PHY_INIT_CLBR_TRACE")]
                [#assign useSCMPYIN = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_PHY_RUNTIME_CLBR_TRACE")]
                [#assign useSCMPYRC = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_PHY_CLBR_ISR")]
                [#assign useSCMPYCI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PHY_INIT_CLBR_SINGLE_CH")]
                [#assign useSCMPYCL = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PHY_CLBR_STRTD")]
                [#assign useSCMPYST = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PHY_CLBR_EXEC")]
                [#assign useSCMPYEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV")]
                [#assign useSCMRCAC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR")]
                [#assign useSCMRCST = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT")]
                [#assign useSCMSTRU = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE")]
                [#assign useSCMSTRC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RCO_ISR_TRACE")]
                [#assign useSCMRCIS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RCO_ISR_COMPENDATE")]
                [#assign useSCMRCCO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_STRT_TX")]
                [#assign useSCMRAST = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_ISR_TIMER_ERROR")]
                [#assign useSCMRAER = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_ISR_TRACE")]
                [#assign useSCMRATR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_STOP_OPRTN")]
                [#assign useSCMRAOP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_STRT_RX")]
                [#assign useSCMRARX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_DONE_CLBK_TX")]
                [#assign useSCMDOCL = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_DONE_CLBK_RX")]
                [#assign useSCMRADO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_DONE_CLBK_ED")]
                [#assign useSCMRACL = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_ED_SCAN")]
                [#assign useSCMRAED = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ERROR_MEM_CAP_EXCED")]
                [#assign useSCMERCA = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ERROR_COMMAND_DISALLOWED")]
                [#assign useSCMERCO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PTA_INIT")]
                [#assign useSCMPTIN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PTA_EN")]
                [#assign useSCMPTEN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_PTA_SET_EN")]
                [#assign useSCMPTSE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_PTA_SET_PARAMS")]
                [#assign useSCMPTPA = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_COEX_STRT_ON_IDLE")]
                [#assign useSCMCOST = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_COEX_ASK_FOR_AIR")]
                [#assign useSCMCOAS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_COEX_TIMER_EVNT_CLBK")]
                [#assign useSCMCOTI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_COEX_STRT_ONE_SHOT")]
                [#assign useSCMCOON = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_COEX_FORCE_STOP_RX")]
                [#assign useSCMCOFO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_ADV_DONE")]
                [#assign useSCMLLAD = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_SCN_DONE")]
                [#assign useSCMLLSC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_INIT_DONE")]
                [#assign useSCMLLID = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_CONN_DONE")]
                [#assign useSCMLLCO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_CIG_DONE ")]
                [#assign useSCMLLGD = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_BIG_DONE ")]
                [#assign useSCMLLBI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_OS_TMR_CREATE ")]
                [#assign useSCMLLTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_TIMEOUT_CBK")]
                [#assign useSCMLLEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_SCN_DUR_CBK")]
                [#assign useSCMLLDU = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_SCN_PERIOD_CBK")]
                [#assign useSCMADPE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK")]
                [#assign useSCMADEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK")]
                [#assign useSCMBITI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIS_TERM_TMR_CBK")]
                [#assign useSCMBITM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIS_TST_MODE_CBK")]
                [#assign useSCMBITS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIS_TST_MODE_TMR_CBK")]
                [#assign useSCMBIMO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISO_POST_TMR_CBK")]
                [#assign useSCMISCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISO_TST_MODE_TMR_CBK")]
                [#assign useSCMISMO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_CONN_POST_TMR_CBK")]
                [#assign useSCMCOTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_EVNT_SCHDLR_TMR_CBK")]
                [#assign useSCMSCCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_HCI_POST_TMR_CBK")]
                [#assign useSCMHCPO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLCP_POST_TMR_CBK")]
                [#assign useSCMLLRR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_ENRGY_DETECT_CBK")]
                [#assign useSCMENDE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PRVCY_POST_TMR_CBK")]
                [#assign useSCMPRPO = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ANT_PRPR_TMR_CBK")]
                [#assign useSCMANTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK")]
                [#assign useSCMFRAI = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_MLME_RX_EN_TMR_CBK")]
                [#assign useSCMMLEN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_MLME_GNRC_TMR_CBK")]
                [#assign useSCMGNTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_MIB_JOIN_LST_TMR_CBK")]
                [#assign useSCMMILS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_MLME_PWR_PRES_TMR_CBK")]
                [#assign useSCMPWPR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PRESISTENCE_TMR_CBK")]
                [#assign useSCMPRTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK")]
                [#assign useSCMRAPY = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RADIO_CSMA_TMR_CBK")]
                [#assign useSCMRACS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RADIO_CSL_RCV_TMR_CBK")]
                [#assign useSCMCSCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ED_TMR_CBK")]
                [#assign useSCMEDCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_DIO_EXT_TMR_CBK")]
                [#assign useSCMDIEX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RCO_CLBR_TMR_CBK")]
                [#assign useSCMRCCL = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_ADV_CBK")]
                [#assign useSCMADMN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_SCN_CBK")]
                [#assign useSCMADCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK")]
                [#assign useSCMMNER = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK")]
                [#assign useSCMMNCN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK")]
                [#assign useSCMPRER = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIG_ADV_CBK")]
                [#assign useSCMBICB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIG_ADV_ERR_CBK")]
                [#assign useSCMBICK = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIG_SYNC_CBK")]
                [#assign useSCMSYCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIG_SYNC_ERR_CBK")]
                [#assign useSCMERRC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK")]
                [#assign useSCMCITR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISO_CIG_ERR_CBK")]
                [#assign useSCMISBK = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK")]
                [#assign useSCMCONN = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PRDC_CLBR_EXTRL_CBK")]
                [#assign useSCMCLBR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PTR_PRDC_ADV_SYNC_CBK")]
                [#assign useSCMPRDC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_NCONN_SCN_CBK")]
                [#assign useSCMNCON = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_NCONN_ADV_CBK")]
                [#assign useSCMADVC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_NCONN_INIT_CBK")]
                [#assign useSCMINIT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ANT_RADIO_CMPLT_EVNT_CBK")]
                [#assign useSCMCMEV = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ANT_STACK_EVNT_CBK")]
                [#assign useSCMEVCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK")]
                [#assign useSCMTMOU = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT")]
                [#assign useSCMDURE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT")]
                [#assign useSCMEXSC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT")]
                [#assign useSCMTMEV = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT")]
                [#assign useSCMPRCE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIS_MNGR_BIG_TERM_CBK")]
                [#assign useSCMBIGT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_BIS_MNGR_SYNC_TMOUT_CBK")]
                [#assign useSCMMNCB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISOAL_MNGR_SDU_GEN")]
                [#assign useSCMISSD = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK")]
                [#assign useSCMCISP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK")]
                [#assign useSCMCONP = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK")]
                [#assign useSCMUPDT = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT")]
                [#assign useSCMSCHW = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_HCI_EVENT_HNDLR")]
                [#assign useSCMHNDL = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_MLME_TMRS_CBK")]
                [#assign useSCMMLTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_DIRECT_TX_EVNT_CBK")]
                [#assign useSCMTXEV = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_INDIRECT_PKT_TOUR_CBK")]
                [#assign useSCMINPK = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RADIO_CSMA_TMR")]
                [#assign useSCMRDCS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_SM_DONE_EVNT_CBK")]
                [#assign useSCMRADE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_ED_TMR_HNDL")]
                [#assign useSCMEDTM = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_OS_TMR_EVNT_CBK")]
                [#assign useSCMOSTM = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME")]
                [#assign useSCMMAPH = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PROFILE_END_DRIFT_TIME")]
                [#assign useSCMENDR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_PROC_RADIO_RCV")]
                [#assign useSCMPRRC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_EVNT_TIME_UPDT")]
                [#assign useSCMTIUP = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_MAC_RECEIVE_DONE")]
                [#assign useSCMMARE = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_MAC_TX_DONE")]
                [#assign useSCMMATX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RADIO_APPLY_CSMA")]
                [#assign useSCMAPCS = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RADIO_TRANSMIT")]
                [#assign useSCMRATM = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_PROC_RADIO_TX")]
                [#assign useSCMPRTX = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_TX_DONE")]
                [#assign useSCMRATD = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT")]
                [#assign useSCMRAIB = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT")]
                [#assign useSCMRARB = true]
            [/#if]
			[#if bsp.bspName?contains("DEBUG_RAL_CONTINUE_RX")]
                [#assign useSCMRACR = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_PERFORM_CCA")]
                [#assign useSCMRAPC = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_RAL_ENABLE_TRANSMITTER")]
                [#assign useSCMRAET = true]
            [/#if]
            [#if bsp.bspName?contains("DEBUG_LLHWC_GET_CH_IDX_ALGO_2")]
                [#assign useSCMLLG2 = true]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[/#if]

[#if BspIpDatas??]
/* System clock manager - System clock config */
[#if useSCMSYSTEM]
#define USE_RT_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                  (1)
#define GPIO_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                    {${SYS_PORT}, ${SYS_PIN}}
[#else]
#define USE_RT_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                  (0)
#define GPIO_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                    {GPIOA, GPIO_PIN_0}
[/#if]

/* System clock manager - Setup */
[#if useSCMSETUP]
#define USE_RT_DEBUG_SCM_SETUP                                (1)
#define GPIO_DEBUG_SCM_SETUP                                  {${SET_PORT}, ${SET_PIN}}
[#else]
#define USE_RT_DEBUG_SCM_SETUP                                (0)
#define GPIO_DEBUG_SCM_SETUP                                  {GPIOA, GPIO_PIN_0}
[/#if]

/* System clock manager - HSE RDY interrupt handling */
[#if useSCMHSERDY]
#define USE_RT_DEBUG_SCM_HSERDY_ISR                           (1)
#define GPIO_DEBUG_SCM_HSERDY_ISR                             {${HSE_PORT}, ${HSE_PIN}}
[#else]
#define USE_RT_DEBUG_SCM_HSERDY_ISR                           (0)
#define GPIO_DEBUG_SCM_HSERDY_ISR                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMACT]
#define USE_RT_DEBUG_ADC_ACTIVATION                           (1)
#define GPIO_DEBUG_ADC_ACTIVATION                             {${ACT_PORT}, ${ACT_PIN}}
[#else]
#define USE_RT_DEBUG_ADC_ACTIVATION                           (0)
#define GPIO_DEBUG_ADC_ACTIVATION                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMDEACT]
#define USE_RT_DEBUG_ADC_DEACTIVATION                         (1)
#define GPIO_DEBUG_ADC_DEACTIVATION                           {${DEA_PORT}, ${DEA_PIN}}
[#else]
#define USE_RT_DEBUG_ADC_DEACTIVATION                         (0)
#define GPIO_DEBUG_ADC_DEACTIVATION                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMTEMP]
#define USE_RT_DEBUG_ADC_TEMPERATURE_ACQUISITION              (1)
#define GPIO_DEBUG_ADC_TEMPERATURE_ACQUISITION                {${TEM_PORT}, ${TEM_PIN}}
[#else]
#define USE_RT_DEBUG_ADC_TEMPERATURE_ACQUISITION              (0)
#define GPIO_DEBUG_ADC_TEMPERATURE_ACQUISITION                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRNGE]
#define USE_RT_DEBUG_RNG_ENABLE                               (1)
#define GPIO_DEBUG_RNG_ENABLE                                 {${RNGE_PORT}, ${RNGE_PIN}}
[#else]
#define USE_RT_DEBUG_RNG_ENABLE                               (0)
#define GPIO_DEBUG_RNG_ENABLE                                 {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRNGD]
#define USE_RT_DEBUG_RNG_DISABLE                              (1)
#define GPIO_DEBUG_RNG_DISABLE                                {${RNGD_PORT}, ${RNGD_PIN}}
[#else]
#define USE_RT_DEBUG_RNG_DISABLE                              (0)
#define GPIO_DEBUG_RNG_DISABLE                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRNGG]
#define USE_RT_DEBUG_RNG_GEN_RAND_NUM                         (1)
#define GPIO_DEBUG_RNG_GEN_RAND_NUM                           {${RNGG_PORT}, ${RNGG_PIN}}
[#else]
#define USE_RT_DEBUG_RNG_GEN_RAND_NUM                         (0)
#define GPIO_DEBUG_RNG_GEN_RAND_NUM                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMODEN]
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ENTER                (1)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_ENTER                  {${MODEN_PORT}, ${MODEN_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ENTER                (0)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_ENTER                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMODEX]
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_EXIT                 (1)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_EXIT                   {${MODEX_PORT}, ${MODEX_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_EXIT                 (0)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_EXIT                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMODAC]
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ACTIVE               (1)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_ACTIVE                 {${MODAC_PORT}, ${MODAC_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ACTIVE               (0)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_ACTIVE                 {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSSEN]
#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_ENTER               (1)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_ENTER                 {${SSEN_PORT}, ${SSEN_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_ENTER               (0)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_ENTER                 {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSSEX]
#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_EXIT                (1)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_EXIT                  {${SSEX_PORT}, ${SSEX_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_EXIT                (0)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_EXIT                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSSAC]
#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_ACTIVE              (1)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_ACTIVE                {${SSAC_PORT}, ${SSAC_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_ACTIVE              (0)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_ACTIVE                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSTEN]
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ENTER             (1)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_ENTER               {${STEN_PORT}, ${STEN_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ENTER             (0)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_ENTER               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSTEX]
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_EXIT              (1)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_EXIT                {${STEX_PORT}, ${STEX_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_EXIT              (0)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_EXIT                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSTAC]
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE            (1)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE              {${STAC_PORT}, ${STAC_PIN}}
[#else]
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE            (0)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMHCRE]
#define USE_RT_DEBUG_HCI_READ_DONE                            (1)
#define GPIO_DEBUG_HCI_READ_DONE                              {${HCRE_PORT}, ${HCRE_PIN}}
[#else]
#define USE_RT_DEBUG_HCI_READ_DONE                            (0)
#define GPIO_DEBUG_HCI_READ_DONE                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMHCRC]
#define USE_RT_DEBUG_HCI_RCVD_CMD                             (1)
#define GPIO_DEBUG_HCI_RCVD_CMD                               {${HCRC_PORT}, ${HCRC_PIN}}
[#else]
#define USE_RT_DEBUG_HCI_RCVD_CMD                             (0)
#define GPIO_DEBUG_HCI_RCVD_CMD                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMHCWR]
#define USE_RT_DEBUG_HCI_WRITE_DONE                           (1)
#define GPIO_DEBUG_HCI_WRITE_DONE                             {${HCWR_PORT}, ${HCWR_PIN}}
[#else]
#define USE_RT_DEBUG_HCI_WRITE_DONE                           (0)
#define GPIO_DEBUG_HCI_WRITE_DONE                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCEVU]
#define USE_RT_DEBUG_SCHDLR_EVNT_UPDATE                       (1)
#define GPIO_DEBUG_SCHDLR_EVNT_UPDATE                         {${SCEVU_PORT}, ${SCEVU_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EVNT_UPDATE                       (0)
#define GPIO_DEBUG_SCHDLR_EVNT_UPDATE                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCTI]
#define USE_RT_DEBUG_SCHDLR_TIMER_SET                         (1)
#define GPIO_DEBUG_SCHDLR_TIMER_SET                           {${SCTI_PORT}, ${SCTI_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_TIMER_SET                         (0)
#define GPIO_DEBUG_SCHDLR_TIMER_SET                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCPY]
#define USE_RT_DEBUG_SCHDLR_PHY_CLBR_TIMER                    (1)
#define GPIO_DEBUG_SCHDLR_PHY_CLBR_TIMER                      {${SCPY_PORT}, ${SCPY_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_PHY_CLBR_TIMER                    (0)
#define GPIO_DEBUG_SCHDLR_PHY_CLBR_TIMER                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCEVS]
#define USE_RT_DEBUG_SCHDLR_EVNT_SKIPPED                      (1)
#define GPIO_DEBUG_SCHDLR_EVNT_SKIPPED                        {${SCEVS_PORT}, ${SCEVS_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EVNT_SKIPPED                      (0)
#define GPIO_DEBUG_SCHDLR_EVNT_SKIPPED                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCHN]
#define USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE                    (1)
#define GPIO_DEBUG_SCHDLR_HNDL_NXT_TRACE                      {${SCHN_PORT}, ${SCHN_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE                    (0)
#define GPIO_DEBUG_SCHDLR_HNDL_NXT_TRACE                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMACN]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED              (1)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED                {${ACND_PORT}, ${ACND_PIN}}
[#else]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED              (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMACNC]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK             (1)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK               {${ACNC_PORT}, ${ACNC_PIN}}
[#else]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK             (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMACNT]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK            (1)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK              {${ACNT_PORT}, ${ACNT_PIN}}
[#else]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK            (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMACNR]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_TRACE                 (1)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_TRACE                   {${ACNR_PORT}, ${ACNR_PIN}}
[#else]
#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_TRACE                 (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_TRACE                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCER]
#define USE_RT_DEBUG_SCHDLR_EVNT_RGSTR                        (1)
#define GPIO_DEBUG_SCHDLR_EVNT_RGSTR                          {${SCER_PORT}, ${SCER_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EVNT_RGSTR                        (0)
#define GPIO_DEBUG_SCHDLR_EVNT_RGSTR                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCAC]
#define USE_RT_DEBUG_SCHDLR_ADD_CONFLICT_Q                    (1)
#define GPIO_DEBUG_SCHDLR_ADD_CONFLICT_Q                      {${SCAC_PORT}, ${SCAC_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_ADD_CONFLICT_Q                    (0)
#define GPIO_DEBUG_SCHDLR_ADD_CONFLICT_Q                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCHM]
#define USE_RT_DEBUG_SCHDLR_HNDL_MISSED_EVNT                  (1)
#define GPIO_DEBUG_SCHDLR_HNDL_MISSED_EVNT                    {${SCHM_PORT}, ${SCHM_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_HNDL_MISSED_EVNT                  (0)
#define GPIO_DEBUG_SCHDLR_HNDL_MISSED_EVNT                    {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCUE]
#define USE_RT_DEBUG_SCHDLR_UNRGSTR_EVNT                      (1)
#define GPIO_DEBUG_SCHDLR_UNRGSTR_EVNT                        {${SCUE_PORT}, ${SCUE_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_UNRGSTR_EVNT                      (0)
#define GPIO_DEBUG_SCHDLR_UNRGSTR_EVNT                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCET]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE                   (1)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_TRACE                     {${SCET_PORT}, ${SCET_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE                   (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_TRACE                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCEP]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_PROFILE                 (1)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_PROFILE                   {${SCEP_PORT}, ${SCEP_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_PROFILE                 (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_PROFILE                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCEE]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_ERROR                   (1)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_ERROR                     {${SCEE_PORT}, ${SCEE_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_ERROR                   (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_ERROR                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCWI]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING         (1)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING           {${SCWI_PORT}, ${SCWI_PIN}}
[#else]
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING         (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLCM]
#define USE_RT_DEBUG_LLHWC_CMN_CLR_ISR                        (1)
#define GPIO_DEBUG_LLHWC_CMN_CLR_ISR                          {${LLCI_PORT}, ${LLCI_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_CMN_CLR_ISR                        (0)
#define GPIO_DEBUG_LLHWC_CMN_CLR_ISR                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLHI]
#define USE_RT_DEBUG_LLWCC_CMN_HG_ISR                         (1)
#define GPIO_DEBUG_LLWCC_CMN_HG_ISR                           {${LLCH_PORT}, ${LLCH_PIN}}
[#else]
#define USE_RT_DEBUG_LLWCC_CMN_HG_ISR                         (0)
#define GPIO_DEBUG_LLWCC_CMN_HG_ISR                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLCI]
#define USE_RT_DEBUG_LLHWC_CMN_LW_ISR                         (1)
#define GPIO_DEBUG_LLHWC_CMN_LW_ISR                           {${LLCM_PORT}, ${LLCM_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_CMN_LW_ISR                         (0)
#define GPIO_DEBUG_LLHWC_CMN_LW_ISR                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLCT]
#define USE_RT_DEBUG_LLHWC_CMN_CLR_TIMER_ERROR                (1)
#define GPIO_DEBUG_LLHWC_CMN_CLR_TIMER_ERROR                  {${LLCT_PORT}, ${LLCT_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_CMN_CLR_TIMER_ERROR                (0)
#define GPIO_DEBUG_LLHWC_CMN_CLR_TIMER_ERROR                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLIS]
#define USE_RT_DEBUG_LLHWC_LL_ISR                             (1)
#define GPIO_DEBUG_LLHWC_LL_ISR                               {${LLIS_PORT}, ${LLIS_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_LL_ISR                             (0)
#define GPIO_DEBUG_LLHWC_LL_ISR                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLSP]
#define USE_RT_DEBUG_LLHWC_SPLTMR_SET                         (1)
#define GPIO_DEBUG_LLHWC_SPLTMR_SET                           {${LLSP_PORT}, ${LLSP_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_SPLTMR_SET                         (0)
#define GPIO_DEBUG_LLHWC_SPLTMR_SET                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLSG]
#define USE_RT_DEBUG_LLHWC_SPLTMR_GET                         (1)
#define GPIO_DEBUG_LLHWC_SPLTMR_GET                           {${LLGE_PORT}, ${LLGE_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_SPLTMR_GET                         (0)
#define GPIO_DEBUG_LLHWC_SPLTMR_GET                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLLI]
#define USE_RT_DEBUG_LLHWC_LOW_ISR                            (1)
#define GPIO_DEBUG_LLHWC_LOW_ISR                              {${LLLI_PORT}, ${LLLI_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_LOW_ISR                            (0)
#define GPIO_DEBUG_LLHWC_LOW_ISR                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLST]
#define USE_RT_DEBUG_LLHWC_STOP_SCN                           (1)
#define GPIO_DEBUG_LLHWC_STOP_SCN                             {${LLSS_PORT}, ${LLSS_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_STOP_SCN                           (0)
#define GPIO_DEBUG_LLHWC_STOP_SCN                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLEA]
#define USE_RT_DEBUG_LLHWC_WAIT_ENVT_ON_AIR                   (1)
#define GPIO_DEBUG_LLHWC_WAIT_ENVT_ON_AIR                     {${LLEA_PORT}, ${LLEA_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_WAIT_ENVT_ON_AIR                   (0)
#define GPIO_DEBUG_LLHWC_WAIT_ENVT_ON_AIR                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLPA]
#define USE_RT_DEBUG_LLHWC_SET_CONN_EVNT_PARAM                (1)
#define GPIO_DEBUG_LLHWC_SET_CONN_EVNT_PARAM                  {${LHSC_PORT}, ${LHSC_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_SET_CONN_EVNT_PARAM                (0)
#define GPIO_DEBUG_LLHWC_SET_CONN_EVNT_PARAM                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPOEV]
#define USE_RT_DEBUG_POST_EVNT                                (1)
#define GPIO_DEBUG_POST_EVNT                                  {${POEV_PORT}, ${POEV_PIN}}
[#else]
#define USE_RT_DEBUG_POST_EVNT                                (0)
#define GPIO_DEBUG_POST_EVNT                                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMHNAL]
#define USE_RT_DEBUG_HNDL_ALL_EVNTS                           (1)
#define GPIO_DEBUG_HNDL_ALL_EVNTS                             {${HNAL_PORT}, ${HNAL_PIN}}
[#else]
#define USE_RT_DEBUG_HNDL_ALL_EVNTS                           (0)
#define GPIO_DEBUG_HNDL_ALL_EVNTS                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPREV]
#define USE_RT_DEBUG_PROCESS_EVNT                             (1)
#define GPIO_DEBUG_PROCESS_EVNT                               {${PREV_PORT}, ${PREV_PIN}}
[#else]
#define USE_RT_DEBUG_PROCESS_EVNT                             (0)
#define GPIO_DEBUG_PROCESS_EVNT                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRIS]
#define USE_RT_DEBUG_PROCESS_ISO_DATA                         (1)
#define GPIO_DEBUG_PROCESS_ISO_DATA                           {${PRIS_PORT}, ${PRIS_PIN}}
[#else]
#define USE_RT_DEBUG_PROCESS_ISO_DATA                         (0)
#define GPIO_DEBUG_PROCESS_ISO_DATA                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPREM]
#define USE_RT_DEBUG_ALLOC_TX_ISO_EMPTY_PKT                   (1)
#define GPIO_DEBUG_ALLOC_TX_ISO_EMPTY_PKT                     {${TXIS_PORT}, ${TXIS_PIN}}
[#else]
#define USE_RT_DEBUG_ALLOC_TX_ISO_EMPTY_PKT                   (0)
#define GPIO_DEBUG_ALLOC_TX_ISO_EMPTY_PKT                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMFREM]
#define USE_RT_DEBUG_BIG_FREE_EMPTY_PKTS                      (1)
#define GPIO_DEBUG_BIG_FREE_EMPTY_PKTS                        {${FREM_PORT}, ${FREM_PIN}}
[#else]
#define USE_RT_DEBUG_BIG_FREE_EMPTY_PKTS                      (0)
#define GPIO_DEBUG_BIG_FREE_EMPTY_PKTS                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMREUN]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_OK                 (1)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_OK                   {${REUN_PORT}, ${REUN_PIN}}
[#else]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_OK                 (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_OK                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMREDA]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_CRC                (1)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_CRC                  {${REDA_PORT}, ${REDA_PIN}}
[#else]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_CRC                (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_CRC                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRENO]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_NoRX               (1)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_NoRX                 {${RENO_PORT}, ${RENO_PIN}}
[#else]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_NoRX               (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_NoRX                 {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRETR]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_TRACE              (1)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_TRACE                {${RETR_PORT}, ${RETR_PIN}}
[#else]
#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_TRACE              (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_TRACE                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMISHN]
#define USE_RT_DEBUG_ISO_HNDL_SDU                             (1)
#define GPIO_DEBUG_ISO_HNDL_SDU                               {${ISHN_PORT}, ${ISHN_PIN}}
[#else]
#define USE_RT_DEBUG_ISO_HNDL_SDU                             (0)
#define GPIO_DEBUG_ISO_HNDL_SDU                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLIN]
#define USE_RT_DEBUG_LL_INTF_INIT                             (1)
#define GPIO_DEBUG_LL_INTF_INIT                               {${LLIN_PORT}, ${LLIN_PIN}}
[#else]
#define USE_RT_DEBUG_LL_INTF_INIT                             (0)
#define GPIO_DEBUG_LL_INTF_INIT                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMDATO]
#define USE_RT_DEBUG_DATA_TO_CNTRLR                           (1)
#define GPIO_DEBUG_DATA_TO_CNTRLR                             {${DATO_PORT}, ${DATO_PIN}}
[#else]
#define USE_RT_DEBUG_DATA_TO_CNTRLR                           (0)
#define GPIO_DEBUG_DATA_TO_CNTRLR                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLPK]
#define USE_RT_DEBUG_FREE_LL_PKT_HNDLR                        (1)
#define GPIO_DEBUG_FREE_LL_PKT_HNDLR                          {${LLPK_PORT}, ${LLPK_PIN}}
[#else]
#define USE_RT_DEBUG_FREE_LL_PKT_HNDLR                        (0)
#define GPIO_DEBUG_FREE_LL_PKT_HNDLR                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPYIN]
#define USE_RT_DEBUG_PHY_INIT_CLBR_TRACE                      (1)
#define GPIO_DEBUG_PHY_INIT_CLBR_TRACE                        {${INCL_PORT}, ${INCL_PIN}}
[#else]
#define USE_RT_DEBUG_PHY_INIT_CLBR_TRACE                      (0)
#define GPIO_DEBUG_PHY_INIT_CLBR_TRACE                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPYRC]
#define USE_RT_DEBUG_PHY_RUNTIME_CLBR_TRACE                   (1)
#define GPIO_DEBUG_PHY_RUNTIME_CLBR_TRACE                     {${PYCT_PORT}, ${PYCT_PIN}}
[#else]
#define USE_RT_DEBUG_PHY_RUNTIME_CLBR_TRACE                   (0)
#define GPIO_DEBUG_PHY_RUNTIME_CLBR_TRACE                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPYCI]
#define USE_RT_DEBUG_PHY_CLBR_ISR                             (1)
#define GPIO_DEBUG_PHY_CLBR_ISR                               {${PYCI_PORT}, ${PYCI_PIN}}
[#else]
#define USE_RT_DEBUG_PHY_CLBR_ISR                             (0)
#define GPIO_DEBUG_PHY_CLBR_ISR                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPYCL]
#define USE_RT_DEBUG_PHY_INIT_CLBR_SINGLE_CH                  (1)
#define GPIO_DEBUG_PHY_INIT_CLBR_SINGLE_CH                    {${PYCL_PORT}, ${PYCL_PIN}}
[#else]
#define USE_RT_DEBUG_PHY_INIT_CLBR_SINGLE_CH                  (0)
#define GPIO_DEBUG_PHY_INIT_CLBR_SINGLE_CH                    {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPYST]
#define USE_RT_DEBUG_PHY_CLBR_STRTD                           (1)
#define GPIO_DEBUG_PHY_CLBR_STRTD                             {${PYST_PORT}, ${PYST_PIN}}
[#else]
#define USE_RT_DEBUG_PHY_CLBR_STRTD                           (0)
#define GPIO_DEBUG_PHY_CLBR_STRTD                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPYEX]
#define USE_RT_DEBUG_PHY_CLBR_EXEC                            (1)
#define GPIO_DEBUG_PHY_CLBR_EXEC                              {${CLEX_PORT}, ${CLEX_PIN}}
[#else]
#define USE_RT_DEBUG_PHY_CLBR_EXEC                            (0)
#define GPIO_DEBUG_PHY_CLBR_EXEC                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRCAC]
#define USE_RT_DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV          (1)
#define GPIO_DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV            {${ROST_PORT}, ${ROST_PIN}}
[#else]
#define USE_RT_DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV          (0)
#define GPIO_DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRCST]
#define USE_RT_DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR           (1)
#define GPIO_DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR             {${RCST_PORT}, ${RCST_PIN}}
[#else]
#define USE_RT_DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR           (0)
#define GPIO_DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSTRU]
#define USE_RT_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT           (1)
#define GPIO_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT             {${STRU_PORT}, ${STRU_PIN}}
[#else]
#define USE_RT_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT           (0)
#define GPIO_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSTRC]
#define USE_RT_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE         (1)
#define GPIO_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE           {${STRC_PORT}, ${STRC_PIN}}
[#else]
#define USE_RT_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE         (0)
#define GPIO_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRCIS]
#define USE_RT_DEBUG_RCO_ISR_TRACE                            (1)
#define GPIO_DEBUG_RCO_ISR_TRACE                              {${RCIS_PORT}, ${RCIS_PIN}}
[#else]
#define USE_RT_DEBUG_RCO_ISR_TRACE                            (0)
#define GPIO_DEBUG_RCO_ISR_TRACE                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRCCO]
#define USE_RT_DEBUG_RCO_ISR_COMPENDATE                       (1)
#define GPIO_DEBUG_RCO_ISR_COMPENDATE                         {${RCCO_PORT}, ${RCCO_PIN}}
[#else]
#define USE_RT_DEBUG_RCO_ISR_COMPENDATE                       (0)
#define GPIO_DEBUG_RCO_ISR_COMPENDATE                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAST]
#define USE_RT_DEBUG_RAL_STRT_TX                              (1)
#define GPIO_DEBUG_RAL_STRT_TX                                {${RAST_PORT}, ${RAST_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_STRT_TX                              (0)
#define GPIO_DEBUG_RAL_STRT_TX                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAER]
#define USE_RT_DEBUG_RAL_ISR_TIMER_ERROR                      (1)
#define GPIO_DEBUG_RAL_ISR_TIMER_ERROR                        {${RAIS_PORT}, ${RAIS_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_ISR_TIMER_ERROR                      (0)
#define GPIO_DEBUG_RAL_ISR_TIMER_ERROR                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRATR]
#define USE_RT_DEBUG_RAL_ISR_TRACE                            (1)
#define GPIO_DEBUG_RAL_ISR_TRACE                              {${RATR_PORT}, ${RATR_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_ISR_TRACE                            (0)
#define GPIO_DEBUG_RAL_ISR_TRACE                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAOP]
#define USE_RT_DEBUG_RAL_STOP_OPRTN                           (1)
#define GPIO_DEBUG_RAL_STOP_OPRTN                             {${RAOP_PORT}, ${RAOP_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_STOP_OPRTN                           (0)
#define GPIO_DEBUG_RAL_STOP_OPRTN                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRARX]
#define USE_RT_DEBUG_RAL_STRT_RX                              (1)
#define GPIO_DEBUG_RAL_STRT_RX                                {${RARX_PORT}, ${RARX_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_STRT_RX                              (0)
#define GPIO_DEBUG_RAL_STRT_RX                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMDOCL]
#define USE_RT_DEBUG_RAL_DONE_CLBK_TX                         (1)
#define GPIO_DEBUG_RAL_DONE_CLBK_TX                           {${DOCL_PORT}, ${DOCL_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_DONE_CLBK_TX                         (0)
#define GPIO_DEBUG_RAL_DONE_CLBK_TX                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRADO]
#define USE_RT_DEBUG_RAL_DONE_CLBK_RX                         (1)
#define GPIO_DEBUG_RAL_DONE_CLBK_RX                           {${RADO_PORT}, ${RADO_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_DONE_CLBK_RX                         (0)
#define GPIO_DEBUG_RAL_DONE_CLBK_RX                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRACL]
#define USE_RT_DEBUG_RAL_DONE_CLBK_ED                         (1)
#define GPIO_DEBUG_RAL_DONE_CLBK_ED                           {${RACL_PORT}, ${RACL_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_DONE_CLBK_ED                         (0)
#define GPIO_DEBUG_RAL_DONE_CLBK_ED                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAED]
#define USE_RT_DEBUG_RAL_ED_SCAN                              (1)
#define GPIO_DEBUG_RAL_ED_SCAN                                {${RAED_PORT}, ${RAED_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_ED_SCAN                              (0)
#define GPIO_DEBUG_RAL_ED_SCAN                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMERCA]
#define USE_RT_DEBUG_ERROR_MEM_CAP_EXCED                      (1)
#define GPIO_DEBUG_ERROR_MEM_CAP_EXCED                        {${ERCA_PORT}, ${ERCA_PIN}}
[#else]
#define USE_RT_DEBUG_ERROR_MEM_CAP_EXCED                      (0)
#define GPIO_DEBUG_ERROR_MEM_CAP_EXCED                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMERCO]
#define USE_RT_DEBUG_ERROR_COMMAND_DISALLOWED                 (1)
#define GPIO_DEBUG_ERROR_COMMAND_DISALLOWED                   {${ERCO_PORT}, ${ERCO_PIN}}
[#else]
#define USE_RT_DEBUG_ERROR_COMMAND_DISALLOWED                 (0)
#define GPIO_DEBUG_ERROR_COMMAND_DISALLOWED                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPTIN]
#define USE_RT_DEBUG_PTA_INIT                                 (1)
#define GPIO_DEBUG_PTA_INIT                                   {${PTIN_PORT}, ${PTIN_PIN}}
[#else]
#define USE_RT_DEBUG_PTA_INIT                                 (0)
#define GPIO_DEBUG_PTA_INIT                                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPTEN]
#define USE_RT_DEBUG_PTA_EN                                   (1)
#define GPIO_DEBUG_PTA_EN                                     {${PTEN_PORT}, ${PTEN_PIN}}
[#else]
#define USE_RT_DEBUG_PTA_EN                                   (0)
#define GPIO_DEBUG_PTA_EN                                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPTSE]
#define USE_RT_DEBUG_LLHWC_PTA_SET_EN                         (1)
#define GPIO_DEBUG_LLHWC_PTA_SET_EN                           {${PTSE_PORT}, ${PTSE_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_PTA_SET_EN                         (0)
#define GPIO_DEBUG_LLHWC_PTA_SET_EN                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPTPA]
#define USE_RT_DEBUG_LLHWC_PTA_SET_PARAMS                     (1)
#define GPIO_DEBUG_LLHWC_PTA_SET_PARAMS                       {${PTPA_PORT}, ${PTPA_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_PTA_SET_PARAMS                     (0)
#define GPIO_DEBUG_LLHWC_PTA_SET_PARAMS                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCOST]
#define USE_RT_DEBUG_COEX_STRT_ON_IDLE                        (1)
#define GPIO_DEBUG_COEX_STRT_ON_IDLE                          {${COST_PORT}, ${COST_PIN}}
[#else]
#define USE_RT_DEBUG_COEX_STRT_ON_IDLE                        (0)
#define GPIO_DEBUG_COEX_STRT_ON_IDLE                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCOAS]
#define USE_RT_DEBUG_COEX_ASK_FOR_AIR                         (1)
#define GPIO_DEBUG_COEX_ASK_FOR_AIR                           {${COAS_PORT}, ${COAS_PIN}}
[#else]
#define USE_RT_DEBUG_COEX_ASK_FOR_AIR                         (0)
#define GPIO_DEBUG_COEX_ASK_FOR_AIR                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCOTI]
#define USE_RT_DEBUG_COEX_TIMER_EVNT_CLBK                     (1)
#define GPIO_DEBUG_COEX_TIMER_EVNT_CLBK                       {${COTI_PORT}, ${COTI_PIN}}
[#else]
#define USE_RT_DEBUG_COEX_TIMER_EVNT_CLBK                     (0)
#define GPIO_DEBUG_COEX_TIMER_EVNT_CLBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCOON]
#define USE_RT_DEBUG_COEX_STRT_ONE_SHOT                       (1)
#define GPIO_DEBUG_COEX_STRT_ONE_SHOT                         {${COON_PORT}, ${COON_PIN}}
[#else]
#define USE_RT_DEBUG_COEX_STRT_ONE_SHOT                       (0)
#define GPIO_DEBUG_COEX_STRT_ONE_SHOT                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCOFO]
#define USE_RT_DEBUG_COEX_FORCE_STOP_RX                       (1)
#define GPIO_DEBUG_COEX_FORCE_STOP_RX                         {${COFO_PORT}, ${COFO_PIN}}
[#else]
#define USE_RT_DEBUG_COEX_FORCE_STOP_RX                       (0)
#define GPIO_DEBUG_COEX_FORCE_STOP_RX                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLAD]
#define USE_RT_DEBUG_LLHWC_ADV_DONE                           (1)
#define GPIO_DEBUG_LLHWC_ADV_DONE                             {${LLAD_PORT}, ${LLAD_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_ADV_DONE                           (0)
#define GPIO_DEBUG_LLHWC_ADV_DONE                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLSC]
#define USE_RT_DEBUG_LLHWC_SCN_DONE                           (1)
#define GPIO_DEBUG_LLHWC_SCN_DONE                             {${LLSC_PORT}, ${LLSC_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_SCN_DONE                           (0)
#define GPIO_DEBUG_LLHWC_SCN_DONE                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLID]
#define USE_RT_DEBUG_LLHWC_INIT_DONE                          (1)
#define GPIO_DEBUG_LLHWC_INIT_DONE                            {${LLID_PORT}, ${LLID_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_INIT_DONE                          (0)
#define GPIO_DEBUG_LLHWC_INIT_DONE                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLCO]
#define USE_RT_DEBUG_LLHWC_CONN_DONE                          (1)
#define GPIO_DEBUG_LLHWC_CONN_DONE                            {${LLCO_PORT}, ${LLCO_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_CONN_DONE                          (0)
#define GPIO_DEBUG_LLHWC_CONN_DONE                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLGD]
#define USE_RT_DEBUG_LLHWC_CIG_DONE                           (1)
#define GPIO_DEBUG_LLHWC_CIG_DONE                             {${LLGD_PORT}, ${LLGD_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_CIG_DONE                           (0)
#define GPIO_DEBUG_LLHWC_CIG_DONE                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLBI]
#define USE_RT_DEBUG_LLHWC_BIG_DONE                           (1)
#define GPIO_DEBUG_LLHWC_BIG_DONE                             {${LLBI_PORT}, ${LLBI_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_BIG_DONE                           (0)
#define GPIO_DEBUG_LLHWC_BIG_DONE                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLTM]
#define USE_RT_DEBUG_OS_TMR_CREATE                            (1)
#define GPIO_DEBUG_OS_TMR_CREATE                              {${LLTM_PORT}, ${LLTM_PIN}}
[#else]
#define USE_RT_DEBUG_OS_TMR_CREATE                            (0)
#define GPIO_DEBUG_OS_TMR_CREATE                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLEX]
#define USE_RT_DEBUG_ADV_EXT_TIMEOUT_CBK                      (1)
#define GPIO_DEBUG_ADV_EXT_TIMEOUT_CBK                        {${LLEX_PORT}, ${LLEX_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_TIMEOUT_CBK                      (0)
#define GPIO_DEBUG_ADV_EXT_TIMEOUT_CBK                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLDU]
#define USE_RT_DEBUG_ADV_EXT_SCN_DUR_CBK                      (1)
#define GPIO_DEBUG_ADV_EXT_SCN_DUR_CBK                        {${LLDU_PORT}, ${LLDU_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_SCN_DUR_CBK                      (0)
#define GPIO_DEBUG_ADV_EXT_SCN_DUR_CBK                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMADPE]
#define USE_RT_DEBUG_ADV_EXT_SCN_PERIOD_CBK                   (1)
#define GPIO_DEBUG_ADV_EXT_SCN_PERIOD_CBK                     {${ADPE_PORT}, ${ADPE_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_SCN_PERIOD_CBK                   (0)
#define GPIO_DEBUG_ADV_EXT_SCN_PERIOD_CBK                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMADEX]
#define USE_RT_DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK             (1)
#define GPIO_DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK               {${ADEX_PORT}, ${ADEX_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK             (0)
#define GPIO_DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBITI]
#define USE_RT_DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK                 (1)
#define GPIO_DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK                   {${BITI_PORT}, ${BITI_PIN}}
[#else]
#define USE_RT_DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK                 (0)
#define GPIO_DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBITM]
#define USE_RT_DEBUG_BIS_TERM_TMR_CBK                         (1)
#define GPIO_DEBUG_BIS_TERM_TMR_CBK                           {${BITM_PORT}, ${BITM_PIN}}
[#else]
#define USE_RT_DEBUG_BIS_TERM_TMR_CBK                         (0)
#define GPIO_DEBUG_BIS_TERM_TMR_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBITS]
#define USE_RT_DEBUG_BIS_TST_MODE_CBK                         (1)
#define GPIO_DEBUG_BIS_TST_MODE_CBK                           {${BITS_PORT}, ${BITS_PIN}}
[#else]
#define USE_RT_DEBUG_BIS_TST_MODE_CBK                         (0)
#define GPIO_DEBUG_BIS_TST_MODE_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBIMO]
#define USE_RT_DEBUG_BIS_TST_MODE_TMR_CBK                     (1)
#define GPIO_DEBUG_BIS_TST_MODE_TMR_CBK                       {${BIMO_PORT}, ${BIMO_PIN}}
[#else]
#define USE_RT_DEBUG_BIS_TST_MODE_TMR_CBK                     (0)
#define GPIO_DEBUG_BIS_TST_MODE_TMR_CBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMISCB]
#define USE_RT_DEBUG_ISO_POST_TMR_CBK                         (1)
#define GPIO_DEBUG_ISO_POST_TMR_CBK                           {${ISCB_PORT}, ${ISCB_PIN}}
[#else]
#define USE_RT_DEBUG_ISO_POST_TMR_CBK                         (0)
#define GPIO_DEBUG_ISO_POST_TMR_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMISMO]
#define USE_RT_DEBUG_ISO_TST_MODE_TMR_CBK                     (1)
#define GPIO_DEBUG_ISO_TST_MODE_TMR_CBK                       {${ISMO_PORT}, ${ISMO_PIN}}
[#else]
#define USE_RT_DEBUG_ISO_TST_MODE_TMR_CBK                     (0)
#define GPIO_DEBUG_ISO_TST_MODE_TMR_CBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCOTM]
#define USE_RT_DEBUG_CONN_POST_TMR_CBK                        (1)
#define GPIO_DEBUG_CONN_POST_TMR_CBK                          {${COTM_PORT}, ${COTM_PIN}}
[#else]
#define USE_RT_DEBUG_CONN_POST_TMR_CBK                        (0)
#define GPIO_DEBUG_CONN_POST_TMR_CBK                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCCB]
#define USE_RT_DEBUG_EVNT_SCHDLR_TMR_CBK                      (1)
#define GPIO_DEBUG_EVNT_SCHDLR_TMR_CBK                        {${SCCB_PORT}, ${SCCB_PIN}}
[#else]
#define USE_RT_DEBUG_EVNT_SCHDLR_TMR_CBK                      (0)
#define GPIO_DEBUG_EVNT_SCHDLR_TMR_CBK                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMHCPO]
#define USE_RT_DEBUG_HCI_POST_TMR_CBK                         (1)
#define GPIO_DEBUG_HCI_POST_TMR_CBK                           {${HCPO_PORT}, ${HCPO_PIN}}
[#else]
#define USE_RT_DEBUG_HCI_POST_TMR_CBK                         (0)
#define GPIO_DEBUG_HCI_POST_TMR_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLRR]
#define USE_RT_DEBUG_LLCP_POST_TMR_CBK                        (1)
#define GPIO_DEBUG_LLCP_POST_TMR_CBK                          {${LLRR_PORT}, ${LLRR_PIN}}
[#else]
#define USE_RT_DEBUG_LLCP_POST_TMR_CBK                        (0)
#define GPIO_DEBUG_LLCP_POST_TMR_CBK                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMENDE]
#define USE_RT_DEBUG_LLHWC_ENRGY_DETECT_CBK                   (1)
#define GPIO_DEBUG_LLHWC_ENRGY_DETECT_CBK                     {${ENDE_PORT}, ${ENDE_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_ENRGY_DETECT_CBK                   (0)
#define GPIO_DEBUG_LLHWC_ENRGY_DETECT_CBK                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRPO]
#define USE_RT_DEBUG_PRVCY_POST_TMR_CBK                       (0)
#define GPIO_DEBUG_PRVCY_POST_TMR_CBK                         {${PRPO_PORT}, ${PRPO_PIN}}
[#else]
#define USE_RT_DEBUG_PRVCY_POST_TMR_CBK                       (0)
#define GPIO_DEBUG_PRVCY_POST_TMR_CBK                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMANTM]
#define USE_RT_DEBUG_ANT_PRPR_TMR_CBK                         (1)
#define GPIO_DEBUG_ANT_PRPR_TMR_CBK                           {${ANTM_PORT}, ${ANTM_PIN}}
[#else]
#define USE_RT_DEBUG_ANT_PRPR_TMR_CBK                         (0)
#define GPIO_DEBUG_ANT_PRPR_TMR_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMFRAI]
#define USE_RT_DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK          (1)
#define GPIO_DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK            {${FRAI_PORT}, ${FRAI_PIN}}
[#else]
#define USE_RT_DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK          (0)
#define GPIO_DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMLEN]
#define USE_RT_DEBUG_MLME_RX_EN_TMR_CBK                       (1)
#define GPIO_DEBUG_MLME_RX_EN_TMR_CBK                         {${MLEN_PORT}, ${MLEN_PIN}}
[#else]
#define USE_RT_DEBUG_MLME_RX_EN_TMR_CBK                       (0)
#define GPIO_DEBUG_MLME_RX_EN_TMR_CBK                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMGNTM]
#define USE_RT_DEBUG_MLME_GNRC_TMR_CBK                        (1)
#define GPIO_DEBUG_MLME_GNRC_TMR_CBK                          {${GNTM_PORT}, ${GNTM_PIN}}
[#else]
#define USE_RT_DEBUG_MLME_GNRC_TMR_CBK                        (0)
#define GPIO_DEBUG_MLME_GNRC_TMR_CBK                          {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMILS]
#define USE_RT_DEBUG_MIB_JOIN_LST_TMR_CBK                     (1)
#define GPIO_DEBUG_MIB_JOIN_LST_TMR_CBK                       {${MILS_PORT}, ${MILS_PIN}}
[#else]
#define USE_RT_DEBUG_MIB_JOIN_LST_TMR_CBK                     (0)
#define GPIO_DEBUG_MIB_JOIN_LST_TMR_CBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPWPR]
#define USE_RT_DEBUG_MLME_PWR_PRES_TMR_CBK                    (1)
#define GPIO_DEBUG_MLME_PWR_PRES_TMR_CBK                      {${PWPR_PORT}, ${PWPR_PIN}}
[#else]
#define USE_RT_DEBUG_MLME_PWR_PRES_TMR_CBK                    (0)
#define GPIO_DEBUG_MLME_PWR_PRES_TMR_CBK                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRTM]
#define USE_RT_DEBUG_PRESISTENCE_TMR_CBK                      (1)
#define GPIO_DEBUG_PRESISTENCE_TMR_CBK                        {${PRTM_PORT}, ${PRTM_PIN}}
[#else]
#define USE_RT_DEBUG_PRESISTENCE_TMR_CBK                      (0)
#define GPIO_DEBUG_PRESISTENCE_TMR_CBK                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAPY]
#define USE_RT_DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK              (1)
#define GPIO_DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK                {${RAPY_PORT}, ${RAPY_PIN}}
[#else]
#define USE_RT_DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK              (0)
#define GPIO_DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRACS]
#define USE_RT_DEBUG_RADIO_CSMA_TMR_CBK                       (1)
#define GPIO_DEBUG_RADIO_CSMA_TMR_CBK                         {${RACS_PORT}, ${RACS_PIN}}
[#else]
#define USE_RT_DEBUG_RADIO_CSMA_TMR_CBK                       (0)
#define GPIO_DEBUG_RADIO_CSMA_TMR_CBK                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCSCB]
#define USE_RT_DEBUG_RADIO_CSL_RCV_TMR_CBK                    (0)
#define GPIO_DEBUG_RADIO_CSL_RCV_TMR_CBK                      {${CSCB_PORT}, ${CSCB_PIN}}
[#else]
#define USE_RT_DEBUG_RADIO_CSL_RCV_TMR_CBK                    (0)
#define GPIO_DEBUG_RADIO_CSL_RCV_TMR_CBK                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMEDCB]
#define USE_RT_DEBUG_ED_TMR_CBK                               (1)
#define GPIO_DEBUG_ED_TMR_CBK                                 {${EDCB_PORT}, ${EDCB_PIN}}
[#else]
#define USE_RT_DEBUG_ED_TMR_CBK                               (0)
#define GPIO_DEBUG_ED_TMR_CBK                                 {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMDIEX]
#define USE_RT_DEBUG_DIO_EXT_TMR_CBK                          (1)
#define GPIO_DEBUG_DIO_EXT_TMR_CBK                            {${DIEX_PORT}, ${DIEX_PIN}}
[#else]
#define USE_RT_DEBUG_DIO_EXT_TMR_CBK                          (0)
#define GPIO_DEBUG_DIO_EXT_TMR_CBK                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRCCL]
#define USE_RT_DEBUG_RCO_CLBR_TMR_CBK                         (1)
#define GPIO_DEBUG_RCO_CLBR_TMR_CBK                           {${RCCL_PORT}, ${RCCL_PIN}}
[#else]
#define USE_RT_DEBUG_RCO_CLBR_TMR_CBK                         (0)
#define GPIO_DEBUG_RCO_CLBR_TMR_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMADMN]
#define USE_RT_DEBUG_ADV_EXT_MNGR_ADV_CBK                     (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_ADV_CBK                       {${ADMN_PORT}, ${ADMN_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_ADV_CBK                     (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_ADV_CBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMADCB]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_CBK                     (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_CBK                       {${ADCB_PORT}, ${ADCB_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_CBK                     (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_CBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMNER]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK                 (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK                   {${MNER_PORT}, ${MNER_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK                 (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMNCN]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK                (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK                  {${MNCN_PORT}, ${MNCN_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK                (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRER]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK            (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK              {${PRER_PORT}, ${PRER_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK            (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBICB]
#define USE_RT_DEBUG_BIG_ADV_CBK                              (1)
#define GPIO_DEBUG_BIG_ADV_CBK                                {${BICB_PORT}, ${BICB_PIN}}
[#else]
#define USE_RT_DEBUG_BIG_ADV_CBK                              (0)
#define GPIO_DEBUG_BIG_ADV_CBK                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBICK]
#define USE_RT_DEBUG_BIG_ADV_ERR_CBK                          (1)
#define GPIO_DEBUG_BIG_ADV_ERR_CBK                            {${BICK_PORT}, ${BICK_PIN}}
[#else]
#define USE_RT_DEBUG_BIG_ADV_ERR_CBK                          (0)
#define GPIO_DEBUG_BIG_ADV_ERR_CBK                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSYCB]
#define USE_RT_DEBUG_BIG_SYNC_CBK                             (1)
#define GPIO_DEBUG_BIG_SYNC_CBK                               {${SYCB_PORT}, ${SYCB_PIN}}
[#else]
#define USE_RT_DEBUG_BIG_SYNC_CBK                             (0)
#define GPIO_DEBUG_BIG_SYNC_CBK                               {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMERRC]
#define USE_RT_DEBUG_BIG_SYNC_ERR_CBK                         (1)
#define GPIO_DEBUG_BIG_SYNC_ERR_CBK                           {${ERRC_PORT}, ${ERRC_PIN}}
[#else]
#define USE_RT_DEBUG_BIG_SYNC_ERR_CBK                         (0)
#define GPIO_DEBUG_BIG_SYNC_ERR_CBK                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCITR]
#define USE_RT_DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK           (1)
#define GPIO_DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK             {${CITR_PORT}, ${CITR_PIN}}
[#else]
#define USE_RT_DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK           (0)
#define GPIO_DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMISBK]
#define USE_RT_DEBUG_ISO_CIG_ERR_CBK                          (1)
#define GPIO_DEBUG_ISO_CIG_ERR_CBK                            {${ISBK_PORT}, ${ISBK_PIN}}
[#else]
#define USE_RT_DEBUG_ISO_CIG_ERR_CBK                          (0)
#define GPIO_DEBUG_ISO_CIG_ERR_CBK                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCONN]
#define USE_RT_DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK              (1)
#define GPIO_DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK                {${CONN_PORT}, ${CONN_PIN}}
[#else]
#define USE_RT_DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK              (0)
#define GPIO_DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCLBR]
#define USE_RT_DEBUG_PRDC_CLBR_EXTRL_CBK                      (1)
#define GPIO_DEBUG_PRDC_CLBR_EXTRL_CBK                        {${CLBR_PORT}, ${CLBR_PIN}}
[#else]
#define USE_RT_DEBUG_PRDC_CLBR_EXTRL_CBK                      (0)
#define GPIO_DEBUG_PRDC_CLBR_EXTRL_CBK                        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRDC]
#define USE_RT_DEBUG_PTR_PRDC_ADV_SYNC_CBK                    (1)
#define GPIO_DEBUG_PTR_PRDC_ADV_SYNC_CBK                      {${PRDC_PORT}, ${PRDC_PIN}}
[#else]
#define USE_RT_DEBUG_PTR_PRDC_ADV_SYNC_CBK                    (0)
#define GPIO_DEBUG_PTR_PRDC_ADV_SYNC_CBK                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMNCON]
#define USE_RT_DEBUG_NCONN_SCN_CBK                            (1)
#define GPIO_DEBUG_NCONN_SCN_CBK                              {${NCON_PORT}, ${NCON_PIN}}
[#else]
#define USE_RT_DEBUG_NCONN_SCN_CBK                            (0)
#define GPIO_DEBUG_NCONN_SCN_CBK                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMADVC]
#define USE_RT_DEBUG_NCONN_ADV_CBK                            (1)
#define GPIO_DEBUG_NCONN_ADV_CBK                              {${ADVC_PORT}, ${ADVC_PIN}}
[#else]
#define USE_RT_DEBUG_NCONN_ADV_CBK                            (0)
#define GPIO_DEBUG_NCONN_ADV_CBK                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMINIT]
#define USE_RT_DEBUG_NCONN_INIT_CBK                           (1)
#define GPIO_DEBUG_NCONN_INIT_CBK                             {${INIT_PORT}, ${INIT_PIN}}
[#else]
#define USE_RT_DEBUG_NCONN_INIT_CBK                           (0)
#define GPIO_DEBUG_NCONN_INIT_CBK                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCMEV]
#define USE_RT_DEBUG_ANT_RADIO_CMPLT_EVNT_CBK                 (1)
#define GPIO_DEBUG_ANT_RADIO_CMPLT_EVNT_CBK                   {${CMEV_PORT}, ${CMEV_PIN}}
[#else]
#define USE_RT_DEBUG_ANT_RADIO_CMPLT_EVNT_CBK                 (0)
#define GPIO_DEBUG_ANT_RADIO_CMPLT_EVNT_CBK                   {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMEVCB]
#define USE_RT_DEBUG_ANT_STACK_EVNT_CBK                       (1)
#define GPIO_DEBUG_ANT_STACK_EVNT_CBK                         {${EVCB_PORT}, ${EVCB_PIN}}
[#else]
#define USE_RT_DEBUG_ANT_STACK_EVNT_CBK                       (0)
#define GPIO_DEBUG_ANT_STACK_EVNT_CBK                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMTMOU]
#define USE_RT_DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK           (1)
#define GPIO_DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK             {${TMOU_PORT}, ${TMOU_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK           (0)
#define GPIO_DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMDURE]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT                (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT                  {${DURE_PORT}, ${DURE_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT                (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMEXSC]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT           (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT             {${EXSC_PORT}, ${EXSC_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT           (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMTMEV]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT         (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT           {${TMEV_PORT}, ${TMEV_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT         (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRCE]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT         (1)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT           {${PRCE_PORT}, ${PRCE_PIN}}
[#else]
#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT         (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMBIGT]
#define USE_RT_DEBUG_BIS_MNGR_BIG_TERM_CBK                    (1)
#define GPIO_DEBUG_BIS_MNGR_BIG_TERM_CBK                      {${BIGT_PORT}, ${BIGT_PIN}}
[#else]
#define USE_RT_DEBUG_BIS_MNGR_BIG_TERM_CBK                    (0)
#define GPIO_DEBUG_BIS_MNGR_BIG_TERM_CBK                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMNCB]
#define USE_RT_DEBUG_BIS_MNGR_SYNC_TMOUT_CBK                  (1)
#define GPIO_DEBUG_BIS_MNGR_SYNC_TMOUT_CBK                    {${MNCB_PORT}, ${MNCB_PIN}}
[#else]
#define USE_RT_DEBUG_BIS_MNGR_SYNC_TMOUT_CBK                  (0)
#define GPIO_DEBUG_BIS_MNGR_SYNC_TMOUT_CBK                    {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMISSD]
#define USE_RT_DEBUG_ISOAL_MNGR_SDU_GEN                       (1)
#define GPIO_DEBUG_ISOAL_MNGR_SDU_GEN                         {${ISSD_PORT}, ${ISSD_PIN}}
[#else]
#define USE_RT_DEBUG_ISOAL_MNGR_SDU_GEN                       (0)
#define GPIO_DEBUG_ISOAL_MNGR_SDU_GEN                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCISP]
#define USE_RT_DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK            (1)
#define GPIO_DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK              {${CISP_PORT}, ${CISP_PIN}}
[#else]
#define USE_RT_DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK            (0)
#define GPIO_DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMCONP]
#define USE_RT_DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK              (1)
#define GPIO_DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK                {${CONP_PORT}, ${CONP_PIN}}
[#else]
#define USE_RT_DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK              (0)
#define GPIO_DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMUPDT]
#define USE_RT_DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK            (1)
#define GPIO_DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK              {${UPDT_PORT}, ${UPDT_PIN}}
[#else]
#define USE_RT_DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK            (0)
#define GPIO_DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMSCHW]
#define USE_RT_DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT                (1)
#define GPIO_DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT                  {${SCHW_PORT}, ${SCHW_PIN}}
[#else]
#define USE_RT_DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT                (0)
#define GPIO_DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT                  {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMHNDL]
#define USE_RT_DEBUG_HCI_EVENT_HNDLR                          (1)
#define GPIO_DEBUG_HCI_EVENT_HNDLR                            {${HNDL_PORT}, ${HNDL_PIN}}
[#else]
#define USE_RT_DEBUG_HCI_EVENT_HNDLR                          (0)
#define GPIO_DEBUG_HCI_EVENT_HNDLR                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMLTM]
#define USE_RT_DEBUG_MLME_TMRS_CBK                            (1)
#define GPIO_DEBUG_MLME_TMRS_CBK                              {${MLTM_PORT}, ${MLTM_PIN}}
[#else]
#define USE_RT_DEBUG_MLME_TMRS_CBK                            (0)
#define GPIO_DEBUG_MLME_TMRS_CBK                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMTXEV]
#define USE_RT_DEBUG_DIRECT_TX_EVNT_CBK                       (1)
#define GPIO_DEBUG_DIRECT_TX_EVNT_CBK                         {${TXEV_PORT}, ${TXEV_PIN}}
[#else]
#define USE_RT_DEBUG_DIRECT_TX_EVNT_CBK                       (0)
#define GPIO_DEBUG_DIRECT_TX_EVNT_CBK                         {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMINPK]
#define USE_RT_DEBUG_INDIRECT_PKT_TOUR_CBK                    (1)
#define GPIO_DEBUG_INDIRECT_PKT_TOUR_CBK                      {${INPK_PORT}, ${INPK_PIN}}
[#else]
#define USE_RT_DEBUG_INDIRECT_PKT_TOUR_CBK                    (0)
#define GPIO_DEBUG_INDIRECT_PKT_TOUR_CBK                      {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRDCS]
#define USE_RT_DEBUG_RADIO_CSMA_TMR                           (1)
#define GPIO_DEBUG_RADIO_CSMA_TMR                             {${RDCS_PORT}, ${RDCS_PIN}}
[#else]
#define USE_RT_DEBUG_RADIO_CSMA_TMR                           (0)
#define GPIO_DEBUG_RADIO_CSMA_TMR                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRADE]
#define USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK                     (1)
#define GPIO_DEBUG_RAL_SM_DONE_EVNT_CBK                       {${RADE_PORT}, ${RADE_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK                     (0)
#define GPIO_DEBUG_RAL_SM_DONE_EVNT_CBK                       {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMEDTM]
#define USE_RT_DEBUG_ED_TMR_HNDL                              (1)
#define GPIO_DEBUG_ED_TMR_HNDL                                {${EDTM_PORT}, ${EDTM_PIN}}
[#else]
#define USE_RT_DEBUG_ED_TMR_HNDL                              (0)
#define GPIO_DEBUG_ED_TMR_HNDL                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMOSTM]
#define USE_RT_DEBUG_OS_TMR_EVNT_CBK                          (1)
#define GPIO_DEBUG_OS_TMR_EVNT_CBK                            {${OSTM_PORT}, ${OSTM_PIN}}
[#else]
#define USE_RT_DEBUG_OS_TMR_EVNT_CBK                          (0)
#define GPIO_DEBUG_OS_TMR_EVNT_CBK                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMAPH]
#define USE_RT_DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME           (1)
#define GPIO_DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME             {${MAPH_PORT}, ${MAPH_PIN}}
[#else]
#define USE_RT_DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME           (0)
#define GPIO_DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMENDR]
#define USE_RT_DEBUG_PROFILE_END_DRIFT_TIME                   (1)
#define GPIO_DEBUG_PROFILE_END_DRIFT_TIME                     {${ENDR_PORT}, ${ENDR_PIN}}
[#else]
#define USE_RT_DEBUG_PROFILE_END_DRIFT_TIME                   (0)
#define GPIO_DEBUG_PROFILE_END_DRIFT_TIME                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRRC]
#define USE_RT_DEBUG_PROC_RADIO_RCV                           (1)
#define GPIO_DEBUG_PROC_RADIO_RCV                             {${PRRC_PORT}, ${PRRC_PIN}}
[#else]
#define USE_RT_DEBUG_PROC_RADIO_RCV                           (0)
#define GPIO_DEBUG_PROC_RADIO_RCV                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMTIUP]
#define USE_RT_DEBUG_EVNT_TIME_UPDT                           (1)
#define GPIO_DEBUG_EVNT_TIME_UPDT                             {${TIUP_PORT}, ${TIUP_PIN}}
[#else]
#define USE_RT_DEBUG_EVNT_TIME_UPDT                           (0)
#define GPIO_DEBUG_EVNT_TIME_UPDT                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMARE]
#define USE_RT_DEBUG_MAC_RECEIVE_DONE                         (1)
#define GPIO_DEBUG_MAC_RECEIVE_DONE                           {${MARE_PORT}, ${MARE_PIN}}
[#else]
#define USE_RT_DEBUG_MAC_RECEIVE_DONE                         (0)
#define GPIO_DEBUG_MAC_RECEIVE_DONE                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMMATX]
#define USE_RT_DEBUG_MAC_TX_DONE                              (1)
#define GPIO_DEBUG_MAC_TX_DONE                                {${MATX_PORT}, ${MATX_PIN}}
[#else]
#define USE_RT_DEBUG_MAC_TX_DONE                              (0)
#define GPIO_DEBUG_MAC_TX_DONE                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMAPCS]
#define USE_RT_DEBUG_RADIO_APPLY_CSMA                         (1)
#define GPIO_DEBUG_RADIO_APPLY_CSMA                           {${APCS_PORT}, ${APCS_PIN}}
[#else]
#define USE_RT_DEBUG_RADIO_APPLY_CSMA                         (0)
#define GPIO_DEBUG_RADIO_APPLY_CSMA                           {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRATM]
#define USE_RT_DEBUG_RADIO_TRANSMIT                           (1)
#define GPIO_DEBUG_RADIO_TRANSMIT                             {${RATM_PORT}, ${RATM_PIN}}
[#else]
#define USE_RT_DEBUG_RADIO_TRANSMIT                           (0)
#define GPIO_DEBUG_RADIO_TRANSMIT                             {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMPRTX]
#define USE_RT_DEBUG_PROC_RADIO_TX                            (1)
#define GPIO_DEBUG_PROC_RADIO_TX                              {${PRTX_PORT}, ${PRTX_PIN}}
[#else]
#define USE_RT_DEBUG_PROC_RADIO_TX                            (0)
#define GPIO_DEBUG_PROC_RADIO_TX                              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRATD]
#define USE_RT_DEBUG_RAL_TX_DONE                              (1)
#define GPIO_DEBUG_RAL_TX_DONE                                {${RATD_PORT}, ${RATD_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_TX_DONE                              (0)
#define GPIO_DEBUG_RAL_TX_DONE                                {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAIB]
#define USE_RT_DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT      (1)
#define GPIO_DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT        {${RAIB_PORT}, ${RAIB_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT      (0)
#define GPIO_DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT        {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRARB]
#define USE_RT_DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT            (1)
#define GPIO_DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT              {${RARB_PORT}, ${RARB_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT            (0)
#define GPIO_DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT              {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRACR]
#define USE_RT_DEBUG_RAL_CONTINUE_RX                          (1)
#define GPIO_DEBUG_RAL_CONTINUE_RX                            {${RACR_PORT}, ${RACR_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_CONTINUE_RX                          (0)
#define GPIO_DEBUG_RAL_CONTINUE_RX                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAPC]
#define USE_RT_DEBUG_RAL_PERFORM_CCA                          (1)
#define GPIO_DEBUG_RAL_PERFORM_CCA                            {${RAPC_PORT}, ${RAPC_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_PERFORM_CCA                          (0)
#define GPIO_DEBUG_RAL_PERFORM_CCA                            {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMRAET]
#define USE_RT_DEBUG_RAL_ENABLE_TRANSMITTER                   (1)
#define GPIO_DEBUG_RAL_ENABLE_TRANSMITTER                     {${RAET_PORT}, ${RAET_PIN}}
[#else]
#define USE_RT_DEBUG_RAL_ENABLE_TRANSMITTER                   (0)
#define GPIO_DEBUG_RAL_ENABLE_TRANSMITTER                     {GPIOA, GPIO_PIN_0}
[/#if]

[#if useSCMLLG2]
#define USE_RT_DEBUG_LLHWC_GET_CH_IDX_ALGO_2                  (1)
#define GPIO_DEBUG_LLHWC_GET_CH_IDX_ALGO_2                    {${LLG2_PORT}, ${LLG2_PIN}}
[#else]
#define USE_RT_DEBUG_LLHWC_GET_CH_IDX_ALGO_2                  (0)
#define GPIO_DEBUG_LLHWC_GET_CH_IDX_ALGO_2                    {GPIOA, GPIO_PIN_0}
[/#if]

[#else]

/* System clock manager - System clock config */
#define USE_RT_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                  (0)
#define GPIO_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                    {GPIOA, GPIO_PIN_12}

/* System clock manager - Setup */
#define USE_RT_DEBUG_SCM_SETUP                                (0)
#define GPIO_DEBUG_SCM_SETUP                                  {GPIOA, GPIO_PIN_5}

/* System clock manager - HSE RDY interrupt handling */
#define USE_RT_DEBUG_SCM_HSERDY_ISR                           (0)
#define GPIO_DEBUG_SCM_HSERDY_ISR                             {GPIOA, GPIO_PIN_15}

#define USE_RT_DEBUG_ADC_ACTIVATION                           (0)
#define GPIO_DEBUG_ADC_ACTIVATION                             {GPIOB, GPIO_PIN_4}

#define USE_RT_DEBUG_ADC_DEACTIVATION                         (0)
#define GPIO_DEBUG_ADC_DEACTIVATION                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADC_TEMPERATURE_ACQUISITION              (0)
#define GPIO_DEBUG_ADC_TEMPERATURE_ACQUISITION                {GPIOB, GPIO_PIN_8}

#define USE_RT_DEBUG_RNG_ENABLE                               (0)
#define GPIO_DEBUG_RNG_ENABLE                                 {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RNG_DISABLE                              (0)
#define GPIO_DEBUG_RNG_DISABLE                                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RNG_GEN_RAND_NUM                         (0)
#define GPIO_DEBUG_RNG_GEN_RAND_NUM                           {GPIOB, GPIO_PIN_12}

#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ENTER                (0)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_ENTER                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_EXIT                 (0)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_EXIT                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ACTIVE               (0)
#define GPIO_DEBUG_LOW_POWER_STOP_MODE_ACTIVE                 {GPIOB, GPIO_PIN_3}

#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_ENTER               (0)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_ENTER                 {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_EXIT                (0)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_EXIT                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STOP2_MODE_ACTIVE              (0)
#define GPIO_DEBUG_LOW_POWER_STOP2_MODE_ACTIVE                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ENTER             (0)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_ENTER               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_EXIT              (0)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_EXIT                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE            (0)
#define GPIO_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE              {GPIOB, GPIO_PIN_15}

#define USE_RT_DEBUG_HCI_READ_DONE                            (0)
#define GPIO_DEBUG_HCI_READ_DONE                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_HCI_RCVD_CMD                             (0)
#define GPIO_DEBUG_HCI_RCVD_CMD                               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_HCI_WRITE_DONE                           (0)
#define GPIO_DEBUG_HCI_WRITE_DONE                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_EVNT_UPDATE                       (0)
#define GPIO_DEBUG_SCHDLR_EVNT_UPDATE                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_TIMER_SET                         (0)
#define GPIO_DEBUG_SCHDLR_TIMER_SET                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_PHY_CLBR_TIMER                    (0)
#define GPIO_DEBUG_SCHDLR_PHY_CLBR_TIMER                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_EVNT_SKIPPED                      (0)
#define GPIO_DEBUG_SCHDLR_EVNT_SKIPPED                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE                    (0)
#define GPIO_DEBUG_SCHDLR_HNDL_NXT_TRACE                      {GPIOA, GPIO_PIN_12}

#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED              (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_DETEDTED                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK             (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_GAP_CHECK               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK            (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_TIME_CHECK              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ACTIVE_SCHDLR_NEAR_TRACE                 (0)
#define GPIO_DEBUG_ACTIVE_SCHDLR_NEAR_TRACE                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_EVNT_RGSTR                        (0)
#define GPIO_DEBUG_SCHDLR_EVNT_RGSTR                          {GPIOB, GPIO_PIN_8}

#define USE_RT_DEBUG_SCHDLR_ADD_CONFLICT_Q                    (0)
#define GPIO_DEBUG_SCHDLR_ADD_CONFLICT_Q                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_HNDL_MISSED_EVNT                  (0)
#define GPIO_DEBUG_SCHDLR_HNDL_MISSED_EVNT                    {GPIOA, GPIO_PIN_5}

#define USE_RT_DEBUG_SCHDLR_UNRGSTR_EVNT                      (0)
#define GPIO_DEBUG_SCHDLR_UNRGSTR_EVNT                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE                   (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_TRACE                     {GPIOA, GPIO_PIN_15}

#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_PROFILE                 (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_PROFILE                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_ERROR                   (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_ERROR                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING         (0)
#define GPIO_DEBUG_SCHDLR_EXEC_EVNT_WINDOW_WIDENING           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_CMN_CLR_ISR                        (0)
#define GPIO_DEBUG_LLHWC_CMN_CLR_ISR                          {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLWCC_CMN_HG_ISR                         (0)
#define GPIO_DEBUG_LLWCC_CMN_HG_ISR                           {GPIOA, GPIO_PIN_15}

#define USE_RT_DEBUG_LLHWC_CMN_LW_ISR                         (0)
#define GPIO_DEBUG_LLHWC_CMN_LW_ISR                           {GPIOA, GPIO_PIN_12}

#define USE_RT_DEBUG_LLHWC_CMN_CLR_TIMER_ERROR                (0)
#define GPIO_DEBUG_LLHWC_CMN_CLR_TIMER_ERROR                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_LL_ISR                             (0)
#define GPIO_DEBUG_LLHWC_LL_ISR                               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_SPLTMR_SET                         (0)
#define GPIO_DEBUG_LLHWC_SPLTMR_SET                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_SPLTMR_GET                         (0)
#define GPIO_DEBUG_LLHWC_SPLTMR_GET                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_LOW_ISR                            (0)
#define GPIO_DEBUG_LLHWC_LOW_ISR                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_STOP_SCN                           (0)
#define GPIO_DEBUG_LLHWC_STOP_SCN                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_WAIT_ENVT_ON_AIR                   (0)
#define GPIO_DEBUG_LLHWC_WAIT_ENVT_ON_AIR                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_SET_CONN_EVNT_PARAM                (0)
#define GPIO_DEBUG_LLHWC_SET_CONN_EVNT_PARAM                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_POST_EVNT                                (0)
#define GPIO_DEBUG_POST_EVNT                                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_HNDL_ALL_EVNTS                           (0)
#define GPIO_DEBUG_HNDL_ALL_EVNTS                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PROCESS_EVNT                             (0)
#define GPIO_DEBUG_PROCESS_EVNT                               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PROCESS_ISO_DATA                         (0)
#define GPIO_DEBUG_PROCESS_ISO_DATA                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ALLOC_TX_ISO_EMPTY_PKT                   (0)
#define GPIO_DEBUG_ALLOC_TX_ISO_EMPTY_PKT                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIG_FREE_EMPTY_PKTS                      (0)
#define GPIO_DEBUG_BIG_FREE_EMPTY_PKTS                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_OK                 (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_OK                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_CRC                (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_CRC                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_NoRX               (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_NoRX                 {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RECOMBINE_UNFRMD_DATA_TRACE              (0)
#define GPIO_DEBUG_RECOMBINE_UNFRMD_DATA_TRACE                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISO_HNDL_SDU                             (0)
#define GPIO_DEBUG_ISO_HNDL_SDU                               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LL_INTF_INIT                             (0)
#define GPIO_DEBUG_LL_INTF_INIT                               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_DATA_TO_CNTRLR                           (0)
#define GPIO_DEBUG_DATA_TO_CNTRLR                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_FREE_LL_PKT_HNDLR                        (0)
#define GPIO_DEBUG_FREE_LL_PKT_HNDLR                          {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PHY_INIT_CLBR_TRACE                      (0)
#define GPIO_DEBUG_PHY_INIT_CLBR_TRACE                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PHY_RUNTIME_CLBR_TRACE                   (0)
#define GPIO_DEBUG_PHY_RUNTIME_CLBR_TRACE                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PHY_CLBR_ISR                             (0)
#define GPIO_DEBUG_PHY_CLBR_ISR                               {GPIOB, GPIO_PIN_3}

#define USE_RT_DEBUG_PHY_INIT_CLBR_SINGLE_CH                  (0)
#define GPIO_DEBUG_PHY_INIT_CLBR_SINGLE_CH                    {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PHY_CLBR_STRTD                           (0)
#define GPIO_DEBUG_PHY_CLBR_STRTD                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PHY_CLBR_EXEC                            (0)
#define GPIO_DEBUG_PHY_CLBR_EXEC                              {GPIOB, GPIO_PIN_4}

#define USE_RT_DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV          (0)
#define GPIO_DEBUG_RCO_STRT_STOP_RUNTIME_CLBR_ACTV            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR           (0)
#define GPIO_DEBUG_RCO_STRT_STOP_RUNTIME_RCO_CLBR             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT           (0)
#define GPIO_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_SWT             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE         (0)
#define GPIO_DEBUG_STRT_STOP_RUNTIME_RCO_CLBR_TRACE           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RCO_ISR_TRACE                            (0)
#define GPIO_DEBUG_RCO_ISR_TRACE                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RCO_ISR_COMPENDATE                       (0)
#define GPIO_DEBUG_RCO_ISR_COMPENDATE                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_STRT_TX                              (0)
#define GPIO_DEBUG_RAL_STRT_TX                                {GPIOA, GPIO_PIN_5}

#define USE_RT_DEBUG_RAL_ISR_TIMER_ERROR                      (0)
#define GPIO_DEBUG_RAL_ISR_TIMER_ERROR                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_ISR_TRACE                            (0)
#define GPIO_DEBUG_RAL_ISR_TRACE                              {GPIOB, GPIO_PIN_3}

#define USE_RT_DEBUG_RAL_STOP_OPRTN                           (0)
#define GPIO_DEBUG_RAL_STOP_OPRTN                             {GPIOB, GPIO_PIN_8}

#define USE_RT_DEBUG_RAL_STRT_RX                              (0)
#define GPIO_DEBUG_RAL_STRT_RX                                {GPIOB, GPIO_PIN_12}

#define USE_RT_DEBUG_RAL_DONE_CLBK_TX                         (0)
#define GPIO_DEBUG_RAL_DONE_CLBK_TX                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_DONE_CLBK_RX                         (0)
#define GPIO_DEBUG_RAL_DONE_CLBK_RX                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_DONE_CLBK_ED                         (0)
#define GPIO_DEBUG_RAL_DONE_CLBK_ED                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_ED_SCAN                              (0)
#define GPIO_DEBUG_RAL_ED_SCAN                                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ERROR_MEM_CAP_EXCED                      (0)
#define GPIO_DEBUG_ERROR_MEM_CAP_EXCED                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ERROR_COMMAND_DISALLOWED                 (0)
#define GPIO_DEBUG_ERROR_COMMAND_DISALLOWED                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PTA_INIT                                 (0)
#define GPIO_DEBUG_PTA_INIT                                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PTA_EN                                   (0)
#define GPIO_DEBUG_PTA_EN                                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_PTA_SET_EN                         (0)
#define GPIO_DEBUG_LLHWC_PTA_SET_EN                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_PTA_SET_PARAMS                     (0)
#define GPIO_DEBUG_LLHWC_PTA_SET_PARAMS                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_COEX_STRT_ON_IDLE                        (0)
#define GPIO_DEBUG_COEX_STRT_ON_IDLE                          {GPIOB, GPIO_PIN_15}

#define USE_RT_DEBUG_COEX_ASK_FOR_AIR                         (0)
#define GPIO_DEBUG_COEX_ASK_FOR_AIR                           {GPIOB, GPIO_PIN_3}

#define USE_RT_DEBUG_COEX_TIMER_EVNT_CLBK                     (0)
#define GPIO_DEBUG_COEX_TIMER_EVNT_CLBK                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_COEX_STRT_ONE_SHOT                       (0)
#define GPIO_DEBUG_COEX_STRT_ONE_SHOT                         {GPIOA, GPIO_PIN_5}

#define USE_RT_DEBUG_COEX_FORCE_STOP_RX                       (0)
#define GPIO_DEBUG_COEX_FORCE_STOP_RX                         {GPIOB, GPIO_PIN_12}

#define USE_RT_DEBUG_LLHWC_ADV_DONE                           (0)
#define GPIO_DEBUG_LLHWC_ADV_DONE                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_SCN_DONE                           (0)
#define GPIO_DEBUG_LLHWC_SCN_DONE                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_INIT_DONE                          (0)
#define GPIO_DEBUG_LLHWC_INIT_DONE                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_CONN_DONE                          (0)
#define GPIO_DEBUG_LLHWC_CONN_DONE                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_CIG_DONE                           (0)
#define GPIO_DEBUG_LLHWC_CIG_DONE                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_BIG_DONE                           (0)
#define GPIO_DEBUG_LLHWC_BIG_DONE                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_OS_TMR_CREATE                            (0)
#define GPIO_DEBUG_OS_TMR_CREATE                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_TIMEOUT_CBK                      (0)
#define GPIO_DEBUG_ADV_EXT_TIMEOUT_CBK                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_SCN_DUR_CBK                      (0)
#define GPIO_DEBUG_ADV_EXT_SCN_DUR_CBK                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_SCN_PERIOD_CBK                   (0)
#define GPIO_DEBUG_ADV_EXT_SCN_PERIOD_CBK                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK             (0)
#define GPIO_DEBUG_ADV_EXT_PRDC_SCN_TIMEOUT_CBK               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK                 (0)
#define GPIO_DEBUG_BIS_SYNC_TIMEOUT_TMR_CBK                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIS_TERM_TMR_CBK                         (0)
#define GPIO_DEBUG_BIS_TERM_TMR_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIS_TST_MODE_CBK                         (0)
#define GPIO_DEBUG_BIS_TST_MODE_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIS_TST_MODE_TMR_CBK                     (0)
#define GPIO_DEBUG_BIS_TST_MODE_TMR_CBK                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISO_POST_TMR_CBK                         (0)
#define GPIO_DEBUG_ISO_POST_TMR_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISO_TST_MODE_TMR_CBK                     (0)
#define GPIO_DEBUG_ISO_TST_MODE_TMR_CBK                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_CONN_POST_TMR_CBK                        (0)
#define GPIO_DEBUG_CONN_POST_TMR_CBK                          {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_EVNT_SCHDLR_TMR_CBK                      (0)
#define GPIO_DEBUG_EVNT_SCHDLR_TMR_CBK                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_HCI_POST_TMR_CBK                         (0)
#define GPIO_DEBUG_HCI_POST_TMR_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLCP_POST_TMR_CBK                        (0)
#define GPIO_DEBUG_LLCP_POST_TMR_CBK                          {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_ENRGY_DETECT_CBK                   (0)
#define GPIO_DEBUG_LLHWC_ENRGY_DETECT_CBK                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PRVCY_POST_TMR_CBK                       (0)
#define GPIO_DEBUG_PRVCY_POST_TMR_CBK                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ANT_PRPR_TMR_CBK                         (0)
#define GPIO_DEBUG_ANT_PRPR_TMR_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK          (0)
#define GPIO_DEBUG_COEX_TMR_FRC_STOP_AIR_GRANT_CBK            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MLME_RX_EN_TMR_CBK                       (0)
#define GPIO_DEBUG_MLME_RX_EN_TMR_CBK                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MLME_GNRC_TMR_CBK                        (0)
#define GPIO_DEBUG_MLME_GNRC_TMR_CBK                          {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MIB_JOIN_LST_TMR_CBK                     (0)
#define GPIO_DEBUG_MIB_JOIN_LST_TMR_CBK                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MLME_PWR_PRES_TMR_CBK                    (0)
#define GPIO_DEBUG_MLME_PWR_PRES_TMR_CBK                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PRESISTENCE_TMR_CBK                      (0)
#define GPIO_DEBUG_PRESISTENCE_TMR_CBK                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK              (0)
#define GPIO_DEBUG_RADIO_PHY_PRDC_CLBK_TMR_CBK                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RADIO_CSMA_TMR_CBK                       (0)
#define GPIO_DEBUG_RADIO_CSMA_TMR_CBK                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RADIO_CSL_RCV_TMR_CBK                    (0)
#define GPIO_DEBUG_RADIO_CSL_RCV_TMR_CBK                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ED_TMR_CBK                               (0)
#define GPIO_DEBUG_ED_TMR_CBK                                 {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_DIO_EXT_TMR_CBK                          (0)
#define GPIO_DEBUG_DIO_EXT_TMR_CBK                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RCO_CLBR_TMR_CBK                         (0)
#define GPIO_DEBUG_RCO_CLBR_TMR_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_ADV_CBK                     (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_ADV_CBK                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_CBK                     (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_CBK                       {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK                 (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_ERR_CBK                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK                (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CBK                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK            (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_ERR_CBK              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIG_ADV_CBK                              (0)
#define GPIO_DEBUG_BIG_ADV_CBK                                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIG_ADV_ERR_CBK                          (0)
#define GPIO_DEBUG_BIG_ADV_ERR_CBK                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIG_SYNC_CBK                             (0)
#define GPIO_DEBUG_BIG_SYNC_CBK                               {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIG_SYNC_ERR_CBK                         (0)
#define GPIO_DEBUG_BIG_SYNC_ERR_CBK                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK           (0)
#define GPIO_DEBUG_ISO_CIS_PKT_TRNSM_RECEIVED_CBK             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISO_CIG_ERR_CBK                          (0)
#define GPIO_DEBUG_ISO_CIG_ERR_CBK                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK              (0)
#define GPIO_DEBUG_CONN_PKT_TRNSM_RECEIVED_CBK                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PRDC_CLBR_EXTRL_CBK                      (0)
#define GPIO_DEBUG_PRDC_CLBR_EXTRL_CBK                        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PTR_PRDC_ADV_SYNC_CBK                    (0)
#define GPIO_DEBUG_PTR_PRDC_ADV_SYNC_CBK                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_NCONN_SCN_CBK                            (0)
#define GPIO_DEBUG_NCONN_SCN_CBK                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_NCONN_ADV_CBK                            (0)
#define GPIO_DEBUG_NCONN_ADV_CBK                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_NCONN_INIT_CBK                           (0)
#define GPIO_DEBUG_NCONN_INIT_CBK                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ANT_RADIO_CMPLT_EVNT_CBK                 (0)
#define GPIO_DEBUG_ANT_RADIO_CMPLT_EVNT_CBK                   {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ANT_STACK_EVNT_CBK                       (0)
#define GPIO_DEBUG_ANT_STACK_EVNT_CBK                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK           (0)
#define GPIO_DEBUG_ADV_EXT_PROCESS_TMOUT_EVNT_CBK             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT                (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_DUR_EVNT                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT           (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_SCN_PERIODIC_EVNT             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT         (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_TMOUT_EVNT           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT         (0)
#define GPIO_DEBUG_ADV_EXT_MNGR_PRDC_SCN_CNCEL_EVNT           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIS_MNGR_BIG_TERM_CBK                    (0)
#define GPIO_DEBUG_BIS_MNGR_BIG_TERM_CBK                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_BIS_MNGR_SYNC_TMOUT_CBK                  (0)
#define GPIO_DEBUG_BIS_MNGR_SYNC_TMOUT_CBK                    {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISOAL_MNGR_SDU_GEN                       (0)
#define GPIO_DEBUG_ISOAL_MNGR_SDU_GEN                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK            (0)
#define GPIO_DEBUG_ISO_MNGR_CIS_PROCESS_EVNT_CBK              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK              (0)
#define GPIO_DEBUG_CONN_MNGR_PROCESS_EVNT_CLBK                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK            (0)
#define GPIO_DEBUG_CONN_MNGR_UPDT_CONN_PARAM_CBK              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT                (0)
#define GPIO_DEBUG_EVNT_SCHDLR_HW_EVNT_CMPLT                  {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_HCI_EVENT_HNDLR                          (0)
#define GPIO_DEBUG_HCI_EVENT_HNDLR                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MLME_TMRS_CBK                            (0)
#define GPIO_DEBUG_MLME_TMRS_CBK                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_DIRECT_TX_EVNT_CBK                       (0)
#define GPIO_DEBUG_DIRECT_TX_EVNT_CBK                         {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_INDIRECT_PKT_TOUR_CBK                    (0)
#define GPIO_DEBUG_INDIRECT_PKT_TOUR_CBK                      {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RADIO_CSMA_TMR                           (0)
#define GPIO_DEBUG_RADIO_CSMA_TMR                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK                     (0)
#define GPIO_DEBUG_RAL_SM_DONE_EVNT_CBK                       {GPIOB, GPIO_PIN_4}

#define USE_RT_DEBUG_ED_TMR_HNDL                              (0)
#define GPIO_DEBUG_ED_TMR_HNDL                                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_OS_TMR_EVNT_CBK                          (0)
#define GPIO_DEBUG_OS_TMR_EVNT_CBK                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME           (0)
#define GPIO_DEBUG_PROFILE_MARKER_PHY_WAKEUP_TIME             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PROFILE_END_DRIFT_TIME                   (0)
#define GPIO_DEBUG_PROFILE_END_DRIFT_TIME                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PROC_RADIO_RCV                           (0)
#define GPIO_DEBUG_PROC_RADIO_RCV                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_EVNT_TIME_UPDT                           (0)
#define GPIO_DEBUG_EVNT_TIME_UPDT                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MAC_RECEIVE_DONE                         (0)
#define GPIO_DEBUG_MAC_RECEIVE_DONE                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_MAC_TX_DONE                              (0)
#define GPIO_DEBUG_MAC_TX_DONE                                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RADIO_APPLY_CSMA                         (0)
#define GPIO_DEBUG_RADIO_APPLY_CSMA                           {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RADIO_TRANSMIT                           (0)
#define GPIO_DEBUG_RADIO_TRANSMIT                             {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_PROC_RADIO_TX                            (0)
#define GPIO_DEBUG_PROC_RADIO_TX                              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_TX_DONE                              (0)
#define GPIO_DEBUG_RAL_TX_DONE                                {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT      (0)
#define GPIO_DEBUG_RAL_TX_DONE_INCREMENT_BACKOFF_COUNT        {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT            (0)
#define GPIO_DEBUG_RAL_TX_DONE_RST_BACKOFF_COUNT              {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_CONTINUE_RX                          (0)
#define GPIO_DEBUG_RAL_CONTINUE_RX                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_PERFORM_CCA                          (0)
#define GPIO_DEBUG_RAL_PERFORM_CCA                            {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_RAL_ENABLE_TRANSMITTER                   (0)
#define GPIO_DEBUG_RAL_ENABLE_TRANSMITTER                     {GPIOA, GPIO_PIN_0}

#define USE_RT_DEBUG_LLHWC_GET_CH_IDX_ALGO_2                  (0)
#define GPIO_DEBUG_LLHWC_GET_CH_IDX_ALGO_2                    {GPIOA, GPIO_PIN_0}
[/#if]

/* Application signal selection and GPIO assignment.
   CAN BE MODIFIED BY USER */

#define USE_RT_DEBUG_APP_APPE_INIT                            (0)
#define GPIO_DEBUG_APP_APPE_INIT                              {GPIOA, GPIO_PIN_0}

/********************************/
/** Debug configuration setup **/
/*******************************/

/*
 *
 * Debug configuration for System purpose
 *
 */
#if (USE_RT_DEBUG_CONFIGURATION_SYSTEM == 1U)
/* SCM_SETUP activation */
#undef USE_RT_DEBUG_SCM_SETUP
#define USE_RT_DEBUG_SCM_SETUP                                (1U)

/* SCM_SYSTEM_CLOCK_CONFIG activation */
#undef USE_RT_DEBUG_SCM_SYSTEM_CLOCK_CONFIG
#define USE_RT_DEBUG_SCM_SYSTEM_CLOCK_CONFIG                  (1U)

/* SCM_HSERDY_ISR activation */
#undef USE_RT_DEBUG_SCM_HSERDY_ISR
#define USE_RT_DEBUG_SCM_HSERDY_ISR                           (1U)

/* LOW_POWER_STOP_MODE_ACTIVE activation */
#undef USE_RT_DEBUG_LOW_POWER_STOP_MODE_ACTIVE
#define USE_RT_DEBUG_LOW_POWER_STOP_MODE_ACTIVE               (1U)

/* ADC_ACTIVATION activation */
#undef USE_RT_DEBUG_ADC_ACTIVATION
#define USE_RT_DEBUG_ADC_ACTIVATION                           (1U)

/* ADC_TEMPERATURE_ACQUISITION activation */
#undef USE_RT_DEBUG_ADC_TEMPERATURE_ACQUISITION
#define USE_RT_DEBUG_ADC_TEMPERATURE_ACQUISITION              (1U)

/* RNG_GEN_RAND_NUM activation */
#undef USE_RT_DEBUG_RNG_GEN_RAND_NUM
#define USE_RT_DEBUG_RNG_GEN_RAND_NUM                         (1U)

/* LOW_POWER_STANDBY_MODE_ACTIVE activation */
#undef USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE
#define USE_RT_DEBUG_LOW_POWER_STANDBY_MODE_ACTIVE            (1U)

/*
 *
 * Debug configuration for BLE purpose
 *
 */
#elif (USE_RT_DEBUG_CONFIGURATION_BLE == 1U)

/* LLHWC_CMN_LW_ISR activation */
#undef USE_RT_DEBUG_LLHWC_CMN_LW_ISR
#define USE_RT_DEBUG_LLHWC_CMN_LW_ISR                         (1U)

/* LLHWC_CMN_HG_ISR activation */
#undef USE_RT_DEBUG_LLWCC_CMN_HG_ISR
#define USE_RT_DEBUG_LLWCC_CMN_HG_ISR                         (1U)

/* PHY_CLBR_EXEC activation */
#undef USE_RT_DEBUG_PHY_CLBR_EXEC
#define USE_RT_DEBUG_PHY_CLBR_EXEC                            (1U)

/* SCHDLR_EVNT_RGSTR activation */
#undef USE_RT_DEBUG_SCHDLR_EVNT_RGSTR
#define USE_RT_DEBUG_SCHDLR_EVNT_RGSTR                        (1U)

/* SCHDLR_HNDL_MISSED_EVNT activation */
#undef USE_RT_DEBUG_SCHDLR_HNDL_MISSED_EVNT
#define USE_RT_DEBUG_SCHDLR_HNDL_MISSED_EVNT                  (1U)

/* SCHDLR_HNDL_NXT_TRACE activation */
#undef USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE
#define USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE                    (1U)

/* SCHDLR_EXEC_EVNT_TRACE activation */
#undef USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE                   (1U)

/* PHY_CLBR_ISR activation */
#undef USE_RT_DEBUG_PHY_CLBR_ISR
#define USE_RT_DEBUG_PHY_CLBR_ISR                             (1U)

/*
 *
 * Debug configuration for MAC purpose
 *
 */
#elif (USE_RT_DEBUG_CONFIGURATION_MAC == 1U)

/* LLHWC_CMN_LW_ISR activation */
#undef USE_RT_DEBUG_LLHWC_CMN_LW_ISR
#define USE_RT_DEBUG_LLHWC_CMN_LW_ISR                         (1U)

/* LLHWC_CMN_HG_ISR activation */
#undef USE_RT_DEBUG_LLWCC_CMN_HG_ISR
#define USE_RT_DEBUG_LLWCC_CMN_HG_ISR                         (1U)

/* RAL_ISR_TRACE activation */
#undef USE_RT_DEBUG_RAL_ISR_TRACE
#define USE_RT_DEBUG_RAL_ISR_TRACE                            (1U)

/* RAL_SM_DONE_EVNT_CBK activation */
#undef USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK
#define USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK                     (1U)

/* RAL_STOP_OPRTN activation */
#undef USE_RT_DEBUG_RAL_STOP_OPRTN
#define USE_RT_DEBUG_RAL_STOP_OPRTN                           (1U)

/* RAL_STRT_RX activation */
#undef USE_RT_DEBUG_RAL_STRT_RX
#define USE_RT_DEBUG_RAL_STRT_RX                              (1U)

/* RAL_STRT_TX activation */
#undef USE_RT_DEBUG_RAL_STRT_TX
#define USE_RT_DEBUG_RAL_STRT_TX                              (1U)

/*
 *
 * Debug configuration for COEX purpose
 *
 */
#elif (USE_RT_DEBUG_CONFIGURATION_COEX == 1U)

/* COEX_ASK_FOR_AIR activation */
#undef USE_RT_DEBUG_COEX_ASK_FOR_AIR
#define USE_RT_DEBUG_COEX_ASK_FOR_AIR                         (1U)

/* COEX_FORCE_STOP_RX activation */
#undef USE_RT_DEBUG_COEX_FORCE_STOP_RX
#define USE_RT_DEBUG_COEX_FORCE_STOP_RX                       (1U)

/* COEX_STRT_ON_IDLE activation */
#undef USE_RT_DEBUG_COEX_STRT_ON_IDLE
#define USE_RT_DEBUG_COEX_STRT_ON_IDLE                        (1U)

/* COEX_STRT_ONE_SHOT activation */
#undef USE_RT_DEBUG_COEX_STRT_ONE_SHOT
#define USE_RT_DEBUG_COEX_STRT_ONE_SHOT                       (1U)

/* SCHDLR_HNDL_NXT_TRACE activation */
#undef USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE
#define USE_RT_DEBUG_SCHDLR_HNDL_NXT_TRACE                    (1U)

/* SCHDLR_EXEC_EVNT_TRACE activation */
#undef USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE
#define USE_RT_DEBUG_SCHDLR_EXEC_EVNT_TRACE                   (1U)

/* RAL_SM_DONE_EVNT_CBK activation */
#undef USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK
#define USE_RT_DEBUG_RAL_SM_DONE_EVNT_CBK                     (1U)

/* RAL_STOP_OPRTN activation */
#undef USE_RT_DEBUG_RAL_STOP_OPRTN
#define USE_RT_DEBUG_RAL_STOP_OPRTN                           (1U)

#else
/* Nothing to do */
#endif /* (USE_RT_DEBUG_CONFIGURATION_COEX == 1U) */

#endif /* CFG_RT_DEBUG_GPIO_MODULE */

/******************************************************************/
/** Association table between general debug signal and used gpio **/
/******************************************************************/

#include "debug_signals.h"

#if (CFG_RT_DEBUG_GPIO_MODULE == 1)

#include "stm32wbaxx_hal.h"

typedef struct {
  GPIO_TypeDef* GPIO_port;
  uint16_t GPIO_pin;
} st_gpio_debug_t;

extern const st_gpio_debug_t general_debug_table[RT_DEBUG_SIGNALS_TOTAL_NUM];

#endif /* CFG_RT_DEBUG_GPIO_MODULE */

#ifdef __cplusplus
}
#endif

#endif /* DEBUG_CONFIG_H */
