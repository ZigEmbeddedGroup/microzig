// picosdk_stubs.c — Pico SDK function stubs for the FreeRTOS port.
//
// The FreeRTOS RP2040/RP2350 port references these Pico SDK functions,
// which are not provided by MicroZig. These minimal stubs satisfy the
// linker for single-core FreeRTOS usage.
//
// See: https://github.com/ZigEmbeddedGroup/microzig/issues/880

#include <stdint.h>
#include <stdbool.h>

// ── IRQ / Panic ─────────────────────────────────────────────────────────
// Default handlers that halt immediately. A debugger will stop here.

// Fallback for unhandled user IRQs — traps immediately so a debugger
// catches the fault rather than silently continuing.
void __unhandled_user_irq(void) {
    __builtin_trap();
}

// Called by the Pico SDK when an unsupported operation is attempted.
// Traps immediately to surface the error during development.
void panic_unsupported(void) {
    __builtin_trap();
}

// ── Multicore (no-ops for single-core FreeRTOS) ─────────────────────────
// The RP2350 port references multicore symbols even in single-core mode
// because LIB_PICO_MULTICORE=1 is required for compilation.

// No-op stub — core 1 is never launched in single-core FreeRTOS mode.
void multicore_launch_core1(void (*entry)(void)) {
    (void)entry;
}

// No-op stub — core 1 is never used, so nothing to reset.
void multicore_reset_core1(void) {
}

// Always returns false — doorbells are not available without the full Pico SDK
// multicore runtime. The `required` flag is ignored; callers must handle failure.
int multicore_doorbell_claim_unused(uint32_t *doorbell, bool required) {
    (void)doorbell;
    (void)required;
    return 0;
}

// ── Clocks ──────────────────────────────────────────────────────────────
// Returns the system clock frequency for the target chip.
// The FreeRTOS port uses this to configure the SysTick timer.

// Returns the default system clock: 125 MHz for RP2040, 150 MHz for RP2350.
// The clock_id parameter is ignored — we always return the system clock.
uint32_t clock_get_hz(uint32_t clock_id) {
    (void)clock_id;
#if defined(PICO_RP2040) && PICO_RP2040
    return 125000000u;
#else
    return 150000000u;
#endif
}

// ── Spinlocks ───────────────────────────────────────────────────────────
// The port claims spinlocks for internal synchronization.
// These stubs are safe because hardware spinlocks are managed by MicroZig.

// No-op — spin locks are managed by hardware and don't need software claiming
// in single-core mode. The lock_num is ignored.
void spin_lock_claim(unsigned int lock_num) {
    (void)lock_num;
}

// Returns sequential lock numbers for the FreeRTOS port, which expects unique
// values per lock. The counter starts at 16 to avoid conflicting with
// low-numbered locks (0–15) reserved by the Pico SDK and hardware.
unsigned int next_striped_spin_lock_num(void) {
    return 16;
}
