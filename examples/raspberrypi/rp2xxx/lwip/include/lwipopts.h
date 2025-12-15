#ifndef ASHET_OS_lwipopts_h
#define ASHET_OS_lwipopts_h

#define NO_SYS 1 // we don't have an OS

#define LWIP_UDP 1
#define LWIP_TCP 1

#define LWIP_IPV4 1 // modern system requires both
#define LWIP_IPV6 1 // modern system requires both

#define LWIP_DHCP 1 // we want auto-setup

#define LWIP_SOCKET 0  // requires multi-threaded environments with os
#define LWIP_NETCONN 0 // requires multi-threaded environments with os

#define LWIP_IGMP LWIP_IPV4
#define LWIP_ICMP LWIP_IPV4
#define LWIP_DNS LWIP_UDP
#define LWIP_MDNS_RESPONDER LWIP_UDP

#define LWIP_NETIF_LINK_CALLBACK 1
#define LWIP_NETIF_STATUS_CALLBACK 1
#define LWIP_NETIF_EXT_STATUS_CALLBACK 1

#define LWIP_MPU_COMPATIBLE 0
#define LWIP_TCPIP_CORE_LOCKING 0

// This is the internal heap LWIP uses:
#define MEM_ALIGNMENT 4
#define MEM_SIZE 100000 // configure peak memory usage here

#define MEMP_NUM_PBUF 200 // packet buffers

// limits for number of sockets:
#define MEMP_NUM_RAW_PCB 64
#define MEMP_NUM_UDP_PCB 64
#define MEMP_NUM_TCP_PCB 64
#define MEMP_NUM_TCP_PCB_LISTEN 64

#define LINK_STATS 1
#define LWIP_STATS 1
#define MEM_STATS 1
#define MEMP_STATS 1

// #define LWIP_ARP 1
// #define LWIP_ETHERNET 1

#endif // ASHET_OS_lwipopts_h
