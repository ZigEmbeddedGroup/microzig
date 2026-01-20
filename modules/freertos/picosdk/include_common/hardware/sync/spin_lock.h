#ifndef _HARDWARE_SYNC_SPIN_LOCK_H
#define _HARDWARE_SYNC_SPIN_LOCK_H

#include "pico.h"

// PICO_CONFIG: PICO_SPINLOCK_ID_OS1, First Spinlock ID reserved for use by low level OS style software, min=0, max=31, default=14, group=hardware_sync
#ifndef PICO_SPINLOCK_ID_OS1
#define PICO_SPINLOCK_ID_OS1 14
#endif

// PICO_CONFIG: PICO_SPINLOCK_ID_OS2, Second Spinlock ID reserved for use by low level OS style software, min=0, max=31, default=15, group=hardware_sync
#ifndef PICO_SPINLOCK_ID_OS2
#define PICO_SPINLOCK_ID_OS2 15
#endif

typedef io_rw_32 spin_lock_t;

__force_inline static spin_lock_t *spin_lock_instance(uint lock_num) {
    invalid_params_if(HARDWARE_SYNC, lock_num >= NUM_SPIN_LOCKS);
#if PICO_USE_SW_SPIN_LOCKS
    return SW_SPIN_LOCK_INSTANCE(lock_num);
#else
    return (spin_lock_t *) (SIO_BASE + SIO_SPINLOCK0_OFFSET + lock_num * 4);
#endif
}

__force_inline static void spin_lock_unsafe_blocking(spin_lock_t *lock) {
    // Note we don't do a wfe or anything, because by convention these spin_locks are VERY SHORT LIVED and NEVER BLOCK and run
    // with INTERRUPTS disabled (to ensure that)... therefore nothing on our core could be blocking us, so we just need to wait on another core
    // anyway which should be finished soon
#if PICO_USE_SW_SPIN_LOCKS
    SW_SPIN_LOCK_LOCK(lock);
#else
    while (__builtin_expect(!*lock, 0)) { // read from spinlock register (tries to acquire the lock)
        tight_loop_contents();
    }
    __mem_fence_acquire();
#endif
}

__force_inline static bool spin_try_lock_unsafe(spin_lock_t *lock) {
#if PICO_USE_SW_SPIN_LOCKS
    return SW_SPIN_TRY_LOCK(lock);
#else
    return *lock;
#endif
}

__force_inline static void spin_unlock_unsafe(spin_lock_t *lock) {
#if PICO_USE_SW_SPIN_LOCKS
    SW_SPIN_LOCK_UNLOCK(lock);
#else
    __mem_fence_release();
    *lock = 0; // write to spinlock register (release lock)
#endif
}

__force_inline static void spin_unlock(spin_lock_t *lock, uint32_t saved_irq) {
    spin_unlock_unsafe(lock);
    restore_interrupts_from_disabled(saved_irq);
}

__force_inline static uint spin_lock_get_num(spin_lock_t *lock) {
#if PICO_USE_SW_SPIN_LOCKS
    uint lock_num = SW_SPIN_LOCK_NUM(lock);
    invalid_params_if(HARDWARE_SYNC, lock_num >= (uint)NUM_SPIN_LOCKS);
    return lock_num;
#else
    invalid_params_if(HARDWARE_SYNC, (uint) lock < SIO_BASE + SIO_SPINLOCK0_OFFSET ||
                            (uint) lock >= NUM_SPIN_LOCKS * sizeof(spin_lock_t) + SIO_BASE + SIO_SPINLOCK0_OFFSET ||
                            ((uint) lock - SIO_BASE + SIO_SPINLOCK0_OFFSET) % sizeof(spin_lock_t) != 0);
    return (uint) (lock - (spin_lock_t *) (SIO_BASE + SIO_SPINLOCK0_OFFSET));
#endif
}

#endif