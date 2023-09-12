[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : Zigbee Application.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign userCodeIndex = 0]
/* USER CODE END Header */
[#-- Generates the cluster stucture into the zigbee_app_info global structure.
     It is called at the definition of the zigbee_app_info structure.
     @clusterParam the cluster argument defined in the Config file
     @endpoint the associated Endpoint number --]
[#macro generateZgbClusterDefinition clusterParam endpoint]
    [#if clusterParam.value?contains("CLIENT")]
        [#lt]  struct ZbZclClusterT *${clusterParam.comments}_client_${endpoint};
    [/#if]
    [#if clusterParam.value?contains("SERVER") && (clusterParam.comments != "basic")]
        [#if clusterParam.comments == "diagnostics"]
            [#lt]  bool ${clusterParam.comments}_server_${endpoint};
        [#else]
            [#lt]  struct ZbZclClusterT *${clusterParam.comments}_server_${endpoint};
        [/#if]
    [/#if]
[/#macro]

[#-- Calls the generateZgbCallbacks macro with correct arguments (name, mode depending on user choice and special arguments synthaxe) for each cluster that is configured by the user.
     It is called at 2 steps : declaration and definition of the callbacks.
     @cluster the Argument cluster of which we want to generate callbacks
     @endpoint the endpoint where the cluster is allocated
     @step the step it is called (declaration or definition) --]
[#macro ZgbCallbacks cluster endpoint step]
    [#if cluster.name?contains("ALARMS") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_ALARMS" "Client" "Alarm" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("MESSAGING") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_MESSAGING" "Client" "Msg" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("MESSAGING") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_MESSAGING" "Server" "Msg" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("ON_OFF_ENDPOINT") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_ON_OFF" "Server" "OnOff" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("COLOR_CONTROL") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_COLOR_CONTROL" "Server" "Color" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("COMMISSIONING") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_COMMISSIONING" "Server" "Commission" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("DOOR_LOCK") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_DOOR_LOCK" "Server" "DoorLock" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("ELECTRICAL_MEASUREMENT") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_ELECTRICAL_MEASUREMENT" "Server" "ElecMeas" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("LEVEL_CONTROL") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_LEVEL_CONTROL" "Server" "Level" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("OTA_UPGRADE") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_OTA_UPGRADE" "Client" "Ota" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("POWER_PROFILE") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_POWER_PROFILE" "Client" "PowerProf" false step endpoint/]
    [/#if]
    [#if cluster.name?contains("POWER_PROFILE") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_POWER_PROFILE" "Server" "PowerProf" false step endpoint/]
    [/#if]
    [#if cluster.name?contains("POLL_CONTROL") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_POLL_CONTROL" "Client" "PollControl" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("POLL_CONTROL") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_POLL_CONTROL" "Server" "PollControl" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("RSSI_LOCATION") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_RSSI_LOCATION" "Client" "rssi_loc" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("RSSI_LOCATION") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_RSSI_LOCATION" "Server" "rssi_loc" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("THERMOSTAT_ENDPOINT") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_THERMOSTAT" "Server" "Therm" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("TIME") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_TIME" "Server" "Time" false step endpoint/]
    [/#if]
    [#if cluster.name?contains("VOICE_OVER_ZGB") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_VOICE_OVER_ZGB" "Client" "Voice" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("VOICE_OVER_ZGB") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_VOICE_OVER_ZGB" "Server" "Voice" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("WINDOW_COVERING") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_WINDOW_COVERING" "Server" "Window" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("DRLC") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_DRLC" "Client" "Drlc" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("DRLC") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_DRLC" "Server" "Drlc" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("METERING") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_METERING" "Client" "Meter" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("METERING") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_METERING" "Server" "Meter" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("PRICE") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_PRICE" "Client" "Price" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("PRICE") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_PRICE" "Server" "Price" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("IAS_ACE") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_IAS_ACE" "Server" "IasAce" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("IAS_WD") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_IAS_WD" "Server" "IasWd" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("IAS_ZONE") && cluster.value?contains("CLIENT")]
        [@generateZgbCallbacks "ZCL_IAS_ZONE" "Client" "IasZone" true step endpoint/]
    [/#if]
    [#if cluster.name?contains("IAS_ZONE") && cluster.value?contains("SERVER")]
        [@generateZgbCallbacks "ZCL_IAS_ZONE" "Server" "IasZone" true step endpoint/]
    [/#if]
[/#macro]

[#-- Generates both the declaration and the definition of the callbacks.
     It is called by the macro ZgbCallbacks.
     @paramName the name of the cluster as refered in the RefConfig definition. It is used to get the right argument in the RefConfig.
     @clusterValue the mode of the cluster (Client or Server).
     @clusterName the name of the cluster used as a base for the name of the callback and its type.
     @t the boolean to know if the type of the callbacks should have a "t" at the end or not.
     @step the step we are at, declaration or definition
     @endpoint the endpoint where the cluster is allocated --]
[#macro generateZgbCallbacks paramName clusterValue clusterName t step endpoint]
    [#-- Set the type of the master callback
         Note: masterCb is the structure that gathers the specific callbacks --]
    [#if clusterName != "Alarm"]
        [#assign masterCbType = "struct"]
    [#else]
        [#assign masterCbType = ""]
    [/#if]
    [#-- Set the name of the master callback (arbitrarily) and its type (defined by the stack) --]
    [#assign masterCbName = clusterName]
    [#if masterCbName?contains("_") || masterCbName?contains("Voice")]
        [#assign masterCbName = clusterName?replace("_", " ")?capitalize?replace(" ", "") + clusterValue + "Callbacks" + "_" + endpoint]
        [#assign masterCbTypeName = "zcl_" + clusterName?lower_case + "_" + clusterValue?lower_case + "_callbacks"]
    [#else]
        [#assign masterCbName = masterCbName + clusterValue + "Callbacks" + "_" + endpoint]
        [#if clusterName == "ElecMeas" && clusterValue == "Server"]
        	[#assign masterCbTypeName = "ZbZcl" + clusterName + "SvrCallbacks"]
        [#else]
        	[#assign masterCbTypeName = "ZbZcl" + clusterName + clusterValue + "Callbacks"]
        [/#if]
    [/#if]
    [#if masterCbName?contains("Alarm") || masterCbName?contains("PollControl")]
        [#assign masterCbTypeName = masterCbTypeName?replace("Callbacks", "Callback")]
    [/#if]
    [#if t == true]
        [#if clusterName?contains("_") || clusterName == "Voice"]
            [#assign masterCbTypeName = masterCbTypeName + "_t"]
        [#else]
            [#assign masterCbTypeName = masterCbTypeName + "T"]
        [/#if]
    [/#if]
    [#-- Alarm cluster is specific : needs just one declaration --]
    [#if clusterName == "Alarm"]
        [#if step == "declaration"]
            /* ${clusterName?replace("_", " ")?capitalize} ${clusterValue?lower_case} custom callbacks */[#lt]
            static ${masterCbType} ${masterCbTypeName} ${masterCbName};[#lt]

        [/#if]
    [#else]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#-- Take the corresponding argument --]
                [#if definition.name?contains("CALLBACKS") && definition.name?contains(paramName) && definition.comments?contains(clusterValue?lower_case) && !definition.name?contains("ALARM")]
                    [#assign comment = definition.comments]
                    [#-- Get the base of the names of every callbacks of this cluster described in the comments of the argument --]
                    [#assign index = comment?index_of(":") - 1]
                    [#assign base = comment[0..index] + "_" + endpoint]
                    [#-- Get all the callback functions as they are described in comments (can be only name or also complete description of needed parameters) --]
                    [#assign index = comment?index_of(":") + 1]
                    [#assign functions = comment[index..]]
                    [#if step == "declaration"]
                        /* [#if clusterName?contains("_")]${clusterName?replace("_", " ")?capitalize}[#else]${clusterName?cap_first}[/#if] ${clusterValue?lower_case} ${endpoint} custom callbacks */[#lt]
                    [/#if]
                    [#-- Callback functions described in Argument are separated with '/' --]
                    [#list functions?split("/") as function]
                        [#-- Assign default function type as enum --]
                        [#assign type = "enum"]
                        [#assign particularArg = "-1"]
                        [#if step == "definition"]
                            [#-- commandCb is the usual name of the callbacks (eg: Toggle for On/Off cluster) --]
                            [#if function?contains("(")]
                                [#assign commandCb = "" + function[0..(function?index_of("(") - 1)] + " " + endpoint]
                            [#else]
                                [#assign commandCb = "" + function + " " + endpoint]
                            [/#if]
                            /* [#if clusterName?contains("_")]${clusterName?replace("_", " ")?capitalize}[#else]${clusterName?cap_first}[/#if] ${clusterValue?lower_case} ${commandCb} command callback */[#lt]
                        [/#if]
                        [#-- Start of the definition of the particularity for each kind of callbacks (type, arguments...) --]
                        [#-- The particularArg represents the parameters to add to the function parameters list (e.g: particular structure, endpoint ID...) --]
                        [#if definition.name?contains("COLOR_CONTROL")]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")?replace("y", "Y")]
                            [#assign particularArg = " struct ZbZclColorClient" + particularArg + "ReqT *req,"]
                        [#elseif definition.name?contains("COMMISSION")]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")?replace("ice", "")]
                            [#assign particularArg = " struct ZbZclCommissionClient" + particularArg + " *req,"]
                        [#elseif definition.name?contains("IAS_WD")]
                            [#assign type = "uint8_t"]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")]
                            [#assign particularArg = ", struct ZbZclIasWdClient" + particularArg + "ReqT *req"]
                        [#elseif definition.name?contains("LEVEL")]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")]
                            [#assign particularArg = " struct ZbZclLevelClient" + particularArg + "ReqT *req,"]
                        [#elseif definition.name?contains("DOOR_LOCK")]
                            [#if function?contains("all")]
                                [#assign particularArg = ""]
                            [#else]
                                [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")]
                                [#if function?ends_with("lock")]
                                    [#assign particularArg = particularArg + "Door"]
                                [#elseif function?ends_with("sched")]
                                    [#assign particularArg = particularArg?replace("d", "D", "f") + "ule"]
                                [/#if]
                                [#assign particularArg = " struct ZbZclDoorLock" + particularArg + "ReqT *cmd_req,"]
                            [/#if]
                        [#elseif definition.name?contains("PRICE") && !function?contains("optional")]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")]
                            [#if base?contains("client")]
                                [#assign particularArg = " struct ZbZclPriceServer" + particularArg + "T *req,"]
                            [#else]
                                [#assign particularArg = " struct ZbZclPriceClient" + particularArg + "T *req,"]
                            [/#if]
                        [#elseif definition.name?contains("POWER_PROFILE") && base?contains("_client")]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")]
                            [#if particularArg?contains("Notify")]
                                [#assign particularMode = "Svr"]
                                [#if !(particularArg?contains("Constraints"))]
                                    [#assign particularArg = particularArg?replace("Notify", "Rsp")]
                                [/#if]
                            [#elseif particularArg?contains("Ext")]
                                [#assign particularMode = "Svr"]
                                [#assign particularArg = particularArg + "Req"]
                            [#else]
                                [#assign particularMode = "Cli"]
                                [#if particularArg?contains("GetPrice") || particularArg?contains("Phases")]
                                    [#assign particularArg = "ProfileReq"]
                                [#else]
                                    [#assign particularArg = ""]
                                [/#if]
                            [/#if]
                            [#if particularArg != ""]
                                [#assign particularArg = " struct ZbZclPowerProf" + particularMode + particularArg + " *req,"]
                            [/#if]
                        [#elseif definition.name?contains("POWER_PROFILE") && base?contains("_server")]
                            [#assign particularArg = function?replace("_", " ")?capitalize?replace(" ", "")]
                            [#if particularArg?contains("Sched")]
                                [#assign particularArg = "ProfileReq"]
                            [#else]
                                [#if particularArg?contains("StateReq")]
                                    [#assign particularArg = ""]
                                [/#if]
                            [/#if]
                            [#if particularArg != ""]
                                [#assign particularArg = " struct ZbZclPowerProfCli" + particularArg + " *req,"]
                            [/#if]
                        [#elseif definition.name?contains("RSSI_LOCATION")]
                            [#assign particularArg = " struct rssi_loc_" + function + " *req,"]
                        [#elseif definition.name?contains("VOICE")]
                            [#if !function?contains("complete")]
                                [#assign particularArg = " struct voice_" + function + "_t *cmd_req,"]
                            [#else]
                                [#assign particularArg = ""]
                            [/#if]
                        [#elseif definition.name?contains("TIME")]
                            [#if function?contains("get")]
                                [#assign type = "uint32_t"]
                            [#else]
                                [#assign type = "void"]
                            [/#if]
                        [#elseif definition.name?contains("WINDOW")]
                            [#if function?contains("up") || function?contains("down") || function?contains("stop")]
                                [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, struct ZbZclHeaderT *zclHdrPtr, struct ZbApsdeDataIndT *dataIndPtr, void *arg)"]
                            [#else]
                                [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, void *arg, uint8_t liftPercentage, uint8_t tiltPercentage)"]
                            [/#if]
                        [#elseif definition.name?contains("DRLC")]
                            [#if base?contains("client")]
                                [#assign functionBody = "(void *arg, struct ZbZclDrlcEventT *event)"]
                                [#if function?contains("start")]
                                    [#assign type = "bool"]
                                [#else]
                                    [#assign type = "void"]
                                [/#if]
                            [#elseif function?contains("report")]
                                [#assign type = "void"]
                            [/#if]
                        [#elseif definition.name?contains("METERING") && base?contains("server")]
                            [#if function?contains("mirror")]
                                [#assign functionBody = "(void *arg, struct ZbZclClusterT *clusterPtr, struct ZbZclAddrInfoT *srcInfo, struct ZbApsdeDataIndT *dataIndPtr)"]
                                [#assign type = "uint16_t"]
                            [#elseif !function?contains("optional")]
                                [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, void *arg, struct ZbZclMeterClient" + function?replace("_", " ")?capitalize?replace(" ", "") + "ReqT *req, struct ZbZclAddrInfoT *srcInfo)"]
                            [/#if]
                        [#elseif definition.name?contains("IAS_ACE")]
                            [#if function?contains("arm")]
                                [#assign type = "bool"]
                                [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, void *arg, struct ZbZclIasAceClientCommandArmT *arm_req, struct ZbZclIasAceServerCommandArmRspT *arm_rsp)"]
                            [#elseif function?contains("bypass")]
                                [#assign type = "void"]
                                [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, void *arg, struct ZbZclIasAceClientCommandBypassT *bypass_req, struct ZbZclIasAceServerCommandBypassRspT *bypass_rsp)"]
                            [#else]
                                [#assign type = "uint8_t"]
                                [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, void *arg, struct ZbZclAddrInfoT *srcInfo)"]
                            [/#if]
                        [#elseif definition.name?contains("IAS_ZONE")]
                            [#if function?contains("status")]
                                [#assign type = "void"]
                            [#else]
                                [#assign type = "uint8_t"]
                            [/#if]
                        [#elseif (definition.name?contains("OTA_UPGRADE") && function?contains("query_next")) || (definition.name?contains("POLL_CONTROL") && base?contains("server"))]
                            [#assign type = "void"]
                        [/#if]
                        [#if function?contains("optional")]
                            [#assign functionBody = "(struct ZbZclClusterT *clusterPtr, struct ZbZclHeaderT *zclHdrPtr, struct ZbApsdeDataIndT *dataIndPtr)"]
                        [/#if]
                        [#if type??]
                            [#if type == "enum"]
                                [#assign type = type + " ZclStatusCodeT"]
                            [/#if]
                        [/#if]
                        [#-- Start of declaration/definition of the callbacks following a different pattern depending on the cluster --]
                        [#if particularArg != "-1" && !function?contains("optional")]
                            [#if definition.name?contains("PRICE")]
                                static ${type} ${base}_${function}(struct ZbZclClusterT *cluster, void *arg,${particularArg} struct ZbZclAddrInfoT *srcInfo)[#if step != "definition"];[#lt]
                                [#else]
                                    {[#lt]
                                    [#lt]  /* USER CODE BEGIN ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                    [@generateCallbacksReturn type/][#lt]
                                    [#lt]  /* USER CODE END ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                    [#assign userCodeIndex = userCodeIndex + 1]
                                    }[#lt]

                                [/#if][#lt]
                            [#elseif definition.name?contains("IAS_WD")]
                                static ${type} ${base}_${function}(struct ZbZclClusterT *cluster,void *arg${particularArg})[#if step != "definition"];[#lt]
                                [#else]
                                    {[#lt]
                                    [#lt]  /* USER CODE BEGIN ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                    [@generateCallbacksReturn type/][#lt]
                                    [#lt]  /* USER CODE END ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                    [#assign userCodeIndex = userCodeIndex + 1]
                                    }[#lt]

                                [/#if][#lt]
                            [#else]
                                static ${type} ${base}_${function}(struct ZbZclClusterT *cluster,${particularArg} struct ZbZclAddrInfoT *srcInfo, void *arg)[#if step != "definition"];[#lt]
                                [#else]
                                    {[#lt]
                                    [#lt]  /* USER CODE BEGIN ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                    [@generateCallbacksReturn type/][#lt]
                                    [#lt]  /* USER CODE END ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                    [#assign userCodeIndex = userCodeIndex + 1]
                                    }[#lt]

                                [/#if][#lt]
                            [/#if]
                        [#elseif definition.name?contains("IAS_ACE") || function?contains("optional") || definition.name?contains("WINDOW") || (definition.name?contains("DRLC") && (function?contains("start") || function?contains("stop"))) || (definition.name?contains("METERING") && base?contains("server"))]
                            static ${type} ${base}_${function}${functionBody}[#if step != "definition"];[#lt]
                            [#else]
                                {[#lt]
                                [#lt]  /* USER CODE BEGIN ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                [@generateCallbacksReturn type/][#lt]
                                [#lt]  /* USER CODE END ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                [#assign userCodeIndex = userCodeIndex + 1]
                                }[#lt]

                            [/#if][#lt]
                        [#else]
                            static ${type} ${base}_${function}[#if step != "definition"];[#lt]
                            [#else]
                                {[#lt]
                                [#lt]  /* USER CODE BEGIN ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                [@generateCallbacksReturn type/][#lt]
                                [#lt]  /* USER CODE END ${userCodeIndex} ${base?replace("_", " ")?cap_first} ${commandCb} */
                                [#assign userCodeIndex = userCodeIndex + 1]
                                }[#lt]

                            [/#if][#lt]
                        [/#if]
                    [/#list]
                    [#-- If we are in "declaration" step, then we have to declare the Master Callback --]
                    [#if step == "declaration"]

                        static ${masterCbType} ${masterCbTypeName} ${masterCbName} = {[#lt]
                        [#list functions?split("/") as function]
                            [#assign index = function?index_of("(") - 1]
                            [#if index > 0]
                                [#assign callbackName = function[0..index]]
                            [#else]
                                [#assign callbackName = function]
                            [/#if]
                            [#lt]  .${callbackName} = ${base}_${callbackName},
                        [/#list]
                        };[#lt]

                    [/#if]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
    [/#if]

[/#macro]

[#-- Generates the correct return for the definition of the callbacks depending of its return type.
    It is called in the generateZgbCallbacks macro when generating the definition of the callbacks.
    @typeReturn the type return of the callback --]
[#macro generateCallbacksReturn typeReturn]
    [#if typeReturn?contains("enum")]
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

[#-- Initializes the Zigbee cluster allocation proceedure, in order to call the macro generateZgbClusterAlloc. It sets the name of the allocation function to use and its specific arguments.
     It is called at the allocation of the clusters.
     @cluster the cluster to allocate
     @endpoint the endpoint where the cluster needs to be allocated.
     @profileID the profileID of the endpoint (needed for some specific cluster allocations) --]
[#macro initZgbClusterAlloc cluster endpoint profileId]
    [#if !(cluster.comments == "basic" && !cluster.value?contains("CLIENT"))] [#-- Do not continue if it concerns the Basic cluster only in server mode --]
        [#lt]  /* ${cluster.comments?cap_first?replace("_", " ")} ${cluster.value?lower_case?replace("_", "/")} */
    [/#if]
    [#-- If cluster is in client mode --]
    [#if cluster.value?contains("CLIENT")]
        [#assign role = "client"]
        [#assign specificAttributes = ""]
        [#assign name = ""]
        [#switch cluster.comments]
            [#case "alarm"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "commissioning"]
                [#assign name = "commission"]
                [#assign specificAttributes = ", APS_SECURED"]
            [#break]
            [#case "diagnostics"]
                [#assign name = "diag"]
            [#break]
            [#case "poll_control"]
                [#assign name = "pollControl"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "power_config"]
                [#assign name = "powerConfig"]
            [#break]
            [#case "power_profile"]
                [#assign name = "powerProf"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "rssi_location"]
                [#assign name = "rssiLoc"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "pressure_meas"]
                [#assign name = "pressMeas"]
            [#break]
            [#case "device_temperature"]
                [#assign name ="devTemp"]
            [#break]
            [#case "temperature_meas"]
                [#assign name = "tempMeas"]
            [#break]
            [#case "thermostat"]
                [#assign name = "therm"]
            [#break]
            [#case "thermostat_ui"]
                [#assign name = "thermUi"]
            [#break]
            [#case "meter_id"]
                [#assign name = "meterId"]
            [#break]
            [#case "electrical_meas"]
                [#assign name = "elecMeas"]
            [#break]
            [#case "color_control"]
                [#assign name = "color"]
            [#break]
            [#case "illuminance_level"]
                [#assign name = "illumLevel"]
            [#break]
            [#case "illuminance_meas"]
                [#assign name = "illumMeas"]
            [#break]
            [#case "level_control"]
                [#assign name = "level"]
            [#break]
            [#case "onoff_swconfig"]
                [#assign name = "onOffSwConfig"]
            [#break]
            [#case "window"]
            [#break]
            [#case "ias_ace"]
                [#assign name = "iasAce"]
                [#assign specificAttributes = ", NULL"]
            [#break]
            [#case "ias_wd"]
                [#assign name ="iasWd"]
                [#assign specificAttributes = ", NULL"]
            [#break]
            [#case "ias_zone"]
                [#assign name = "iasZone"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "messaging"]
                [#assign name = "msg"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "drlc"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "meter"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "price"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "nearest_gateway"]
                [#assign name = "nearestGw"]
            [#break]
            [#case "ota_upgrade"]
                [#assign name = "ota"]
            [#break]
            [#case "dehumidification_ctrl"]
                [#assign name = "dehumCtrl"]
            [#break]
            [#case "ballast_config"]
                [#assign name = "ballastConfig"]
            [#break]
            [#case "voice"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "relative_humidity"]
                [#assign name = "waterContentMeas"]
                [#assign specificAttributes = ", ZCL_CLUSTER_MEAS_HUMIDITY"]
            [#break]
        [/#switch]
        [@generateZgbClusterAlloc cluster endpoint profileId name role specificAttributes/]

    [/#if]
    [#-- If cluster is in server mode --]
    [#if cluster.value?contains("SERVER")]
        [#assign role = "server"]
        [#assign specificAttributes =""]
        [#assign name = ""]
        [#switch cluster.comments]
            [#case "identify"]
                [#assign specificAttributes = ", NULL"]
            [#break]
            [#case "alarm"]
                [#assign specificAttributes = ", ZCL_ALARM_LOG_ENTRY_NB, zigbee_app_info.time_server_" + endpoint]
            [#break]
            [#case "time"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "commissioning"]
                [#assign name = "commission"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "scenes"]
                [#assign specificAttributes = ", ZCL_SCENES_MAX_SCENES"]
            [#break]
            [#case "diagnostics"]
                [#assign name = "diag"]
                [#assign specificAttributes = ", " + profileId + ", MIN_SECURITY"]
            [#break]
            [#case "poll_control"]
                [#assign name = "pollControl"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "power_config"]
                [#assign name = "powerConfig"]
            [#break]
            [#case "power_profile"]
                [#assign name = "powerProf"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "rssi_location"]
                [#assign name = "rssiLoc"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "pressure_meas"]
                [#assign name = "pressMeas"]
                [#assign specificAttributes = ", PRESS_MIN, PRESS_MAX"]
            [#break]
            [#case "device_temperature"]
                [#assign name ="devTemp"]
            [#break]
            [#case "temperature_meas"]
                [#assign name = "tempMeas"]
                [#assign specificAttributes = ", TEMP_MIN, TEMP_MAX, TEMP_TOLERANCE"]
            [#break]
            [#case "thermostat"]
                [#assign name = "therm"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "thermostat_ui"]
                [#assign name = "thermUi"]
            [#break]
            [#case "meter_id"]
                [#assign name = "meterId"]
            [#break]
            [#case "electrical_meas"]
                [#assign name = "elecMeas"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "onOff"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "color_control"]
                [#assign name = "color"]
                [#assign specificAttributes = ", zigbee_app_info.onOff_server_" + endpoint + ", NULL, 0, &colorServerConfig" + endpoint + ", NULL"]
            [#break]
            [#case "illuminance_level"]
                [#assign name = "illumLevel"]
            [#break]
            [#case "illuminance_meas"]
                [#assign name = "illumMeas"]
                [#assign specificAttributes = ", ILLUM_MIN, ILLUM_MAX"]
            [#break]
            [#case "level_control"]
                [#assign name = "level"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "onoff_swconfig"]
                [#assign name = "onOffSwConfig"]
                [#assign specificAttributes = ", SWITCH_TYPE"]
            [#break]
            [#case "doorLock"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "window"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "ias_ace"]
                [#assign name = "iasAce"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "ias_wd"]
                [#assign name ="iasWd"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "ias_zone"]
                [#assign name = "iasZone"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "messaging"]
                [#assign name = "msg"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "drlc"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "meter"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "price"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "nearest_gateway"]
                [#assign name = "nearestGw"]
            [#break]
            [#case "ota_upgrade"]
                [#assign name = "ota"]
            [#break]
            [#case "dehumidification_ctrl"]
                [#assign name = "dehumCtrl"]
            [#break]
            [#case "ballast_config"]
                [#assign name = "ballastConfig"]
                [#assign specificAttributes = ", BALLAST_PHY_MIN, BALLAST_PHY_MAX"]
            [#break]
            [#case "voice"]
                [#assign specificAttributes = "Callbacks_" + endpoint + ", NULL"]
            [#break]
            [#case "relative_humidity"]
                [#assign name = "waterContentMeas"]
                [#assign specificAttributes = ", ZCL_CLUSTER_MEAS_HUMIDITY, HUMIDITY_MIN, HUMIDITY_MAX"]
            [#break]
        [/#switch]
        [@generateZgbClusterAlloc cluster endpoint profileId name role specificAttributes/]

    [/#if]
[/#macro]

[#-- Generates the cluster allocation using the parameters defined in initZgbClusterAlloc macro.
     @cluster the cluster to allocate
     @endpoint the endpoint on which the cluster must be allocated
     @profileId the profile ID of the endpoint
     @name the base of the name of the cluster allocation function
     @role the role of the cluster (client / server)
     @specificAttributes the specific attributes to use as the allocation function parameters --]
[#macro generateZgbClusterAlloc cluster endpoint profileId name role specificAttributes]
    [#-- Reassign name and specific attributes to nameAlloc and attributes variables to avoid remanance problems --]
    [#assign attributes = specificAttributes]
    [#assign nameAlloc = name]
    [#if nameAlloc == ""]
        [#assign nameAlloc = cluster.comments]
    [/#if]
    [#-- Color Control server and OTA clusters have plenty of specific attributes that are setted in a separated structure used then as an allocation function argument.
         So we define this structure with elementary attributes setted and we elt the user to configure the others if he needs it. --]
    [#if nameAlloc == "ota"]
        [#lt]  struct ZbZcl${nameAlloc?cap_first}${role?cap_first}Config ${nameAlloc}${role?cap_first}Config${endpoint} = {
        [#lt]    .profile_id = ${profileId},
        [#lt]    .endpoint = SW${endpoint}_ENDPOINT,
        [#if role == "client"]
                 .callbacks = ${nameAlloc?cap_first}${role?cap_first}Callbacks_${endpoint},
        [/#if]
        [#lt]    /* Please complete the other attributes according to your application:
        [#if role == "server"]
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
        [#lt]    /* USER CODE BEGIN OTA ${role?cap_first} Config${endpoint} */
        [#lt]    /* USER CODE END OTA ${role?cap_first} Config${endpoint} */
        [#lt]  };
    [/#if]
    [#if (nameAlloc == "color") && (role == "server")]
        [#lt]  struct Zb${nameAlloc?cap_first}ClusterConfig ${nameAlloc}ServerConfig${endpoint} = {
        [#lt]    .callbacks = ${nameAlloc?cap_first}${role?cap_first}Callbacks_${endpoint},
        [#lt]    /* Please complete the other attributes according to your application:
        [#lt]     *          .capabilities           //uint8_t (e.g. ZCL_COLOR_CAP_HS)
        [#lt]     *          .enhanced_supported     //bool
        [#lt]     */
        [#lt]    /* USER CODE BEGIN Color Server Config${endpoint} */
        [#lt]    /* USER CODE END Color Server Config${endpoint} */
        [#lt]  };
    [/#if]
    [#-- Handle the callback argument depending on the clusters --]
    [#if attributes?contains("Callbacks")]
        [#if nameAlloc != "alarm"]
            [#assign attributes = ", &" + nameAlloc?cap_first + role?cap_first + attributes]
        [#else]
            [#assign attributes = ", " + nameAlloc?cap_first + role?cap_first + attributes]
        [/#if]
        [#if (cluster.comments == "drlc") && (role == "client")]
            [#assign attributes = ", zigbee_app_info.time_server_" + endpoint + attributes]
        [/#if]
        [#if (cluster.comments == "level_control") && (role == "server")]
            [#assign attributes = ", zigbee_app_info.onOff_server_" + endpoint + attributes]
        [/#if]
        [#if (cluster.comments == "ias_zone") && (role == "server")]
        [#-- Specific attributes zone_type, manuf_code, use_trip_pair?? --]
            [#assign attributes = ", ZCL_IAS_ZONE_SVR_ATTR_ZONE_TYPE, 0x00, false" + attributes]
        [/#if]
        [#if (cluster.comments == "commissioning") && (role = "server")]
            [#assign attributes = ", false" + attributes]
        [/#if]
    [/#if]
    [#if cluster.comments == "poll_control"]
        [#lt]  zigbee_app_info.${cluster.comments}_${role}_${endpoint} = zcl_poll_${role}_alloc(zigbee_app_info.zb, SW${endpoint}_ENDPOINT${attributes});
    [#elseif cluster.comments == "ota_upgrade"]
        [#lt]  zigbee_app_info.${cluster.comments}_${role}_${endpoint} = ZbZcl${nameAlloc?cap_first}${role?cap_first}Alloc(zigbee_app_info.zb, &ota${role?cap_first}Config${endpoint}, NULL);
    [#elseif cluster.comments == "commissioning"]
        [#lt]  zigbee_app_info.${cluster.comments}_${role}_${endpoint} = ZbZcl${nameAlloc?cap_first}${role?cap_first}Alloc(zigbee_app_info.zb, ${profileId}${attributes});
    [#elseif !(cluster.comments == "basic" && role == "server")]
        [#lt]  zigbee_app_info.${cluster.comments}_${role}_${endpoint} = ZbZcl${nameAlloc?cap_first}${role?cap_first}Alloc(zigbee_app_info.zb, SW${endpoint}_ENDPOINT${attributes});
    [/#if]
    [#if !(cluster.comments == "basic" && role == "server")]
        [#if nameAlloc == "diag" && role == "server"]
            [#lt]  assert (zigbee_app_info.${cluster.comments}_${role}_${endpoint});
        [#else]
            [#lt]  assert(zigbee_app_info.${cluster.comments}_${role}_${endpoint} != NULL);
            [#lt]  ZbZclClusterEndpointRegister(zigbee_app_info.${cluster.comments}_${role}_${endpoint});
        [/#if]
    [/#if]
[/#macro]

[#-- Variables that represent if a cluster is used or not in order to include the appropriate headers. --]
[#assign ZCL_BASIC = ""]
[#assign ZCL_IDENTIFY = ""]
[#assign ZCL_ALARMS = ""]
[#assign ZCL_TIME = ""]
[#assign ZCL_COMMISSIONING = ""]
[#assign ZCL_GROUPS = ""]
[#assign ZCL_SCENES = ""]
[#assign ZCL_OCCUPANCY = ""]
[#assign ZCL_DIAGNOSTICS = ""]
[#assign ZCL_POLL_CONTROL = ""]
[#assign ZCL_POWER_CONFIGURATION = ""]
[#assign ZCL_POWER_PROFILE = ""]
[#assign ZCL_RSSI_LOCATION = ""]
[#assign ZCL_PRESSURE_MEASUREMENT = ""]
[#assign ZCL_DEVICE_TEMPERATURE_CONFIGURATION = ""]
[#assign ZCL_TEMPERATURE_MEASUREMENT = ""]
[#assign ZCL_THERMOSTAT = ""]
[#assign ZCL_THERMOSTAT_UI_CONFIGURATION = ""]
[#assign ZCL_METER_IDENTIFICATION = ""]
[#assign ZCL_ELECTRICAL_MEASUREMENT = ""]
[#assign ZCL_FAN_CONTROL = ""]
[#assign ZCL_PUMP_CONFIGURATION_CONTROL = ""]
[#assign ZCL_RELATIVE_HUMIDITY_MEASUREMENT = ""]
[#assign ZCL_ON_OFF = ""]
[#assign ZCL_COLOR_CONTROL = ""]
[#assign ZCL_ILLUMINANCE_LEVEL_SENSING = ""]
[#assign ZCL_ILLUMINANCE_MEASUREMENT = ""]
[#assign ZCL_LEVEL_CONTROL = ""]
[#assign ZCL_ON_OFF_SWITCH_CONFIGURATION = ""]
[#assign ZCL_DOOR_LOCK = ""]
[#assign ZCL_WINDOW_COVERING = ""]
[#assign ZCL_IAS_ACE = ""]
[#assign ZCL_IAS_WD = ""]
[#assign ZCL_IAS_ZONE = ""]
[#assign ZCL_MESSAGING = ""]
[#assign ZCL_DRLC = ""]
[#assign ZCL_METERING = ""]
[#assign ZCL_PRICE = ""]
[#assign ZCL_TUNNELING = ""]
[#assign ZCL_TOUCHLINK = ""]
[#assign ZCL_GREEN_POWER_PROXY = ""]
[#assign ZCL_NEAREST_GATEWAY = ""]
[#assign ZCL_OTA_UPGRADE = ""]
[#assign ZCL_DEHUMIDIFICATION_CONTROL = ""]
[#assign ZCL_BALLAST_CONFIGURATION = ""]
[#assign ZCL_VOICE_OVER_ZGB = ""]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name?contains("ZCL_BASIC")]
                [#assign ZCL_BASIC = ZCL_BASIC + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_IDENTIFY_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_IDENTIFY = ZCL_IDENTIFY + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_ALARMS_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
            ${definition.name} = ${definition.value} !!
                [#assign ZCL_ALARMS = ZCL_ALARMS + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_TIME_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
            ${definition.name} = ${definition.value} !!
                [#assign ZCL_TIME = ZCL_TIME + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_COMMISSIONING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_COMMISSIONING = ZCL_COMMISSIONING + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_GROUPS_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_GROUPS = ZCL_GROUPS + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_SCENES_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_SCENES = ZCL_SCENES + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_OCCUPANCY_SENSING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_OCCUPANCY = ZCL_OCCUPANCY + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_DIAGNOSTICS_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_DIAGNOSTICS = ZCL_DIAGNOSTICS + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_POLL_CONTROL_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_POLL_CONTROL = ZCL_POLL_CONTROL + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_POWER_CONFIGURATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_POWER_CONFIGURATION = ZCL_POWER_CONFIGURATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_POWER_PROFILE_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_POWER_PROFILE = ZCL_POWER_PROFILE + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_RSSI_LOCATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_RSSI_LOCATION = ZCL_RSSI_LOCATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_PRESSURE_MEASUREMENT_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_PRESSURE_MEASUREMENT = ZCL_PRESSURE_MEASUREMENT + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_DEVICE_TEMPERATURE_CONFIGURATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_DEVICE_TEMPERATURE_CONFIGURATION = ZCL_DEVICE_TEMPERATURE_CONFIGURATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_TEMPERATURE_MEASUREMENT_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_TEMPERATURE_MEASUREMENT = ZCL_TEMPERATURE_MEASUREMENT + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_THERMOSTAT_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_THERMOSTAT = ZCL_THERMOSTAT + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_THERMOSTAT_UI_CONFIGURATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_THERMOSTAT_UI_CONFIGURATION = ZCL_THERMOSTAT_UI_CONFIGURATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_METER_IDENTIFICATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_METER_IDENTIFICATION = ZCL_METER_IDENTIFICATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_ELECTRICAL_MEASUREMENT_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_ELECTRICAL_MEASUREMENT = ZCL_ELECTRICAL_MEASUREMENT + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_FAN_CONTROL_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_FAN_CONTROL = ZCL_FAN_CONTROL + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_PUMP_CONFIGURATION_CONTROL_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_PUMP_CONFIGURATION_CONTROL = ZCL_PUMP_CONFIGURATION_CONTROL + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_RELATIVE_HUMIDITY_MEASUREMENT_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_RELATIVE_HUMIDITY_MEASUREMENT = ZCL_RELATIVE_HUMIDITY_MEASUREMENT + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_ON_OFF_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_ON_OFF = ZCL_ON_OFF + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_COLOR_CONTROL_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_COLOR_CONTROL = ZCL_COLOR_CONTROL + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_ILLUMINANCE_LEVEL_SENSING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_ILLUMINANCE_LEVEL_SENSING = ZCL_ILLUMINANCE_LEVEL_SENSING + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_ILLUMINANCE_MEASUREMENT_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_ILLUMINANCE_MEASUREMENT = ZCL_ILLUMINANCE_MEASUREMENT + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_LEVEL_CONTROL_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_LEVEL_CONTROL = ZCL_LEVEL_CONTROL + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_ON_OFF_SWITCH_CONFIGURATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_ON_OFF_SWITCH_CONFIGURATION = ZCL_ON_OFF_SWITCH_CONFIGURATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_DOOR_LOCK_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_DOOR_LOCK = ZCL_DOOR_LOCK + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_WINDOW_COVERING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_WINDOW_COVERING = ZCL_WINDOW_COVERING + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_IAS_ACE_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_IAS_ACE = ZCL_IAS_ACE + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_IAS_WD_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_IAS_WD = ZCL_IAS_WD + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_IAS_ZONE_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_IAS_ZONE = ZCL_IAS_ZONE + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_MESSAGING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_MESSAGING = ZCL_MESSAGING + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_DRLC_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_DRLC = ZCL_DRLC + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_METERING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_METERING = ZCL_METERING + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_PRICE_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_PRICE = ZCL_PRICE + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_TUNNELING_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_TUNNELING = ZCL_TUNNELING + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_NEAREST_GATEWAY_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_NEAREST_GATEWAY = ZCL_NEAREST_GATEWAY + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_OTA_UPGRADE_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_OTA_UPGRADE = ZCL_OTA_UPGRADE + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_DEHUMIDIFICATION_CONTROL_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_DEHUMIDIFICATION_CONTROL = ZCL_DEHUMIDIFICATION_CONTROL + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_BALLAST_CONFIGURATION_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_BALLAST_CONFIGURATION = ZCL_BALLAST_CONFIGURATION + definition.value]
            [/#if]
            [#if definition.name?contains("ZCL_VOICE_OVER_ZGB_ENDPOINT") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                [#assign ZCL_VOICE_OVER_ZGB = ZCL_VOICE_OVER_ZGB + definition.value]
            [/#if]
            [#if definition.name == "ZGB_APPLICATION"]
                [#assign ZGB_APPLICATION = definition.value]
            [/#if]
            [#if definition.name == "ZGB_NW_MODE"]
                [#assign ZGB_NW_MODE = definition.value]
            [/#if]
            [#if definition.name == "ZGB_DEVICE_ROLE"]
                [#assign ZGB_DEVICE_ROLE = definition.value]
            [/#if]
            [#if definition.name == "ZGB_TOUCHLINK_CAPABILITY"]
            	[#assign ZGB_TOUCHLINK_CAPABILITY = definition.value]
            [/#if]
            [#if definition.name == "ZGB_NB_ENDPOINTS"]
                [#assign ZGB_NB_ENDPOINTS = (definition.value)?number]
            [/#if]
            [#if definition.name == "ZGB_CHANNEL"]
                [#assign ZGB_CHANNEL = definition.value]
            [/#if]
            [#if definition.name == "ZGB_SLEEPY_MODE"]
                [#assign ZGB_SLEEPY_MODE = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]


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
#include <assert.h>
#include "zcl/zcl.h"
[#if ZCL_BASIC?contains("CLIENT")]
#include "zcl/zcl.basic.h"
[/#if]
[#if ZCL_IDENTIFY != ""]
#include "zcl/zcl.identify.h"
[/#if]
[#if ZCL_ALARMS != ""]
#include "zcl/zcl.alarm.h"
[/#if]
[#if ZCL_TIME != ""]
#include "zcl/zcl.time.h"
[/#if]
[#if ZCL_COMMISSIONING != ""]
#include "zcl/zcl.commission.h"
[/#if]
[#if ZCL_GROUPS != ""]
#include "zcl/zcl.groups.h"
[/#if]
[#if ZCL_SCENES != ""]
#include "zcl/zcl.scenes.h"
[/#if]
[#if ZCL_OCCUPANCY != ""]
#include "zcl/zcl.occupancy.h"
[/#if]
[#if ZCL_DIAGNOSTICS != ""]
#include "zcl/zcl.diagnostics.h"
[/#if]
[#if ZCL_POLL_CONTROL != ""]
#include "zcl/zcl.poll.control.h"
[/#if]
[#if ZCL_POWER_CONFIGURATION != ""]
#include "zcl/zcl.power.config.h"
[/#if]
[#if ZCL_POWER_PROFILE != ""]
#include "zcl/zcl.power.profile.h"
[/#if]
[#if ZCL_RSSI_LOCATION != ""]
#include "zcl/zcl.rssi.loc.h"
[/#if]
[#if ZCL_PRESSURE_MEASUREMENT != ""]
#include "zcl/zcl.press.meas.h"
[/#if]
[#if ZCL_DEVICE_TEMPERATURE_CONFIGURATION != ""]
#include "zcl/zcl.device.temp.h"
[/#if]
[#if ZCL_TEMPERATURE_MEASUREMENT != ""]
#include "zcl/zcl.temp.meas.h"
[/#if]
[#if ZCL_THERMOSTAT != ""]
#include "zcl/zcl.therm.h"
[/#if]
[#if ZCL_THERMOSTAT_UI_CONFIGURATION != ""]
#include "zcl/zcl.therm.ui.h"
[/#if]
[#if ZCL_METER_IDENTIFICATION != ""]
#include "zcl/zcl.meter.id.h"
[/#if]
[#if ZCL_ELECTRICAL_MEASUREMENT != ""]
#include "zcl/zcl.elec.meas.h"
[/#if]
[#if ZCL_FAN_CONTROL != ""]
#include "zcl/zcl.fan.h"
[/#if]
[#if ZCL_PUMP_CONFIGURATION_CONTROL != ""]
#include "zcl/zcl.pump.h"
[/#if]
[#if ZCL_RELATIVE_HUMIDITY_MEASUREMENT != ""]
#include "zcl/zcl.water.content.meas.h"
[/#if]
[#if ZCL_ON_OFF != ""]
#include "zcl/zcl.onoff.h"
[/#if]
[#if ZCL_COLOR_CONTROL != ""]
#include "zcl/zcl.color.h"
[/#if]
[#if ZCL_ILLUMINANCE_LEVEL_SENSING != ""]
#include "zcl/zcl.illum.level.h"
[/#if]
[#if ZCL_ILLUMINANCE_MEASUREMENT != ""]
#include "zcl/zcl.illum.meas.h"
[/#if]
[#if ZCL_LEVEL_CONTROL != ""]
#include "zcl/zcl.level.h"
[/#if]
[#if ZCL_ON_OFF_SWITCH_CONFIGURATION != ""]
#include "zcl/zcl.onoff.swconfig.h"
[/#if]
[#if ZCL_DOOR_LOCK != ""]
#include "zcl/zcl.doorlock.h"
[/#if]
[#if ZCL_WINDOW_COVERING != ""]
#include "zcl/zcl.window.h"
[/#if]
[#if ZCL_IAS_ACE != ""]
#include "zcl/security/zcl.ias_ace.h"
[/#if]
[#if ZCL_IAS_WD != ""]
#include "zcl/security/zcl.ias_wd.h"
[/#if]
[#if ZCL_IAS_ZONE != ""]
#include "zcl/security/zcl.ias_zone.h"
[/#if]
[#if ZCL_MESSAGING != ""]
#include "zcl/se/zcl.message.h"
[/#if]
[#if ZCL_DRLC != ""]
#include "zcl/se/zcl.drlc.h"
[/#if]
[#if ZCL_METERING != ""]
#include "zcl/se/zcl.meter.h"
[/#if]
[#if ZCL_PRICE != ""]
#include "zcl/se/zcl.price.h"
[/#if]
[#if ZCL_TUNNELING != ""]
#include "zcl/se/zcl.tunnel.h"
[/#if]
[#if ZCL_NEAREST_GATEWAY != ""]
#include "zcl/zcl.nearest.gw.h"
[/#if]
[#if ZCL_OTA_UPGRADE != ""]
#include "zcl/zcl.ota.h"
[/#if]
[#if ZCL_DEHUMIDIFICATION_CONTROL != ""]
#include "zcl/zcl.dehum.ctrl.h"
[/#if]
[#if ZCL_BALLAST_CONFIGURATION != ""]
#include "zcl/zcl.ballast.config.h"
[/#if]
[#if ZCL_VOICE_OVER_ZGB != ""]
#include "zcl/zcl.voice.h"
[/#if]

/* USER CODE BEGIN Includes */
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */
/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
#define APP_ZIGBEE_STARTUP_FAIL_DELAY               500U
[#if ZGB_NW_MODE == "TOUCHLINK"]
#define TOUCHLINK_ENDPOINT                          200
#define APP_TOUCHLINK_MIN_RSSI                      -60
[#else]
#define CHANNEL                                     ${ZGB_CHANNEL}
[/#if]
[#if ZGB_DEVICE_ROLE == "END_DEVICE" || ZGB_APPLICATION == "RFD"]
#define ZED_SLEEP_TIME_30S                           1 /* 30s sleep time unit */
[/#if]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#assign numEndpoint = 1]
        [#list SWIP.defines as definition]
            [#if definition.name == ("ENDPOINT" + numEndpoint + "_ID")]
                #define SW${numEndpoint}_ENDPOINT                                ${definition.value}[#lt]
                [#assign numEndpoint = numEndpoint + 1]

            [/#if]
        [/#list]
    [/#if]
[/#list]
[#if ZCL_ALARMS?contains("SERVER")]
    /* Alarm specific defines ------------------------------------------------*/[#lt]
    #define ZCL_ALARM_LOG_ENTRY_NB                      4U[#lt]
    /* USER CODE BEGIN Alarm defines */[#lt]
    /* USER CODE END Alarm defines */[#lt]

[/#if]
[#if ZCL_SCENES?contains("SERVER")]
    /* Scenes specific defines -----------------------------------------------*/[#lt]
    #define ZCL_SCENES_MAX_SCENES                       40U[#lt]
    /* USER CODE BEGIN Scenes defines */[#lt]
    /* USER CODE END Scenes defines */[#lt]

[/#if]
[#if ZCL_COMMISSIONING?contains("CLIENT")]
    /* Commissioning specific defines ----------------------------------------*/[#lt]
    #define APS_SECURED                                 false[#lt]
    /* USER CODE BEGIN Commissioning defines */[#lt]
    /* USER CODE END Commissioning defines */[#lt]

[/#if]
[#if ZCL_DIAGNOSTICS?contains("SERVER")]
    /* Diagnostics specific defines ------------------------------------------*/[#lt]
    #define MIN_SECURITY                                ZB_APS_STATUS_UNSECURED[#lt]
    /* USER CODE BEGIN Diagnostics defines */[#lt]
    /* USER CODE END Diagnostics defines */[#lt]

[/#if]
[#if ZCL_PRESSURE_MEASUREMENT?contains("SERVER")]
    /* Pressure measurement specific defines ---------------------------------*/[#lt]
    #define PRESS_MIN                                   ZCL_PRESS_MEAS_MIN_VAL_MIN[#lt]
    #define PRESS_MAX                                   ZCL_PRESS_MEAS_MAX_VAL_MAX[#lt]
    /* USER CODE BEGIN Pressure measurement defines */[#lt]
    /* USER CODE END Pressure measurement defines */[#lt]

[/#if]
[#if ZCL_TEMPERATURE_MEASUREMENT?contains("SERVER")]
    /* Temperature measurement specific defines ------------------------------*/[#lt]
    #define TEMP_MIN                                    ZCL_TEMP_MEAS_MIN_MEAS_VAL_MIN[#lt]
    #define TEMP_MAX                                    ZCL_TEMP_MEAS_MAX_MEAS_VAL_MAX[#lt]
    #define TEMP_TOLERANCE                              ZCL_TEMP_MEAS_TOLERANCE_MAX[#lt]
    /* USER CODE BEGIN Temperature measurement defines */[#lt]
    /* USER CODE END Temperature measurement defines */[#lt]

[/#if]
[#if ZCL_ILLUMINANCE_MEASUREMENT?contains("SERVER")]
    /* Illuminance measurement specific defines ------------------------------*/[#lt]
    #define ILLUM_MIN                                   ZCL_ILLUM_MEAS_MIN_MEAS_VAL_MIN[#lt]
    #define ILLUM_MAX                                   ZCL_ILLUM_MEAS_MAX_MEAS_VAL_MAX[#lt]
    /* USER CODE BEGIN Illuminance measurement defines */[#lt]
    /* USER CODE END Illuminance measurement defines */[#lt]

[/#if]
[#if ZCL_ON_OFF_SWITCH_CONFIGURATION?contains("SERVER")]
    /* OnOff switch configuration specific defines ---------------------------*/[#lt]
    #define SWITCH_TYPE                                 ZCL_ONOFF_SWCONFIG_ON_OFF[#lt]
    /* USER CODE BEGIN OnOff switch configuration defines */[#lt]
    /* USER CODE END OnOff switch configuration defines */[#lt]

[/#if]
[#if ZCL_BALLAST_CONFIGURATION?contains("SERVER")]
    /* Ballast configuration specific defines --------------------------------*/[#lt]
    #define BALLAST_PHY_MIN                             ZCL_BALLAST_CONFIG_PHY_MIN_LEVEL_MIN[#lt]
    #define BALLAST_PHY_MAX                             ZCL_BALLAST_CONFIG_PHY_MAX_LEVEL_MAX[#lt]
    /* USER CODE BEGIN Ballast configuration defines */[#lt]
    /* USER CODE END Ballast configuration defines */[#lt]

[/#if]
[#if ZCL_RELATIVE_HUMIDITY_MEASUREMENT?contains("SERVER")]
    /* Relative humidity specific defines ------------------------------------*/[#lt]
    #define HUMIDITY_MIN                                ZCL_WC_MEAS_MIN_MEAS_VAL_MIN[#lt]
    #define HUMIDITY_MAX                                ZCL_WC_MEAS_MAX_MEAS_VAL_MAX[#lt]
    /* USER CODE BEGIN Relative humidity defines */[#lt]
    /* USER CODE END Relative humidity defines */[#lt]

[/#if]
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

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#assign numEndpoint = 1]
        [#list SWIP.defines as definition]
            [#if definition.name == ("ENDPOINT" + numEndpoint + "_ID")]
                [#list SWIPdatas as SWIP]
                    [#list SWIP.defines as definition]
                        [#if definition.name?contains("" + numEndpoint) && definition.name?contains("ZCL_")]
                            [@generateZgbClusterDefinition definition numEndpoint/][#lt]
                        [/#if]
                    [/#list]
                [/#list]
                [#assign numEndpoint = numEndpoint + 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
};
static struct zigbee_app_info zigbee_app_info;

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#assign numEndpoint = 1]
        [#list SWIP.defines as definition]
            [#if definition.name == ("ENDPOINT" + numEndpoint + "_ID")]
                [#list SWIPdatas as SWIP]
                    [#list SWIP.defines as definition]
                        [#if definition.name?contains("" + numEndpoint) && definition.name?contains("ZCL_")]
                            [@ZgbCallbacks definition numEndpoint "declaration"/][#lt]
                        [/#if]
                    [/#list]
                [/#list]
                [#assign numEndpoint = numEndpoint + 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* USER CODE BEGIN PV */
/* USER CODE END PV */
/* Functions Definition ------------------------------------------------------*/
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#assign numEndpoint = 1]
        [#list SWIP.defines as definition]
            [#if definition.name == ("ENDPOINT" + numEndpoint + "_ID")]
                [#list SWIPdatas as SWIP]
                    [#list SWIP.defines as definition]
                        [#if definition.name?contains("" + numEndpoint) && definition.name?contains("ZCL_")]
                            [@ZgbCallbacks definition numEndpoint "definition"/][#lt]
                        [/#if]
                    [/#list]
                [/#list]
                [#assign numEndpoint = numEndpoint + 1]
            [/#if]
        [/#list]
    [/#if]
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
[#if ZGB_NW_MODE != "TOUCHLINK"]
    [#if ZGB_DEVICE_ROLE == "COORDINATOR" && ZGB_NW_MODE == "CENTRALIZED"]
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
  ZbApsmeAddEndpointReqT req;
  ZbApsmeAddEndpointConfT conf;

  memset(&req, 0, sizeof(req));

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#assign numEndpoint = 1]
        [#list SWIP.defines as definition]
            [#if definition.name?contains("_PROFILE_ID") && definition.name?contains("" + numEndpoint)]
                [#assign profileId = definition.value]
                [#lt]  /* Endpoint: SW${numEndpoint}_ENDPOINT */
                [#lt]  req.profileId = ${definition.value};
            [/#if]
            [#if definition.name?contains("_DEVICE_ID") && definition.name?contains("" + numEndpoint) && definition.value!="valueNotSetted"]
                [#assign isEndpoint = true]
                [#lt]  req.deviceId = ${definition.value};
                [#lt]  req.endpoint = SW${numEndpoint}_ENDPOINT;
                [#lt]  ZbZclAddEndpoint(zigbee_app_info.zb, &req, &conf);
                [#lt]  assert(conf.status == ZB_STATUS_SUCCESS);

                [#list SWIPdatas as SWIP]
                    [#if SWIP.defines??]
                        [#list SWIP.defines as definition]
                            [#if definition.name?contains("" + numEndpoint) && definition.name?contains("ZCL_") && definition.value!="NONE" && definition.value!="valueNotSetted"]
                                [@initZgbClusterAlloc definition numEndpoint profileId/]
                            [/#if]
                        [/#list]
                    [/#if]
                [/#list]
                [#assign numEndpoint = numEndpoint + 1]
            [/#if]
        [/#list]
    [/#if]
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

    /* Set the ${ZGB_NW_MODE?lower_case} network */
    APP_DBG("Network config : APP_STARTUP_${ZGB_NW_MODE}[#if ZGB_NW_MODE == "CENTRALIZED"]_${ZGB_DEVICE_ROLE}[/#if]");
    [#if ZGB_NW_MODE != "TOUCHLINK"]
    config.startupControl = zigbee_app_info.startupControl;
    [/#if]

    [#if ZGB_NW_MODE == "DISTRIBUTED"]
    /* Set the TC address to be distributed. */
    config.security.trustCenterAddress = ZB_DISTRIBUTED_TC_ADDR;

    [/#if]
    [#if ZGB_NW_MODE == "DISTRIBUTED" || ZGB_NW_MODE == "TOUCHLINK"]
    /* Using the Uncertified Distributed Global Key (d0:d1:d2:d3:d4:d5:d6:d7:d8:d9:da:db:dc:dd:de:df) */
        [#if ZGB_NW_MODE == "TOUCHLINK"]
    /* This key can be used as an APS Link Key between Touchlink devices.*/
        [/#if]
    memcpy(config.security.distributedGlobalKey, sec_key_distrib_uncert, ZB_SEC_KEYSIZE);

    [/#if]
    [#if ZGB_NW_MODE == "TOUCHLINK"]
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
    [#if ZGB_NW_MODE == "CENTRALIZED"]
    /* Using the default HA preconfigured Link Key */
    memcpy(config.security.preconfiguredLinkKey, sec_key_ha, ZB_SEC_KEYSIZE);

    [/#if]
    [#if ZGB_NW_MODE != "TOUCHLINK"]
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
      /* USER CODE BEGIN ${userCodeIndex} */
      zigbee_app_info.join_delay = 0U;
    }
    else
    {
      /* USER CODE END ${userCodeIndex} */
      [#assign userCodeIndex = userCodeIndex +1]
      [#if ZGB_NW_MODE == "DISTRIBUTED" && ZGB_APPLICATION != "RFD"]
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
 *        and display associated informations
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
 * @brief  This function is called when the M0+ acknoledge the fact that it has received a Cmd
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

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

