const std = @import("std");
const microzig = @import("microzig");
const SYSTIMER = microzig.chip.peripherals.SYSTIMER;

const system = @import("system.zig");

pub fn ticks_per_us() u52 {
    return 16;
}

pub fn unit(num: u1) Unit {
    return @enumFromInt(num);
}

pub fn alarm(num: u2) Alarm {
    std.debug.assert(num <= 2);
    return @enumFromInt(num);
}

pub const Unit = enum(u1) {
    unit0,
    unit1,

    pub const Config = enum {
        disabled,
        disabled_if_cpu_stalled,
        enabled,
    };

    // TODO: Not sure how this should be called.
    pub fn apply(self: Unit, config: Config) void {
        system.enable_clocks_and_release_reset(.{
            .systimer = true,
        });

        switch (config) {
            .disabled => switch (self) {
                .unit0 => SYSTIMER.CONF.modify(.{
                    .TIMER_UNIT0_WORK_EN = 0,
                }),
                .unit1 => SYSTIMER.CONF.modify(.{
                    .TIMER_UNIT1_WORK_EN = 0,
                }),
            },
            .disabled_if_cpu_stalled => switch (self) {
                .unit0 => SYSTIMER.CONF.modify(.{
                    .TIMER_UNIT0_WORK_EN = 1,
                    .TIMER_UNIT0_CORE0_STALL_EN = 1,
                    .TIMER_UNIT0_CORE1_STALL_EN = 0,
                }),
                .unit1 => SYSTIMER.CONF.modify(.{
                    .TIMER_UNIT1_WORK_EN = 1,
                    .TIMER_UNIT1_CORE0_STALL_EN = 1,
                    .TIMER_UNIT1_CORE1_STALL_EN = 0,
                }),
            },
            .enabled => switch (self) {
                .unit0 => SYSTIMER.CONF.modify(.{
                    .TIMER_UNIT0_WORK_EN = 1,
                    .TIMER_UNIT0_CORE0_STALL_EN = 0,
                    .TIMER_UNIT0_CORE1_STALL_EN = 0,
                }),
                .unit1 => SYSTIMER.CONF.modify(.{
                    .TIMER_UNIT1_WORK_EN = 1,
                    .TIMER_UNIT1_CORE0_STALL_EN = 0,
                    .TIMER_UNIT1_CORE1_STALL_EN = 0,
                }),
            },
        }
    }

    pub fn write(self: Unit, value: u52) void {
        const LOAD: @TypeOf(&SYSTIMER.UNIT0_LOAD) = switch (self) {
            .unit0 => &SYSTIMER.UNIT0_LOAD,
            .unit1 => @ptrCast(&SYSTIMER.UNIT1_LOAD),
        };
        const LO: @TypeOf(&SYSTIMER.UNIT0_LOAD_LO) = switch (self) {
            .unit0 => &SYSTIMER.UNIT0_LOAD_LO,
            .unit1 => @ptrCast(&SYSTIMER.UNIT1_LOAD_LO),
        };
        const HI: @TypeOf(&SYSTIMER.UNIT0_LOAD_HI) = switch (self) {
            .unit0 => &SYSTIMER.UNIT0_VALUE_HI,
            .unit1 => @ptrCast(&SYSTIMER.UNIT1_VALUE_HI),
        };

        LO.write(.{ .TIMER_UNIT0_LOAD_LO = @truncate(value) });
        HI.write(.{ .TIMER_UNIT0_LOAD_HI = @truncate(value >> 32) });
        LOAD.write(.{ .TIMER_UNIT0_LOAD = 1 });
    }

    pub fn read(self: Unit) u52 {
        const OP: @TypeOf(&SYSTIMER.UNIT0_OP) = switch (self) {
            .unit0 => &SYSTIMER.UNIT0_OP,
            .unit1 => @ptrCast(&SYSTIMER.UNIT1_OP),
        };
        const LO: @TypeOf(&SYSTIMER.UNIT0_VALUE_LO) = switch (self) {
            .unit0 => &SYSTIMER.UNIT0_VALUE_LO,
            .unit1 => @ptrCast(&SYSTIMER.UNIT1_VALUE_LO),
        };
        const HI: @TypeOf(&SYSTIMER.UNIT0_VALUE_HI) = switch (self) {
            .unit0 => &SYSTIMER.UNIT0_VALUE_HI,
            .unit1 => @ptrCast(&SYSTIMER.UNIT1_VALUE_HI),
        };

        // Set the "update" bit and wait for acknowledgment
        OP.modify(.{ .TIMER_UNIT0_UPDATE = 1 });
        while (OP.read().TIMER_UNIT0_VALUE_VALID != 1) {}

        // Read LO, HI, then LO again, check that LO returns the same value. This accounts for the case
        // when an interrupt may happen between reading HI and LO values, and this function may get
        // called from the ISR. In this case, the repeated read will return consistent values.
        var lo_start = LO.read().TIMER_UNIT0_VALUE_LO; // 32 bits
        while (true) {
            const lo = lo_start;
            const hi = HI.read().TIMER_UNIT0_VALUE_HI;
            lo_start = LO.read().TIMER_UNIT0_VALUE_LO;

            if (lo_start == lo) return (@as(u52, hi) << 32) | lo;
        }
    }
};

