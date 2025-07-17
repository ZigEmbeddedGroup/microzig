#ifndef LWIP_ARCH_CC_H
#define LWIP_ARCH_CC_H

#include <stdbool.h>
#include <stdint.h>

extern uint32_t rand(void);

#define LWIP_PLATFORM_DIAG(x)   // TODO: Implement these
#define LWIP_PLATFORM_ASSERT(x) // TODO: Implement these

#define BYTE_ORDER LITTLE_ENDIAN

#define LWIP_RAND() (rand())

#define LWIP_NO_STDDEF_H 0
#define LWIP_NO_STDINT_H 0
#define LWIP_NO_INTTYPES_H 1
#define LWIP_NO_LIMITS_H 0
#define LWIP_NO_CTYPE_H 1

#define LWIP_UNUSED_ARG(x) (void)x
#define LWIP_PROVIDE_ERRNO 1

/* ---------- No Protection Needed ---------- */

#define SYS_ARCH_DECL_PROTECT(lev)
#define SYS_ARCH_PROTECT(lev)
#define SYS_ARCH_UNPROTECT(lev)

#endif /* LWIP_ARCH_CC_H */
