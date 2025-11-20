pub const Clock = struct {
    sys_clk: u32,
    ahb: u32,
    apb1: u32,
    apb2: u32,
};

pub var current_clock: Clock = .{
    .sys_clk = 8_000_000,
    .ahb = 8_000_000,
    .apb1 = 8_000_000,
    .apb2 = 8_000_000,
};
