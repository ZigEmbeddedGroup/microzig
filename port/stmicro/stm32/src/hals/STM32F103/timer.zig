const std = @import("std");
const microzig = @import("microzig");
const CounterDevice = @import("drivers.zig").CounterDevice;
const create_peripheral_enum = @import("util.zig").create_peripheral_enum;

const periferals = microzig.chip.peripherals;

const TIM_GP16 = *volatile microzig.chip.types.peripherals.timer_v1.TIM_GP16;
pub const DIR = microzig.chip.types.peripherals.timer_v1.DIR;
pub const URS = microzig.chip.types.peripherals.timer_v1.URS;
pub const CMS = microzig.chip.types.peripherals.timer_v1.CMS;

//OCM stands for Output Compare Mode
pub const OCM = microzig.chip.types.peripherals.timer_v1.OCM;

pub const Instances = create_peripheral_enum("TIM", "TIM_GP16");

pub const ARRModes = enum(u1) {
    immediate, //ARR is not buffered, counter will update ARR immediately
    buffered, //ARR is buffered, counter will only update ARR on update event
};

pub const CounterMode = union(enum) {
    up: void,
    down: void,
    center_aligned: CMS,
};

pub const Polarity = enum(u1) {
    ///active high
    high,
    ///active low
    low,
};

pub const Capture = struct {}; //TODO: implement capture mode
pub const Compare = struct {
    mode: OCM,
    polarity: Polarity,
    pre_load: bool = true, //if true, the output will be pre-loaded
    clear_enable: bool = false, //if true, the output will be cleared on ETRF high level
    fast_mode: bool = false, //if true, the output will be in fast mode
};
pub const CaptureOrCompare = union(enum) {
    // output: Capture,
    output: Compare,
    // input: Capture,
    // Config effect depends on the timer Channel.

    ///mode 1: IC1 = IT1, IC2 = IT2, IC3 = IT3, IC4 = IT4
    input_mode1: Capture,

    ///mode 2: IC1 = IT2, IC2 = IT1, IC3 = IT4, IC4 = IT3
    input_mode2: Capture,

    ///only works if TS bits are set
    input_TRC: Capture,
};

