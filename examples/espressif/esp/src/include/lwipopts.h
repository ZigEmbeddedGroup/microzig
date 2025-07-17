#ifndef LWIPOPTS_H
#define LWIPOPTS_H

/* ---------- System options ---------- */
#define NO_SYS                      1
#define SYS_LIGHTWEIGHT_PROT        0

/* ---------- Memory options ---------- */
#define MEM_LIBC_MALLOC             1     // Don't use malloc()
#define MEM_USE_POOLS               0     // No custom pools
#define MEM_USE_POOLS_TRY_BIGGER_POOL 0
#define MEMP_MEM_MALLOC             0     // Don't malloc pools
#define MEM_ALIGNMENT               4     // 32-bit CPU alignment
#define MEM_SIZE                    0     // No dynamic heap

/* ---------- PBUF options ---------- */
#define PBUF_POOL_SIZE              8     // Number of static pbufs
#define PBUF_POOL_BUFSIZE           512   // Size of each pbuf
#define PBUF_POOL_ALLOC_SRC         PBUF_ALLOC_SRC_INTERNAL

/* ---------- Raw API ---------- */
#define LWIP_RAW                    1
#define LWIP_NETCONN                0
#define LWIP_SOCKET                 0

#define LWIP_IPV4 1
#define LWIP_IPV6 1

#define LINK_STATS 0

#define LWIP_NETIF_LINK_CALLBACK 1
#define LWIP_NETIF_STATUS_CALLBACK 1
#define LWIP_NETIF_EXT_STATUS_CALLBACK 1

/* ---------- Protocol Support ---------- */
#define LWIP_ARP                    1
#define LWIP_ICMP                   1
#define LWIP_DHCP                   1      // Optional
#define LWIP_DNS                    1      // Optional
#define LWIP_TCP                    1
#define LWIP_UDP                    1

/* ---------- TCP options ---------- */
#define MEMP_NUM_TCP_PCB            4
#define MEMP_NUM_TCP_SEG            16
#define TCP_MSS                     1460
#define TCP_SND_BUF                 (2 * TCP_MSS)
#define TCP_WND                     (2 * TCP_MSS)

/* ---------- UDP options ---------- */
#define MEMP_NUM_UDP_PCB            2

/* ---------- Other MEMP pool sizes ---------- */
#define MEMP_NUM_PBUF               16
#define MEMP_NUM_NETCONN            0
#define MEMP_NUM_SYS_TIMEOUT        12     // Required for timers like DHCP

/* ---------- DNS ---------- */
#define MEMP_NUM_NETBUF             0
#define MEMP_NUM_API_MSG            0
#define MEMP_NUM_TCPIP_MSG_API      0
#define MEMP_NUM_TCPIP_MSG_INPKT    0

/* ---------- Debug options ---------- */
#define LWIP_DEBUG                  0

#endif /* LWIPOPTS_H */
