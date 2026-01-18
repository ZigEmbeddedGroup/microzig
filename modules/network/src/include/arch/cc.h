#ifndef lwip__cc_h
#define lwip__cc_h

#include <stdbool.h>
#include <stdint.h>

typedef unsigned int sys_prot_t;

// Platform dependent methods, needs to be implemented for each chip.
extern uint32_t lwip_rand(void);
extern uint32_t lwip_sys_now(void);

// Implemented in network/root.zig
extern void lwip_lock_interrupts(bool *state);
extern void lwip_unlock_interrupts(bool state);
extern void lwip_assert(const char *msg, const char *file, int line);
extern void lwip_diag(const char *msg, const char *file, int line);

#define LWIP_PLATFORM_DIAG(x)                                                  \
    do {                                                                       \
        lwip_diag((msg), __FILE__, __LINE__);                                  \
    } while (0)
#define LWIP_PLATFORM_ASSERT(msg)                                              \
    do {                                                                       \
        lwip_assert((msg), __FILE__, __LINE__);                                \
    } while (0)

#define BYTE_ORDER LITTLE_ENDIAN

#define LWIP_RAND() ((u32_t)lwip_rand())

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
#define SYS_ARCH_PROTECT(lev) lwip_lock_interrupts(&lev)
#define SYS_ARCH_UNPROTECT(lev) lwip_unlock_interrupts(lev)

// Rename sys_now to lwip_sys_now
// https://github.com/lwip-tcpip/lwip/blob/6ca936f6b588cee702c638eee75c2436e6cf75de/src/include/lwip/sys.h#L446
#define sys_now lwip_sys_now

#endif // lwip__cc_h
