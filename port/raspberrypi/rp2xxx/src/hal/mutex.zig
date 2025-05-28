const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");

const Spinlock = microzig.hal.multicore.Spinlock;

/// Multicore safe mutex.  This mutex is protected by a spinlock in addition to
/// a critical section.  It can be used to protect shared resources from being
/// accessed by multiple cores.
///
/// It is NOT safe to use in code that could be suspended on one core and
/// resumed on another.
///
pub const Mutex = struct {

    // A critical section that is used to protect the mutex.  Will be
    // null if the mutex is not locked.
    critical_section: ?microzig.interrupt.CriticalSection = null,

    // A spinlock that is used to protect the mutex from concurrent access.
    spinlock: Spinlock = .mutexes,

    // The core that currently holds the mutex.
    core: ?u8 = null,

    // Set to true to enable interrupts when the mutex is locked.
    enable_interrupts: bool = false,

    /// Initialize the mutex.
    /// Parameters:
    /// - `params`: Mutex configuration parameters.
    pub fn init(params: anytype) Mutex {
        _ = params;
        return .{};
    }

    /// Try to lock the mutex.
    /// Returns true if the mutex was acquired, false if the mutex
    /// was not acquired.
    pub fn try_lock(self: *Mutex) bool {
        // acquire the spinlock and disable interrupts
        const cs = self.spinlock.lock_irq();

        if (self.critical_section != null) {
            // The mutex is already locked release the spinlock and restore interrupts.
            self.spinlock.unlock_irq(cs);
            return false;
        }

        // Good to go. Record the core id and critical section but release the spinlock.
        self.core = @intCast(microzig.hal.get_cpu_id());
        self.critical_section = cs;

        if (self.enable_interrupts) {
            self.spinlock.unlock_irq(cs);
        } else {
            self.spinlock.unlock(); // critical section will be released in unlock
        }

        return true;
    }

    /// Lock the mutex.
    /// If the mutex is held by the same core it will panic.
    /// If the mutex is held by the other core we will wait until the mutex becomes available.
    pub fn lock(self: *Mutex) void {
        while (!self.try_lock()) {
            if (self.core != null and self.core.? == microzig.hal.get_cpu_id()) {
                @panic("mutex already locked by this core");
            }

            microzig.cpu.wfe();
        }
    }

    /// Unlock the mutex by leaving the critical section
    pub fn unlock(self: *Mutex) void {
        self.spinlock.lock();
        self.core = null;

        if (self.critical_section) |cs| {
            self.critical_section = null;

            if (self.enable_interrupts) {
                self.spinlock.unlock(); // interrupts were unlocked in try_lock
            } else {
                self.spinlock.unlock_irq(cs);
            }

            microzig.cpu.sev();
        }
    }
};
