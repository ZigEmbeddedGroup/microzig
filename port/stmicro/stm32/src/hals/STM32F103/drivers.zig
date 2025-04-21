pub const CounterDevice = struct {
    us_psc: u32,
    ms_psc: u32,
    ns_per_tick: u32,
    busy_wait_fn: *const fn (*const anyopaque, time: u64) void,
    load_and_start: *const fn (*const anyopaque, psc: u32, arr: u16) void,
    check_event: *const fn (*const anyopaque) bool,
    ctx: *const anyopaque,

    pub fn sleep_ns(self: *const CounterDevice, ns: u64) void {
        const arr = ns / self.ns_per_tick;
        self.busy_wait_fn(self.ctx, arr);
    }

    pub fn sleep_us(self: *const CounterDevice, us: u64) void {
        self.sleep_ns(us * 1_000);
    }

    pub fn sleep_ms(self: *const CounterDevice, ms: u64) void {
        self.sleep_us(ms * 1_000);
    }

    pub fn make_ms_timeout(self: *const CounterDevice, time: u16) Timeout {
        self.load_and_start(self.ctx, self.ms_psc, time);
        return Timeout{
            .ctx = self.ctx,
            .check_event = self.check_event,
        };
    }
};

pub const Timeout = struct {
    ctx: *const anyopaque,
    check_event: *const fn (*const anyopaque) bool,

    pub fn check_timeout(self: *const Timeout) bool {
        return self.check_event(self.ctx);
    }
};
