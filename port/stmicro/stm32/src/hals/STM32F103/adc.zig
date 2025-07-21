const std = @import("std");
const microzig = @import("microzig");
const drivers = @import("drivers.zig");
const utils = @import("util.zig");
const periferals = microzig.chip.peripherals;
const adc_regs = microzig.chip.types.peripherals.adc_f1.ADC;
const CounterDevice = drivers.CounterDevice;
const timeout = drivers.Timeout;
const DUALMOD = microzig.chip.types.peripherals.adc_f1.DUALMOD;

const ADC_inst = utils.create_peripheral_enum("ADC", "adc_f1");

pub const SampleRate = enum(u3) {
    @"1.5" = 0,
    @"7.5" = 1,
    @"13.5" = 2,
    @"28.5" = 3,
    @"41.5" = 4,
    @"55.5" = 5,
    @"71.5" = 6,
    @"239.5" = 7,
};
pub const Alignment = enum(u1) {
    Right = 0,
    Left = 1,
};

pub const ReadError = error{
    InvalidChannel,
    ADCNotEnabled,
};

fn get_regs(comptime adc: ADC_inst) *volatile adc_regs {
    return @field(microzig.chip.peripherals, @tagName(adc));
}

///1ms, the actual stabilization time is in microseconds, but we use 1ms to be safe with all microcontrollers
pub var STAB_TIME: u32 = 1000; //1ms in microseconds

///1ms, this is the time to stabilize Vrefint and temperature sensor
pub var STAB_VREFE_TIME: u32 = 1000;

pub const ADC = struct {
    regs: *volatile adc_regs,

    pub fn enable(self: *const ADC, Counter: *const CounterDevice) void {
        const regs = self.regs;
        regs.CR2.raw = 0; //force reset
        regs.CR2.modify(.{ .ADON = 1 }); //enable ADC

        //wait for ADC stabilization time
        Counter.sleep_us(STAB_TIME);

        regs.CR2.modify(.{ .CAL = 1 }); //start calibration

        //wait for calibration to finish
        while (regs.CR2.read().CAL == 1) {
            asm volatile ("" ::: .{ .memory = true });
        }
        regs.SR.raw = 0; //clear all status flags

        regs.CR2.modify(.{
            .TSVREFE = 1, //enable temperature sensor and Vrefint
            .EXTSEL = 0b111, // by default set to SWSTART, which is software trigger
            .EXTTRIG = 1, //by default enable external trigger
        });

        Counter.sleep_us(STAB_VREFE_TIME); //wait for Vrefint and temperature sensor to stabilize
    }

    pub fn disable(self: *const ADC) void {
        const regs = self.regs;
        regs.CR2.raw = 0; //force reset
    }

    pub fn set_channel_sample_rate(self: *const ADC, channel: u5, sample_rate: SampleRate) void {
        if (channel > 18) return; //invalid channel, do nothing
        const regs = self.regs;
        const smpr_index = if (channel < 10) channel else channel - 10;
        const rate: u32 = @intFromEnum(sample_rate);
        const smpr_val = rate << (smpr_index * 3);
        if (channel < 10) {
            regs.SMPR2.raw |= smpr_val;
        } else {
            regs.SMPR1.raw |= smpr_val;
        }
    }

    pub fn set_multiple_channels_sample_rate(self: *const ADC, sample_rates: []const SampleRate) void {
        const len = @min(sample_rates.len, 18);
        for (0..len, sample_rates) |i, rate| {
            self.set_channel_sample_rate(@intCast(i), rate);
        }
    }

    /// Read a single channel and returns the value.
    ///
    /// NOTE: this is a blocking call, it will wait for the conversion to finish.
    pub fn read_single_channel(self: *const ADC, channel: u5) ReadError!u16 {
        if (channel > 18) return ReadError.InvalidChannel;
        const regs = self.regs;
        const cr2 = regs.CR2.read();
        if (cr2.ADON == 0) return ReadError.ADCNotEnabled;
        regs.SQR1.modify(.{ .L = 0 }); //set number of conversions to 1
        regs.SQR3.modify(.{ .@"SQ[0]" = channel }); //set the channel to read
        regs.CR2.modify(.{ .SWSTART = 1 }); //start conversion, if software trigger is not enabled, this will do nothing

        //wait for conversion to finish
        while (regs.SR.read().EOC == 0) {
            asm volatile ("" ::: .{ .memory = true });
        }
        const result: u16 = regs.DR.read().DATA; //read the data registe, this will also clear the EOC flag
        regs.SR.modify(.{ .STRT = 0 }); //clear the START flag
        return result;
    }

    ///load a sequence of channels to be converted by `read_multiple_channels` function.
    /// the read sequence is determined by the order of the channels in the sequence array.
    /// only the first 16 sequence elements are used, the rest are ignored.
    pub fn load_sequence(self: *const ADC, sequence: []const u5) void {
        const regs = self.regs;
        const len = @min(17, sequence.len);
        const to_load = sequence[0..len];
        for (to_load, 0..len) |sq, index| {
            const bit_index: u5 = @intCast((index % 6) * 5); //each channel takes 5 bits
            const mask = @as(u32, sq) << bit_index;
            if (index < 6) {
                regs.SQR3.raw |= mask; //load into SQR3
            } else if (index < 12) {
                regs.SQR2.raw |= mask; //load into SQR2
            } else {
                regs.SQR1.raw |= mask; //load into SQR1
            }
        }
        regs.SQR1.modify(.{ .L = @as(u4, @intCast(len - 1)) }); //set number of conversions
    }

    /// Read multiple channels and returns the values in the order they were loaded in `load_sequence`.
    ///
    /// NOTE: this is a blocking call, it will wait for All conversion to finish.
    pub fn read_multiple_channels(self: *const ADC, recv: []u16) ReadError![]const u16 {
        const regs = self.regs;
        const cr2 = regs.CR2.read();
        if (cr2.ADON == 0) return ReadError.ADCNotEnabled;
        const seq_len = regs.SQR1.read().L + 1; //get the number of conversions
        const len = @min(recv.len, seq_len);
        const to_read = recv[0..len];

        regs.SR.raw = 0; //clear all status flag

        regs.CR1.modify(.{
            .DISCEN = 1,
            .DISCNUM = 0,
        }); //discontinuous mode

        regs.CR2.modify(.{ .SWSTART = 1 }); //start conversion, if software trigger is not enabled, this will do nothing

        for (to_read) |*data| {
            while (regs.SR.read().EOC == 0) {
                asm volatile ("nop");
            }
            data.* = regs.DR.read().DATA; //read the data register, this will also clear the EOC flag
            regs.CR2.modify(.{ .SWSTART = 1 }); //start conversion, if software trigger is not enabled, this will do nothing

        }
        regs.SR.raw = 0; //clear all status flag

        regs.CR1.modify(.{
            .DISCEN = 0,
        }); //disable scan mode

        return to_read;
    }

    pub fn init(comptime adc: ADC_inst) ADC {
        return .{
            .regs = get_regs(adc),
        };
    }
};

