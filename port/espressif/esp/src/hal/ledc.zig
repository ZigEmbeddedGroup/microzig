const std = @import("std");
const microzig = @import("microzig");
const LEDC = microzig.chip.peripherals.LEDC;

const clocks = @import("clocks.zig");
const gpio = @import("gpio.zig");
const system = @import("system.zig");

pub const ClockSource = enum(u2) {
    apb_clk = 1,
    xtal_clk = 3,
};

/// Enables the LEDC peripheral and sets the clock source.
pub fn apply(clock_source: ClockSource) void {
    system.enable_clocks_and_release_reset(.{ .ledc = true });

    set_clock_source(clock_source);
}

/// Timers configuration is specific to a clock source. If changed, all active
/// timers must be reconfigured.
pub fn set_clock_source(clock_source: ClockSource) void {
    LEDC.CONF.modify(.{
        .APB_CLK_SEL = @intFromEnum(clock_source),
    });
}

pub fn get_clock_source() ClockSource {
    return @enumFromInt(LEDC.CONF.read().APB_CLK_SEL);
}

pub fn timer(num: u4) Timer {
    return @enumFromInt(num);
}

pub fn channel(num: u4) Channel {
    return @enumFromInt(num);
}

inline fn comptime_fail_or_error(msg: []const u8, fmt_args: anytype, err: anytype) !void {
    if (@inComptime()) {
        @compileError(std.fmt.comptimePrint(msg, fmt_args));
    } else {
        return err;
    }
}

pub const Timer = enum(u2) {
    timer0 = 0,
    timer1 = 1,
    timer2 = 2,
    timer3 = 3,

    pub const Config = struct {
        clock_config: clocks.Config,
        /// The frequency of the timer in Hz.
        frequency: u32,
        /// The number of precision bits for the timer. Takes values from 1 to 14.
        precision: u4,

        pub const Error = error{
            InvalidFrequency,
            InvalidPrecision,
        };

        fn resolve(config: Config, clock_source: ClockSource) Error!u18 {
            const src_freq = switch (clock_source) {
                .apb_clk => config.clock_config.apb_clk_freq,
                .xtal_clk => clocks.xtal_clk_freq,
            };

            if (config.frequency == 0) try comptime_fail_or_error("frequency must be greater than 0", .{}, error.InvalidFrequency);

            if (config.precision <= 0 or config.precision > 14) try comptime_fail_or_error(
                "invalid precision: {} (must be greater than 0 and less than or equal to 14)",
                .{config.precision},
                error.InvalidPrecision,
            );

            const divider = (@as(u64, src_freq) << 8) / config.frequency / (@as(u64, 1) << config.precision);
            if (divider < 256) try comptime_fail_or_error("frequency too high: {}", .{config.frequency}, error.InvalidFrequency);
            if (divider > std.math.maxInt(u18)) try comptime_fail_or_error("frequency too low: {}", .{config.frequency}, error.InvalidFrequency);

            return @truncate(divider);
        }
    };

    /// Applies the configuration to the timer and validates it at comptime.
    /// Requires the clock source to be provided.
    pub fn apply(tim: Timer, comptime config: Config, comptime clock_source: ClockSource) void {
        const resolved_config = comptime config.resolve(clock_source) catch unreachable;
        apply_internal(tim, config, resolved_config);
    }

    /// Applies the configuration to the timer and returns an error if invalid.
    /// Doesn't require the clock source to be provided as it is fetched at
    /// runtime.
    pub fn apply_runtime(tim: Timer, config: Config) Config.Error!void {
        const clock_source = get_clock_source();
        const resolved_config = try config.resolve(clock_source);
        apply_internal(tim, config, resolved_config);
    }

    fn apply_internal(tim: Timer, config: Config, divider: u18) void {
        const regs = tim.get_regs();

        regs.conf.modify(.{
            .LSTIMER0_DUTY_RES = config.precision,
            .CLK_DIV_LSTIMER0 = divider,
            .LSTIMER0_PAUSE = 0,
            .LSTIMER0_RST = 0,
            .TICK_SEL_LSTIMER0 = 0,
        });

        regs.conf.modify(.{
            .LSTIMER0_PARA_UP = 1,
        });
    }

    inline fn get_regs(tim: Timer) *volatile extern struct {
        conf: @TypeOf(LEDC.LSTIMER0_CONF),
        value: @TypeOf(LEDC.LSTIMER0_VALUE),
    } {
        return switch (tim) {
            .timer0 => @alignCast(@ptrCast(&LEDC.LSTIMER0_CONF)),
            .timer1 => @alignCast(@ptrCast(&LEDC.LSTIMER1_CONF)),
            .timer2 => @alignCast(@ptrCast(&LEDC.LSTIMER2_CONF)),
            .timer3 => @alignCast(@ptrCast(&LEDC.LSTIMER3_CONF)),
        };
    }
};

