[#ftl]

[#-- Clock binding :
-w U-Boot, TF-A, Linux, OP-TEE FWs support
-w no U-Boot-SPL supp	ort
--]

[#-- Fixed Clocks (clocks node)--]
[#assign  TAB = dts_get_tabs(1)]
[#assign  TABN = TAB.TABN]
[#assign  TABP = TAB.TABP]
[#assign  TAB = dts_get_tabs(3)]
[#assign  TABN1 = TAB.TABN]
${TABN}clocks {

${TABP}/* USER CODE BEGIN clocks */
${TABP}/* USER CODE END clocks */
${TABN}};
#n