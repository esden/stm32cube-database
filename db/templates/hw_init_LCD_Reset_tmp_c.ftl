[#ftl]

[#-- BspIpDatas is a list of SWIPconfigModel --] 

[#assign IpName = ""]
[#if BspIpDatas??]

[#list BspIpDatas  as BSPIP]

	
	[#if BSPIP.variables??]
		[#list BSPIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
                         
		[/#if]
               [#if variables.name?contains("IpInstance")]
			[#assign IpInstance = variables.value]
		[/#if]
	        [/#list]
	[/#if]
 [/#list]

[/#if]

/**
* @brief  BSP LCD Reset
*         Hw reset the LCD DSI activating its XRES signal (active low for some time)
*         and desactivating it later.
*         This signal is only cabled on Eval Rev B and beyond.
*/

static void LCD_LL_Reset(void)
{
    /* Activate XRES active low */
    HAL_GPIO_WritePin(${IpName}, ${IpInstance}, GPIO_PIN_RESET);

    HAL_Delay(20); /* wait 20 ms */

    /* Desactivate XRES */
    HAL_GPIO_WritePin(${IpName}, ${IpInstance}, GPIO_PIN_SET);
    
    /* Wait for 10ms after releasing XRES before sending commands */
    HAL_Delay(10); 

}