pub const Alarm = enum(u2) {
    alarm0,
    alarm1,
    alarm2,

    pub fn set_enabled(self: Alarm, enable: bool) void {
        const en = @intFromBool(enable);
        switch (self) {
            .alarm0 => SYSTIMER.CONF.modify(.{ .TARGET0_WORK_EN = en }),
            .alarm1 => SYSTIMER.CONF.modify(.{ .TARGET1_WORK_EN = en }),
            .alarm2 => SYSTIMER.CONF.modify(.{ .TARGET2_WORK_EN = en }),
        }
    }

    pub fn set_unit(self: Alarm, unit_: Unit) void {
        const conf = self.target_conf_reg();
        conf.modify(.{ .TARGET0_TIMER_UNIT_SEL = @intFromEnum(unit_) });
    }

    pub const Mode = enum {
        target,
        period,
    };

    pub fn set_mode(self: Alarm, mode: Mode) void {
        const conf = self.target_conf_reg();
        conf.modify(.{ .TARGET0_PERIOD_MODE = @intFromBool(mode == .period) });
    }

    pub fn set_period(self: Alarm, value: u26) void {
        const conf = self.target_conf_reg();
        const comp_load = self.comp_load_reg();

        conf.modify(.{
            .TARGET0_PERIOD = value,
        });

        comp_load.write(.{
            .TIMER_COMP0_LOAD = 1,
        });
    }

    pub fn set_target(self: Alarm, value: u52) void {
        const target_lo: @TypeOf(&SYSTIMER.TARGET0_LO) = switch (self) {
            .alarm0 => &SYSTIMER.TARGET0_LO,
            .alarm1 => @ptrCast(&SYSTIMER.TARGET1_LO),
            .alarm2 => @ptrCast(&SYSTIMER.TARGET2_LO),
        };
        const target_hi: @TypeOf(&SYSTIMER.TARGET0_HI) = switch (self) {
            .alarm0 => &SYSTIMER.TARGET0_HI,
            .alarm1 => @ptrCast(&SYSTIMER.TARGET1_HI),
            .alarm2 => @ptrCast(&SYSTIMER.TARGET2_HI),
        };
        const comp_load = self.comp_load_reg();

        target_lo.write(.{ .TIMER_TARGET0_LO = @intCast(value & 0xffff_ffff) });
        target_hi.write(.{ .TIMER_TARGET0_HI = @intCast(value >> 32) });

        comp_load.write(.{
            .TIMER_COMP0_LOAD = 1,
        });
    }

    pub fn interrupt_source(self: Alarm) microzig.cpu.interrupt.Source {
        return switch (self) {
            .alarm0 => .systimer_target0,
            .alarm1 => .systimer_target1,
            .alarm2 => .systimer_target2,
        };
    }

    pub fn set_interrupt_enabled(self: Alarm, enable: bool) void {
        switch (self) {
            .alarm0 => SYSTIMER.INT_ENA.modify(.{ .TARGET0_INT_ENA = @intFromBool(enable) }),
            .alarm1 => SYSTIMER.INT_ENA.modify(.{ .TARGET1_INT_ENA = @intFromBool(enable) }),
            .alarm2 => SYSTIMER.INT_ENA.modify(.{ .TARGET2_INT_ENA = @intFromBool(enable) }),
        }
    }

    pub fn clear_interrupt(self: Alarm) void {
        switch (self) {
            .alarm0 => SYSTIMER.INT_CLR.modify(.{ .TARGET0_INT_CLR = 1 }),
            .alarm1 => SYSTIMER.INT_CLR.modify(.{ .TARGET1_INT_CLR = 1 }),
            .alarm2 => SYSTIMER.INT_CLR.modify(.{ .TARGET2_INT_CLR = 1 }),
        }
    }

    fn target_conf_reg(self: Alarm) @TypeOf(&SYSTIMER.TARGET0_CONF) {
        return switch (self) {
            .alarm0 => &SYSTIMER.TARGET0_CONF,
            .alarm1 => @ptrCast(&SYSTIMER.TARGET1_CONF),
            .alarm2 => @ptrCast(&SYSTIMER.TARGET2_CONF),
        };
    }

    fn comp_load_reg(self: Alarm) @TypeOf(&SYSTIMER.COMP0_LOAD) {
        return switch (self) {
            .alarm0 => &SYSTIMER.COMP0_LOAD,
            .alarm1 => @ptrCast(&SYSTIMER.COMP1_LOAD),
            .alarm2 => @ptrCast(&SYSTIMER.COMP2_LOAD),
        };
    }
};