fn get_regs(instance: Instances) TIM_GP16 {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

//TODO: add more low-level functions for the timer when adding more modes support

/// General Purpose Timer (GPTimer) driver for STM32F1xx series
/// This driver provides a low-level interface for the general-purpose timers.
///
/// but, it does provide a high-level API for each timer mode.
pub const GPTimer = struct {
    regs: TIM_GP16,
    //=============== Modes ================
    pub fn init(instance: Instances) GPTimer {
        return .{ .regs = get_regs(instance) };
    }

    ///Get high-level timer API for the Basic counter mode.
    pub fn into_counter_mode(self: *const GPTimer) Counter {
        return Counter{ .gptimer = self };
    }

    pub fn into_pwm_mode(self: *const GPTimer) PWM {
        return PWM{ .gptimer = self };
    }

    //=============Timer low level functions=============

    /// This function clears all control registers of the timer.
    pub fn clear_all_control_registers(self: *const GPTimer) void {
        const regs = self.regs;
        regs.CR1.raw = 0;
        regs.CR2.raw = 0;
        regs.SR.raw = 0;
        regs.EGR.raw = 0;
        regs.DIER.raw = 0;
        regs.ARR.raw = 0;
        regs.CNT.raw = 0;
        regs.PSC.raw = 0;
        regs.SMCR.raw = 0;
        regs.CCER.raw = 0;
        regs.DCR.raw = 0;
        regs.DMAR.raw = 0;
    }

    ///clear only CR1 and CR2 registers
    pub fn clear_configs(self: *const GPTimer) void {
        self.regs.CR1.raw = 0;
        self.regs.CR2.raw = 0;
    }
    // ============ Timer control functions ============
    pub inline fn start(self: *const GPTimer) void {
        self.regs.CR1.modify(.{ .CEN = 1 });
    }

    pub inline fn stop(self: *const GPTimer) void {
        self.regs.CR1.modify(.{ .CEN = 0 });
    }

    pub inline fn is_running(self: *const GPTimer) bool {
        return self.regs.CR1.read().CEN == 1;
    }

    pub fn reset(self: *const GPTimer) void {
        self.regs.CR1.modify(.{ .CEN = 0 });
        self.regs.SR.raw = 0;
        self.regs.EGR.modify(.{ .UG = 1 });
        self.regs.CR1.modify(.{ .CEN = 1 });
    }

    pub inline fn get_counter(self: *const GPTimer) u16 {
        return self.regs.CNT.read().CNT;
    }

    pub inline fn set_counter(self: *const GPTimer, value: u16) void {
        self.regs.CNT.modify(.{ .CNT = value });
    }

    pub inline fn get_prescaler(self: *const GPTimer) u32 {
        return self.regs.PSC;
    }

    pub inline fn set_prescaler(self: *const GPTimer, value: u32) void {
        self.regs.PSC = value;
    }

    pub inline fn get_auto_reload(self: *const GPTimer) u16 {
        return self.regs.ARR.read().ARR;
    }

    pub inline fn set_auto_reload(self: *const GPTimer, value: u16) void {
        self.regs.ARR.modify(.{ .ARR = value });
    }

    pub inline fn set_auto_relaod_mode(self: *const GPTimer, mode: ARRModes) void {
        self.regs.CR1.modify(.{ .ARPE = @intFromEnum(mode) });
    }

    pub fn set_counter_mode(self: *const GPTimer, mode: CounterMode) void {
        const regs = self.regs;
        regs.CR1.modify(.{ .CMS = CMS.EdgeAligned });
        switch (mode) {
            .up => regs.CR1.modify(.{ .DIR = DIR.Up }),
            .down => regs.CR1.modify(.{ .DIR = DIR.Down }),
            .center_aligned => |center_mode| {
                regs.CR1.modify(.{ .CMS = center_mode });
            },
        }
    }

    pub inline fn set_one_pulse(self: *const GPTimer, set: bool) void {
        self.regs.CR1.modify(.{ .OPM = @as(u1, @intFromBool(set)) });
    }

    pub inline fn set_update_request_source(self: *const GPTimer, source: URS) void {
        self.regs.CR1.modify(.{ .URS = source });
    }

    pub inline fn set_update_event(self: *const GPTimer, set: bool) void {
        self.regs.CR1.modify(.{ .UDIS = @as(u1, @intFromBool(!set)) });
    }

    pub inline fn set_interrupt(self: *const GPTimer, set: bool) void {
        self.regs.DIER.modify(.{ .UIE = @as(u1, @intFromBool(set)) });
    }

    pub inline fn set_dma_request(self: *const GPTimer, set: bool) void {
        self.regs.DIER.modify(.{ .UDE = @as(u1, @intFromBool(set)) });
    }

    pub fn set_channel_interrupt(self: *const GPTimer, channel: u2, set: bool) void {
        const regs = self.regs;
        if (set) {
            regs.DIER.raw |= @as(u32, 0b1) << (@as(u5, channel) + 1); //CCxIE bits
        } else {
            regs.DIER.raw &= ~(@as(u32, 0b1) << (@as(u5, channel) + 1)); //CCxIE bits
        }
    }

    pub fn set_channel_dma_request(self: *const GPTimer, channel: u2, set: bool) void {
        const regs = self.regs;
        if (set) {
            regs.DIER.raw |= @as(u32, 0b1) << (@as(u5, channel) + 9); //CCxDE bits
        } else {
            regs.DIER.raw &= ~(@as(u32, 0b1) << (@as(u5, channel) + 9)); //CCxDE bits
        }
    }

    pub inline fn software_update(self: *const GPTimer) void {
        self.regs.EGR.modify(.{ .UG = 1 });
    }

    pub inline fn clear_update_interrupt_flag(self: *const GPTimer) void {
        self.regs.SR.raw = 0;
    }

    //=============== Compare/Capture Functions ============
    pub fn load_capture_or_compare(self: *const GPTimer, channel: u2, value: u16) void {
        const regs = self.regs;
        regs.CCR[channel].modify(.{ .CCR = value });
    }

    pub fn set_channel(self: *const GPTimer, channel: u2, set: bool) void {
        const regs = self.regs;
        if (set) {
            regs.CCER.raw |= @as(u32, 0b1) << (@as(u5, channel) * 4); //CCxE bits
        } else {
            regs.CCER.raw &= ~(@as(u32, 0b1) << (@as(u5, channel) * 4)); //CCxE bits
        }
    }

    pub fn set_capture_or_compare(self: *const GPTimer, channel: u2, config: CaptureOrCompare) void {
        const regs = self.regs;
        switch (config) {
            .output => |out| {
                configure_output(channel, out);
            },
            else => |_| {
                @panic("Capture mode not implemented yet");
            },
        }

        const mode: u32 = @intFromEnum(config);
        const CCMR = if (channel < 2) &regs.CCMR_Input[0] else &regs.CCMR_Input[1];

        //channel 1 and 3 start at 0, channel 2 and 4 start at 8
        //but index is 0-based, so we need to subtract 1
        //channel 0 and 2 start at 0, channel 1 and 3 start at 8
        const offset: u5 = if (channel % 2 == 0) 0 else 8;
        CCMR.raw &= ~(@as(u32, 0b11) << offset);
        CCMR.raw |= mode << offset;
    }

    pub fn configure_output(self: *const GPTimer, channel: u2, config: Compare) void {
        const regs = self.regs;
        const CCMR = if (channel < 2) &regs.CCMR_Input[0] else &regs.CCMR_Input[1];
        const offset: u5 = if (channel % 2 == 0) 0 else 8;

        if (config.fast_mode) {
            CCMR.raw |= @as(u32, 0b1) << (offset + 2); //OCxFE bits
        } else {
            CCMR.raw &= ~(@as(u32, 0b1) << (offset + 2)); //OCxFE bits
        }

        if (config.pre_load) {
            CCMR.raw |= @as(u32, 0b1) << (offset + 3); //CCxS bits
        } else {
            CCMR.raw &= ~(@as(u32, 0b1) << (offset + 3)); //CCxS bits
        }

        const mode: u32 = @intFromEnum(config.mode);
        CCMR.raw &= ~(@as(u32, 0b111) << offset + 4); //clear mode bits
        CCMR.raw |= mode << (offset + 4); //set mode bits

        if (config.clear_enable) {
            CCMR.raw |= @as(u32, 0b1) << (offset + 7); //CCxE bits
        } else {
            CCMR.raw &= ~(@as(u32, 0b1) << (offset + 7)); //CCxE bits
        }

        switch (config.polarity) {
            .high => {
                regs.CCER.raw &= ~(@as(u32, 0b1) << (@as(u5, channel) * 4 + 1)); //CCxP bits
            },
            .low => {
                regs.CCER.raw |= @as(u32, 0b1) << (@as(u5, channel) * 4 + 1); //CCxP bits
            },
        }
    }
};

//============ Counter mode ============

pub const CounterConfig = struct {
    prescaler: u32 = 0, //prescaler value, 0 means no prescaler
    auto_reload: u16 = std.math.maxInt(u16), //auto-reload value
    one_pulse_mode: bool = false, //if true, timer will stop after one pulse
    update_request_source: bool = true, //if true, timer will only generate update
    //requests on counter overflow, otherwise it will generate update requests on
    //counter underflow and overflow
    enable_interrupt: bool = false, //if true, timer will generate an interrupt on update event
    enable_dma_request: bool = false, //if true, timer will generate a DMA request on update event
    event_source: URS = .CounterOnly, //update request source
    counter_mode: CounterMode = .up, //counter mode
};

///at the right moment this is only a thin wrapper around the GPTimer APIs
///to provide a high-level API for the basic counter mode.
///
/// TODO: Slave/Master modes for sinchronization with other timers
/// TODO: DMA BURST on timer update event
pub const Counter = struct {
    gptimer: *const GPTimer,

    //=============== Device Functions ================
    pub fn counter_device(self: *const Counter, pclk: u32) CounterDevice {
        const regs = self.gptimer.regs;
        //clear timer configs end pending events
        regs.CR1.raw = 0;
        regs.CR2.raw = 0;
        regs.SR.raw = 0;

        //downcounter, one-pulse, UG UVE source disable
        regs.CR1.modify(.{
            .DIR = DIR.Down,
            .OPM = 1,
            .URS = URS.CounterOnly,
            .ARPE = 1,
        });

        return CounterDevice{
            .ns_per_tick = 1_000_000_000 / pclk,
            .us_psc = pclk / 1_000_000,
            .ms_psc = pclk / 1_000,
            .load_and_start = load_and_start,
            .check_event = check_event,
            .busy_wait_fn = busy_wait_fn,
            .ctx = self.gptimer,
        };
    }

    fn load_and_start(ctx: *const anyopaque, psc: u32, arr: u16) void {
        const self: *const GPTimer = @alignCast(@ptrCast(ctx));
        const regs = self.regs;
        regs.CR1.modify(.{ .CEN = 0 });
        regs.SR.raw = 0;
        regs.PSC = @min(psc, std.math.maxInt(u16)); //prescaler value, 0 means no prescaler
        regs.ARR.modify(.{ .ARR = arr - 1 });
        regs.EGR.modify(.{ .UG = 1 });
        regs.CR1.modify(.{ .CEN = 1 });
    }

    fn check_event(ctx: *const anyopaque) bool {
        const self: *const GPTimer = @alignCast(@ptrCast(ctx));
        const regs = self.regs;
        return regs.SR.read().UIF == 1;
    }

    fn busy_wait_fn(ctx: *const anyopaque, time: u64) void {
        const self: *const GPTimer = @alignCast(@ptrCast(ctx));
        const regs = self.regs;
        const full_ticks: usize = @intCast(time / std.math.maxInt(u16));
        const partial_ticks: u16 = @intCast(time % std.math.maxInt(u16));

        //set initial counter to partial_ticks then wait for full_ticks
        //this will set timer to partial_ticks then after underflow the ARPE will automatically reload the timer
        //and start counting down from std.math.maxInt(u16) to 0
        regs.SR.raw = 0;
        regs.PSC = 0;
        regs.ARR.modify(.{ .ARR = partial_ticks });
        regs.EGR.modify(.{ .UG = 1 });
        regs.ARR.modify(.{ .ARR = std.math.maxInt(u16) });

        //start counting down
        regs.CR1.modify(.{ .CEN = 1 });

        //wait for all ticks to finish
        //we need to wait for full_ticks + 1 because the first tick is already started
        for (0..full_ticks + 1) |_| {
            //wait for underflow
            while (regs.SR.read().UIF == 0) {}
            //clear UIF flag
            regs.SR.raw = 0;
            //reenable timer (becuse we are in OPM mode)
            regs.CR1.modify(.{ .CEN = 1 });
        }
    }

    //timer configuration
    pub fn configure(self: *const Counter, config: CounterConfig) void {
        const timer = self.gptimer;
        timer.set_update_event(false);
        timer.clear_configs();
        timer.set_interrupt(config.enable_interrupt);
        timer.set_dma_request(config.enable_dma_request);
        timer.set_prescaler(config.prescaler);
        timer.set_auto_reload(config.auto_reload);
        timer.set_auto_relaod_mode(.buffered);
        timer.set_update_request_source(config.event_source);
        timer.set_counter_mode(config.counter_mode);
        timer.set_one_pulse(config.one_pulse_mode);
        timer.set_update_event(true);
        timer.software_update();
    }

    /// This function sets the prescaler, auto-reload value and optionally forces an update event.
    pub fn set_values(self: *const Counter, prescaler: u32, auto_reload: u16, force_update: bool) void {
        const timer = self.gptimer;
        timer.set_prescaler(prescaler);
        timer.set_auto_reload(auto_reload);
        if (force_update) {
            timer.software_update();
        }
    }

    //wrapper functions for Counter Mode API
    pub inline fn start(self: *const Counter) void {
        self.gptimer.start();
    }

    pub inline fn stop(self: *const Counter) void {
        self.gptimer.stop();
    }

    pub inline fn is_running(self: *const Counter) bool {
        return self.gptimer.is_running();
    }

    pub inline fn get_counter(self: *const Counter) u16 {
        return self.gptimer.get_counter();
    }
};

pub const PWMChannelConfig = struct {
    polarity: Polarity = .high, //output polarity, high means active high, low means active low
    invert: bool = false, //if true, the active period will be inverted
    fast_mode: bool = false, //if true, the output will be in fast mode
    clear_enable: bool = false, //if true, the output will be cleared on ETRF high level
    channel_interrupt_enable: bool = false, //if true, the timer will generate an interrupt on channel event
    channel_dma_request_enable: bool = false, //if true, the timer will generate a

};

pub const PMWConfig = struct {
    //in PWM mode, the prescaler is used to divide the clock frequency
    prescaler: u32 = 0,

    //in PWM mode, the auto-reload value is used to set the period of the PWM signal
    auto_reload: u16 = std.math.maxInt(u16), //auto-reload value

    counter_direction: DIR = .Up, //counter direction, Up or Down

    interrupt_enable: bool = false, //if true, the timer will generate an interrupt on update event
    dma_request_enable: bool = false, //if true, the timer will generate a DMA request on update event
    event_source: URS = .CounterOnly, //update request source
};
pub const PWM = struct {
    gptimer: *const GPTimer,

    pub fn configure_PWM(self: *const PWM, config: PMWConfig) void {
        const timer = self.gptimer;
        timer.set_update_event(false);
        timer.clear_configs();
        timer.set_interrupt(config.interrupt_enable);
        timer.set_dma_request(config.dma_request_enable);
        timer.set_prescaler(config.prescaler);
        timer.set_auto_reload(config.auto_reload);
        timer.set_auto_relaod_mode(.buffered);
        timer.set_update_request_source(config.event_source);
        timer.set_update_event(true);
        timer.software_update();
        timer.start();
    }

    pub fn configure_channel(self: *const PWM, channel: u2, config: PWMChannelConfig) void {
        const timer = self.gptimer;
        timer.configure_output(channel, .{
            .mode = if (!config.invert) OCM.PwmMode1 else OCM.PwmMode2,
            .polarity = config.polarity,
            .pre_load = true,
            .clear_enable = config.clear_enable,
            .fast_mode = config.fast_mode,
        });

        timer.set_channel_interrupt(channel, config.channel_interrupt_enable);
        timer.set_channel_dma_request(channel, config.channel_dma_request_enable);
    }

    pub inline fn set_channel(self: *const PWM, channel: u2, set: bool) void {
        self.gptimer.set_channel(channel, set);
    }

    pub inline fn set_duty(self: *const PWM, channel: u2, value: u16) void {
        self.gptimer.load_capture_or_compare(channel, value);
    }

    pub inline fn get_duty(self: *const PWM, channel: u2) u16 {
        return self.gptimer.regs.CCR[channel].read().CCR;
    }

    pub inline fn force_update(self: *const PWM) void {
        self.gptimer.software_update();
    }
};
