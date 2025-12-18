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

#define PBUF_POOL_SIZE 64      // the number of buffers in the pbuf pool.
#define PBUF_POOL_BUFSIZE 1536 //  the size of each pbuf in the pbuf pool // 256

// #define IP_REASSEMBLY 0

/* #define IP_REASSEMBLY 1 */
/* #define IP_REASS_MAXAGE 1 */
/* #define IP_REASS_MAX_PBUFS 32 */
/* //    (10 * ((1500 + PBUF_POOL_BUFSIZE - 1) / PBUF_POOL_BUFSIZE)) */
/* #define MEMP_NUM_REASSDATA IP_REASS_MAX_PBUFS / 2 */
/* #define IP_FRAG 1 */
/* #define MEMP_NUM_SYS_TIMEOUT 64 */
// #define IPV6_FRAG_COPYHEADER 1

/* #define LWIP_ICMP_ECHO 1 */
/* #define LWIP_ARP 1 */
/* #define LWIP_ETHERNET 1 */

// This is the internal heap LWIP uses:
#define MEM_ALIGNMENT 4
#define MEM_SIZE 65536 // configure peak memory usage here

#define MEMP_NUM_PBUF 200 // packet buffers

// limits for number of sockets:
#define MEMP_NUM_RAW_PCB 64
#define MEMP_NUM_UDP_PCB 64
#define MEMP_NUM_TCP_PCB 64
#define MEMP_NUM_TCP_PCB_LISTEN 64

/* #define MEMP_NUM_TCP_SEG 63 */
/* #define MEMP_NUM_SYS_TIMEOUT 62 */
/* #define MEMP_NUM_NETBUF 61 */
/* #define MEMP_NUM_NETCONN 59 */
/* #define MEMP_NUM_TCPIP_MSG_API 58 */
/* #define MEMP_NUM_TCPIP_MSG_INPKT 57 */

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

// #define LWIP_NOASSERT 1

#endif // ASHET_OS_lwipopts_h