pub const Channel = enum(u2) {
    channel0 = 0,
    channel1 = 1,
    channel2 = 2,
    channel3 = 3,

    pub const Config = struct {
        timer: Timer,
        initial_duty: u15 = 0,
    };

    /// Applies the configuration to the channel.
    pub fn apply(chan: Channel, config: Config) void {
        const regs = chan.get_regs();

        regs.hpoint.write(.{ .HPOINT_LSCH0 = 0 });
        regs.conf0.modify(.{
            .TIMER_SEL_LSCH0 = @intFromEnum(config.timer),
            .SIG_OUT_EN_LSCH0 = 1,
        });

        // also calls update()
        chan.set_duty(config.initial_duty);
    }

    /// Connects the channel to the provided pin.
    pub fn connect_pin(chan: Channel, pin: gpio.Pin) void {
        pin.connect_peripheral_to_output(.{
            .signal = switch (chan) {
                .channel0 => .ledc_ls_sig_out0,
                .channel1 => .ledc_ls_sig_out1,
                .channel2 => .ledc_ls_sig_out2,
                .channel3 => .ledc_ls_sig_out3,
            },
        });
    }

    /// Sets a constant duty cycle.
    pub fn set_duty(chan: Channel, duty: u15) void {
        const regs = chan.get_regs();

        regs.duty.write(.{ .DUTY_LSCH0 = @as(u19, duty) << 4 });

        regs.conf1.write(.{
            .DUTY_START_LSCH0 = 1,
            .DUTY_INC_LSCH0 = 1,
            .DUTY_NUM_LSCH0 = 1,
            .DUTY_CYCLE_LSCH0 = 1,
            .DUTY_SCALE_LSCH0 = 0,
        });

        chan.update();
    }

    /// Starts a fade duty and waits for it to complete.
    pub fn fade_duty_blocking(chan: Channel, starting_duty: u15, options: DutyFadeOptions) void {
        start_duty_fade(chan, starting_duty, options);
        while (!is_duty_fade_done(chan)) {}
    }

    /// Starts a duty cycle fade.
    pub fn start_duty_fade(chan: Channel, starting_duty: u15, options: DutyFadeOptions) void {
        const regs = chan.get_regs();

        regs.duty.write(.{ .DUTY_LSCH0 = @as(u19, starting_duty) << 4 });

        switch (chan) {
            .channel0 => LEDC.INT_CLR.modify(.{ .DUTY_CHNG_END_LSCH0_INT_CLR = 1 }),
            .channel1 => LEDC.INT_CLR.modify(.{ .DUTY_CHNG_END_LSCH1_INT_CLR = 1 }),
            .channel2 => LEDC.INT_CLR.modify(.{ .DUTY_CHNG_END_LSCH2_INT_CLR = 1 }),
            .channel3 => LEDC.INT_CLR.modify(.{ .DUTY_CHNG_END_LSCH3_INT_CLR = 1 }),
        }

        regs.conf1.write(.{
            .DUTY_START_LSCH0 = 1,
            .DUTY_INC_LSCH0 = @intFromBool(options.increment >= 0),
            .DUTY_NUM_LSCH0 = options.duration,
            .DUTY_CYCLE_LSCH0 = options.cycle,
            .DUTY_SCALE_LSCH0 = @truncate(@abs(options.increment)),
        });

        chan.update();
    }

    /// Returns true if the previous duty cycle fade is complete.
    pub fn is_duty_fade_done(chan: Channel) bool {
        return switch (chan) {
            .channel0 => LEDC.INT_RAW.read().DUTY_CHNG_END_LSCH0_INT_RAW == 1,
            .channel1 => LEDC.INT_RAW.read().DUTY_CHNG_END_LSCH0_INT_RAW == 1,
            .channel2 => LEDC.INT_RAW.read().DUTY_CHNG_END_LSCH0_INT_RAW == 1,
            .channel3 => LEDC.INT_RAW.read().DUTY_CHNG_END_LSCH0_INT_RAW == 1,
        };
    }

    pub const DutyFadeOptions = struct {
        increment: i11,
        // Every `cycle` ticks the duty cycle is incremented by `increment`.
        cycle: u10,
        // The fade lasts for `duration` ticks.
        duration: u10,
    };

    fn update(chan: Channel) void {
        const regs = chan.get_regs();

        regs.conf0.modify(.{
            .PARA_UP_LSCH0 = 1,
        });
    }

    inline fn get_regs(chan: Channel) *volatile extern struct {
        conf0: @TypeOf(LEDC.LSCH0_CONF0),
        hpoint: @TypeOf(LEDC.LSCH0_HPOINT),
        duty: @TypeOf(LEDC.LSCH0_DUTY),
        conf1: @TypeOf(LEDC.LSCH0_CONF1),
        duty_r: @TypeOf(LEDC.LSCH0_DUTY_R),
    } {
        return switch (chan) {
            .channel0 => @alignCast(@ptrCast(&LEDC.LSCH0_CONF0)),
            .channel1 => @alignCast(@ptrCast(&LEDC.LSCH1_CONF0)),
            .channel2 => @alignCast(@ptrCast(&LEDC.LSCH2_CONF0)),
            .channel3 => @alignCast(@ptrCast(&LEDC.LSCH3_CONF0)),
        };
    }
};
