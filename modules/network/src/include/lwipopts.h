// all available options:
// https://github.com/lwip-tcpip/lwip/blob/STABLE-2_1_3_RELEASE/src/include/lwip/opt.h
//
#ifndef lwipopts_h
#define lwipopts_h

// freestanding envrionment
#define NO_SYS 1       // we don't have an OS
#define LWIP_SOCKET 0  // requires multi-threaded environments with os
#define LWIP_NETCONN 0 // requires multi-threaded environments with os
#define LWIP_MPU_COMPATIBLE 0
#define LWIP_TCPIP_CORE_LOCKING 0

// features
#define LWIP_IPV4 1
#define LWIP_IPV6 1
#define LWIP_UDP 1
#define LWIP_TCP 1
#define LWIP_DHCP 1
#define LWIP_IGMP LWIP_IPV4
#define LWIP_ICMP LWIP_IPV4
#define LWIP_DNS LWIP_UDP
#define LWIP_MDNS_RESPONDER LWIP_UDP

// callbacks
#define LWIP_NETIF_LINK_CALLBACK 0
#define LWIP_NETIF_STATUS_CALLBACK 1
#define LWIP_NETIF_EXT_STATUS_CALLBACK 0

// stats
#define LWIP_STATS 1
#define LINK_STATS 1
#define IP_STATS 1
#define ICMP_STATS 1
#define IGMP_STATS 1
#define IPFRAG_STATS 1
#define UDP_STATS 1
#define TCP_STATS 1
#define MEM_STATS 1
#define MEMP_STATS 1
#define PBUF_STATS 1
#define SYS_STATS 1

#endif // lwipopts_h
