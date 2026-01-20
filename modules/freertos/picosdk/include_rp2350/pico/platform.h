#ifndef _PICO_PLATFORM_H
#define _PICO_PLATFORM_H

#include "pico/platform/compiler.h"
#include "pico/platform/common.h"
#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"

__force_inline static uint get_core_num(void) {
    return (*(uint32_t *) (SIO_BASE + SIO_CPUID_OFFSET));
}

static __force_inline uint __get_current_exception(void) {
#ifdef __riscv
    uint32_t meicontext;
    pico_default_asm_volatile (
            "csrr %0, %1\n"
    : "=r" (meicontext) : "i" (RVCSR_MEICONTEXT_OFFSET)
    );
    if (meicontext & RVCSR_MEICONTEXT_NOIRQ_BITS) {
        return 0;
    } else {
        return VTABLE_FIRST_IRQ + (
                (meicontext & RVCSR_MEICONTEXT_IRQ_BITS) >> RVCSR_MEICONTEXT_IRQ_LSB
        );
    }
#else
    uint exception;
    pico_default_asm_volatile (
        "mrs %0, ipsr\n"
        "uxtb %0, %0\n"
        : "=l" (exception)
    );
    return exception;
#endif
}

#endif