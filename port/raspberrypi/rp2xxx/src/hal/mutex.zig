const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");

const Spinlock = microzig.hal.multicore.Spinlock;

/// Multicore safe mutex.
pub const Mutex = struct {
    available: bool = true,
    spinlock: Spinlock = .mutexes,

    /// Try to lock the mutex.
    /// Returns true if the mutex was acquired, false if the mutex
    /// was not acquired.
    pub fn try_lock(self: *Mutex) bool {
        const critical_section = self.spinlock.lock_irq();
        defer self.spinlock.unlock_irq(critical_section);

        if (self.available) {
            self.available = false;
            return true;
        }

        return false;
    }

    /// Lock the mutex.
    /// If the mutex cannot be acquired, this function will busy wait until
    /// the mutex is available.
    pub fn lock(self: *Mutex) void {
        while (!self.try_lock()) {}
    }

    /// Unlock the mutex.
    pub fn unlock(self: *Mutex) void {
        // Note: no need for critical section here as this operation
        // is inherently atomic.
        self.available = true;
    }
};

/// This mutex can only be acquired by one core at a time.  It can be
/// acquired more than once by the same core but must be released the same
/// number of times it was acquired before the other core can acquire it.
pub const CoreMutex = struct {
    count: usize = 0,
    spinlock: Spinlock = .mutexes,
    owning_core: u32 = 0,

    /// Try to acquire the mutex.
    /// Returns true if the mutex was acquired, false if the mutex
    /// is not available.
    pub fn try_lock(self: *CoreMutex) bool {
        const critical_section = self.spinlock.lock_irq();
        defer self.spinlock.unlock_irq(critical_section);

        if (self.count == 0) {
            // Core is free
            self.owning_core = microzig.hal.get_cpu_id();
            self.count = 1;
            return true;
        } else if (self.owning_core == microzig.hal.get_cpu_id()) {
            self.count += 1;
            return true;
        }

        return false;
    }

    /// Lock the mutex.
    /// If a core cannot acquire the mutex, it will busy wait until
    /// the mutex is available.
    pub fn lock(self: *CoreMutex) void {
        while (!self.try_lock()) {}
    }

    /// Release the mutex.
    pub fn unlock(self: *CoreMutex) void {
        const critical_section = self.spinlock.lock_irq();
        defer self.spinlock.unlock_irq(critical_section);

        if (self.count > 0) self.count -= 1;
    }
};
