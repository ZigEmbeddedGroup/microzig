const std = @import("std");
const microzig = @import("microzig");
const Mmio = microzig.mmio.Mmio;
const chip = microzig.chip;

pub const Direction = enum(u1) {
    out = 0,
    in = 1,
};

pub const Pull = enum {
    up,
    down,
    disabled,
};

pub const Enabled = enum(u1) {
    disabled = 0,
    enabled = 1,
};

pub const DriveStrength = enum(u1) {
    high = 0,
    normal = 1,
};

const gpio_block_size = 64;
const gpio_port_count = 4;
const max_pin_number = 10;

const GenericGpioBlock = extern struct {
    reg: Mmio(u32) align(4),
    padding: [gpio_block_size - @sizeOf(u32)]u8 align(4),
};

const SelGpioBlock = extern struct {
    reg: [max_pin_number]Mmio(u32) align(4),
    padding: [gpio_block_size - (@sizeOf(u32) * max_pin_number)]u8 align(4),
};

comptime {
    std.debug.assert(@sizeOf(GenericGpioBlock) == gpio_block_size);
    std.debug.assert(@sizeOf(SelGpioBlock) == gpio_block_size);
}

const IN: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0IN);
const OUT: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0OUT);
const DIR: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0DIR);
const PU: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0PU);
const PD: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0PD);
const OD: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0OD);
const DR: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0DR);
const ADS: *volatile [gpio_port_count]GenericGpioBlock align(4) = @ptrCast(&chip.peripherals.GPIO.P0ADS);
// TODO: patch the svd instead of doing pointer math here
const SEL: *volatile [gpio_port_count]SelGpioBlock align(4) = @ptrFromInt(@intFromPtr(&chip.peripherals.GPIO.P01_SEL) - 4);

pub const Pin = enum(u5) {
    _,

    pub inline fn init(self: Pin, direction: Direction) void {
        self.set_function(0); // gpio
        self.set_direction(direction);
        self.set_pull(.disabled);
        self.set_open_drain(.disabled);
    }

    pub inline fn put(self: Pin, value: u1) void {
        OUT[self.port()].reg.write_bit(self.pin(), value);
    }

    pub inline fn toggle(self: Pin) void {
        OUT[self.port()].reg.toggle_bit(self.pin());
    }

    pub inline fn read(self: Pin) u1 {
        return IN[self.port()].reg.read_bit(self.pin());
    }

    pub inline fn set_direction(self: Pin, direction: Direction) void {
        DIR[self.port()].reg.write_bit(self.pin(), @intFromEnum(direction));
    }

    pub inline fn set_function(self: Pin, function: u5) void {
        SEL[self.port()].reg[self.pin()].raw = function;
    }

    pub inline fn set_pull(self: Pin, pull: Pull) void {
        PU[self.port()].reg.write_bit(self.pin(), @intFromBool(pull == .up));
        PD[self.port()].reg.write_bit(self.pin(), @intFromBool(pull == .down));
    }

    pub inline fn set_open_drain(self: Pin, enabled: Enabled) void {
        OD[self.port()].reg.write_bit(self.pin(), @intFromEnum(enabled));
    }

    pub inline fn set_drive_strength(self: Pin, drive_strength: DriveStrength) void {
        DR[self.port()].reg.write_bit(self.pin(), @intFromEnum(drive_strength));
    }

    pub inline fn set_analog(self: Pin, enabled: Enabled) void {
        ADS[self.port()].reg.write_bit(self.pin(), @intFromEnum(enabled));
    }

    inline fn port(self: Pin) u2 {
        return @truncate(@intFromEnum(self) >> 3);
    }

    inline fn pin(self: Pin) u3 {
        return @truncate(@intFromEnum(self));
    }
};

pub fn num(port: u2, n: u3) Pin {
    return @enumFromInt(@as(u5, port) << 3 | (n));
}
