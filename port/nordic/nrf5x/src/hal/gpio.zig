const std = @import("std");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const compatibility = @import("compatibility.zig");

const version: enum {
    nrf51,
    nrf5283x,
    nrf52840,
} = switch (compatibility.chip) {
    .nrf51 => .nrf51,
    .nrf52, .nrf52833 => .nrf5283x,
    .nrf52840 => .nrf52840,
    else => compatibility.unsupported_chip("GPIO"),
};

pub const Direction = enum(u1) {
    in,
    out,
};

pub const Sense = enum(u2) {
    disabled = 0x0,
    high = 0x2,
    low = 0x3,
};

pub const InputBuffer = enum(u1) {
    connect = 0x0,
    disconnect = 0x1,
};

const Regs = switch (version) {
    .nrf51 => microzig.chip.types.peripherals.GPIO,
    .nrf5283x, .nrf52840 => microzig.chip.types.peripherals.P0,
};

pub const Pull = Regs.Pull;
pub const DriveStrength = Regs.DriveStrength;

pub fn num(bank: u1, n: u5) Pin {
    return @enumFromInt(@as(u6, bank) * 32 + n);
}

// TODO: Do we want to follow the rp2350 design where we encode the package
// somewhere? Some GPIOs are unbonded in certain packages.
pub const Pin = enum(u6) {
    _,
    // TODO: Add support for LATCH, DETECTMODE

    fn get_regs(pin: Pin) *volatile Regs {
        return switch (version) {
            .nrf51 => peripherals.GPIO,
            .nrf5283x => peripherals.P0,
            .nrf52840 => if (@intFromEnum(pin) <= 31)
                peripherals.P0
            else
                peripherals.P1,
        };
    }

    /// Get the index of the pin, relative to its bank
    pub fn index(pin: Pin) u5 {
        const n = @intFromEnum(pin);
        return @truncate(if (n <= 31) n else (n - 32));
    }

    /// Get the port of the pin
    pub fn port(pin: Pin) u1 {
        const n = @intFromEnum(pin);
        if (n <= 31) {
            return 0;
        } else return 1;
    }

    /// Get a bitmask of the pin, appropriate for registers in its bank
    pub fn mask(pin: Pin) u32 {
        return @as(u32, 1) << pin.index();
    }

    pub fn set_pull(pin: Pin, pull: Pull) void {
        const regs = pin.get_regs();
        regs.PIN_CNF[pin.index()].modify(.{ .PULL = pull });
    }

    /// Set GPIO pin as input or output
    pub fn set_direction(pin: Pin, direction: Direction) void {
        const regs = pin.get_regs();
        switch (direction) {
            .in => regs.DIRCLR.raw = pin.mask(),
            .out => regs.DIRSET.raw = pin.mask(),
        }
    }

    pub inline fn set_sense(pin: Pin, sense: Sense) void {
        const regs = pin.get_regs();
        regs.PIN_CNF[@intFromEnum(pin)].modify(.{
            .SENSE = switch (sense) {
                .disabled => .Disabled,
                .high => .High,
                .low => .Low,
            },
        });
    }

    pub inline fn set_input_buffer(pin: Pin, input_buffer: InputBuffer) void {
        const regs = pin.get_regs();
        regs.PIN_CNF[@intFromEnum(pin)].modify(.{
            .INPUT = switch (input_buffer) {
                .connect => .Connect,
                .disconnect => .Disconnect,
            },
        });
    }

    pub inline fn put(pin: Pin, value: u1) void {
        const regs = pin.get_regs();
        switch (value) {
            0 => regs.OUTCLR.raw = pin.mask(),
            1 => regs.OUTSET.raw = pin.mask(),
        }
    }

    pub inline fn toggle(pin: Pin) void {
        const regs = pin.get_regs();
        regs.OUT.raw ^= pin.mask();
    }

    pub inline fn read(pin: Pin) u1 {
        const regs = pin.get_regs();
        return @truncate(regs.IN.raw >> pin.index());
    }

    pub fn set_drive_strength(pin: Pin, drive_strength: DriveStrength) void {
        const regs = pin.get_regs();
        regs.PIN_CNF[pin.index()].modify(.{ .DRIVE = drive_strength });
    }
};

test "pin number" {
    const tcs = .{
        // bank, pin, pin number
        .{ 0, 0, 0 },
        .{ 0, 1, 1 },
        .{ 0, 31, 31 },
        .{ 1, 0, 32 },
        .{ 1, 1, 33 },
    };
    inline for (tcs) |tc| {
        const pin = num(tc[0], tc[1]);
        try std.testing.expectEqual(tc[2], @intFromEnum(pin));
    }
}

test "pin index" {
    const tcs = .{
        // bank, pin, index
        .{ 0, 1, 1 },
        .{ 0, 31, 31 },
        .{ 1, 0, 0 },
        .{ 1, 1, 1 },
    };
    inline for (tcs) |tc| {
        const pin = num(tc[0], tc[1]);
        try std.testing.expectEqual(tc[2], pin.index());
    }
}
