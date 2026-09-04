//! GPIO and pin configuration
//!
//! The GPIO matrix and IO mux allows input from any pin to be routed to any peripheral, and any
//! peripheral output to be routed to any pin.
//!
//! The registers behind this differ between chips, see `gpio/<chip>.zig`.
//!
const std = @import("std");

const compatibility = @import("compatibility.zig");

/// Number of usable pads. The pins are numbered 0 to `pin_count - 1`.
pub const pin_count = chip_specific.pin_count;

/// Peripheral signals that can be routed onto a pin.
pub const InputSignal = chip_specific.InputSignal;
pub const OutputSignal = chip_specific.OutputSignal;

pub const DriveStrength = enum {
    @"5mA",
    @"10mA",
    @"20mA",
    @"40mA",

    /// Get the register value of this drive strength for a pad. The mapping is not always the
    /// identity, some pads on some chips swap the 10 mA and 20 mA settings.
    fn to_value(strength: DriveStrength, pin: Pin) u2 {
        return chip_specific.drive_strength_value(@backingInt(pin), switch (strength) {
            .@"5mA" => .@"5mA",
            .@"10mA" => .@"10mA",
            .@"20mA" => .@"20mA",
            .@"40mA" => .@"40mA",
        });
    }
};

/// Alternative pin functions
pub const AlternateFunction = enum(u3) {
    function0 = 0,
    function1 = 1,
    function2 = 2,
    function3 = 3,
};

/// Interrupt events
pub const Event = enum(u3) {
    rising_edge = 1,
    falling_edge = 2,
    any_edge = 3,
    low_level = 4,
    high_level = 5,
};

pub const Pull = enum {
    up,
    down,
    disabled,
};

pub const Mask = enum(chip_specific.PinMask) {
    _,
};

pub fn num(n: u5) Pin {
    std.debug.assert(n < pin_count);
    return @as(Pin, @fromBackingInt(n));
}

pub const Pin = enum(u5) {
    _,

    pub const Config = struct {
        output_enable: bool = false,
        input_enable: bool = false,
        open_drain: bool = false,
        pull: Pull = .disabled,
        drive_strength: DriveStrength = .@"5mA",
        input_filter_enable: bool = false,

        pub const analog: Config = .{
            .output_enable = false,
            .input_enable = false,
            .pull = .disabled,
        };
    };

    fn assert_usb_disabled(self: Pin) void {
        chip_specific.assert_usb_disabled(@backingInt(self));
    }

    pub fn apply(self: Pin, config: Config) void {
        self.assert_usb_disabled();

        const n = @backingInt(self);

        chip_specific.set_output_signal(n, .{
            .signal = @backingInt(OutputSignal.gpio),
        });

        chip_specific.set_mux(n, .{
            .pull_down = config.pull == .down,
            .pull_up = config.pull == .up,
            .drive_strength = config.drive_strength.to_value(self),
            .input_enable = config.input_enable,
            .function = @backingInt(AlternateFunction.function1),
            .input_filter_enable = config.input_filter_enable,
        });

        chip_specific.set_open_drain(n, config.open_drain);
        chip_specific.set_output_enabled(n, config.output_enable);
    }

    pub const ConnectToOutputOptions = struct {
        signal: OutputSignal,
        invert: bool = false,
        output_enable_signal_controlled_by_peripheral: bool = false,
        invert_output_enable_signal: bool = false,
    };

    // TODO: bypass gpio matrix
    pub fn connect_peripheral_to_output(self: Pin, options: ConnectToOutputOptions) void {
        self.assert_usb_disabled();

        chip_specific.set_output_signal(@backingInt(self), .{
            .signal = @backingInt(options.signal),
            .invert = options.invert,
            .output_enable_signal_controlled_by_peripheral = options.output_enable_signal_controlled_by_peripheral,
            .invert_output_enable_signal = options.invert_output_enable_signal,
        });
    }

    pub const ConnectToInputOptions = struct {
        signal: InputSignal,
        invert: bool = false,
    };

    // TODO: bypass gpio matrix
    pub fn connect_input_to_peripheral(self: Pin, options: ConnectToInputOptions) void {
        self.assert_usb_disabled();

        chip_specific.set_input_signal(@backingInt(options.signal), @backingInt(self), options.invert);
    }

    pub fn set_output_enabled(self: Pin, enable: bool) void {
        chip_specific.set_output_enabled(@backingInt(self), enable);
    }

    pub fn set_output_invert(self: Pin, invert: bool) void {
        chip_specific.set_output_invert(@backingInt(self), invert);
    }

    pub fn set_input_enabled(self: Pin, enable: bool) void {
        chip_specific.set_input_enabled(@backingInt(self), enable);
    }

    /// Inverts the signal a peripheral reads from this pin.
    pub fn set_input_invert(self: Pin, signal: InputSignal, invert: bool) void {
        _ = self;
        chip_specific.set_input_signal_invert(@backingInt(signal), invert);
    }

    pub fn set_input_filter_enabled(self: Pin, enable: bool) void {
        chip_specific.set_input_filter_enabled(@backingInt(self), enable);
    }

    pub fn set_pull(self: Pin, pull: Pull) void {
        chip_specific.set_pull(@backingInt(self), pull == .down, pull == .up);
    }

    pub fn set_drive_strength(self: Pin, drive_strength: DriveStrength) void {
        chip_specific.set_drive_strength(@backingInt(self), drive_strength.to_value(self));
    }

    pub fn set_open_drain(self: Pin, open_drain: bool) void {
        chip_specific.set_open_drain(@backingInt(self), open_drain);
    }

    pub fn put(self: Pin, level: u1) void {
        chip_specific.put(@backingInt(self), level);
    }

    pub fn read(self: Pin) u1 {
        std.debug.assert(chip_specific.get_input_enabled(@backingInt(self)));

        return chip_specific.read(@backingInt(self));
    }

    pub fn toggle(self: Pin) void {
        switch (self.read()) {
            0 => self.put(1),
            1 => self.put(0),
        }
    }
};

const chip_specific = switch (compatibility.chip) {
    .esp32_c3 => @import("gpio/esp32_c3.zig"),
    .esp32_c6 => @import("gpio/esp32_c6.zig"),
};