pub const RegularTrigger = enum(u3) {
    TIM1_CC1 = 0,
    TIM1_CC2 = 1,
    TIM1_CC3 = 2,
    TIM2_CC2 = 3,
    TIM3_TRGO = 4,
    TIM4_CC4 = 5,
    EXTI11_TIM8_TRGO = 6, // TIM8_TRGO is available only in high-density and XL-density devices
    SWSTART = 7,
};

pub const InjectedTrigger = enum(u3) {
    TIM1_TRGO = 0,
    TIM1_CC4 = 1,
    TIM2_TRGO = 2,
    TIM2_CC1 = 3,
    TIM3_CC4 = 4,
    TIM4_TRGO = 5,
    EXTI15_TIM8_CC4 = 6, // TIM8_CC4 is available only in high-density and XL-density devices
    SWSTART = 7,
};

pub const Channel = struct {
    channel: u5,
    sample_rate: SampleRate = .@"13.5", //default sample rate
};

pub const Sequence = struct {
    seq: []const u5, //sequence of channels to read, max 17 channels
    channels_conf: ?[]const Channel = null, //optional channel configuration, if not provided, the sample rate will be not modified
};

pub const Discontinuous = struct {
    channels: Sequence,
    ///number of conversions per trigger,in this API length starts from 1 instead of 0
    length: u3 = 1, //default length is 1
};

pub const Flags = packed struct(u5) {
    watchdog: bool = false,
    regular_eoc: bool = false,
    injected_eoc: bool = false,
    injected_start: bool = false,
    regular_start: bool = false,
};

pub const RegularModes = union(enum) {
    Single: Sequence,
    Continuous: Sequence,
    Discontinuous: Discontinuous,
};
pub const RegularConfig = struct {
    mode: RegularModes,
    trigger: RegularTrigger = .SWSTART,
    dma: bool = false,
    interrupt: bool = false,
};

pub const InjectedModes = union(enum) {
    auto_injected: Sequence,
    Single: Sequence,
    Discontinuous: Discontinuous,
};

///define the offset to be subtracted from the raw converted data when converting injected channels.
pub const InjectedOffsets = struct {
    SEQ1: u11 = 0,
    SEQ2: u11 = 0,
    SEQ3: u11 = 0,
    SEQ4: u11 = 0,
};

pub const InjectedConfig = struct {
    trigger: InjectedTrigger = .SWSTART,
    interrupt: bool = false,
    offsets: InjectedOffsets = .{},
    mode: InjectedModes,
};

pub const SimultaneousInjected = struct {
    trigger: InjectedTrigger = .SWSTART,

    primary_seq: []const u5, //sequence of channels to read for primary ADC, max 4 channels
    primary_offsets: InjectedOffsets = .{},
    primary_interrupt: bool = false,

    secondary_seq: []const u5, //sequence of channels to read for secondary ADC, max 4 channels
    secondary_offsets: InjectedOffsets = .{},
    secondary_interrupt: bool = false,

    ///in dual mode both ADCs must have the same sample rates for the channels.
    ///if not provided, the sample rates will be set to the primary ADC sample rates values
    rate_seq: ?[]const SampleRate = null,
};

pub const SimRegModes = union(enum) {
    Single: void,
    Continuous: void,
    Discontinuous: u3,
};

