[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Custom Example Application (Server)
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign NUMBER_OF_SERVICES = "0"]
[#assign SERVICE1_NUMBER_OF_CHARACTERISTICS = 0]
[#assign SERVICE2_NUMBER_OF_CHARACTERISTICS = 0]
[#assign SERVICE3_NUMBER_OF_CHARACTERISTICS = 0]
[#assign SERVICE4_NUMBER_OF_CHARACTERISTICS = 0]
[#assign SERVICE5_NUMBER_OF_CHARACTERISTICS = 0]

[#assign SERVICE1_LONG_NAME = ""]
[#assign SERVICE2_LONG_NAME = ""]
[#assign SERVICE3_LONG_NAME = ""]
[#assign SERVICE4_LONG_NAME = ""]
[#assign SERVICE5_LONG_NAME = ""]

[#assign SERVICE1_SHORT_NAME = ""]
[#assign SERVICE2_SHORT_NAME = ""]
[#assign SERVICE3_SHORT_NAME = ""]
[#assign SERVICE4_SHORT_NAME = ""]
[#assign SERVICE5_SHORT_NAME = ""]

[#assign SERVICE1_CHAR1_LONG_NAME = ""]
[#assign SERVICE1_CHAR2_LONG_NAME = ""]
[#assign SERVICE1_CHAR3_LONG_NAME = ""]
[#assign SERVICE1_CHAR4_LONG_NAME = ""]
[#assign SERVICE1_CHAR5_LONG_NAME = ""]
[#assign SERVICE2_CHAR1_LONG_NAME = ""]
[#assign SERVICE2_CHAR2_LONG_NAME = ""]
[#assign SERVICE2_CHAR3_LONG_NAME = ""]
[#assign SERVICE2_CHAR4_LONG_NAME = ""]
[#assign SERVICE2_CHAR5_LONG_NAME = ""]
[#assign SERVICE3_CHAR1_LONG_NAME = ""]
[#assign SERVICE3_CHAR2_LONG_NAME = ""]
[#assign SERVICE3_CHAR3_LONG_NAME = ""]
[#assign SERVICE3_CHAR4_LONG_NAME = ""]
[#assign SERVICE3_CHAR5_LONG_NAME = ""]
[#assign SERVICE4_CHAR1_LONG_NAME = ""]
[#assign SERVICE4_CHAR2_LONG_NAME = ""]
[#assign SERVICE4_CHAR3_LONG_NAME = ""]
[#assign SERVICE4_CHAR4_LONG_NAME = ""]
[#assign SERVICE4_CHAR5_LONG_NAME = ""]
[#assign SERVICE5_CHAR1_LONG_NAME = ""]
[#assign SERVICE5_CHAR2_LONG_NAME = ""]
[#assign SERVICE5_CHAR3_LONG_NAME = ""]
[#assign SERVICE5_CHAR4_LONG_NAME = ""]
[#assign SERVICE5_CHAR5_LONG_NAME = ""]

[#assign SERVICE1_CHAR1_SHORT_NAME = ""]
[#assign SERVICE1_CHAR2_SHORT_NAME = ""]
[#assign SERVICE1_CHAR3_SHORT_NAME = ""]
[#assign SERVICE1_CHAR4_SHORT_NAME = ""]
[#assign SERVICE1_CHAR5_SHORT_NAME = ""]
[#assign SERVICE2_CHAR1_SHORT_NAME = ""]
[#assign SERVICE2_CHAR2_SHORT_NAME = ""]
[#assign SERVICE2_CHAR3_SHORT_NAME = ""]
[#assign SERVICE2_CHAR4_SHORT_NAME = ""]
[#assign SERVICE2_CHAR5_SHORT_NAME = ""]
[#assign SERVICE3_CHAR1_SHORT_NAME = ""]
[#assign SERVICE3_CHAR2_SHORT_NAME = ""]
[#assign SERVICE3_CHAR3_SHORT_NAME = ""]
[#assign SERVICE3_CHAR4_SHORT_NAME = ""]
[#assign SERVICE3_CHAR5_SHORT_NAME = ""]
[#assign SERVICE4_CHAR1_SHORT_NAME = ""]
[#assign SERVICE4_CHAR2_SHORT_NAME = ""]
[#assign SERVICE4_CHAR3_SHORT_NAME = ""]
[#assign SERVICE4_CHAR4_SHORT_NAME = ""]
[#assign SERVICE4_CHAR5_SHORT_NAME = ""]
[#assign SERVICE5_CHAR1_SHORT_NAME = ""]
[#assign SERVICE5_CHAR2_SHORT_NAME = ""]
[#assign SERVICE5_CHAR3_SHORT_NAME = ""]
[#assign SERVICE5_CHAR4_SHORT_NAME = ""]
[#assign SERVICE5_CHAR5_SHORT_NAME = ""]

[#assign SERVICE1_CHAR1_PROP_BROADCAST = ""]
[#assign SERVICE1_CHAR2_PROP_BROADCAST = ""]
[#assign SERVICE1_CHAR3_PROP_BROADCAST = ""]
[#assign SERVICE1_CHAR4_PROP_BROADCAST = ""]
[#assign SERVICE1_CHAR5_PROP_BROADCAST = ""]
[#assign SERVICE2_CHAR1_PROP_BROADCAST = ""]
[#assign SERVICE2_CHAR2_PROP_BROADCAST = ""]
[#assign SERVICE2_CHAR3_PROP_BROADCAST = ""]
[#assign SERVICE2_CHAR4_PROP_BROADCAST = ""]
[#assign SERVICE2_CHAR5_PROP_BROADCAST = ""]
[#assign SERVICE3_CHAR1_PROP_BROADCAST = ""]
[#assign SERVICE3_CHAR2_PROP_BROADCAST = ""]
[#assign SERVICE3_CHAR3_PROP_BROADCAST = ""]
[#assign SERVICE3_CHAR4_PROP_BROADCAST = ""]
[#assign SERVICE3_CHAR5_PROP_BROADCAST = ""]
[#assign SERVICE4_CHAR1_PROP_BROADCAST = ""]
[#assign SERVICE4_CHAR2_PROP_BROADCAST = ""]
[#assign SERVICE4_CHAR3_PROP_BROADCAST = ""]
[#assign SERVICE4_CHAR4_PROP_BROADCAST = ""]
[#assign SERVICE4_CHAR5_PROP_BROADCAST = ""]
[#assign SERVICE5_CHAR1_PROP_BROADCAST = ""]
[#assign SERVICE5_CHAR2_PROP_BROADCAST = ""]
[#assign SERVICE5_CHAR3_PROP_BROADCAST = ""]
[#assign SERVICE5_CHAR4_PROP_BROADCAST = ""]
[#assign SERVICE5_CHAR5_PROP_BROADCAST = ""]

[#assign SERVICE1_CHAR1_PROP_READ = ""]
[#assign SERVICE1_CHAR2_PROP_READ = ""]
[#assign SERVICE1_CHAR3_PROP_READ = ""]
[#assign SERVICE1_CHAR4_PROP_READ = ""]
[#assign SERVICE1_CHAR5_PROP_READ = ""]
[#assign SERVICE2_CHAR1_PROP_READ = ""]
[#assign SERVICE2_CHAR2_PROP_READ = ""]
[#assign SERVICE2_CHAR3_PROP_READ = ""]
[#assign SERVICE2_CHAR4_PROP_READ = ""]
[#assign SERVICE2_CHAR5_PROP_READ = ""]
[#assign SERVICE3_CHAR1_PROP_READ = ""]
[#assign SERVICE3_CHAR2_PROP_READ = ""]
[#assign SERVICE3_CHAR3_PROP_READ = ""]
[#assign SERVICE3_CHAR4_PROP_READ = ""]
[#assign SERVICE3_CHAR5_PROP_READ = ""]
[#assign SERVICE4_CHAR1_PROP_READ = ""]
[#assign SERVICE4_CHAR2_PROP_READ = ""]
[#assign SERVICE4_CHAR3_PROP_READ = ""]
[#assign SERVICE4_CHAR4_PROP_READ = ""]
[#assign SERVICE4_CHAR5_PROP_READ = ""]
[#assign SERVICE5_CHAR1_PROP_READ = ""]
[#assign SERVICE5_CHAR2_PROP_READ = ""]
[#assign SERVICE5_CHAR3_PROP_READ = ""]
[#assign SERVICE5_CHAR4_PROP_READ = ""]
[#assign SERVICE5_CHAR5_PROP_READ = ""]

[#assign SERVICE1_CHAR1_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE1_CHAR2_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE1_CHAR3_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE1_CHAR4_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE1_CHAR5_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE2_CHAR1_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE2_CHAR2_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE2_CHAR3_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE2_CHAR4_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE2_CHAR5_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE3_CHAR1_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE3_CHAR2_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE3_CHAR3_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE3_CHAR4_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE3_CHAR5_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE4_CHAR1_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE4_CHAR2_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE4_CHAR3_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE4_CHAR4_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE4_CHAR5_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE5_CHAR1_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE5_CHAR2_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE5_CHAR3_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE5_CHAR4_PROP_WRITE_WITHOUT_RESP = ""]
[#assign SERVICE5_CHAR5_PROP_WRITE_WITHOUT_RESP = ""]

[#assign SERVICE1_CHAR1_PROP_WRITE = ""]
[#assign SERVICE1_CHAR2_PROP_WRITE = ""]
[#assign SERVICE1_CHAR3_PROP_WRITE = ""]
[#assign SERVICE1_CHAR4_PROP_WRITE = ""]
[#assign SERVICE1_CHAR5_PROP_WRITE = ""]
[#assign SERVICE2_CHAR1_PROP_WRITE = ""]
[#assign SERVICE2_CHAR2_PROP_WRITE = ""]
[#assign SERVICE2_CHAR3_PROP_WRITE = ""]
[#assign SERVICE2_CHAR4_PROP_WRITE = ""]
[#assign SERVICE2_CHAR5_PROP_WRITE = ""]
[#assign SERVICE3_CHAR1_PROP_WRITE = ""]
[#assign SERVICE3_CHAR2_PROP_WRITE = ""]
[#assign SERVICE3_CHAR3_PROP_WRITE = ""]
[#assign SERVICE3_CHAR4_PROP_WRITE = ""]
[#assign SERVICE3_CHAR5_PROP_WRITE = ""]
[#assign SERVICE4_CHAR1_PROP_WRITE = ""]
[#assign SERVICE4_CHAR2_PROP_WRITE = ""]
[#assign SERVICE4_CHAR3_PROP_WRITE = ""]
[#assign SERVICE4_CHAR4_PROP_WRITE = ""]
[#assign SERVICE4_CHAR5_PROP_WRITE = ""]
[#assign SERVICE5_CHAR1_PROP_WRITE = ""]
[#assign SERVICE5_CHAR2_PROP_WRITE = ""]
[#assign SERVICE5_CHAR3_PROP_WRITE = ""]
[#assign SERVICE5_CHAR4_PROP_WRITE = ""]
[#assign SERVICE5_CHAR5_PROP_WRITE = ""]

[#assign SERVICE1_CHAR1_PROP_NOTIFY = ""]
[#assign SERVICE1_CHAR2_PROP_NOTIFY = ""]
[#assign SERVICE1_CHAR3_PROP_NOTIFY = ""]
[#assign SERVICE1_CHAR4_PROP_NOTIFY = ""]
[#assign SERVICE1_CHAR5_PROP_NOTIFY = ""]
[#assign SERVICE2_CHAR1_PROP_NOTIFY = ""]
[#assign SERVICE2_CHAR2_PROP_NOTIFY = ""]
[#assign SERVICE2_CHAR3_PROP_NOTIFY = ""]
[#assign SERVICE2_CHAR4_PROP_NOTIFY = ""]
[#assign SERVICE2_CHAR5_PROP_NOTIFY = ""]
[#assign SERVICE3_CHAR1_PROP_NOTIFY = ""]
[#assign SERVICE3_CHAR2_PROP_NOTIFY = ""]
[#assign SERVICE3_CHAR3_PROP_NOTIFY = ""]
[#assign SERVICE3_CHAR4_PROP_NOTIFY = ""]
[#assign SERVICE3_CHAR5_PROP_NOTIFY = ""]
[#assign SERVICE4_CHAR1_PROP_NOTIFY = ""]
[#assign SERVICE4_CHAR2_PROP_NOTIFY = ""]
[#assign SERVICE4_CHAR3_PROP_NOTIFY = ""]
[#assign SERVICE4_CHAR4_PROP_NOTIFY = ""]
[#assign SERVICE4_CHAR5_PROP_NOTIFY = ""]
[#assign SERVICE5_CHAR1_PROP_NOTIFY = ""]
[#assign SERVICE5_CHAR2_PROP_NOTIFY = ""]
[#assign SERVICE5_CHAR3_PROP_NOTIFY = ""]
[#assign SERVICE5_CHAR4_PROP_NOTIFY = ""]
[#assign SERVICE5_CHAR5_PROP_NOTIFY = ""]

[#assign SERVICE1_CHAR1_PROP_INDICATE = ""]
[#assign SERVICE1_CHAR2_PROP_INDICATE = ""]
[#assign SERVICE1_CHAR3_PROP_INDICATE = ""]
[#assign SERVICE1_CHAR4_PROP_INDICATE = ""]
[#assign SERVICE1_CHAR5_PROP_INDICATE = ""]
[#assign SERVICE2_CHAR1_PROP_INDICATE = ""]
[#assign SERVICE2_CHAR2_PROP_INDICATE = ""]
[#assign SERVICE2_CHAR3_PROP_INDICATE = ""]
[#assign SERVICE2_CHAR4_PROP_INDICATE = ""]
[#assign SERVICE2_CHAR5_PROP_INDICATE = ""]
[#assign SERVICE3_CHAR1_PROP_INDICATE = ""]
[#assign SERVICE3_CHAR2_PROP_INDICATE = ""]
[#assign SERVICE3_CHAR3_PROP_INDICATE = ""]
[#assign SERVICE3_CHAR4_PROP_INDICATE = ""]
[#assign SERVICE3_CHAR5_PROP_INDICATE = ""]
[#assign SERVICE4_CHAR1_PROP_INDICATE = ""]
[#assign SERVICE4_CHAR2_PROP_INDICATE = ""]
[#assign SERVICE4_CHAR3_PROP_INDICATE = ""]
[#assign SERVICE4_CHAR4_PROP_INDICATE = ""]
[#assign SERVICE4_CHAR5_PROP_INDICATE = ""]
[#assign SERVICE5_CHAR1_PROP_INDICATE = ""]
[#assign SERVICE5_CHAR2_PROP_INDICATE = ""]
[#assign SERVICE5_CHAR3_PROP_INDICATE = ""]
[#assign SERVICE5_CHAR4_PROP_INDICATE = ""]
[#assign SERVICE5_CHAR5_PROP_INDICATE = ""]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if (definition.name == "NUMBER_OF_SERVICES")]
                [#assign NUMBER_OF_SERVICES = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_NUMBER_OF_CHARACTERISTICS")]
                [#assign SERVICE1_NUMBER_OF_CHARACTERISTICS = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_NUMBER_OF_CHARACTERISTICS")]
                [#assign SERVICE2_NUMBER_OF_CHARACTERISTICS = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_NUMBER_OF_CHARACTERISTICS")]
                [#assign SERVICE3_NUMBER_OF_CHARACTERISTICS = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_NUMBER_OF_CHARACTERISTICS")]
                [#assign SERVICE4_NUMBER_OF_CHARACTERISTICS = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_NUMBER_OF_CHARACTERISTICS")]
                [#assign SERVICE5_NUMBER_OF_CHARACTERISTICS = definition.value]
            [/#if]

            [#if (definition.name == "SERVICE1_LONG_NAME")]
                [#assign SERVICE1_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_LONG_NAME")]
                [#assign SERVICE2_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_LONG_NAME")]
                [#assign SERVICE3_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_LONG_NAME")]
                [#assign SERVICE4_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_LONG_NAME")]
                [#assign SERVICE5_LONG_NAME = definition.value]
            [/#if]

            [#if (definition.name == "SERVICE1_SHORT_NAME")]
                [#assign SERVICE1_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_SHORT_NAME")]
                [#assign SERVICE2_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_SHORT_NAME")]
                [#assign SERVICE3_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_SHORT_NAME")]
                [#assign SERVICE4_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_SHORT_NAME")]
                [#assign SERVICE5_SHORT_NAME = definition.value]
            [/#if]

            [#if (definition.name == "SERVICE1_CHAR1_LONG_NAME")]
                [#assign SERVICE1_CHAR1_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR2_LONG_NAME")]
                [#assign SERVICE1_CHAR2_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR3_LONG_NAME")]
                [#assign SERVICE1_CHAR3_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR4_LONG_NAME")]
                [#assign SERVICE1_CHAR4_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR5_LONG_NAME")]
                [#assign SERVICE1_CHAR5_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR1_LONG_NAME")]
                [#assign SERVICE2_CHAR1_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR2_LONG_NAME")]
                [#assign SERVICE2_CHAR2_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR3_LONG_NAME")]
                [#assign SERVICE2_CHAR3_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR4_LONG_NAME")]
                [#assign SERVICE2_CHAR4_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR5_LONG_NAME")]
                [#assign SERVICE2_CHAR5_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR1_LONG_NAME")]
                [#assign SERVICE3_CHAR1_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR2_LONG_NAME")]
                [#assign SERVICE3_CHAR2_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR3_LONG_NAME")]
                [#assign SERVICE3_CHAR3_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR4_LONG_NAME")]
                [#assign SERVICE3_CHAR4_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR5_LONG_NAME")]
                [#assign SERVICE3_CHAR5_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR1_LONG_NAME")]
                [#assign SERVICE4_CHAR1_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR2_LONG_NAME")]
                [#assign SERVICE4_CHAR2_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR3_LONG_NAME")]
                [#assign SERVICE4_CHAR3_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR4_LONG_NAME")]
                [#assign SERVICE4_CHAR4_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR5_LONG_NAME")]
                [#assign SERVICE4_CHAR5_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR1_LONG_NAME")]
                [#assign SERVICE5_CHAR1_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR2_LONG_NAME")]
                [#assign SERVICE5_CHAR2_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR3_LONG_NAME")]
                [#assign SERVICE5_CHAR3_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR4_LONG_NAME")]
                [#assign SERVICE5_CHAR4_LONG_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR5_LONG_NAME")]
                [#assign SERVICE5_CHAR5_LONG_NAME = definition.value]
            [/#if]

            [#if (definition.name == "SERVICE1_CHAR1_SHORT_NAME")]
                [#assign SERVICE1_CHAR1_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR2_SHORT_NAME")]
                [#assign SERVICE1_CHAR2_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR3_SHORT_NAME")]
                [#assign SERVICE1_CHAR3_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR4_SHORT_NAME")]
                [#assign SERVICE1_CHAR4_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE1_CHAR5_SHORT_NAME")]
                [#assign SERVICE1_CHAR5_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR1_SHORT_NAME")]
                [#assign SERVICE2_CHAR1_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR2_SHORT_NAME")]
                [#assign SERVICE2_CHAR2_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR3_SHORT_NAME")]
                [#assign SERVICE2_CHAR3_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR4_SHORT_NAME")]
                [#assign SERVICE2_CHAR4_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE2_CHAR5_SHORT_NAME")]
                [#assign SERVICE2_CHAR5_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR1_SHORT_NAME")]
                [#assign SERVICE3_CHAR1_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR2_SHORT_NAME")]
                [#assign SERVICE3_CHAR2_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR3_SHORT_NAME")]
                [#assign SERVICE3_CHAR3_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR4_SHORT_NAME")]
                [#assign SERVICE3_CHAR4_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE3_CHAR5_SHORT_NAME")]
                [#assign SERVICE3_CHAR5_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR1_SHORT_NAME")]
                [#assign SERVICE4_CHAR1_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR2_SHORT_NAME")]
                [#assign SERVICE4_CHAR2_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR3_SHORT_NAME")]
                [#assign SERVICE4_CHAR3_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR4_SHORT_NAME")]
                [#assign SERVICE4_CHAR4_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE4_CHAR5_SHORT_NAME")]
                [#assign SERVICE4_CHAR5_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR1_SHORT_NAME")]
                [#assign SERVICE5_CHAR1_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR2_SHORT_NAME")]
                [#assign SERVICE5_CHAR2_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR3_SHORT_NAME")]
                [#assign SERVICE5_CHAR3_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR4_SHORT_NAME")]
                [#assign SERVICE5_CHAR4_SHORT_NAME = definition.value]
            [/#if]
            [#if (definition.name == "SERVICE5_CHAR5_SHORT_NAME")]
                [#assign SERVICE5_CHAR5_SHORT_NAME = definition.value]
            [/#if]

            [#if definition.value != ""]

                [#if (definition.name == "SERVICE1_CHAR1_PROP_BROADCAST")]
                    [#assign SERVICE1_CHAR1_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR2_PROP_BROADCAST")]
                    [#assign SERVICE1_CHAR2_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR3_PROP_BROADCAST")]
                    [#assign SERVICE1_CHAR3_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR4_PROP_BROADCAST")]
                    [#assign SERVICE1_CHAR4_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR5_PROP_BROADCAST")]
                    [#assign SERVICE1_CHAR5_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR1_PROP_BROADCAST")]
                    [#assign SERVICE2_CHAR1_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR2_PROP_BROADCAST")]
                    [#assign SERVICE2_CHAR2_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR3_PROP_BROADCAST")]
                    [#assign SERVICE2_CHAR3_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR4_PROP_BROADCAST")]
                    [#assign SERVICE2_CHAR4_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR5_PROP_BROADCAST")]
                    [#assign SERVICE2_CHAR5_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR1_PROP_BROADCAST")]
                    [#assign SERVICE3_CHAR1_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR2_PROP_BROADCAST")]
                    [#assign SERVICE3_CHAR2_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR3_PROP_BROADCAST")]
                    [#assign SERVICE3_CHAR3_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR4_PROP_BROADCAST")]
                    [#assign SERVICE3_CHAR4_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR5_PROP_BROADCAST")]
                    [#assign SERVICE3_CHAR5_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR1_PROP_BROADCAST")]
                    [#assign SERVICE4_CHAR1_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR2_PROP_BROADCAST")]
                    [#assign SERVICE4_CHAR2_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR3_PROP_BROADCAST")]
                    [#assign SERVICE4_CHAR3_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR4_PROP_BROADCAST")]
                    [#assign SERVICE4_CHAR4_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR5_PROP_BROADCAST")]
                    [#assign SERVICE4_CHAR5_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR1_PROP_BROADCAST")]
                    [#assign SERVICE5_CHAR1_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR2_PROP_BROADCAST")]
                    [#assign SERVICE5_CHAR2_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR3_PROP_BROADCAST")]
                    [#assign SERVICE5_CHAR3_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR4_PROP_BROADCAST")]
                    [#assign SERVICE5_CHAR4_PROP_BROADCAST = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR5_PROP_BROADCAST")]
                    [#assign SERVICE5_CHAR5_PROP_BROADCAST = definition.value]
                [/#if]

                [#if (definition.name == "SERVICE1_CHAR1_PROP_READ")]
                    [#assign SERVICE1_CHAR1_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR2_PROP_READ")]
                    [#assign SERVICE1_CHAR2_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR3_PROP_READ")]
                    [#assign SERVICE1_CHAR3_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR4_PROP_READ")]
                    [#assign SERVICE1_CHAR4_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR5_PROP_READ")]
                    [#assign SERVICE1_CHAR5_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR1_PROP_READ")]
                    [#assign SERVICE2_CHAR1_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR2_PROP_READ")]
                    [#assign SERVICE2_CHAR2_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR3_PROP_READ")]
                    [#assign SERVICE2_CHAR3_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR4_PROP_READ")]
                    [#assign SERVICE2_CHAR4_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR5_PROP_READ")]
                    [#assign SERVICE2_CHAR5_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR1_PROP_READ")]
                    [#assign SERVICE3_CHAR1_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR2_PROP_READ")]
                    [#assign SERVICE3_CHAR2_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR3_PROP_READ")]
                    [#assign SERVICE3_CHAR3_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR4_PROP_READ")]
                    [#assign SERVICE3_CHAR4_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR5_PROP_READ")]
                    [#assign SERVICE3_CHAR5_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR1_PROP_READ")]
                    [#assign SERVICE4_CHAR1_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR2_PROP_READ")]
                    [#assign SERVICE4_CHAR2_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR3_PROP_READ")]
                    [#assign SERVICE4_CHAR3_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR4_PROP_READ")]
                    [#assign SERVICE4_CHAR4_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR5_PROP_READ")]
                    [#assign SERVICE4_CHAR5_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR1_PROP_READ")]
                    [#assign SERVICE5_CHAR1_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR2_PROP_READ")]
                    [#assign SERVICE5_CHAR2_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR3_PROP_READ")]
                    [#assign SERVICE5_CHAR3_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR4_PROP_READ")]
                    [#assign SERVICE5_CHAR4_PROP_READ = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR5_PROP_READ")]
                    [#assign SERVICE5_CHAR5_PROP_READ = definition.value]
                [/#if]

                [#if (definition.name == "SERVICE1_CHAR1_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE1_CHAR1_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR2_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE1_CHAR2_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR3_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE1_CHAR3_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR4_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE1_CHAR4_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR5_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE1_CHAR5_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR1_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE2_CHAR1_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR2_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE2_CHAR2_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR3_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE2_CHAR3_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR4_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE2_CHAR4_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR5_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE2_CHAR5_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR1_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE3_CHAR1_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR2_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE3_CHAR2_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR3_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE3_CHAR3_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR4_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE3_CHAR4_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR5_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE3_CHAR5_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR1_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE4_CHAR1_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR2_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE4_CHAR2_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR3_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE4_CHAR3_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR4_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE4_CHAR4_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR5_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE4_CHAR5_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR1_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE5_CHAR1_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR2_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE5_CHAR2_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR3_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE5_CHAR3_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR4_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE5_CHAR4_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR5_PROP_WRITE_WITHOUT_RESP")]
                    [#assign SERVICE5_CHAR5_PROP_WRITE_WITHOUT_RESP = definition.value]
                [/#if]

                [#if (definition.name == "SERVICE1_CHAR1_PROP_WRITE")]
                    [#assign SERVICE1_CHAR1_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR2_PROP_WRITE")]
                    [#assign SERVICE1_CHAR2_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR3_PROP_WRITE")]
                    [#assign SERVICE1_CHAR3_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR4_PROP_WRITE")]
                    [#assign SERVICE1_CHAR4_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR5_PROP_WRITE")]
                    [#assign SERVICE1_CHAR5_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR1_PROP_WRITE")]
                    [#assign SERVICE2_CHAR1_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR2_PROP_WRITE")]
                    [#assign SERVICE2_CHAR2_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR3_PROP_WRITE")]
                    [#assign SERVICE2_CHAR3_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR4_PROP_WRITE")]
                    [#assign SERVICE2_CHAR4_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR5_PROP_WRITE")]
                    [#assign SERVICE2_CHAR5_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR1_PROP_WRITE")]
                    [#assign SERVICE3_CHAR1_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR2_PROP_WRITE")]
                    [#assign SERVICE3_CHAR2_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR3_PROP_WRITE")]
                    [#assign SERVICE3_CHAR3_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR4_PROP_WRITE")]
                    [#assign SERVICE3_CHAR4_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR5_PROP_WRITE")]
                    [#assign SERVICE3_CHAR5_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR1_PROP_WRITE")]
                    [#assign SERVICE4_CHAR1_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR2_PROP_WRITE")]
                    [#assign SERVICE4_CHAR2_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR3_PROP_WRITE")]
                    [#assign SERVICE4_CHAR3_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR4_PROP_WRITE")]
                    [#assign SERVICE4_CHAR4_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR5_PROP_WRITE")]
                    [#assign SERVICE4_CHAR5_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR1_PROP_WRITE")]
                    [#assign SERVICE5_CHAR1_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR2_PROP_WRITE")]
                    [#assign SERVICE5_CHAR2_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR3_PROP_WRITE")]
                    [#assign SERVICE5_CHAR3_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR4_PROP_WRITE")]
                    [#assign SERVICE5_CHAR4_PROP_WRITE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR5_PROP_WRITE")]
                    [#assign SERVICE5_CHAR5_PROP_WRITE = definition.value]
                [/#if]

                [#if (definition.name == "SERVICE1_CHAR1_PROP_NOTIFY")]
                    [#assign SERVICE1_CHAR1_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR2_PROP_NOTIFY")]
                    [#assign SERVICE1_CHAR2_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR3_PROP_NOTIFY")]
                    [#assign SERVICE1_CHAR3_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR4_PROP_NOTIFY")]
                    [#assign SERVICE1_CHAR4_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR5_PROP_NOTIFY")]
                    [#assign SERVICE1_CHAR5_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR1_PROP_NOTIFY")]
                    [#assign SERVICE2_CHAR1_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR2_PROP_NOTIFY")]
                    [#assign SERVICE2_CHAR2_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR3_PROP_NOTIFY")]
                    [#assign SERVICE2_CHAR3_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR4_PROP_NOTIFY")]
                    [#assign SERVICE2_CHAR4_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR5_PROP_NOTIFY")]
                    [#assign SERVICE2_CHAR5_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR1_PROP_NOTIFY")]
                    [#assign SERVICE3_CHAR1_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR2_PROP_NOTIFY")]
                    [#assign SERVICE3_CHAR2_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR3_PROP_NOTIFY")]
                    [#assign SERVICE3_CHAR3_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR4_PROP_NOTIFY")]
                    [#assign SERVICE3_CHAR4_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR5_PROP_NOTIFY")]
                    [#assign SERVICE3_CHAR5_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR1_PROP_NOTIFY")]
                    [#assign SERVICE4_CHAR1_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR2_PROP_NOTIFY")]
                    [#assign SERVICE4_CHAR2_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR3_PROP_NOTIFY")]
                    [#assign SERVICE4_CHAR3_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR4_PROP_NOTIFY")]
                    [#assign SERVICE4_CHAR4_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR5_PROP_NOTIFY")]
                    [#assign SERVICE4_CHAR5_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR1_PROP_NOTIFY")]
                    [#assign SERVICE5_CHAR1_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR2_PROP_NOTIFY")]
                    [#assign SERVICE5_CHAR2_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR3_PROP_NOTIFY")]
                    [#assign SERVICE5_CHAR3_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR4_PROP_NOTIFY")]
                    [#assign SERVICE5_CHAR4_PROP_NOTIFY = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR5_PROP_NOTIFY")]
                    [#assign SERVICE5_CHAR5_PROP_NOTIFY = definition.value]
                [/#if]

                [#if (definition.name == "SERVICE1_CHAR1_PROP_INDICATE")]
                    [#assign SERVICE1_CHAR1_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR2_PROP_INDICATE")]
                    [#assign SERVICE1_CHAR2_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR3_PROP_INDICATE")]
                    [#assign SERVICE1_CHAR3_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR4_PROP_INDICATE")]
                    [#assign SERVICE1_CHAR4_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE1_CHAR5_PROP_INDICATE")]
                    [#assign SERVICE1_CHAR5_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR1_PROP_INDICATE")]
                    [#assign SERVICE2_CHAR1_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR2_PROP_INDICATE")]
                    [#assign SERVICE2_CHAR2_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR3_PROP_INDICATE")]
                    [#assign SERVICE2_CHAR3_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR4_PROP_INDICATE")]
                    [#assign SERVICE2_CHAR4_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE2_CHAR5_PROP_INDICATE")]
                    [#assign SERVICE2_CHAR5_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR1_PROP_INDICATE")]
                    [#assign SERVICE3_CHAR1_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR2_PROP_INDICATE")]
                    [#assign SERVICE3_CHAR2_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR3_PROP_INDICATE")]
                    [#assign SERVICE3_CHAR3_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR4_PROP_INDICATE")]
                    [#assign SERVICE3_CHAR4_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE3_CHAR5_PROP_INDICATE")]
                    [#assign SERVICE3_CHAR5_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR1_PROP_INDICATE")]
                    [#assign SERVICE4_CHAR1_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR2_PROP_INDICATE")]
                    [#assign SERVICE4_CHAR2_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR3_PROP_INDICATE")]
                    [#assign SERVICE4_CHAR3_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR4_PROP_INDICATE")]
                    [#assign SERVICE4_CHAR4_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE4_CHAR5_PROP_INDICATE")]
                    [#assign SERVICE4_CHAR5_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR1_PROP_INDICATE")]
                    [#assign SERVICE5_CHAR1_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR2_PROP_INDICATE")]
                    [#assign SERVICE5_CHAR2_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR3_PROP_INDICATE")]
                    [#assign SERVICE5_CHAR3_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR4_PROP_INDICATE")]
                    [#assign SERVICE5_CHAR4_PROP_INDICATE = definition.value]
                [/#if]
                [#if (definition.name == "SERVICE5_CHAR5_PROP_INDICATE")]
                    [#assign SERVICE5_CHAR5_PROP_INDICATE = definition.value]
                [/#if]

            [/#if]

        [/#list]
    [/#if]
[/#list]

[#assign SERVICES_NUMBER_OF_CHARACTERISTICS = {
  "1":SERVICE1_NUMBER_OF_CHARACTERISTICS,
  "2":SERVICE2_NUMBER_OF_CHARACTERISTICS,
  "3":SERVICE3_NUMBER_OF_CHARACTERISTICS,
  "4":SERVICE4_NUMBER_OF_CHARACTERISTICS,
  "5":SERVICE5_NUMBER_OF_CHARACTERISTICS
}]

[#assign item = 0]
[#assign item_NAME_START = item]
[#assign item_LONG_NAME = item][#assign item = item + 1]
[#assign item_SHORT_NAME = item]
[#assign item_NAME_END = item]

[#assign SERVICES_NAMES = {
  "1":[SERVICE1_LONG_NAME, SERVICE1_SHORT_NAME],
  "2":[SERVICE2_LONG_NAME, SERVICE2_SHORT_NAME],
  "3":[SERVICE3_LONG_NAME, SERVICE3_SHORT_NAME],
  "4":[SERVICE4_LONG_NAME, SERVICE4_SHORT_NAME],
  "5":[SERVICE5_LONG_NAME, SERVICE5_SHORT_NAME]
}]

[#assign SERVICES_CHARS_NAMES = {
  "1":{"1":[SERVICE1_CHAR1_LONG_NAME, SERVICE1_CHAR1_SHORT_NAME],
       "2":[SERVICE1_CHAR2_LONG_NAME, SERVICE1_CHAR2_SHORT_NAME],
       "3":[SERVICE1_CHAR3_LONG_NAME, SERVICE1_CHAR3_SHORT_NAME],
       "4":[SERVICE1_CHAR4_LONG_NAME, SERVICE1_CHAR4_SHORT_NAME],
       "5":[SERVICE1_CHAR5_LONG_NAME, SERVICE1_CHAR5_SHORT_NAME]},
  "2":{"1":[SERVICE2_CHAR1_LONG_NAME, SERVICE2_CHAR1_SHORT_NAME],
       "2":[SERVICE2_CHAR2_LONG_NAME, SERVICE2_CHAR2_SHORT_NAME],
       "3":[SERVICE2_CHAR3_LONG_NAME, SERVICE2_CHAR3_SHORT_NAME],
       "4":[SERVICE2_CHAR4_LONG_NAME, SERVICE2_CHAR4_SHORT_NAME],
       "5":[SERVICE2_CHAR5_LONG_NAME, SERVICE2_CHAR5_SHORT_NAME]},
  "3":{"1":[SERVICE3_CHAR1_LONG_NAME, SERVICE3_CHAR1_SHORT_NAME],
       "2":[SERVICE3_CHAR2_LONG_NAME, SERVICE3_CHAR2_SHORT_NAME],
       "3":[SERVICE3_CHAR3_LONG_NAME, SERVICE3_CHAR3_SHORT_NAME],
       "4":[SERVICE3_CHAR4_LONG_NAME, SERVICE3_CHAR4_SHORT_NAME],
       "5":[SERVICE3_CHAR5_LONG_NAME, SERVICE3_CHAR5_SHORT_NAME]},
  "4":{"1":[SERVICE4_CHAR1_LONG_NAME, SERVICE4_CHAR1_SHORT_NAME],
       "2":[SERVICE4_CHAR2_LONG_NAME, SERVICE4_CHAR2_SHORT_NAME],
       "3":[SERVICE4_CHAR3_LONG_NAME, SERVICE4_CHAR3_SHORT_NAME],
       "4":[SERVICE4_CHAR4_LONG_NAME, SERVICE4_CHAR4_SHORT_NAME],
       "5":[SERVICE4_CHAR5_LONG_NAME, SERVICE4_CHAR5_SHORT_NAME]},
  "5":{"1":[SERVICE5_CHAR1_LONG_NAME, SERVICE5_CHAR1_SHORT_NAME],
       "2":[SERVICE5_CHAR2_LONG_NAME, SERVICE5_CHAR2_SHORT_NAME],
       "3":[SERVICE5_CHAR3_LONG_NAME, SERVICE5_CHAR3_SHORT_NAME],
       "4":[SERVICE5_CHAR4_LONG_NAME, SERVICE5_CHAR4_SHORT_NAME],
       "5":[SERVICE5_CHAR5_LONG_NAME, SERVICE5_CHAR5_SHORT_NAME]}
}]

[#assign item = 0]
[#assign item_PROP_START = item]
[#-- assign item_PROP_NONE = item][#assign item = item + 1--]
[#assign item_PROP_BROADCAST = item][#assign item = item + 1]
[#assign item_PROP_READ = item][#assign item = item + 1]
[#assign item_PROP_WRITE_WITHOUT_RESP = item][#assign item = item + 1]
[#assign item_PROP_WRITE = item][#assign item = item + 1]
[#assign item_PROP_NOTIFY = item][#assign item = item + 1]
[#assign item_PROP_INDICATE = item][#-- assign item++]
[#assign item_PROP_SIGNED_WRITE = item][#assign item++]
[# assign item_PROP_EXT = item --]
[#assign item_PROP_END = item]

[#assign SERVICES_CHARS_PROP = {
  "1":{"1":[SERVICE1_CHAR1_PROP_BROADCAST, SERVICE1_CHAR1_PROP_READ, SERVICE1_CHAR1_PROP_WRITE_WITHOUT_RESP, SERVICE1_CHAR1_PROP_WRITE, SERVICE1_CHAR1_PROP_NOTIFY, SERVICE1_CHAR1_PROP_INDICATE],
       "2":[SERVICE1_CHAR2_PROP_BROADCAST, SERVICE1_CHAR2_PROP_READ, SERVICE1_CHAR2_PROP_WRITE_WITHOUT_RESP, SERVICE1_CHAR2_PROP_WRITE, SERVICE1_CHAR2_PROP_NOTIFY, SERVICE1_CHAR2_PROP_INDICATE],
       "3":[SERVICE1_CHAR3_PROP_BROADCAST, SERVICE1_CHAR3_PROP_READ, SERVICE1_CHAR3_PROP_WRITE_WITHOUT_RESP, SERVICE1_CHAR3_PROP_WRITE, SERVICE1_CHAR3_PROP_NOTIFY, SERVICE1_CHAR3_PROP_INDICATE],
       "4":[SERVICE1_CHAR4_PROP_BROADCAST, SERVICE1_CHAR4_PROP_READ, SERVICE1_CHAR4_PROP_WRITE_WITHOUT_RESP, SERVICE1_CHAR4_PROP_WRITE, SERVICE1_CHAR4_PROP_NOTIFY, SERVICE1_CHAR4_PROP_INDICATE],
       "5":[SERVICE1_CHAR5_PROP_BROADCAST, SERVICE1_CHAR5_PROP_READ, SERVICE1_CHAR5_PROP_WRITE_WITHOUT_RESP, SERVICE1_CHAR5_PROP_WRITE, SERVICE1_CHAR5_PROP_NOTIFY, SERVICE1_CHAR5_PROP_INDICATE]},
  "2":{"1":[SERVICE2_CHAR1_PROP_BROADCAST, SERVICE2_CHAR1_PROP_READ, SERVICE2_CHAR1_PROP_WRITE_WITHOUT_RESP, SERVICE2_CHAR1_PROP_WRITE, SERVICE2_CHAR1_PROP_NOTIFY, SERVICE2_CHAR1_PROP_INDICATE],
       "2":[SERVICE2_CHAR2_PROP_BROADCAST, SERVICE2_CHAR2_PROP_READ, SERVICE2_CHAR2_PROP_WRITE_WITHOUT_RESP, SERVICE2_CHAR2_PROP_WRITE, SERVICE2_CHAR2_PROP_NOTIFY, SERVICE2_CHAR2_PROP_INDICATE],
       "3":[SERVICE2_CHAR3_PROP_BROADCAST, SERVICE2_CHAR3_PROP_READ, SERVICE2_CHAR3_PROP_WRITE_WITHOUT_RESP, SERVICE2_CHAR3_PROP_WRITE, SERVICE2_CHAR3_PROP_NOTIFY, SERVICE2_CHAR3_PROP_INDICATE],
       "4":[SERVICE2_CHAR4_PROP_BROADCAST, SERVICE2_CHAR4_PROP_READ, SERVICE2_CHAR4_PROP_WRITE_WITHOUT_RESP, SERVICE2_CHAR4_PROP_WRITE, SERVICE2_CHAR4_PROP_NOTIFY, SERVICE2_CHAR4_PROP_INDICATE],
       "5":[SERVICE2_CHAR5_PROP_BROADCAST, SERVICE2_CHAR5_PROP_READ, SERVICE2_CHAR5_PROP_WRITE_WITHOUT_RESP, SERVICE2_CHAR5_PROP_WRITE, SERVICE2_CHAR5_PROP_NOTIFY, SERVICE2_CHAR5_PROP_INDICATE]},
  "3":{"1":[SERVICE3_CHAR1_PROP_BROADCAST, SERVICE3_CHAR1_PROP_READ, SERVICE3_CHAR1_PROP_WRITE_WITHOUT_RESP, SERVICE3_CHAR1_PROP_WRITE, SERVICE3_CHAR1_PROP_NOTIFY, SERVICE3_CHAR1_PROP_INDICATE],
       "2":[SERVICE3_CHAR2_PROP_BROADCAST, SERVICE3_CHAR2_PROP_READ, SERVICE3_CHAR2_PROP_WRITE_WITHOUT_RESP, SERVICE3_CHAR2_PROP_WRITE, SERVICE3_CHAR2_PROP_NOTIFY, SERVICE3_CHAR2_PROP_INDICATE],
       "3":[SERVICE3_CHAR3_PROP_BROADCAST, SERVICE3_CHAR3_PROP_READ, SERVICE3_CHAR3_PROP_WRITE_WITHOUT_RESP, SERVICE3_CHAR3_PROP_WRITE, SERVICE3_CHAR3_PROP_NOTIFY, SERVICE3_CHAR3_PROP_INDICATE],
       "4":[SERVICE3_CHAR4_PROP_BROADCAST, SERVICE3_CHAR4_PROP_READ, SERVICE3_CHAR4_PROP_WRITE_WITHOUT_RESP, SERVICE3_CHAR4_PROP_WRITE, SERVICE3_CHAR4_PROP_NOTIFY, SERVICE3_CHAR4_PROP_INDICATE],
       "5":[SERVICE3_CHAR5_PROP_BROADCAST, SERVICE3_CHAR5_PROP_READ, SERVICE3_CHAR5_PROP_WRITE_WITHOUT_RESP, SERVICE3_CHAR5_PROP_WRITE, SERVICE3_CHAR5_PROP_NOTIFY, SERVICE3_CHAR5_PROP_INDICATE]},
  "4":{"1":[SERVICE4_CHAR1_PROP_BROADCAST, SERVICE4_CHAR1_PROP_READ, SERVICE4_CHAR1_PROP_WRITE_WITHOUT_RESP, SERVICE4_CHAR1_PROP_WRITE, SERVICE4_CHAR1_PROP_NOTIFY, SERVICE4_CHAR1_PROP_INDICATE],
       "2":[SERVICE4_CHAR2_PROP_BROADCAST, SERVICE4_CHAR2_PROP_READ, SERVICE4_CHAR2_PROP_WRITE_WITHOUT_RESP, SERVICE4_CHAR2_PROP_WRITE, SERVICE4_CHAR2_PROP_NOTIFY, SERVICE4_CHAR2_PROP_INDICATE],
       "3":[SERVICE4_CHAR3_PROP_BROADCAST, SERVICE4_CHAR3_PROP_READ, SERVICE4_CHAR3_PROP_WRITE_WITHOUT_RESP, SERVICE4_CHAR3_PROP_WRITE, SERVICE4_CHAR3_PROP_NOTIFY, SERVICE4_CHAR3_PROP_INDICATE],
       "4":[SERVICE4_CHAR4_PROP_BROADCAST, SERVICE4_CHAR4_PROP_READ, SERVICE4_CHAR4_PROP_WRITE_WITHOUT_RESP, SERVICE4_CHAR4_PROP_WRITE, SERVICE4_CHAR4_PROP_NOTIFY, SERVICE4_CHAR4_PROP_INDICATE],
       "5":[SERVICE4_CHAR5_PROP_BROADCAST, SERVICE4_CHAR5_PROP_READ, SERVICE4_CHAR5_PROP_WRITE_WITHOUT_RESP, SERVICE4_CHAR5_PROP_WRITE, SERVICE4_CHAR5_PROP_NOTIFY, SERVICE4_CHAR5_PROP_INDICATE]},
  "5":{"1":[SERVICE5_CHAR1_PROP_BROADCAST, SERVICE5_CHAR1_PROP_READ, SERVICE5_CHAR1_PROP_WRITE_WITHOUT_RESP, SERVICE5_CHAR1_PROP_WRITE, SERVICE5_CHAR1_PROP_NOTIFY, SERVICE5_CHAR1_PROP_INDICATE],
       "2":[SERVICE5_CHAR2_PROP_BROADCAST, SERVICE5_CHAR2_PROP_READ, SERVICE5_CHAR2_PROP_WRITE_WITHOUT_RESP, SERVICE5_CHAR2_PROP_WRITE, SERVICE5_CHAR2_PROP_NOTIFY, SERVICE5_CHAR2_PROP_INDICATE],
       "3":[SERVICE5_CHAR3_PROP_BROADCAST, SERVICE5_CHAR3_PROP_READ, SERVICE5_CHAR3_PROP_WRITE_WITHOUT_RESP, SERVICE5_CHAR3_PROP_WRITE, SERVICE5_CHAR3_PROP_NOTIFY, SERVICE5_CHAR3_PROP_INDICATE],
       "4":[SERVICE5_CHAR4_PROP_BROADCAST, SERVICE5_CHAR4_PROP_READ, SERVICE5_CHAR4_PROP_WRITE_WITHOUT_RESP, SERVICE5_CHAR4_PROP_WRITE, SERVICE5_CHAR4_PROP_NOTIFY, SERVICE5_CHAR4_PROP_INDICATE],
       "5":[SERVICE5_CHAR5_PROP_BROADCAST, SERVICE5_CHAR5_PROP_READ, SERVICE5_CHAR5_PROP_WRITE_WITHOUT_RESP, SERVICE5_CHAR5_PROP_WRITE, SERVICE5_CHAR5_PROP_NOTIFY, SERVICE5_CHAR5_PROP_INDICATE]}
}]

[#assign SERVICES_CHARS_SUFFIX = ["", "_READ_EVT", "_WRITE_NO_RESP_EVT", "_WRITE_EVT", "_NOTIFY_ENABLED_EVT", "_INDICATE_ENABLED_EVT"]]

[#macro customServChar service characteristic]
    CUSTOM_STM_${SERVICES_CHARS_NAMES[service?string][characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro capitalizeServChar service characteristic]
    ${SERVICES_CHARS_NAMES[service?string][characteristic?string][item_SHORT_NAME]?capitalize}[#t]
[/#macro]

[#macro caseEventCode service characteristic suffix]
    case [@customServChar service characteristic/]${suffix}:
      /* USER CODE BEGIN [@customServChar service characteristic/]${suffix} */

      /* USER CODE END [@customServChar service characteristic/]${suffix} */
      break;

[/#macro]

[#macro customEventCode item service characteristic]
    [#if SERVICES_CHARS_SUFFIX[item] != ""]
        [#assign suffix = SERVICES_CHARS_SUFFIX[item]]
  [@caseEventCode service characteristic suffix/]
        [#if SERVICES_CHARS_SUFFIX[item]?contains("ENABLED")]
            [#assign suffix=SERVICES_CHARS_SUFFIX[item]?replace("ENABLED","DISABLED")]
  [@caseEventCode service characteristic suffix/]
        [/#if]
    [/#if]
[/#macro]
[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
${definition.name}: "${definition.value}"
        [/#list]
    [/#if]
[/#list]
--]

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "app_common.h"
#include "dbg_trace.h"
#include "ble.h"
#include "custom_app.h"
#include "custom_stm.h"
#include "stm32_seq.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef struct
{
[#if NUMBER_OF_SERVICES != "0"]
    [#list 1..NUMBER_OF_SERVICES?number as service]
  /* ${SERVICES_NAMES[service?string][item_LONG_NAME]} */
        [#list 1..SERVICES_NUMBER_OF_CHARACTERISTICS[service?string]?number as characteristic]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY] != ""]
  uint8_t               [@capitalizeServChar service characteristic/]_Notification_Status;
            [/#if]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE] != ""]
  uint8_t               [@capitalizeServChar service characteristic/]_Indication_Status;
            [/#if]
        [/#list]
    [/#list]
[/#if]
  /* USER CODE BEGIN CUSTOM_APP_Context_t */

  /* USER CODE END CUSTOM_APP_Context_t */

  uint16_t              ConnectionHandle;
} Custom_App_Context_t;

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/**
 * START of Section BLE_APP_CONTEXT
 */

static Custom_App_Context_t Custom_App_Context;

/**
 * END of Section BLE_APP_CONTEXT
 */

uint8_t UpdateCharData[247];
uint8_t NotifyCharData[247];

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if NUMBER_OF_SERVICES != "0"]
    [#list 1..NUMBER_OF_SERVICES?number as service]
/* ${SERVICES_NAMES[service?string][item_LONG_NAME]} */
        [#list 1..SERVICES_NUMBER_OF_CHARACTERISTICS[service?string]?number as characteristic]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY]??  &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY] != "" ||
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE] != ""]
static void Custom_[@capitalizeServChar service characteristic/]_Update_Char(void);
            [/#if]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY] != ""]
static void Custom_[@capitalizeServChar service characteristic/]_Send_Notification(void);
            [/#if]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE] != ""]
static void Custom_[@capitalizeServChar service characteristic/]_Send_Indication(void);
            [/#if]
        [/#list]
    [/#list]
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
void Custom_STM_App_Notification(Custom_STM_App_Notification_evt_t *pNotification)
{
  /* USER CODE BEGIN CUSTOM_STM_App_Notification_1 */

  /* USER CODE END CUSTOM_STM_App_Notification_1 */
  switch (pNotification->Custom_Evt_Opcode)
  {
    /* USER CODE BEGIN CUSTOM_STM_App_Notification_Custom_Evt_Opcode */

    /* USER CODE END CUSTOM_STM_App_Notification_Custom_Evt_Opcode */

[#if NUMBER_OF_SERVICES != "0"]
    [#list 1..NUMBER_OF_SERVICES?number as service]
    /* ${SERVICES_NAMES[service?string][item_LONG_NAME]} */
        [#list 1..SERVICES_NUMBER_OF_CHARACTERISTICS[service?string]?number as characteristic]
            [#list item_PROP_START..item_PROP_END as item]
                [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item]?? &&
                        SERVICES_CHARS_PROP[service?string][characteristic?string][item] != ""]
                    [@customEventCode item service characteristic /]
                [/#if]
            [/#list]
        [/#list]
    [/#list]
[/#if]
    case CUSTOM_STM_NOTIFICATION_COMPLETE_EVT:
      /* USER CODE BEGIN CUSTOM_STM_NOTIFICATION_COMPLETE_EVT */

      /* USER CODE END CUSTOM_STM_NOTIFICATION_COMPLETE_EVT */
      break;

    default:
      /* USER CODE BEGIN CUSTOM_STM_App_Notification_default */

      /* USER CODE END CUSTOM_STM_App_Notification_default */
      break;
  }
  /* USER CODE BEGIN CUSTOM_STM_App_Notification_2 */

  /* USER CODE END CUSTOM_STM_App_Notification_2 */
  return;
}

void Custom_APP_Notification(Custom_App_ConnHandle_Not_evt_t *pNotification)
{
  /* USER CODE BEGIN CUSTOM_APP_Notification_1 */

  /* USER CODE END CUSTOM_APP_Notification_1 */

  switch (pNotification->Custom_Evt_Opcode)
  {
    /* USER CODE BEGIN CUSTOM_APP_Notification_Custom_Evt_Opcode */

    /* USER CODE END P2PS_CUSTOM_Notification_Custom_Evt_Opcode */
    case CUSTOM_CONN_HANDLE_EVT :
      /* USER CODE BEGIN CUSTOM_CONN_HANDLE_EVT */
              
      /* USER CODE END CUSTOM_CONN_HANDLE_EVT */
      break;

    case CUSTOM_DISCON_HANDLE_EVT :
      /* USER CODE BEGIN CUSTOM_DISCON_HANDLE_EVT */
          
      /* USER CODE END CUSTOM_DISCON_HANDLE_EVT */
      break;
    
    default:
      /* USER CODE BEGIN CUSTOM_APP_Notification_default */

      /* USER CODE END CUSTOM_APP_Notification_default */
      break;
  }

  /* USER CODE BEGIN CUSTOM_APP_Notification_2 */

  /* USER CODE END CUSTOM_APP_Notification_2 */

  return;
}

void Custom_APP_Init(void)
{
  /* USER CODE BEGIN CUSTOM_APP_Init */

  /* USER CODE END CUSTOM_APP_Init */
  return;
}

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/

[#if NUMBER_OF_SERVICES != "0"]
    [#list 1..NUMBER_OF_SERVICES?number as service]
/* ${SERVICES_NAMES[service?string][item_LONG_NAME]} */
        [#list 1..SERVICES_NUMBER_OF_CHARACTERISTICS[service?string]?number as characteristic]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY]??  &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY] != "" ||
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE] != ""]
void Custom_[@capitalizeServChar service characteristic/]_Update_Char(void) /* Property Read */
{ 
  uint8_t updateflag = 0;

  /* USER CODE BEGIN [@capitalizeServChar service characteristic/]_UC_1*/

  /* USER CODE END [@capitalizeServChar service characteristic/]_UC_1*/

  if (updateflag != 0)
  {
    Custom_STM_App_Update_Char([@customServChar service characteristic/], (uint8_t *)UpdateCharData);
  }
  
  /* USER CODE BEGIN [@capitalizeServChar service characteristic/]_UC_Last*/

  /* USER CODE END [@capitalizeServChar service characteristic/]_UC_Last*/
  return;
}

            [/#if]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_NOTIFY] != ""]
void Custom_[@capitalizeServChar service characteristic/]_Send_Notification(void) /* Property Notification */
{ 
  uint8_t updateflag = 0;

  /* USER CODE BEGIN [@capitalizeServChar service characteristic/]_NS_1*/

  /* USER CODE END [@capitalizeServChar service characteristic/]_NS_1*/

  if (updateflag != 0)
  {
    Custom_STM_App_Update_Char([@customServChar service characteristic/], (uint8_t *)NotifyCharData);
  }
  
  /* USER CODE BEGIN [@capitalizeServChar service characteristic/]_NS_Last*/

  /* USER CODE END [@capitalizeServChar service characteristic/]_NS_Last*/

  return;
}

            [/#if]
            [#if SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[service?string][characteristic?string][item_PROP_INDICATE] != ""]
void Custom_[@capitalizeServChar service characteristic/]_Send_Indication(void) /* Property Indication */
{ 
  uint8_t updateflag = 0;

  /* USER CODE BEGIN [@capitalizeServChar service characteristic/]_IS_1*/

  /* USER CODE END [@capitalizeServChar service characteristic/]_IS_1*/

  if (updateflag != 0)
  {
    Custom_STM_App_Update_Char([@customServChar service characteristic/], (uint8_t *)NotifyCharData);
  }
  
  /* USER CODE BEGIN [@capitalizeServChar service characteristic/]_IS_Last*/

  /* USER CODE END [@capitalizeServChar service characteristic/]_IS_Last*/

  return;
}

            [/#if]
        [/#list]
    [/#list]
[/#if]



/* USER CODE BEGIN FD_LOCAL_FUNCTIONS*/

/* USER CODE END FD_LOCAL_FUNCTIONS*/
