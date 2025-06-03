const std = @import("std");
const microzig = @import("microzig");
const drivers = @import("drivers.zig");
const utils = @import("util.zig");
const periferals = microzig.chip.peripherals;
const adc_regs = microzig.chip.types.peripherals.adc_f1.ADC;
const CounterDevice = drivers.CounterDevice;
const timeout = drivers.Timeout;

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

pub const RegularSingleChannel = struct {
    channel: u5,
    sample_rate: SampleRate = .@"13.5", //default sample rate
};

pub const RegularSingleSequence = struct {
    seq: []const u5, //sequence of channels to read, max 17 channels
    channels_conf: ?[]const RegularSingleChannel, //optional channel configuration, if not provided, the sample rate will be not modified
};

pub const RegularDiscontinuous = struct {
    channels: []const RegularSingleChannel,
    length: u3 = 0, //default length is 0, which means 1 read per trigger
};

pub const RegularModes = union(enum) {
    SingleCh: RegularSingleChannel,
    SingleSeq: RegularSingleSequence,
    ContinuousCh: RegularSingleChannel,
    ContinuousSeq: RegularSingleSequence,
    Discontinuous: RegularDiscontinuous,
};
pub const RegularConfig = struct {
    mode: RegularModes,
    trigger: RegularTrigger = .SWSTART,
    DMA: bool = false,
    Interrupt: bool = false,
};

pub const RegularConfigError = error{
    InvalidADC,
    InvalidMode,
    InvalidTrigger,
    InvalidChannel,
    InvalidSampleRate,
    InvalidLength,
};

pub const AdvancedADC = struct {
    regs: *volatile adc_regs,
    adc_num: usize,

    //==========ADC init functions===========

    ///enable the ADC and optionally calibrate it.
    pub fn enable(self: *const AdvancedADC, calib: bool, Counter: *const CounterDevice) void {
        const regs = self.regs;
        regs.CR2.modify(.{ .ADON = 1 }); //enable ADC

        //wait for ADC stabilization time
        Counter.sleep_us(STAB_TIME);
        if (calib) {
            _ = self.calibrate();
        }
        regs.SR.raw = 0; //clear all status flags
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
        return regs.DR.read().DATA; //read the calibration data
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
    pub fn enable_refint(self: *const AdvancedADC, Counter: *const CounterDevice) void {
        const regs = self.regs;
        regs.CR2.modify(.{ .TSVREFE = 1 }); //enable temperature sensor and Vrefint
        //wait for Vrefint and temperature sensor to stabilize
        Counter.sleep_us(STAB_VREFE_TIME);
    }

    //========== ADC Regular conversion functions ===========

    pub fn configure_regular_conversion(self: *const AdvancedADC, config: RegularConfig) RegularConfigError!void {
        const regs = self.regs;
        switch (config.mode) {
            .SingleCh => |single| {
                try self.set_regular_ch(single, true);
            },
            .SingleSeq => |seq| {
                try self.set_regular_seq(seq, true);
            },
            .ContinuousCh => |single| {
                try self.set_regular_ch(single, false);
            },
            .ContinuousSeq => |seq| {
                try self.set_regular_seq(seq, false);
            },
            .Discontinuous => |_| {
                //TODO: implement discontinuous mode
                return RegularConfigError.InvalidMode;
            },
        }

        if (self.adc_num == 2 and config.DMA) return RegularConfigError.InvalidADC; //only ADC1 and ADC3 can use DMA

        regs.CR1.modify(.{ .EOCIE = @as(u1, if (config.Interrupt) 1 else 0) });
        regs.CR2.modify(.{
            .DMA = @as(u1, if (config.DMA) 1 else 0),
            .EXTSEL = @as(u3, @intFromEnum(config.trigger)),
            .EXTTRIG = 1,
        });
    }

    pub fn set_regular_ch(self: *const AdvancedADC, single: RegularSingleChannel, single_mode: bool) RegularConfigError!void {
        if (single.channel > 17) return RegularConfigError.InvalidChannel;
        const regs = self.regs;
        regs.CR1.modify(.{
            .SCAN = 0, //disable scan mode
            .DISCEN = 0, //disable discontinuous mode
        });

        self.set_channel_sample_rate(single.channel, single.sample_rate);
        regs.SQR1.modify(.{ .L = 0 }); //set number of conversions to 1
        regs.SQR3.modify(.{ .@"SQ[0]" = single.channel }); //set the channel to read

        regs.CR2.modify(.{ .CONT = @as(u1, if (single_mode) 0 else 1) }); //set conversion mode
    }

    pub fn set_regular_seq(self: *const AdvancedADC, seq: RegularSingleSequence, single_mode: bool) RegularConfigError!void {
        const regs = self.regs;
        const len = @min(seq.seq.len, 17);
        if (len == 0) return RegularConfigError.InvalidChannel;

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

    pub fn set_multiple_channels_sample_rate(self: *const AdvancedADC, sample_rates: []const SampleRate) void {
        const len = @min(sample_rates.len, 18);
        for (0..len, sample_rates) |i, rate| {
            self.set_channel_sample_rate(@intCast(i), rate);
        }
    }

    ///load a sequence of channels to be converted by `read_multiple_channels` function.
    /// the read sequence is determined by the order of the channels in the sequence array.
    /// only the first 16 sequence elements are used, the rest are ignored.
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
    //TODO: implement injected conversion read functions

    pub fn init(adc: ADC_inst) AdvancedADC {
        return .{
            .regs = get_regs(adc),
            .adc_num = @intFromEnum(adc),
        };
    }
};