pub const SimultaneousRegular = struct {
    ///even though DMA is an optional feature, it is highly recommended to use it.
    /// especially in applications that require high sampling rates.
    ///
    /// NOTE: without DMA the ADC secondary value cannot be read from the primary ADC registers,
    /// NOTE: in Dualmode DMA request are 32bits wide.
    dma: bool = false,
    mode: SimRegModes,
    trigger: RegularTrigger = .SWSTART,
    primary_seq: []const u5, //sequence of channels to read for primary ADC, max 17 channels
    primary_interrupt: bool = false,
    secondary_seq: []const u5, //sequence of channels to read for secondary ADC, max 17 channels
    secondary_interrupt: bool = false,
    ///in dual mode both ADCs must have the same sample rates for the channels.
    ///if not provided, the sample rates will not be modified.
    /// Ignore only if the sample rates are already set for the channels.
    rate_seq: ?[]const SampleRate = null,
};

pub const Interleaved = struct {
    interrupt: bool = false, //in this mode only the primary ADC can generate an interrupt
    ///same as in `SimultaneousRegular`
    dma: bool = false,
    ///NOTE: this config only have effect if the ADC is in Fast interleaved.
    continuos: bool = false,
    trigger: RegularTrigger = .SWSTART,
    channel: Channel, //channel to read in interleaved mode

};

/// `RegularInjected` and `RegularAlternateTrigger` modes
///
/// these modes use the same configuration but with different behavior.
pub const RegularInjetedCombined = struct {
    Injected: SimultaneousInjected,
    Regular: SimultaneousRegular,
};

/// `FastInterleaved` and `SlowInterleaved` modes
///
/// these modes use the same configuration but with different behavior.
pub const InterleavedInjectedCombined = struct {
    Injected: SimultaneousInjected,
    Regular: Interleaved,
};
pub const DualModeSelection = union(DUALMOD) {
    Independent: void,
    RegularInjected: RegularInjetedCombined,
    RegularAlternateTrigger: RegularInjetedCombined,
    InjectedFastInterleaved: InterleavedInjectedCombined,
    InjectedSlowInterleaved: InterleavedInjectedCombined,
    Injected: SimultaneousInjected,
    Regular: SimultaneousRegular,
    FastInterleaved: Interleaved,
    SlowInterleaved: Interleaved,
    AlternateTrigger: SimultaneousInjected,
};

pub const RegularConfigError = error{
    InvalidADC,
    InvalidMode,
    InvalidTrigger,
    InvalidChannel,
    InvalidSampleRate,
    InvalidLength,
    InvalidSequence,
};

pub const DualConfigError = error{
    invalidSequence,
    ADC2NotEnabled,
    ADC2NotSupported,
} || RegularConfigError;

pub const WatchdogGuards = union(enum) {
    disable: void,
    all_regular: void,
    all_injected: void,
    all: void,
    single_regular: u5,
    single_injected: u5,
    single: u5,
};

pub const Watchdog = struct {
    guard_mode: WatchdogGuards,
    high_treshold: u12,
    low_treshold: u12,
    interrupt: bool = true,
};

