[#ftl]

[#-- BspIpDatas is a list of SWIPconfigModel --] 

[#assign IpName = ""]
[#assign IpInstance = ""]
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

  MX_${IpInstance}_Init();
