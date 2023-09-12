[#ftl]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** NetX Component                                                        */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/**************************************************************************/
/*                                                                        */
/*  PORT SPECIFIC C INFORMATION                            RELEASE        */
/*                                                                        */
/*    nx_user.h                                           PORTABLE C      */
/*                                                           6.0          */
/*                                                                        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    Yuxin Zhou, Microsoft Corporation                                   */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This file contains user defines for configuring NetX in specific    */
/*    ways. This file will have an effect only if the application and     */
/*    NetX library are built with NX_INCLUDE_USER_DEFINE_FILE defined.    */
/*    Note that all the defines in this file may also be made on the      */
/*    command line when building NetX library and application objects.    */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  05-19-2020     Yuxin Zhou               Initial Version 6.0           */
/*                                                                        */
/**************************************************************************/

#ifndef NX_USER_H
#define NX_USER_H

[#assign NX_WEB_HTTP_NO_FILEX_value = "true"]
[#assign NX_HTTP_NO_FILEX_value = "true"]

[#compress]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	
	[#if name == "FILEX_ENABLED"]
      [#assign FX_ENABLE = value]
	    [#if FX_ENABLE == "true"]
			[#list SWIPdatas as SWIP]
				[#if SWIP.defines??]
				  [#list SWIP.defines as definition]
					[#assign value = definition.value]
					[#assign name = definition.name]
						[#if name == "NX_WEB_HTTP_NO_FILEX"]
							[#assign NX_WEB_HTTP_NO_FILEX_value = value]
						[/#if]
					
						[#if name == "NX_HTTP_NO_FILEX"]
							[#assign NX_HTTP_NO_FILEX_value = value]
						[/#if]
					[/#list]
				[/#if]
			[/#list]
		[/#if]
    [/#if]
	
	[#if name == "NX_CLOUD_ENABLED"]
      [#assign NX_CLOUD_COMPONENT_ENABLED = value]
    [/#if]
	
	[#if name == "NX_MAX_PHYSICAL_INTERFACES"]
      [#assign NX_MAX_PHYSICAL_INTERFACES_value = value]
    [/#if]

	[#if name == "NX_DISABLE_LOOPBACK_INTERFACE"]
      [#assign NX_DISABLE_LOOPBACK_INTERFACE_value = value]
    [/#if]
	
	[#if name == "NX_ENABLE_INTERFACE_CAPABILITY"]
      [#assign NX_ENABLE_INTERFACE_CAPABILITY_value = value]
    [/#if]

	[#if name == "NX_PHYSICAL_HEADER"]
      [#assign NX_PHYSICAL_HEADER_value = value]
    [/#if]

	[#if name == "NX_PHYSICAL_TRAILER"]
      [#assign NX_PHYSICAL_TRAILER_value = value]
    [/#if]

	[#if name == "NX_DISABLE_RX_SIZE_CHECKING"]
      [#assign NX_DISABLE_RX_SIZE_CHECKING_value = value]
    [/#if]

	[#if name == "NX_ENABLE_PACKET_DEBUG_INFO"]
      [#assign NX_ENABLE_PACKET_DEBUG_INFO_value = value]
    [/#if]

	[#if name == "NX_DISABLE_PACKET_CHAIN"]
      [#assign NX_DISABLE_PACKET_CHAIN_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ERROR_CHECKING"]
      [#assign NX_DISABLE_ERROR_CHECKING_value = value]
    [/#if]

	[#if name == "NX_DRIVER_DEFERRED_PROCESSING"]
      [#assign NX_DRIVER_DEFERRED_PROCESSING_value = value]
    [/#if]

	[#if name == "NX_ENABLE_SOURCE_ADDRESS_CHECK"]
      [#assign NX_ENABLE_SOURCE_ADDRESS_CHECK_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ASSERT"]
      [#assign NX_DISABLE_ASSERT_value = value]
    [/#if]

	[#if name == "NX_ASSERT_FAIL"]
      [#assign NX_ASSERT_FAIL_value = value]
    [/#if]

	[#if name == "NX_MAX_STRING_LENGTH"]
      [#assign NX_MAX_STRING_LENGTH_value = value]
    [/#if]

	[#if name == "NX_DEBUG_PACKET"]
      [#assign NX_DEBUG_PACKET_value = value]
    [/#if]

	[#if name == "NX_DEBUG"]
      [#assign NX_DEBUG_value = value]
    [/#if]

	[#if name == "NX_ENABLE_EXTENDED_NOTIFY_SUPPORT"]
      [#assign NX_ENABLE_EXTENDED_NOTIFY_SUPPORT_value = value]
    [/#if]

	[#if name == "NX_PACKET_ALIGNMENT"]
      [#assign NX_PACKET_ALIGNMENT_value = value]
    [/#if]

	[#if name == "NX_RETRANS_TIMER"]
      [#assign NX_RETRANS_TIMER_value = value]
    [/#if]

	[#if name == "NX_IP_PERIODIC_RATE"]
      [#assign NX_IP_PERIODIC_RATE_value = value]
    [/#if]

	[#if name == "TX_TIMER_TICKS_PER_SECOND"]
      [#assign TX_TIMER_TICKS_PER_SECOND_value = value]
    [/#if]

	[#if name == "NX_ENABLE_IP_RAW_PACKET_FILTER"]
      [#assign NX_ENABLE_IP_RAW_PACKET_FILTER_value = value]
    [/#if]

	[#if name == "NX_IP_RAW_MAX_QUEUE_DEPTH"]
      [#assign NX_IP_RAW_MAX_QUEUE_DEPTH_value = value]
    [/#if]

	[#if name == "NX_ENABLE_IP_STATIC_ROUTING"]
      [#assign NX_ENABLE_IP_STATIC_ROUTING_value = value]
    [/#if]

	[#if name == "NX_IP_ROUTING_TABLE_SIZE"]
      [#assign NX_IP_ROUTING_TABLE_SIZE_value = value]
    [/#if]

	[#if name == "NX_IP_MAX_REASSEMBLY_TIME"]
      [#assign NX_IP_MAX_REASSEMBLY_TIME_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IP_RX_CHECKSUM"]
      [#assign NX_DISABLE_IP_RX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IP_TX_CHECKSUM"]
      [#assign NX_DISABLE_IP_TX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IP_INFO"]
      [#assign NX_DISABLE_IP_INFO_value = value]
    [/#if]

	[#if name == "NX_IP_FAST_TIMER_RATE"]
      [#assign NX_IP_FAST_TIMER_RATE_value = value]
    [/#if]

	[#if name == "NX_IP_STATUS_CHECK_WAIT_TIME"]
      [#assign NX_IP_STATUS_CHECK_WAIT_TIME_value = value]
    [/#if]

	[#if name == "NX_IPV4_MAX_REASSEMBLY_TIME"]
      [#assign NX_IPV4_MAX_REASSEMBLY_TIME_value = value]
    [/#if]
	
	[#if name == "NX_ENABLE_IP_PACKET_FILTER"]
      [#assign NX_ENABLE_IP_PACKET_FILTER_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IPV4"]
      [#assign NX_DISABLE_IPV4_value = value]
    [/#if]

	[#if name == "FEATURE_NX_IPV6"]
      [#assign FEATURE_NX_IPV6_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IPV6"]
      [#assign NX_DISABLE_IPV6_value = value]
    [/#if]

	[#if name == "NX_MAX_IPV6_ADDRESSES"]
      [#assign NX_MAX_IPV6_ADDRESSES_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IPV6_DAD"]
      [#assign NX_DISABLE_IPV6_DAD_value = value]
    [/#if]

	[#if name == "NX_IPV6_STATELESS_AUTOCONFIG_CONTROL"]
      [#assign NX_IPV6_STATELESS_AUTOCONFIG_CONTROL_value = value]
    [/#if]

	[#if name == "NX_ENABLE_IPV6_ADDRESS_CHANGE_NOTIFY"]
      [#assign NX_ENABLE_IPV6_ADDRESS_CHANGE_NOTIFY_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IPV6_PURGE_UNUSED_CACHE_ENTRIES"]
      [#assign NX_DISABLE_IPV6_PURGE_UNUSED_CACHE_ENTRIES_value = value]
    [/#if]

	[#if name == "NX_ENABLE_IPV6_MULTICAST"]
      [#assign NX_ENABLE_IPV6_MULTICAST_value = value]
    [/#if]

	[#if name == "NX_ENABLE_IPV6_PATH_MTU_DISCOVERY"]
      [#assign NX_ENABLE_IPV6_PATH_MTU_DISCOVERY_value = value]
    [/#if]

	[#if name == "NX_PATH_MTU_INCREASE_WAIT_INTERVAL"]
      [#assign NX_PATH_MTU_INCREASE_WAIT_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_IPV6_DAD_TRANSMITS"]
      [#assign NX_IPV6_DAD_TRANSMITS_value = value]
    [/#if]

	[#if name == "NX_IPV6_NEIGHBOR_CACHE_SIZE"]
      [#assign NX_IPV6_NEIGHBOR_CACHE_SIZE_value = value]
    [/#if]

	[#if name == "NX_IPV6_DESTINATION_TABLE_SIZE"]
      [#assign NX_IPV6_DESTINATION_TABLE_SIZE_value = value]
    [/#if]

	[#if name == "NX_IPV6_PREFIX_LIST_TABLE_SIZE"]
      [#assign NX_IPV6_PREFIX_LIST_TABLE_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_IPV6_MAX_REASSEMBLY_TIME"]
      [#assign NX_IPV6_MAX_REASSEMBLY_TIME_value = value]
    [/#if]

	[#if name == "NX_IPV6_DEFAULT_ROUTER_TABLE_SIZE"]
      [#assign NX_IPV6_DEFAULT_ROUTER_TABLE_SIZE_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMPV4_ERROR_MESSAGE"]
      [#assign NX_DISABLE_ICMPV4_ERROR_MESSAGE_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMPV4_RX_CHECKSUM"]
      [#assign NX_DISABLE_ICMPV4_RX_CHECKSUM_value = value]
    [/#if]	

	[#if name == "NX_DISABLE_ICMPV6_RX_CHECKSUM"]
      [#assign NX_DISABLE_ICMPV6_RX_CHECKSUM_value = value]
    [/#if]		

	[#if name == "NX_DISABLE_ICMP_RX_CHECKSUM"]
      [#assign NX_DISABLE_ICMP_RX_CHECKSUM_value = value]
    [/#if]		

	[#if name == "NX_DISABLE_ICMPV4_TX_CHECKSUM"]
      [#assign NX_DISABLE_ICMPV4_TX_CHECKSUM_value = value]
    [/#if]		

	[#if name == "NX_DISABLE_ICMPV6_TX_CHECKSUM"]
      [#assign NX_DISABLE_ICMPV6_TX_CHECKSUM_value = value]
    [/#if]	

	[#if name == "NX_DISABLE_ICMP_TX_CHECKSUM"]
      [#assign NX_DISABLE_ICMP_TX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMP_INFO"]
      [#assign NX_DISABLE_ICMP_INFO_value = value]
    [/#if]

	[#if name == "NX_ENABLE_ICMP_ADDRESS_CHECK"]
      [#assign NX_ENABLE_ICMP_ADDRESS_CHECK_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMPV6_ERROR_MESSAGE"]
      [#assign NX_DISABLE_ICMPV6_ERROR_MESSAGE_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMPV6_REDIRECT_PROCESS"]
      [#assign NX_DISABLE_ICMPV6_REDIRECT_PROCESS_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMPV6_ROUTER_ADVERTISEMENT_PROCESS"]
      [#assign NX_DISABLE_ICMPV6_ROUTER_ADVERTISEMENT_PROCESS_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ICMPV6_ROUTER_SOLICITATION"]
      [#assign NX_DISABLE_ICMPV6_ROUTER_SOLICITATION_value = value]
    [/#if]

	[#if name == "NX_ICMPV6_MAX_RTR_SOLICITATIONS"]
      [#assign NX_ICMPV6_MAX_RTR_SOLICITATIONS_value = value]
    [/#if]

	[#if name == "NX_ICMPV6_RTR_SOLICITATION_INTERVAL"]
      [#assign NX_ICMPV6_RTR_SOLICITATION_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_ICMPV6_RTR_SOLICITATION_DELAY"]
      [#assign NX_ICMPV6_RTR_SOLICITATION_DELAY_value = value]
    [/#if]

	[#if name == "NX_TCP_ACK_TIMER_RATE"]
      [#assign NX_TCP_ACK_TIMER_RATE_value = value]
    [/#if]

	[#if name == "NX_TCP_FAST_TIMER_RATE"]
      [#assign NX_TCP_FAST_TIMER_RATE_value = value]
    [/#if]

	[#if name == "NX_TCP_TRANSMIT_TIMER_RATE"]
      [#assign NX_TCP_TRANSMIT_TIMER_RATE_value = value]
    [/#if]	

	[#if name == "NX_TCP_KEEPALIVE_INITIAL"]
      [#assign NX_TCP_KEEPALIVE_INITIAL_value = value]
    [/#if]	

	[#if name == "NX_TCP_KEEPALIVE_RETRY"]
      [#assign NX_TCP_KEEPALIVE_RETRY_value = value]
    [/#if]

	[#if name == "NX_TCP_MAX_OUT_OF_ORDER_PACKETS"]
      [#assign NX_TCP_MAX_OUT_OF_ORDER_PACKETS_value = value]
    [/#if]

	[#if name == "NX_ENABLE_TCP_KEEPALIVE"]
      [#assign NX_ENABLE_TCP_KEEPALIVE_value = value]
    [/#if]

	[#if name == "NX_TCP_IMMEDIATE_ACK"]
      [#assign NX_TCP_IMMEDIATE_ACK_value = value]
    [/#if]

	[#if name == "NX_TCP_ACK_EVERY_N_PACKETS"]
      [#assign NX_TCP_ACK_EVERY_N_PACKETS_value = value]
    [/#if]

	[#if name == "NX_TCP_MAXIMUM_RETRIES"]
      [#assign NX_TCP_MAXIMUM_RETRIES_value = value]
    [/#if]

	[#if name == "NX_TCP_MAXIMUM_TX_QUEUE"]
      [#assign NX_TCP_MAXIMUM_TX_QUEUE_value = value]
    [/#if]

	[#if name == "NX_TCP_RETRY_SHIFT"]
      [#assign NX_TCP_RETRY_SHIFT_value = value]
    [/#if]

	[#if name == "NX_TCP_KEEPALIVE_RETRIES"]
      [#assign NX_TCP_KEEPALIVE_RETRIES_value = value]
    [/#if]

	[#if name == "NX_ENABLE_TCP_WINDOW_SCALING"]
      [#assign NX_ENABLE_TCP_WINDOW_SCALING_value = value]
    [/#if]

	[#if name == "NX_DISABLE_RESET_DISCONNECT"]
      [#assign NX_DISABLE_RESET_DISCONNECT_value = value]
    [/#if]

	[#if name == "NX_ENABLE_TCP_MSS_CHECK"]
      [#assign NX_ENABLE_TCP_MSS_CHECK_value = value]
    [/#if]

	[#if name == "NX_TCP_MSS_MINIMUM"]
      [#assign NX_TCP_MSS_MINIMUM_value = value]
    [/#if]

	[#if name == "NX_ENABLE_TCP_QUEUE_DEPTH_UPDATE_NOTIFY"]
      [#assign NX_ENABLE_TCP_QUEUE_DEPTH_UPDATE_NOTIFY_value = value]
    [/#if]

	[#if name == "NX_TCP_MAXIMUM_RX_QUEUE"]
      [#assign NX_TCP_MAXIMUM_RX_QUEUE_value = value]
    [/#if]

	[#if name == "NX_DISABLE_TCP_RX_CHECKSUM"]
      [#assign NX_DISABLE_TCP_RX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_TCP_TX_CHECKSUM"]
      [#assign NX_DISABLE_TCP_TX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_TCP_INFO"]
      [#assign NX_DISABLE_TCP_INFO_value = value]
    [/#if]

	[#if name == "NX_TCP_MAXIMUM_SEGMENT_LIFETIME"]
      [#assign NX_TCP_MAXIMUM_SEGMENT_LIFETIME_value = value]
    [/#if]

	[#if name == "NX_DISABLE_UDP_RX_CHECKSUM"]
      [#assign NX_DISABLE_UDP_RX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_UDP_TX_CHECKSUM"]
      [#assign NX_DISABLE_UDP_TX_CHECKSUM_value = value]
    [/#if]

	[#if name == "NX_DISABLE_UDP_INFO"]
      [#assign NX_DISABLE_UDP_INFO_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IGMP_INFO"]
      [#assign NX_DISABLE_IGMP_INFO_value = value]
    [/#if]

	[#if name == "NX_DISABLE_IGMPV2"]
      [#assign NX_DISABLE_IGMPV2_value = value]
    [/#if]

	[#if name == "NX_ARP_DEFEND_BY_REPLY"]
      [#assign NX_ARP_DEFEND_BY_REPLY_value = value]
    [/#if]

	[#if name == "NX_ARP_EXPIRATION_RATE"]
      [#assign NX_ARP_EXPIRATION_RATE_value = value]
    [/#if]

	[#if name == "NX_ARP_UPDATE_RATE"]
      [#assign NX_ARP_UPDATE_RATE_value = value]
    [/#if]

	[#if name == "NX_ARP_MAXIMUM_RETRIES"]
      [#assign NX_ARP_MAXIMUM_RETRIES_value = value]
    [/#if]

	[#if name == "NX_ARP_MAX_QUEUE_DEPTH"]
      [#assign NX_ARP_MAX_QUEUE_DEPTH_value = value]
    [/#if]

	[#if name == "NX_ARP_DEFEND_INTERVAL"]
      [#assign NX_ARP_DEFEND_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ARP_AUTO_ENTRY"]
      [#assign NX_DISABLE_ARP_AUTO_ENTRY_value = value]
    [/#if]

	[#if name == "NX_ENABLE_ARP_MAC_CHANGE_NOTIFICATION"]
      [#assign NX_ENABLE_ARP_MAC_CHANGE_NOTIFICATION_value = value]
    [/#if]

	[#if name == "NX_DISABLE_ARP_INFO"]
      [#assign NX_DISABLE_ARP_INFO_value = value]
    [/#if]

	[#if name == "NX_MAX_MULTICAST_GROUPS"]
      [#assign NX_MAX_MULTICAST_GROUPS_value = value]
    [/#if]

	[#if name == "NX_DISABLE_FRAGMENTATION"]
      [#assign NX_DISABLE_FRAGMENTATION_value = value]
    [/#if]

	[#if name == "NX_FRAGMENT_IMMEDIATE_ASSEMBLY"]
      [#assign NX_FRAGMENT_IMMEDIATE_ASSEMBLY_value = value]
    [/#if]

	[#if name == "NX_DISABLE_PACKET_INFO"]
      [#assign NX_DISABLE_PACKET_INFO_value = value]
    [/#if]

	[#if name == "NX_ENABLE_LOW_WATERMARK"]
      [#assign NX_ENABLE_LOW_WATERMARK_value = value]
    [/#if]

	[#if name == "NX_MAX_LISTEN_REQUESTS"]
      [#assign NX_MAX_LISTEN_REQUESTS_value = value]
    [/#if]

	[#if name == "NX_DISABLE_RARP_INFO"]
      [#assign NX_DISABLE_RARP_INFO_value = value]
    [/#if]

	[#if name == "NX_DELAY_FIRST_PROBE_TIME"]
      [#assign NX_DELAY_FIRST_PROBE_TIME_value = value]
    [/#if]

	[#if name == "NX_MAX_MULTICAST_SOLICIT"]
      [#assign NX_MAX_MULTICAST_SOLICIT_value = value]
    [/#if]

	[#if name == "NX_MAX_UNICAST_SOLICIT"]
      [#assign NX_MAX_UNICAST_SOLICIT_value = value]
    [/#if]

	[#if name == "NX_ND_MAX_QUEUE_DEPTH"]
      [#assign NX_ND_MAX_QUEUE_DEPTH_value = value]
    [/#if]

	[#if name == "NX_REACHABLE_TIME"]
      [#assign NX_REACHABLE_TIME_value = value]
    [/#if]

	[#if name == "NX_NAT_ENABLE"]
      [#assign NX_NAT_ENABLE_value = value]
    [/#if]

	[#if name == "NX_ENABLE_DUAL_PACKET_POOL"]
      [#assign NX_ENABLE_DUAL_PACKET_POOL_value = value]
    [/#if]

	[#if name == "NX_DHCP_ENABLE_BOOTP"]
      [#assign NX_DHCP_ENABLE_BOOTP_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_RESTORE_STATE"]
      [#assign NX_DHCP_CLIENT_RESTORE_STATE_value = value]
    [/#if]

	[#if name == "NX_DHCP_CLIENT_USER_CREATE_PACKET_POOL"]
      [#assign NX_DHCP_CLIENT_USER_CREATE_PACKET_POOL_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_SEND_ARP_PROBE"]
      [#assign NX_DHCP_CLIENT_SEND_ARP_PROBE_value = value]
    [/#if]

	[#if name == "NX_DHCP_ARP_PROBE_WAIT"]
      [#assign NX_DHCP_ARP_PROBE_WAIT_value = value]
    [/#if]	

	[#if name == "NX_DHCP_ARP_PROBE_MIN"]
      [#assign NX_DHCP_ARP_PROBE_MIN_value = value]
    [/#if]

	[#if name == "NX_DHCP_ARP_PROBE_MAX"]
      [#assign NX_DHCP_ARP_PROBE_MAX_value = value]
    [/#if]	

	[#if name == "NX_DHCP_ARP_PROBE_NUM"]
      [#assign NX_DHCP_ARP_PROBE_NUM_value = value]
    [/#if]	

	[#if name == "NX_DHCP_RESTART_WAIT"]
      [#assign NX_DHCP_RESTART_WAIT_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_MAX_RECORDS"]
      [#assign NX_DHCP_CLIENT_MAX_RECORDS_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_SEND_MAX_DHCP_MESSAGE_OPTION"]
      [#assign NX_DHCP_CLIENT_SEND_MAX_DHCP_MESSAGE_OPTION_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_ENABLE_HOST_NAME_CHECK"]
      [#assign NX_DHCP_CLIENT_ENABLE_HOST_NAME_CHECK_value = value]
    [/#if]

	[#if name == "NX_DHCP_THREAD_PRIORITY"]
      [#assign NX_DHCP_THREAD_PRIORITY_value = value]
    [/#if]	

	[#if name == "NX_DHCP_THREAD_STACK_SIZE"]
      [#assign NX_DHCP_THREAD_STACK_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_TIME_INTERVAL"]
      [#assign NX_DHCP_TIME_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_DHCP_OPTIONS_BUFFER_SIZE"]
      [#assign NX_DHCP_OPTIONS_BUFFER_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_PACKET_PAYLOAD"]
      [#assign NX_DHCP_PACKET_PAYLOAD_value = value]
    [/#if]	

	[#if name == "NX_DHCP_PACKET_POOL_SIZE"]
      [#assign NX_DHCP_PACKET_POOL_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_MIN_RETRANS_TIMEOUT"]
      [#assign NX_DHCP_MIN_RETRANS_TIMEOUT_value = value]
    [/#if]		

	[#if name == "NX_DHCP_MAX_RETRANS_TIMEOUT"]
      [#assign NX_DHCP_MAX_RETRANS_TIMEOUT_value = value]
    [/#if]	

	[#if name == "NX_DHCP_MIN_RENEW_TIMEOUT"]
      [#assign NX_DHCP_MIN_RENEW_TIMEOUT_value = value]
    [/#if]	

	[#if name == "NX_DHCP_TYPE_OF_SERVICE"]
      [#assign NX_DHCP_TYPE_OF_SERVICE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_FRAGMENT_OPTION"]
      [#assign NX_DHCP_FRAGMENT_OPTION_value = value]
    [/#if]	

	[#if name == "NX_DHCP_TIME_TO_LIVE"]
      [#assign NX_DHCP_TIME_TO_LIVE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_QUEUE_DEPTH"]
      [#assign NX_DHCP_QUEUE_DEPTH_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_THREAD_PRIORITY"]
      [#assign NX_DHCPV6_THREAD_PRIORITY_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_MUTEX_WAIT"]
      [#assign NX_DHCPV6_MUTEX_WAIT_value = value]
    [/#if]		

	[#if name == "NX_DHCPV6_TICKS_PER_SECOND"]
      [#assign NX_DHCPV6_TICKS_PER_SECOND_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_IP_LIFETIME_TIMER_INTERVAL"]
      [#assign NX_DHCPV6_IP_LIFETIME_TIMER_INTERVAL_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_SESSION_TIMER_INTERVAL"]
      [#assign NX_DHCPV6_SESSION_TIMER_INTERVAL_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_MAX_IA_ADDRESS"]
      [#assign NX_DHCPV6_MAX_IA_ADDRESS_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_NUM_DNS_SERVERS"]
      [#assign NX_DHCPV6_NUM_DNS_SERVERS_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_NUM_TIME_SERVERS"]
      [#assign NX_DHCPV6_NUM_TIME_SERVERS_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_DOMAIN_NAME_BUFFER_SIZE"]
      [#assign NX_DHCPV6_DOMAIN_NAME_BUFFER_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_TIME_ZONE_BUFFER_SIZE"]
      [#assign NX_DHCPV6_TIME_ZONE_BUFFER_SIZE_value = value]
    [/#if]		

	[#if name == "NX_DHCPV6_MAX_MESSAGE_SIZE"]
      [#assign NX_DHCPV6_MAX_MESSAGE_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_PACKET_TIME_OUT"]
      [#assign NX_DHCPV6_PACKET_TIME_OUT_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_TYPE_OF_SERVICE"]
      [#assign NX_DHCPV6_TYPE_OF_SERVICE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_TIME_TO_LIVE"]
      [#assign NX_DHCPV6_TIME_TO_LIVE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_QUEUE_DEPTH"]
      [#assign NX_DHCPV6_QUEUE_DEPTH_value = value]
    [/#if]	

	[#if name == "NX_DHCP_SERVER_THREAD_PRIORITY"]
      [#assign NX_DHCP_SERVER_THREAD_PRIORITY_value = value]
    [/#if]		

	[#if name == "NX_DHCP_PACKET_ALLOCATE_TIMEOUT"]
      [#assign NX_DHCP_PACKET_ALLOCATE_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_DHCP_SUBNET_MASK"]
      [#assign NX_DHCP_SUBNET_MASK_value = value]
    [/#if]	

	[#if name == "NX_DHCP_FAST_PERIODIC_TIME_INTERVAL"]
      [#assign NX_DHCP_FAST_PERIODIC_TIME_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL"]
      [#assign NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_DHCP_DEFAULT_LEASE_TIME"]
      [#assign NX_DHCP_DEFAULT_LEASE_TIME_value = value]
    [/#if]

	[#if name == "NX_DHCP_IP_ADDRESS_MAX_LIST_SIZE"]
      [#assign NX_DHCP_IP_ADDRESS_MAX_LIST_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_RECORD_TABLE_SIZE"]
      [#assign NX_DHCP_CLIENT_RECORD_TABLE_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_OPTIONS_MAX"]
      [#assign NX_DHCP_CLIENT_OPTIONS_MAX_value = value]
    [/#if]

	[#if name == "NX_DHCP_SERVER_HOSTNAME_MAX"]
      [#assign NX_DHCP_SERVER_HOSTNAME_MAX_value = value]
    [/#if]	

	[#if name == "NX_DHCP_CLIENT_HOSTNAME_MAX"]
      [#assign NX_DHCP_CLIENT_HOSTNAME_MAX_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_SERVER_THREAD_STACK_SIZE"]
      [#assign NX_DHCPV6_SERVER_THREAD_STACK_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_SERVER_THREAD_PRIORITY"]
      [#assign NX_DHCPV6_SERVER_THREAD_PRIORITY_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_IP_LEASE_TIMER_INTERVAL"]
      [#assign NX_DHCPV6_IP_LEASE_TIMER_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_ID"]
      [#assign NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_ID_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_LENGTH"]
      [#assign NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_LENGTH_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_SERVER_DUID_VENDOR_PRIVATE_ID"]
      [#assign NX_DHCPV6_SERVER_DUID_VENDOR_PRIVATE_ID_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_PACKET_WAIT_OPTION"]
      [#assign NX_DHCPV6_PACKET_WAIT_OPTION_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_SERVER_DUID_TYPE"]
      [#assign NX_DHCPV6_SERVER_DUID_TYPE_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_PREFERENCE_VALUE"]
      [#assign NX_DHCPV6_PREFERENCE_VALUE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_MAX_OPTION_REQUEST_OPTIONS"]
      [#assign NX_DHCPV6_MAX_OPTION_REQUEST_OPTIONS_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_DEFAULT_T1_TIME"]
      [#assign NX_DHCPV6_DEFAULT_T1_TIME_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_DEFAULT_T2_TIME"]
      [#assign NX_DHCPV6_DEFAULT_T2_TIME_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_DEFAULT_PREFERRED_TIME"]
      [#assign NX_DHCPV6_DEFAULT_PREFERRED_TIME_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_DEFAULT_VALID_TIME"]
      [#assign NX_DHCPV6_DEFAULT_VALID_TIME_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_STATUS_MESSAGE_MAX"]
      [#assign NX_DHCPV6_STATUS_MESSAGE_MAX_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_MAX_LEASES"]
      [#assign NX_DHCPV6_MAX_LEASES_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_MAX_CLIENTS"]
      [#assign NX_DHCPV6_MAX_CLIENTS_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_PACKET_SIZE"]
      [#assign NX_DHCPV6_PACKET_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_PACKET_POOL_SIZE"]
      [#assign NX_DHCPV6_PACKET_POOL_SIZE_value = value]
    [/#if]	

	[#if name == "NX_DHCPV6_FRAGMENT_OPTION"]
      [#assign NX_DHCPV6_FRAGMENT_OPTION_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_SESSION_TIMEOUT"]
      [#assign NX_DHCPV6_SESSION_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_STATUS_MESSAGE_SUCCESS"]
      [#assign NX_DHCPV6_STATUS_MESSAGE_SUCCESS_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE"]
      [#assign NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_STATUS_MESSAGE_NO_BINDING"]
      [#assign NX_DHCPV6_STATUS_MESSAGE_NO_BINDING_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK"]
      [#assign NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK_value = value]
    [/#if]

	[#if name == "NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST"]
      [#assign NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST_value = value]
    [/#if]

	[#if name == "NX_DNS_TYPE_OF_SERVICE"]
      [#assign NX_DNS_TYPE_OF_SERVICE_value = value]
    [/#if]

	[#if name == "NX_DNS_TIME_TO_LIVE"]
      [#assign NX_DNS_TIME_TO_LIVE_value = value]
    [/#if]

	[#if name == "NX_DNS_FRAGMENT_OPTION"]
      [#assign NX_DNS_FRAGMENT_OPTION_value = value]
    [/#if]

	[#if name == "NX_DNS_QUEUE_DEPTH"]
      [#assign NX_DNS_QUEUE_DEPTH_value = value]
    [/#if]

	[#if name == "NX_DNS_MAX_SERVERS"]
      [#assign NX_DNS_MAX_SERVERS_value = value]
    [/#if]

	[#if name == "NX_DNS_MESSAGE_MAX"]
      [#assign NX_DNS_MESSAGE_MAX_value = value]
    [/#if]

	[#if name == "NX_DNS_PACKET_PAYLOAD_UNALIGNED"]
      [#assign NX_DNS_PACKET_PAYLOAD_UNALIGNED_value = value]
    [/#if]

	[#if name == "NX_DNS_PACKET_POOL_SIZE"]
      [#assign NX_DNS_PACKET_POOL_SIZE_value = value]
    [/#if]

	[#if name == "NX_DNS_MAX_RETRIES"]
      [#assign NX_DNS_MAX_RETRIES_value = value]
    [/#if]

	[#if name == "NX_DNS_IP_GATEWAY_AND_DNS_SERVER"]
      [#assign NX_DNS_IP_GATEWAY_AND_DNS_SERVER_value = value]
    [/#if]

	[#if name == "NX_DNS_CLIENT_USER_CREATE_PACKET_POOL"]
      [#assign NX_DNS_CLIENT_USER_CREATE_PACKET_POOL_value = value]
    [/#if]

	[#if name == "NX_DNS_CLIENT_CLEAR_QUEUE"]
      [#assign NX_DNS_CLIENT_CLEAR_QUEUE_value = value]
    [/#if]

	[#if name == "NX_DNS_ENABLE_EXTENDED_RR_TYPES"]
      [#assign NX_DNS_ENABLE_EXTENDED_RR_TYPES_value = value]
    [/#if]

	[#if name == "NX_DNS_CACHE_ENABLE"]
      [#assign NX_DNS_CACHE_ENABLE_value = value]
    [/#if]

	[#if name == "NX_DNS_PACKET_ALLOCATE_TIMEOUT"]
      [#assign NX_DNS_PACKET_ALLOCATE_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_DNS_MAX_RETRANS_TIMEOUT"]
      [#assign NX_DNS_MAX_RETRANS_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_SECURE_ENABLE"]
      [#assign NX_SECURE_ENABLE_value = value]
    [/#if]

	[#if name == "NXD_MQTT_REQUIRE_TLS"]
      [#assign NXD_MQTT_REQUIRE_TLS_value = value]
    [/#if]

	[#if name == "NXD_MQTT_KEEPALIVE_TIMER_RATE"]
      [#assign NXD_MQTT_KEEPALIVE_TIMER_RATE_value = value]
    [/#if]

	[#if name == "NXD_MQTT_PING_TIMEOUT_DELAY"]
      [#assign NXD_MQTT_PING_TIMEOUT_DELAY_value = value]
    [/#if]

	[#if name == "NXD_MQTT_SOCKET_TIMEOUT"]
      [#assign NXD_MQTT_SOCKET_TIMEOUT_value = value]
    [/#if]

	[#if name == "NXD_MQTT_CLOUD_ENABLE"]
      [#assign NXD_MQTT_CLOUD_ENABLE_value = value]
    [/#if]

	[#if name == "NXD_MQTT_SECURE_MEMCPY"]
      [#assign NXD_MQTT_SECURE_MEMCPY_value = value]
    [/#if]

	[#if name == "NXD_MQTT_SECURE_MEMCMP"]
      [#assign NXD_MQTT_SECURE_MEMCMP_value = value]
    [/#if]

	[#if name == "NXD_MQTT_SECURE_MEMSET"]
      [#assign NXD_MQTT_SECURE_MEMSET_value = value]
    [/#if]

	[#if name == "NXD_MQTT_SECURE_MEMMOVE"]
      [#assign NXD_MQTT_SECURE_MEMMOVE_value = value]
    [/#if]

	[#if name == "NXD_MQTT_CLIENT_SOCKET_WINDOW_SIZE"]
      [#assign NXD_MQTT_CLIENT_SOCKET_WINDOW_SIZE_value = value]
    [/#if]

	[#if name == "NXD_MQTT_CLIENT_THREAD_TIME_SLICE"]
      [#assign NXD_MQTT_CLIENT_THREAD_TIME_SLICE_value = value]
    [/#if]
	
	[#if name == "NX_HTTP_TYPE_OF_SERVICE"]
      [#assign NX_HTTP_TYPE_OF_SERVICE_value = value]
    [/#if]

	[#if name == "NX_HTTP_FRAGMENT_OPTION"]
      [#assign NX_HTTP_FRAGMENT_OPTION_value = value]
    [/#if]

	[#if name == "NX_HTTP_MAX_RESOURCE"]
      [#assign NX_HTTP_MAX_RESOURCE_value = value]
    [/#if]

	[#if name == "NX_HTTP_MAX_NAME"]
      [#assign NX_HTTP_MAX_NAME_value = value]
    [/#if]

	[#if name == "NX_HTTP_MAX_PASSWORD"]
      [#assign NX_HTTP_MAX_PASSWORD_value = value]
    [/#if]

	[#if name == "NX_HTTP_CLIENT_MIN_PACKET_SIZE"]
      [#assign NX_HTTP_CLIENT_MIN_PACKET_SIZE_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_TIMEOUT"]
      [#assign NX_HTTP_SERVER_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_THREAD_TIME_SLICE"]
      [#assign NX_HTTP_SERVER_THREAD_TIME_SLICE_value = value]
    [/#if]

	[#if name == "NX_HTTP_MAX_HEADER_FIELD"]
      [#assign NX_HTTP_MAX_HEADER_FIELD_value = value]
    [/#if]

	[#if name == "NX_HTTP_MULTIPART_ENABLE"]
      [#assign NX_HTTP_MULTIPART_ENABLE_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_MAX_PENDING"]
      [#assign NX_HTTP_SERVER_MAX_PENDING_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH"]
      [#assign NX_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_MIN_PACKET_SIZE"]
      [#assign NX_HTTP_SERVER_MIN_PACKET_SIZE_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_RETRY_SECONDS"]
      [#assign NX_HTTP_SERVER_RETRY_SECONDS_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_RETRY_SHIFT"]
      [#assign NX_HTTP_SERVER_RETRY_SHIFT_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_RETRY_MAX"]
      [#assign NX_HTTP_SERVER_RETRY_MAX_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_PRIORITY"]
      [#assign NX_HTTP_SERVER_PRIORITY_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_WINDOW_SIZE"]
      [#assign NX_HTTP_SERVER_WINDOW_SIZE_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_TIMEOUT_ACCEPT"]
      [#assign NX_HTTP_SERVER_TIMEOUT_ACCEPT_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_TIMEOUT_RECEIVE"]
      [#assign NX_HTTP_SERVER_TIMEOUT_RECEIVE_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_TIMEOUT_SEND"]
      [#assign NX_HTTP_SERVER_TIMEOUT_SEND_value = value]
    [/#if]

	[#if name == "NX_HTTP_SERVER_TIMEOUT_DISCONNECT"]
      [#assign NX_HTTP_SERVER_TIMEOUT_DISCONNECT_value = value]
    [/#if]
		
	[#if name == "NX_AUTO_IP_DEBUG"]
      [#assign NX_AUTO_IP_DEBUG_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_PROBE_WAIT"]
      [#assign NX_AUTO_IP_PROBE_WAIT_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_PROBE_NUM"]
      [#assign NX_AUTO_IP_PROBE_NUM_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_PROBE_MIN"]
      [#assign NX_AUTO_IP_PROBE_MIN_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_PROBE_MAX"]
      [#assign NX_AUTO_IP_PROBE_MAX_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_MAX_CONFLICTS"]
      [#assign NX_AUTO_IP_MAX_CONFLICTS_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_RATE_LIMIT_INTERVAL"]
      [#assign NX_AUTO_IP_RATE_LIMIT_INTERVAL_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_ANNOUNCE_WAIT"]
      [#assign NX_AUTO_IP_ANNOUNCE_WAIT_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_ANNOUNCE_NUM"]
      [#assign NX_AUTO_IP_ANNOUNCE_NUM_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_ANNOUNCE_INTERVAL"]
      [#assign NX_AUTO_IP_ANNOUNCE_INTERVAL_value = value]
    [/#if]
	
	[#if name == "NX_AUTO_IP_DEFEND_INTERVAL"]
      [#assign NX_AUTO_IP_DEFEND_INTERVAL_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_DISABLE_SERVER"]
      [#assign NX_MDNS_DISABLE_SERVER_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_IPV6_ADDRESS_COUNT"]
      [#assign NX_MDNS_IPV6_ADDRESS_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_HOST_NAME_MAX"]
      [#assign NX_MDNS_HOST_NAME_MAX_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_SERVICE_NAME_MAX"]
      [#assign NX_MDNS_SERVICE_NAME_MAX_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_DOMAIN_NAME_MAX"]
      [#assign NX_MDNS_DOMAIN_NAME_MAX_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_CONFLICT_COUNT"]
      [#assign NX_MDNS_CONFLICT_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_UDP_TYPE_OF_SERVICE"]
      [#assign NX_MDNS_UDP_TYPE_OF_SERVICE_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RR_TTL_HOST"]
      [#assign NX_MDNS_RR_TTL_HOST_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RR_TTL_OTHER"]
      [#assign NX_MDNS_RR_TTL_OTHER_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_PROBING_TIMER_COUNT"]
      [#assign NX_MDNS_PROBING_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_ANNOUNCING_TIMER_COUNT"]
      [#assign NX_MDNS_ANNOUNCING_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_GOODBYE_TIMER_COUNT"]
      [#assign NX_MDNS_GOODBYE_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_QUERY_MIN_TIMER_COUNT"]
      [#assign NX_MDNS_QUERY_MIN_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_QUERY_MAX_TIMER_COUNT"]
      [#assign NX_MDNS_QUERY_MAX_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_QUERY_DELAY_MIN"]
      [#assign NX_MDNS_QUERY_DELAY_MIN_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_QUERY_DELAY_RANGE"]
      [#assign NX_MDNS_QUERY_DELAY_RANGE_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RESPONSE_INTERVAL"]
      [#assign NX_MDNS_RESPONSE_INTERVAL_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RESPONSE_UNIQUE_DELAY"]
      [#assign NX_MDNS_RESPONSE_UNIQUE_DELAY_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RESPONSE_SHARED_DELAY_MIN"]
      [#assign NX_MDNS_RESPONSE_SHARED_DELAY_MIN_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RESPONSE_SHARED_DELAY_RANGE"]
      [#assign NX_MDNS_RESPONSE_SHARED_DELAY_RANGE_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RESPONSE_TC_DELAY_MIN"]
      [#assign NX_MDNS_RESPONSE_TC_DELAY_MIN_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RESPONSE_TC_DELAY_RANGE"]
      [#assign NX_MDNS_RESPONSE_TC_DELAY_RANGE_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_TIMER_COUNT_RANGE"]
      [#assign NX_MDNS_TIMER_COUNT_RANGE_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_PROBING_RETRANSMIT_COUNT"]
      [#assign NX_MDNS_PROBING_RETRANSMIT_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_GOODBYE_RETRANSMIT_COUNT"]
      [#assign NX_MDNS_GOODBYE_RETRANSMIT_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_POOF_MIN_COUNT"]
      [#assign NX_MDNS_POOF_MIN_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_POOF_TIMER_COUNT"]
      [#assign NX_MDNS_POOF_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_MDNS_RR_DELETE_DELAY_TIMER_COUNT"]
      [#assign NX_MDNS_RR_DELETE_DELAY_TIMER_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_PPP_PPPOE_ENABLE"]
      [#assign NX_PPP_PPPOE_ENABLE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DISABLE_INFO"]
      [#assign NX_PPP_DISABLE_INFO_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DEBUG_LOG_ENABLE"]
      [#assign NX_PPP_DEBUG_LOG_ENABLE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DEBUG_LOG_PRINT_ENABLE"]
      [#assign NX_PPP_DEBUG_LOG_PRINT_ENABLE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DISABLE_CHAP"]
      [#assign NX_PPP_DISABLE_CHAP_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DISABLE_PAP"]
      [#assign NX_PPP_DISABLE_PAP_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DNS_OPTION_DISABLE"]
      [#assign NX_PPP_DNS_OPTION_DISABLE_value = value]
    [/#if]
	
		[#if name == "NX_PPP_DNS_ADDRESS_MAX_RETRIES"]
      [#assign NX_PPP_DNS_ADDRESS_MAX_RETRIES_value = value]
    [/#if]
	
	[#if name == "NX_PPP_THREAD_TIME_SLICE"]
      [#assign NX_PPP_THREAD_TIME_SLICE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_MRU"]
      [#assign NX_PPP_MRU_value = value]
	
    [/#if]
		[#if name == "NX_PPP_MINIMUM_MRU"]
      [#assign NX_PPP_MINIMUM_MRU_value = value]
    [/#if]
	
	[#if name == "NX_PPP_SERIAL_BUFFER_SIZE"]
      [#assign NX_PPP_SERIAL_BUFFER_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_NAME_SIZE"]
      [#assign NX_PPP_NAME_SIZE_value = value]
    [/#if]
	
		[#if name == "NX_PPP_PASSWORD_SIZE"]
      [#assign NX_PPP_PASSWORD_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_VALUE_SIZE"]
      [#assign NX_PPP_VALUE_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_HASHED_VALUE_SIZE"]
      [#assign NX_PPP_HASHED_VALUE_SIZE_value = value]
    [/#if]
	
		[#if name == "NX_PPP_BASE_TIMEOUT"]
      [#assign NX_PPP_BASE_TIMEOUT_value = value]
    [/#if]
	
	[#if name == "NX_PPP_TIMEOUT"]
      [#assign NX_PPP_TIMEOUT_value = value]
    [/#if]
	
	[#if name == "NX_PPP_RECEIVE_TIMEOUTS"]
      [#assign NX_PPP_RECEIVE_TIMEOUTS_value = value]
    [/#if]
		[#if name == "NX_PPP_PROTOCOL_TIMEOUT"]
      [#assign NX_PPP_PROTOCOL_TIMEOUT_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DEBUG_LOG_SIZE"]
      [#assign NX_PPP_DEBUG_LOG_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_PPP_DEBUG_FRAME_SIZE"]
      [#assign NX_PPP_DEBUG_FRAME_SIZE_value = value]
    [/#if]
	
		[#if name == "NX_PPP_MAX_LCP_PROTOCOL_RETRIES"]
      [#assign NX_PPP_MAX_LCP_PROTOCOL_RETRIES_value = value]
    [/#if]
	
	[#if name == "NX_PPP_MAX_PAP_PROTOCOL_RETRIES"]
      [#assign NX_PPP_MAX_PAP_PROTOCOL_RETRIES_value = value]
    [/#if]
	
	[#if name == "NX_PPP_MAX_CHAP_PROTOCOL_RETRIES"]
      [#assign NX_PPP_MAX_CHAP_PROTOCOL_RETRIES_value = value]
    [/#if]
	
	[#if name == "NX_PPP_PACKET"]
      [#assign NX_PPP_PACKET_value = value]
    [/#if]
	
	[#if name == "NX_PPP_MIN_PACKET_PAYLOAD"]
      [#assign NX_PPP_MIN_PACKET_PAYLOAD_value = value]
    [/#if]
		
	[#if name == "NX_SNTP_CLIENT_THREAD_STACK_SIZE"]
      [#assign NX_SNTP_CLIENT_THREAD_STACK_SIZE_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_THREAD_TIME_SLICE"]
      [#assign NX_SNTP_CLIENT_THREAD_TIME_SLICE_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_THREAD_PRIORITY"]
      [#assign NX_SNTP_CLIENT_THREAD_PRIORITY_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_PREEMPTION_THRESHOLD"]
      [#assign NX_SNTP_CLIENT_PREEMPTION_THRESHOLD_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_UDP_SOCKET_NAME"]
      [#assign NX_SNTP_CLIENT_UDP_SOCKET_NAME_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_UDP_PORT"]
      [#assign NX_SNTP_CLIENT_UDP_PORT_value = value]
    [/#if]

	[#if name == "NX_SNTP_SERVER_UDP_PORT"]
      [#assign NX_SNTP_SERVER_UDP_PORT_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_TIME_TO_LIVE"]
      [#assign NX_SNTP_CLIENT_TIME_TO_LIVE_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MAX_QUEUE_DEPTH"]
      [#assign NX_SNTP_CLIENT_MAX_QUEUE_DEPTH_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_PACKET_TIMEOUT"]
      [#assign NX_SNTP_CLIENT_PACKET_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_NTP_VERSION"]
      [#assign NX_SNTP_CLIENT_NTP_VERSION_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MIN_NTP_VERSION"]
      [#assign NX_SNTP_CLIENT_MIN_NTP_VERSION_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MIN_SERVER_STRATUM"]
      [#assign NX_SNTP_CLIENT_MIN_SERVER_STRATUM_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MIN_TIME_ADJUSTMENT"]
      [#assign NX_SNTP_CLIENT_MIN_TIME_ADJUSTMENT_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MAX_TIME_ADJUSTMENT"]
      [#assign NX_SNTP_CLIENT_MAX_TIME_ADJUSTMENT_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_IGNORE_MAX_ADJUST_STARTUP"]
      [#assign NX_SNTP_CLIENT_IGNORE_MAX_ADJUST_STARTUP_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_RANDOMIZE_ON_STARTUP"]
      [#assign NX_SNTP_CLIENT_RANDOMIZE_ON_STARTUP_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MAX_TIME_LAPSE"]
      [#assign NX_SNTP_CLIENT_MAX_TIME_LAPSE_value = value]
    [/#if]

	[#if name == "NX_SNTP_UPDATE_TIMEOUT_INTERVAL"]
      [#assign NX_SNTP_UPDATE_TIMEOUT_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_SLEEP_INTERVAL"]
      [#assign NX_SNTP_CLIENT_SLEEP_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_UNICAST_POLL_INTERVAL"]
      [#assign NX_SNTP_CLIENT_UNICAST_POLL_INTERVAL_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_EXP_BACKOFF_RATE"]
      [#assign NX_SNTP_CLIENT_EXP_BACKOFF_RATE_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_RTT_REQUIRED"]
      [#assign NX_SNTP_CLIENT_RTT_REQUIRED_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_MAX_ROOT_DISPERSION"]
      [#assign NX_SNTP_CLIENT_MAX_ROOT_DISPERSION_value = value]
    [/#if]

	[#if name == "NX_SNTP_CLIENT_INVALID_UPDATE_LIMIT"]
      [#assign NX_SNTP_CLIENT_INVALID_UPDATE_LIMIT_value = value]
    [/#if]

	[#if name == "NX_SNTP_CURRENT_YEAR"]
      [#assign NX_SNTP_CURRENT_YEAR_value = value]
    [/#if]

	[#if name == "NTP_SECONDS_AT_01011999"]
      [#assign NTP_SECONDS_AT_01011999_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_TYPE_OF_SERVICE"]
      [#assign NX_WEB_HTTP_TYPE_OF_SERVICE_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_FRAGMENT_OPTION"]
      [#assign NX_WEB_HTTP_FRAGMENT_OPTION_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_TIME_TO_LIVE"]
      [#assign NX_WEB_HTTP_TIME_TO_LIVE_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_MAX_RESOURCE"]
      [#assign NX_WEB_HTTP_MAX_RESOURCE_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_MAX_NAME"]
      [#assign NX_WEB_HTTP_MAX_NAME_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_MAX_PASSWORD"]
      [#assign NX_WEB_HTTP_MAX_PASSWORD_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTPS_ENABLE"]
      [#assign NX_WEB_HTTPS_ENABLE_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_DIGEST_ENABLE"]
      [#assign NX_WEB_HTTP_DIGEST_ENABLE_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_MAX_HEADER_FIELD"]
      [#assign NX_WEB_HTTP_MAX_HEADER_FIELD_value = value]
    [/#if]

	
	[#if name == "NX_WEB_HTTP_SERVER_PRIORITY"]
      [#assign NX_WEB_HTTP_SERVER_PRIORITY_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_WINDOW_SIZE"]
      [#assign NX_WEB_HTTP_SERVER_WINDOW_SIZE_value = value]
    [/#if]		

	[#if name == "NX_WEB_HTTP_SERVER_TIMEOUT_ACCEPT"]
      [#assign NX_WEB_HTTP_SERVER_TIMEOUT_ACCEPT_value = value]
    [/#if]		

	[#if name == "NX_WEB_HTTP_SERVER_TIMEOUT_RECEIVE"]
      [#assign NX_WEB_HTTP_SERVER_TIMEOUT_RECEIVE_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_TIMEOUT_SEND"]
      [#assign NX_WEB_HTTP_SERVER_TIMEOUT_SEND_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_TIMEOUT_DISCONNECT"]
      [#assign NX_WEB_HTTP_SERVER_TIMEOUT_DISCONNECT_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_TIMEOUT"]
      [#assign NX_WEB_HTTP_SERVER_TIMEOUT_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_SESSION_MAX"]
      [#assign NX_WEB_HTTP_SERVER_SESSION_MAX_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_MAX_PENDING"]
      [#assign NX_WEB_HTTP_SERVER_MAX_PENDING_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_THREAD_TIME_SLICE"]
      [#assign NX_WEB_HTTP_SERVER_THREAD_TIME_SLICE_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_MIN_PACKET_SIZE"]
      [#assign NX_WEB_HTTP_SERVER_MIN_PACKET_SIZE_value = value]
    [/#if]		

	[#if name == "NX_WEB_HTTP_SERVER_RETRY_SECONDS"]
      [#assign NX_WEB_HTTP_SERVER_RETRY_SECONDS_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH"]
      [#assign NX_WEB_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_SERVER_RETRY_SHIFT"]
      [#assign NX_WEB_HTTP_SERVER_RETRY_SHIFT_value = value]
    [/#if]	

	[#if name == "NX_WEB_HTTP_MULTIPART_ENABLE"]
      [#assign NX_WEB_HTTP_MULTIPART_ENABLE_value = value]
    [/#if]

	[#if name == "NX_WEB_HTTP_SERVER_RETRY_MAX"]
      [#assign NX_WEB_HTTP_SERVER_RETRY_MAX_value = value]
    [/#if]
  [/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Define various build options for the NetX Duo port. The application should
   either make changes here by commenting or un-commenting the conditional
   compilation defined OR supply the defines though the compiler's equivalent
   of the -D option.  */

/* Override various options with default values already assigned in nx_api.h
   or nx_port.h. Please also refer to nx_port.h for descriptions on each of
   these options.  */

/*****************************************************************************/
/************** Configuration options for NetXDuo Core ***********************/
/*****************************************************************************/

/* NX_MAX_PHYSICAL_INTERFACES defines the number physical network interfaces
   present to NetX Duo IP layer.  Physical interface does not include
   loopback interface. By default there is at least one physical interface
   in the system. */
[#if NX_MAX_PHYSICAL_INTERFACES_value == "1"]
/*
#define NX_MAX_PHYSICAL_INTERFACES              1
*/
[#else]
#define NX_MAX_PHYSICAL_INTERFACES				${NX_MAX_PHYSICAL_INTERFACES_value}
[/#if]

/* If defined, the link driver is able to specify extra capability, such as
   checksum offloading features. */
[#if NX_ENABLE_INTERFACE_CAPABILITY_value == "true"]
#define NX_ENABLE_INTERFACE_CAPABILITY
[#else]
/*
#define NX_ENABLE_INTERFACE_CAPABILITY
*/
[/#if]

/* NX_PHYSICAL_HEADER Specifies the size in bytes of the physical header of
   the frame. */
[#if NX_PHYSICAL_HEADER_value == "16"]
/*
#define NX_PHYSICAL_HEADER						16
*/						
[#else]
#define NX_PHYSICAL_HEADER                      ${NX_PHYSICAL_HEADER_value}
[/#if]

/* NX_PHYSICAL_TRAILER specifies the size in bytes of the physical packet
   trailer and is typically used to reserve storage for things like Ethernet
   CRCs, etc. */
/* Define the max string length. The default value is 1024.  */
[#if NX_PHYSICAL_TRAILER_value == "4"]
/*
#define NX_PHYSICAL_TRAILER                     4
*/
[#else]
#define NX_PHYSICAL_TRAILER                     ${NX_PHYSICAL_TRAILER_value}
[/#if]

/* Defined, this option bypasses the basic NetX error checking. This define
   is typically used after the application is fully debugged.
*/
[#if NX_DISABLE_ERROR_CHECKING_value == "true"]
#define NX_DISABLE_ERROR_CHECKING
[#else]
/*
#define NX_DISABLE_ERROR_CHECKING
*/
[/#if]

/* Defined, this option enables deferred driver packet handling. This allows
   the driver to place a raw packet on the IP instance and have the driver's
   real processing routine called from the NetX internal IP helper thread. */
[#if NX_DRIVER_DEFERRED_PROCESSING_value == "true"]
#define NX_DRIVER_DEFERRED_PROCESSING
[#else]
/*
#define NX_DRIVER_DEFERRED_PROCESSING
*/
[/#if]

/* Defined, the source address of incoming packet is checked. The default is
   disabled. */
[#if NX_ENABLE_SOURCE_ADDRESS_CHECK_value == "true"]
#define NX_ENABLE_SOURCE_ADDRESS_CHECK
[#else]
/*
#define NX_ENABLE_SOURCE_ADDRESS_CHECK
*/
[/#if]

/* Defined, ASSERT is disabled. The default is enabled. */
[#if NX_DISABLE_ASSERT_value == "1"]
#define NX_DISABLE_ASSERT
[#else]
/*
#define NX_DISABLE_ASSERT
*/
[/#if]

/* Defined, ASSERT is disabled. The default is enabled. */
[#if NX_ASSERT_FAIL_value == " " || NX_ASSERT_FAIL_value == "" || NX_ASSERT_FAIL_value == "for (;;) {tx_thread_sleep(NX_WAIT_FOREVER); }"]
/*
#define NX_ASSERT_FAIL 							for (;;) {tx_thread_sleep(NX_WAIT_FOREVER); }
*/
[#else]
#define NX_ASSERT_FAIL							${NX_ASSERT_FAIL_value}
[/#if]

/* Define the max string length. The default value is 1024.  */
[#if NX_MAX_STRING_LENGTH_value == "1024"]
/*
#define NX_MAX_STRING_LENGTH                    1024
*/
[#else]
#define NX_MAX_STRING_LENGTH                    ${NX_MAX_STRING_LENGTH_value}
[/#if]

/* Defined, enables the optional debug packet dumping available in the RAM
   Ethernet network driver.  */
[#if NX_DEBUG_PACKET_value == "true"]
#define NX_DEBUG_PACKET
[#else]
/*
#define NX_DEBUG_PACKET
*/
[/#if]

/* Defined, enables the optional print debug information available from the RAM
   Ethernet network driver. */
[#if NX_DEBUG_value == "true"]
#define NX_DEBUG
[#else]
/*
#define NX_DEBUG
*/
[/#if]

/* Defined, the extended notify support is enabled.  This feature adds additional
   callback/notify services to NetX Duo API for notifying the application of
   socket events, such as TCP connection and disconnect completion.
   These extended notify functions are mainly used by the BSD wrapper.
   The default is this feature is disabled.  */
[#if NX_ENABLE_EXTENDED_NOTIFY_SUPPORT_value == "true"]
#define NX_ENABLE_EXTENDED_NOTIFY_SUPPORT
[#else]
/*
#define NX_ENABLE_EXTENDED_NOTIFY_SUPPORT
*/
[/#if]


/* Defined, NetX Duo is built with NAT process. By default this option is not
   defined. */
[#if NX_NAT_ENABLE_value == "true"]
#define NX_NAT_ENABLE
[#else]
/*
#define NX_NAT_ENABLE
*/
[/#if]

/* Defined, allows the stack to use two packet pools, one with large payload
   size and one with smaller payload size. By default this option is not
   enabled. */
[#if NX_ENABLE_DUAL_PACKET_POOL_value == "true"]
#define NX_ENABLE_DUAL_PACKET_POOL
[#else]
/*
#define NX_ENABLE_DUAL_PACKET_POOL
*/
[/#if]

/*****************************************************************************/
/***************** Configuration options for Packet **************************/
/*****************************************************************************/

/* Defined, packet header and payload are aligned automatically by the value.
   The default value is sizeof(ULONG). */
[#if NX_PACKET_ALIGNMENT_value == "4"]
/*
#define NX_PACKET_ALIGNMENT 	  				sizeof(ULONG)
*/
[#else]
#define NX_PACKET_ALIGNMENT       				${NX_PACKET_ALIGNMENT_value}
[/#if]

/* Defined, packet debug information is enabled.  */
[#if NX_ENABLE_PACKET_DEBUG_INFO_value == "true"]
#define NX_ENABLE_PACKET_DEBUG_INFO
[#else]
/*
#define NX_ENABLE_PACKET_DEBUG_INFO
*/
[/#if]

/* If defined, the packet chain feature is removed. */
[#if NX_DISABLE_PACKET_CHAIN_value == "true"]
#define NX_DISABLE_PACKET_CHAIN
[#else]
/*
#define NX_DISABLE_PACKET_CHAIN
*/
[/#if]

/* Defined, disables packet pool information gathering. */
[#if NX_DISABLE_PACKET_INFO_value == "true"]
#define NX_DISABLE_PACKET_INFO
[#else]
/*
#define NX_DISABLE_PACKET_INFO
*/
[/#if]

/* Defined, enables NetX Duo packet pool low watermark feature. Application
   sets low watermark value. On receiving TCP packets, if the packet pool
   low watermark is reached, NetX Duo silently discards the packet by releasing
   it, preventing the packet pool from starvation. By default this feature is
   not enabled. */
[#if NX_ENABLE_LOW_WATERMARK_value == "true"]
#define NX_ENABLE_LOW_WATERMARK
[#else]
/*
#define NX_ENABLE_LOW_WATERMARK
*/
[/#if]

/*****************************************************************************/
/************* Configuration options for Neighbor Cache **********************/
/*****************************************************************************/

/* Define the length of time, in milliseconds, between re-transmitting
   Neighbor Solicitation (NS) packets. */
[#if NX_RETRANS_TIMER_value == "1000"]
/*
#define NX_RETRANS_TIMER						1000
*/
[#else]
#define NX_RETRANS_TIMER                       	${NX_RETRANS_TIMER_value}
[/#if]

/* Defined, this option disables Duplicate Address Detection (DAD) during IPv6
   address assignment. Addresses are set either by manual configuration or
   through Stateless Address Auto Configuration. */
[#if NX_DISABLE_IPV6_DAD_value == "true"]
#define NX_DISABLE_IPV6_DAD
[#else]
/*
#define NX_DISABLE_IPV6_DAD
*/
[/#if]

/* Defined, this option prevents NetX Duo from removing stale (old) cache table
   entries whose timeout has not expired so are otherwise still valid) to make
   room for new entries when the table is full. Static and router entries are
   not purged.  */
[#if NX_DISABLE_IPV6_PURGE_UNUSED_CACHE_ENTRIES_value == "true"]
#define NX_DISABLE_IPV6_PURGE_UNUSED_CACHE_ENTRIES
[#else]
/*
#define NX_DISABLE_IPV6_PURGE_UNUSED_CACHE_ENTRIES
*/
[/#if]

/* Specifies the number of Neighbor Solicitation messages to be sent before
   NetX Duo marks an interface address as valid. If NX_DISABLE_IPV6_DAD is
   defined (DAD disabled), setting this option has no effect. Alternatively,
   a value of zero (0) turns off DAD but leaves the DAD functionality in
   NetX Duo. Defined in nx_api.h, the default value is 3.  */
[#if NX_IPV6_DAD_TRANSMITS_value == "3"]
/*
#define NX_IPV6_DAD_TRANSMITS           		3
*/
[#else]
#define NX_IPV6_DAD_TRANSMITS					${NX_IPV6_DAD_TRANSMITS_value}
[/#if]

/* Specifies the number of entries in the IPv6 Neighbor Cache table. Defined
   in nx_nd_cache.h, the default value is 16. */
[#if NX_IPV6_NEIGHBOR_CACHE_SIZE_value == "16"]
/*
#define NX_IPV6_NEIGHBOR_CACHE_SIZE     		16
*/
[#else]
#define NX_IPV6_NEIGHBOR_CACHE_SIZE				${NX_IPV6_NEIGHBOR_CACHE_SIZE_value}
[/#if]

/* Specifies the delay in seconds before the first solicitation is sent out for
   a cache entry in the STALE state. Defined in nx_nd_cache.h, the default
   value is 5. */
[#if NX_DELAY_FIRST_PROBE_TIME_value == "5"]
/*
#define NX_DELAY_FIRST_PROBE_TIME       		5
*/
[#else]
#define NX_DELAY_FIRST_PROBE_TIME				${NX_DELAY_FIRST_PROBE_TIME_value}
[/#if]

/* Specifies the number of Neighbor Solicitation messages NetX Duo transmits as
   part of the IPv6 Neighbor Discovery protocol when mapping between IPv6
   address and MAC address is required. Defined in nx_nd_cache.h, the default
   value is 3. */
[#if NX_MAX_MULTICAST_SOLICIT_value == "3"]
/*
#define NX_MAX_MULTICAST_SOLICIT        		3
*/
[#else]
#define NX_MAX_MULTICAST_SOLICIT				${NX_MAX_MULTICAST_SOLICIT_value}
[/#if]

/* Specifies the number of Neighbor Solicitation messages NetX Duo transmits
   to determine a specific neighbor's reachability. Defined in nx_nd_cache.h,
   the default value is 3. */
[#if NX_MAX_UNICAST_SOLICIT_value == "3"]
/*
#define NX_MAX_UNICAST_SOLICIT          		3
*/
[#else]
#define NX_MAX_UNICAST_SOLICIT					${NX_MAX_UNICAST_SOLICIT_value}
[/#if]

/* This defines specifies the maximum number of packets that can be queued while waiting for a
   Neighbor Discovery to resolve an IPv6 address. The default value is 4.  */
[#if NX_ND_MAX_QUEUE_DEPTH_value == "4"]
/*
#define NX_ND_MAX_QUEUE_DEPTH           		4
*/
[#else]
#define NX_ND_MAX_QUEUE_DEPTH					${NX_ND_MAX_QUEUE_DEPTH_value}
[/#if]

/* Specifies the time out in seconds for a cache entry to exist in the REACHABLE
   state with no packets received from the cache destination IPv6 address.
   Defined in nx_nd_cache.h, the default value is 30. */
[#if NX_REACHABLE_TIME_value == "30"]
/*
#define NX_REACHABLE_TIME               		30
*/
[#else]
#define NX_REACHABLE_TIME						${NX_REACHABLE_TIME_value}
[/#if]

/*****************************************************************************/
/********************* Configuration options for IP **************************/
/*****************************************************************************/

/* Defined, this option disables NetX Duo support on the 127.0.0.1 loopback
   interface. 127.0.0.1 loopback interface is enabled by default.
   Uncomment out the follow code to disable the loopback interface. */

[#if NX_DISABLE_LOOPBACK_INTERFACE_value == "true"]
#define NX_DISABLE_LOOPBACK_INTERFACE
[#else]
/*
#define NX_DISABLE_LOOPBACK_INTERFACE
*/
[/#if]

/* Defined, this option disables the addition size checking on received packets. */
[#if NX_DISABLE_RX_SIZE_CHECKING_value == "true"]
#define NX_DISABLE_RX_SIZE_CHECKING
[#else]
/*
#define NX_DISABLE_RX_SIZE_CHECKING
*/
[/#if]

/* This defines specifies the number of ThreadX timer ticks in one second.
   The default value is based on ThreadX timer interrupt. */
[#if NX_IP_PERIODIC_RATE_value == TX_TIMER_TICKS_PER_SECOND_value]
/*
#ifdef TX_TIMER_TICKS_PER_SECOND
#define NX_IP_PERIODIC_RATE         			TX_TIMER_TICKS_PER_SECOND
#else
#define NX_IP_PERIODIC_RATE         			100
#endif
*/
[#else]
[#if NX_IP_PERIODIC_RATE_value == "100"]
#define NX_IP_PERIODIC_RATE                     100
[#else]
#define NX_IP_PERIODIC_RATE                     ${NX_IP_PERIODIC_RATE_value}
[/#if]     			
[/#if]

/* Defined, NX_ENABLE_IP_RAW_PACKET_FILTER allows an application to install a
   filter for incoming raw packets. This feature is disabled by default. */
[#if NX_ENABLE_IP_RAW_PACKET_FILTER_value == "true"]
#define NX_ENABLE_IP_RAW_PACKET_FILTER
[#else]
/*
#define NX_ENABLE_IP_RAW_PACKET_FILTER
*/
[/#if]

/* This define specifies the maximum number of RAW packets can be queued for
   receive. The default value is 20.  */
[#if NX_IP_RAW_MAX_QUEUE_DEPTH_value == "20"]
/*
#define NX_IP_RAW_MAX_QUEUE_DEPTH		  		20
*/
[#else]
#define NX_IP_RAW_MAX_QUEUE_DEPTH         		${NX_IP_RAW_MAX_QUEUE_DEPTH_value}
[/#if]

/* Defined, this option enables IP static routing feature. By default IP static
   routing feature is not compiled in. */
[#if NX_ENABLE_IP_STATIC_ROUTING_value == "true"]
#define NX_ENABLE_IP_STATIC_ROUTING
[#else]
/*
#define NX_ENABLE_IP_STATIC_ROUTING
*/
[/#if]

[#if NX_ENABLE_IP_STATIC_ROUTING_value == "true"]
/* This define specifies the size of IP routing table. The default value is 8. */
[#if NX_IP_ROUTING_TABLE_SIZE_value == "8"]
/*
#define NX_IP_ROUTING_TABLE_SIZE		 		8
*/
[#else]
#define NX_IP_ROUTING_TABLE_SIZE         		${NX_IP_ROUTING_TABLE_SIZE_value}
[/#if]
[/#if]

/* This define specifies the maximum time of IP reassembly.  The default value
   is 60. By default this option is not defined.  */
[#if NX_IP_MAX_REASSEMBLY_TIME_value == "60"]
/*
#define NX_IP_MAX_REASSEMBLY_TIME 			60
*/

/* Symbol that controls maximum time allowed to reassemble IPv4 fragment.
   Note the value defined in NX_IP_MAX_REASSEMBLY_TIME overwrites this value.
   The default value is 15. */
[#if NX_IPV4_MAX_REASSEMBLY_TIME_value == "15"]
/*
#define NX_IPV4_MAX_REASSEMBLY_TIME 			15
*/
[#else]
#define NX_IPV4_MAX_REASSEMBLY_TIME 			${NX_IPV4_MAX_REASSEMBLY_TIME_value}
[/#if]

/* This define specifies the maximum time of IPv6 reassembly. The default value
   is 60. Note that if NX_IP_MAX_REASSEMBLY_TIME is defined, this option is
   automatically defined as 60. By default this option is not defined. */
[#if NX_IPV6_MAX_REASSEMBLY_TIME_value == "60"]
/*
#define NX_IPV6_MAX_REASSEMBLY_TIME 60
*/
[#else]
#define NX_IPV6_MAX_REASSEMBLY_TIME 			${NX_IPV6_MAX_REASSEMBLY_TIME_value}
[/#if]

[#else]
#define NX_IP_MAX_REASSEMBLY_TIME 			${NX_IP_MAX_REASSEMBLY_TIME_value}

/* Symbol that controls maximum time allowed to reassemble IPv4 fragment.
   Note the value defined in NX_IP_MAX_REASSEMBLY_TIME overwrites this value.
   The default value is 15. */
#define NX_IPV4_MAX_REASSEMBLY_TIME NX_IP_MAX_REASSEMBLY_TIME

/* This define specifies the maximum time of IPv6 reassembly. The default value
   is 60. Note that if NX_IP_MAX_REASSEMBLY_TIME is defined, this option is
   automatically defined as 60. By default this option is not defined. */
#define NX_IPV6_MAX_REASSEMBLY_TIME NX_IP_MAX_REASSEMBLY_TIME
[/#if]

/* Defined, this option disables checksum logic on received IP packets.
   This is useful if the link-layer has reliable checksum or CRC logic. */
[#if NX_DISABLE_IP_RX_CHECKSUM_value == "true"]
#define NX_DISABLE_IP_RX_CHECKSUM
[#else]
/*
#define NX_DISABLE_IP_RX_CHECKSUM
*/
[/#if]

/* Defined, this option disables checksum logic on transmitted IP packets. */
[#if NX_DISABLE_IP_TX_CHECKSUM_value == "true"]
#define NX_DISABLE_IP_TX_CHECKSUM
[#else]
/*
#define NX_DISABLE_IP_TX_CHECKSUM
*/
[/#if]

/* Defined, IP information gathering is disabled.  */
[#if NX_DISABLE_IP_INFO_value == "true"]
#define NX_DISABLE_IP_INFO
[#else]
/*
#define NX_DISABLE_IP_INFO
*/
[/#if]

/* This define IP fast timer rate. The default value is 10. */
[#if NX_IP_FAST_TIMER_RATE_value == "10"]
/*
#define NX_IP_FAST_TIMER_RATE		 			10
*/
[#else]
#define NX_IP_FAST_TIMER_RATE         			${NX_IP_FAST_TIMER_RATE_value}
[/#if]

/* Define the amount of time to sleep in nx_ip_(interface_)status_check.
   The default value is 1. */
[#if NX_IP_STATUS_CHECK_WAIT_TIME_value == "1"]
/*
#define NX_IP_STATUS_CHECK_WAIT_TIME		 	1
*/
[#else]
#define NX_IP_STATUS_CHECK_WAIT_TIME         	${NX_IP_STATUS_CHECK_WAIT_TIME_value}
[/#if]

/* Defined, IP packet filter is enabled.  */
[#if NX_ENABLE_IP_PACKET_FILTER_value == "true"]
#define NX_ENABLE_IP_PACKET_FILTER
[#else]
/*
#define NX_ENABLE_IP_PACKET_FILTER
*/
[/#if]

/* Defined, disables both IPv4 and IPv6 fragmentation and reassembly logic. */
[#if NX_DISABLE_FRAGMENTATION_value == "true"]
#define NX_DISABLE_FRAGMENTATION
[#else]
/*
#define NX_DISABLE_FRAGMENTATION
*/
[/#if]

/* Defined, this option process IP fragmentation immediately.  */
[#if NX_FRAGMENT_IMMEDIATE_ASSEMBLY_value == "true"]
#define NX_FRAGMENT_IMMEDIATE_ASSEMBLY
[#else]
/*
#define NX_FRAGMENT_IMMEDIATE_ASSEMBLY
*/
[/#if]

/*****************************************************************************/
/******************** Configuration options for IPV 4 ************************/
/*****************************************************************************/

/* Defined, disables IPv4 functionality. This option can be used to build NetX
   Duo to support IPv6 only. By default this option is not defined. */
[#if NX_DISABLE_IPV4_value == "true"]
#define NX_DISABLE_IPV4
[#else]
/*
#define NX_DISABLE_IPV4
*/
[/#if]

/*****************************************************************************/
/******************** Configuration options for IPV 6 ************************/
/*****************************************************************************/

/* Disables IPv6 functionality when the NetX Duo library is built.
   For applications that do not need IPv6, this avoids pulling in code and
   additional storage space needed to support IPv6. */
[#if NX_DISABLE_IPV6_value == "true"]
#define NX_DISABLE_IPV6
[#else]
/*
#define NX_DISABLE_IPV6
*/
[/#if]

/* Defined, enable IPV6 features. */
[#if FEATURE_NX_IPV6_value == "true"]
#define FEATURE_NX_IPV6
[#else]
/*
#define FEATURE_NX_IPV6
*/
[/#if]

/* Specifies the number of entries in the IPv6 address pool. During interface
   configuration, NetX Duo uses IPv6 entries from the pool. It is defaulted to
   (NX_MAX_PHYSICAL_INTERFACES * 3) to allow each interface to have at least
   one link local address and two global addresses. Note that all interfaces
   share the IPv6 address pool. */
[#if NX_MAX_IPV6_ADDRESSES_value == "3" && NX_MAX_PHYSICAL_INTERFACES_value == "1"]
/*
#ifdef NX_MAX_PHYSICAL_INTERFACES
#define NX_MAX_IPV6_ADDRESSES 					(NX_MAX_PHYSICAL_INTERFACES * 3)
#endif
*/
[#else]
#define NX_MAX_IPV6_ADDRESSES 					${NX_MAX_IPV6_ADDRESSES_value}
[/#if]

/* If defined, application is able to control whether or not to perform IPv6
   stateless address auto-configuration with nxd_ipv6_stateless_address_autoconfig_enable()
   or nxd_ipv6_stateless_address_autoconfig_disable() service. If defined, the
   system starts with IPv6 stateless address auto-configuration enabled.
   This feature is disabled by default. */
[#if NX_IPV6_STATELESS_AUTOCONFIG_CONTROL_value == "true"]
#define NX_IPV6_STATELESS_AUTOCONFIG_CONTROL
[#else]
/*
#define NX_IPV6_STATELESS_AUTOCONFIG_CONTROL
*/
[/#if]

/* If enabled, application is able to install a callback function to get
   notified when an interface IPv6 address is changed. By default this
   feature is disabled. */
[#if NX_ENABLE_IPV6_ADDRESS_CHANGE_NOTIFY_value == "true"]
#define NX_ENABLE_IPV6_ADDRESS_CHANGE_NOTIFY
[#else]
/*
#define NX_ENABLE_IPV6_ADDRESS_CHANGE_NOTIFY
*/
[/#if]

/* This define enables simple IPv6 multicast group join/leave function.
   By default the IPv6 multicast join/leave function is not enabled. */
[#if NX_ENABLE_IPV6_MULTICAST_value == "true"]
#define NX_ENABLE_IPV6_MULTICAST
[#else]
/*
#define NX_ENABLE_IPV6_MULTICAST
*/
[/#if]

/* Defined, Minimum Path MTU Discovery feature is enabled.  */
[#if NX_ENABLE_IPV6_PATH_MTU_DISCOVERY_value == "true"]
#define NX_ENABLE_IPV6_PATH_MTU_DISCOVERY
[#else]
/*
#define NX_ENABLE_IPV6_PATH_MTU_DISCOVERY
*/
[/#if]

/* Define wait interval in seconds to reset the path MTU for a destination
   table entry after decreasing it in response to a packet too big error message.
   RFC 1981 Section 5.4 states the minimum time to wait is 5 minutes and
   recommends 10 minutes. */
[#if NX_PATH_MTU_INCREASE_WAIT_INTERVAL_value == "600"]
/*
#define NX_PATH_MTU_INCREASE_WAIT_INTERVAL          600
*/
[#else]
#define NX_PATH_MTU_INCREASE_WAIT_INTERVAL 			${NX_PATH_MTU_INCREASE_WAIT_INTERVAL_value}
[/#if]

/* Specifies the number of entries in the IPv6 destination table. This stores
   information about next hop addresses for IPv6 addresses. Defined in nx_api.h,
   the default value is 8. */
[#if NX_IPV6_DESTINATION_TABLE_SIZE_value == "8"]
/*
#define NX_IPV6_DESTINATION_TABLE_SIZE          8
*/
[#else]
#define NX_IPV6_DESTINATION_TABLE_SIZE 			${NX_IPV6_DESTINATION_TABLE_SIZE_value}
[/#if]

/* Specifies the size of the prefix table. Prefix information is obtained from
   router advertisements and is part of the IPv6 address configuration. Defined
   in nx_api.h, the default value is 8. */
[#if NX_IPV6_PREFIX_LIST_TABLE_SIZE_value == "8"]
/*
#define NX_IPV6_PREFIX_LIST_TABLE_SIZE  		8
*/
[#else]
#define NX_IPV6_PREFIX_LIST_TABLE_SIZE 			${NX_IPV6_PREFIX_LIST_TABLE_SIZE_value}
[/#if]

/* Specifies the number of entries in the IPv6 routing table. At least one
   entry is needed for the default router. Defined in nx_api.h, the default
   value is 8. */
[#if NX_IPV6_DEFAULT_ROUTER_TABLE_SIZE_value == "8"]
/*
#define NX_IPV6_DEFAULT_ROUTER_TABLE_SIZE 	    8
*/
[#else]
#define NX_IPV6_DEFAULT_ROUTER_TABLE_SIZE 	    ${NX_IPV6_DEFAULT_ROUTER_TABLE_SIZE_value}
[/#if]

/*****************************************************************************/
/******************** Configuration options for ICMP *************************/
/*****************************************************************************/

/* Defined, NetX Duo does not send ICMPv4 Error Messages in response to error
   conditions such as improperly formatted IPv4 header. By default this option
   is not defined. */
[#if NX_DISABLE_ICMPV4_ERROR_MESSAGE_value == "true"]
#define NX_DISABLE_ICMPV4_ERROR_MESSAGE
[#else]
/*
#define NX_DISABLE_ICMPV4_ERROR_MESSAGE
*/
[/#if]


/* Defined, this option disables checksum logic on received ICMPv4 or ICMPv6 packets.
   Note that if NX_DISABLE_ICMP_RX_CHECKSUM is defined, NX_DISABLE_ICMPV4_RX_CHECKSUM
   and NX_DISABLE_ICMPV6_RX_CHECKSUM are automatically defined. */
[#if NX_DISABLE_ICMP_RX_CHECKSUM_value == "true"]
#define NX_DISABLE_ICMP_RX_CHECKSUM
[#else]
/*
#define NX_DISABLE_ICMP_RX_CHECKSUM
*/
[/#if]

/* Defined, this option disables checksum logic on received ICMPv4 packets.
   Note that if NX_DISABLE_ICMP_RX_CHECKSUM is defined, this option is
   automatically defined. By default this option is not defined. */
[#if NX_DISABLE_ICMPV4_RX_CHECKSUM_value == "true" || NX_DISABLE_ICMP_RX_CHECKSUM_value == "true"]
#define NX_DISABLE_ICMPV4_RX_CHECKSUM
[#else]
/*
#define NX_DISABLE_ICMPV4_RX_CHECKSUM
*/
[/#if]

/* Defined, this option disables checksum logic on received ICMPv6 packets.
   Note that if NX_DISABLE_ICMP_RX_CHECKSUM is defined, this option is
   automatically defined. By default this option is not defined. */
[#if NX_DISABLE_ICMPV6_RX_CHECKSUM_value == "true" || NX_DISABLE_ICMP_RX_CHECKSUM_value == "true"]
#define NX_DISABLE_ICMPV6_RX_CHECKSUM
[#else]
/*
#define NX_DISABLE_ICMPV6_RX_CHECKSUM
*/
[/#if]

/* Defined, this option disables checksum logic on transmitted ICMPv4 or ICMPv6
   packets. Note that if NX_DISABLE_ICMP_TX_CHECKSUM is defined,
   NX_DISABLE_ICMPV4_TX_CHECKSUM and NX_DISABLE_ICMPV6_TX_CHECKSUM are
   automatically defined. */
[#if NX_DISABLE_ICMP_TX_CHECKSUM_value == "true"]
#define NX_DISABLE_ICMP_TX_CHECKSUM
[#else]
/*
#define NX_DISABLE_ICMP_TX_CHECKSUM
*/
[/#if]

/* Defined, this option disables checksum logic on transmitted ICMPv4 packets.
   Note that if NX_DISABLE_ICMP_TX_CHECKSUM is defined, this option is
   automatically defined. By default this option is not defined.*/
[#if NX_DISABLE_ICMPV4_TX_CHECKSUM_value == "true" || NX_DISABLE_ICMP_TX_CHECKSUM_value =="true"]
#define NX_DISABLE_ICMPV4_TX_CHECKSUM
[#else]
/*
#define NX_DISABLE_ICMPV4_TX_CHECKSUM
*/
[/#if]

/* Defined, this option disables checksum logic on transmitted ICMPv6 packets.
   Note that if NX_DISABLE_ICMP_TX_CHECKSUM is defined, this option is
   automatically defined. By default this option is not defined.*/
[#if NX_DISABLE_ICMPV6_TX_CHECKSUM_value == "true" || NX_DISABLE_ICMP_TX_CHECKSUM_value =="true"]
#define NX_DISABLE_ICMPV6_TX_CHECKSUM
[#else]
/*
#define NX_DISABLE_ICMPV6_TX_CHECKSUM
*/
[/#if]

/* Defined, ICMP information gathering is disabled. */
[#if NX_DISABLE_ICMP_INFO_value == "true"]
#define NX_DISABLE_ICMP_INFO
[#else]
/*
#define NX_DISABLE_ICMP_INFO
*/
[/#if]

/* Defined, the destination address of ICMP packet is checked. The default
   is disabled. An ICMP Echo Request destined to an IP broadcast or IP
   multicast address will be silently discarded. */
[#if NX_ENABLE_ICMP_ADDRESS_CHECK_value == "true"]
#define NX_ENABLE_ICMP_ADDRESS_CHECK
[#else]
/*
#define NX_ENABLE_ICMP_ADDRESS_CHECK
*/
[/#if]

/* Defined, disables NetX Duo from sending an ICMPv6 error message in response
   to a problem packet (e.g., improperly formatted header or packet header
   type is deprecated) received from another host. */
[#if NX_DISABLE_ICMPV6_ERROR_MESSAGE_value == "true"]
#define NX_DISABLE_ICMPV6_ERROR_MESSAGE
[#else]
/*
#define NX_DISABLE_ICMPV6_ERROR_MESSAGE
*/
[/#if]

/* Defined, disables ICMPv6 redirect packet processing. NetX Duo by default
   processes redirect messages and updates the destination table with next hop
   IP address information. */
[#if NX_DISABLE_ICMPV6_REDIRECT_PROCESS_value == "true"]
#define NX_DISABLE_ICMPV6_REDIRECT_PROCESS
[#else]
/*
#define NX_DISABLE_ICMPV6_REDIRECT_PROCESS
*/
[/#if]

/* Defined, disables NetX Duo from processing information received in IPv6
   router advertisement packets. */
[#if NX_DISABLE_ICMPV6_ROUTER_ADVERTISEMENT_PROCESS_value == "true"]
#define NX_DISABLE_ICMPV6_ROUTER_ADVERTISEMENT_PROCESS
[#else]
/*
#define NX_DISABLE_ICMPV6_ROUTER_ADVERTISEMENT_PROCESS
*/
[/#if]

/* Defined, disables NetX Duo from sending IPv6 router solicitation messages
   at regular intervals to the router. */
[#if NX_DISABLE_ICMPV6_ROUTER_SOLICITATION_value == "true"]
#define NX_DISABLE_ICMPV6_ROUTER_SOLICITATION
[#else]
/*
#define NX_DISABLE_ICMPV6_ROUTER_SOLICITATION
*/
[/#if]

/* Define the max number of router solicitations a host sends until a router
   response is received. If no response is received, the host concludes no
   router is present. The default value is 3. */
[#if NX_ICMPV6_MAX_RTR_SOLICITATIONS_value == "3"]
/*
#define NX_ICMPV6_MAX_RTR_SOLICITATIONS         3
*/
[#else]
#define NX_ICMPV6_MAX_RTR_SOLICITATIONS 	    ${NX_ICMPV6_MAX_RTR_SOLICITATIONS_value}
[/#if]

/* Specifies the interval between two router solicitation messages.
   The default value is 4. */
[#if NX_ICMPV6_RTR_SOLICITATION_INTERVAL_value == "4"]
/*
#define NX_ICMPV6_RTR_SOLICITATION_INTERVAL     4
*/
[#else]
#define NX_ICMPV6_RTR_SOLICITATION_INTERVAL 	${NX_ICMPV6_RTR_SOLICITATION_INTERVAL_value}
[/#if]

/* Specifies the maximum delay for the initial router solicitation in seconds. */
[#if NX_ICMPV6_RTR_SOLICITATION_DELAY_value == "1"]
/*
#define NX_ICMPV6_RTR_SOLICITATION_DELAY        1
*/
[#else]
#define NX_ICMPV6_RTR_SOLICITATION_DELAY 	    ${NX_ICMPV6_RTR_SOLICITATION_DELAY_value}
[/#if]

/*****************************************************************************/
/********************* Configuration options for TCP *************************/
/*****************************************************************************/

/* Specifies how the number of system ticks (NX_IP_PERIODIC_RATE) is divided
   to calculate the timer rate for the TCP delayed ACK processing.
   The default value is 5, which represents 200ms, and is defined in nx_tcp.h.
   The application can override the default by defining the value before
   nx_api.h is included. */
[#if NX_TCP_ACK_TIMER_RATE_value == "5"]
/*
#define NX_TCP_ACK_TIMER_RATE       			5
*/
[#else]
#define NX_TCP_ACK_TIMER_RATE 	    			${NX_TCP_ACK_TIMER_RATE_value}
[/#if]

/* Specifies how the number of NetX Duo internal ticks (NX_IP_PERIODIC_RATE)
   is divided to calculate the fast TCP timer rate. The fast TCP timer is used
   to drive the various TCP timers, including the delayed ACK timer.
   The default value is 10, which represents 100ms assuming the ThreadX timer
   is running at 10ms. This value is defined in nx_tcp.h. The application can
   override the default by defining the value before nx_api.h is included. */
[#if NX_TCP_FAST_TIMER_RATE_value == "10"]
/*
#define NX_TCP_FAST_TIMER_RATE      			10
*/
[#else]
#define NX_TCP_FAST_TIMER_RATE 	    			${NX_TCP_FAST_TIMER_RATE_value}
[/#if]

/* Specifies how the number of system ticks (NX_IP_PERIODIC_RATE) is divided to
   calculate the timer rate for the TCP transmit retry processing.
   The default value is 1, which represents 1 second, and is defined in nx_tcp.h.
   The application can override the default by defining the value before nx_api.h
   is included. */
[#if NX_TCP_TRANSMIT_TIMER_RATE_value == "1"]
/*
#define NX_TCP_TRANSMIT_TIMER_RATE  			1
*/
[#else]
#define NX_TCP_TRANSMIT_TIMER_RATE 	    		${NX_TCP_TRANSMIT_TIMER_RATE_value}
[/#if]

/* Specifies the number of seconds of inactivity before the keepalive timer
   activates. The default value is 7200, which represents 2 hours, and is
   defined in nx_tcp.h. The application can override the default by defining
   the value before nx_api.h is included. */
[#if NX_TCP_KEEPALIVE_INITIAL_value == "7200"]
/*
#define NX_TCP_KEEPALIVE_INITIAL    			7200
*/
[#else]
#define NX_TCP_KEEPALIVE_INITIAL 	    		${NX_TCP_KEEPALIVE_INITIAL_value}
[/#if]

/* Specifies the number of seconds between retries of the keepalive timer
   assuming the other side of the connection is not responding. The default
   value is 75, which represents 75 seconds between retries, and is defined
   in nx_tcp.h. The application can override the default by defining the value
   before nx_api.h is included. */
[#if NX_TCP_KEEPALIVE_RETRY_value == "75"]
/*
#define NX_TCP_KEEPALIVE_RETRY      			75
*/
[#else]
#define NX_TCP_KEEPALIVE_RETRY 	    			${NX_TCP_KEEPALIVE_RETRY_value}
[/#if]

/* Symbol that defines the maximum number of out-of-order TCP packets can be
   kept in the TCP socket receive queue. This symbol can be used to limit the
   number of packets queued in the TCP receive socket, preventing the packet
   pool from being starved. By default this symbol is not defined, thus there
   is no limit on the number of out of order packets being queued in the TCP
   socket. */
#define NX_TCP_MAX_OUT_OF_ORDER_PACKETS 	    ${NX_TCP_MAX_OUT_OF_ORDER_PACKETS_value}

/* Defined, enables the optional TCP keepalive timer. The default settings is
   not enabled. */
[#if NX_ENABLE_TCP_KEEPALIVE_value == "true"]
#define NX_ENABLE_TCP_KEEPALIVE
[#else]
/*
#define NX_ENABLE_TCP_KEEPALIVE
*/
[/#if]

/* Defined, enables the optional TCP immediate ACK response processing.
   Defining this symbol is equivalent to defining NX_TCP_ACK_EVERY_N_PACKETS
   to be 1. */
[#if NX_TCP_IMMEDIATE_ACK_value == "true"]
#define NX_TCP_IMMEDIATE_ACK
[#else]
/*
#define NX_TCP_IMMEDIATE_ACK
*/
[/#if]

/* Specifies the number of TCP packets to receive before sending an ACK.
   Note if NX_TCP_IMMEDIATE_ACK is enabled but NX_TCP_ACK_EVERY_N_PACKETS is
   not, this value is automatically set to 1 for backward compatibility. */
[#if NX_TCP_ACK_EVERY_N_PACKETS_value == "2"]
/*
#define NX_TCP_ACK_EVERY_N_PACKETS  			2
*/
[#else]
#define NX_TCP_ACK_EVERY_N_PACKETS 	    		${NX_TCP_ACK_EVERY_N_PACKETS_value}
[/#if]

/* Automatically define NX_TCP_ACK_EVERY_N_PACKETS to 1 if NX_TCP_IMMEDIATE_ACK is defined.
   This is needed for backward compatibility. */
#if (defined(NX_TCP_IMMEDIATE_ACK) && !defined(NX_TCP_ACK_EVERY_N_PACKETS))
#define NX_TCP_ACK_EVERY_N_PACKETS 1
#endif

/* Specifies how many data transmit retries are allowed before the connection
   is deemed broken. The default value is 10, which represents 10 retries, and
   is defined in nx_tcp.h. The application can override the default by defining
   the value before nx_api.h is included. */
[#if NX_TCP_MAXIMUM_RETRIES_value == "10"]
/*
#define NX_TCP_MAXIMUM_RETRIES      			10
*/
[#else]
#define NX_TCP_MAXIMUM_RETRIES 	    			${NX_TCP_MAXIMUM_RETRIES_value}
[/#if]

/* Specifies the maximum depth of the TCP transmit queue before TCP send
   requests are suspended or rejected. The default value is 20, which means
   that a maximum of 20 packets can be in the transmit queue at any given time.
   Note packets stay in the transmit queue until an ACK that covers some or all
   of the packet data is received from the other side of the connection.
   This constant is defined in nx_tcp.h. The application can override the
   default by defining the value before nx_api.h is included. */
[#if NX_TCP_MAXIMUM_TX_QUEUE_value == "20"]
/*
#define NX_TCP_MAXIMUM_TX_QUEUE     			20
*/
[#else]
#define NX_TCP_MAXIMUM_TX_QUEUE 	    		${NX_TCP_MAXIMUM_TX_QUEUE_value}
[/#if]

/* Specifies how the retransmit timeout period changes between retries.
   If this value is 0, the initial retransmit timeout is the same as subsequent
   retransmit timeouts. If this value is 1, each successive retransmit is twice
   as long. If this value is 2, each subsequent retransmit timeout is four
   times as long. The default value is 0 and is defined in nx_tcp.h.
   The application can override the default by defining the value before nx_api.h
   is included. */
[#if NX_TCP_RETRY_SHIFT_value == "0x0"]
/*
#define NX_TCP_RETRY_SHIFT          			0x0
*/
[#else]
#define NX_TCP_RETRY_SHIFT		 	    		${NX_TCP_RETRY_SHIFT_value}
[/#if]

/* Specifies how many keepalive retries are allowed before the connection is
   deemed broken. The default value is 10, which represents 10 retries, and is
   defined in nx_tcp.h. The application can override the default by defining
   the value before nx_api.h is included. */
[#if NX_TCP_KEEPALIVE_RETRIES_value == "10"]
/*
#define NX_TCP_KEEPALIVE_RETRIES    			10
*/
[#else]
#define NX_TCP_KEEPALIVE_RETRIES		 	    ${NX_TCP_KEEPALIVE_RETRIES_value}
[/#if]

/* Enables the window scaling option for TCP applications. If defined, window
   scaling option is negotiated during TCP connection phase, and the
   application is able to specify a window size larger than 64K. The default
   setting is not enabled (not defined). */
[#if NX_ENABLE_TCP_WINDOW_SCALING_value == "true"]
#define NX_ENABLE_TCP_WINDOW_SCALING
[#else]
/*
#define NX_ENABLE_TCP_WINDOW_SCALING
*/
[/#if]

/* Defined, disables the reset processing during disconnect when the timeout
   value supplied is specified as NX_NO_WAIT. */
[#if NX_DISABLE_RESET_DISCONNECT_value == "true"]
#define NX_DISABLE_RESET_DISCONNECT
[#else]
/*
#define NX_DISABLE_RESET_DISCONNECT
*/
[/#if]

/* Defined, enables the verification of minimum peer MSS before accepting a TCP
   connection. To use this feature, the symbol NX_ENABLE_TCP_MSS_MINIMUM must
   be defined. By default, this option is not enabled. */
[#if NX_ENABLE_TCP_MSS_CHECK_value == "true"]
#define NX_ENABLE_TCP_MSS_CHECK
[#else]
/*
#define NX_ENABLE_TCP_MSS_CHECK
*/
[/#if]

[#if NX_ENABLE_TCP_MSS_CHECK_value == "true"]
/* Symbol that defines the minimal MSS value NetX Duo TCP module accepts.
   This feature is enabled by NX_ENABLE_TCP_MSS_CHECK. */
[#if NX_TCP_MSS_MINIMUM_value == "128"]
/*
#define NX_TCP_MSS_MINIMUM    					128
*/
[#else]
#define NX_TCP_MSS_MINIMUM		 	    		${NX_TCP_MSS_MINIMUM_value}
[/#if]
[/#if]

/* Defined, allows the application to install a callback function that is
   invoked when the TCP transmit queue depth is no longer at maximum value.
   This callback serves as an indication that the TCP socket is ready to
   transmit more data. By default this option is not enabled. */
[#if NX_ENABLE_TCP_QUEUE_DEPTH_UPDATE_NOTIFY_value == "true"]
#define NX_ENABLE_TCP_QUEUE_DEPTH_UPDATE_NOTIFY
[#else]
/*
#define NX_ENABLE_TCP_QUEUE_DEPTH_UPDATE_NOTIFY
*/
[/#if]

[#if NX_ENABLE_LOW_WATERMARK_value == "true"]
/* Symbol that defines the maximum receive queue for TCP sockets.
   This feature is enabled by NX_ENABLE_LOW_WATERMARK. */
[#if NX_TCP_MAXIMUM_RX_QUEUE_value == "20"]
/*
#define NX_TCP_MAXIMUM_RX_QUEUE    				20
*/
[#else]
#define NX_TCP_MAXIMUM_RX_QUEUE		 	     	${NX_TCP_MAXIMUM_RX_QUEUE_value}
[/#if]
[/#if]

/* Defined, disables checksum logic on received TCP packets. This is only
   useful in situations in which the link-layer has reliable checksum or CRC
   processing, or the interface driver is able to verify the TCP checksum in
   hardware, and the application does not use IPsec. */
[#if NX_DISABLE_TCP_RX_CHECKSUM_value == "true"]
#define NX_DISABLE_TCP_RX_CHECKSUM
[#else]
/*
#define NX_DISABLE_TCP_RX_CHECKSUM
*/
[/#if]

/* Defined, disables checksum logic for sending TCP packets. This is only
   useful in situations in which the receiving network node has received TCP
   checksum logic disabled or the underlying network driver is capable of
   generating the TCP checksum, and the application does not use IPsec. */
[#if NX_DISABLE_TCP_TX_CHECKSUM_value == "true"]
#define NX_DISABLE_TCP_TX_CHECKSUM
[#else]
/*
#define NX_DISABLE_TCP_TX_CHECKSUM
*/
[/#if]

/* Defined, disables TCP information gathering. */
[#if NX_DISABLE_TCP_INFO_value == "true"]
#define NX_DISABLE_TCP_INFO
[#else]
/*
#define NX_DISABLE_TCP_INFO
*/
[/#if]

/* Number of seconds for maximum segment lifetime, the default is 2 minutes
  (120s) */
[#if NX_TCP_MAXIMUM_SEGMENT_LIFETIME_value == "120"]
/*
#define NX_TCP_MAXIMUM_SEGMENT_LIFETIME    		120
*/
[#else]
#define NX_TCP_MAXIMUM_SEGMENT_LIFETIME		 	${NX_TCP_MAXIMUM_SEGMENT_LIFETIME_value}
[/#if]

/* Specifies the maximum number of server listen requests. The default value is
   10 and is defined in nx_api.h. The application can override the default by
   defining the value before nx_api.h is included. */
[#if NX_MAX_LISTEN_REQUESTS_value == "10"]
/*
#define NX_MAX_LISTEN_REQUESTS      			10
*/
[#else]
#define NX_MAX_LISTEN_REQUESTS		 			${NX_MAX_LISTEN_REQUESTS_value}
[/#if]

/*****************************************************************************/
/********************* Configuration options for UDP *************************/
/*****************************************************************************/

/* Defined, disables the UDP checksum computation on incoming UDP packets.
   This is useful if the network interface driver is able to verify UDP header
   checksum in hardware, and the application does not enable IPsec or IP
   fragmentation logic. */
[#if NX_DISABLE_UDP_RX_CHECKSUM_value == "true"]
#define NX_DISABLE_UDP_RX_CHECKSUM
[#else]
/*
#define NX_DISABLE_UDP_RX_CHECKSUM
*/
[/#if]

/* Defined, disables the UDP checksum computation on outgoing UDP packets.
   This is useful if the network interface driver is able to compute UDP header
   checksum and insert the value in the IP head before transmitting the data,
   and the application does not enable IPsec or IP fragmentation logic. */
[#if NX_DISABLE_UDP_TX_CHECKSUM_value == "true"]
#define NX_DISABLE_UDP_TX_CHECKSUM
[#else]
/*
#define NX_DISABLE_UDP_TX_CHECKSUM
*/
[/#if]

/* Defined, disables UDP information gathering. */
[#if NX_DISABLE_UDP_INFO_value == "true"]
#define NX_DISABLE_UDP_INFO
[#else]
/*
#define NX_DISABLE_UDP_INFO
*/
[/#if]

/*****************************************************************************/
/********************* Configuration options for IGMP ************************/
/*****************************************************************************/

/* Defined, disables IGMP information gathering. */
[#if NX_DISABLE_IGMP_INFO_value == "true"]
#define NX_DISABLE_IGMP_INFO
[#else]
/*
#define NX_DISABLE_IGMP_INFO
*/
[/#if]

/* Defined, disables IGMPv2 support, and NetX Duo supports IGMPv1 only.
   By default this option is not set and is defined in nx_api.h. */
[#if NX_DISABLE_IGMPV2_value == "true"]
#define NX_DISABLE_IGMPV2
[#else]
/*
#define NX_DISABLE_IGMPV2
*/
[/#if]

/* Specifies the maximum number of multicast groups that can be joined.
   The default value is 7 and is defined in nx_api.h. The application can
   override the default by defining the value before nx_api.h is included. */
[#if NX_MAX_MULTICAST_GROUPS_value == "7"]
/*
#define NX_MAX_MULTICAST_GROUPS     			7
*/
[#else]
#define NX_MAX_MULTICAST_GROUPS		 			${NX_MAX_MULTICAST_GROUPS_value}
[/#if]

/*****************************************************************************/
/******************* Configuration options for ARP/RARP **********************/
/*****************************************************************************/

/* Defined, allows NetX Duo to defend its IP address by sending an ARP
   response. */
[#if NX_ARP_DEFEND_BY_REPLY_value == "true"]
#define NX_ARP_DEFEND_BY_REPLY
[#else]
/*
#define NX_ARP_DEFEND_BY_REPLY
*/
[/#if]

/* Specifies the number of seconds ARP entries remain valid. The default value
   of zero disables expiration or aging of ARP entries and is defined in
   nx_api.h. The application can override the default by defining the value
   before nx_api.h is included. */
[#if NX_ARP_EXPIRATION_RATE_value == "0"]
/*
#define NX_ARP_EXPIRATION_RATE      			0
*/
[#else]
#define NX_ARP_EXPIRATION_RATE		 			${NX_ARP_EXPIRATION_RATE_value}
[/#if]

/* Specifies the number of seconds between ARP retries. The default value is 10,
   which represents 10 seconds, and is defined in nx_api.h. The application can
   override the default by defining the value before nx_api.h is included. */
[#if NX_ARP_UPDATE_RATE_value == "10"]
/*
#define NX_ARP_UPDATE_RATE          			10
*/
[#else]
#define NX_ARP_UPDATE_RATE		 				${NX_ARP_UPDATE_RATE_value}
[/#if]

/* Specifies the maximum number of ARP retries made without an ARP response.
   The default value is 18 and is defined in nx_api.h. The application can
   override the default by defining the value before nx_api.h is included. */
[#if NX_ARP_MAXIMUM_RETRIES_value == "18"]
/*
#define NX_ARP_MAXIMUM_RETRIES      			18
*/
[#else]
#define NX_ARP_MAXIMUM_RETRIES		 			${NX_ARP_MAXIMUM_RETRIES_value}
[/#if]

/* Specifies the maximum number of packets that can be queued while waiting for
   an ARP response. The default value is 4 and is defined in nx_api.h. */
[#if NX_ARP_MAX_QUEUE_DEPTH_value == "4"]
/*
#define NX_ARP_MAX_QUEUE_DEPTH      			4
*/
[#else]
#define NX_ARP_MAX_QUEUE_DEPTH		 			${NX_ARP_MAX_QUEUE_DEPTH_value}
[/#if]

/* Defines the interval, in seconds, the ARP module sends out the next defend
   packet in response to an incoming ARP message that indicates an address in
   conflict. */
[#if NX_ARP_DEFEND_INTERVAL_value == "10"]
/*
#define NX_ARP_DEFEND_INTERVAL  				10
*/
[#else]
#define NX_ARP_DEFEND_INTERVAL		 			${NX_ARP_DEFEND_INTERVAL_value}
[/#if]

/* Defined, disables entering ARP request information in the ARP cache. */
[#if NX_DISABLE_ARP_AUTO_ENTRY_value == "true"]
#define NX_DISABLE_ARP_AUTO_ENTRY
[#else]
/*
#define NX_DISABLE_ARP_AUTO_ENTRY
*/
[/#if]

/* Defined, allows ARP to invoke a callback notify function on detecting the
   MAC address is updated. */
[#if NX_ENABLE_ARP_MAC_CHANGE_NOTIFICATION_value == "true"]
#define NX_ENABLE_ARP_MAC_CHANGE_NOTIFICATION
[#else]
/*
#define NX_ENABLE_ARP_MAC_CHANGE_NOTIFICATION
*/
[/#if]

/* Defined, disables ARP information gathering. */
[#if NX_DISABLE_ARP_INFO_value == "true"]
#define NX_DISABLE_ARP_INFO
[#else]
/*
#define NX_DISABLE_ARP_INFO
*/
[/#if]

/* Defined, disables RARP information gathering. */
[#if NX_DISABLE_RARP_INFO_value == "true"]
#define NX_DISABLE_RARP_INFO
[#else]
/*
#define NX_DISABLE_RARP_INFO
*/
[/#if]

/*****************************************************************************/
/********************* Configuration options for DHCP ************************/
/*****************************************************************************/

/* Type of service required for the DHCP UDP requests. By default, this value
   is defined as NX_IP_NORMAL to indicate normal IP packet service. */
[#if NX_DHCP_TYPE_OF_SERVICE_value == "((ULONG)0x00000000)"]
/*
#define NX_DHCP_TYPE_OF_SERVICE                 NX_IP_NORMAL
*/
[#else]
#define NX_DHCP_TYPE_OF_SERVICE		 			${NX_DHCP_TYPE_OF_SERVICE_value}
[/#if]

/* Fragment enable for DHCP UDP requests. By default, this value is
   NX_DONT_FRAGMENT to disable DHCP UDP fragmenting. */
[#if NX_DHCP_FRAGMENT_OPTION_value == "((ULONG)0x00004000)"]
/*
#define NX_DHCP_FRAGMENT_OPTION                 NX_DONT_FRAGMENT
*/
[#else]
#define NX_DHCP_FRAGMENT_OPTION		 			${NX_DHCP_FRAGMENT_OPTION_value}
[/#if]

/* Specifies the number of routers this packet can pass before it is discarded.
   The default value is set to 0x80. */
[#if NX_DHCP_TIME_TO_LIVE_value == "128"]
/*
#define NX_DHCP_TIME_TO_LIVE                    0x80
*/
[#else]
#define NX_DHCP_TIME_TO_LIVE		 			${NX_DHCP_TIME_TO_LIVE_value}
[/#if]

/* Specifies the number of maximum depth of receive queue. The default value
   is set to 4. */
[#if NX_DHCP_QUEUE_DEPTH_value == "4"]
/*
#define NX_DHCP_QUEUE_DEPTH             		4
*/
[#else]
#define NX_DHCP_QUEUE_DEPTH		 				${NX_DHCP_QUEUE_DEPTH_value}
[/#if]

/*****************************************************************************/
/****************** Configuration options for DHCP Client ********************/
/*****************************************************************************/

/* Defined, this option enables the BOOTP protocol instead of DHCP.
   By default this option is disabled. */
[#if NX_DHCP_ENABLE_BOOTP_value == "true"]
#define NX_DHCP_ENABLE_BOOTP
[#else]
/*
#define NX_DHCP_ENABLE_BOOTP
*/
[/#if]

/* If defined, this enables the DHCP Client to save its current DHCP Client
   license ‘state’ including time remaining on the lease, and restore this
   state between DHCP Client application reboots.
   The default value is disabled. */
[#if NX_DHCP_CLIENT_RESTORE_STATE_value == "true"]
#define NX_DHCP_CLIENT_RESTORE_STATE
[#else]
/*
#define NX_DHCP_CLIENT_RESTORE_STATE
*/
[/#if]

/* If set, the DHCP Client will not create its own packet pool. The host
   application must use the nx_dhcp_packet_pool_set service to set the DHCP
   Client packet pool. The default value is disabled. */
[#if NX_DHCP_CLIENT_USER_CREATE_PACKET_POOL_value == "true"]
#define NX_DHCP_CLIENT_USER_CREATE_PACKET_POOL
[#else]
/*
#define NX_DHCP_CLIENT_USER_CREATE_PACKET_POOL
*/
[/#if]

/* Defined, this enables the DHCP Client to send an ARP probe after IP
   address assignment to verify the assigned DHCP address is not owned by
   another host. By default, this option is disabled. */
[#if NX_DHCP_CLIENT_SEND_ARP_PROBE_value == "true"]
#define NX_DHCP_CLIENT_SEND_ARP_PROBE
[#else]
/*
#define NX_DHCP_CLIENT_SEND_ARP_PROBE
*/
[/#if]

/* Defines the length of time the DHCP Client waits for a response after
   sending an ARP probe. The default value is one second
   (1 * NX_IP_PERIODIC_RATE). */
[#if NX_DHCP_ARP_PROBE_WAIT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_ARP_PROBE_WAIT  				(1 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_ARP_PROBE_WAIT		 			${NX_DHCP_ARP_PROBE_WAIT_value}
[/#if]

/* Defines the minimum variation in the interval between sending ARP probes.
   The value is defaulted to 1 second. */
[#if NX_DHCP_ARP_PROBE_MIN_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_ARP_PROBE_MIN           		(1 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_ARP_PROBE_MIN		 			${NX_DHCP_ARP_PROBE_MIN_value}
[/#if]

/* Defines the maximum variation in the interval between sending ARP probes.
   The value is defaulted to 2 seconds. */
[#if NX_DHCP_ARP_PROBE_MAX_value == "200" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_ARP_PROBE_MAX           		(2 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_ARP_PROBE_MAX		 			${NX_DHCP_ARP_PROBE_MAX_value}
[/#if]

/* Defines the number of ARP probes sent for determining if the IP address
   assigned by the DHCP server is already in use. The value is defaulted to
   3 probes. */
[#if NX_DHCP_ARP_PROBE_NUM_value == "3"]
/*
#define NX_DHCP_ARP_PROBE_NUM           		3
*/
[#else]
#define NX_DHCP_ARP_PROBE_NUM		 			${NX_DHCP_ARP_PROBE_NUM_value}
[/#if]

/* Defines the length of time the DHCP Client waits to restart DHCP if the IP
   address assigned to the DHCP Client is already in use. The value is defaulted
   to 10 seconds. */
[#if NX_DHCP_RESTART_WAIT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_RESTART_WAIT            		(10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_RESTART_WAIT		 			${NX_DHCP_RESTART_WAIT_value}
[/#if]

/* Specifies the maximum number of interface records to save to the DHCP Client
   instance. A DHCP Client interface record is a record of the DHCP Client
   running on a specific interface. The default value is set as physical
   interfaces count (NX_MAX_PHYSICAL_INTERFACES). */
[#if NX_DHCP_CLIENT_MAX_RECORDS_value == "1" && NX_MAX_PHYSICAL_INTERFACES_value == "1"]
/*
#define NX_DHCP_CLIENT_MAX_RECORDS      		(NX_MAX_PHYSICAL_INTERFACES)
*/
[#else]
#define NX_DHCP_CLIENT_MAX_RECORDS		 		${NX_DHCP_CLIENT_MAX_RECORDS_value}
[/#if]

/* Defined, this enables the DHCP Client to send maximum DHCP message size
   option. By default, this option is disabled. */
[#if NX_DHCP_CLIENT_SEND_MAX_DHCP_MESSAGE_OPTION_value == "true"]
#define NX_DHCP_CLIENT_SEND_MAX_DHCP_MESSAGE_OPTION
[#else]
/*
#define NX_DHCP_CLIENT_SEND_MAX_DHCP_MESSAGE_OPTION
*/
[/#if]

/* Defined, this enables the DHCP Client to check the input host name in the
   nx_dhcp_create call for invalid characters or length. By default, this
   option is disabled. */
[#if NX_DHCP_CLIENT_ENABLE_HOST_NAME_CHECK_value == "true"]
#define NX_DHCP_CLIENT_ENABLE_HOST_NAME_CHECK
[#else]
/*
#define NX_DHCP_CLIENT_ENABLE_HOST_NAME_CHECK
*/
[/#if]

/* Priority of the DHCP thread. By default, this value specifies that the DHCP
   thread runs at priority 3. */
[#if NX_DHCP_THREAD_PRIORITY_value == "3"]
/*
#define NX_DHCP_THREAD_PRIORITY         		3
*/
[#else]
#define NX_DHCP_THREAD_PRIORITY			 		${NX_DHCP_THREAD_PRIORITY_value}
[/#if]

/* Size of the DHCP thread stack. By default, the size is 4096 bytes. */
[#if NX_DHCP_THREAD_STACK_SIZE_value == "4096"]
/*
#define NX_DHCP_THREAD_STACK_SIZE       		(4096)
*/
[#else]
#define NX_DHCP_THREAD_STACK_SIZE		 		${NX_DHCP_THREAD_STACK_SIZE_value}
[/#if]

/* Interval in seconds when the DHCP Client timer expiration function executes.
   This function updates all the timeouts in the DHCP process e.g. if messages
   should be retransmitted or DHCP Client state changed. By default, this
   value is 1 second. */
[#if NX_DHCP_TIME_INTERVAL_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_TIME_INTERVAL          			(1 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_TIME_INTERVAL		 			${NX_DHCP_TIME_INTERVAL_value}
[/#if]

/* Size of DHCP options buffer. By default, this value is 312 bytes. */
[#if NX_DHCP_OPTIONS_BUFFER_SIZE_value == "312"]
/*
#define NX_DHCP_OPTIONS_BUFFER_SIZE     		312
*/
[#else]
#define NX_DHCP_OPTIONS_BUFFER_SIZE		 		${NX_DHCP_OPTIONS_BUFFER_SIZE_value}
[/#if]

/* Specifies the size in bytes of the DHCP Client packet payload.
   The default value is NX_DHCP_MINIMUM_IP_DATAGRAM + physical header size.
   The physical header size in a wireline network is usually the Ethernet frame
   size. */
[#if NX_DHCP_PACKET_PAYLOAD_value == "592"]
/*
#define NX_DHCP_PACKET_PAYLOAD          		(NX_DHCP_MINIMUM_IP_DATAGRAM + NX_PHYSICAL_HEADER)
*/
[#else]
#define NX_DHCP_PACKET_PAYLOAD		 			${NX_DHCP_PACKET_PAYLOAD_value}
[/#if]

/* Specifies the size of the DHCP Client packet pool. The default value is
  (5 *NX_DHCP_PACKET_PAYLOAD) which will provide four packets plus room for
  internal packet pool overhead. */
[#if NX_DHCP_PACKET_POOL_SIZE_value == "2960" && NX_DHCP_PACKET_PAYLOAD_value == "592"]
/*
#define NX_DHCP_PACKET_POOL_SIZE        		(5 * NX_DHCP_PACKET_PAYLOAD)
*/
[#else]
#define NX_DHCP_PACKET_POOL_SIZE		 		${NX_DHCP_PACKET_POOL_SIZE_value}
[/#if]

/* Specifies the minimum wait option for receiving a DHCP Server reply to
   client message before retransmitting the message. The default value is the
   RFC 2131 recommended 4 seconds. */
[#if NX_DHCP_MIN_RETRANS_TIMEOUT_value == "400" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_MIN_RETRANS_TIMEOUT     		(4 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_MIN_RETRANS_TIMEOUT		 		${NX_DHCP_MIN_RETRANS_TIMEOUT_value}
[/#if]

/* Specifies the maximum wait option for receiving a DHCP Server reply to
   client message before retransmitting the message. The default value is
   64 seconds. */
[#if NX_DHCP_MAX_RETRANS_TIMEOUT_value == "6400" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_MAX_RETRANS_TIMEOUT     		(64 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_MAX_RETRANS_TIMEOUT		 		${NX_DHCP_MAX_RETRANS_TIMEOUT_value}
[/#if]

/* Specifies minimum wait option for receiving a DHCP Server message and sending
   a renewal request after the DHCP Client is bound to an IP address.
   The default value is 60 seconds. However, the DHCP Client uses the Renew and
   Rebind expiration times from the DHCP server message before defaulting to the
   minimum renew timeout. */
[#if NX_DHCP_MIN_RENEW_TIMEOUT_value == "6000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_MIN_RENEW_TIMEOUT      			(60 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCP_MIN_RENEW_TIMEOUT		 		${NX_DHCP_MIN_RENEW_TIMEOUT_value}
[/#if]

/*****************************************************************************/
/****************** Configuration options for DHCP Server ********************/
/*****************************************************************************/

/* This option specifies the priority of the DHCP Server thread. By default,
   this value specifies that the DHCP thread runs at priority 2. */
[#if NX_DHCP_SERVER_THREAD_PRIORITY_value == "2"]
/*
#define NX_DHCP_SERVER_THREAD_PRIORITY          2
*/
[#else]
#define NX_DHCP_SERVER_THREAD_PRIORITY			${NX_DHCP_SERVER_THREAD_PRIORITY_value}
[/#if]

/* Specifies the timeout in timer ticks for the NetX DHCP Server to wait for
   allocate a packet from its packet pool. The default value is set to
   NX_IP_PERIODIC_RATE. */
[#if NX_DHCP_PACKET_ALLOCATE_TIMEOUT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCP_PACKET_ALLOCATE_TIMEOUT         NX_IP_PERIODIC_RATE
*/
[#else]
#define NX_DHCP_PACKET_ALLOCATE_TIMEOUT			${NX_DHCP_PACKET_ALLOCATE_TIMEOUT_value}
[/#if]

/* This is the subnet mask the DHCP Client should be configured with.
   The default value is set to 0xFFFFFF00. */
[#if NX_DHCP_SUBNET_MASK_value == "0xFFFFFF00"]
/*
#define NX_DHCP_SUBNET_MASK                     0xFFFFFF00UL
*/
[#else]
#define NX_DHCP_SUBNET_MASK						${NX_DHCP_SUBNET_MASK_value}
[/#if]

/* This is timeout period in timer ticks for the DHCP Server fast timer to check
   on session time remaining and handle sessions that have timed out. */
[#if NX_DHCP_FAST_PERIODIC_TIME_INTERVAL_value == "10"]
/*
#define NX_DHCP_FAST_PERIODIC_TIME_INTERVAL     10
*/
[#else]
#define NX_DHCP_FAST_PERIODIC_TIME_INTERVAL		${NX_DHCP_FAST_PERIODIC_TIME_INTERVAL_value}
[/#if]

/* This is timeout period in timer ticks for the DHCP Server slow timer to
   check on IP address lease time remaining and handle lease that have
   timed out. */
[#if NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL_value == "1000"]
/*
#define NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL		1000
*/
[#else]
#define NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL		${NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL_value}
[/#if]

/* This is IP Address lease time in seconds assigned to the DHCP Client, and
   the basis for computing the renewal and rebind times also assigned to the
   Client.
   The default value is set to (10 * NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL). */
[#if NX_DHCP_DEFAULT_LEASE_TIME_value == "10000" && NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL_value == "1000"]
/*
#define  NX_DHCP_DEFAULT_LEASE_TIME             (10 * NX_DHCP_SLOW_PERIODIC_TIME_INTERVAL)
*/
[#else]
#define NX_DHCP_DEFAULT_LEASE_TIME				${NX_DHCP_DEFAULT_LEASE_TIME_value}
[/#if]

/* This is size of the DHCP Server array for holding available IP addresses for
   assigning to the Client. The default value is 20. */
[#if NX_DHCP_IP_ADDRESS_MAX_LIST_SIZE_value == "20"]
/*
#define NX_DHCP_IP_ADDRESS_MAX_LIST_SIZE        20
*/
[#else]
#define NX_DHCP_IP_ADDRESS_MAX_LIST_SIZE		${NX_DHCP_IP_ADDRESS_MAX_LIST_SIZE_value}
[/#if]

/* This is size of the DHCP Server array for holding Client records.
   The default value is 50. */
[#if NX_DHCP_CLIENT_RECORD_TABLE_SIZE_value == "50"]
/*
#define NX_DHCP_CLIENT_RECORD_TABLE_SIZE      	50
*/
[#else]
#define NX_DHCP_CLIENT_RECORD_TABLE_SIZE		${NX_DHCP_CLIENT_RECORD_TABLE_SIZE_value}
[/#if]

/* This is size of the array in the DHCP Client instance for holding the all
   the requested options in the parameter request list in the current session.
   The default value is 12. */
[#if NX_DHCP_CLIENT_OPTIONS_MAX_value == "12"]
/*
#define NX_DHCP_CLIENT_OPTIONS_MAX             	12
*/
[#else]
#define NX_DHCP_CLIENT_OPTIONS_MAX				${NX_DHCP_CLIENT_OPTIONS_MAX_value}
[/#if]

/* This is size of the buffer for holding the Server host name.
   The default value is 32. */
[#if NX_DHCP_SERVER_HOSTNAME_MAX_value == "32"]
/*
#define NX_DHCP_SERVER_HOSTNAME_MAX             32
*/
[#else]
#define NX_DHCP_SERVER_HOSTNAME_MAX				${NX_DHCP_SERVER_HOSTNAME_MAX_value}
[/#if]

/* This is size of the buffer for holding the Client host name in the current
   DHCP Server Client session. The default value is 32. */
[#if NX_DHCP_CLIENT_HOSTNAME_MAX_value == "32"]
/*
#define NX_DHCP_CLIENT_HOSTNAME_MAX             32
*/
[#else]
#define NX_DHCP_CLIENT_HOSTNAME_MAX				${NX_DHCP_CLIENT_HOSTNAME_MAX_value}
[/#if]

/*****************************************************************************/
/****************** Configuration options for DHCP IPV6 **********************/
/*****************************************************************************/

/* Time interval in seconds at which the session timer updates the length of
   time the Client has been in session communicating with the Server.
   By default, this value is 1. */
[#if NX_DHCPV6_SESSION_TIMER_INTERVAL_value == "1"]
/*
#define NX_DHCPV6_SESSION_TIMER_INTERVAL        1
*/
[#else]
#define NX_DHCPV6_SESSION_TIMER_INTERVAL 		${NX_DHCPV6_SESSION_TIMER_INTERVAL_value}
[/#if]

/* Time out in seconds for allocating a packet from the Client packet pool.
   The default value is 3 seconds. */
[#if NX_DHCPV6_PACKET_TIME_OUT_value == "300"]
/*
#define NX_DHCPV6_PACKET_TIME_OUT               (3 * NX_DHCPV6_TICKS_PER_SECOND)
*/
[#else]
#define NX_DHCPV6_PACKET_TIME_OUT				${NX_DHCPV6_PACKET_TIME_OUT_value}
[/#if]

/* This defines the type of service for UDP packet transmission from the DHCPv6
   Client socket. The default value is NX_IP_NORMAL. */
[#if NX_DHCPV6_TYPE_OF_SERVICE_value == "((ULONG)0x00000000)"]
/*
#define NX_DHCPV6_TYPE_OF_SERVICE               NX_IP_NORMAL
*/
[#else]
#define NX_DHCPV6_TYPE_OF_SERVICE				${NX_DHCPV6_TYPE_OF_SERVICE_value}
[/#if]

/* The number of times a Client packet is forwarded by a network router before
   the packet is discarded. The default value is 0x80. */
[#if NX_DHCPV6_TIME_TO_LIVE_value == "128"]
/*
#define NX_DHCPV6_TIME_TO_LIVE                  0x80
*/
[#else]
#define NX_DHCPV6_TIME_TO_LIVE 					${NX_DHCPV6_TIME_TO_LIVE_value}
[/#if]

/* Specifies the number of packets to keep in the Client UDP socket receive
   queue before NetX Duo discards packets. The default value is 5. */
[#if NX_DHCPV6_QUEUE_DEPTH_value == "5"]
/*
#define NX_DHCPV6_QUEUE_DEPTH                   5
*/
[#else]
#define NX_DHCPV6_QUEUE_DEPTH 					${NX_DHCPV6_QUEUE_DEPTH_value}
[/#if]

/*****************************************************************************/
/*************** Configuration options for DHCP Client IPV6 ******************/
/*****************************************************************************/

/* Priority of the Client thread. By default, this value specifies that the
   Client thread runs at priority 2. */
[#if NX_DHCPV6_THREAD_PRIORITY_value == "2"]
/*
#define NX_DHCPV6_THREAD_PRIORITY               2
*/
[#else]
#define NX_DHCPV6_THREAD_PRIORITY		 		${NX_DHCPV6_THREAD_PRIORITY_value}
[/#if]

/* Time out option for obtaining an exclusive lock on a DHCPv6 Client mutex.
   The default value is TX_WAIT_FOREVER. */
[#if NX_DHCPV6_MUTEX_WAIT_value == "0xFFFFFFFF"]
/*
#define NX_DHCPV6_MUTEX_WAIT                    TX_WAIT_FOREVER
*/
[#else]
#define NX_DHCPV6_MUTEX_WAIT		 			${NX_DHCPV6_MUTEX_WAIT_value}
[/#if]

/* Ratio of ticks to seconds. This is processor dependent.
   The default value is 100. */
[#if NX_DHCPV6_TICKS_PER_SECOND_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCPV6_TICKS_PER_SECOND              (NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DHCPV6_TICKS_PER_SECOND	 			${NX_DHCPV6_TICKS_PER_SECOND_value}
[/#if]

/* Time interval in seconds at which the IP lifetime timer updates the length
   of time the current IP address has been assigned to the Client.
   By default, this value is 1. */
[#if NX_DHCPV6_IP_LIFETIME_TIMER_INTERVAL_value == "1"]
/*
#define NX_DHCPV6_IP_LIFETIME_TIMER_INTERVAL    1
*/
[#else]
#define NX_DHCPV6_IP_LIFETIME_TIMER_INTERVAL	${NX_DHCPV6_IP_LIFETIME_TIMER_INTERVAL_value}
[/#if]

/* The maximum number of IA addresses that can be added to the Client record.
   The default value is 1. */
[#if NX_DHCPV6_MAX_IA_ADDRESS_value == "1"]
/*
#define NX_DHCPV6_MAX_IA_ADDRESS                1
*/
[#else]
#define NX_DHCPV6_MAX_IA_ADDRESS				${NX_DHCPV6_MAX_IA_ADDRESS_value}
[/#if]

/* Number of DNS servers to store to the client record.
   The default value is 2. */
[#if NX_DHCPV6_NUM_DNS_SERVERS_value == "2"]
/*
#define NX_DHCPV6_NUM_DNS_SERVERS               2
*/
[#else]
#define NX_DHCPV6_NUM_DNS_SERVERS				${NX_DHCPV6_NUM_DNS_SERVERS_value}
[/#if]

/* Number of time servers to store to the client record.
   The default value is 1. */
[#if NX_DHCPV6_NUM_TIME_SERVERS_value == "1"]
/*
#define NX_DHCPV6_NUM_TIME_SERVERS              1
*/
[#else]
#define NX_DHCPV6_NUM_TIME_SERVERS				${NX_DHCPV6_NUM_TIME_SERVERS_value}
[/#if]

/* Size of the buffer in the Client record to hold the client’s network domain
   name. The default value is 32. */
[#if NX_DHCPV6_DOMAIN_NAME_BUFFER_SIZE_value == "32"]
/*
#define NX_DHCPV6_DOMAIN_NAME_BUFFER_SIZE       32
*/
[#else]
#define NX_DHCPV6_DOMAIN_NAME_BUFFER_SIZE		${NX_DHCPV6_DOMAIN_NAME_BUFFER_SIZE_value}
[/#if]

/* Size of the buffer in the Client record to hold the Client’s time zone.
   The default value is 16. */
[#if NX_DHCPV6_TIME_ZONE_BUFFER_SIZE_value == "16"]
/*
#define NX_DHCPV6_TIME_ZONE_BUFFER_SIZE         16
*/
[#else]
#define NX_DHCPV6_TIME_ZONE_BUFFER_SIZE			${NX_DHCPV6_TIME_ZONE_BUFFER_SIZE_value}
[/#if]

/* Size of the buffer in the Client record to hold the option status message
   in a Server reply. The default value is 100 bytes. */
[#if NX_DHCPV6_MAX_MESSAGE_SIZE_value == "100"]
/*
#define NX_DHCPV6_MAX_MESSAGE_SIZE              100
*/
[#else]
#define NX_DHCPV6_MAX_MESSAGE_SIZE				${NX_DHCPV6_MAX_MESSAGE_SIZE_value}
[/#if]

/*****************************************************************************/
/*************** Configuration options for DHCP Server IPV6 ******************/
/*****************************************************************************/

/* This defines the size of the DHCPv6 thread stack. By default, the size is
   4096 bytes which is more than enough for most NetX Duo applications. */
[#if NX_DHCPV6_SERVER_THREAD_STACK_SIZE_value == "4096"]
/*
#define NX_DHCPV6_SERVER_THREAD_STACK_SIZE      4096
*/
[#else]
#define NX_DHCPV6_SERVER_THREAD_STACK_SIZE		${NX_DHCPV6_SERVER_THREAD_STACK_SIZE_value}
[/#if]

/* This defines the DHCPv6 Server thread priority. This should be lower than the
   DHCPv6 Server’s IP thread task priority. The default value is 2. */
[#if NX_DHCPV6_SERVER_THREAD_PRIORITY_value == "2"]
/*
#define NX_DHCPV6_SERVER_THREAD_PRIORITY        2
*/
[#else]
#define NX_DHCPV6_SERVER_THREAD_PRIORITY		${NX_DHCPV6_SERVER_THREAD_PRIORITY_value}
[/#if]

/* Timer interval in seconds when the lease timer entry function is called by
   the ThreadX scheduler. The entry function sets a flag for the DHCPv6 Server
   to increment all Clients’ accrued time on their lease by the timer interval.
   By default, this value is 60. */
[#if NX_DHCPV6_IP_LEASE_TIMER_INTERVAL_value == "60"]
/*
#define NX_DHCPV6_IP_LEASE_TIMER_INTERVAL       (60)
*/
[#else]
#define NX_DHCPV6_IP_LEASE_TIMER_INTERVAL		${NX_DHCPV6_IP_LEASE_TIMER_INTERVAL_value}
[/#if]

/* Create a Server DUID with a vendor assigned ID. Note the DUID type must be
   set NX_DHCPV6_DUID_TYPE_VENDOR_ASSIGNED. */
[#if NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_ID_value == "abcdeffghijklmnopqrstuvwxyz"]
/*
#define NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_ID    "abcdeffghijklmnopqrstuvwxyz"
*/
[#else]
#define NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_ID	"${NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_ID_value}"
[/#if]

/* Sets the upper limit on the Vendor assigned ID. The default value is 48. */
[#if NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_LENGTH_value == "48"]
/*
#define NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_LENGTH    48
*/
[#else]
#define NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_LENGTH	${NX_DHCPV6_SERVER_DUID_VENDOR_ASSIGNED_LENGTH_value}
[/#if]

/* Sets the enterprise type of the DUID to private vendor type. */
[#if NX_DHCPV6_SERVER_DUID_VENDOR_PRIVATE_ID_value == "0x12345678"]
/*
#define NX_DHCPV6_SERVER_DUID_VENDOR_PRIVATE_ID     0x12345678
*/
[#else]
#define NX_DHCPV6_SERVER_DUID_VENDOR_PRIVATE_ID 	${NX_DHCPV6_SERVER_DUID_VENDOR_PRIVATE_ID_value}
[/#if]

/* This defines the wait option for the Server nx_udp_socket_receive call.
   This is perfunctory since the socket has a receive notify callback from
   NetX Duo, so the packet is already enqueued when the DHCPv6 server calls
   the receive function.
   The default value is 1 second (1 * NX_IP_PERIODIC_RATE). */
[#if NX_DHCPV6_PACKET_WAIT_OPTION_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DHCPV6_PACKET_WAIT_OPTION            NX_IP_PERIODIC_RATE
*/
[#else]
#define NX_DHCPV6_PACKET_WAIT_OPTION 			${NX_DHCPV6_PACKET_WAIT_OPTION_value}
[/#if]

/* This defines the Server DUID type which the Server includes in all messages
   to Clients. The default value is link layer plus time
   (NX_DHCPV6_SERVER_DUID_TYPE_LINK_TIME). */
[#if NX_DHCPV6_SERVER_DUID_TYPE_value == "1"]
/*
#define NX_DHCPV6_SERVER_DUID_TYPE            	NX_DHCPV6_DUID_TYPE_LINK_TIME
*/
[#else]
#define NX_DHCPV6_SERVER_DUID_TYPE 				${NX_DHCPV6_SERVER_DUID_TYPE_value}
[/#if]

/* This defines the preference option value between 0 and 255, where the higher
   the value the higher the preference, in the DHCPv6 option of the same name.
   This tells the Client what preference to place on this Server’s offer where
   multiple DHCPv6 Servers are available to assign IP addresses.
   A value of 255 instructs the Client to choose this server. A value of zero
   indicates the Client is free to choose. The default value is zero. */
[#if NX_DHCPV6_PREFERENCE_VALUE_value == "0"]
/*
#define NX_DHCPV6_PREFERENCE_VALUE              0
*/
[#else]
#define NX_DHCPV6_PREFERENCE_VALUE 				${NX_DHCPV6_PREFERENCE_VALUE_value}
[/#if]

/* This defines the maximum number of option requests in a Client request that
   can be saved to a Client record. The default value is 6. */
[#if NX_DHCPV6_MAX_OPTION_REQUEST_OPTIONS_value == "6"]
/*
#define NX_DHCPV6_MAX_OPTION_REQUEST_OPTIONS    6
*/
[#else]
#define NX_DHCPV6_MAX_OPTION_REQUEST_OPTIONS	${NX_DHCPV6_MAX_OPTION_REQUEST_OPTIONS_value}
[/#if]

/* The time in seconds assigned by the Server on a Client address lease for
   when the Client should begin renewing its IP address. The default value is
   2000 seconds. */
[#if NX_DHCPV6_DEFAULT_T1_TIME_value == "2000"]
/*
#define  NX_DHCPV6_DEFAULT_T1_TIME              (2000)
*/
[#else]
#define NX_DHCPV6_DEFAULT_T1_TIME				${NX_DHCPV6_DEFAULT_T1_TIME_value}
[/#if]

/* The time in seconds assigned by the Server on a Client address lease for
   when the Client should begin rebinding its IP address assuming its attempt
   to renew failed. The default value is 3000 seconds. */
[#if NX_DHCPV6_DEFAULT_T2_TIME_value == "3000"]
/*
#define  NX_DHCPV6_DEFAULT_T2_TIME              (3000)
*/
[#else]
#define NX_DHCPV6_DEFAULT_T2_TIME				${NX_DHCPV6_DEFAULT_T2_TIME_value}
[/#if]

/* This defines the time in seconds assigned bythe Server for when an assigned
   Client IP address lease is deprecated.
   The default value is 2 NX_DHCPV6_DEFAULT_T1_TIME. */
[#if NX_DHCPV6_DEFAULT_PREFERRED_TIME_value == "4000"]
/*
#define  NX_DHCPV6_DEFAULT_PREFERRED_TIME       (2 * NX_DHCPV6_DEFAULT_T1_TIME)
*/
[#else]
#define NX_DHCPV6_DEFAULT_PREFERRED_TIME		${NX_DHCPV6_DEFAULT_PREFERRED_TIME_value}
[/#if]

/* This defines the time expiration in seconds assigned by the Server on an
   assigned Client IP address lease. After this time expires, the Client IP
   address is invalid.
   The default value is 2 NX_DHCPV6_DEFAULT_PREFERRED_TIME. */
[#if NX_DHCPV6_DEFAULT_VALID_TIME_value == "8000"]
/*
#define NX_DHCPV6_DEFAULT_VALID_TIME      		(2 * NX_DHCPV6_DEFAULT_PREFERRED_TIME)
*/
[#else]
#define NX_DHCPV6_DEFAULT_VALID_TIME			${NX_DHCPV6_DEFAULT_VALID_TIME_value}
[/#if]

/* Defines the maximum size of the Server message in status option message field.
   The default value is 100 bytes. */
[#if NX_DHCPV6_STATUS_MESSAGE_MAX_value == "100"]
/*
#define NX_DHCPV6_STATUS_MESSAGE_MAX           	100
*/
[#else]
#define NX_DHCPV6_STATUS_MESSAGE_MAX			${NX_DHCPV6_STATUS_MESSAGE_MAX_value}
[/#if]

/* Defines the size of the Server’s IP lease table (e.g. the max number of IPv6
   address available to lease that can be stored).
   By default, this value is 100. */
[#if NX_DHCPV6_MAX_LEASES_value == "100"]
/*
#define NX_DHCPV6_MAX_LEASES                   	100
*/
[#else]
#define NX_DHCPV6_MAX_LEASES					${NX_DHCPV6_MAX_LEASES_value}
[/#if]

/* Defines the size of the Server’s Client record table (e.g. max number of
   Clients that can be stored). This value should be less than or equal to the
   value NX_DHCPV6_MAX_LEASES.By default, this value is 120. */
[#if NX_DHCPV6_MAX_CLIENTS_value == "120"]
/*
#define NX_DHCPV6_MAX_CLIENTS                   120
*/
[#else]
#define NX_DHCPV6_MAX_CLIENTS					${NX_DHCPV6_MAX_CLIENTS_value}
[/#if]

/* This defines the packet payload of the Server packet pool packets.
   The default value is 500 bytes. */
[#if NX_DHCPV6_PACKET_SIZE_value == "500"]
/*
#define NX_DHCPV6_PACKET_SIZE                   500
*/
[#else]
#define NX_DHCPV6_PACKET_SIZE					${NX_DHCPV6_PACKET_SIZE_value}
[/#if]

/* Defines the Server packet pool size for packets the Server will allocate to
   send DHCPv6 messages out.
   The default value is (10 * NX_DHCPV6_PACKET_SIZE) */
[#if NX_DHCPV6_PACKET_POOL_SIZE_value == "5000"]
/*
#define NX_DHCPV6_PACKET_POOL_SIZE              (10 * NX_DHCPV6_PACKET_SIZE)
*/
[#else]
#define NX_DHCPV6_PACKET_POOL_SIZE				${NX_DHCPV6_PACKET_POOL_SIZE_value}
[/#if]

/* This defines the Server socket fragmentation option.
   The default value is NX_DONT_FRAGMENT. */
[#if NX_DHCPV6_FRAGMENT_OPTION_value == "((ULONG)0x00004000)"]
/*
#define NX_DHCPV6_FRAGMENT_OPTION               NX_DONT_FRAGMENT
*/
[#else]
#define NX_DHCPV6_FRAGMENT_OPTION				${NX_DHCPV6_FRAGMENT_OPTION_value}
[/#if]

/* Define the session time out in seconds. This is the timer for how long the
   server has not received a client response.
   The default value is set to 20. */
[#if NX_DHCPV6_SESSION_TIMEOUT_value == "20"]
/*
#define NX_DHCPV6_SESSION_TIMEOUT               (20)
*/
[#else]
#define NX_DHCPV6_SESSION_TIMEOUT				${NX_DHCPV6_SESSION_TIMEOUT_value}
[/#if]

/* This defines the status option message for : NX_DHCPV6_STATUS_MESSAGE_SUCCESS.
   The default value is "IA OPTION GRANTED". */
[#if NX_DHCPV6_STATUS_MESSAGE_SUCCESS_value == "IA OPTION GRANTED"]
/*
#define NX_DHCPV6_STATUS_MESSAGE_SUCCESS        "IA OPTION GRANTED"
*/
[#else]
#define NX_DHCPV6_STATUS_MESSAGE_SUCCESS		"${NX_DHCPV6_STATUS_MESSAGE_SUCCESS_value}"
[/#if]

/* This defines the status option message for : NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE.
   The default value is "IA OPTION NOT GRANTED-NO ADDRESSES AVAILABLE". */
[#if NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE_value == "IA OPTION NOT GRANTED-NO ADDRESSES AVAILABLE"]
/*
#define NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE     "IA OPTION NOT GRANTED-NO ADDRESSES AVAILABLE"
*/
[#else]
#define NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE		"${NX_DHCPV6_STATUS_MESSAGE_NO_ADDRS_AVAILABLE_value}"
[/#if]

/* This defines the status option message for : NX_DHCPV6_STATUS_MESSAGE_NO_BINDING.
   The default value is "IA OPTION NOT GRANTED-INVALID CLIENT REQUEST". */
[#if NX_DHCPV6_STATUS_MESSAGE_NO_BINDING_value == "IA OPTION NOT GRANTED-INVALID CLIENT REQUEST"]
/*
#define NX_DHCPV6_STATUS_MESSAGE_NO_BINDING             "IA OPTION NOT GRANTED-INVALID CLIENT REQUEST"
*/
[#else]
#define NX_DHCPV6_STATUS_MESSAGE_NO_BINDING				"${NX_DHCPV6_STATUS_MESSAGE_NO_BINDING_value}"
[/#if]

/* This defines the status option message for : NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK.
   The default value is "IA OPTION NOT GRANTED-INVALID CLIENT REQUEST". */
[#if NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK_value == "IA OPTION NOT GRANTED-CLIENT NOT ON LINK"]
/*
#define NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK            "IA OPTION NOT GRANTED-CLIENT NOT ON LINK"
*/
[#else]
#define NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK			"${NX_DHCPV6_STATUS_MESSAGE_NOT_ON_LINK_value}"
[/#if]

/* This defines the status option message for : NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST.
   The default value is "IA OPTION NOT GRANTED-CLIENT MUST USE MULTICAST". */
[#if NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST_value == "IA OPTION NOT GRANTED-CLIENT MUST USE MULTICAST"]
/*
#define NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST          "IA OPTION NOT GRANTED-CLIENT MUST USE MULTICAST"
*/
[#else]
#define NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST			"${NX_DHCPV6_STATUS_MESSAGE_USE_MULTICAST_value}"
[/#if]

/*****************************************************************************/
/********************* Configuration options for DNS *************************/
/*****************************************************************************/

/* Type of service required for the DNS UDP requests. By default, this value
   is defined as NX_IP_NORMAL for normal IP packet service. */
[#if NX_DNS_TYPE_OF_SERVICE_value == "((ULONG)0x00000000)"]
/*
#define NX_DNS_TYPE_OF_SERVICE          		NX_IP_NORMAL
*/
[#else]
#define NX_DNS_TYPE_OF_SERVICE					${NX_DNS_TYPE_OF_SERVICE_value}
[/#if]

/* Specifies the maximum number of routers a packet can pass before it is
   discarded. The default value is 0x80. */
[#if NX_DNS_TIME_TO_LIVE_value == "0x80"]
/*
#define NX_DNS_TIME_TO_LIVE                     0x80
*/
[#else]
#define NX_DNS_TIME_TO_LIVE						${NX_DNS_TIME_TO_LIVE_value}
[/#if]

/* Sets the socket property to allow or disallow fragmentation of outgoing
   packets. The default value is NX_DONT_FRAGMENT. */
[#if NX_DNS_FRAGMENT_OPTION_value == "((ULONG)0x00004000)"]
/*
#define NX_DNS_FRAGMENT_OPTION          		NX_DONT_FRAGMENT
*/
[#else]
#define NX_DNS_FRAGMENT_OPTION					${NX_DNS_FRAGMENT_OPTION_value}
[/#if]

/* Sets the maximum number of packets to store on the socket receive queue.
   The default value is 5. */
[#if NX_DNS_QUEUE_DEPTH_value == "5"]
/*
#define NX_DNS_QUEUE_DEPTH                      5
*/
[#else]
#define NX_DNS_QUEUE_DEPTH						${NX_DNS_QUEUE_DEPTH_value}
[/#if]

/* Specifies the maximum number of DNS Servers in the Client server list.
   The default value is 5. */
[#if NX_DNS_MAX_SERVERS_value == "5"]
/*
#define NX_DNS_MAX_SERVERS                      5
*/
[#else]
#define NX_DNS_MAX_SERVERS						${NX_DNS_MAX_SERVERS_value}
[/#if]

/* Specifies the maximum number of DNS Servers in the Client server list.
   The default value is 5. */
[#if NX_DNS_MESSAGE_MAX_value == "512"]
/*
#define NX_DNS_MESSAGE_MAX                      512
*/
[#else]
#define NX_DNS_MESSAGE_MAX						${NX_DNS_MESSAGE_MAX_value}
[/#if]

/* If not defined, the size of the Client packet payload which includes the
   Ethernet, IP (or IPv6), and UDP headers plus the maximum DNS message size
   specified by NX_DNS_MESSAGE_MAX. Regardless if defined, the packet payload
   is the 4-byte aligned and stored in NX_DNS_PACKET_PAYLOAD.
   The default value is (NX_UDP_PACKET + NX_DNS_MESSAGE_MAX). */
[#if NX_DNS_PACKET_PAYLOAD_UNALIGNED_value == "576" || NX_DNS_PACKET_PAYLOAD_UNALIGNED_value == "556"]
/*
#define NX_DNS_PACKET_PAYLOAD_UNALIGNED         (NX_UDP_PACKET + NX_DNS_MESSAGE_MAX)
*/
[#else]
#define NX_DNS_PACKET_PAYLOAD_UNALIGNED			${NX_DNS_PACKET_PAYLOAD_UNALIGNED_value}
[/#if]

/* Size of the Client packet pool for sending DNS queries if
   NX_DNS_CLIENT_USER_CREATE_PACKET_POOL is not defined. The default value is
   large enough for 16 packets of payload size defined by NX_DNS_PACKET_PAYLOAD,
   and is 4-byte aligned.
   The default value is (16 * (NX_DNS_PACKET_PAYLOAD + sizeof(NX_PACKET))). */
[#if NX_DNS_PACKET_POOL_SIZE_value == "10288" ]
/*
#define NX_DNS_PACKET_POOL_SIZE                 (16 * (NX_DNS_PACKET_PAYLOAD + sizeof(NX_PACKET)))
*/
[#else]
#define NX_DNS_PACKET_POOL_SIZE					${NX_DNS_PACKET_POOL_SIZE_value}
[/#if]

/* The maximum number of times the DNS Client will query the current DNS server
   before trying another server or aborting the DNS query.
   The default value is 3. */
[#if NX_DNS_MAX_RETRIES_value == "3" ]
/*
#define NX_DNS_MAX_RETRIES                      3
*/
[#else]
#define NX_DNS_MAX_RETRIES						${NX_DNS_MAX_RETRIES_value}
[/#if]

/* If defined and the Client IPv4 gateway address is non zero, the DNS Client
   sets the IPv4 gateway as the Client’s primary DNS server. The default value
   is disabled. */
[#if NX_DNS_IP_GATEWAY_AND_DNS_SERVER_value == "true"]
#define NX_DNS_IP_GATEWAY_AND_DNS_SERVER
[#else]
/*
#define NX_DNS_IP_GATEWAY_AND_DNS_SERVER
*/
[/#if]

/* This enables the DNS Client to let the application create and set the DNS
   Client packet pool. By default this option is disabled, and the DNS Client
   creates its own packet pool in nx_dns_create. */
[#if NX_DNS_CLIENT_USER_CREATE_PACKET_POOL_value == "true"]
#define NX_DNS_CLIENT_USER_CREATE_PACKET_POOL
[#else]
/*
#define NX_DNS_CLIENT_USER_CREATE_PACKET_POOL
*/
[/#if]

/* This enables the DNS Client to clear old DNS messages off the receive queue
   before sending a new query. Removing these packets from previous DNS queries
   prevents the DNS Client socket queue from overflowing and dropping valid
   packets. */
[#if NX_DNS_CLIENT_CLEAR_QUEUE_value == "true"]
#define NX_DNS_CLIENT_CLEAR_QUEUE
[#else]
/*
#define NX_DNS_CLIENT_CLEAR_QUEUE
*/
[/#if]

/* This enables the DNS Client to query on additional DNS record types in
   (e.g. CNAME, NS, MX, SOA, SRV and TXT). */
[#if NX_DNS_ENABLE_EXTENDED_RR_TYPES_value == "true"]
#define NX_DNS_ENABLE_EXTENDED_RR_TYPES
[#else]
/*
#define NX_DNS_ENABLE_EXTENDED_RR_TYPES
*/
[/#if]

/* This enables the DNS Client to store the answer records into DNS cache. */
[#if NX_DNS_CACHE_ENABLE_value == "true"]
#define NX_DNS_CACHE_ENABLE
[#else]
/*
#define NX_DNS_CACHE_ENABLE
*/
[/#if]

/* This sets the timeout option for allocating a packet from the DNS client
   packet pool. The default value is 1 second (1*NX_IP_PERIODIC_RATE). */
[#if NX_DNS_PACKET_ALLOCATE_TIMEOUT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DNS_PACKET_ALLOCATE_TIMEOUT          NX_IP_PERIODIC_RATE
*/
[#else]
#define NX_DNS_PACKET_ALLOCATE_TIMEOUT			${NX_DNS_PACKET_ALLOCATE_TIMEOUT_value}
[/#if]

/* The maximum retransmission timeout on a DNS query to a specific DNS server.
   The default value is 64 seconds (64 * NX_IP_PERIODIC_RATE) */
[#if NX_DNS_MAX_RETRANS_TIMEOUT_value == "6400" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_DNS_MAX_RETRANS_TIMEOUT             (64 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_DNS_MAX_RETRANS_TIMEOUT				${NX_DNS_MAX_RETRANS_TIMEOUT_value}
[/#if]

/*****************************************************************************/
/********************* Configuration options for MQTT ************************/
/*****************************************************************************/

/* Defined, MQTT Client is built with TLS support. Defining this symbol
   requires NetX Secure TLS module to be installed. NX_SECURE_ENABLE is not
   enabled by default. */
[#if NX_SECURE_ENABLE_value == "true"]
#define NX_SECURE_ENABLE
[#else]
/*
#define NX_SECURE_ENABLE
*/
[/#if]

/* Defined, application must use TLS to connect to MQTT broker. This feature
   requires NX_SECURE_ENABLE defined. By default, this symbol is not
   defined. */
[#if NXD_MQTT_REQUIRE_TLS_value == "true"]
#define NXD_MQTT_REQUIRE_TLS
[#else]
/*
#define NXD_MQTT_REQUIRE_TLS
*/
[/#if]

/* Defines the MQTT timer rate, in ThreadX timer ticks. This timer is used to
   keep track of the time since last MQTT control message was sent, and sends
   out an MQTT PINGREQ message before the keep-alive time expires. This timer
   is activated if the client connects to the broker with a keep-alive timer
   value set. The default value is TX_TIMER_TICKS_PER_SECOND, which is a
   one-second timer. The default value is TX_TIMER_TICKS_PER_SECOND. */
[#if NXD_MQTT_KEEPALIVE_TIMER_RATE_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NXD_MQTT_KEEPALIVE_TIMER_RATE           (NX_IP_PERIODIC_RATE)
*/
[#else]
#define NXD_MQTT_KEEPALIVE_TIMER_RATE			${NXD_MQTT_KEEPALIVE_TIMER_RATE_value}
[/#if]

/* Defines the MQTT timer rate, in ThreadX timer ticks. This timer is used to
   keep track of the time since last MQTT control message was sent, and sends
   out an MQTT PINGREQ message before the keep-alive time expires. This timer
   is activated if the client connects to the broker with a keep-alive timer
   value set. The default value is TX_TIMER_TICKS_PER_SECOND, which is a
   one-second timer. */
[#if NXD_MQTT_PING_TIMEOUT_DELAY_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NXD_MQTT_PING_TIMEOUT_DELAY             (NX_IP_PERIODIC_RATE)
*/
[#else]
#define NXD_MQTT_PING_TIMEOUT_DELAY				${NXD_MQTT_PING_TIMEOUT_DELAY_value}
[/#if]

/* Defines the time out in the TCP socket disconnect call when disconnecting
   from the MQTT server in timer ticks. The default value is NX_WAIT_FOREVER. */
[#if NXD_MQTT_SOCKET_TIMEOUT_value == "0xFFFFFFFF"]
/*
#define NXD_MQTT_SOCKET_TIMEOUT                 NX_WAIT_FOREVER
*/
[#else]
#define NXD_MQTT_SOCKET_TIMEOUT					${NXD_MQTT_SOCKET_TIMEOUT_value}
[/#if]

/* Defined, enable MQTT over cloud option. */
[#if NX_CLOUD_COMPONENT_ENABLED == "true" && NXD_MQTT_CLOUD_ENABLE_value == "true"]
#define NXD_MQTT_CLOUD_ENABLE
[#else]
/*
#define NXD_MQTT_CLOUD_ENABLE
*/
[/#if]

/* Define memcpy function used internal. */
[#if NXD_MQTT_SECURE_MEMCPY_value == "memcpy"]
/*
#define NXD_MQTT_SECURE_MEMCPY                  memcpy
*/
[#else]
#define NXD_MQTT_SECURE_MEMCPY					"${NXD_MQTT_SECURE_MEMCPY_value}"
[/#if]

/* Define memcmp function used internal. */
[#if NXD_MQTT_SECURE_MEMCMP_value == "memcmp"]
/*
#define NXD_MQTT_SECURE_MEMCMP                  memcmp
*/
[#else]
#define NXD_MQTT_SECURE_MEMCMP					"${NXD_MQTT_SECURE_MEMCMP_value}"
[/#if]

/* Define memset function used internal. */
[#if NXD_MQTT_SECURE_MEMSET_value == "memset"]
/*
#define NXD_MQTT_SECURE_MEMSET                  memset
*/
[#else]
#define NXD_MQTT_SECURE_MEMSET					"${NXD_MQTT_SECURE_MEMSET_value}"
[/#if]

/* Define memmove function used internal. */
[#if NXD_MQTT_SECURE_MEMMOVE_value == "memmove"]
/*
#define NXD_MQTT_SECURE_MEMMOVE                 memmove
*/
[#else]
#define NXD_MQTT_SECURE_MEMMOVE					"${NXD_MQTT_SECURE_MEMMOVE_value}"
[/#if]

/* Define the default TCP socket window size. */
[#if NXD_MQTT_CLIENT_SOCKET_WINDOW_SIZE_value == "8192"]
/*
#define NXD_MQTT_CLIENT_SOCKET_WINDOW_SIZE      8192
*/
[#else]
#define NXD_MQTT_CLIENT_SOCKET_WINDOW_SIZE		${NXD_MQTT_CLIENT_SOCKET_WINDOW_SIZE_value}
[/#if]

/* Define the default MQTT Thread time slice. */
[#if NXD_MQTT_CLIENT_THREAD_TIME_SLICE_value == "2"]
/*
#define NXD_MQTT_CLIENT_THREAD_TIME_SLICE       2
*/
[#else]
#define NXD_MQTT_CLIENT_THREAD_TIME_SLICE		${NXD_MQTT_CLIENT_THREAD_TIME_SLICE_value}
[/#if]

/*****************************************************************************/
/********************* Configuration options for HTTP ************************/
/*****************************************************************************/

/* Defined, this option provides a stub for FileX dependencies. The HTTP Client
   will function without any change if this option is defined. The HTTP Server
   will need to either be modified or the user will have to create a handful
   of FileX services in order to function properly. */
[#if NX_HTTP_NO_FILEX_value == "true"]
#define NX_HTTP_NO_FILEX
[#else]
/*
#define NX_HTTP_NO_FILEX
*/
[/#if]

/* Type of service required for the HTTP TCP requests. By default, this value
   is defined as NX_IP_NORMAL to indicate normal IP packet service. */
[#if NX_HTTP_TYPE_OF_SERVICE_value == "((ULONG)0x00000000)"]
/*
#define NX_HTTP_TYPE_OF_SERVICE             	NX_IP_NORMAL
*/
[#else]
#define NX_HTTP_TYPE_OF_SERVICE					${NX_HTTP_TYPE_OF_SERVICE_value}
[/#if]

/* Fragment enable for HTTP TCP requests. By default, this value is
   NX_DONT_FRAGMENT to disable HTTP TCP fragmenting. */
[#if NX_HTTP_FRAGMENT_OPTION_value == "((ULONG)0x00004000)"]
/*
#define NX_HTTP_FRAGMENT_OPTION             	NX_DONT_FRAGMENT
*/
[#else]
#define NX_HTTP_FRAGMENT_OPTION					${NX_HTTP_FRAGMENT_OPTION_value}
[/#if]

/* Specifies the number of bytes allowed in a client supplied resource name.
   The default value is set to 40. */
[#if NX_HTTP_MAX_RESOURCE_value == "40"]
/*
#define NX_HTTP_MAX_RESOURCE                	40
*/
[#else]
#define NX_HTTP_MAX_RESOURCE					${NX_HTTP_MAX_RESOURCE_value}
[/#if]

/* Specifies the number of bytes allowed in a client supplied username.
   The default value is set to 20. */
[#if NX_HTTP_MAX_NAME_value == "20"]
/*
#define NX_HTTP_MAX_NAME                    	20
*/
[#else]
#define NX_HTTP_MAX_NAME						${NX_HTTP_MAX_NAME_value}
[/#if]

/* Specifies the number of bytes allowed in a client supplied password.
   The default value is set to 20. */
[#if NX_HTTP_MAX_PASSWORD_value == "20"]
/*
#define NX_HTTP_MAX_PASSWORD                	20
*/
[#else]
#define NX_HTTP_MAX_PASSWORD					${NX_HTTP_MAX_PASSWORD_value}
[/#if]

/*****************************************************************************/
/***************** Configuration options for HTTP Client *********************/
/*****************************************************************************/

/* Specifies the minimum size of the packets in the pool specified at Client
   creation. The minimum size is needed to ensure the complete HTTP header can
   be contained in one packet. The default value is set to 600. */
[#if NX_HTTP_CLIENT_MIN_PACKET_SIZE_value == "600"]
/*
#define NX_HTTP_CLIENT_MIN_PACKET_SIZE      	600
*/
[#else]
#define NX_HTTP_CLIENT_MIN_PACKET_SIZE			${NX_HTTP_CLIENT_MIN_PACKET_SIZE_value}
[/#if]

/*****************************************************************************/
/***************** Configuration options for HTTP Server *********************/
/*****************************************************************************/

/* Specifies the number of ThreadX ticks that internal services will suspend
   for. The default value is set to 10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_HTTP_SERVER_TIMEOUT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_HTTP_SERVER_TIMEOUT              	(10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_HTTP_SERVER_TIMEOUT					${NX_HTTP_SERVER_TIMEOUT_value}
[/#if]

/* The number of timer ticks the Server thread is allowed to run before yielding
   to threads of the same priority. The default value is 2. */
[#if NX_HTTP_SERVER_THREAD_TIME_SLICE_value == "2"]
/*
#define NX_HTTP_SERVER_THREAD_TIME_SLICE    	2
*/
[#else]
#define NX_HTTP_SERVER_THREAD_TIME_SLICE		${NX_HTTP_SERVER_THREAD_TIME_SLICE_value}
[/#if]

/* Specifies the maximum size of the HTTP header field. The default value is 256. */
[#if NX_HTTP_MAX_HEADER_FIELD_value == "256"]
/*
#define NX_HTTP_MAX_HEADER_FIELD            	256
*/
[#else]
#define NX_HTTP_MAX_HEADER_FIELD				${NX_HTTP_MAX_HEADER_FIELD_value}
[/#if]

/* If defined, enables HTTP Server to support multipart HTTP requests. */
[#if NX_HTTP_MULTIPART_ENABLE_value == "true"]
#define NX_HTTP_MULTIPART_ENABLE
[#else]
/*
#define NX_HTTP_MULTIPART_ENABLE
*/
[/#if]

/* Specifies the number of connections that can be queued for the HTTP Server.
   The default value is set to 5. */
[#if NX_HTTP_SERVER_MAX_PENDING_value == "5"]
/*
#define NX_HTTP_SERVER_MAX_PENDING          	5
*/
[#else]
#define NX_HTTP_SERVER_MAX_PENDING				${NX_HTTP_SERVER_MAX_PENDING_value}
[/#if]

/* This specifies the maximum number of packets that can be enqueued on the
   Server socket retransmission queue. If the number of packets enqueued
   reaches this number, no more packets can be sent until one or more enqueued
   packets are released. The default value is set to 20. */
[#if NX_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH_value == "20"]
/*
#define NX_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH 	20
*/
[#else]
#define NX_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH 	${NX_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH_value}
[/#if]

/* Specifies the minimum size of the packets in the pool specified at Server
   creation. The minimum size is needed to ensure the complete HTTP header can
   be contained in one packet. The default value is set to 600. */
[#if NX_HTTP_SERVER_MIN_PACKET_SIZE_value == "600"]
/*
#define NX_HTTP_SERVER_MIN_PACKET_SIZE      	600
*/
[#else]
#define NX_HTTP_SERVER_MIN_PACKET_SIZE		 	${NX_HTTP_SERVER_MIN_PACKET_SIZE_value}
[/#if]

/* Set the Server socket retransmission timeout in seconds.
   The default value is set to 2. */
[#if NX_HTTP_SERVER_RETRY_SECONDS_value == "2"]
/*
#define NX_HTTP_SERVER_RETRY_SECONDS        	2
*/
[#else]
#define NX_HTTP_SERVER_RETRY_SECONDS		 	${NX_HTTP_SERVER_RETRY_SECONDS_value}
[/#if]

/* This value is used to set the next retransmission timeout. The current
   timeout is multiplied by the number of retransmissions thus far, shifted
   by the value of the socket timeout shift. The default value is set to 1 for
   doubling the timeout. */
[#if NX_HTTP_SERVER_RETRY_SHIFT_value == "1"]
/*
#define NX_HTTP_SERVER_RETRY_SHIFT          	1
*/
[#else]
#define NX_HTTP_SERVER_RETRY_SHIFT			 	${NX_HTTP_SERVER_RETRY_SHIFT_value}
[/#if]

/* This sets the maximum number of retransmissions on Server socket.
   The default value is set to 10. */
[#if NX_HTTP_SERVER_RETRY_MAX_value == "10"]
/*
#define NX_HTTP_SERVER_RETRY_MAX            	10
*/
[#else]
#define NX_HTTP_SERVER_RETRY_MAX			 	${NX_HTTP_SERVER_RETRY_MAX_value}
[/#if]

/* The priority of the HTTP Server thread. By default, this value is defined
   as 16 to specify priority 16. */
[#if NX_HTTP_SERVER_PRIORITY_value == "16"]
/*
#define NX_HTTP_SERVER_PRIORITY             	16
*/
[#else]
#define NX_HTTP_SERVER_PRIORITY				 	${NX_HTTP_SERVER_PRIORITY_value}
[/#if]

/* Server socket window size. By default, this value is 2048 bytes */
[#if NX_HTTP_SERVER_WINDOW_SIZE_value == "2048"]
/*
#define NX_HTTP_SERVER_WINDOW_SIZE          	2048
*/
[#else]
#define NX_HTTP_SERVER_WINDOW_SIZE			 	${NX_HTTP_SERVER_WINDOW_SIZE_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
  for in internal nx_tcp_server_socket_accept calls. The default value is set
  to (10 * NX_IP_PERIODIC_RATE). */
[#if NX_HTTP_SERVER_TIMEOUT_ACCEPT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_HTTP_SERVER_TIMEOUT_ACCEPT       	(10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_HTTP_SERVER_TIMEOUT_ACCEPT		 	${NX_HTTP_SERVER_TIMEOUT_ACCEPT_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_socket_receive calls. The default value is set to
   10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_HTTP_SERVER_TIMEOUT_RECEIVE_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_HTTP_SERVER_TIMEOUT_RECEIVE       	(10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_HTTP_SERVER_TIMEOUT_RECEIVE		 	${NX_HTTP_SERVER_TIMEOUT_RECEIVE_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_socket_send calls. The default value is set to
   10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_HTTP_SERVER_TIMEOUT_SEND_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_HTTP_SERVER_TIMEOUT_SEND       		(10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_HTTP_SERVER_TIMEOUT_SEND		 		${NX_HTTP_SERVER_TIMEOUT_SEND_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_socket_disconnect calls. The default value is set
   to 10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_HTTP_SERVER_TIMEOUT_DISCONNECT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_HTTP_SERVER_TIMEOUT_DISCONNECT       (10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_HTTP_SERVER_TIMEOUT_DISCONNECT		 ${NX_HTTP_SERVER_TIMEOUT_DISCONNECT_value}
[/#if]

/*****************************************************************************/
/***************** Configuration options for AUTO_IP *************************/
/*****************************************************************************/

/* This option enables printing a debugging trace using printf.*/
[#if NX_AUTO_IP_DEBUG_value == "true"]
#define NX_AUTO_IP_DEBUG		
[#else]
/*
#define NX_AUTO_IP_DEBUG
*/
[/#if]

/* The number of seconds to wait before sending first probe.
   By default, this value is defined as 1.*/
[#if NX_AUTO_IP_PROBE_WAIT_value == "1"]
/*
#define NX_AUTO_IP_PROBE_WAIT         1
*/
[#else]
#define NX_AUTO_IP_PROBE_WAIT         ${NX_AUTO_IP_PROBE_WAIT_value}
[/#if]

/* The number of ARP probes to send.
   By default, this value is defined as 3.*/
[#if NX_AUTO_IP_PROBE_NUM_value == "3"]
/*
#define NX_AUTO_IP_PROBE_NUM         3
*/
[#else]
#define NX_AUTO_IP_PROBE_NUM         ${NX_AUTO_IP_PROBE_NUM_value}
[/#if]

/* The minimum number of seconds to wait between sending probes.
   By default, this value is defined as 1.*/
[#if NX_AUTO_IP_PROBE_MIN_value == "1"]
/*
#define NX_AUTO_IP_PROBE_MIN         1
*/
[#else]
#define NX_AUTO_IP_PROBE_MIN         ${NX_AUTO_IP_PROBE_MIN_value}
[/#if]

/* The maximum number of seconds to wait between sending probes.
   By default, this value is defined as 2.*/
[#if NX_AUTO_IP_PROBE_MAX_value == "2"]
/*
#define NX_AUTO_IP_PROBE_MAX         2
*/
[#else]
#define NX_AUTO_IP_PROBE_MAX         ${NX_AUTO_IP_PROBE_MAX_value}
[/#if]

/* The number of AutoIP conflicts before increasing processing delays.
   By default, this value is defined as 10.*/
[#if NX_AUTO_IP_MAX_CONFLICTS_value == "10"]
/*
#define NX_AUTO_IP_MAX_CONFLICTS         10
*/
[#else]
#define NX_AUTO_IP_MAX_CONFLICTS         ${NX_AUTO_IP_MAX_CONFLICTS_value}
[/#if]

/* The number of seconds to extend the wait period when the total
   number of conflicts is exceeded. By default, this value is defined as 60.*/
[#if NX_AUTO_IP_RATE_LIMIT_INTERVAL_value == "60"]
/*
#define NX_AUTO_IP_RATE_LIMIT_INTERVAL         60
*/
[#else]
#define NX_AUTO_IP_RATE_LIMIT_INTERVAL         ${NX_AUTO_IP_RATE_LIMIT_INTERVAL_value}
[/#if]

/* The number of seconds to wait before sending announcement.
   By default, this value is defined as 2.*/
[#if NX_AUTO_IP_ANNOUNCE_WAIT_value == "2"]
/*
#define NX_AUTO_IP_ANNOUNCE_WAIT         2
*/
[#else]
#define NX_AUTO_IP_ANNOUNCE_WAIT         ${NX_AUTO_IP_ANNOUNCE_WAIT_value}
[/#if]

/* The number of ARP announces to send.
   By default, this value is defined as 2.*/
[#if NX_AUTO_IP_ANNOUNCE_NUM_value == "2"]
/*
#define NX_AUTO_IP_ANNOUNCE_NUM         2
*/
[#else]
#define NX_AUTO_IP_ANNOUNCE_NUM         ${NX_AUTO_IP_ANNOUNCE_NUM_value}
[/#if]

/* The number of seconds to wait between sending announces.
   By default, this value is defined as 2.*/
[#if NX_AUTO_IP_ANNOUNCE_INTERVAL_value == "2"]
/*
#define NX_AUTO_IP_ANNOUNCE_INTERVAL         2
*/
[#else]
#define NX_AUTO_IP_ANNOUNCE_INTERVAL         ${NX_AUTO_IP_ANNOUNCE_INTERVAL_value}
[/#if]

/* The number of seconds to wait between defense announces.
   By default, this value is defined as 10.*/
[#if NX_AUTO_IP_DEFEND_INTERVAL_value == "10"]
/*
#define NX_AUTO_IP_DEFEND_INTERVAL         10
*/
[#else]
#define NX_AUTO_IP_DEFEND_INTERVAL         ${NX_AUTO_IP_DEFEND_INTERVAL_value}
[/#if]

/*****************************************************************************/
/************** Configuration options for mDNS *******************************/
/*****************************************************************************/

/* Disables the mDNS/DNS-SD server functionality. Without the server functionality,
   the mDNS/DNS-SD module does not announce services provided by local host,
   nor does it respond to mDNS enquiries. This symbol is not defined by default.*/
[#if NX_MDNS_DISABLE_SERVER_value == "true"]
#define NX_MDNS_DISABLE_SERVER
[#else]
/*
#define NX_MDNS_DISABLE_SERVER
*/
[/#if]

/* Maximum IPv6 addresses count of host. The default value is 2.*/
[#if NX_MDNS_IPV6_ADDRESS_COUNT_value == "2"]
/*
#define NX_MDNS_IPV6_ADDRESS_COUNT        2
*/
[#else]
#define NX_MDNS_IPV6_ADDRESS_COUNT        ${NX_MDNS_IPV6_ADDRESS_COUNT_value}
[/#if]

/* Maximum string size for host name. The default value is 64.
   Does not include the NULL terminator.*/
[#if NX_MDNS_HOST_NAME_MAX_value == "64"]
/*
#define NX_MDNS_HOST_NAME_MAX        64
*/
[#else]
#define NX_MDNS_HOST_NAME_MAX        ${NX_MDNS_HOST_NAME_MAX_value}
[/#if]

/* Maximum string size for service name. The default value is 64.
   Does not include the NULL terminator.*/
[#if NX_MDNS_SERVICE_NAME_MAX_value == "64"]
/*
#define NX_MDNS_SERVICE_NAME_MAX        64
*/
[#else]
#define NX_MDNS_SERVICE_NAME_MAX        ${NX_MDNS_SERVICE_NAME_MAX_value}
[/#if]

/* Maximum string size for domain name. The default value is 16.
   Does not include the NULL terminator.*/
[#if NX_MDNS_DOMAIN_NAME_MAX_value == "16"]
/*
#define NX_MDNS_DOMAIN_NAME_MAX        16
*/
[#else]
#define NX_MDNS_DOMAIN_NAME_MAX        ${NX_MDNS_DOMAIN_NAME_MAX_value}
[/#if]

/* Maximum conflict count for host name or service name.
   The default value is 8.*/
[#if NX_MDNS_CONFLICT_COUNT_value == "8"]
/*
#define NX_MDNS_CONFLICT_COUNT        8
*/
[#else]
#define NX_MDNS_CONFLICT_COUNT        ${NX_MDNS_CONFLICT_COUNT_value}
[/#if]

/* Define UDP socket create options.*/
[#if NX_MDNS_UDP_TYPE_OF_SERVICE_value == "((ULONG)0x00000000)"]
/*
#define NX_MDNS_UDP_TYPE_OF_SERVICE        NX_IP_NORMAL
*/
[#else]
#define NX_MDNS_UDP_TYPE_OF_SERVICE        ${NX_MDNS_UDP_TYPE_OF_SERVICE_value}
[/#if]

/* TTL value for resource records with host name, in second.
   The default value is 120 for 120s.*/
[#if NX_MDNS_RR_TTL_HOST_value == "120"]
/*
#define NX_MDNS_RR_TTL_HOST        120
*/
[#else]
#define NX_MDNS_RR_TTL_HOST        ${NX_MDNS_RR_TTL_HOST_value}
[/#if]


/* TTL value for other resource records, in second.
   The default value is 4500 for 75 minutes.*/
[#if NX_MDNS_RR_TTL_OTHER_value == "4500"]
/*
#define NX_MDNS_RR_TTL_OTHER        4500
*/
[#else]
#define NX_MDNS_RR_TTL_OTHER        ${NX_MDNS_RR_TTL_OTHER_value}
[/#if]

/* The time interval, in ticks, between mDNS probing messages.
   The default value is 25 ticks for 250ms.*/
[#if NX_MDNS_PROBING_TIMER_COUNT_value == "25"]
/*
#define NX_MDNS_PROBING_TIMER_COUNT        25
*/
[#else]
#define NX_MDNS_PROBING_TIMER_COUNT        ${NX_MDNS_PROBING_TIMER_COUNT_value}
[/#if]

/* The time interval, in ticks, between mDNS announcement messages.
   The default value is 25 ticks for 250ms.*/
[#if NX_MDNS_ANNOUNCING_TIMER_COUNT_value == "25"]
/*
#define NX_MDNS_ANNOUNCING_TIMER_COUNT        25
*/
[#else]
#define NX_MDNS_ANNOUNCING_TIMER_COUNT        ${NX_MDNS_ANNOUNCING_TIMER_COUNT_value}
[/#if]

/* The time interval, in ticks, between repeated "goodbye" messages.
   The default value is 25 ticks for 250ms.*/
[#if NX_MDNS_GOODBYE_TIMER_COUNT_value == "25"]
/*
#define NX_MDNS_GOODBYE_TIMER_COUNT        25
*/
[#else]
#define NX_MDNS_GOODBYE_TIMER_COUNT        ${NX_MDNS_GOODBYE_TIMER_COUNT_value}
[/#if]

/* The minimum time interval, in ticks, between two queries.
   The default value is 100 ticks for 1 second.*/
[#if NX_MDNS_QUERY_MIN_TIMER_COUNT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_MDNS_QUERY_MIN_TIMER_COUNT        (NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_MDNS_QUERY_MIN_TIMER_COUNT        ${NX_MDNS_QUERY_MIN_TIMER_COUNT_value}
[/#if]

/* The maximum time interval, in ticks, between two queries.
   The default value is 360000 for 60 seconds.*/
[#if NX_MDNS_QUERY_MAX_TIMER_COUNT_value == "360000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_MDNS_QUERY_MAX_TIMER_COUNT        (3600 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_MDNS_QUERY_MAX_TIMER_COUNT        ${NX_MDNS_QUERY_MAX_TIMER_COUNT_value}
[/#if]

/* The minimum delay for sending first query, in ticks.
   The default value is 2 ticks for 20ms.*/
[#if NX_MDNS_QUERY_DELAY_MIN_value == "2"]
/*
#define NX_MDNS_QUERY_DELAY_MIN        2
*/
[#else]
#define NX_MDNS_QUERY_DELAY_MIN        ${NX_MDNS_QUERY_DELAY_MIN_value}
[/#if]

/* The delay range for sending first query, in ticks.
   The default value is 10 ticks for 100ms.*/
[#if NX_MDNS_QUERY_DELAY_RANGE_value == "10"]
/*
#define NX_MDNS_QUERY_DELAY_RANGE        10
*/
[#else]
#define NX_MDNS_QUERY_DELAY_RANGE        ${NX_MDNS_QUERY_DELAY_RANGE_value}
[/#if]

/* The time interval, in ticks, in responding to a query to ensure
   an interval of at least 1s since the last time the record was multicast.
   The default value is 100 ticks (NX_IP_PERIODIC_RATE).*/
[#if NX_MDNS_RESPONSE_INTERVAL_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_MDNS_RESPONSE_INTERVAL        NX_IP_PERIODIC_RATE
*/
[#else]
#define NX_MDNS_RESPONSE_INTERVAL        ${NX_MDNS_RESPONSE_INTERVAL_value}
[/#if]

/* The delay, in ticks, in responding to a query to a service that is
   unique to the local network. The default value is 1 tick for 10ms.*/
[#if NX_MDNS_RESPONSE_UNIQUE_DELAY_value == "1"]
/*
#define NX_MDNS_RESPONSE_UNIQUE_DELAY        1
*/
[#else]
#define NX_MDNS_RESPONSE_UNIQUE_DELAY        ${NX_MDNS_RESPONSE_UNIQUE_DELAY_value}
[/#if]

/* The minimum delay, in ticks, in responding to a query to a shared resource.
   The default value is 2 ticks for 20ms.*/
[#if NX_MDNS_RESPONSE_SHARED_DELAY_MIN_value == "2"]
/*
#define NX_MDNS_RESPONSE_SHARED_DELAY_MIN        2
*/
[#else]
#define NX_MDNS_RESPONSE_SHARED_DELAY_MIN        ${NX_MDNS_RESPONSE_SHARED_DELAY_MIN_value}
[/#if]

/* The delay range, in ticks, in responding to a query to a shared resource.
   The default value is 10 ticks for 100ms.*/
[#if NX_MDNS_RESPONSE_SHARED_DELAY_RANGE_value == "10"]
/*
#define NX_MDNS_RESPONSE_SHARED_DELAY_RANGE        10
*/
[#else]
#define NX_MDNS_RESPONSE_SHARED_DELAY_RANGE        ${NX_MDNS_RESPONSE_SHARED_DELAY_RANGE_value}
[/#if]

/* The minimum delay, in ticks, in responding to a query with TC bit.
   The default value is 40 ticks for 400ms.*/
[#if NX_MDNS_RESPONSE_TC_DELAY_MIN_value == "40"]
/*
#define NX_MDNS_RESPONSE_TC_DELAY_MIN        40
*/
[#else]
#define NX_MDNS_RESPONSE_TC_DELAY_MIN        ${NX_MDNS_RESPONSE_TC_DELAY_MIN_value}
[/#if]

/* The delay range, in ticks, in responding to a query with TC bit.
   The default value is 10 ticks for 100ms.*/
[#if NX_MDNS_RESPONSE_TC_DELAY_RANGE_value == "10"]
/*
#define NX_MDNS_RESPONSE_TC_DELAY_RANGE        10
*/
[#else]
#define NX_MDNS_RESPONSE_TC_DELAY_RANGE        ${NX_MDNS_RESPONSE_TC_DELAY_RANGE_value}
[/#if]

/* When sending out mDNS responses, the packet contains responses that
   otherwise would be sent within this timer counter range.
   The timer count range is expressed in ticks. The default value is 12 for
   120ms.This value allows a response to include messages that would be sent
   within the next 120ms range if each tick is 10ms.*/
[#if NX_MDNS_TIMER_COUNT_RANGE_value == "12"]
/*
#define NX_MDNS_TIMER_COUNT_RANGE        12
*/
[#else]
#define NX_MDNS_TIMER_COUNT_RANGE        ${NX_MDNS_TIMER_COUNT_RANGE_value}
[/#if]

/* The number of retransmitted probing messages. The default value is 3.*/
[#if NX_MDNS_PROBING_RETRANSMIT_COUNT_value == "3"]
/*
#define NX_MDNS_PROBING_RETRANSMIT_COUNT        3
*/
[#else]
#define NX_MDNS_PROBING_RETRANSMIT_COUNT        ${NX_MDNS_PROBING_RETRANSMIT_COUNT_value}
[/#if]

/* The number of retransmitted "goodbye" messages. The default value is 1.*/
[#if NX_MDNS_GOODBYE_RETRANSMIT_COUNT_value == "1"]
/*
#define NX_MDNS_GOODBYE_RETRANSMIT_COUNT        1
*/
[#else]
#define NX_MDNS_GOODBYE_RETRANSMIT_COUNT        ${NX_MDNS_GOODBYE_RETRANSMIT_COUNT_value}
[/#if]

/* The number of queries that no multicast response,
   then the host may take this as an indication that
   the record may no longer be valid. The default value is 2.*/
[#if NX_MDNS_POOF_MIN_COUNT_value == "2"]
/*
#define NX_MDNS_POOF_MIN_COUNT        2
*/
[#else]
#define NX_MDNS_POOF_MIN_COUNT        ${NX_MDNS_POOF_MIN_COUNT_value}
[/#if]

/* Define the Passive Observation Of Failures timer count,
   10 seconds in spec (10 * NX_IP_PERIODIC_RATE).*/
[#if NX_MDNS_POOF_TIMER_COUNT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_MDNS_POOF_TIMER_COUNT        (10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_MDNS_POOF_TIMER_COUNT        ${NX_MDNS_POOF_TIMER_COUNT_value}
[/#if]

/* The delay for deleting a resource record when the TTL of
   this record is zero, in ticks, The default value is 100 ticks for 1 second (NX_IP_PERIODIC_RATE).*/
[#if NX_MDNS_RR_DELETE_DELAY_TIMER_COUNT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_MDNS_RR_DELETE_DELAY_TIMER_COUNT        (NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_MDNS_RR_DELETE_DELAY_TIMER_COUNT       ${NX_MDNS_RR_DELETE_DELAY_TIMER_COUNT_value}
[/#if]

/*****************************************************************************/
/******************** Configuration options for PPP **************************/
/*****************************************************************************/

/* If defined, PPP can transmit packet over Ethernet.*/
[#if NX_PPP_PPPOE_ENABLE_value == "true"]
#define NX_PPP_PPPOE_ENABLE
[#else]
/*
#define NX_PPP_PPPOE_ENABLE
*/
[/#if]

/* If defined, internal PPP information gathering is disabled.*/
[#if NX_PPP_DISABLE_INFO_value == "true"]
#define NX_PPP_DISABLE_INFO
[#else]
/*
#define NX_PPP_DISABLE_INFO
*/
[/#if]

/* If defined, internal PPP debug log is enabled.*/
[#if NX_PPP_DEBUG_LOG_ENABLE_value == "true"]
#define NX_PPP_DEBUG_LOG_ENABLE
[#else]
/*
#define NX_PPP_DEBUG_LOG_ENABLE
*/
[/#if]

/* If defined, internal PPP debug log printf to stdio is enabled.
   This is only valid if the debug log is also enabled.*/
[#if NX_PPP_DEBUG_LOG_PRINT_ENABLE_value == "true"]
#define NX_PPP_DEBUG_LOG_PRINT_ENABLE
[#else]
/*
#define NX_PPP_DEBUG_LOG_PRINT_ENABLE
*/
[/#if]

/* If defined, internal PPP CHAP logic is removed, including the MD5 digest logic.*/
[#if NX_PPP_DISABLE_CHAP_value == "true"]
#define NX_PPP_DISABLE_CHAP
[#else]
/*
#define NX_PPP_DISABLE_CHAP
*/
[/#if]

/* If defined, internal PPP PAP logic is removed.*/
[#if NX_PPP_DISABLE_PAP_value == "true"]
#define NX_PPP_DISABLE_PAP
[#else]
/*
#define NX_PPP_DISABLE_PAP
*/
[/#if]

/* If defined, the primary DNS Server Option is disabled in
   the IPCP response. By default this option is not defined.*/
[#if NX_PPP_DNS_OPTION_DISABLE_value == "true"]
#define NX_PPP_DNS_OPTION_DISABLE
[#else]
/*
#define NX_PPP_DNS_OPTION_DISABLE
*/
[/#if]

/* This specifies how many times the PPP host will request
  a DNS Server address from the peer in the IPCP state.
  This has no effect if NX_PPP_DNS_OPTION_DISABLE is defined.
  The default value is 2.*/
[#if NX_PPP_DNS_ADDRESS_MAX_RETRIES_value == "2"]
/*
#define NX_PPP_DNS_ADDRESS_MAX_RETRIES       2
*/
[#else]
#define NX_PPP_DNS_ADDRESS_MAX_RETRIES       ${NX_PPP_DNS_ADDRESS_MAX_RETRIES_value}
[/#if]

/* Time-slice option for PPP threads.
   By default, this value is TX_NO_TIME_SLICE.
   This define can be set by the application prior
   to inclusion of nx_ppp.h.By default, it is TX_NO_TIME_SLICE.*/
[#if NX_PPP_THREAD_TIME_SLICE_value == "0"]
/*
#define NX_PPP_THREAD_TIME_SLICE       TX_NO_TIME_SLICE
*/
[#else]
#define NX_PPP_THREAD_TIME_SLICE       ${NX_PPP_THREAD_TIME_SLICE_value}
[/#if]

/* Specifies the Maximum Receive Unit (MRU) for PPP.
   By default, this value is 1,500 bytes (the minimum value).
   This define can be set by the application prior to inclusion of nx_ppp.h.*/
[#if NX_PPP_MRU_value == "1480"]
/*
#define NX_PPP_MRU       1480
*/
[#else]
#define NX_PPP_MRU       ${NX_PPP_MRU_value}
[/#if]

/* Specifies the Maximum Receive Unit (MRU) for PPP.
   By default, this value is 1,500 bytes (the minimum value).
   This define can be set by the application prior to inclusion of nx_ppp.h.*/
[#if NX_PPP_MINIMUM_MRU_value == "1480"]
/*
#define NX_PPP_MINIMUM_MRU       1480
*/
[#else]
#define NX_PPP_MINIMUM_MRU       ${NX_PPP_MINIMUM_MRU_value}
[/#if]

/* Specifies the size of the receive character serial buffer.
   By default, this value is 3,000 bytes.
   This define can be set by the application prior to inclusion of nx_ppp.h.
   By default, it is NX_PPP_MRU*2.*/
[#if NX_PPP_SERIAL_BUFFER_SIZE_value == "2960"]
/*
#define NX_PPP_SERIAL_BUFFER_SIZE       2960
*/
[#else]
#define NX_PPP_SERIAL_BUFFER_SIZE       ${NX_PPP_SERIAL_BUFFER_SIZE_value}
[/#if]

/* Specifies the size of “name” strings used in authentication.
   The default value is set to 32bytes,
   but can be redefined prior to inclusion of *nx_ppp.h.*/
[#if NX_PPP_NAME_SIZE_value == "32"]
/*
#define NX_PPP_NAME_SIZE       32
*/
[#else]
#define NX_PPP_NAME_SIZE       ${NX_PPP_NAME_SIZE_value}
[/#if]

/* Specifies the size of "password" strings used in authentication.
   The default value is set to 32bytes,
   but can be redefined prior to inclusion of *nx_ppp.h.*/
[#if NX_PPP_PASSWORD_SIZE_value == "32"]
/*
#define NX_PPP_PASSWORD_SIZE       32
*/
[#else]
#define NX_PPP_PASSWORD_SIZE       ${NX_PPP_PASSWORD_SIZE_value}
[/#if]

/* Specifies the size of “value” strings used in CHAP authentication.
   The default value is set to 32bytes,
   but can be redefined prior to inclusion of nx_ppp.h.*/
[#if NX_PPP_VALUE_SIZE_value == "32"]
/*
#define NX_PPP_VALUE_SIZE       32
*/
[#else]
#define NX_PPP_VALUE_SIZE       ${NX_PPP_VALUE_SIZE_value}
[/#if]

/* Specifies the size of “hashed value” strings used in CHAP authentication.
   The default value is set to 16 bytes, but can be redefined prior
   to inclusion of nx_ppp.h.*/
[#if NX_PPP_HASHED_VALUE_SIZE_value == "16"]
/*
#define NX_PPP_HASHED_VALUE_SIZE       16
*/
[#else]
#define NX_PPP_HASHED_VALUE_SIZE       ${NX_PPP_HASHED_VALUE_SIZE_value}
[/#if]


/* This defines the period rate (in timer ticks) that the PPP
  thread task is woken to check for PPP events.
  The default value is 1*NX_IP_PERIODIC_RATE (100 ticks).*/
[#if NX_PPP_BASE_TIMEOUT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_PPP_BASE_TIMEOUT       (NX_IP_PERIODIC_RATE * 1)
*/
[#else]
#define NX_PPP_BASE_TIMEOUT       ${NX_PPP_BASE_TIMEOUT_value}
[/#if]

/* This defines the wait option (in timer ticks) for allocating packets
   to transmit data as well as buffer PPP serial data into packets to
   send to the IP layer. The default value is 4*NX_IP_PERIODIC_RATE (400 ticks).*/
[#if NX_PPP_TIMEOUT_value == "400" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_PPP_TIMEOUT       (NX_IP_PERIODIC_RATE * 4)
*/
[#else]
#define NX_PPP_TIMEOUT       ${NX_PPP_TIMEOUT_value}
[/#if]

/* This defines the number of times the PPP thread task times out
   waiting to receive the next character in a PPP message stream.
   Thereafter, PPP releases the packet and begins waiting to
   receive the next PPP message. The default value is 4. */
[#if NX_PPP_RECEIVE_TIMEOUTS_value == "4"]
/*
#define NX_PPP_RECEIVE_TIMEOUTS       4
*/
[#else]
#define NX_PPP_RECEIVE_TIMEOUTS       ${NX_PPP_RECEIVE_TIMEOUTS_value}
[/#if]

/* This defines the wait option (in seconds) for the PPP task to
   receive a response to a PPP protocol request message. The default value is 4 seconds. */
[#if NX_PPP_PROTOCOL_TIMEOUT_value == "4"]
/*
#define NX_PPP_PROTOCOL_TIMEOUT       4
*/
[#else]
#define NX_PPP_PROTOCOL_TIMEOUT       ${NX_PPP_PROTOCOL_TIMEOUT_value}
[/#if]

/* Size of debug log (number of entries in the debug log).
   On reaching the last entry, the debug capture wraps
   to the first entry and overwrites any data previously captured.
   The default value is 50. */
[#if NX_PPP_DEBUG_LOG_SIZE_value == "50"]
/*
#define NX_PPP_DEBUG_LOG_SIZE       50
*/
[#else]
#define NX_PPP_DEBUG_LOG_SIZE       ${NX_PPP_DEBUG_LOG_SIZE_value}
[/#if]

/* Maximum amount of data captured from a received packet
   payload and saved to debug output. The default value is 50.*/
[#if NX_PPP_DEBUG_FRAME_SIZE_value == "50"]
/*
#define NX_PPP_DEBUG_FRAME_SIZE       50
*/
[#else]
#define NX_PPP_DEBUG_FRAME_SIZE       ${NX_PPP_DEBUG_FRAME_SIZE_value}
[/#if]

/* This defines the max number of retries if the PPP times out before sending
   another LCP configure request message. When this number is reached the
   PPP handshake is aborted and the link status is down. The default value is 20. */
[#if NX_PPP_MAX_LCP_PROTOCOL_RETRIES_value == "20"]
/*
#define NX_PPP_MAX_LCP_PROTOCOL_RETRIES       20
*/
[#else]
#define NX_PPP_MAX_LCP_PROTOCOL_RETRIES       ${NX_PPP_MAX_LCP_PROTOCOL_RETRIES_value}
[/#if]

/* This defines the max number of retries if the PPP times out
   before sending another PAP authentication request message.
   When this number is reached the PPP handshake is aborted and the
   link status is down. The default value is 20.*/
[#if NX_PPP_MAX_PAP_PROTOCOL_RETRIES_value == "20"]
/*
#define NX_PPP_MAX_PAP_PROTOCOL_RETRIES       20
*/
[#else]
#define NX_PPP_MAX_PAP_PROTOCOL_RETRIES       ${NX_PPP_MAX_PAP_PROTOCOL_RETRIES_value}
[/#if]

/* This defines the max number of retries if the PPP times out
   before sending another CHAP challenge message. When this number
   is reached the PPP handshake is aborted and the link status is down.
   The default value is 20.*/
[#if NX_PPP_MAX_CHAP_PROTOCOL_RETRIES_value == "20"]
/*
#define NX_PPP_MAX_CHAP_PROTOCOL_RETRIES       20
*/
[#else]
#define NX_PPP_MAX_CHAP_PROTOCOL_RETRIES       ${NX_PPP_MAX_CHAP_PROTOCOL_RETRIES_value}
[/#if]

/* Define the packet header.*/
[#if NX_PPP_PACKET_value == "22"]
/*
#define NX_PPP_PACKET        22
*/
[#else]
#define NX_PPP_PACKET       ${NX_PPP_PACKET_value}
[/#if]

/* Define the minimum PPP packet payload, the PPP commands
  (LCP, PAP, CHAP, IPCP) should be in one packet.
   The default value is (NX_PPP_PACKET + 128).*/
[#if NX_PPP_MIN_PACKET_PAYLOAD_value == "150"]
/*
#define NX_PPP_MIN_PACKET_PAYLOAD        (NX_PPP_PACKET + 128)
*/
[#else]
#define NX_PPP_MIN_PACKET_PAYLOAD       ${NX_PPP_MIN_PACKET_PAYLOAD_value}
[/#if]

/*****************************************************************************/
/******************** Configuration options for SNTP *************************/
/*****************************************************************************/

/* This option sets the size of the Client thread stack. The default NetX Duo
   SNTP Client size is 2048. */
[#if NX_SNTP_CLIENT_THREAD_STACK_SIZE_value == "2048"]
/*
#define NX_SNTP_CLIENT_THREAD_STACK_SIZE       	2048
*/
[#else]
#define NX_SNTP_CLIENT_THREAD_STACK_SIZE		${NX_SNTP_CLIENT_THREAD_STACK_SIZE_value}
[/#if]

/* This option sets the time slice of the scheduler allows for Client thread
   execution. The default NetX Duo SNTP Client size is TX_NO_TIME_SLICE. */
[#if NX_SNTP_CLIENT_THREAD_TIME_SLICE_value == "0"]
/*
#define NX_SNTP_CLIENT_THREAD_TIME_SLICE        TX_NO_TIME_SLICE
*/
[#else]
#define NX_SNTP_CLIENT_THREAD_TIME_SLICE		${NX_SNTP_CLIENT_THREAD_TIME_SLICE_value}
[/#if]

/* This option sets the Client thread priority.
   The NetX Duo SNTP Client default value is 2. */
[#if NX_SNTP_CLIENT_THREAD_PRIORITY_value == "2"]
/*
#define NX_SNTP_CLIENT_THREAD_PRIORITY          2
*/
[#else]
#define NX_SNTP_CLIENT_THREAD_PRIORITY			${NX_SNTP_CLIENT_THREAD_PRIORITY_value}
[/#if]

/* This option sets the sets the level of priority at which the Client thread
   allows preemption. The default NetX Duo SNTP Client value is set to
   NX_SNTP_CLIENT_ THREAD_PRIORITY.  */
[#if NX_SNTP_CLIENT_PREEMPTION_THRESHOLD_value == "2" && NX_SNTP_CLIENT_THREAD_PRIORITY_value == "2"]
/*
#define NX_SNTP_CLIENT_PREEMPTION_THRESHOLD     NX_SNTP_CLIENT_THREAD_PRIORITY
*/
[#else]
#define NX_SNTP_CLIENT_PREEMPTION_THRESHOLD		${NX_SNTP_CLIENT_PREEMPTION_THRESHOLD_value}
[/#if]

/* This option sets the UDP socket name. The NetX Duo SNTP Client UDP socket
   name default is “SNTP Client socket”. */
[#if NX_SNTP_CLIENT_UDP_SOCKET_NAME_value == "SNTP Client socket"]
/*
#define NX_SNTP_CLIENT_UDP_SOCKET_NAME          "SNTP Client socket"
*/
[#else]
#define NX_SNTP_CLIENT_UDP_SOCKET_NAME			"${NX_SNTP_CLIENT_UDP_SOCKET_NAME_value}"
[/#if]

/* This sets the port which the Client socket is bound to. The default NetX
   Duo SNTP Client port is 123.  */
[#if NX_SNTP_CLIENT_UDP_PORT_value == "123"]
/*
#define NX_SNTP_CLIENT_UDP_PORT                 123
*/
[#else]
#define NX_SNTP_CLIENT_UDP_PORT					${NX_SNTP_CLIENT_UDP_PORT_value}
[/#if]

/* This is port which the Client sends SNTP messages to the SNTP Server on.
   The default NetX SNTP Server port is 123. */
[#if NX_SNTP_SERVER_UDP_PORT_value == "123"]
/*
#define NX_SNTP_SERVER_UDP_PORT                 123
*/
[#else]
#define NX_SNTP_SERVER_UDP_PORT					${NX_SNTP_SERVER_UDP_PORT_value}
[/#if]

/* Specifies the number of routers a Client packet can pass before it is
   discarded. The default NetX Duo SNTP Client is set to 0x80
   (NX_IP_TIME_TO_LIVE). */
[#if NX_SNTP_CLIENT_TIME_TO_LIVE_value == "0x00000080"]
/*
#define NX_SNTP_CLIENT_TIME_TO_LIVE             NX_IP_TIME_TO_LIVE
*/
[#else]
#define NX_SNTP_CLIENT_TIME_TO_LIVE 			${NX_SNTP_CLIENT_TIME_TO_LIVE_value}
[/#if]

/* Maximum number of UDP packets (datagrams) that can be queued in the NetX
   Duo SNTP Client socket. Additional packets received mean the oldest packets
   are released. The default NetX Duo SNTP Client is set to 5. */
[#if NX_SNTP_CLIENT_MAX_QUEUE_DEPTH_value == "5"]
/*
#define NX_SNTP_CLIENT_MAX_QUEUE_DEPTH          5
*/
[#else]
#define NX_SNTP_CLIENT_MAX_QUEUE_DEPTH 			${NX_SNTP_CLIENT_MAX_QUEUE_DEPTH_value}
[/#if]

/* Time out for NetX Duo packet allocation. The default NetX Duo SNTP Client
   packet timeout is 1 second. */
[#if NX_SNTP_CLIENT_PACKET_TIMEOUT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_SNTP_CLIENT_PACKET_TIMEOUT           (1 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_SNTP_CLIENT_PACKET_TIMEOUT 			${NX_SNTP_CLIENT_PACKET_TIMEOUT_value}
[/#if]

/* SNTP version used by the Client The NetX Duo SNTP Client API was based on
   Version 4. The default value is 3. */
[#if NX_SNTP_CLIENT_NTP_VERSION_value == "3"]
/*
#define NX_SNTP_CLIENT_NTP_VERSION              3
*/
[#else]
#define NX_SNTP_CLIENT_NTP_VERSION	 			${NX_SNTP_CLIENT_NTP_VERSION_value}
[/#if]

/* Oldest SNTP version the Client will be able to work with. The NetX Duo SNTP
   Client default is Version 3. */
[#if NX_SNTP_CLIENT_MIN_NTP_VERSION_value == "3"]
/*
#define NX_SNTP_CLIENT_MIN_NTP_VERSION          3
*/
[#else]
#define NX_SNTP_CLIENT_MIN_NTP_VERSION 			${NX_SNTP_CLIENT_MIN_NTP_VERSION_value}
[/#if]

/* The lowest level (highest numeric stratum level) SNTP Server stratum the
   Client will accept. The NetX Duo SNTP Client default is 2. */
[#if NX_SNTP_CLIENT_MIN_SERVER_STRATUM_value == "2"]
/*
#define NX_SNTP_CLIENT_MIN_SERVER_STRATUM       2
*/
[#else]
#define NX_SNTP_CLIENT_MIN_SERVER_STRATUM		${NX_SNTP_CLIENT_MIN_SERVER_STRATUM_value}
[/#if]

/* The minimum time adjustment in milliseconds the Client will make to its
   local clock time. Time adjustments below this will be ignored. The NetX
   Duo SNTP Client default is 10. */
[#if NX_SNTP_CLIENT_MIN_TIME_ADJUSTMENT_value == "10"]
/*
#define NX_SNTP_CLIENT_MIN_TIME_ADJUSTMENT      10
*/
[#else]
#define NX_SNTP_CLIENT_MIN_TIME_ADJUSTMENT		${NX_SNTP_CLIENT_MIN_TIME_ADJUSTMENT_value}
[/#if]

/* The maximum time adjustment in milliseconds the Client will make to its local
   clock time. For time adjustments above this amount, the local clock adjustment
   is limited to the maximum time adjustment. The NetX Duo SNTP Client default
   is 180000 (3 minutes). */
[#if NX_SNTP_CLIENT_MAX_TIME_ADJUSTMENT_value == "180000"]
/*
#define NX_SNTP_CLIENT_MAX_TIME_ADJUSTMENT      180000
*/
[#else]
#define NX_SNTP_CLIENT_MAX_TIME_ADJUSTMENT		${NX_SNTP_CLIENT_MAX_TIME_ADJUSTMENT_value}
[/#if]

/* This enables the maximum time adjustment to be waived when the Client
   receives the first update from its time server. Thereafter, the maximum
   time adjustment is enforced. The intention is to get the Client in synch
   with the server clock as soon as possible. The NetX Duo SNTP Client default
   is NX_TRUE. */
[#if NX_SNTP_CLIENT_IGNORE_MAX_ADJUST_STARTUP_value == "true"]
/*
#define NX_SNTP_CLIENT_IGNORE_MAX_ADJUST_STARTUP    NX_TRUE
*/
[#else]
#define NX_SNTP_CLIENT_IGNORE_MAX_ADJUST_STARTUP	0 /* NX_FALSE */
[/#if]

/* This determines if the SNTP Client in unicast mode should send its first SNTP
   request with the current SNTP server after a random wait interval. It is used
   in cases where significant numbers of SNTP Clients are starting up
   simultaneously to limit traffic congestion on the SNTP Server. The default
   value is NX_FALSE. */
[#if NX_SNTP_CLIENT_RANDOMIZE_ON_STARTUP_value == "false"]
/*
#define NX_SNTP_CLIENT_RANDOMIZE_ON_STARTUP     NX_FALSE
*/
[#else]
#define NX_SNTP_CLIENT_RANDOMIZE_ON_STARTUP		1 /* NX_TRUE */
[/#if]

/* Maximum allowable amount of time (seconds) elapsed without a valid time
   update received by the SNTP Client. The SNTP Client will continue in
   operation but the SNTP Server status is set to NX_FALSE. The default
   value is 7200. */
[#if NX_SNTP_CLIENT_MAX_TIME_LAPSE_value == "7200"]
/*
#define NX_SNTP_CLIENT_MAX_TIME_LAPSE           7200
*/
[#else]
#define NX_SNTP_CLIENT_MAX_TIME_LAPSE			${NX_SNTP_CLIENT_MAX_TIME_LAPSE_value}
[/#if]

/* The interval (seconds) at which the SNTP Client timer updates the SNTP Client
   time remaining since the last valid update received, and the unicast Client
   updates the poll interval time remaining before sending the next SNTP
   update request. The default value is 1. */
[#if NX_SNTP_UPDATE_TIMEOUT_INTERVAL_value == "1"]
/*
#define NX_SNTP_UPDATE_TIMEOUT_INTERVAL         1
*/
[#else]
#define NX_SNTP_UPDATE_TIMEOUT_INTERVAL			${NX_SNTP_UPDATE_TIMEOUT_INTERVAL_value}
[/#if]

/* The time interval during which the SNTP Client task sleeps. This allows the
   application API calls to be executed by the SNTP Client. The default value
   is 1 timer tick. */
[#if NX_SNTP_CLIENT_SLEEP_INTERVAL_value == "1"]
/*
#define NX_SNTP_CLIENT_SLEEP_INTERVAL           1
*/
[#else]
#define NX_SNTP_CLIENT_SLEEP_INTERVAL			${NX_SNTP_CLIENT_SLEEP_INTERVAL_value}
[/#if]

/* The starting poll interval (seconds) on which the Client sends a unicast
   request to its SNTP server. The NetX Duo SNTP Client default is 3600. */
[#if NX_SNTP_CLIENT_UNICAST_POLL_INTERVAL_value == "3600"]
/*
#define NX_SNTP_CLIENT_UNICAST_POLL_INTERVAL    3600
*/
[#else]
#define NX_SNTP_CLIENT_UNICAST_POLL_INTERVAL	${NX_SNTP_CLIENT_UNICAST_POLL_INTERVAL_value}
[/#if]

/* The factor by which the current Client unicast poll interval is increased.
   When the Client fails to receive a server time update, or receiving
   indications from the server that it is temporarily unavailable
   (e.g. not synchronized yet) for time update service, it will increase the
   current poll interval by this rate up to but not exceeding
   NX_SNTP_CLIENT_MAX_TIME_LAPSE. The default is 2. */
[#if NX_SNTP_CLIENT_EXP_BACKOFF_RATE_value == "2"]
/*
#define NX_SNTP_CLIENT_EXP_BACKOFF_RATE         2
*/
[#else]
#define NX_SNTP_CLIENT_EXP_BACKOFF_RATE			${NX_SNTP_CLIENT_EXP_BACKOFF_RATE_value}
[/#if]

/* This option if enabled requires that the SNTP Client calculate round trip
   time of SNTP messages when applying Server updates to the local clock.
   The default value is NX_FALSE (disabled). */
[#if NX_SNTP_CLIENT_RTT_REQUIRED_value == "false"]
/*
#define NX_SNTP_CLIENT_RTT_REQUIRED             NX_FALSE
*/
[#else]
#define NX_SNTP_CLIENT_RTT_REQUIRED				1  /* NX_TRUE */
[/#if]

/* The maximum server clock dispersion (microseconds), which is a measure of
   server clock precision, the Client will accept. To disable this requirement,
   set the maximum root dispersion to 0x0. The NetX Duo SNTP Client default is
   set to 50000. */
[#if NX_SNTP_CLIENT_MAX_ROOT_DISPERSION_value == "50000"]
/*
#define NX_SNTP_CLIENT_MAX_ROOT_DISPERSION      50000
*/
[#else]
#define NX_SNTP_CLIENT_MAX_ROOT_DISPERSION		${NX_SNTP_CLIENT_MAX_ROOT_DISPERSION_value}
[/#if]

/* The limit on the number of consecutive invalid updates received from the
   Client server in either broadcast or unicast mode. When this limit is
   reached, the Client sets the current SNTP Server status to invalid (NX_FALSE)
   although it will continue to try to receive updates from the Server.
   The NetX Duo SNTP Client default is 3. */
[#if NX_SNTP_CLIENT_INVALID_UPDATE_LIMIT_value == "3"]
/*
#define NX_SNTP_CLIENT_INVALID_UPDATE_LIMIT     3
*/
[#else]
#define NX_SNTP_CLIENT_INVALID_UPDATE_LIMIT		${NX_SNTP_CLIENT_INVALID_UPDATE_LIMIT_value}
[/#if]

/* To display date in year/month/date format, set this value to equal or less
   than current year (need not be same year as in NTP time being evaluated).
   The default value is 2015. */
[#if NX_SNTP_CURRENT_YEAR_value == "2015"]
/*
#define NX_SNTP_CURRENT_YEAR                    2015
*/
[#else]
#define NX_SNTP_CURRENT_YEAR					${NX_SNTP_CURRENT_YEAR_value}
[/#if]

/* This is the number of seconds into the first NTP Epoch on the master NTP
   clock. It is defined as 0xBA368E80. To disable display of NTP seconds into
   date and time, set to zero. */
[#if NTP_SECONDS_AT_01011999_value == "0xBA368E80"]
/*
#define NTP_SECONDS_AT_01011999                 0xBA368E80
*/
[#else]
#define NTP_SECONDS_AT_01011999					${NTP_SECONDS_AT_01011999_value}
[/#if]

/*****************************************************************************/
/****************** Configuration options for WEB HTTP ***********************/
/*****************************************************************************/

/* Type of service required for the HTTPS TCP requests. By default, this value
   is defined as NX_IP_NORMAL to indicate normal IP packet service. */
[#if NX_WEB_HTTP_TYPE_OF_SERVICE_value == "((ULONG)0x00000000)"]
/*
#define NX_WEB_HTTP_TYPE_OF_SERVICE             NX_IP_NORMAL
*/
[#else]
#define NX_WEB_HTTP_TYPE_OF_SERVICE				${NX_WEB_HTTP_TYPE_OF_SERVICE_value}
[/#if]

/* Fragment enable for HTTP TCP requests. By default, this value is
   NX_DONT_FRAGMENT to disable HTTP TCP fragmenting. */
[#if NX_WEB_HTTP_FRAGMENT_OPTION_value == "((ULONG)0x00004000)"]
/*
#define NX_WEB_HTTP_FRAGMENT_OPTION             NX_DONT_FRAGMENT
*/
[#else]
#define NX_WEB_HTTP_FRAGMENT_OPTION				${NX_WEB_HTTP_FRAGMENT_OPTION_value}
[/#if]

/* Specifies the number of routers this packet can pass before it is discarded.
   The default value is set to 0x80. */
[#if NX_WEB_HTTP_TIME_TO_LIVE_value == "0x80"]
/*
#define NX_WEB_HTTP_TIME_TO_LIVE                0x80
*/
[#else]
#define NX_WEB_HTTP_TIME_TO_LIVE				${NX_WEB_HTTP_TIME_TO_LIVE_value}
[/#if]

/* Specifies the number of bytes allowed in a client supplied resource name.
   The default value is set to 40. */
[#if NX_WEB_HTTP_MAX_RESOURCE_value == "40"]
/*
#define NX_WEB_HTTP_MAX_RESOURCE                40
*/
[#else]
#define NX_WEB_HTTP_MAX_RESOURCE				${NX_WEB_HTTP_MAX_RESOURCE_value}
[/#if]

/* Specifies the number of bytes allowed in a client supplied username.
   The default value is set to 20. */
[#if NX_WEB_HTTP_MAX_NAME_value == "20"]
/*
#define NX_WEB_HTTP_MAX_NAME                    20
*/
[#else]
#define NX_WEB_HTTP_MAX_NAME					${NX_WEB_HTTP_MAX_NAME_value}
[/#if]

/* Specifies the number of bytes allowed in a client supplied password.
   The default value is set to 20. */
[#if NX_WEB_HTTP_MAX_PASSWORD_value == "20"]
/*
#define NX_WEB_HTTP_MAX_PASSWORD                20
*/
[#else]
#define NX_WEB_HTTP_MAX_PASSWORD				${NX_WEB_HTTP_MAX_PASSWORD_value}
[/#if]

/* If defined, this macro enables TLS and HTTPS. Leave undefined to free up
   resources if only plain-text HTTP is desired. By default, this macro is not
   defined. */
[#if NX_WEB_HTTPS_ENABLE_value == "true"]
#define NX_WEB_HTTPS_ENABLE
[#else]
/*
#define NX_WEB_HTTPS_ENABLE
*/
[/#if]

/* If defined, authentication using the MD5 digest is enabled on the HTTPS
   Server. By default it is not defined. */
[#if NX_WEB_HTTP_DIGEST_ENABLE_value == "true"]
#define NX_WEB_HTTP_DIGEST_ENABLE
[#else]
/*
#define NX_WEB_HTTP_DIGEST_ENABLE
*/
[/#if]

/* Specifies the maximum size of the HTTP header field.
   The default value is 256. */
[#if NX_WEB_HTTP_MAX_HEADER_FIELD_value == "256"]
/*
#define NX_WEB_HTTP_MAX_HEADER_FIELD            256
*/
[#else]
#define NX_WEB_HTTP_MAX_HEADER_FIELD			${NX_WEB_HTTP_MAX_HEADER_FIELD_value}
[/#if]

/* Defined, this option provides a stub for FileX dependencies. The HTTPS Client
   will function without any change if this option is defined. The HTTPS Server
   will need to either be modified or the user will have to create a handful of
   FileX services in order to function properly. */
[#if NX_WEB_HTTP_NO_FILEX_value == "true"]
#define NX_WEB_HTTP_NO_FILEX
[#else]
/*
#define NX_WEB_HTTP_NO_FILEX
*/
[/#if]

/* The priority of the HTTPS Server thread. By default, this value is defined
   as 4 to specify priority 4. */
[#if NX_WEB_HTTP_SERVER_PRIORITY_value == "4"]
/*
#define NX_WEB_HTTP_SERVER_PRIORITY             4
*/
[#else]
#define NX_WEB_HTTP_SERVER_PRIORITY				${NX_WEB_HTTP_SERVER_PRIORITY_value}
[/#if]

/* Server socket window size. By default, this value is 8192. */
[#if NX_WEB_HTTP_SERVER_WINDOW_SIZE_value == "8192"]
/*
#define NX_WEB_HTTP_SERVER_WINDOW_SIZE          8192
*/
[#else]
#define NX_WEB_HTTP_SERVER_WINDOW_SIZE			${NX_WEB_HTTP_SERVER_WINDOW_SIZE_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_server_socket_accept() calls. The default value is
   set to (1 * NX_IP_PERIODIC_RATE). */
[#if NX_WEB_HTTP_SERVER_TIMEOUT_ACCEPT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_WEB_HTTP_SERVER_TIMEOUT_ACCEPT       (1 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_WEB_HTTP_SERVER_TIMEOUT_ACCEPT		${NX_WEB_HTTP_SERVER_TIMEOUT_ACCEPT_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_socket_receive() calls. The default value is set to
   10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_WEB_HTTP_SERVER_TIMEOUT_RECEIVE_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_WEB_HTTP_SERVER_TIMEOUT_RECEIVE      (10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_WEB_HTTP_SERVER_TIMEOUT_RECEIVE		${NX_WEB_HTTP_SERVER_TIMEOUT_RECEIVE_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_socket_send() calls. The default value is set to 10
   seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_WEB_HTTP_SERVER_TIMEOUT_SEND_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_WEB_HTTP_SERVER_TIMEOUT_SEND         (10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_WEB_HTTP_SERVER_TIMEOUT_SEND			${NX_WEB_HTTP_SERVER_TIMEOUT_SEND_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend
   for in internal nx_tcp_socket_disconnect() calls. The default value is set
   to 10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_WEB_HTTP_SERVER_TIMEOUT_DISCONNECT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_WEB_HTTP_SERVER_TIMEOUT_DISCONNECT   (10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_WEB_HTTP_SERVER_TIMEOUT_DISCONNECT	${NX_WEB_HTTP_SERVER_TIMEOUT_DISCONNECT_value}
[/#if]

/* Specifies the number of ThreadX ticks that internal services will suspend for.
   The default value is set to 10 seconds (10 * NX_IP_PERIODIC_RATE). */
[#if NX_WEB_HTTP_SERVER_TIMEOUT_value == "1000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_WEB_HTTP_SERVER_TIMEOUT              (10 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_WEB_HTTP_SERVER_TIMEOUT				${NX_WEB_HTTP_SERVER_TIMEOUT_value}
[/#if]

/* Specifies the number of simultaneous sessions for an HTTP or HTTPS Server.
   A TCP socket and a TLS session (if HTTPS is enabled) are allocated for each
   session. The default value is set to 2. */
[#if NX_WEB_HTTP_SERVER_SESSION_MAX_value == "2"]
/*
#define NX_WEB_HTTP_SERVER_SESSION_MAX          2
*/
[#else]
#define NX_WEB_HTTP_SERVER_SESSION_MAX			${NX_WEB_HTTP_SERVER_SESSION_MAX_value}
[/#if]

/* Specifies the number of connections that can be queued for the HTTPS Server.
   The default value is set to twice the maximum number of server sessions
   ((NX_WEB_HTTP_SERVER_SESSION_MAX << 1). */
[#if NX_WEB_HTTP_SERVER_MAX_PENDING_value == "4" && NX_WEB_HTTP_SERVER_SESSION_MAX_value == "2"]
/*
#define NX_WEB_HTTP_SERVER_MAX_PENDING          (NX_WEB_HTTP_SERVER_SESSION_MAX << 1)
*/
[#else]
#define NX_WEB_HTTP_SERVER_MAX_PENDING			${NX_WEB_HTTP_SERVER_MAX_PENDING_value}
[/#if]

/* The number of timer ticks the Server thread is allowed to run before yielding
   to threads of the same priority. The default value is 2. */
[#if NX_WEB_HTTP_SERVER_THREAD_TIME_SLICE_value == "2"]
/*
#define NX_WEB_HTTP_SERVER_THREAD_TIME_SLICE    2
*/
[#else]
#define NX_WEB_HTTP_SERVER_THREAD_TIME_SLICE 	${NX_WEB_HTTP_SERVER_THREAD_TIME_SLICE_value}
[/#if]

/* Specifies the minimum size of the packets in the pool specified at server
   creation. The minimum size is needed to ensure the complete HTTP header can
   be contained in one packet. The default value is set to 600. */
[#if NX_WEB_HTTP_SERVER_MIN_PACKET_SIZE_value == "600"]
/*
#define NX_WEB_HTTP_SERVER_MIN_PACKET_SIZE      600
*/
[#else]
#define NX_WEB_HTTP_SERVER_MIN_PACKET_SIZE	 	${NX_WEB_HTTP_SERVER_MIN_PACKET_SIZE_value}
[/#if]

/* Set the Server socket retransmission timeout in seconds. The default value
   is set to 2.*/
[#if NX_WEB_HTTP_SERVER_RETRY_SECONDS_value == "2"]
/*
#define NX_WEB_HTTP_SERVER_RETRY_SECONDS        2
*/
[#else]
#define NX_WEB_HTTP_SERVER_RETRY_SECONDS	 	${NX_WEB_HTTP_SERVER_RETRY_SECONDS_value}
[/#if]

/* This specifies the maximum number of packets that can be enqueued on the
   Server socket retransmission queue. If the number of packets enqueued
   reaches this number, no more packets can be sent until one or more enqueued
   packets are released. */
[#if NX_WEB_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH_value == "20"]
/*
#define NX_WEB_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH 	20
*/
[#else]
#define NX_WEB_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH		${NX_WEB_HTTP_SERVER_TRANSMIT_QUEUE_DEPTH_value}
[/#if]

/* This value is used to set the next retransmission timeout. The current
   timeout is multiplied by the number of retransmissions thus far, shifted
   by the value of the socket timeout shift. */
[#if NX_WEB_HTTP_SERVER_RETRY_SHIFT_value == "1"]
/*
#define NX_WEB_HTTP_SERVER_RETRY_SHIFT          1
*/
[#else]
#define NX_WEB_HTTP_SERVER_RETRY_SHIFT			${NX_WEB_HTTP_SERVER_RETRY_SHIFT_value}
[/#if]

/* If defined, enables HTTPS Server to support multipart HTTP requests. */
[#if NX_WEB_HTTP_MULTIPART_ENABLE_value == "true"]
#define NX_WEB_HTTP_MULTIPART_ENABLE
[#else]
/*
#define NX_WEB_HTTP_MULTIPART_ENABLE
*/
[/#if]

/* This sets the maximum number of retransmissions on Server socket. The default
   value is set to 10. */
[#if NX_WEB_HTTP_SERVER_RETRY_MAX_value == "10"]
/*
#define NX_WEB_HTTP_SERVER_RETRY_MAX            10
*/
[#else]
#define NX_WEB_HTTP_SERVER_RETRY_MAX			${NX_WEB_HTTP_SERVER_RETRY_MAX_value}
[/#if]

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif /* NX_USER_H */