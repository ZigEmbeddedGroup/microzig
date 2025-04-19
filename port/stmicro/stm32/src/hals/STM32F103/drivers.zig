pub const CounterDevice = struct {
    ticks_per_ns: u32,
    busy_wait_fn: *const fn (?*const anyopaque, u64) void,
    ctx: ?*const anyopaque,

    /// NOTE: STM32F1xx timer only have 16bits, so we need to run multiple times
    /// NOTE: delay in nanoseconds is not precise
    /// to wait for a time greater than 65535
    pub fn sleep_ns(self: *const CounterDevice, time: u64) void {
        self.busy_wait_fn(self.ctx, time / self.ticks_per_ns);
    }

    pub fn sleep_us(self: *const CounterDevice, time: u64) void {
        self.sleep_ns(time * 1000);
    }

    ///wait for a given time in milliseconds
    pub fn sleep_ms(self: *const CounterDevice, time: u64) void {
        self.sleep_us(time * 1000);
    }
};
