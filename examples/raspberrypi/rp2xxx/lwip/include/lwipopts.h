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

// memory
#define MEM_ALIGNMENT 4
#define MEM_SIZE (32 * 1024) // limit of dynamic mem alloc

#define PBUF_POOL_SIZE 32      // number of preallocated buffers
#define PBUF_POOL_BUFSIZE 1540 // enough for 1500 MTU + headers (14 + 22 + 4)
#define PBUF_LINK_HLEN 14
#define PBUF_LINK_ENCAPSULATION_HLEN 22 // CYW43 WiFi header space
// #define LWIP_NETIF_TX_SINGLE_PBUF 1  // reject chained TX (if available)

#define MEMP_NUM_PBUF 32
#define MEMP_NUM_RAW_PCB 32
#define MEMP_NUM_TCP_PCB 8
#define MEMP_NUM_TCP_SEG 32
#define MEMP_NUM_UDP_PCB 8
#define MEMP_NUM_SYS_TIMEOUT 16

// callbacks
#define LWIP_NETIF_LINK_CALLBACK 1
#define LWIP_NETIF_STATUS_CALLBACK 1
#define LWIP_NETIF_EXT_STATUS_CALLBACK 1

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