//NOTE: before making any write to the CR2 bit, it is necessary to check if the write will change the current value of the register
//otherwise, it will result in an accidental trigger
pub const AdvancedADC = struct {
    regs: *volatile adc_regs,
    adc_num: usize,

    //==========ADC init functions===========

    ///enable the ADC and optionally calibrate it.
    pub fn enable(self: *const AdvancedADC, calib: bool, Counter: *const CounterDevice) void {
        const regs = self.regs;
        if (regs.CR2.read().ADON == 0) {
            regs.CR2.modify(.{ .ADON = 1 }); //enable ADC

            //wait for ADC stabilization time
            Counter.sleep_us(STAB_TIME);
        }

        if (calib) {
            _ = self.calibrate();
        }
    }

    ///disable the ADC.
    ///
    /// NOTE: This will not reset the ADC config, it will just put ADC in power down mode.
    pub fn disable(self: *const AdvancedADC) void {
        const regs = self.regs;
        regs.CR2.modify(.{ .ADON = 0 }); //disable ADC
    }

    ///clear all ADC configuration registers
    ///
    /// NOTE: this is also put the ADC in power down mode.
    pub fn clear_config(self: *const AdvancedADC) void {
        const regs = self.regs;
        regs.CR2.raw = 0; //force reset
        regs.CR1.raw = 0; //force reset
        regs.SQR1.raw = 0; //force reset
        regs.SQR2.raw = 0; //force reset
        regs.SQR3.raw = 0; //force reset
        regs.SMPR1.raw = 0; //force reset
        regs.SMPR2.raw = 0; //force reset
    }

    ///calibrate the ADC and return the calibration data.
    ///
    /// NOTE: This function should be called after the ADC is enabled.
    pub fn calibrate(self: *const AdvancedADC) u16 {
        const regs = self.regs;
        regs.CR2.modify(.{ .CAL = 1 }); //start calibration

        //wait for calibration to finish
        while (regs.CR2.read().CAL == 1) {
            asm volatile ("" ::: .{ .memory = true });
        }
        const data = regs.DR.read().DATA;
        return data;
    }

    ///re-calibrate the ADC and return the calibration data.
    ///
    /// NOTE: This function should be called after the ADC is enabled.
    pub fn reset_calibration(self: *const AdvancedADC) u16 {
        const regs = self.regs;
        regs.CR2.modify(.{ .RTSCAL = 1 }); //reset calibration
        //wait for reset to finish
        while (regs.CR2.read().RTSCAL == 1) {
            asm volatile ("" ::: .{ .memory = true });
        }
        return regs.DR.read().DATA; //read the calibration data

    }

    ///enable the temperature sensor and Vrefint.
    ///NOTE: This function should be called after the ADC is enabled.
    pub fn enable_reftemp(self: *const AdvancedADC, Counter: *const CounterDevice) void {
        const regs = self.regs;
        regs.CR2.modify(.{ .TSVREFE = 1 }); //enable temperature sensor and Vrefint
        //wait for Vrefint and temperature sensor to stabilize
        Counter.sleep_us(STAB_VREFE_TIME);
    }

    pub fn set_data_alignment(self: *const AdvancedADC, aling: Alignment) void {
        const regs = self.regs;
        regs.CR2.modify(.{ .ALIGN = @intFromEnum(aling) }); //set data alignment
    }

    pub fn read_flags(self: *const AdvancedADC) Flags {
        const val: u5 = @truncate(self.regs.SR.raw);
        return @bitCast(val);
    }

    pub fn clear_flags(self: *const AdvancedADC, flags: Flags) void {
        const val: u5 = @bitCast(flags);
        self.regs.SR.raw &= ~val;
    }

    //========== ADC Regular conversion functions ===========

    ///set the regular group configuration.
    ///
    /// NOTE: DO NOT CALL THIS FUNCTION IF DUALMODE IS ENABLED!
    pub fn configure_regular(self: *const AdvancedADC, config: RegularConfig) RegularConfigError!void {
        const regs = self.regs;

        switch (config.mode) {
            .Single => |seq| {
                try self.set_regular_seq(seq, false);
            },
            .Continuous => |seq| {
                try self.set_regular_seq(seq, true);
            },
            .Discontinuous => |disc| {
                try self.set_regular_discontinuous(disc);
            },
        }

        if (self.adc_num == 2 and config.dma) return RegularConfigError.InvalidADC; //only ADC1 and ADC3 can use DMA

        regs.CR1.modify(.{ .EOCIE = @as(u1, if (config.interrupt) 1 else 0) });

        const cr2_read = regs.CR2.read();
        const trig_sel: u3 = @intFromEnum(config.trigger);
        const dma: u1 = @intFromBool(config.dma);
        if ((cr2_read.DMA != dma) or (cr2_read.EXTTRIG != trig_sel))
            regs.CR2.modify(.{
                .EXTSEL = trig_sel,
                .EXTTRIG = 1,
                .DMA = dma,
            });
    }

    pub fn set_regular_seq(self: *const AdvancedADC, seq: Sequence, continuos: bool) RegularConfigError!void {
        const regs = self.regs;
        const len = seq.seq.len;
        const cr2_state = regs.CR2.read();
        const val: u1 = @intFromBool(continuos);
        if (len == 0) {
            return RegularConfigError.InvalidSequence;
        } else if (len > 17) {
            return RegularConfigError.InvalidSequence; //max length is 18 [0..16]
        }

        regs.CR1.modify(.{
            .SCAN = 1, //enable scan mode
            .DISCEN = 0, //disable discontinuous mode
        });
        self.load_sequence(seq.seq);
        if (seq.channels_conf) |channels| {
            for (channels) |ch| {
                if (ch.channel > 17) return RegularConfigError.InvalidChannel;
                self.set_channel_sample_rate(ch.channel, ch.sample_rate);
            }
        }

        if (val != cr2_state.CONT) {
            regs.CR2.modify(.{ .CONT = val }); //set conversion mode
        }
    }

    pub fn set_regular_discontinuous(self: *const AdvancedADC, disc: Discontinuous) RegularConfigError!void {
        const regs = self.regs;
        //in this API length starts from 1 instead of 0
        if (disc.length == 0) {
            return RegularConfigError.InvalidLength;
        } else if (disc.length > 8) {
            return RegularConfigError.InvalidLength; //max length is 8
        }

        if (regs.CR1.read().JDISCEN == 1) {
            return RegularConfigError.InvalidMode; //discontinuous mode is already enabled for injected
        }

        if (regs.CR2.read().CONT == 1) {
            regs.CR2.modify(.{ .CONT = 0 }); //clear conversion mode
        }

        regs.CR1.modify(.{
            .SCAN = 1, //enable scan mode
            .DISCEN = 1, //enable discontinuous mode
            .DISCNUM = @as(u3, disc.length - 1),
        });

        self.load_sequence(disc.channels.seq);
        if (disc.channels.channels_conf) |channels| {
            for (channels) |ch| {
                if (ch.channel > 17) return RegularConfigError.InvalidChannel;
                self.set_channel_sample_rate(ch.channel, ch.sample_rate);
            }
        }
    }

    ///set sample rate for a specific channel.
    ///
    /// NOTE: DO NOT USE THIS FUNCTION IF DUAL MODE IS ENABLED!
    pub fn set_channel_sample_rate(self: *const AdvancedADC, channel: u5, sample_rate: SampleRate) void {
        if (channel > 18) return; //invalid channel, do nothing
        const regs = self.regs;
        const smpr_index = if (channel < 10) channel else channel - 10;
        const rate: u32 = @intFromEnum(sample_rate);
        const smpr_val = rate << (smpr_index * 3);
        if (channel < 10) {
            regs.SMPR2.raw |= smpr_val;
        } else {
            regs.SMPR1.raw |= smpr_val;
        }
    }

    ///set sample rate for a specific channels.
    ///
    /// NOTE: DO NOT USE THIS FUNCTION IF DUAL MODE IS ENABLED!
    pub fn set_multiple_channels_sample_rate(self: *const AdvancedADC, sample_rates: []const SampleRate) void {
        const len = @min(sample_rates.len, 18);
        for (0..len, sample_rates) |i, rate| {
            self.set_channel_sample_rate(@intCast(i), rate);
        }
    }

    ///load a sequence of channels to be converted by `read_multiple_channels` function.
    /// the read sequence is determined by the order of the channels in the sequence array.
    /// only the first 16 sequence elements are used, the rest are ignored.
    ///
    /// NOTE: DO NOT USE THIS FUNCTION IF DUAL MODE IS ENABLED!
    pub fn load_sequence(self: *const AdvancedADC, sequence: []const u5) void {
        const regs = self.regs;
        const len = @min(16, sequence.len);
        const to_load = sequence[0..len];
        for (to_load, 0..len) |sq, index| {
            const bit_index: u5 = @intCast((index % 6) * 5); //each channel takes 5 bits
            const mask = @as(u32, sq) << bit_index;
            if (index < 6) {
                regs.SQR3.raw |= mask; //load into SQR3
            } else if (index < 12) {
                regs.SQR2.raw |= mask; //load into SQR2
            } else {
                regs.SQR1.raw |= mask; //load into SQR1
            }
        }
        regs.SQR1.modify(.{ .L = @as(u4, @intCast(len - 1)) }); //set number of conversions
    }

    // ========== ADC Regular conversion Util functions ===========

    ///start conversion, if software trigger is not enabled, this will do nothing
    pub fn software_trigger(self: *const AdvancedADC) void {
        const regs = self.regs;
        regs.SR.modify(.{
            .EOC = 0,
            .STRT = 0,
        });
        regs.CR2.modify(.{ .SWSTART = 1 });
    }

    pub fn set_DMA(self: *const AdvancedADC, set: bool) void {
        const regs = self.regs;
        const val: u1 = @intFromBool(set);
        if (regs.CR2.read().DMA != val) {
            regs.CR2.modify(.{ .DMA = val });
        }
    }

    pub fn set_interrupt(self: *const AdvancedADC, set: bool) void {
        const regs = self.regs;
        regs.CR1.modify(.{ .EOCIE = @as(u1, @intFromBool(set)) });
    }

    pub fn set_trigger(self: *const AdvancedADC, trigger: RegularTrigger) void {
        const regs = self.regs;
        const trig_sel: u3 = @intFromEnum(trigger);
        const cr2 = regs.CR2.read();
        if (cr2.EXTSEL != trig_sel) {
            regs.CR2.modify(.{
                .EXTSEL = trig_sel,
                .EXTTRIG = 1,
            });
        }
    }

    //========== ADC Injected conversion read functions ===========

    ///start conversion for the injected group, if software trigger is not enabled, this will do nothing
    pub fn software_injected_trigger(self: *const AdvancedADC) void {
        const regs = self.regs;
        regs.SR.modify(.{
            .JEOC = 0,
            .JSTRT = 0,
        });
        regs.CR2.modify(.{ .JSWSTART = 1 });
    }

    ///read the injected group conversion data.
    /// this value can be negative if offssets are set.
    ///
    ///NOTE: in dual mode the secondary data is read from the secondary ADC registers
    pub fn read_injected_data(self: *const AdvancedADC, index: u2) i16 {
        const regs = self.regs;
        return @bitCast(regs.JDR[index].read().JDATA);
    }

    pub fn set_injected_offsets(self: *const AdvancedADC, offsets: InjectedOffsets) void {
        const regs = self.regs;
        regs.JOFR[0].modify(.{ .JOFFSET = offsets.SEQ1 });
        regs.JOFR[1].modify(.{ .JOFFSET = offsets.SEQ2 });
        regs.JOFR[2].modify(.{ .JOFFSET = offsets.SEQ3 });
        regs.JOFR[3].modify(.{ .JOFFSET = offsets.SEQ4 });
    }

    ///set the injected group configuration.
    ///
    /// NOTE: DO NOT CALL THIS FUNCTION IF DUALMODE IS ENABLED!
    pub fn configure_injected(self: *const AdvancedADC, config: InjectedConfig) RegularConfigError!void {
        const regs = self.regs;
        var trig: u1 = 1;

        //disable all corrent configs to avoid erros
        regs.CR1.modify(.{
            .JEOCIE = 0,
            .JDISCEN = 0,
            .JAUTO = 0,
        });
        switch (config.mode) {
            .auto_injected => |seq| {
                try self.set_injected_auto(seq);
                trig = 0; //auto injected mode must disable the trigger
            },
            .Single => |seq| {
                try self.set_injected_seq(seq);
            },
            .Discontinuous => |disc| {
                try self.set_injected_discontinuous(disc);
            },
        }

        self.set_injected_offsets(config.offsets);
        regs.CR2.modify(.{
            .JEXTSEL = @as(u3, @intFromEnum(config.trigger)),
            .JEXTTRIG = trig,
        });
        regs.CR1.modify(.{ .JEOCIE = @as(u1, if (config.interrupt) 1 else 0) });
    }

    pub fn set_injected_auto(self: *const AdvancedADC, seq: Sequence) RegularConfigError!void {
        const regs = self.regs;
        if (seq.seq.len == 0) {
            return RegularConfigError.InvalidSequence;
        } else if (seq.seq.len > 4) {
            return RegularConfigError.InvalidSequence; //max length is 4 [0..3]
        }

        regs.CR1.modify(.{
            .SCAN = 1, //enable scan mode
            .JDISCEN = 0, //disable discontinuous mode
        });
        self.load_injected_sequence(seq.seq);
        if (seq.channels_conf) |channels| {
            for (channels) |ch| {
                if (ch.channel > 17) return RegularConfigError.InvalidChannel;
                self.set_channel_sample_rate(ch.channel, ch.sample_rate);
            }
        }
        regs.CR1.modify(.{ .JAUTO = 1 }); //enable auto injected mode
    }

    pub fn set_injected_seq(self: *const AdvancedADC, seq: Sequence) RegularConfigError!void {
        const regs = self.regs;
        if (seq.seq.len == 0) {
            return RegularConfigError.InvalidSequence;
        } else if (seq.seq.len > 4) {
            return RegularConfigError.InvalidSequence; //max length is 4 [0..3]
        }

        regs.CR1.modify(.{
            .SCAN = 1, //enable scan mode
            .JDISCEN = 0, //disable discontinuous mode
            .JAUTO = 0, //disable auto injected mode
        });
        self.load_injected_sequence(seq.seq);
        if (seq.channels_conf) |channels| {
            for (channels) |ch| {
                if (ch.channel > 17) return RegularConfigError.InvalidChannel;
                self.set_channel_sample_rate(ch.channel, ch.sample_rate);
            }
        }
    }

    pub fn set_injected_discontinuous(self: *const AdvancedADC, disc: Discontinuous) RegularConfigError!void {
        const regs = self.regs;
        //in this API length starts from 1 instead of 0
        if (disc.length == 0) {
            return RegularConfigError.InvalidLength;
        } else if (disc.length > 4) {
            return RegularConfigError.InvalidLength; //max length is 4
        }

        if (regs.CR1.read().DISCEN == 1) {
            return RegularConfigError.InvalidMode; //discontinuous mode is already enabled for regular
        }
        regs.CR1.modify(.{
            .SCAN = 1, //enable scan mode
            .JDISCEN = 1, //enable discontinuous mode
            .JAUTO = 0, //disable auto injected mode
            .DISCNUM = disc.length - 1,
        });

        self.load_injected_sequence(disc.channels.seq);
        if (disc.channels.channels_conf) |channels| {
            for (channels) |ch| {
                if (ch.channel > 17) return RegularConfigError.InvalidChannel;
                self.set_channel_sample_rate(ch.channel, ch.sample_rate);
            }
        }
    }

    pub fn load_injected_sequence(self: *const AdvancedADC, sequence: []const u5) void {
        const regs = self.regs;
        if (sequence.len == 0) return; //do nothing
        const len = @min(4, sequence.len);

        //injected sequence is loaded from seq_max - len
        //ex:
        //len 1 = load start from SQ4
        //len 2 = load start from SQ3
        //len 3 = load start from SQ2....

        const sti: usize = 4 - len;

        for (sequence[0..len], sti..4) |sq, index| {
            const bit_index: usize = index * 5; //each channel takes 5 bits
            const mask = @as(u32, sq) << @as(u5, @truncate(bit_index));
            regs.JSQR.raw |= mask; //load into JSQR
        }

        regs.JSQR.modify(.{ .JL = @as(u2, @intCast(len - 1)) }); //set number of conversions
    }
    ///DO NOT USE THIS FUNCTION IF AUTO INJECTED MODE IS ENABLED!
    ///
    /// auto injected mode uses internal trigger, so this function will block the auto injected mode.
    pub fn set_injected_trigger(self: *const AdvancedADC, trigger: InjectedTrigger) void {
        const regs = self.regs;
        const trig_sel: u3 = @intFromEnum(trigger);
        if (regs.CR2.read().JEXTSEL != trig_sel) {
            regs.CR2.modify(.{
                .JEXTSEL = trig_sel,
                .JEXTTRIG = 1,
            });
        }
    }

    //========== ADC Dual mode functions ===========

    ///configure the ADC for dual mode. this function can only be called for ADC1
    ///
    /// NOTE: This function will not enable the ADC secondary, you need to call the `enable` function manually.
    pub fn configure_dual_mode(self: *const AdvancedADC, config: DualModeSelection) DualConfigError!void {
        if (self.adc_num == 2 or !@hasDecl(periferals, "ADC2")) {
            return DualConfigError.ADC2NotSupported;
        }
        if (self.adc_num == 3) {
            return DualConfigError.InvalidADC; //only ADC1 and ADC2 can be used in dual mode
        }
        const adc1 = self;
        const adc2 = AdvancedADC.init(.ADC2);

        adc1.set_indedpended(); //dual mode need to be set to independent mode before any configuration
        switch (config) {
            .Independent => return, //just set independent mode, nothing to do

            .Regular => |reg| {
                try set_regular_simultaneous(adc1, &adc2, reg);
            },

            //same config, diferent behavior
            .FastInterleaved => |inter| {
                try set_interleaved(adc1, &adc2, inter, true);
            },
            .SlowInterleaved => |inter| {
                try set_interleaved(adc1, &adc2, inter, false);
            },

            //same config, diferent behavior
            .Injected, .AlternateTrigger => |inj| {
                try set_injected_simultaneous(adc1, &adc2, inj);
            },

            //combined modes
            .RegularAlternateTrigger, .RegularInjected => |dual| {
                try set_injected_simultaneous(adc1, &adc2, dual.Injected);
                try set_regular_simultaneous(adc1, &adc2, dual.Regular);
            },

            .InjectedSlowInterleaved => |dual| {
                try set_injected_simultaneous(adc1, &adc2, dual.Injected);
                try set_interleaved(adc1, &adc2, dual.Regular, false);
            },
            .InjectedFastInterleaved => |dual| {
                try set_injected_simultaneous(adc1, &adc2, dual.Injected);
                try set_interleaved(adc1, &adc2, dual.Regular, true);
            },
        }

        adc1.regs.CR1.modify(.{ .DUALMOD = config });
    }

    ///disable the dual mode. This function can only be called for ADC1 and will do nothing for other ADCs.
    ///
    /// NOTE: this function will not disable the Primary/Secondary ADC or clear configuration.
    pub fn set_indedpended(adc1: *const AdvancedADC) void {
        adc1.regs.CR1.modify(.{ .DUALMOD = .Independent }); //set independent mode
    }

    pub fn set_regular_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousRegular) DualConfigError!void {
        try check_regular_simultaneous(adc1, adc2, config);
        const primary_seq = config.primary_seq;
        const secondary_seq = config.secondary_seq;
        const p_seq = Sequence{ .seq = primary_seq };
        const s_seq = Sequence{ .seq = secondary_seq };
        const p_mode: RegularModes = switch (config.mode) {
            .Single => RegularModes{ .Single = p_seq },
            .Continuous => RegularModes{ .Continuous = p_seq },
            .Discontinuous => |len| RegularModes{
                .Discontinuous = .{
                    .channels = p_seq,
                    .length = len,
                },
            },
        };

        const s_mode: RegularModes = switch (config.mode) {
            .Single => RegularModes{ .Single = s_seq },
            .Continuous => RegularModes{ .Continuous = s_seq },
            .Discontinuous => |len| RegularModes{
                .Discontinuous = .{
                    .channels = s_seq,
                    .length = len,
                },
            },
        };

        adc1.configure_regular(.{
            .mode = p_mode,
            .trigger = config.trigger,
            .dma = config.dma,
            .interrupt = config.primary_interrupt,
        }) catch unreachable;

        adc2.configure_regular(.{
            .mode = s_mode,
            .trigger = .SWSTART, //secondary ADC must use software trigger
            .dma = false, //secondary ADC does not support DMA.
            .interrupt = config.secondary_interrupt,
        }) catch unreachable;

        if (config.rate_seq) |rates| {
            for (rates, primary_seq, secondary_seq) |rate, mseq, ssque| {
                adc1.set_channel_sample_rate(mseq, rate);
                adc2.set_channel_sample_rate(ssque, rate);
            }
        }
    }

    pub fn set_injected_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousInjected) DualConfigError!void {
        try check_injected_simultaneous(adc1, adc2, config);
        const primary_seq = config.primary_seq;
        const secondary_seq = config.secondary_seq;
        adc1.configure_injected(.{
            .trigger = config.trigger,
            .offsets = config.primary_offsets,
            .interrupt = config.primary_interrupt,
            .mode = .{
                .Single = .{
                    .seq = primary_seq,
                    .channels_conf = null, //no channels configuration for primary
                },
            },
        }) catch unreachable;

        adc2.configure_injected(.{
            .trigger = .SWSTART,
            .offsets = config.secondary_offsets,
            .interrupt = config.secondary_interrupt,
            .mode = .{
                .Single = .{
                    .seq = secondary_seq,
                    .channels_conf = null, //no channels configuration for primary
                },
            },
        }) catch unreachable;

        if (config.rate_seq) |rates| {
            for (rates, primary_seq, secondary_seq) |rate, mseq, ssque| {
                adc1.set_channel_sample_rate(mseq, rate);
                adc2.set_channel_sample_rate(ssque, rate);
            }
        }
    }

    pub fn set_interleaved(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: Interleaved, fast: bool) DualConfigError!void {
        try check_interleaved(adc1, adc2, config, fast);
        const mode = blk: {
            if (config.continuos and fast) {
                break :blk RegularModes{
                    .Continuous = .{
                        .seq = &.{config.channel.channel},
                        .channels_conf = &.{config.channel},
                    },
                };
            } else {
                break :blk RegularModes{
                    .Single = .{
                        .seq = &.{config.channel.channel},
                        .channels_conf = &.{config.channel},
                    },
                };
            }
        };

        adc1.configure_regular(.{
            .mode = mode,
            .dma = config.dma,
            .trigger = config.trigger,
            .interrupt = config.interrupt,
        }) catch unreachable;

        adc2.configure_regular(.{
            .mode = mode,
            .dma = false,
            .trigger = .SWSTART,
            .interrupt = false,
        }) catch unreachable;
    }

    fn check_regular_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousRegular) DualConfigError!void {
        if (adc1.adc_num != 1 or adc2.adc_num != 2) {
            return DualConfigError.InvalidADC; //only ADC1 and ADC2 can be used in dual mode
        }
        const primary_len = config.primary_seq.len;
        const secondary_len = config.secondary_seq.len;
        if (primary_len != secondary_len) {
            return DualConfigError.invalidSequence; //primary and secondary sequences must have the same length
        } else if (primary_len == 0 or secondary_len == 0) {
            return DualConfigError.invalidSequence; //sequence cannot be empty
        } else if (primary_len > 17 or secondary_len > 17) {
            return DualConfigError.invalidSequence; //max length is 17 [0..16]
        }

        for (config.primary_seq, config.secondary_seq) |mch, sch| {
            if (mch == sch) {
                return DualConfigError.invalidSequence; //primary and secondary channels must be different
            }
        }

        if (config.rate_seq) |rates| {
            if (rates.len != primary_len) {
                return DualConfigError.InvalidSequence; //sample rates must match the primary sequence length
            }
        }
    }

    fn check_injected_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousInjected) DualConfigError!void {
        if (adc1.adc_num != 1 or adc2.adc_num != 2) {
            return DualConfigError.InvalidADC; //only ADC1 and ADC2 can be used in dual mode
        }
        const primary_len = config.primary_seq.len;
        const secondary_len = config.secondary_seq.len;
        if (primary_len != secondary_len) {
            return DualConfigError.invalidSequence; //primary and secondary sequences must have the same length
        } else if (primary_len == 0 or secondary_len == 0) {
            return DualConfigError.invalidSequence; //sequence cannot be empty
        } else if (primary_len > 4 or secondary_len > 4) {
            return DualConfigError.invalidSequence; //max length is 4 [0..3]
        }

        for (config.primary_seq, config.secondary_seq) |mch, sch| {
            if (mch == sch) {
                return DualConfigError.invalidSequence; //primary and secondary channels must be different
            }
        }

        if (config.rate_seq) |rates| {
            if (rates.len != primary_len) {
                return DualConfigError.InvalidSequence; //sample rates must match the primary sequence length
            }
        }
    }

    fn check_interleaved(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: Interleaved, fast: bool) DualConfigError!void {
        if (adc1.adc_num != 1 or adc2.adc_num != 2) {
            return DualConfigError.InvalidADC; //only ADC1 and ADC2 can be used in dual mode
        }
        const max_sample: usize = if (fast) 0 else 2; // 0 == 1.5, 2 == 13.5

        //max for fast is 7, max for slow is 14
        const rate: usize = @intFromEnum(config.channel.sample_rate);
        if (rate > max_sample) return DualConfigError.InvalidSampleRate;
    }

    //========== WTG funcitions =============

    pub fn configure_watchdog(self: *const AdvancedADC, config: Watchdog) void {
        const regs = self.regs;
        const int_bit: u1 = @intFromBool(config.interrupt);
        var single: u1 = 0;
        var regular: u1 = 0;
        var injected: u1 = 0;
        var channel: u5 = 0;

        regs.CR1.modify(.{
            .AWDEN = 0,
            .JAWDEN = 0,
            .AWDSGL = 0,
            .AWDIE = 0,
        });

        switch (config.guard_mode) {
            .single, .single_regular, .single_injected => |ch| {
                channel = ch;
                single = 1;
            },
            else => {},
        }
        switch (config.guard_mode) {
            .all, .single => {
                regular = 1;
                injected = 1;
            },
            .all_injected, .single_injected => {
                injected = 1;
            },
            .all_regular, .single_regular => {
                regular = 1;
            },
            else => {},
        }

        regs.CR1.modify(.{
            .AWDEN = regular,
            .JAWDEN = injected,
            .AWDSGL = single,
            .AWDIE = int_bit,
            .AWDCH = channel,
        });

        regs.HTR.modify(.{ .HT = config.high_treshold });
        regs.LTR.modify(.{ .LT = config.low_treshold });
    }

    pub fn init(comptime adc: ADC_inst) AdvancedADC {
        return .{
            .regs = get_regs(adc),
            .adc_num = @intFromEnum(adc),
        };
    }
};
