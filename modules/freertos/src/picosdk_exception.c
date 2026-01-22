#include "hardware/exception.h"
#include "hardware/sync.h"
#include "pico/platform/cpu_regs.h"

static inline void check_exception_param(__unused enum exception_number num) {
    invalid_params_if(HARDWARE_EXCEPTION, num < MIN_EXCEPTION_NUM || num > MAX_EXCEPTION_NUM);
}

static inline exception_handler_t *get_exception_table(void) {
#ifdef __riscv
    extern uintptr_t __riscv_exception_table;
    return (exception_handler_t *) &__riscv_exception_table;
#else
    return (exception_handler_t *) scb_hw->vtor;
#endif
}

exception_handler_t exception_get_vtable_handler(enum exception_number num) {
    check_exception_param(num);
    return get_exception_table()[num];
}

#if !PICO_NO_RAM_VECTOR_TABLE
static void set_raw_exception_handler_and_restore_interrupts(enum exception_number num, exception_handler_t handler, uint32_t save) {
    // update vtable (vtable_handler may be same or updated depending on cases, but we do it anyway for compactness)
    get_exception_table()[num] = handler;
    __dmb();
    restore_interrupts_from_disabled(save);
}
#endif

exception_handler_t exception_set_exclusive_handler(enum exception_number num, exception_handler_t handler) {
    check_exception_param(num);
#if !PICO_NO_RAM_VECTOR_TABLE
    uint32_t save = save_and_disable_interrupts();
    exception_handler_t current = exception_get_vtable_handler(num);
    //hard_assert(handler == current || exception_is_compile_time_default(current));
    set_raw_exception_handler_and_restore_interrupts(num, handler, save);
    return current;
#else
    ((void)num);
    ((void)handler);
    panic_unsupported();
#endif
}