#ifndef _HARDWARE_SYNC_H
#define _HARDWARE_SYNC_H

#include "pico.h"
#include "hardware/address_mapped.h"

#ifndef PARAM_ASSERTIONS_ENABLED_HARDWARE_SYNC
#ifdef PARAM_ASSERTIONS_ENABLED_SYNC // backwards compatibility with SDK < 2.0.0
#define PARAM_ASSERTIONS_ENABLED_HARDWARE_SYNC PARAM_ASSERTIONS_ENABLED_SYNC
#else
#define PARAM_ASSERTIONS_ENABLED_HARDWARE_SYNC 0
#endif
#endif

#if !__has_builtin(__sev)
__force_inline static void __sev(void) {
#ifdef __riscv
    __hazard3_unblock();
#else
    pico_default_asm_volatile ("sev");
#endif
}
#endif

/*! \brief Insert a WFE instruction in to the code path.
 *  \ingroup hardware_sync
 *
 * The WFE (wait for event) instruction waits until one of a number of
 * events occurs, including events signalled by the SEV instruction on either core.
 */
#if !__has_builtin(__wfe)
__force_inline static void __wfe(void) {
#ifdef __riscv
    __hazard3_block();
#else
    pico_default_asm_volatile ("wfe");
#endif
}
#endif

/*! \brief Insert a DMB instruction in to the code path.
 *  \ingroup hardware_sync
 *
 * The DMB (data memory barrier) acts as a memory barrier, all memory accesses prior to this
 * instruction will be observed before any explicit access after the instruction.
 */
__force_inline static void __dmb(void) {
#ifdef __riscv
    __asm volatile ("fence rw, rw" : : : "memory");
#else
    pico_default_asm_volatile ("dmb" : : : "memory");
#endif
}

__force_inline static void __mem_fence_acquire(void) {
    // the original code below makes it hard for us to be included from C++ via a header
    // which itself is in an extern "C", so just use __dmb instead, which is what
    // is required on Cortex M0+
    __dmb();
//#ifndef __cplusplus
//    atomic_thread_fence(memory_order_acquire);
//#else
//    std::atomic_thread_fence(std::memory_order_acquire);
//#endif
}

__force_inline static void __mem_fence_release(void) {
    // the original code below makes it hard for us to be included from C++ via a header
    // which itself is in an extern "C", so just use __dmb instead, which is what
    // is required on Cortex M0+
    __dmb();
//#ifndef __cplusplus
//    atomic_thread_fence(memory_order_release);
//#else
//    std::atomic_thread_fence(std::memory_order_release);
//#endif
}

uint next_striped_spin_lock_num(void);

void spin_lock_claim(uint lock_num);

__force_inline static void restore_interrupts_from_disabled(uint32_t status) {
    // on ARM, this behaves the same as restore_interrupts()
    pico_default_asm_volatile ("msr PRIMASK,%0"::"r" (status) : "memory" );
}

#include "hardware/sync/spin_lock.h"

#endif