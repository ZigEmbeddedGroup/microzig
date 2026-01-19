#ifndef _PICO_PLATFORM_H
#define _PICO_PLATFORM_H

#include "pico/platform/compiler.h"
#include "pico/platform/common.h"
#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"

__force_inline static uint get_core_num(void) {
    return (*(uint32_t *) (SIO_BASE + SIO_CPUID_OFFSET));
}

void __attribute__((noreturn)) panic_unsupported(void);

static __force_inline uint __get_current_exception(void) {
    uint exception;
    pico_default_asm_volatile ( "mrs %0, ipsr" : "=l" (exception));
    return exception;
}

#endif