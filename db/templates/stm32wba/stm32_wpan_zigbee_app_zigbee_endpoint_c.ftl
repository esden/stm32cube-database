[#ftl]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]
[#assign activeCluster_GP = []]
[#assign nbActiveCluster_GP = 0]
[#assign allHashParamsPerCluster_GP = {}]  [#-- Hash to catch all Params used in some Alloc functions --]
[#assign seqPrintedCluster_GP = []]
[#assign userCodeIndex_GP = 0]
[#assign userListIndex_GP = 0]
[#assign userAlignPad = 43]                [#-- Default alignment of variables declaration --]
[#assign userDefineLength = 10]            [#-- Length if a #define --]
[#assign allHashEndpoint_GP = {}]
[#assign zigbeeGenericParamHash_GP = {}]   [#-- Hash to register all generic param --]
[#assign allHashCluster_GP = {}]           [#-- Hash to register all cluster in used --]
[#assign allHashCallBacks_GP = {}]         [#-- Hash to register all CallBacks in used --]
[#assign allSortedHashCallBacks_GP = {}]   [#-- Hash to register all CallBacks sorted in used --]
[#assign headerFiles_GP = ["zcl/zcl.h"]]   [#-- Sequence to catch all header files --]

[#--lt]// begin read XML Parameters to initialize private structure to manipulatein the macros --]
[#--  MAIN FUNCTION to read ALL parameters --]
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
                    [#if endpointNb != 0]
                        [#assign curActiveCluster = {"epNb":endpointNb, "clusterValue":configParameter.value, "key0clusterHeaderFile": clusterHeaderFile,"key1clusterName": clusterName,"key2clusterNameForCBName": clusterNameForCBName,"key3masterCbTypeName": masterCbTypeName, "key4masterCbName": masterCbName,"key5allocNameFunction": allocNameFunction,"key6allocSpecificParamClient": allocSpecificParamClient,"key7allocSpecificParamServer": allocSpecificParamServer,"key8additionnalParameters": additionnalParameters}]
                        [#assign allHashCluster_GP = allHashCluster_GP + {configParameter.name: curActiveCluster}]
                        [#if configParameter.name?contains("BASIC")]
                            [#-- Update the headerfile sequence with the current header files --]
                            [#if configParameter.value?contains("CLIENT")]
                                [#if headerFiles_GP?seq_index_of(clusterHeaderFile) < 0]
                                    [#assign headerFiles_GP = headerFiles_GP + [clusterHeaderFile]]
                                [/#if]
                                [#assign nbActiveCluster_GP = nbActiveCluster_GP + 1]
                            [/#if]
                        [#else]
                            [#if headerFiles_GP?seq_index_of(clusterHeaderFile) < 0]
                                [#assign headerFiles_GP = headerFiles_GP + [clusterHeaderFile]]
                            [/#if]
                            [#assign nbActiveCluster_GP = nbActiveCluster_GP + 1]
                        [/#if]
                        [#assign activeCluster_GP = activeCluster_GP + [clusterName]]
                    [/#if]
                [/#if]
            [#else]
                [#if configParameter.name?starts_with("CB_")]
                    [#if configParameter.value == "true"]
                        [#assign configParamElements = configParameter.comments?split(":")]
                        [#if configParamElements[0]??][#assign cbName = configParamElements[0]][#else][#assign cbName = ""][/#if]
                        [#if configParamElements[1]??][#assign cbStruct = configParamElements[1]][#else][#assign cbStruct = ""][/#if]
                        [#if configParamElements[2]??][#assign cbParams = configParamElements[2]][#else][#assign cbParams = ""][/#if]
                        [#assign activeCB = {"key0cbName":cbName,"key1cbStruct": cbStruct,"key2cbParams": cbParams }]
                        [#assign allHashCallBacks_GP = allHashCallBacks_GP + {configParameter.name: activeCB}]
                    [/#if]
                [#else]
                    [#if configParameter.name?starts_with("ZPARAM_")]
                        [#-- Register all parameters of cluster activated in allHashParamsPerCluster_GP with the name of the param and its value  --]
                        [#if configParameter.value != "-1" && configParameter.value != "valueNotSetted" && configParameter.comments?split(":")[1]??]
                            [#assign endpointNb = configParameter.name?keep_after("ENDPOINT")]
                            [#assign key = endpointNb +"$"+ configParameter.comments?split(":")[0]]
                            [#if allHashParamsPerCluster_GP[key]??]
                                [#assign tmp = allHashParamsPerCluster_GP[key]]
                            [#else]
                                [#assign tmp = {}]
                            [/#if]
                            [#if configParameter.comments?split(":")[1] == "COMMISSIONING_DEST_ENDPOINT_" && configParameter.value == "255"]
                                [#-- Specific case to change 255 value by ZB_ENDPOINT_BCAST define --]
                                [#assign tmp = tmp + {configParameter.comments?split(":")[1] : "ZB_ENDPOINT_BCAST"}]
                            [#else]
                                [#assign tmp = tmp + {configParameter.comments?split(":")[1] : configParameter.value}]
                            [/#if]
                            [#assign allHashParamsPerCluster_GP = allHashParamsPerCluster_GP + {key : tmp}]
                        [/#if]
                    [#else]
                        [#-- [#if configParameter.name?starts_with("ZGB_") || configParameter.name?ends_with("_DEVICE_ID") || configParameter.name?contains("_ID_ZGB")] --]
                        [#if configParameter.name?starts_with("ZGB_") || configParameter.name?contains("_ID_ZGB")]
                            [#assign zigbeeGenericParamHash_GP = zigbeeGenericParamHash_GP + {configParameter.name: configParameter.value}]
                        [#-- [#else]
                            [#if configParameter.name?ends_with("_DEVICE_ID") || configParameter.name?contains("_ID_ZGB") ]
                                [#assign allHashEndpoint_GP = allHashEndpoint_GP + {configParameter.name: configParameter.value}]
                            [/#if] --]
                        [/#if]
                    [/#if]
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#-- Generate Callback --]
[#macro generateZgbCallbacks cluster step]
    [#assign endpoint  = allHashCluster_GP[cluster]["epNb"]]
    [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
        [#assign endpointName  = ""]
        [#assign endpointNameCbk  = endpointName]
    [#else]
        [#assign endpointName  = endpoint?string ]
        [#assign endpointNameCbk  = "_" + endpointName]
    [/#if]
    [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]?split("_")]
    [#list clusterValue as seqElement]
        [#assign clusterRole =seqElement?lower_case]
        [#assign clusterNameForCBName = allHashCluster_GP[cluster]["key2clusterNameForCBName"]?cap_first ]
        [#assign masterCbTypeName = allHashCluster_GP[cluster]["key3masterCbTypeName"]?replace("$ROLE",clusterRole?cap_first)?replace("$LOWERROLE",clusterRole)?replace("$ENDPOINT","" + endpoint)]
        [#assign isAlone = "false" ]
        [#assign cbName = ""]

        [#-- Get elements of the callback master of the Cluster --]
        [#assign searchCBName = "CB_"+ clusterNameForCBName?upper_case + "_" + clusterRole?upper_case] 
        [#assign clusterRoleForCBName = clusterRole?cap_first ]
                
        [#-- Get elements of the CallBacks function activated --]
        [#assign cbToRegister = []]
        [#list allHashCallBacks_GP?keys as cbXMLArgumentName]
            [#if cbXMLArgumentName?contains(searchCBName) && cbXMLArgumentName?contains("" + endpoint)]
                [#assign cbToRegister = cbToRegister + [allHashCallBacks_GP[cbXMLArgumentName]]]
            [/#if]
        [/#list]

        [#if cbToRegister[0]??]
            [#if step == "declaration"]
                [#lt]/* ${clusterNameForCBName?cap_first} ${clusterRoleForCBName}${endpointName} Callbacks */
            [/#if]
            [#assign allCallbackName = ""]
            [#list cbToRegister as activatedCallback]
                [#if activatedCallback??]
                    [#assign cbPointerName = activatedCallback["key0cbName"]]
                    [#assign callbackDefStruct = activatedCallback["key1cbStruct"]]
                    [#assign callbackDefArg = activatedCallback["key2cbParams"]]
                    [#if (cbPointerName == "") && (callbackDefStruct == "") && (callbackDefArg == "") ]
                        [#assign cbName = ""]
                    [#else]
                        [#if cbPointerName == "" ]
                            [#assign isAlone = "true" ]
                        [/#if]
                        [#assign cbPtNameList = cbPointerName?split("_")]
                        [#assign cbFinalPointerName = ""]
                        [#list cbPtNameList as cbPtName]
                            [#assign cbFinalPointerName = cbFinalPointerName + cbPtName?cap_first ]
                        [/#list]
                        [#assign cbName = "APP_ZIGBEE_" + clusterNameForCBName + clusterRoleForCBName + cbFinalPointerName + "Callback" + endpointNameCbk]
                    [/#if]
                    [#assign callbackDefStruct = activatedCallback["key1cbStruct"]]
                    [#assign callbackDefArg = activatedCallback["key2cbParams"]]
                    [#if callbackDefArg == "()"]
                        [#assign allCallbackNameToAdd = "$NULL" + cbPointerName]
                    [#else]
                        [#assign allCallbackNameToAdd = cbPointerName]
                    [/#if]
                    [#if allCallbackName != ""]
                        [#assign allCallbackName = allCallbackName +  ":" + allCallbackNameToAdd]
                    [#else]
                        [#assign allCallbackName = allCallbackNameToAdd]
                    [/#if]
                [/#if]
                [#if  cbName != "" && callbackDefArg != "()"]
                    [#if step == "declaration"]
                        [#lt]${callbackDefStruct} ${cbName}${callbackDefArg};
                    [#else]
                        [#if callbackDefStruct?contains("ZbZclTunnelStatusT")]
                            [#assign declVar = "enum ZbZclTunnelStatusT   eStatus = ZCL_TUNNEL_STATUS_SUCCESS;"]
                            [#assign retVar = "return eStatus;"]
                        [#elseif callbackDefStruct?contains("enum")]
                            [#assign declVar = "enum ZclStatusCodeT   eStatus = ZCL_STATUS_SUCCESS;"]
                            [#assign retVar = "return eStatus;"]
                        [#elseif callbackDefStruct?contains("bool")]
                            [#assign declVar = "bool   bStatus = true;"]
                            [#assign retVar = "return bStatus;"]
                        [#elseif callbackDefStruct?contains("void")]
                            [#assign declVar = ""]
                            [#assign retVar = ""]
                        [#else]
                            [#assign declVar = callbackDefStruct + "   status = 0x01;"]
                            [#assign retVar = "return status;"]
                        [/#if]
                        [#lt]/**
                        [#if endpointName != ""]
                            [#lt] * @brief  ${clusterNameForCBName?cap_first} ${clusterRoleForCBName?cap_first} '${cbFinalPointerName}' ${endpointName} command Callback
                        [#else]
                            [#lt] * @brief  ${clusterNameForCBName?cap_first} ${clusterRoleForCBName?cap_first} '${cbFinalPointerName}' command Callback
                        [/#if]
                        [#lt] */
                        [#lt]${callbackDefStruct} ${cbName}${callbackDefArg}
                        [#lt]{
                        [#lt]  ${declVar}
                        [#lt]  /* USER CODE BEGIN ${cbName} */

                        [#lt]  /* USER CODE END ${cbName} */
                        [#lt]  ${retVar}
                        [#lt]}

                    [/#if]
                [/#if]
            [/#list]

            [#if step == "declaration"]
                [#if cbName != ""]
                    [#if isAlone == "false" ]
                        [#assign masterCbName = "st" + clusterNameForCBName + clusterRoleForCBName + "Callbacks" + endpointNameCbk]
                        [#lt]${masterCbTypeName} ${masterCbName} =
                        [#lt]{
                        [#--lt] //----------------------  generateZgbCallbacks : allCallbackName = ${allCallbackName} --]
                        [#if allCallbackName??]
                            [#list allCallbackName?split(":") as currentCallBackName]
                                [#if currentCallBackName?contains("$NULL")]
                                    [#lt]  .${currentCallBackName?replace("$NULL","")} = NULL,
                                [#else]
                                    [#assign cbPtNameList = currentCallBackName?split("_")]
                                    [#assign cbFinalCallbackName = ""]
                                    [#list cbPtNameList as cbPtName]
                                        [#assign cbFinalCallbackName = cbFinalCallbackName + cbPtName?cap_first ]
                                    [/#list]
                                    [#assign allCallbackNameToAdd = cbPointerName]
                                    [#assign cbName2 = "APP_ZIGBEE_" + clusterNameForCBName + clusterRoleForCBName + cbFinalCallbackName + "Callback" + endpointNameCbk]
                                    [#lt]  .${currentCallBackName?lower_case} = ${cbName2},
                                [/#if]
                            [/#list]
                        [/#if]
                        [#lt]};
                    [/#if]
                [#else]
                    [#lt]${masterCbTypeName} ${masterCbName};
                [/#if]
            [/#if]  
        [/#if]
    [/#list]
[/#macro]

[#-- Generate Cluster Allocation Cluster Basic-Server is never listed --]
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
    [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
        [#assign endpointName = ""]
    [#else]
        [#assign endpointName = "_" + endpoint]
    [/#if]
    [#assign profileId  = allHashEndpoint_GP[endpoint]["ProfID"]]
    [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]?split("_")]
    [#assign clusterName = allHashCluster_GP[cluster]["key1clusterName"]]
    [#assign clusterNameForCBName = allHashCluster_GP[cluster]["key2clusterNameForCBName"]]
    [#assign commentPrinted = "no"]
    [#if seqPrintedCluster_GP?seq_contains(endpoint)]
    [#else]
        [#assign seqPrintedCluster_GP = seqPrintedCluster_GP + [endpoint]]
        
        [#lt]  /* Add EndPoint${endpointName?replace("_"," ")} */
        [#lt]  memset( &stRequest, 0, sizeof( stRequest ) );
        [#lt]  stRequest.profileId = APP_ZIGBEE_PROFILE_ID${endpointName};
        [#lt]  stRequest.deviceId = APP_ZIGBEE_DEVICE_ID${endpointName};
        [#lt]  stRequest.endpoint = APP_ZIGBEE_ENDPOINT${endpointName};
        [#lt]  ZbZclAddEndpoint( stZigbeeAppInfo.pstZigbee, &stRequest, &stConfig );
        [#lt]  assert( stConfig.status == ZB_STATUS_SUCCESS );
        
    [/#if]
    [#list clusterValue as seqElement]
        [#assign clusterRole =seqElement?lower_case]
        [#assign masterCbTypeName = allHashCluster_GP[cluster]["key3masterCbTypeName"]?replace("$ROLE",clusterRole?cap_first)?replace("$LOWERROLE",clusterRole)?replace("$ENDPOINT",endpointName)]
        [#assign masterCbName = allHashCluster_GP[cluster]["key4masterCbName"]?replace("$ROLE",clusterRole?cap_first)?replace("$ENDPOINT",endpointName)]
        [#assign allocNameFunction = allHashCluster_GP[cluster]["key5allocNameFunction"]?replace("$ROLE",clusterRole?cap_first)?replace("$LOWERROLE",clusterRole)]
        [#assign allocSpecificParamClient = allHashCluster_GP[cluster]["key6allocSpecificParamClient"]?replace("$PROFILEID",profileId)?replace("$ENDPOINT",endpointName)]
        [#assign allocSpecificParamServer = allHashCluster_GP[cluster]["key7allocSpecificParamServer"]?replace("$PROFILEID",profileId)?replace("$ENDPOINT",endpointName)]
        [#assign additionnalParameters = allHashCluster_GP[cluster]["key8additionnalParameters"]?replace("$PROFILEID",profileId)?replace("$ENDPOINT",endpointName)?replace("$ROLE",clusterRole?cap_first)]
    
        [#-- Manage specific use cases --]     
        [#--lt] // ----------> ${clusterName} : ${clusterRole} : ${allocNameFunction} : ${allocSpecificParamClient} : ${allocSpecificParamServer} --]
        [#if allocNameFunction == ""]
            [#break]
        [/#if]
        [#if (clusterRole == "server" && allocSpecificParamServer != "") ||(clusterRole == "client" && allocSpecificParamClient != "")]
            [#-- [#assign clusterValueName = ${allHashCluster_GP[cluster]["clusterValue"]?lower_case?cap_first?replace("_", "/")} --]
            [#assign clusterValueList = allHashCluster_GP[cluster]["clusterValue"]?split("_") ]
            [#assign clusterValueName = clusterValueList[0]?lower_case?cap_first ]
            [#if commentPrinted == "no"]
                [#lt]  /* Add ${clusterNameForCBName?cap_first} ${clusterValueName}${endpointName?replace("_"," ")} Cluster */
                [#assign commentPrinted = "yes"]
            [/#if]
            [#if (clusterNameForCBName == "colorControl") && (clusterRole == "server")]
                [#lt]  ${additionnalParameters?split("/")[0]} =
                [#lt]  {
                [#lt]    .callbacks = stColorControlServerCallbacks,
                [#lt]    /* Please complete the other attributes according to your application:
                [#lt]     *          .capabilities           //uint8_t (e.g. ZCL_COLOR_CAP_HS)
                [#lt]     *          .enhanced_supported     //bool
                [#lt]     */
                [#lt]    /* USER CODE BEGIN Color Server Config (endpoint${endpoint}) */
                [#lt]    /* USER CODE END Color Server Config (endpoint${endpoint}) */
                [#lt]  };
            [/#if]
            [#if clusterNameForCBName == "otaUpgrade"]
                [#lt]  ${additionnalParameters?split("/")[0]}  =
                [#lt]  {
                [#lt]    .profile_id = ${profileId},
                [#lt]    .endpoint = APP_ZIGBEE_ENDPOINT${endpointName},
                [#if clusterRole == "client"]
                    [#lt]    .callbacks = stOtaUpgradeClientCallbacks,
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
            [#if ((clusterNameForCBName == "diagnostics") && (clusterRole == "server"))]
                [#lt]  if ( ${allocNameFunction}${allocSpecificParamServer} == false )
                [#lt]  {
                [#lt]    LOG_ERROR_APP( "Error : Diagnostic Server Cluster allocation failed." );
                [#lt]  }
            [#else]
                [#lt]  stZigbeeAppInfo.${clusterNameForCBName?cap_first}${clusterRole?cap_first}${endpointName} = ${allocNameFunction}[#if clusterRole == "server"]${allocSpecificParamServer}[#else]${allocSpecificParamClient}[/#if];
                [#lt]  assert( stZigbeeAppInfo.${clusterNameForCBName?cap_first}${clusterRole?cap_first}${endpointName} != NULL );
                [#lt]  ZbZclClusterEndpointRegister( stZigbeeAppInfo.${clusterNameForCBName?cap_first}${clusterRole?cap_first}${endpointName} );
            [/#if]

        [/#if]
    [/#list]
[/#macro]

[#-- Generate Cluster redefine. Cluster Basic-Server is never listed --]
[#macro generateZgbClusterRedefine cluster]
    [#assign clusterNameForCBName = allHashCluster_GP[cluster]["key2clusterNameForCBName"]]
    [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]]
    [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
        [#assign endpointName = ""]
    [#else]
        [#assign endpointName = "_" + allHashCluster_GP[cluster]["epNb"]]
    [/#if]
    [#if !((clusterNameForCBName?contains("basic")) && (clusterValue == "SERVER"))]
        [#if clusterValue?contains("CLIENT")]
            [#assign clusterFinalName = clusterNameForCBName?cap_first + "Client" + endpointName]
        [#else]
            [#assign clusterFinalName = clusterNameForCBName?cap_first + "Server" + endpointName]
        [/#if]
        [#lt]#define ${clusterFinalName?right_pad(userAlignPad - userDefineLength)} pstZbCluster[${userListIndex_GP}]
        [#assign userListIndex_GP = userListIndex_GP + 1]
    [/#if]
[/#macro]

[#macro generateZgbClusterInformation step]
    [#assign clusterNb = 0]
    [#list allHashCluster_GP?keys as cluster]
        [#assign clusterName = allHashCluster_GP[cluster]["key1clusterName"]]
        [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]]
        [#if !((clusterName?contains("basic")) && (clusterValue == "SERVER"))]
            [#assign clusterNb = clusterNb + 1]
        [/#if]
    [/#list]
    [#assign clusterIndex = 1]
    [#assign manageBasic = true]
    [#list allHashCluster_GP?keys as cluster]
        [#assign clusterName = allHashCluster_GP[cluster]["key1clusterName"]]
        [#assign clusterNameForCBName = allHashCluster_GP[cluster]["key2clusterNameForCBName"]]
        [#assign clusterValue  = allHashCluster_GP[cluster]["clusterValue"]]
        [#if (clusterNb == 1)]
            [#assign clusterNumber = ""]
        [#else]
            [#assign clusterNumber = clusterIndex]
        [/#if]
        [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
            [#assign endpointName  = ""]
        [#else]
            [#assign endpointName  = "_" + allHashCluster_GP[cluster]["epNb"]]
        [/#if]
        [#if !((clusterName?contains("basic")) && (clusterValue == "SERVER"))]
            [#if clusterValue?contains("CLIENT")]
                [#assign clusterTypeName = "Client"]
            [#else]
                [#assign clusterTypeName = "Server"]
            [/#if]
            [#assign clusterDefineID = "APP_ZIGBEE_CLUSTER" + clusterNumber + endpointName + "_ID"]
            [#assign clusterDefineName = "APP_ZIGBEE_CLUSTER" + clusterNumber + endpointName + "_NAME"]
            [#if step != "display"]
                [#assign rightPadSize = userAlignPad - userDefineLength ]
                [#lt]#define ${clusterDefineID?right_pad(rightPadSize)} ZCL_CLUSTER_${clusterName?upper_case}
                [#lt]#define ${clusterDefineName?right_pad(rightPadSize)} "${clusterNameForCBName?cap_first} ${clusterTypeName}"

            [#else]
                [#lt]  LOG_INFO_APP( "%s on Endpoint %d.", ${clusterDefineName}, APP_ZIGBEE_ENDPOINT${endpointName} );
            [/#if]
            [#assign clusterIndex = clusterIndex + 1]
        [/#if]
    [/#list]
[/#macro]

[#macro setDefine]
    [#list allHashParamsPerCluster_GP?keys as defineParam]
        [#--lt]// defineParam ${defineParam} --]
        [#if defineParam?split("$")[1]??]
            [#assign endpoint = defineParam?split("$")[0]]
            [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
                [#assign endpointName  = ""]
                [#assign endpointNameDfn  = endpointName]
                [#assign commentEndpointName  = " specific defines ----------------------------------------------------*/"]
            [#else]
                [#assign endpointName  = endpoint]
                [#assign endpointNameDfn  = "_" + endpointName]
                [#assign commentEndpointName  = " for Endpoint " + endpointName + " specific defines -----------------------------------*/"]
            [/#if]
            [#assign rightPadSize = userAlignPad - userDefineLength ]
            [#assign clusterName = defineParam?split("$")[1]]
            [#if activeCluster_GP?seq_contains(clusterName)]
                [#assign clusterNameList = clusterName?split("_")]
                [#assign clusterNameDisplay = ""]
                [#list clusterNameList as clusterNamePart]
                    [#assign clusterNameDisplay = clusterNameDisplay + clusterNamePart?cap_first ]
                [/#list]
                [#lt]/* ${clusterNameDisplay}${commentEndpointName}
                [#list allHashParamsPerCluster_GP[defineParam]?keys as defineName]
                    [#assign defineFinalName = defineName + endpointNameDfn]
                    [#assign defineFinalValue = allHashParamsPerCluster_GP[defineParam][defineName]]
                    [#lt]#define ${defineFinalName?right_pad(rightPadSize)} ${defineFinalValue}
                [/#list]
                [#lt]/* USER CODE BEGIN ${clusterNameDisplay}${endpointName} defines */
                [#lt]/* USER CODE END ${clusterNameDisplay}${endpointName} defines */

            [/#if]
        [/#if]
    [/#list]
[/#macro]

[#macro setGroupAddress]
    [#assign nbGroupAdr = 0 ]
    [#list allHashEndpoint_GP?keys as currentEndPoint]
        [#if currentEndPoint != "0"]
            [#if  allHashEndpoint_GP[currentEndPoint]["GrpAdrActive"] == "1" ]
                [#assign nbGroupAdr = nbGroupAdr + 1 ]
            [/#if]
        [/#if]
    [/#list]
    [#if nbGroupAdr != 0 ]
        [#lt]  struct ZbApsmeAddGroupReqT  stRequest;
        [#lt]  struct ZbApsmeAddGroupConfT stConfig;

        [#lt]  memset( &stRequest, 0, sizeof( stRequest ) );
        
        [#list allHashEndpoint_GP?keys as currentEndPoint]
            [#if currentEndPoint != "0"]
                [#if  allHashEndpoint_GP[currentEndPoint]["GrpAdrActive"] == "1" ]
                    [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
                        [#assign endPoint = ""]
                    [#else]
                        [#assign endPoint = "_" + currentEndPoint]
                        [#lt]  /* Set GroupAdddress for Endpoint${endPoint?replace("_"," ")} */
                    [/#if]
                    [#lt]  stRequest.endpt = APP_ZIGBEE_ENDPOINT${endPoint};
                    [#lt]  stRequest.groupAddr = APP_ZIGBEE_GROUP_ADDRESS${endPoint};
                    [#lt]  ZbApsmeAddGroupReq( stZigbeeAppInfo.pstZigbee, &stRequest, &stConfig );

                [/#if]
            [/#if]
        [/#list]
        [#lt]  return true;
    [#else]
        [#lt]  /* Not used */

        [#lt]  return false;
    [/#if]
[/#macro]

[#assign ZigBeeMode = zigbeeGenericParamHash_GP["ZGB_NW_MODE"]]
[#assign ZGB_APPLICATION = zigbeeGenericParamHash_GP["ZGB_APPLICATION"]]
[#assign ZGB_DEVICE_ROLE = zigbeeGenericParamHash_GP["ZGB_DEVICE_ROLE"]]
[#assign ZGB_TOUCHLINK_CAPABILITY = zigbeeGenericParamHash_GP["ZGB_TOUCHLINK_CAPABILITY"]]
[#assign ZGB_CHANNEL = zigbeeGenericParamHash_GP["ZGB_CHANNEL"]]
[#assign ZGB_SLEEPY_MODE = zigbeeGenericParamHash_GP["ZGB_SLEEPY_MODE"]]                    
[#-- Build the endpoint Array --]
[#assign numberOfEndpoint_GP = zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number]
[#list 0..numberOfEndpoint_GP as i]
    [#assign endpointHash = {"NbID": zigbeeGenericParamHash_GP["ENDPOINT" + i + "_ID_ZGB"]}]
    [#assign endpointHash = endpointHash + {"DevID": zigbeeGenericParamHash_GP["ZGB_ENDPOINT" + i + "_DEVICE_ID"]}]
    [#assign endpointHash = endpointHash + {"ProfID": zigbeeGenericParamHash_GP["ZGB_ENDPOINT" + i + "_PROFILE_ID"]}]
    [#assign endpointHash = endpointHash + {"GrpAdrActive": zigbeeGenericParamHash_GP["ZGB_ENDPOINT" + i + "_GROUP_ADDRESS_ACTIVATION"]}]
    [#assign endpointHash = endpointHash + {"GrpAdr": zigbeeGenericParamHash_GP["ZGB_ENDPOINT" + i + "_GROUP_ADDRESS"]}]
    [#assign allHashEndpoint_GP = allHashEndpoint_GP + {i : endpointHash}]
[/#list]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : app_zigbee_endpoint.c
  * Description        : Zigbee Application to manage endpoints and these clusters.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include <assert.h>
#include <stdint.h>

#include "app_conf.h"
#include "app_common.h"
#include "app_entry.h"
#include "app_zigbee.h"
#include "dbg_trace.h"
#include "ieee802154_enums.h"
#include "mcp_enums.h"

#include "stm32_lpm.h"
#include "stm32_rtos.h"
#include "stm32_timer.h"

#include "zigbee.h"
#include "zigbee.nwk.h"
#include "zigbee.security.h"

/* Private includes -----------------------------------------------------------*/
[#list headerFiles_GP as file]
    [#lt]#include "${file}"
[/#list]

/* USER CODE BEGIN PI */

/* USER CODE END PI */

/* Private defines -----------------------------------------------------------*/
#define APP_ZIGBEE_CHANNEL                ${zigbeeGenericParamHash_GP["ZGB_CHANNEL"]}u
#define APP_ZIGBEE_CHANNEL_MASK           ( 1u << APP_ZIGBEE_CHANNEL )
#define APP_ZIGBEE_TX_POWER               ((int8_t) 10)    /* TX-Power is at +10 dBm. */

[#list allHashEndpoint_GP?keys as currentEndPoint]
    [#if currentEndPoint != "0"]
        [#if zigbeeGenericParamHash_GP["ZGB_NB_ENDPOINTS"]?number == 1 ]
            [#assign endPoint = ""]
        [#else]
            [#assign endPoint = "_" + currentEndPoint]
        [/#if]
        [#assign endPointNumber = "APP_ZIGBEE_ENDPOINT" + endPoint]
        [#assign endPointProfile = "APP_ZIGBEE_PROFILE_ID" + endPoint]
        [#assign endPointDevice = "APP_ZIGBEE_DEVICE_ID" + endPoint]
        [#assign endPointGrpAdr = "APP_ZIGBEE_GROUP_ADDRESS" + endPoint]
        [#assign rightPadSize = userAlignPad - userDefineLength]
        [#lt]#define ${endPointNumber?right_pad(rightPadSize)} ${allHashEndpoint_GP[currentEndPoint]["NbID"]}u[#lt]
        [#lt]#define ${endPointProfile?right_pad(rightPadSize)} ${allHashEndpoint_GP[currentEndPoint]["ProfID"]}[#lt]
        [#lt]#define ${endPointDevice?right_pad(rightPadSize)} ${allHashEndpoint_GP[currentEndPoint]["DevID"]}[#lt]
        [#if  allHashEndpoint_GP[currentEndPoint]["GrpAdrActive"] == "1" ]
            [#lt]#define ${endPointGrpAdr?right_pad(rightPadSize)} 0x${allHashEndpoint_GP[currentEndPoint]["GrpAdr"]}u[#lt]
        [/#if]

    [/#if]
[/#list]
[@generateZgbClusterInformation "define"/]

[#if ZGB_DEVICE_ROLE == "END_DEVICE" ]
    [#lt]#define APP_ZIGBEE_ZED_SLEEP_TIME         1u            /* For a ZED, Sleep Time Unit is 30 seconds. */
[/#if]

[#lt][@setDefine/]

/* USER CODE BEGIN PD */

/* USER CODE END PD */

// -- Redefine Clusters to better code read --
[#assign userListIndex_GP = 0]
[#list allHashCluster_GP?keys as cluster]
    [@generateZgbClusterRedefine cluster/][#lt]
[/#list]

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private constants ---------------------------------------------------------*/
/* USER CODE BEGIN PC */

/* USER CODE END PC */

/* Private variables ---------------------------------------------------------*/
static uint16_t   iDeviceShortAddress;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#list allHashCluster_GP?keys as cluster]
    [@generateZgbCallbacks cluster "declaration"/][#lt]
[/#list]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/

/**
 * @brief  Zigbee application initialization
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_ApplicationInit(void)
{
  LOG_INFO_APP( "ZIGBEE Application Init" );

  /* Initialization of the Zigbee stack */
  APP_ZIGBEE_Init();

  /* Configure Application Form/Join parameters : Startup, Persistence and Start with/without Form/Join */
[#if ZGB_DEVICE_ROLE == "COORDINATOR" && ZigBeeMode == "CENTRALIZED"]
    [#lt]  stZigbeeAppInfo.eStartupControl = ZbStartTypeForm;
[#else]
    [#lt]  stZigbeeAppInfo.eStartupControl = ZbStartTypeJoin;
[/#if]
  stZigbeeAppInfo.bPersistNotification = false;
  stZigbeeAppInfo.bNwkStartup = true;

  /* USER CODE BEGIN APP_ZIGBEE_ApplicationInit */
  
  /* USER CODE END APP_ZIGBEE_ApplicationInit */
  
  /* Initialize Zigbee stack layers */
  APP_ZIGBEE_StackLayersInit();
}

/**
 * @brief  Zigbee application start
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_ApplicationStart( void )
{
  /* USER CODE BEGIN APP_ZIGBEE_ApplicationStart */

  /* USER CODE END APP_ZIGBEE_ApplicationStart */

#if ( CFG_LPM_LEVEL != 0)
  /* Authorize LowPower now */
  UTIL_LPM_SetStopMode( 1 << CFG_LPM_APP, UTIL_LPM_ENABLE );
#if (CFG_LPM_STDBY_SUPPORTED == 1)  
  UTIL_LPM_SetOffMode( 1 << CFG_LPM_APP, UTIL_LPM_ENABLE );
#endif /* CFG_LPM_STDBY_SUPPORTED */
#endif /* CFG_LPM_LEVEL */
}

/**
 * @brief  Zigbee persistence startup
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_PersistenceStartup(void)
{
  /* Not used */
}

/**
 * @brief  Configure Zigbee application endpoints
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_ConfigEndpoints(void)
{
  struct ZbApsmeAddEndpointReqT   stRequest;
  struct ZbApsmeAddEndpointConfT  stConfig;
  /* USER CODE BEGIN APP_ZIGBEE_ConfigEndpoints1 */

  /* USER CODE END APP_ZIGBEE_ConfigEndpoints1 */

[#list allHashCluster_GP?keys as cluster]
    [@initZgbClusterAlloc cluster/][#lt]
[/#list]

  /* USER CODE BEGIN APP_ZIGBEE_ConfigEndpoints2 */

  /* USER CODE END APP_ZIGBEE_ConfigEndpoints2 */
}

/**
 * @brief  Set Group Addressing mode (if used)
 * @param  None
 * @retval 'true' if Group Address used else 'false'.
 */
bool APP_ZIGBEE_ConfigGroupAddr( void )
{
  [@setGroupAddress /][#lt]
}

/**
 * @brief  Return the Startup Configuration
 * @param  pstConfig  Configuration structure to fill
 * @retval None
 */
void APP_ZIGBEE_GetStartupConfig( struct ZbStartupT * pstConfig )
{
  /* Attempt to join a zigbee network */
  ZbStartupConfigGetProDefaults( pstConfig );

[#if ZigBeeMode == "DISTRIBUTED"]
  /* Set the TC address to be distributed. */
  pstConfig->security.trustCenterAddress = ZB_DISTRIBUTED_TC_ADDR;

  /* Using the Uncertified Distributed Global Key */
  memcpy( pstConfig->security.distributedGlobalKey, sec_key_distrib_uncert, ZB_SEC_KEYSIZE );
[#else]
  /* Using the default HA preconfigured Link Key */
  memcpy( pstConfig->security.preconfiguredLinkKey, sec_key_ha, ZB_SEC_KEYSIZE );
[/#if]  
  
  /* Setting up additional startup configuration parameters */
  pstConfig->startupControl = stZigbeeAppInfo.eStartupControl;
  pstConfig->channelList.count = 1;
  pstConfig->channelList.list[0].page = 0;
  pstConfig->channelList.list[0].channelMask = APP_ZIGBEE_CHANNEL_MASK;
  
[#if ZGB_DEVICE_ROLE == "END_DEVICE" ]
  [#lt]  /* Add End Device configuration */
  [#lt]  pstConfig->capability &= ~( MCP_ASSOC_CAP_RXONIDLE | MCP_ASSOC_CAP_DEV_TYPE | MCP_ASSOC_CAP_ALT_COORD );
  [#lt]  pstConfig->endDeviceTimeout = APP_ZIGBEE_ZED_SLEEP_TIME;
  
[/#if]
  /* Set the TX-Power */
  if ( APP_ZIGBEE_SetTxPower( APP_ZIGBEE_TX_POWER ) == false )
  {
    LOG_ERROR_APP( "Switching to %d dB failed.", APP_ZIGBEE_TX_POWER );
    return;
  }

  /* USER CODE BEGIN APP_ZIGBEE_GetStartupConfig */

  /* USER CODE END APP_ZIGBEE_GetStartupConfig */
}

/**
 * @brief  Manage a New Device on Network (called only if Coord or Router).
 * @param  iShortAddress      Short Address of new Device
 * @param  dlExtendedAddress  Extended Address of new Device
 * @param  cCapability        Capability of new Device
 * @retval Group Address
 */
void APP_ZIGBEE_SetNewDevice( uint16_t iShortAddress, uint64_t dlExtendedAddress, uint8_t cCapability )
{
  iDeviceShortAddress = iShortAddress;
  LOG_INFO_APP( "New Device (%d) on Network : with Extended ( 0x%016" PRIX64 " ) and Short ( 0x%04" PRIX16 " ) Address.", cCapability, dlExtendedAddress, iDeviceShortAddress );

  /* USER CODE BEGIN APP_ZIGBEE_SetNewDevice */

  /* USER CODE END APP_ZIGBEE_SetNewDevice */  
}

/**
 * @brief  Print application information to the console
 * @param  None
 * @retval None
 */
void APP_ZIGBEE_PrintApplicationInfo(void)
{
  LOG_INFO_APP( "**********************************************************" );
[#if ZigBeeMode == "CENTRALIZED"]
  LOG_INFO_APP( "Network config : ${ZigBeeMode?upper_case} ${ZGB_DEVICE_ROLE?upper_case?replace("_", " ")}" );
[#else]  
  LOG_INFO_APP( "Network config : ${ZigBeeMode}" );
[/#if]

  /* USER CODE BEGIN APP_ZIGBEE_PrintApplicationInfo1 */
  
  /* USER CODE END APP_ZIGBEE_PrintApplicationInfo1 */
  LOG_INFO_APP( "Channel used: %d.", APP_ZIGBEE_CHANNEL );

  APP_ZIGBEE_PrintGenericInfo();

  LOG_INFO_APP( "Clusters allocated are:" );
  [@generateZgbClusterInformation "display"/][#lt]

  /* USER CODE BEGIN APP_ZIGBEE_PrintApplicationInfo2 */

  /* USER CODE END APP_ZIGBEE_PrintApplicationInfo2 */

  LOG_INFO_APP( "**********************************************************" );
}

[#list allHashCluster_GP?keys as cluster]
    [@generateZgbCallbacks cluster "definition"/][#lt]
[/#list]

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */
