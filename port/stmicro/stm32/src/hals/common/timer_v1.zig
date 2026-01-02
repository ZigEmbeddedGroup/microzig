const std = @import("std");
const microzig = @import("microzig");
const enums = @import("enums.zig");
const periferals = microzig.chip.peripherals;

const TIM_GP16 = microzig.chip.types.peripherals.timer_v1.TIM_GP16;
const DIR = microzig.chip.types.peripherals.timer_v1.DIR;
const URS = microzig.chip.types.peripherals.timer_v1.URS;
const CMS = microzig.chip.types.peripherals.timer_v1.CMS;
const CCDS = microzig.chip.types.peripherals.timer_v1.CCDS;
const TI1S = microzig.chip.types.peripherals.timer_v1.TI1S;
const CKD = microzig.chip.types.peripherals.timer_v1.CKD;
const FilterValue = microzig.chip.types.peripherals.timer_v1.FilterValue;
const CCMR_Input_CCS = microzig.chip.types.peripherals.timer_v1.CCMR_Input_CCS;
const ETP = microzig.chip.types.peripherals.timer_v1.ETP;
const ETPS = microzig.chip.types.peripherals.timer_v1.ETPS;
const MSM = microzig.chip.types.peripherals.timer_v1.MSM;
const MMS = microzig.chip.types.peripherals.timer_v1.MMS;
const OCM = microzig.chip.types.peripherals.timer_v1.OCM; //OCM stands for Output Compare Mode

pub const Instances = enums.TIMGP16_Type;

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

pub const Compare = struct {
    mode: OCM,
    clear_enable: bool = false, //if true, the output will be cleared on ETRF high level
    pre_load: bool = false, //always true for PWM mode
    fast_mode: bool = false, //only applies to PWM mode.
};
pub const CaptureModes = enum(u2) {
    ///mode 1 - normal mapping: ICx (Channel x) mapped to TIx
    input_normal = 1,

    ///mode 2 - alternate mapping IC1 = IT2, IC2 = IT1, IC3 = IT4, IC4 = IT3
    input_alternate = 2,

    ///only works if TS bits are set
    input_TRC = 3,
};

pub const CapturePrescaler = enum(u2) {
    ///no prescaler, input clock is the same as timer clock
    no_prescaler = 0,
    ///prescaler divides input clock by 2
    div_2 = 1,
    ///prescaler divides input clock by 4
    div_4 = 2,
    ///prescaler divides input clock by 8
    div_8 = 3,
};

pub const SyncTriggerSource = enum(u3) {
    ITR0, // Internal Trigger 0
    ITR1, // Internal Trigger 1
    ITR2, // Internal Trigger 2
    ITR3, // Internal Trigger 3
    TI1F_ED, // TI1 Edge Detector
    TI1FP1, // Filtered Timer Input 1
    TI2FP2, // Filtered Timer Input 2
    ETRF, // External Trigger input (TIM2 is the only general-purpose timer that has the ETR pin)
};

pub const SyncMode = enum(u3) {
    Disabled, // Sync mode disabled
    EncoderMode1, // Counter counts up/down on TI2FP1 edge depending on TI1FP2 level
    EncoderMode2, // Counter counts up/down on TI1FP2 edge depending on TI2FP1 level
    EncoderMode3, // Counter counts up/down on both TI1FP1 and TI2FP2 edges depending on the level of the other input
    ResetMode, // Rising edge of the selected trigger input (TRGI) reinitializes the counter and generates an update of the registers
    GatedMode, // Counter clock is enabled when the trigger input (TRGI) is high
    TriggerMode, // Counter starts at a rising edge of the trigger TRGI
    ExternalClockMode1, // Rising edges of the selected trigger (TRGI) clock the counter
};

pub const InterruptFlags = packed struct(u6) {
    update: bool = false,
    channel1: bool = false,
    channel2: bool = false,
    channel3: bool = false,
    channel4: bool = false,
    trigger: bool = false,
};

pub const Capture = struct {
    mode: CaptureModes = .input_normal,
    prescaler: CapturePrescaler = .no_prescaler, //prescaler for the input clock
    filter: FilterValue = .NoFilter, //filter value for the input clock, no
};

pub const CCR = union(enum) {
    capture: Capture,
    compare: Compare,
};
///capture/compare configuration
pub const CCConfig = struct {
    ch_mode: CCR,
    polarity: Polarity = .high,
    channel_interrupt_enable: bool = false, //if true, the selected channel will generate an interrupt on event

    //channel DMA depends on the channel dma trigger setting
    channel_dma_request_enable: bool = false, //if true, the selected channel will generate an DMA request on event
};

///NOTE:The gated mode must not be used if TI1F_ED is selected as the trigger input (TS=100).
//Indeed, TI1F_ED outputs 1 pulse for each transition on TI1F, whereas the gated mode
//checks the level of the trigger signal.
//The clock of the sync timer must be enabled prior to receiving events from the TRGI
//timer, and must not be changed on-the-fly while triggers are received from the TRGI
//timer.
//Reference Manual 008 | page: 408
pub const SyncModeConfig = struct {
    mode: SyncMode = .Disabled,
    trigger_source: SyncTriggerSource = .ITR0,
    sync: MSM = .NoSync,
    //external trigger configs
    ext_trig_polarity: ETP = .NotInverted,
    ext_clock_mode2: bool = false,
    ext_trig_prescaler: ETPS = .Div1,
    ext_trig_filter: FilterValue = .NoFilter,
};

pub const TimerGenealConfig = struct {
    prescaler: u16 = 0, //prescaler value, 0 means no prescaler
    auto_reload: u16 = std.math.maxInt(u16),
    auto_reload_mode: ARRModes = .buffered, //auto-reload mode, buffered or immediate
    counter_mode: CounterMode = .up,
    one_pulse_mode: bool = false, //if true, timer will stop after one pulse
    event_source: URS = .CounterOnly, //update request source
    clock_division: CKD = .Div1, // <- tDTS signal
    TI1_source: TI1S = .Normal,

    enable_update_interrupt: bool = false, //if true, timer will generate an interrupt on update event
    enable_update_dma_request: bool = false, //if true, timer will generate a DMA request on update event
    channel_dma_trigger: CCDS = .OnCompare, //selects when the DMA request is generated, applies to all channels
    trigger_output: MMS = .Reset,
    sync_config: ?SyncModeConfig = null,
};

///General Purpose Timer (GPTimer) driver for STM32F1xx series,
///
///This driver provides a low-level interface for the  16bits general-purpose timers.
///but, it does provide a high-level API for basic counter mode and PWM mode.
///
///This driver supports the following modes:
///- Basic counter mode.
///- Capture mode.
///- Compare mode <- includes PWM mode.
///- sync and TRGI modes for synchronization with other timers (TODO).
///- DMA support for update and compare events.
///- Interrupt support for update and compare events.
///- DMA burst support for update and compare events (TODO).
pub const GPTimer = struct {
    regs: *volatile TIM_GP16,
    //=============== Modes ================
    pub fn init(comptime instance: Instances) GPTimer {
        return .{ .regs = enums.get_regs(TIM_GP16, instance) };
    }

    ///Get high-level timer API for the Basic counter mode.
    pub fn into_counter_mode(self: *const GPTimer) Counter {
        return Counter{ .gptimer = self };
    }

    pub fn into_pwm_mode(self: *const GPTimer) PWM {
        return PWM{ .gptimer = self };
    }

    //=============Timer low level functions=============

    pub fn timer_general_config(self: *const GPTimer, config: TimerGenealConfig) void {
        const regs = self.regs;
        //disable timer before configuring
        self.clear_configs();
        self.set_update_event(false); //disable update event to prevent unwanted updates
        regs.PSC = config.prescaler;
        regs.ARR.modify(.{ .ARR = config.auto_reload });
        regs.CR1.modify(.{
            .CKD = config.clock_division,
            .OPM = @as(u1, @intFromBool(config.one_pulse_mode)),
            .ARPE = @as(u1, @intFromEnum(config.auto_reload_mode)),
            .URS = config.event_source,
        });
        regs.CR2.modify(.{
            .CCDS = config.channel_dma_trigger,
            .TI1S = config.TI1_source,
            .MMS = config.trigger_output,
        });
        self.set_counter_mode(config.counter_mode);
        const enable_dma: u1 = @intFromBool(config.enable_update_dma_request);
        const enable_interrupt: u1 = @intFromBool(config.enable_update_interrupt);

        regs.DIER.modify(.{
            .UIE = enable_interrupt,
            .UDE = enable_dma,
            .TIE = enable_interrupt,
            .TDE = enable_dma,
        });
        if (config.sync_config) |s_conf| self.config_sync_mode(s_conf);
        self.set_update_event(true); //enable update event
        self.software_update();
    }

    ///This function clears all control registers of the timer.
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
        self.regs.SMCR.raw = 0;
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

    pub inline fn set_cdk(self: *const GPTimer, ckd: CKD) void {
        self.regs.CR1.modify(.{ .CKD = ckd });
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
        self.regs.DIER.modify(.{ .TIE = @as(u1, @intFromBool(set)) });
    }

    pub inline fn set_dma_request(self: *const GPTimer, set: bool) void {
        self.regs.DIER.modify(.{ .TDE = @as(u1, @intFromBool(set)) });
    }

    pub inline fn set_update_interrupt(self: *const GPTimer, set: bool) void {
        self.regs.DIER.modify(.{ .UIE = @as(u1, @intFromBool(set)) });
    }

    pub inline fn set_update_dma_request(self: *const GPTimer, set: bool) void {
        self.regs.DIER.modify(.{ .UDE = @as(u1, @intFromBool(set)) });
    }

    pub fn get_interrupt_flags(self: *const GPTimer) InterruptFlags {
        const sr = self.regs.SR.read();
        return InterruptFlags{
            .update = (sr.UIF == 1),
            .channel1 = (sr.@"CCIF[0]" == 1),
            .channel2 = (sr.@"CCIF[1]" == 1),
            .channel3 = (sr.@"CCIF[2]" == 1),
            .channel4 = (sr.@"CCIF[3]" == 1),
            .trigger = (sr.TIF == 1),
        };
    }

    pub fn clear_interrupts(self: *const GPTimer) void {
        self.regs.SR.modify(.{
            .UIF = 0,
            .@"CCIF[0]" = 0,
            .@"CCIF[1]" = 0,
            .@"CCIF[2]" = 0,
            .@"CCIF[3]" = 0,
            .TIF = 0,
        });
    }

    pub inline fn set_channels_dma_trigger(self: *const GPTimer, ccds: CCDS) void {
        self.regs.CR2.modify(.{ .CCDS = ccds });
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

    //=============== sync mode Functions ================
    pub fn config_sync_mode(self: *const GPTimer, config: SyncModeConfig) void {
        self.regs.SMCR.modify(.{
            .ETP = config.ext_trig_polarity,
            .ECE = @as(u1, @intFromBool(config.ext_clock_mode2)),
            .ETPS = config.ext_trig_prescaler,
            .ETF = config.ext_trig_filter,
            .MSM = config.sync,
            .TS = @as(u3, @intFromEnum(config.trigger_source)),
            .SMS = @as(u3, @intFromEnum(config.mode)),
        });
    }

    //=============== Compare/Capture Functions ============
    pub inline fn load_ccr(self: *const GPTimer, channel: u2, value: u16) void {
        self.regs.CCR[channel].modify(.{ .CCR = value });
    }

    pub inline fn read_ccr(self: *const GPTimer, channel: u2) u16 {
        return self.regs.CCR[channel].read().CCR;
    }

    pub fn set_channel(self: *const GPTimer, channel: u2, set: bool) void {
        const regs = self.regs;
        if (set) {
            regs.CCER.raw |= @as(u32, 0b1) << (@as(u5, channel) * 4); //CCxE bits
        } else {
            regs.CCER.raw &= ~(@as(u32, 0b1) << (@as(u5, channel) * 4)); //CCxE bits
        }
    }

    pub fn set_polarity(self: *const GPTimer, channel: u2, polarity: Polarity) void {
        const regs = self.regs;
        const offset: u5 = @as(u5, channel) * 4 + 1; //CCxP bits offset

        switch (polarity) {
            .high => {
                regs.CCER.raw &= ~(@as(u32, 0b1) << offset); //clear CCxP bits
            },
            .low => {
                regs.CCER.raw |= @as(u32, 0b1) << offset; //set CCxP bits
            },
        }
    }

    pub fn configure_ccr(self: *const GPTimer, channel: u2, config: CCConfig) void {
        switch (config.ch_mode) {
            .capture => |capture| {
                self.configure_input(channel, capture);
            },
            .compare => |compare| {
                self.configure_output(channel, compare);
            },
        }
        //set polarity
        self.set_polarity(channel, config.polarity);
        self.set_channel_interrupt(channel, config.channel_interrupt_enable);
        self.set_channel_dma_request(channel, config.channel_dma_request_enable);
    }

    pub fn configure_output(self: *const GPTimer, channel: u2, config: Compare) void {
        const regs = self.regs;
        const CCMR = if (channel < 2) &regs.CCMR_Input[0] else &regs.CCMR_Input[1];
        const offset: u5 = if (channel % 2 == 0) 0 else 8;

        CCMR.raw &= ~(@as(u32, 0b11) << offset); //clear mode bits, set output compare mode (00)

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
    }

    pub fn configure_input(self: *const GPTimer, channel: u2, config: Capture) void {
        const regs = self.regs;
        const CCMR = if (channel < 2) &regs.CCMR_Input[0] else &regs.CCMR_Input[1];
        const ccs: CCMR_Input_CCS = @enumFromInt(@intFromEnum(config.mode));
        const psc: u2 = @intFromEnum(config.prescaler);
        if (channel % 2 == 0) {
            CCMR.modify(.{
                .@"CCS[0]" = ccs,
                .@"ICPSC[0]" = psc,
                .@"ICF[0]" = config.filter,
            });
        } else {
            CCMR.modify(.{
                .@"CCS[1]" = ccs,
                .@"ICPSC[1]" = psc,
                .@"ICF[1]" = config.filter,
            });
        }
    }
};

//============ Counter mode ============

///High level API for the Basic Counter Mode of the GPTimer.
pub const Counter = struct {
    gptimer: *const GPTimer,

    //timer configuration
    pub inline fn configure(self: *const Counter, config: TimerGenealConfig) void {
        self.gptimer.timer_general_config(config);
    }

    ///This function sets the prescaler, auto-reload value and optionally forces an update event.
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

pub const PWMChConfig = struct {
    polarity: Polarity = .high, //output polarity, high means active high, low means active low
    invert: bool = false, //switch between PWM mode 1 and mode 2, mode1: normal PWM, mode2: invertded PWM period.
    clear_enable: bool = false, //if true, the output will be cleared on ETRF high level
    fast_mode: bool = false, //if true, the output will be in fast mode, only applies to PWM mode
    channel_interrupt_enable: bool = false, //if true, the timer will generate an interrupt on channel event
    channel_dma_request_enable: bool = false, //if true, the timer will generate a DMA request on channel event
};

//high-level API for the PWM mode of the GPTimer.
pub const PWM = struct {
    gptimer: *const GPTimer,

    pub inline fn configure(self: *const PWM, config: TimerGenealConfig) void {
        const timer = self.gptimer;
        timer.timer_general_config(config);
        timer.start();
    }

    ///This function configures the output channel for PWM mode.
    pub fn configure_channel(self: *const PWM, channel: u2, config: PWMChConfig) void {
        const timer = self.gptimer;
        timer.configure_ccr(channel, .{
            .ch_mode = .{
                .compare = .{
                    .mode = if (config.invert) OCM.PwmMode1 else OCM.PwmMode1,
                    .clear_enable = config.clear_enable,
                    .pre_load = true, //always true for PWM mode
                    .fast_mode = config.fast_mode,
                },
            },
            .polarity = config.polarity,
            .channel_interrupt_enable = config.channel_interrupt_enable,
            .channel_dma_request_enable = config.channel_dma_request_enable,
        });
    }

    pub inline fn set_channel(self: *const PWM, channel: u2, set: bool) void {
        self.gptimer.set_channel(channel, set);
    }

    pub inline fn set_duty(self: *const PWM, channel: u2, value: u16) void {
        self.gptimer.load_ccr(channel, value);
    }

    pub inline fn get_duty(self: *const PWM, channel: u2) u16 {
        return self.gptimer.regs.CCR[channel].read().CCR;
    }

    pub inline fn set_period(self: *const PWM, period: u16) void {
        self.gptimer.set_auto_reload(period);
    }

    pub inline fn get_period(self: *const PWM) u16 {
        return self.gptimer.get_auto_reload();
    }

    pub inline fn force_update(self: *const PWM) void {
        self.gptimer.software_update();
    }
};
