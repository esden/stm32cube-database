[#ftl]
[#assign activeCluster_GP = []]
[#assign allHashParamsPerCluster_GP = {}][#-- Hash to catch all Params used in some Alloc functions --]
[#assign seqPrintedCluster_GP = []]
[#assign userCodeIndex_GP = 0]
[#assign allHashEndpoint_GP = {}]
[#assign zigbeeGenericParamHash_GP = {}][#-- Hash to register all generic param --]
[#assign allHashCluster_GP = {}]           [#-- Hash to register all cluster in used --]
[#assign allHashCallBacks_GP = {}]         [#-- Hash to register all CallBacks in used --]
[#assign allSortedHashCallBacks_GP = {}]         [#-- Hash to register all CallBacks sorted in used --]
[#assign headerFiles_GP = ["zcl/zcl.h"]]   [#-- Sequence to catch all header files --]
[#-- Generates the cluster structure into the zigbee_app_info global structure.
     It is called at the definition of the zigbee_app_info structure.
     @clusterParam the cluster argument defined in the Config file
     @endpoint the associated Endpoint number --]
[#macro generateZgbClusterDefinition cluster]
    [#assign endpoint  = allHashCluster_GP[cluster]["epNb"]]
    [#assign clusterName = allHashCluster_GP[cluster]["key1clusterName"]]
    [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]]
    [#if clusterValue?contains("CLIENT")]
        [#lt]  struct ZbZclClusterT *${clusterName}_client_${endpoint};
    [/#if]
    [#if clusterValue?contains("SERVER") && (clusterName != "basic")]
        [#if clusterName == "diagnostics"]
            [#lt]  bool ${clusterName}_server_${endpoint};
        [#else]
            [#lt]  struct ZbZclClusterT *${clusterName}_server_${endpoint};
        [/#if]
    [/#if]
[/#macro]
            
[#macro generateZgbCallbacks cluster step]
    [#--lt] //----------- generateZgbCallbacks ${allHashCluster_GP[cluster]["key1clusterName"]}  --]
    [#-- Cluster Keys : 
    "epNb":endpointNb, 
    "clusterValue":configParameter.value, 
    "key0clusterHeaderFile": clusterHeaderFile,
    "key1clusterName": clusterName,
    "key2clusterNameForCBName": clusterNameForCBName,
    "key3masterCbTypeName": masterCbTypeName, 
    "key4masterCbName": masterCbName,
    "key5allocNameFunction": allocNameFunction,
    "key6allocSpecificParamClient": allocSpecificParamClient,
    "key7allocSpecificParamServer": allocSpecificParamServer,
    "key8additionnalParameters": additionnalParameters}--]
    [#assign endpoint  = allHashCluster_GP[cluster]["epNb"]]
    [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]?split("_")]
    [#list clusterValue as seqElement]
        [#assign clusterRole =seqElement?lower_case]
        [#assign clusterName = allHashCluster_GP[cluster]["key1clusterName"]]
        [#assign clusterNameForCBName = allHashCluster_GP[cluster]["key2clusterNameForCBName"]]
        [#assign masterCbTypeName = allHashCluster_GP[cluster]["key3masterCbTypeName"]?replace("$ROLE",clusterRole?cap_first)?replace("$LOWERROLE",clusterRole)?replace("$ENDPOINT","" + endpoint)]
        [#assign masterCbName = allHashCluster_GP[cluster]["key4masterCbName"]?replace("$ROLE",clusterRole?cap_first)?replace("$ENDPOINT","" + endpoint)]
        [#-- Get elements of the callback master of the Cluster --]
        [#assign searchCBName = "CB_"+ clusterName?upper_case + "_" + clusterRole?upper_case] 
        [#-- Get elements of the CallBacks function activated --]
        [#assign cbToRegister = []]
        [#list allHashCallBacks_GP?keys as cbXMLArgumentName]
            [#if cbXMLArgumentName?contains(searchCBName) && cbXMLArgumentName?contains("" + endpoint)]
                [#assign cbToRegister = cbToRegister + [allHashCallBacks_GP[cbXMLArgumentName]]]
            [/#if]
        [/#list]

        [#if cbToRegister[0]??]
            [#if step == "declaration"]

                [#lt]/* ${clusterName?cap_first?replace("_", " ")} ${clusterRole} ${endpoint} custom callbacks */
            [/#if]
            [#assign allCallbackName = ""]
            [#list cbToRegister as activatedCallback]
                [#if activatedCallback??]
                    [#assign cbPointerName = activatedCallback["key0cbName"]]
                    [#if cbPointerName == ""][#assign cbName = ""][#else][#assign cbName = clusterNameForCBName + "_"+ clusterRole + "_" + endpoint + "_" + cbPointerName][/#if]
                    [#assign callbackDefStruct = activatedCallback["key1cbStruct"]]
                    [#assign callbackDefArg = activatedCallback["key2cbParams"]]
                    [#if callbackDefArg == "()"][#assign allCallbackNameToAdd = "$NULL" + cbPointerName][#else][#assign allCallbackNameToAdd = cbPointerName][/#if]
                    [#if allCallbackName != ""][#assign allCallbackName = allCallbackName +  ":" + allCallbackNameToAdd][#else][#assign allCallbackName = allCallbackNameToAdd][/#if]
                [/#if]
                [#if  cbName != "" && callbackDefArg != "()"]
                    [#if step == "declaration"]
                        [#lt]${callbackDefStruct} ${cbName}${callbackDefArg};
                    [#else]
                        [#lt]/* ${clusterName?cap_first?replace("_", " ")} ${clusterRole} ${cbPointerName} ${endpoint} command callback */
                        [#lt]${callbackDefStruct} ${cbName}${callbackDefArg}{
                        [#lt]  /* USER CODE BEGIN ${userCodeIndex_GP} ${clusterNameForCBName?cap_first} ${clusterRole} ${endpoint} ${cbPointerName} ${endpoint} */
                        [#lt][@generateCallbacksReturn callbackDefStruct/]
                        [#lt]  /* USER CODE END ${userCodeIndex_GP} ${clusterNameForCBName?cap_first} ${clusterRole} ${endpoint} ${cbPointerName} ${endpoint} */
                        [#assign userCodeIndex_GP = userCodeIndex_GP + 1]
                        [#lt]}

                    [/#if]
                [/#if]
            [/#list]
            [#if step == "declaration"]
                [#if  cbName != ""]  

                    [#lt]${masterCbTypeName} ${masterCbName} = {
                    [#--lt] //----------------------  generateZgbCallbacks : allCallbackName = ${allCallbackName} --]
                    [#if allCallbackName??]
                        [#list allCallbackName?split(":") as currentCallBackName]
                            [#if currentCallBackName?contains("$NULL")]
                                [#lt]  .${currentCallBackName?replace("$NULL","")} = NULL,
                            [#else][#assign allCallbackNameToAdd = cbPointerName]
                                [#assign cbName2 = clusterNameForCBName + "_" + clusterRole + "_" + endpoint + "_" + currentCallBackName]
                                [#lt]  .${currentCallBackName} = ${cbName2},
                            [/#if]
                        [/#list]
                    [/#if]  
                    [#lt]};
                [#else] 
                    [#lt]${masterCbTypeName} ${masterCbName};

                [/#if]
            [/#if]  
        [/#if]
    [/#list]
[/#macro]
                    
                    
[#-- 
    Generates the correct return for the definition of the callbacks depending of its return type.
    It is called in the generateZgbCallbacks macro when generating the definition of the callbacks.
    @typeReturn the type return of the callback
 --]
[#macro generateCallbacksReturn typeReturn]
    [#if typeReturn?contains("ZbZclTunnelStatusT")]
        [#lt]  return ZCL_TUNNEL_STATUS_SUCCESS;
    [#elseif typeReturn?contains("enum")]
        [#lt]  return ZCL_STATUS_SUCCESS;
    [#elseif typeReturn?contains("uint")]
        [#if typeReturn?contains("8")]
            [#lt]  return 01;
        [#else]
            [#lt]  return 0x1;
        [/#if]
    [#elseif typeReturn?contains("bool")]
        [#lt]  return true;
    [#elseif typeReturn?contains("void")]
        [#lt]  return;
    [/#if]
[/#macro]
    
 [#-- 
    
  --]      
[#macro setDefine]
[#list allHashParamsPerCluster_GP?keys as defineParam]
    [#--lt]// defineParam ${defineParam} --]
    [#if defineParam?split("$")[1]??]
        [#assign endpoint = defineParam?split("$")[0]]
        [#assign clusterName = defineParam?split("$")[1]]
        [#if activeCluster_GP?seq_contains(clusterName)]
            [#lt]/* ${clusterName?cap_first} (endpoint ${endpoint}) specific defines ------------------------------------------------*/
            [#list allHashParamsPerCluster_GP[defineParam]?keys as defineName]
                [#assign defineValue = allHashParamsPerCluster_GP[defineParam][defineName]]
                [#lt]#define ${defineName}${endpoint}                      ${defineValue}
            [/#list]
            [#lt]/* USER CODE BEGIN ${clusterName?cap_first} (endpoint ${endpoint}) defines */
            [#lt]/* USER CODE END ${clusterName?cap_first} (endpoint ${endpoint}) defines */
        
        [/#if]
    [/#if]
[/#list]
[/#macro]
    
 [#-- 
    
  --]      
[#macro initZgbClusterAlloc cluster]
    [#--lt] //----------- initZgbClusterAlloc ${allHashCluster_GP[cluster]["key1clusterName"]}  --]
    [#-- Cluster Keys : 
    "epNb":endpointNb, 
    "clusterValue":configParameter.value, 
    "key0clusterHeaderFile": clusterHeaderFile,
    "key1clusterName": clusterName,
    "key2clusterNameForCBName": clusterNameForCBName,
    "key3masterCbTypeName": masterCbTypeName, 
    "key4masterCbName": masterCbName,
    "key5allocNameFunction": allocNameFunction,
    "key6allocSpecificParamClient": allocSpecificParamClient,
    "key7allocSpecificParamServer": allocSpecificParamServer,
    "key8additionnalParameters": additionnalParameters} --]
   
    [#assign endpoint  = "" + allHashCluster_GP[cluster]["epNb"]]
    [#assign profileId  = allHashEndpoint_GP[endpoint]["ProfID"]]
    [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]?split("_")]
    [#assign clusterName = allHashCluster_GP[cluster]["key1clusterName"]]
    [#assign clusterNameForCBName = allHashCluster_GP[cluster]["key2clusterNameForCBName"]]
    [#assign commentPrinted = "no"]
    [#if seqPrintedCluster_GP?seq_contains(endpoint)]
    [#else]
        [#assign seqPrintedCluster_GP = seqPrintedCluster_GP + [endpoint]]
        [#lt]  /* Endpoint: SW${endpoint}_ENDPOINT */
        [#lt]  req.profileId = ${profileId};
        [#lt]  req.deviceId = ${allHashEndpoint_GP[endpoint]["DevID"]};
        [#lt]  req.endpoint = SW${endpoint}_ENDPOINT;
        [#lt]  ZbZclAddEndpoint(zigbee_app_info.zb, &req, &conf);
        [#lt]  assert(conf.status == ZB_STATUS_SUCCESS);
        
    [/#if]
    [#list clusterValue as seqElement]
        [#assign clusterRole =seqElement?lower_case]
        [#assign masterCbTypeName = allHashCluster_GP[cluster]["key3masterCbTypeName"]?replace("$ROLE",clusterRole?cap_first)?replace("$LOWERROLE",clusterRole)?replace("$ENDPOINT",endpoint)]
        [#assign masterCbName = allHashCluster_GP[cluster]["key4masterCbName"]?replace("$ROLE",clusterRole?cap_first)?replace("$ENDPOINT",endpoint)]
        [#assign allocNameFunction = allHashCluster_GP[cluster]["key5allocNameFunction"]?replace("$ROLE",clusterRole?cap_first)?replace("$LOWERROLE",clusterRole)]
        [#assign allocSpecificParamClient = allHashCluster_GP[cluster]["key6allocSpecificParamClient"]?replace("$PROFILEID",profileId)?replace("$ENDPOINT",endpoint)]
        [#assign allocSpecificParamServer = allHashCluster_GP[cluster]["key7allocSpecificParamServer"]?replace("$PROFILEID",profileId)?replace("$ENDPOINT",endpoint)]
        [#assign additionnalParameters = allHashCluster_GP[cluster]["key8additionnalParameters"]?replace("$PROFILEID",profileId)?replace("$ENDPOINT",endpoint)?replace("$ROLE",clusterRole?cap_first)]
    
        [#-- Manage specific use cases --]     
        [#--lt] // ----------> ${clusterName} : ${clusterRole} : ${allocNameFunction} : ${allocSpecificParamClient} : ${allocSpecificParamServer} --]
        [#if allocNameFunction == ""][#break][/#if]
        [#if (clusterRole == "server" && allocSpecificParamServer != "") ||(clusterRole == "client" && allocSpecificParamClient != "")]
            [#if commentPrinted == "no"]
                [#lt]  /* ${clusterName?cap_first?replace("_", " ")} ${allHashCluster_GP[cluster]["clusterValue"]?lower_case?replace("_", "/")} */
                [#assign commentPrinted = "yes"]
            [/#if]
            [#if (clusterName == "colorControl") && (clusterRole == "server")]
                [#lt]  ${additionnalParameters?split("/")[0]} = {
                [#lt]    .callbacks = ${masterCbName},
                [#lt]    /* Please complete the other attributes according to your application:
                [#lt]     *          .capabilities           //uint8_t (e.g. ZCL_COLOR_CAP_HS)
                [#lt]     *          .enhanced_supported     //bool
                [#lt]     */
                [#lt]    /* USER CODE BEGIN Color Server Config (endpoint${endpoint}) */
                [#lt]    /* USER CODE END Color Server Config (endpoint${endpoint}) */
                [#lt]  };
            [#elseif clusterName == "otaUpgrade"]
                [#lt]  ${additionnalParameters?split("/")[0]}  = {
                [#lt]    .profile_id = ${profileId},
                [#lt]    .endpoint = SW${endpoint}_ENDPOINT,
                [#if clusterRole == "client"]
                    [#lt]    .callbacks = ${masterCbName},
                [/#if]
                [#lt]    /* Please complete the other attributes according to your application:
                [#if clusterRole == "server"]
                    [#lt]     *          .minimum_block_period           //uint16_t
                    [#lt]     *          .upgrade_end_current_time       //uint32_t
                    [#lt]     *          .upgrade_end_upgrade_time       //uint32_t
                    [#lt]     *          .image_eval                     //ZbZclOtaServerImageEvalT
                    [#lt]     *          .image_read                     //ZbZclOtaServerImageReadT
                    [#lt]     *          .image_upgrade_end_req          //ZbZclOtaServerUpgradeEndReqT
                    [#lt]     *          .arg                            //void *
                [#else]
                    [#lt]     *          .activation_policy      //enum ZbZclOtaActivationPolicy
                    [#lt]     *          .timeout_policy         //enum ZbZclOtaTimeoutPolicy
                    [#lt]     *          .image_block_delay      //uint32_t
                    [#lt]     *          .current_image          //struct ZbZclOtaHeader
                    [#lt]     *          .ca_pub_key_array       //const uint8_t *
                    [#lt]     *          .ca_pub_key_len         //unsigned int
                [/#if]
                [#lt]     */
                [#lt]    /* USER CODE BEGIN OTA ${clusterRole?cap_first} (endpoint${endpoint}) */
                [#lt]    /* USER CODE END OTA ${clusterRole?cap_first} (endpoint${endpoint}) */
                [#lt]  };
            [/#if]
            [#-- Write ALLOC functions --]       
            [#lt]  zigbee_app_info.${clusterName}_${clusterRole}_${endpoint} = ${allocNameFunction}[#if clusterRole == "server"]${allocSpecificParamServer}[#else]${allocSpecificParamClient}[/#if];
            [#lt]  assert(zigbee_app_info.${clusterName}_${clusterRole}_${endpoint} != NULL);
            [#if !((clusterName == "diagnostics") && (clusterRole == "server"))]
                [#lt]  ZbZclClusterEndpointRegister(zigbee_app_info.${clusterName}_${clusterRole}_${endpoint});
            [/#if]

        [/#if]
[/#list]             
[/#macro]
[#--lt]// begin read XML Parameters to initialize private structure to manipulatein the macros --]
[#-- 
      





  MAIN FUNCTION to read ALL parameters








--]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as configParameter]
            [#--lt]// one element begin "${configParameter.name}" : "${configParameter.value}" --]
            [#if configParameter.name?starts_with("ZCL_")]
                [#if configParameter.value != "NONE" && configParameter.value != "valueNotSetted"]
                    [#assign configParamElements = configParameter.comments?split(":")]
                    [#if configParamElements[0]??][#assign clusterHeaderFile = configParamElements[0]][#else][#assign clusterHeaderFile = ""][/#if]
                    [#if configParamElements[1]??][#assign clusterName = configParamElements[1]][#else][#assign clusterName = ""][/#if]
                    [#if configParamElements[2]??][#assign clusterNameForCBName = configParamElements[2]][#else][#assign clusterNameForCBName = ""][/#if]
                    [#if configParamElements[3]??][#assign masterCbTypeName = configParamElements[3]][#else][#assign masterCbTypeName = ""][/#if]
                    [#if configParamElements[4]??][#assign masterCbName = configParamElements[4]][#else][#assign masterCbName = ""][/#if]
                    [#if configParamElements[5]??][#assign allocNameFunction = configParamElements[5]][#else][#assign allocNameFunction = ""][/#if]
                    [#if configParamElements[6]??][#assign allocSpecificParamClient = configParamElements[6]][#else][#assign allocSpecificParamClient = ""][/#if]
                    [#if configParamElements[7]??][#assign allocSpecificParamServer = configParamElements[7]][#else][#assign allocSpecificParamServer = ""][/#if]
                    [#if configParamElements[8]??][#assign additionnalParameters = configParamElements[8]][#else][#assign additionnalParameters = ""][/#if]
                    [#--lt]// Add "${configParameter.name}" with value = ${configParameter.value}[#lt--]
                    [#assign endpointNb = configParameter.name?keep_after("ENDPOINT")?number]
                    [#assign curActiveCluster = {"epNb":endpointNb, "clusterValue":configParameter.value, "key0clusterHeaderFile": clusterHeaderFile,"key1clusterName": clusterName,"key2clusterNameForCBName": clusterNameForCBName,"key3masterCbTypeName": masterCbTypeName, "key4masterCbName": masterCbName,"key5allocNameFunction": allocNameFunction,"key6allocSpecificParamClient": allocSpecificParamClient,"key7allocSpecificParamServer": allocSpecificParamServer,"key8additionnalParameters": additionnalParameters}]
                    [#assign allHashCluster_GP = allHashCluster_GP + {configParameter.name: curActiveCluster}]
                    [#if configParameter.name?contains("BASIC")][#-- Update the headerfile sequence with the current header files --]
                        [#if  configParameter.value?contains("CLIENT")]
                            [#if headerFiles_GP?seq_index_of(clusterHeaderFile) < 0][#assign headerFiles_GP = headerFiles_GP + [clusterHeaderFile]][/#if]
                        [/#if]
                    [#else]
                        [#if headerFiles_GP?seq_index_of(clusterHeaderFile) < 0][#assign headerFiles_GP = headerFiles_GP + [clusterHeaderFile]][/#if]
                    [/#if]
                    [#assign activeCluster_GP = activeCluster_GP + [clusterName]]
                [/#if]
            [#elseif configParameter.name?starts_with("CB_")]
                [#if configParameter.value == "true"]
                    [#assign configParamElements = configParameter.comments?split(":")]
                    [#if configParamElements[0]??][#assign cbName = configParamElements[0]][#else][#assign cbName = ""][/#if]
                    [#if configParamElements[1]??][#assign cbStruct = configParamElements[1]][#else][#assign cbStruct = ""][/#if]
                    [#if configParamElements[2]??][#assign cbParams = configParamElements[2]][#else][#assign cbParams = ""][/#if]
                    [#assign activeCB = {"key0cbName":cbName,"key1cbStruct": cbStruct,"key2cbParams": cbParams }]
                    [#assign allHashCallBacks_GP = allHashCallBacks_GP + {configParameter.name: activeCB}]
                [/#if]
            [#elseif configParameter.name?starts_with("ZPARAM_")][#-- Register all parameters of cluster activated in allHashParamsPerCluster_GP with the name of the param and its value  --]
                [#if configParameter.value != "-1" && configParameter.value != "valueNotSetted" && configParameter.comments?split(":")[1]??]
                    [#assign endpointNb = configParameter.name?keep_after("ENDPOINT")]
                    [#assign key = endpointNb +"$"+ configParameter.comments?split(":")[0]]
                    [#if allHashParamsPerCluster_GP[key]??][#assign tmp = allHashParamsPerCluster_GP[key]][#else][#assign tmp = {}][/#if]
                    [#if configParameter.comments?split(":")[1] == "COMMISSIONING_DEST_ENDPOINT_" && configParameter.value == "255"][#-- Specific case to change 255 value by ZB_ENDPOINT_BCAST define --]
                        [#assign tmp = tmp + {configParameter.comments?split(":")[1] : "ZB_ENDPOINT_BCAST"}]
                    [#else]
                        [#assign tmp = tmp + {configParameter.comments?split(":")[1] : configParameter.value}]
                    [/#if]
                    [#assign allHashParamsPerCluster_GP = allHashParamsPerCluster_GP + {key : tmp}]
        
                [/#if]
            [#elseif configParameter.name?starts_with("ZGB_") || configParameter.name?ends_with("_DEVICE_ID") || configParameter.name?contains("_ID_ZGB")]
                [#assign zigbeeGenericParamHash_GP = zigbeeGenericParamHash_GP + {configParameter.name: configParameter.value}]
            [#elseif configParameter.name?ends_with("_DEVICE_ID") || configParameter.name?contains("_ID_ZGB") ]
                [#assign allHashEndpoint_GP = allHashEndpoint_GP + {configParameter.name: configParameter.value}]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#assign ZigBeeMode = zigbeeGenericParamHash_GP["ZGB_NW_MODE"]]
[#assign ZGB_APPLICATION = zigbeeGenericParamHash_GP["ZGB_APPLICATION"]]
[#assign ZGB_DEVICE_ROLE = zigbeeGenericParamHash_GP["ZGB_DEVICE_ROLE"]]
[#assign ZGB_TOUCHLINK_CAPABILITY = zigbeeGenericParamHash_GP["ZGB_TOUCHLINK_CAPABILITY"]]
[#assign ZGB_CHANNEL = zigbeeGenericParamHash_GP["ZGB_CHANNEL"]]
[#assign ZGB_SLEEPY_MODE = zigbeeGenericParamHash_GP["ZGB_SLEEPY_MODE"]]                    
[#-- Build the endpoint Array --]
[#assign numberOfEndpoint_GP = zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number]
[#list 1..numberOfEndpoint_GP as i]
    [#assign endpointHash = {"NbID": zigbeeGenericParamHash_GP["ENDPOINT"+i+"_ID_ZGB"]}]
    [#assign endpointHash = endpointHash + {"DevID": zigbeeGenericParamHash_GP["ENDPOINT"+i+"_DEVICE_ID"]}]
    [#assign endpointHash = endpointHash + {"ProfID": zigbeeGenericParamHash_GP["ZGB_ENDPOINT"+i+"_PROFILE_ID"]}]
    [#assign allHashEndpoint_GP = allHashEndpoint_GP + {i : endpointHash}]
[/#list]
[#--lt]// END readParameter --]  
        
[#-- Display lists for debug --]
[#--lt]// zigbeeGenericParamHash_GP
[#list zigbeeGenericParamHash_GP?keys as key]
    [#lt]// "${key}" -> ${zigbeeGenericParamHash_GP[key]}
[/#list]

[#lt]// allHashEndpoint_GP
[#list allHashEndpoint_GP?keys as currentEndPoint]
    [#list allHashEndpoint_GP[currentEndPoint]?keys as epParam]
        [#lt]// "${currentEndPoint}" -> ${epParam} : ${allHashEndpoint_GP[currentEndPoint][epParam]}      
    [/#list]
[/#list]

[#lt]// allHashCluster_GP
[#list allHashCluster_GP?keys as key]
    [#lt]// "${key}" .... 
[/#list]

[#lt]// allHashCallBacks_GP
[#list allHashCallBacks_GP?keys as cbXMLArgumentName]
    [#lt]// "${cbXMLArgumentName}" 
    [#list allHashCallBacks_GP[cbXMLArgumentName]?keys as key2]
        [#lt]// "${cbXMLArgumentName}" -> ${key2} : ${allHashCallBacks_GP[cbXMLArgumentName][key2]}   
    [/#list]
[/#list]
        
[#lt]// allHashParamsPerCluster_GP
[#list allHashParamsPerCluster_GP?keys as key]
    [#lt]// "${key}" -> 
    [#list allHashParamsPerCluster_GP[key]?keys as key2]
        [#lt]// "${key}" -> ${key2} : ${allHashParamsPerCluster_GP[key][key2]} 
    [/#list]
[/#list]

[#lt]// headerFiles_GP
[#list headerFiles_GP as key]
    [#lt]// "${key}" -> 
[/#list]

[#lt]// activeCluster_GP
[#list activeCluster_GP as key]
    [#lt]// "${key}" .... 
[/#list--]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Zigbee Application.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "app_entry.h"
#include "dbg_trace.h"
#include "app_zigbee.h"
#include "zigbee_interface.h"
#include "shci.h"
#include "stm_logging.h"
#include "app_conf.h"
#include "stm32wbxx_core_interface_def.h"
#include "zigbee_types.h"
#include "stm32_seq.h"
[#if ZGB_SLEEPY_MODE == "ON"]
#include "stm32_lpm.h"
[/#if]

/* Private includes -----------------------------------------------------------*/
[#lt]#include <assert.h>
[#list headerFiles_GP as file]
    [#lt]#include "${file}"
[/#list]

[#lt]/* USER CODE BEGIN Includes */
[#lt]/* USER CODE END Includes */

    [#lt]/* Private typedef -----------------------------------------------------------*/
    [#lt]/* USER CODE BEGIN PTD */
    [#lt]/* USER CODE END PTD */

    [#lt]/* Private defines -----------------------------------------------------------*/
    [#lt]#define APP_ZIGBEE_STARTUP_FAIL_DELAY               500U
[#if ZigBeeMode == "TOUCHLINK"]
    [#lt]#define TOUCHLINK_ENDPOINT                          200
    [#lt]#define APP_TOUCHLINK_MIN_RSSI                      -60
[#else]
    [#lt]#define CHANNEL                                     ${zigbeeGenericParamHash_GP["ZGB_CHANNEL"]}
[/#if]
[#if ZGB_DEVICE_ROLE == "END_DEVICE" || ZGB_APPLICATION == "RFD"]
    [#lt]#define ZED_SLEEP_TIME_30S                           1 /* 30s sleep time unit */
[/#if]
    
[#list allHashEndpoint_GP?keys as currentEndPoint]
    [#lt]#define SW${currentEndPoint}_ENDPOINT                                ${allHashEndpoint_GP[currentEndPoint]["NbID"]}[#lt]
[/#list]

[#lt][@setDefine/]
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */
/* USER CODE END PM */

/* External definition -------------------------------------------------------*/
enum ZbStatusCodeT ZbStartupWait(struct ZigBeeT *zb, struct ZbStartupT *config);

/* USER CODE BEGIN ED */
/* USER CODE END ED */

/* Private function prototypes -----------------------------------------------*/
static void APP_ZIGBEE_StackLayersInit(void);
static void APP_ZIGBEE_ConfigEndpoints(void);
static void APP_ZIGBEE_NwkForm(void);

static void APP_ZIGBEE_TraceError(const char *pMess, uint32_t ErrCode);
static void APP_ZIGBEE_CheckWirelessFirmwareInfo(void);

static void Wait_Getting_Ack_From_M0(void);
static void Receive_Ack_From_M0(void);
static void Receive_Notification_From_M0(void);

/* USER CODE BEGIN PFP */
/* USER CODE END PFP */

/* Private variables ---------------------------------------------------------*/
static TL_CmdPacket_t *p_ZIGBEE_otcmdbuffer;
static TL_EvtPacket_t *p_ZIGBEE_notif_M0_to_M4;
static TL_EvtPacket_t *p_ZIGBEE_request_M0_to_M4;
static __IO uint32_t CptReceiveNotifyFromM0 = 0;
static __IO uint32_t CptReceiveRequestFromM0 = 0;

PLACE_IN_SECTION("MB_MEM1") ALIGN(4) static TL_ZIGBEE_Config_t ZigbeeConfigBuffer;
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static TL_CmdPacket_t ZigbeeOtCmdBuffer;
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static uint8_t ZigbeeNotifRspEvtBuffer[sizeof(TL_PacketHeader_t) + TL_EVT_HDR_SIZE + 255U];
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static uint8_t ZigbeeNotifRequestBuffer[sizeof(TL_PacketHeader_t) + TL_EVT_HDR_SIZE + 255U];

struct zigbee_app_info {
  bool has_init;
  struct ZigBeeT *zb; 
  enum ZbStartType startupControl;
  enum ZbStatusCodeT join_status;
  uint32_t join_delay;
  bool init_after_join;

[#list allHashCluster_GP?keys as cluster]
    [@generateZgbClusterDefinition cluster/][#lt]
[/#list]
};
static struct zigbee_app_info zigbee_app_info;

[#list allHashCluster_GP?keys as cluster]
    [@generateZgbCallbacks cluster "declaration"/][#lt]
[/#list]

/* USER CODE BEGIN PV */
/* USER CODE END PV */
/* Functions Definition ------------------------------------------------------*/
[#list allHashCluster_GP?keys as cluster]
    [@generateZgbCallbacks cluster "definition"/][#lt]
[/#list]

/**
 * @brief  Zigbee application initialization
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_Init(void)
{
  SHCI_CmdStatus_t ZigbeeInitStatus;

  APP_DBG("APP_ZIGBEE_Init");

  /* Check the compatibility with the Coprocessor Wireless Firmware loaded */
  APP_ZIGBEE_CheckWirelessFirmwareInfo();

  /* Register cmdbuffer */
  APP_ZIGBEE_RegisterCmdBuffer(&ZigbeeOtCmdBuffer);

  /* Init config buffer and call TL_ZIGBEE_Init */
  APP_ZIGBEE_TL_INIT();

  /* Register task */
  /* Create the different tasks */

  UTIL_SEQ_RegTask(1U << (uint32_t)CFG_TASK_NOTIFY_FROM_M0_TO_M4, UTIL_SEQ_RFU, APP_ZIGBEE_ProcessNotifyM0ToM4);
  UTIL_SEQ_RegTask(1U << (uint32_t)CFG_TASK_REQUEST_FROM_M0_TO_M4, UTIL_SEQ_RFU, APP_ZIGBEE_ProcessRequestM0ToM4);

  /* Task associated with network creation process */
  UTIL_SEQ_RegTask(1U << CFG_TASK_ZIGBEE_NETWORK_FORM, UTIL_SEQ_RFU, APP_ZIGBEE_NwkForm);

  /* USER CODE BEGIN APP_ZIGBEE_INIT */
  /* USER CODE END APP_ZIGBEE_INIT */

  /* Start the Zigbee on the CPU2 side */
  ZigbeeInitStatus = SHCI_C2_ZIGBEE_Init();
  /* Prevent unused argument(s) compilation warning */
  UNUSED(ZigbeeInitStatus);

  /* Initialize Zigbee stack layers */
  APP_ZIGBEE_StackLayersInit();

} /* APP_ZIGBEE_Init */

/**
 * @brief  Initialize Zigbee stack layers
 * @param  None
 * @retval None
 */
static void APP_ZIGBEE_StackLayersInit(void)
{
  APP_DBG("APP_ZIGBEE_StackLayersInit");

  zigbee_app_info.zb = ZbInit(0U, NULL, NULL);
  assert(zigbee_app_info.zb != NULL);

  /* Create the endpoint and cluster(s) */
  APP_ZIGBEE_ConfigEndpoints();

  /* USER CODE BEGIN APP_ZIGBEE_StackLayersInit */
  /* USER CODE END APP_ZIGBEE_StackLayersInit */

  /* Configure the joining parameters */
  zigbee_app_info.join_status = (enum ZbStatusCodeT) 0x01; /* init to error status */
  zigbee_app_info.join_delay = HAL_GetTick(); /* now */
  [#if ZigBeeMode != "TOUCHLINK"]
        [#if ZGB_DEVICE_ROLE == "COORDINATOR" && ZigBeeMode == "CENTRALIZED"]
            [#lt]  zigbee_app_info.startupControl = ZbStartTypeForm;
        [#else]
            [#lt]  zigbee_app_info.startupControl = ZbStartTypeJoin;
        [/#if]
  [/#if]

  /* Initialization Complete */
  zigbee_app_info.has_init = true;

  /* run the task */
  UTIL_SEQ_SetTask(1U << CFG_TASK_ZIGBEE_NETWORK_FORM, CFG_SCH_PRIO_0);
} /* APP_ZIGBEE_StackLayersInit */

/**
 * @brief  Configure Zigbee application endpoints
 * @param  None
 * @retval None
 */
static void APP_ZIGBEE_ConfigEndpoints(void)
{
  struct ZbApsmeAddEndpointReqT req;
  struct ZbApsmeAddEndpointConfT conf;

  memset(&req, 0, sizeof(req));

[#list allHashCluster_GP?keys as cluster]
    [@initZgbClusterAlloc cluster/][#lt]
[/#list]  

  /* USER CODE BEGIN CONFIG_ENDPOINT */
  /* USER CODE END CONFIG_ENDPOINT */
} /* APP_ZIGBEE_ConfigEndpoints */

/**
 * @brief  Handle Zigbee network forming and joining
 * @param  None
 * @retval None
 */
static void APP_ZIGBEE_NwkForm(void)
{
  if ((zigbee_app_info.join_status != ZB_STATUS_SUCCESS) && (HAL_GetTick() >= zigbee_app_info.join_delay))
  {
    struct ZbStartupT config;
    enum ZbStatusCodeT status;

    /* Configure Zigbee Logging */
    ZbSetLogging(zigbee_app_info.zb, ZB_LOG_MASK_LEVEL_5, NULL);

    /* Attempt to join a zigbee network */
    ZbStartupConfigGetProDefaults(&config);

    /* Set the ${ZigBeeMode?lower_case} network */
    APP_DBG("Network config : APP_STARTUP_${ZigBeeMode}[#if ZigBeeMode == "CENTRALIZED"]_${ZGB_DEVICE_ROLE}[/#if]");
    [#if ZigBeeMode != "TOUCHLINK"]
    config.startupControl = zigbee_app_info.startupControl;
    [/#if]

    [#if ZigBeeMode == "DISTRIBUTED"]
    /* Set the TC address to be distributed. */
    config.security.trustCenterAddress = ZB_DISTRIBUTED_TC_ADDR;

    [/#if]
    [#if ZigBeeMode == "DISTRIBUTED" || ZigBeeMode == "TOUCHLINK"]
    /* Using the Uncertified Distributed Global Key (d0:d1:d2:d3:d4:d5:d6:d7:d8:d9:da:db:dc:dd:de:df) */
      [#if ZigBeeMode == "TOUCHLINK"]
    /* This key can be used as an APS Link Key between Touchlink devices.*/
      [/#if]
    memcpy(config.security.distributedGlobalKey, sec_key_distrib_uncert, ZB_SEC_KEYSIZE);

    [/#if]
    [#if ZigBeeMode == "TOUCHLINK"]
    /* Use the Touchlink Certification Key (c0:c1:c2:c3:c4:c5:c6:c7:c8:c9:ca:cb:cc:cd:ce:cf).
    * This key is "mashed" with the Touchlink session data to generate the Network Key */
    ZbBdbSet(zigbee_app_info.zb, ZB_BDB_TLKey, sec_key_touchlink_cert, ZB_SEC_KEYSIZE);

    /* Set the "Key Encryption Algorithm" to Certification */
    enum ZbBdbTouchlinkKeyIndexT keyIdx = TOUCHLINK_KEY_INDEX_CERTIFICATION;
    ZbBdbSet(zigbee_app_info.zb, ZB_BDB_TLKeyIndex, &keyIdx, sizeof(keyIdx));

    int8_t val8 = APP_TOUCHLINK_MIN_RSSI;
    ZbBdbSet(zigbee_app_info.zb, ZB_BDB_TLRssiMin, &val8, sizeof(val8));

    /* Touchlink uses the BDB Primary and Secondary channel masks, which we leave as defaults. */

    /* Configure the startup to use Touchlink */
    config.bdbCommissioningMode |= BDB_COMMISSION_MODE_TOUCHLINK;
    config.touchlink.tl_endpoint = TOUCHLINK_ENDPOINT;
    config.touchlink.bind_endpoint = SW1_ENDPOINT;
    config.touchlink.flags = [#if ZGB_DEVICE_ROLE == "TARGET"]ZCL_TL_FLAGS_IS_TARGET[#else]0x00[/#if];
    config.touchlink.zb_info = [#if ZGB_TOUCHLINK_CAPABILITY == "END_DEVICE"]ZCL_TL_ZBINFO_TYPE_END_DEVICE[#else]ZCL_TL_ZBINFO_TYPE_ROUTER[/#if];
    [#if ZGB_SLEEPY_MODE != "ON"]
    config.touchlink.zb_info |= ZCL_TL_ZBINFO_RX_ON_IDLE;
    [/#if]

    /* USER CODE BEGIN Touchlink */
    /* USER CODE END Touchlink */

    [/#if]
    [#if ZigBeeMode == "CENTRALIZED"]
    /* Using the default HA preconfigured Link Key */
    memcpy(config.security.preconfiguredLinkKey, sec_key_ha, ZB_SEC_KEYSIZE);

    [/#if]
    [#if ZigBeeMode != "TOUCHLINK"]
    config.channelList.count = 1;
    config.channelList.list[0].page = 0;
    config.channelList.list[0].channelMask = 1 << CHANNEL; /*Channel in use */

    [/#if]
    [#if ZGB_DEVICE_ROLE == "END_DEVICE" || (ZGB_APPLICATION == "RFD")]
    [#if  ZGB_DEVICE_ROLE == "END_DEVICE"]/* Add End device configuration */[#else]/* For Distributed and Touchlink network in RFD application, End device configuration has to be set */[/#if]
    config.capability &= ~(MCP_ASSOC_CAP_RXONIDLE | MCP_ASSOC_CAP_DEV_TYPE | MCP_ASSOC_CAP_ALT_COORD);
    config.endDeviceTimeout=ZED_SLEEP_TIME_30S;

    [/#if]
    /* Using ZbStartupWait (blocking) */
    status = ZbStartupWait(zigbee_app_info.zb, &config);

    APP_DBG("ZbStartup Callback (status = 0x%02x)", status);
    zigbee_app_info.join_status = status;

    if (status == ZB_STATUS_SUCCESS) {
    [#if ZGB_SLEEPY_MODE == "ON"]
      /* Enabling Stop mode */
      UTIL_LPM_SetStopMode(1U << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);

  [/#if]
      /* USER CODE BEGIN ${userCodeIndex_GP} */
      zigbee_app_info.join_delay = 0U;
    }
    else
    {
      /* USER CODE END ${userCodeIndex_GP} */
      [#assign userCodeIndex_GP = userCodeIndex_GP +1]
      [#if ZigBeeMode == "DISTRIBUTED" && ZGB_APPLICATION != "RFD"]
      zigbee_app_info.startupControl = ZbStartTypeForm;
      [/#if]
      APP_DBG("Startup failed, attempting again after a short delay (%d ms)", APP_ZIGBEE_STARTUP_FAIL_DELAY);
      zigbee_app_info.join_delay = HAL_GetTick() + APP_ZIGBEE_STARTUP_FAIL_DELAY;
    }
  }

  /* If Network forming/joining was not successful reschedule the current task to retry the process */
  if (zigbee_app_info.join_status != ZB_STATUS_SUCCESS)
  {
    UTIL_SEQ_SetTask(1U << CFG_TASK_ZIGBEE_NETWORK_FORM, CFG_SCH_PRIO_0);
  }

  /* USER CODE BEGIN NW_FORM */
  /* USER CODE END NW_FORM */
} /* APP_ZIGBEE_NwkForm */

/*************************************************************
 * ZbStartupWait Blocking Call
 *************************************************************/
struct ZbStartupWaitInfo {
  bool active;
  enum ZbStatusCodeT status;
};

static void ZbStartupWaitCb(enum ZbStatusCodeT status, void *cb_arg)
{
  struct ZbStartupWaitInfo *info = cb_arg;

  info->status = status;
  info->active = false;
  UTIL_SEQ_SetEvt(EVENT_ZIGBEE_STARTUP_ENDED);
} /* ZbStartupWaitCb */

enum ZbStatusCodeT ZbStartupWait(struct ZigBeeT *zb, struct ZbStartupT *config)
{
  struct ZbStartupWaitInfo *info;
  enum ZbStatusCodeT status;

  info = malloc(sizeof(struct ZbStartupWaitInfo));
  if (info == NULL) {
    return ZB_STATUS_ALLOC_FAIL;
  }
  memset(info, 0, sizeof(struct ZbStartupWaitInfo));

  info->active = true;
  status = ZbStartup(zb, config, ZbStartupWaitCb, info);
  if (status != ZB_STATUS_SUCCESS) {
    info->active = false;
    return status;
  }
  UTIL_SEQ_WaitEvt(EVENT_ZIGBEE_STARTUP_ENDED);
  status = info->status;
  free(info);
  return status;
} /* ZbStartupWait */

/**
 * @brief  Trace the error or the warning reported.
 * @param  ErrId :
 * @param  ErrCode
 * @retval None
 */
void APP_ZIGBEE_Error(uint32_t ErrId, uint32_t ErrCode)
{
  switch (ErrId) {
  default:
    APP_ZIGBEE_TraceError("ERROR Unknown ", 0);
    break;
  }
} /* APP_ZIGBEE_Error */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/

/**
 * @brief  Warn the user that an error has occurred.
 *
 * @param  pMess  : Message associated to the error.
 * @param  ErrCode: Error code associated to the module (Zigbee or other module if any)
 * @retval None
 */
static void APP_ZIGBEE_TraceError(const char *pMess, uint32_t ErrCode)
{
  APP_DBG("**** Fatal error = %s (Err = %d)", pMess, ErrCode);
  /* USER CODE BEGIN TRACE_ERROR */
  /* USER CODE END TRACE_ERROR */

} /* APP_ZIGBEE_TraceError */

/**
 * @brief Check if the Coprocessor Wireless Firmware loaded supports Zigbee
 *        and display associated information
 * @param  None
 * @retval None
 */
static void APP_ZIGBEE_CheckWirelessFirmwareInfo(void)
{
  WirelessFwInfo_t wireless_info_instance;
  WirelessFwInfo_t *p_wireless_info = &wireless_info_instance;

  if (SHCI_GetWirelessFwInfo(p_wireless_info) != SHCI_Success) {
    APP_ZIGBEE_Error((uint32_t)ERR_ZIGBEE_CHECK_WIRELESS, (uint32_t)ERR_INTERFACE_FATAL);
  }
  else {
    APP_DBG("**********************************************************");
    APP_DBG("WIRELESS COPROCESSOR FW:");
    /* Print version */
    APP_DBG("VERSION ID = %d.%d.%d", p_wireless_info->VersionMajor, p_wireless_info->VersionMinor, p_wireless_info->VersionSub);

    switch (p_wireless_info->StackType) {
    case INFO_STACK_TYPE_ZIGBEE_FFD:
      APP_DBG("FW Type : FFD Zigbee stack");
      break;
   case INFO_STACK_TYPE_ZIGBEE_RFD:
      APP_DBG("FW Type : RFD Zigbee stack");
      break;
    default:
      /* No Zigbee device supported ! */
      APP_ZIGBEE_Error((uint32_t)ERR_ZIGBEE_CHECK_WIRELESS, (uint32_t)ERR_INTERFACE_FATAL);
      break;
    }
    APP_DBG("**********************************************************");
  }
} /* APP_ZIGBEE_CheckWirelessFirmwareInfo */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/

void APP_ZIGBEE_RegisterCmdBuffer(TL_CmdPacket_t *p_buffer)
{
  p_ZIGBEE_otcmdbuffer = p_buffer;
} /* APP_ZIGBEE_RegisterCmdBuffer */

Zigbee_Cmd_Request_t * ZIGBEE_Get_OTCmdPayloadBuffer(void)
{
  return (Zigbee_Cmd_Request_t *)p_ZIGBEE_otcmdbuffer->cmdserial.cmd.payload;
} /* ZIGBEE_Get_OTCmdPayloadBuffer */

Zigbee_Cmd_Request_t * ZIGBEE_Get_OTCmdRspPayloadBuffer(void)
{
  return (Zigbee_Cmd_Request_t *)((TL_EvtPacket_t *)p_ZIGBEE_otcmdbuffer)->evtserial.evt.payload;
} /* ZIGBEE_Get_OTCmdRspPayloadBuffer */

Zigbee_Cmd_Request_t * ZIGBEE_Get_NotificationPayloadBuffer(void)
{
  return (Zigbee_Cmd_Request_t *)(p_ZIGBEE_notif_M0_to_M4)->evtserial.evt.payload;
} /* ZIGBEE_Get_NotificationPayloadBuffer */

Zigbee_Cmd_Request_t * ZIGBEE_Get_M0RequestPayloadBuffer(void)
{
  return (Zigbee_Cmd_Request_t *)(p_ZIGBEE_request_M0_to_M4)->evtserial.evt.payload;
}

/**
 * @brief  This function is used to transfer the commands from the M4 to the M0.
 *
 * @param   None
 * @return  None
 */
void ZIGBEE_CmdTransfer(void)
{
  Zigbee_Cmd_Request_t *cmd_req = (Zigbee_Cmd_Request_t *)p_ZIGBEE_otcmdbuffer->cmdserial.cmd.payload;

  /* Zigbee OT command cmdcode range 0x280 .. 0x3DF = 352 */
  p_ZIGBEE_otcmdbuffer->cmdserial.cmd.cmdcode = 0x280U;
  /* Size = otCmdBuffer->Size (Number of OT cmd arguments : 1 arg = 32bits so multiply by 4 to get size in bytes)
   * + ID (4 bytes) + Size (4 bytes) */
  p_ZIGBEE_otcmdbuffer->cmdserial.cmd.plen = 8U + (cmd_req->Size * 4U);

  TL_ZIGBEE_SendM4RequestToM0();

  /* Wait completion of cmd */
  Wait_Getting_Ack_From_M0();
} /* ZIGBEE_CmdTransfer */

/**
 * @brief  This function is called when the M0+ acknowledge the fact that it has received a Cmd
 *
 *
 * @param   Otbuffer : a pointer to TL_EvtPacket_t
 * @return  None
 */
void TL_ZIGBEE_CmdEvtReceived(TL_EvtPacket_t *Otbuffer)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(Otbuffer);

  Receive_Ack_From_M0();
} /* TL_ZIGBEE_CmdEvtReceived */

/**
 * @brief  This function is called when notification from M0+ is received.
 *
 * @param   Notbuffer : a pointer to TL_EvtPacket_t
 * @return  None
 */
void TL_ZIGBEE_NotReceived(TL_EvtPacket_t *Notbuffer)
{
  p_ZIGBEE_notif_M0_to_M4 = Notbuffer;

  Receive_Notification_From_M0();
} /* TL_ZIGBEE_NotReceived */

/**
 * @brief  This function is called before sending any ot command to the M0
 *         core. The purpose of this function is to be able to check if
 *         there are no notifications coming from the M0 core which are
 *         pending before sending a new ot command.
 * @param  None
 * @retval None
 */
void Pre_ZigbeeCmdProcessing(void)
{
  UTIL_SEQ_WaitEvt(EVENT_SYNCHRO_BYPASS_IDLE);
} /* Pre_ZigbeeCmdProcessing */

/**
 * @brief  This function waits for getting an acknowledgment from the M0.
 *
 * @param  None
 * @retval None
 */
static void Wait_Getting_Ack_From_M0(void)
{
  UTIL_SEQ_WaitEvt(EVENT_ACK_FROM_M0_EVT);
} /* Wait_Getting_Ack_From_M0 */

/**
 * @brief  Receive an acknowledgment from the M0+ core.
 *         Each command send by the M4 to the M0 are acknowledged.
 *         This function is called under interrupt.
 * @param  None
 * @retval None
 */
static void Receive_Ack_From_M0(void)
{
  UTIL_SEQ_SetEvt(EVENT_ACK_FROM_M0_EVT);
} /* Receive_Ack_From_M0 */

/**
 * @brief  Receive a notification from the M0+ through the IPCC.
 *         This function is called under interrupt.
 * @param  None
 * @retval None
 */
static void Receive_Notification_From_M0(void)
{
    CptReceiveNotifyFromM0++;
    UTIL_SEQ_SetTask(1U << (uint32_t)CFG_TASK_NOTIFY_FROM_M0_TO_M4, CFG_SCH_PRIO_0);
}

/**
 * @brief  This function is called when a request from M0+ is received.
 *
 * @param   Notbuffer : a pointer to TL_EvtPacket_t
 * @return  None
 */
void TL_ZIGBEE_M0RequestReceived(TL_EvtPacket_t *Reqbuffer)
{
    p_ZIGBEE_request_M0_to_M4 = Reqbuffer;

    CptReceiveRequestFromM0++;
    UTIL_SEQ_SetTask(1U << (uint32_t)CFG_TASK_REQUEST_FROM_M0_TO_M4, CFG_SCH_PRIO_0);
}

/**
 * @brief Perform initialization of TL for Zigbee.
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_TL_INIT(void)
{
    ZigbeeConfigBuffer.p_ZigbeeOtCmdRspBuffer = (uint8_t *)&ZigbeeOtCmdBuffer;
    ZigbeeConfigBuffer.p_ZigbeeNotAckBuffer = (uint8_t *)ZigbeeNotifRspEvtBuffer;
    ZigbeeConfigBuffer.p_ZigbeeNotifRequestBuffer = (uint8_t *)ZigbeeNotifRequestBuffer;
    TL_ZIGBEE_Init(&ZigbeeConfigBuffer);
}

/**
 * @brief Process the messages coming from the M0.
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_ProcessNotifyM0ToM4(void)
{
    if (CptReceiveNotifyFromM0 != 0) {
        /* If CptReceiveNotifyFromM0 is > 1. it means that we did not serve all the events from the radio */
        if (CptReceiveNotifyFromM0 > 1U) {
            APP_ZIGBEE_Error(ERR_REC_MULTI_MSG_FROM_M0, 0);
        }
        else {
            Zigbee_CallBackProcessing();
        }
        /* Reset counter */
        CptReceiveNotifyFromM0 = 0;
    }
}

/**
 * @brief Process the requests coming from the M0.
 * @param
 * @return
 */
void APP_ZIGBEE_ProcessRequestM0ToM4(void)
{
    if (CptReceiveRequestFromM0 != 0) {
        Zigbee_M0RequestProcessing();
        CptReceiveRequestFromM0 = 0;
    }
}
/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */
/* USER CODE END FD_LOCAL_FUNCTIONS */
