#ifndef ASHET_OS_cc_h
#define ASHET_OS_cc_h

#include <stdbool.h>
#include <stdint.h>

typedef unsigned int sys_prot_t;

// ashet apis, implemented in src/main.zig:
extern void net_lock_interrupts(bool *state);
extern void net_unlock_interrupts(bool state);
extern uint32_t net_rand(void);
extern uint32_t __aeabi_read_tp(void);

#define LWIP_PLATFORM_DIAG(x)   // TODO: Implement these
#define LWIP_PLATFORM_ASSERT(x) // TODO: Implement these

#define BYTE_ORDER LITTLE_ENDIAN

#define LWIP_RAND() ((u32_t)net_rand())

#define LWIP_NO_STDDEF_H 0
#define LWIP_NO_STDINT_H 0
#define LWIP_NO_INTTYPES_H 1
#define LWIP_NO_LIMITS_H 0
#define LWIP_NO_CTYPE_H 1

#define LWIP_UNUSED_ARG(x) (void)x
#define LWIP_PROVIDE_ERRNO 1

// Critical section support:
// https://www.nongnu.org/lwip/2_1_x/group__sys__prot.html

#define SYS_ARCH_DECL_PROTECT(lev) bool lev
#define SYS_ARCH_PROTECT(lev) net_lock_interrupts(&lev)
#define SYS_ARCH_UNPROTECT(lev) net_unlock_interrupts(lev)

#endif // ASHET_OS_cc_h
