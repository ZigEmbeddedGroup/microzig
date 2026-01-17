#ifndef lwip__cc_h
#define lwip__cc_h

#include <stdbool.h>
#include <stdint.h>

typedef unsigned int sys_prot_t;

extern uint32_t lwip_rand(void);
extern void lwip_lock_core_mutex();
extern void lwip_unlock_core_mutex();
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
#define LWIP_PROVIDE_ERRNO 0

#define SYS_ARCH_DECL_PROTECT(lev) sys_prot_t lev
#define SYS_ARCH_PROTECT(lev) lwip_lock_core_mutex()
#define SYS_ARCH_UNPROTECT(lev) lwip_unlock_core_mutex()

#endif // lwip__cc_h
