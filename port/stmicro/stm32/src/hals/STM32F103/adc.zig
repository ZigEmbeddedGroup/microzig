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

fn get_regs(adc: ADC_inst) *volatile adc_regs {
    const number = @intFromEnum(adc);
    return switch (number) {
        1 => if (@hasDecl(periferals, "ADC1")) periferals.ADC1 else unreachable,
        2 => if (@hasDecl(periferals, "ADC2")) periferals.ADC2 else unreachable,
        3 => if (@hasDecl(periferals, "ADC3")) periferals.ADC3 else unreachable,
        else => unreachable,
    };
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
            asm volatile ("" ::: "memory");
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
            asm volatile ("" ::: "memory");
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

    pub fn init(adc: ADC_inst) ADC {
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

pub const RegularModes = union(enum) {
    Single: Sequence,
    Continuous: Sequence,
    Discontinuous: Discontinuous,
};
pub const RegularConfig = struct {
    mode: RegularModes,
    trigger: RegularTrigger = .SWSTART,
    DMA: bool = false,
    Interrupt: bool = false,
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
    Interrupt: bool = false,
    offsets: InjectedOffsets = .{},
    mode: InjectedModes,
};

pub const SimultaneousInjected = struct {
    trigger: InjectedTrigger = .SWSTART,

    master_seq: []const u5, //sequence of channels to read for master ADC, max 4 channels
    master_offsets: InjectedOffsets = .{},
    master_interrupt: bool = false,

    slave_seq: []const u5, //sequence of channels to read for slave ADC, max 4 channels
    slave_offsets: InjectedOffsets = .{},
    slave_interrupt: bool = false,

    ///in dual mode both ADCs must have the same sample rates for the channels.
    ///if not provided, the sample rates will be set to the master ADC sample rates values
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
    /// NOTE: without DMA the ADC slave value cannot be read from the master ADC registers,
    /// NOTE: in Dualmode DMA request are 32bits wide.
    dma: bool = false,
    mode: SimRegModes,
    trigger: RegularTrigger = .SWSTART,
    master_seq: []const u5, //sequence of channels to read for master ADC, max 17 channels
    master_interrupt: bool = false,
    slave_seq: []const u5, //sequence of channels to read for slave ADC, max 17 channels
    slave_interrupt: bool = false,
    ///in dual mode both ADCs must have the same sample rates for the channels.
    ///if not provided, the sample rates will not be modified.
    /// Ignore only if the sample rates are already set for the channels.
    rate_seq: ?[]const SampleRate = null,
};

pub const Interleaved = struct {
    interrupt: bool = false, //in this mode only the master ADC can generate an interrupt
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
            asm volatile ("" ::: "memory");
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
            asm volatile ("" ::: "memory");
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

    pub fn clear_flags(self: *const AdvancedADC) void {
        self.regs.SR.raw = 0;
    }

    //========== ADC Regular conversion functions ===========

    ///set the regular group configuration.
    ///
    /// NOTE: DO NOT CALL THIS FUNCTION IF DUALMODE IS ENABLED!
    pub fn configure_regular(self: *const AdvancedADC, config: RegularConfig) RegularConfigError!void {
        const regs = self.regs;

        //disable all corrent configs to avoid erros
        regs.CR2.modify(.{
            .DMA = 0,
            .CONT = 0,
            .EXTTRIG = 0,
        });

        regs.CR1.modify(.{
            .EOCIE = 0,
            .DISCEN = 0,
        });

        switch (config.mode) {
            .Single => |seq| {
                try self.set_regular_seq(seq, true);
            },
            .Continuous => |seq| {
                try self.set_regular_seq(seq, false);
            },
            .Discontinuous => |disc| {
                try self.set_regular_discontinuous(disc);
            },
        }

        if (self.adc_num == 2 and config.DMA) return RegularConfigError.InvalidADC; //only ADC1 and ADC3 can use DMA

        regs.CR1.modify(.{ .EOCIE = @as(u1, if (config.Interrupt) 1 else 0) });
        regs.CR2.modify(.{
            .EXTSEL = @as(u3, @intFromEnum(config.trigger)),
            .EXTTRIG = 1,
            .DMA = @as(u1, if (config.DMA) 1 else 0),
        });
    }

    pub fn set_regular_seq(self: *const AdvancedADC, seq: Sequence, single_mode: bool) RegularConfigError!void {
        const regs = self.regs;
        const len = seq.seq.len;
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

        regs.CR2.modify(.{ .CONT = @as(u1, if (single_mode) 0 else 1) }); //set conversion mode
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

        regs.CR2.modify(.{ .CONT = 0 }); //set conversion mode
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
        regs.CR2.modify(.{ .DMA = if (set) 1 else 0 });
    }

    pub fn set_interrupt(self: *const AdvancedADC, set: bool) void {
        const regs = self.regs;
        regs.CR1.modify(.{ .EOCIE = if (set) 1 else 0 });
    }

    pub fn set_trigger(self: *const AdvancedADC, trigger: RegularTrigger) void {
        const regs = self.regs;
        regs.CR2.modify(.{
            .EXTSEL = @as(u3, @intFromEnum(trigger)),
            .EXTTRIG = 1,
        });
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
    ///NOTE: in dual mode the slave data is read from the slave ADC registers
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
        regs.CR2.modify(.{
            .JEXTTRIG = 0,
        });

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
        regs.CR1.modify(.{ .JEOCIE = @as(u1, if (config.Interrupt) 1 else 0) });
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
        regs.CR2.modify(.{
            .JEXTSEL = @as(u3, @intFromEnum(trigger)),
            .JEXTTRIG = 1,
        });
    }

    //========== ADC Dual mode functions ===========

    ///configure the ADC for dual mode. this function can only be called for ADC1
    ///
    /// NOTE: This function will not enable the ADC slave, you need to call the `enable` function manually.
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
            .FastInterleaved, .SlowInterleaved => |_| {},

            //same config, diferent behavior
            .Injected, .AlternateTrigger => |inj| {
                try set_injected_simultaneous(adc1, &adc2, inj);
            },
            else => {}, //TODO: implement other dual modes
        }

        adc1.regs.CR1.modify(.{ .DUALMOD = config });
    }

    ///disable the dual mode. This function can only be called for ADC1 and will do nothing for other ADCs.
    ///
    /// NOTE: this function will not disable the Master/slave ADC or clear configuration.
    pub fn set_indedpended(adc1: *const AdvancedADC) void {
        adc1.regs.CR1.modify(.{ .DUALMOD = .Independent }); //set independent mode
    }

    pub fn set_regular_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousRegular) DualConfigError!void {
        try check_regular_simultaneous(adc1, adc2, config);
        const master_seq = config.master_seq;
        const slave_seq = config.slave_seq;
        const m_seq = Sequence{ .seq = master_seq };
        const s_seq = Sequence{ .seq = slave_seq };
        const m_mode: RegularModes = switch (config.mode) {
            .Single => RegularModes{ .Single = m_seq },
            .Continuous => RegularModes{ .Continuous = m_seq },
            .Discontinuous => |len| RegularModes{
                .Discontinuous = .{
                    .channels = m_seq,
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
            .mode = m_mode,
            .trigger = config.trigger,
            .DMA = config.dma,
            .Interrupt = config.master_interrupt,
        }) catch unreachable;

        adc2.configure_regular(.{
            .mode = s_mode,
            .trigger = .SWSTART, //slave ADC must use software trigger
            .DMA = false, //slave ADC does not support DMA.
            .Interrupt = config.slave_interrupt,
        }) catch unreachable;

        if (config.rate_seq) |rates| {
            for (rates, master_seq, slave_seq) |rate, mseq, ssque| {
                adc1.set_channel_sample_rate(mseq, rate);
                adc2.set_channel_sample_rate(ssque, rate);
            }
        }
    }

    pub fn set_injected_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousInjected) DualConfigError!void {
        try check_injected_simultaneous(adc1, adc2, config);
        const master_seq = config.master_seq;
        const slave_seq = config.slave_seq;
        adc1.configure_injected(.{
            .trigger = config.trigger,
            .offsets = config.master_offsets,
            .Interrupt = config.master_interrupt,
            .mode = .{
                .Single = .{
                    .seq = master_seq,
                    .channels_conf = null, //no channels configuration for master
                },
            },
        }) catch unreachable;

        adc2.configure_injected(.{
            .trigger = .SWSTART,
            .offsets = config.slave_offsets,
            .Interrupt = config.slave_interrupt,
            .mode = .{
                .Single = .{
                    .seq = slave_seq,
                    .channels_conf = null, //no channels configuration for master
                },
            },
        }) catch unreachable;

        if (config.rate_seq) |rates| {
            for (rates, master_seq, slave_seq) |rate, mseq, ssque| {
                adc1.set_channel_sample_rate(mseq, rate);
                adc2.set_channel_sample_rate(ssque, rate);
            }
        }
    }

    fn check_regular_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousRegular) DualConfigError!void {
        if (adc1.adc_num != 1 or adc2.adc_num != 2) {
            return DualConfigError.InvalidADC; //only ADC1 and ADC2 can be used in dual mode
        }
        const master_len = config.master_seq.len;
        const slave_len = config.slave_seq.len;
        if (master_len != slave_len) {
            return DualConfigError.invalidSequence; //master and slave sequences must have the same length
        } else if (master_len == 0 or slave_len == 0) {
            return DualConfigError.invalidSequence; //sequence cannot be empty
        } else if (master_len > 17 or slave_len > 17) {
            return DualConfigError.invalidSequence; //max length is 17 [0..16]
        }

        for (config.master_seq, config.slave_seq) |mch, sch| {
            if (mch == sch) {
                return DualConfigError.invalidSequence; //master and slave channels must be different
            }
        }

        if (config.rate_seq) |rates| {
            if (rates.len != master_len) {
                return DualConfigError.InvalidSequence; //sample rates must match the master sequence length
            }
        }
    }

    fn check_injected_simultaneous(adc1: *const AdvancedADC, adc2: *const AdvancedADC, config: SimultaneousInjected) DualConfigError!void {
        if (adc1.adc_num != 1 or adc2.adc_num != 2) {
            return DualConfigError.InvalidADC; //only ADC1 and ADC2 can be used in dual mode
        }
        const master_len = config.master_seq.len;
        const slave_len = config.slave_seq.len;
        if (master_len != slave_len) {
            return DualConfigError.invalidSequence; //master and slave sequences must have the same length
        } else if (master_len == 0 or slave_len == 0) {
            return DualConfigError.invalidSequence; //sequence cannot be empty
        } else if (master_len > 4 or slave_len > 4) {
            return DualConfigError.invalidSequence; //max length is 4 [0..3]
        }

        for (config.master_seq, config.slave_seq) |mch, sch| {
            if (mch == sch) {
                return DualConfigError.invalidSequence; //master and slave channels must be different
            }
        }

        if (config.rate_seq) |rates| {
            if (rates.len != master_len) {
                return DualConfigError.InvalidSequence; //sample rates must match the master sequence length
            }
        }
    }

    pub fn init(adc: ADC_inst) AdvancedADC {
        return .{
            .regs = get_regs(adc),
            .adc_num = @intFromEnum(adc),
        };
    }
};
