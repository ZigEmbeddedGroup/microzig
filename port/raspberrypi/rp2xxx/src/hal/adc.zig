//! NOTE: no settling time is needed when switching analog inputs

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const ADC = microzig.chip.peripherals.ADC;
const gpio = @import("gpio.zig");
const resets = @import("resets.zig");
const clocks = @import("clocks.zig");

pub const Error = error{
    /// ADC conversion failed, one such reason is that the controller failed to
    /// converge on a result.
    Conversion,
    FifoEmpty,
};

const Config = struct {
    /// Note that this frequency is the sample frequency of the controller, not
    /// each input. So for 4 inputs in round-robin mode you'd see 1/4 sample
    /// rate for a given put vs what is set here.
    sample_frequency: ?u32 = null,
    round_robin: ?InputMask = null,
    fifo: ?instance.fifo.Config = null,
    temp_sensor_enabled: bool = false,
};

/// For selecting which inputs are to be used in round-robin mode
pub const InputMask = packed struct(u5) {
    ain0: bool = false,
    ain1: bool = false,
    ain2: bool = false,
    ain3: bool = false,
    temp_sensor: bool = false,
};

pub const Input = enum(u3) {
    ain0 = 0,
    ain1 = 1,
    ain2 = 2,
    ain3 = 3,
    temp_sensor = 4,

    /// Get the corresponding GPIO pin for an ADC input. Panics if you give it
    /// temp_sensor.
    pub fn get_gpio_pin(in: Input) gpio.Pin {
        return switch (in) {
            else => gpio.num(@as(u5, @intFromEnum(in)) + 26),
            .temp_sensor => @panic("temp_sensor doesn't have a pin"),
        };
    }

    /// Prepares an ADC input's corresponding GPIO pin to be used as an analog
    /// input.
    pub fn configure_gpio_pin(in: Input) void {
        switch (in) {
            else => {
                const pin = in.get_gpio_pin();
                pin.set_function(.disabled);
                pin.set_pull(.disabled);
                pin.set_input_enabled(false);
            },
            .temp_sensor => {},
        }
    }
};

pub const Mode = enum {
    one_shot,
    free_running,
};

