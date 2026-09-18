const microzig = @import("microzig");

const cpu = microzig.cpu;
const interrupt = cpu.interrupt;

const peripherals = microzig.chip.peripherals;
const STK = peripherals.STK;

const Systick = struct {
    id: u1,

    pub const Config = struct {
        // default: 0 => v3f, 1 => v5f
        core: ?cpu.Core = null,

        mode: enum { up, down },
        clock_source: enum { hclk_div_8, hclk },

        auto_reload: bool,
        compare_value: u32 = 0,
    };

    pub inline fn apply(stk: Systick, comptime cfg: Config) void {
        switch (stk.id) {
            0 => {
                STK.CTLR0.modify(.{
                    .CID = if (cfg.core) |core| @backingInt(core) else 0,
                    .DOWN_MODE = @backingInt(cfg.mode),
                    .AUTO_RELOAD = @intFromBool(cfg.auto_reload),
                    .NO_RTC = @backingInt(cfg.clock_source),
                    .IE = 0,
                    .EN = 0,
                });
                if (cfg.auto_reload) STK.CMP0.raw = cfg.compare_value;
            },
            1 => {
                STK.CTLR1.modify(.{
                    .CID = if (cfg.core) |core| @backingInt(core) else 1,
                    .DOWN_MODE = @backingInt(cfg.mode),
                    .AUTO_RELOAD = @intFromBool(cfg.auto_reload),
                    .NO_RTC = @backingInt(cfg.clock_source),
                    .IE = 0,
                    .EN = 0,
                });
                if (cfg.auto_reload) STK.CMP1.raw = cfg.compare_value;
            },
        }
    }

    pub inline fn get_cnt(stk: Systick) u32 {
        switch (stk.id) {
            0 => return STK.CNT0.raw,
            1 => return STK.CNT1.raw,
        }
    }

    pub inline fn enable_interrupt(stk: Systick) void {
        switch (stk.id) {
            0 => {
                STK.CTLR0.modify(.{ .IE = 1 });
                interrupt.enable(.SysTick0);
            },
            1 => {
                STK.CTLR1.modify(.{ .IE = 1 });
                interrupt.enable(.SysTick1);
            },
        }
    }

    pub inline fn clear_pending(stk: Systick) void {
        switch (stk.id) {
            0 => STK.ISR.modify(.{ .ISR0 = 0 }),
            1 => STK.ISR.modify(.{ .ISR1 = 0 }),
        }
    }

    pub inline fn enable(stk: Systick) void {
        switch (stk.id) {
            0 => STK.CTLR0.modify(.{ .EN = 1 }),
            1 => STK.CTLR1.modify(.{ .EN = 1 }),
        }
    }

    pub inline fn busy_delay(stk: Systick, cycles: u32) void {
        const begin = stk.get_cnt();
        while (stk.get_cnt() -% begin < cycles) {}
    }
};

pub const systick0: Systick = .{ .id = 0 };
pub const systick1: Systick = .{ .id = 1 };
