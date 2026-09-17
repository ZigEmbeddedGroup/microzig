const microzig = @import("microzig");

const cpu = microzig.cpu;
const interrupt = cpu.interrupt;

const peripherals = microzig.chip.peripherals;
const STK = peripherals.STK;

// TODO: the svd needs to be patched!
// Remove the 'STK_' prefix and '_0'/'_1' suffix.

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
                STK.STK_CTLR_0.modify(.{
                    .CID_0 = if (cfg.core) |core| @backingInt(core) else 0,
                    .DOWN_MODE_0 = @backingInt(cfg.mode),
                    .AUTO_RELOAD_0 = @intFromBool(cfg.auto_reload),
                    .NO_RTC_0 = @backingInt(cfg.clock_source),
                    .IE_0 = 0,
                    .EN_0 = 0,
                });
                if (cfg.auto_reload) STK.STK_CMP_0.raw = cfg.compare_value;
            },
            1 => {
                STK.STK_CTLR_1.modify(.{
                    .CID_1 = if (cfg.core) |core| @backingInt(core) else 1,
                    .DOWN_MODE_1 = @backingInt(cfg.mode),
                    .AUTO_RELOAD_1 = @intFromBool(cfg.auto_reload),
                    .NO_RTC_1 = @backingInt(cfg.clock_source),
                    .IE_1 = 0,
                    .EN_1 = 0,
                });
                if (cfg.auto_reload) STK.STK_CMP_1.raw = cfg.compare_value;
            },
        }
    }

    pub inline fn get_cnt(stk: Systick) u32 {
        switch (stk.id) {
            0 => return STK.STK_CNT_0.raw,
            1 => return STK.STK_CNT_1.raw,
        }
    }

    pub inline fn enable_interrupt(stk: Systick) void {
        switch (stk.id) {
            0 => {
                STK.STK_CTLR_0.modify(.{ .IE_0 = 1 });
                interrupt.enable(.SysTick0);
            },
            1 => {
                STK.STK_CTLR_1.modify(.{ .IE_1 = 1 });
                interrupt.enable(.SysTick1);
            },
        }
    }

    pub inline fn clear_pending(stk: Systick) void {
        switch (stk.id) {
            0 => STK.STK_ISR.modify(.{ .STK_ISR0 = 0 }),
            1 => STK.STK_ISR.modify(.{ .STK_ISR1 = 0 }),
        }
    }

    pub inline fn enable(stk: Systick) void {
        switch (stk.id) {
            0 => STK.STK_CTLR_0.modify(.{ .EN_0 = 1 }),
            1 => STK.STK_CTLR_1.modify(.{ .EN_1 = 1 }),
        }
    }

    pub inline fn busy_delay(stk: Systick, cycles: u32) void {
        const begin = stk.get_cnt();
        while (stk.get_cnt() -% begin < cycles) {}
    }
};

pub const systick0: Systick = .{ .id = 0 };
pub const systick1: Systick = .{ .id = 1 };
