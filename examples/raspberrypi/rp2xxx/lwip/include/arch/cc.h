#ifndef ASHET_OS_cc_h
#define ASHET_OS_cc_h

#include <stdbool.h>
#include <stdint.h>

typedef unsigned int sys_prot_t;

/* uint32_t __aeabi_read_tp(void) { */
/*     // If no TLS, just return 0 or implement as needed */
/*     return 0; */
/* } */

/* sys_prot_t sys_arch_protect(void); // disables interrupts & returns key/state
 */
/* void sys_arch_unprotect(sys_prot_t p); // restores interrupts */

// ashet apis, implemented in src/main.zig:
extern void ashet_lockInterrupts(bool *state);
extern void ashet_unlockInterrupts(bool state);
extern uint32_t ashet_rand(void);
extern uint32_t __aeabi_read_tp(void);

#define LWIP_PLATFORM_DIAG(x)   // TODO: Implement these
#define LWIP_PLATFORM_ASSERT(x) // TODO: Implement these

#define BYTE_ORDER LITTLE_ENDIAN

#define LWIP_RAND() ((u32_t)ashet_rand())

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
#define SYS_ARCH_PROTECT(lev) ashet_lockInterrupts(&lev)
#define SYS_ARCH_UNPROTECT(lev) ashet_unlockInterrupts(lev)

#endif // ASHET_OS_cc_h
