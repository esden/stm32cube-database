[#ftl]
[#assign SauInitAllRegion = {}][#-- Hash to register all SAU regions --]
[#--
    "0": {  "REGION" : "value",
            "START" : "value",
            "END" : "value",
            "NSC" : "value"},
    "1": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "2": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "3": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "4": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "5": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "6": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "7": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""}
}--] 
[#-- 

--]
[#list IPdatas as ipvar]
   [#list ipvar.configModelList as configModel]
       [#list configModel.refConfigFiles as refconfig]
            [#list refconfig.arguments as argument]
                [#assign index=argument.name[3]]
                [#assign key=argument.name[10..]]
                [#assign val=argument.value]
                [#assign element = {key:val}]
                [#if SauInitAllRegion[index?string]??][#assign hashRegion=SauInitAllRegion[index?string]][#else][#assign hashRegion={}][/#if]
                [#assign hashRegion = hashRegion + element]
                [#assign SauInitAllRegion = SauInitAllRegion + {index:hashRegion}]
            [/#list]
        [/#list]
    [/#list]
[/#list]
[#-- uncomment to display the table value --]
[#--list SauInitAllRegion?keys as regionNb]
    [#list SauInitAllRegion[regionNb]?keys as param]
        ${regionNb} ${param} :${SauInitAllRegion[regionNb][param]}
    [/#list]
[/#list--]

/*
//-------- <<< Use Configuration Wizard in Context Menu >>> -----------------
*/
/*
// <e>Initialize Security Attribution Unit (SAU) CTRL register
*/
#define SAU_INIT_CTRL          1

/*
//   <q> Enable SAU
//   <i> Value for SAU->CTRL register bit ENABLE
*/
#define SAU_INIT_CTRL_ENABLE   1

/*
//   <o> When SAU is disabled
//     <0=> All Memory is Secure
//     <1=> All Memory is Non-Secure
//   <i> Value for SAU->CTRL register bit ALLNS
//   <i> When all Memory is Non-Secure (ALLNS is 1), IDAU can override memory map configuration.
*/
#define SAU_INIT_CTRL_ALLNS  1

/*
// </e>
*/

/*
// <h>Initialize Security Attribution Unit (SAU) Address Regions
// <i>SAU configuration specifies regions to be one of:
// <i> - Secure and Non-Secure Callable
// <i> - Non-Secure
// <i>Note: All memory regions not configured by SAU are Secure
*/
#define SAU_REGIONS_MAX   8                 /* Max. number of SAU regions */

/*
//   <e>Initialize SAU Region 0
//   <i> Setup SAU Region 0 memory attributes
*/
#define SAU_INIT_REGION0    ${SauInitAllRegion["0"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     ${SauInitAllRegion["0"]["START"]}      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       ${SauInitAllRegion["0"]["END"]}      /* end address of SAU region 0 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC0       ${SauInitAllRegion["0"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 1
//   <i> Setup SAU Region 1 memory attributes
*/
#define SAU_INIT_REGION1    ${SauInitAllRegion["1"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1       ${SauInitAllRegion["1"]["START"]}      /* end address of SAU region 0 */
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       ${SauInitAllRegion["1"]["END"]}      /* end address of SAU region 1 */
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC1       ${SauInitAllRegion["1"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 2
//   <i> Setup SAU Region 2 memory attributes
*/
#define SAU_INIT_REGION2    ${SauInitAllRegion["2"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     ${SauInitAllRegion["2"]["START"]}      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       ${SauInitAllRegion["2"]["END"]}      /* end address of SAU region 2 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC2       ${SauInitAllRegion["2"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 3
//   <i> Setup SAU Region 3 memory attributes
*/
#define SAU_INIT_REGION3    ${SauInitAllRegion["3"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START3     ${SauInitAllRegion["3"]["START"]}      /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3       ${SauInitAllRegion["3"]["END"]}      /* end address of SAU region 3 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC3       ${SauInitAllRegion["3"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 4
//   <i> Setup SAU Region 4 memory attributes
*/
#define SAU_INIT_REGION4    ${SauInitAllRegion["4"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START4     ${SauInitAllRegion["4"]["START"]}      /* start address of SAU region 4 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       ${SauInitAllRegion["4"]["END"]}      /* end address of SAU region 4 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC4       ${SauInitAllRegion["4"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 5
//   <i> Setup SAU Region 5 memory attributes
*/
#define SAU_INIT_REGION5    ${SauInitAllRegion["5"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START5     ${SauInitAllRegion["5"]["START"]}      /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5       ${SauInitAllRegion["5"]["END"]}      /* end address of SAU region 5 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC5       ${SauInitAllRegion["5"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 6
//   <i> Setup SAU Region 6 memory attributes
*/
#define SAU_INIT_REGION6    ${SauInitAllRegion["6"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START6     ${SauInitAllRegion["6"]["START"]}      /* start address of SAU region 6 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END6       ${SauInitAllRegion["6"]["END"]}      /* end address of SAU region 6 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC6       ${SauInitAllRegion["6"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 7
//   <i> Setup SAU Region 7 memory attributes
*/
#define SAU_INIT_REGION7    ${SauInitAllRegion["7"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START7     ${SauInitAllRegion["7"]["START"]}      /* start address of SAU region 7 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END7       ${SauInitAllRegion["7"]["END"]}      /* end address of SAU region 7 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC7       ${SauInitAllRegion["7"]["NSC"]}
/*
//   </e>
*/

/*
// </h>
*/