pub const instance = struct {
    /// Enable the ADC controller.
    pub fn set_enabled(enabled: bool) void {
        ADC.CS.modify(.{ .EN = @intFromBool(enabled) });
    }

    /// Applies configuration to ADC, leaves it in an enabled state by setting
    /// CS.EN = 1. The global clock configuration is not needed to configure the
    /// sample rate because the ADC hardware block requires a 48MHz clock.
    pub fn apply(config: Config) void {
        ADC.CS.write(.{
            .EN = 0,
            .TS_EN = @intFromBool(config.temp_sensor_enabled),
            .START_ONCE = 0,
            .START_MANY = 0,
            .READY = 0,

            .ERR = 0,
            .ERR_STICKY = 0,
            .AINSEL = 0,
            .RROBIN = if (config.round_robin) |rr|
                @as(u5, @bitCast(rr))
            else
                0,

            .reserved8 = 0,
            .reserved12 = 0,
            .reserved16 = 0,
            .padding = 0,
        });

        if (config.sample_frequency) |sample_frequency| {
            const cycles = (48_000_000 * 256) / @as(u64, sample_frequency);
            ADC.DIV.write(.{
                .FRAC = @as(u8, @truncate(cycles)),
                .INT = @as(u16, @intCast((cycles >> 8) - 1)),

                .padding = 0,
            });
        }

        if (config.fifo) |fifo_config|
            fifo.apply(fifo_config);

        set_enabled(true);
    }

    /// Select analog input for next conversion.
    ///
    /// NOTE: If the temperature sensor is desired to be read, it must be enabled
    /// via set_temp_sensor_enabled(true);
    pub fn set_input(in: Input) void {
        ADC.CS.modify(.{ .AINSEL = @intFromEnum(in) });
    }

    /// Get the currently selected analog input. ain0..ain3 map to GPIO 26..29 respectively,
    /// temperature_sensor maps to the internal temperature sense diode.
    pub fn get_input() Input {
        const cs = ADC.SC.read();
        return @as(Input, @enumFromInt(cs.AINSEL));
    }

    /// Set to true to power on the temperature sensor.
    ///
    /// Mandatory when reading the temperature sensor input channel.
    pub fn set_temp_sensor_enabled(enable: bool) void {
        ADC.CS.modify(.{ .TS_EN = @intFromBool(enable) });
    }

    /// Start the ADC controller. There are three "modes" that the controller
    /// operates in:
    ///
    /// - one shot: the input is selected and then conversion is started. The
    ///   controller stops once the conversion is complete.
    ///
    /// - free running single input: the input is selected and then the conversion
    ///   is started. Once a conversion is complete the controller begins another
    ///   on the same input.
    ///
    /// - free running round-robin: a mask of which inputs to sample is set using
    ///   `round_robin_set()`. Once conversion is completed for one input, a
    ///   conversion is started for the next set input in the mask.
    pub fn start(mode: Mode) void {
        switch (mode) {
            .one_shot => ADC.CS.modify(.{
                .START_ONCE = 1,
            }),
            .free_running => ADC.CS.modify(.{
                .START_MANY = 1,
            }),
        }
    }

    /// Check whether the ADC controller has a conversion result
    pub fn is_ready() bool {
        const cs = ADC.CS.read();
        return cs.READY != 0;
    }

    /// Single-shot, blocking conversion. Operates on channel set via set_input()
    pub fn convert_one_shot_blocking() Error!u12 {
        start(.one_shot);

        while (!is_ready()) {}

        return read_result();
    }

    /// Sets which of the inputs are to be run in round-robin mode. Setting all to
    /// 0 will disable round-robin mode but `round_robin_disable()` is provided so
    /// the user may be explicit.
    pub fn round_robin_set(enabled_inputs: InputMask) void {
        ADC.CS.modify(.{ .RROBIN = @as(u5, @bitCast(enabled_inputs)) });
    }

    /// Disable round-robin sample mode.
    pub fn round_robin_disable() void {
        ADC.CS.modify(.{ .RROBIN = 0 });
    }

    /// Read conversion result from ADC controller, this function assumes that the
    /// controller has a result ready.
    pub fn read_result() Error!u12 {
        const cs = ADC.CS.read();
        return if (cs.ERR == 1)
            error.Conversion
        else blk: {
            const conversion = ADC.RESULT.read();
            break :blk conversion.RESULT;
        };
    }

    /// The ADC FIFO can store up to four conversion results. It must be enabled in
    /// order to use DREQ or IRQ driven streaming.
    pub const fifo = struct {
        pub const Config = struct {
            /// Assert DMA request when fifo contains >= thresh
            dreq_enabled: bool = false,
            /// Assert Interrupt when fifo contains >= thresh
            irq_enabled: bool = false,
            /// DREQ/IRQ asserted when level >= thresh
            thresh: u4 = 0,
            /// Downshift the conversion so it's 8-bit, good for DMAing to a byte
            /// buffer. Note that bottom 4 bits of precision will be truncated.
            shift: bool = false,
        };

        /// Apply ADC FIFO configuration and enable it
        pub fn apply(config: fifo.Config) void {
            ADC.FCS.write(.{
                .DREQ_EN = @intFromBool(config.dreq_enabled),
                .THRESH = config.thresh,
                .SHIFT = @intFromBool(config.shift),

                .EN = 1,
                .EMPTY = 0,
                .FULL = 0,
                .LEVEL = 0,

                // As far as it is known, there is zero cost to being able to
                // report errors in the FIFO, so let's.
                .ERR = 1,

                // Writing 1 to these will clear them if they're already set
                .UNDER = 1,
                .OVER = 1,

                .reserved8 = 0,
                .reserved16 = 0,
                .reserved24 = 0,
                .padding = 0,
            });

            irq_set_enabled(config.irq_enabled);
        }

        /// Enable/disable ADC interrupt.
        ///
        /// NOTE: Only enables the peripheral's interrupt signal, actual interrupt handler
        /// must be set using irq.zig.
        pub fn irq_set_enabled(enable: bool) void {
            ADC.INTE.write(.{
                .FIFO = @intFromBool(enable),
                .padding = 0,
            });
        }

        /// Check if the ADC FIFO is full.
        pub fn is_full() bool {
            const fsc = ADC.FSC.read();
            return fsc.FULL != 0;
        }

        /// Check if the ADC FIFO is empty.
        pub fn is_empty() bool {
            const fsc = ADC.FSC.read();
            return fsc.EMPTY != 0;
        }

        /// Get the number of conversions available in the ADC FIFO.
        pub fn get_level() u4 {
            const fsc = ADC.FSC.read();
            return fsc.LEVEL;
        }

        /// Check if the ADC FIFO has overflowed. When overflow happens, the new
        /// conversion is discarded. This flag is sticky, to clear it call
        /// `clear_overflowed()`.
        pub fn has_overflowed() bool {
            const fsc = ADC.FSC.read();
            return fsc.OVER != 0;
        }

        /// Clear the overflow status flag if it is set.
        pub fn clear_overflowed() void {
            ADC.FSC.modify(.{ .OVER = 1 });
        }

        /// Check if the ADC FIFO has underflowed. This means that the FIFO
        /// register was read while the FIFO was empty. This flag is sticky, to
        /// clear it call `clear_underflowed()`.
        pub fn has_underflowed() bool {
            const fsc = ADC.FSC.read();
            return fsc.UNDER != 0;
        }

        /// Clear the underflow status flag if it is set.
        pub fn clear_underflowed() void {
            ADC.FSC.modify(.{ .UNDER = 1 });
        }

        /// Pop conversion from ADC FIFO.
        pub fn pop() Error!u12 {
            if (is_empty()) return error.FifoEmpty;
            const result = ADC.FIFO.read();
            return if (result.ERR == 1)
                error.Conversion
            else
                result.VAL;
        }
    };
};

/// T must be floating point.
pub fn temp_sensor_result_to_celcius(comptime T: type, comptime vref: T, result: u12) T {
    // TODO: consider fixed-point
    const raw = @as(T, @floatFromInt(result));
    const voltage: T = vref * raw / 0x0fff;
    return (27.0 - ((voltage - 0.706) / 0.001721));
}
