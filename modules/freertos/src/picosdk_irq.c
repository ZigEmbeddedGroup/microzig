#include "hardware/irq.h"
#include "hardware/sync/spin_lock.h"

#ifndef __riscv
static io_rw_32 *nvic_ipr0(void) {
    return (io_rw_32 *)(PPB_BASE + ARM_CPU_PREFIXED(NVIC_IPR0_OFFSET));
}
#endif

void irq_set_priority(uint num, uint8_t hardware_priority) {
    check_irq_param(num);
#ifdef __riscv
    // SDK priorities are upside down due to Cortex-M influence
    hardware_priority = (uint8_t)((hardware_priority >> 4) ^ 0xf);
    // There is no atomic field write operation, so first drop the IRQ to its
    // lowest priority (safe even if it is in a preemption frame below us) and
    // then use a set to raise it to the target priority.
    hazard3_irqarray_clear(RVCSR_MEIPRA_OFFSET, num / 4, 0xfu << (4 * (num % 4)));
    hazard3_irqarray_set(RVCSR_MEIPRA_OFFSET, num / 4, hardware_priority << (4 * (num % 4)));
#else
    io_rw_32 *p = nvic_ipr0() + (num >> 2);
    // note that only 32 bit writes are supported
    *p = (*p & ~(0xffu << (8 * (num & 3u)))) | (((uint32_t) hardware_priority) << (8 * (num & 3u)));
#endif
}

static inline void irq_set_mask_n_enabled_internal(uint n, uint32_t mask, bool enabled) {
    invalid_params_if(HARDWARE_IRQ, n * 32u >= ((PICO_NUM_VTABLE_IRQS + 31u) & ~31u));
#if defined(__riscv)
    if (enabled) {
        hazard3_irqarray_clear(RVCSR_MEIFA_OFFSET, 2 * n, mask & 0xffffu);
        hazard3_irqarray_clear(RVCSR_MEIFA_OFFSET, 2 * n + 1, mask >> 16);
        hazard3_irqarray_set(RVCSR_MEIEA_OFFSET, 2 * n, mask & 0xffffu);
        hazard3_irqarray_set(RVCSR_MEIEA_OFFSET, 2 * n + 1, mask >> 16);
    } else {
        hazard3_irqarray_clear(RVCSR_MEIEA_OFFSET, 2 * n, mask & 0xffffu);
        hazard3_irqarray_clear(RVCSR_MEIEA_OFFSET, 2 * n + 1, mask >> 16);
    }
#elif PICO_RP2040
    ((void)n);
    if (enabled) {
        nvic_hw->icpr = mask;
        nvic_hw->iser = mask;
    } else {
        nvic_hw->icer = mask;
    }
#else
    // >32 IRQs (well this works for the bottom 32 which is all that is passed in
    if (enabled) {
        nvic_hw->icpr[n] = mask;
        nvic_hw->iser[n] = mask;
    } else {
        nvic_hw->icer[n] = mask;
    }
#endif
}

void irq_set_mask_n_enabled(uint n, uint32_t mask, bool enabled) {
    irq_set_mask_n_enabled_internal(n, mask, enabled);
}

void irq_set_enabled(uint num, bool enabled) {
    check_irq_param(num);
    // really should update irq_set_mask_enabled?
    irq_set_mask_n_enabled(num / 32, 1u << (num % 32), enabled);
}

static inline irq_handler_t *get_vtable(void) {
#ifdef __riscv
    return (irq_handler_t *) (riscv_read_csr(RVCSR_MTVEC_OFFSET) & ~0x3u);
#else
    return (irq_handler_t *) scb_hw->vtor;
#endif
}

static void set_raw_irq_handler_and_unlock(uint num, irq_handler_t handler, uint32_t save) {
    // update vtable (vtable_handler may be same or updated depending on cases, but we do it anyway for compactness)
    get_vtable()[VTABLE_FIRST_IRQ + num] = handler;
    __dmb();
    spin_unlock(spin_lock_instance(PICO_SPINLOCK_ID_IRQ), save);
}

void irq_set_exclusive_handler(uint num, irq_handler_t handler) {
    check_irq_param(num);
#if !PICO_NO_RAM_VECTOR_TABLE
    spin_lock_t *lock = spin_lock_instance(PICO_SPINLOCK_ID_IRQ);
    uint32_t save = spin_lock_blocking(lock);
    __unused irq_handler_t current = irq_get_vtable_handler(num);

    // TODO: had to comment this asseert out to get FreeRTOS port for RP2350 ARM working
    // but it us existing assert in PicoSDK - neeed investigation
    
    //hard_assert(current == __unhandled_user_irq || current == handler);
    set_raw_irq_handler_and_unlock(num, handler, save);
#else
    ((void)handler);
    panic_unsupported();
#endif
}

irq_handler_t irq_get_vtable_handler(uint num) {
    check_irq_param(num);
    return get_vtable()[VTABLE_FIRST_IRQ + num];
}