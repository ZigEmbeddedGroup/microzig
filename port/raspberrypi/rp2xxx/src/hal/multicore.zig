const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SIO = peripherals.SIO;
const PSM = peripherals.PSM;
const PPB = peripherals.PPB;

pub const fifo = struct {
    /// Check if the FIFO has valid data for reading.
    pub fn is_read_ready() bool {
        return SIO.FIFO_ST.read().VLD == 1;
    }

    /// Read from the FIFO
    /// Will return null if it is empty.
    pub fn read() ?u32 {
        if (!is_read_ready())
            return null;

        return SIO.FIFO_RD.read().FIFO_RD;
    }

    /// Read from the FIFO, waiting for data if there is none.
    pub fn read_blocking() u32 {
        while (true) {
            if (read()) |value| return value;
            microzig.cpu.wfe();
        }
    }

    /// Read from the FIFO, and throw everyting away.
    pub fn drain() void {
        while (read()) |_| {}
    }

    /// Check if the FIFO is ready to receive data.
    pub fn is_write_ready() bool {
        return SIO.FIFO_ST.read().RDY == 1;
    }

    /// Write to the FIFO
    /// You must check if there is space by calling is_write_ready
    pub fn write(value: u32) void {
        SIO.FIFO_WR.write(.{ .FIFO_WR = value });
        microzig.cpu.sev();
    }

    /// Write to the FIFO, waiting for room if it is full.
    pub fn write_blocking(value: u32) void {
        while (!is_write_ready())
            std.mem.doNotOptimizeAway(value);

        write(value);
    }
};

var core1_stack: [128]u32 = undefined;

/// Runs `entrypoint` on the second core.
pub fn launch_core1(entrypoint: *const fn () void) void {
    launch_core1_with_stack(entrypoint, &core1_stack);
}

pub fn launch_core1_with_stack(entrypoint: *const fn () void, stack: []u32) void {
    // TODO: disable SIO interrupts

    const wrapper = &struct {
        fn wrapper(_: u32, _: u32, _: u32, _: u32, entry: u32, stack_base: [*]u32) callconv(.c) void {
            // TODO: protect stack using MPU
            _ = stack_base;
            @as(*const fn () void, @ptrFromInt(entry))();
        }
    }.wrapper;

    // reset the second core
    PSM.FRCE_OFF.modify(.{ .PROC1 = 1 });
    while (PSM.FRCE_OFF.read().PROC1 != 1) microzig.cpu.nop();
    PSM.FRCE_OFF.modify(.{ .PROC1 = 0 });

    stack[stack.len - 2] = @intFromPtr(entrypoint);
    stack[stack.len - 1] = @intFromPtr(stack.ptr);

    // calculate top of the stack
    const stack_ptr: u32 =
        @intFromPtr(stack.ptr) +
        (stack.len - 2) * @sizeOf(u32); // pop the two elements we "pushed" above

    // after reseting core1 is waiting for this specific sequence
    const cmds: [6]u32 = .{
        0,
        0,
        1,
        PPB.VTOR.raw,
        stack_ptr,
        @intFromPtr(wrapper),
    };

    var seq: usize = 0;
    while (seq < cmds.len) {
        const cmd = cmds[seq];
        if (cmd == 0) {
            // always drain the fifo before sending zero
            fifo.drain();
            microzig.cpu.sev();
        }

        fifo.write_blocking(cmd);
        // the second core should respond with the same value, if it doesnt't lets start over
        seq = if (cmd == fifo.read_blocking()) seq + 1 else 0;
    }
}

/// Manage the state of hardware spinlocks.
/// Usage example:
///     var lock = Spinlock.init(5);
///     . . .
///     {
///         lock.lock();
///         defer lock.unlock();
///         . . .
///     }
///
pub const Spinlock = struct {
    lock_reg: *volatile u32,

    const spinlock_base: usize = @intFromPtr(&SIO.SPINLOCK0.raw);

    /// Returns an initialized Spinlock struct.
    /// Parameters:
    ///   lock_num - the index of the hardware spinlock to use
    ///
    /// Note: Spinlocks 26 through 31 are reserved for use by microzig.
    pub fn init(lock_num: u5) Spinlock {
        return .{ .lock_reg = @ptrFromInt(spinlock_base + 4 * @as(usize, @intCast(lock_num))) };
    }

    /// Returns the index of the spinlock.
    pub fn number(self: Spinlock) u5 {
        return @intCast((@intFromPtr(self.lock_reg) - spinlock_base) / 4);
    }

    /// Lock the spinlock.  If the spinlock is already locked, busy wait until
    /// it is release by the other core.
    pub fn lock(self: Spinlock) void {
        while (self.lock_reg.* == 0) {}
    }

    /// Returns true if the spinlock is locked
    pub fn isLocked(self: Spinlock) bool {
        const bit = @as(u32, 1) << self.number();
        return (Spinlock.lockStatus() & bit) != 0;
    }

    /// Unlock the spinlock
    pub fn unlock(self: Spinlock) void {
        self.lock_reg.* = 0;
    }

    /// Returns bitmap of currently locked spinlocks
    pub fn lockStatus() u32 {
        return SIO.SPINLOCK_ST.read().SPINLOCK_ST;
    }
};

// Reserved spinlocks:
//  31 - multicore safe logging     - hal.uart

/// Multicore safe semaphore.
pub const Semaphore = struct {
    available: bool = true,
    spinlock: Spinlock = Spinlock.init(31),

    /// Acquire the semaphore.
    /// Returns true if the semaphore was acquired, false if the semaphore
    /// is not available.
    pub fn acquire_unblocking(self: *Semaphore) bool {
        const critical_section = microzig.interrupt.enter_critical_section();
        defer critical_section.leave();

        self.spinlock.lock();
        defer self.spinlock.unlock();

        if (self.available) {
            self.available = false;
            return true;
        }

        return false;
    }

    /// Acquire the semaphore.
    /// If the semaphore cannot be acquired, this function will busy wait until
    /// the semaphore is available.
    pub fn acquire(self: *Semaphore) void {
        while (!self.acquire_unblocking()) {}
    }

    /// Release the semaphore.
    pub fn release(self: *Semaphore) void {
        // Note: no need for critical section here as this operation
        // is inherently atomic.
        self.available = true;
    }
};
/// This semaphore can only be acquired by one core at a time.  It can be
/// acquired more than once by the same core but must be released the same
/// number of times it was acquired before the other core can acquire it.
pub const CoreSemaphore = struct {
    count: usize = 0,
    spinlock: Spinlock = Spinlock.init(31),
    owning_core: u32 = 0,

    /// Acquire the semaphore.
    /// Returns true if the semaphore was acquired, false if the semaphore
    /// is not available.
    pub fn acquire_unblocking(self: *CoreSemaphore) bool {
        const critical_section = microzig.interrupt.enter_critical_section();
        defer critical_section.leave();

        self.spinlock.lock();
        defer self.spinlock.unlock();

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

    /// Acquire the semaphore.
    /// If a core cannot acquire the semaphore, it will busy wait until
    /// the semaphore is available.
    pub fn acquire(self: *CoreSemaphore) void {
        while (!self.acquire_unblocking()) {}
    }

    /// Release the semaphore.
    pub fn release(self: *CoreSemaphore) void {
        const critical_section = microzig.interrupt.enter_critical_section();
        defer critical_section.leave();

        self.spinlock.lock();
        defer self.spinlock.unlock();

        if (self.count > 0) self.count -= 1;
    }
};

