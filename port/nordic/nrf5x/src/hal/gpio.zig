const std = @import("std");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

pub const Direction = enum(u1) {
    in,
    out,
};

pub const DriveStrength = enum(u3) {
    SOS1 = 0,
    HOS1 = 1,
    SOH1 = 2,
    HOH1 = 3,
    DOS1 = 4,
    DOH1 = 5,
    SOD1 = 6,
    HOD1 = 7,
};
// pub const DriveStrength = peripherals.P0.PIN_CNF[0].underlying_type.DRIVE; // DELETEME
// pub const DriveStrength = microzig.chip.types.peripherals.P0.OUT;
// pub const DriveStrength = @FieldType(microzig.chip.types.peripherals.P0, "PIN_CNF[0].DRIVE");
// PIN_CNF[0].DRIVE; // DELETEME

pub const Pull = enum {
    up,
    down,
    disabled,
};

pub fn num(bank: u1, n: u5) Pin {
    return @enumFromInt(@as(u6, bank) * 32 + n);
}

// TODO: Do we want to follow the rp2350 design where we encode the packaage
// somewhere? Some GPIOs are unbonded in certain packages.
pub const Pin = enum(u6) {
    _,
    // TODO: Add support for LATCH, DETECTMODE

    fn get_regs(pin: Pin) @TypeOf(peripherals.P0) {
        return if (@intFromEnum(pin) <= 31)
            peripherals.P0
        else
            peripherals.P1;
    }

    /// Get the index of the pin, relative to its bank
    pub fn index(pin: Pin) u5 {
        const n = @intFromEnum(pin);
        return @truncate(if (n <= 31) n else (n - 32));
    }

    /// Get a bitmask of the pin, appropriate for registers in its bank
    pub fn mask(pin: Pin) u31 {
        return @as(u31, 1) << pin.index();
    }

    pub fn set_pull(pin: Pin, pull: Pull) void {
        const regs = pin.get_regs();
        // regs.PIN_CNF[pin.index()].modify(.{
        regs.PIN_CNF[pin.index()].write(.{
            // NOTE: With `write` we know the type, with `modify` we take an anonymous struct which we only match the type with at comptime
            .DIR = @enumFromInt(0), // DELETEME
            .INPUT = @enumFromInt(0), // DELETEME
            .DRIVE = @enumFromInt(0), // DELETEME
            .SENSE = @enumFromInt(0), // DELETEME
            .PULL = @enumFromInt(@intFromEnum(pull)),
            // .PULL = switch (pull) {
            //     // .up => microzig.chip.types.peripherals.P0.PIN_CNF[0].PULL.Pullup,
            //     // .down => microzig.chip.types.peripherals.P0.PIN_CNF[0].PULL.Pulldown,
            //     // .disabled => microzig.chip.types.peripherals.P0.PIN_CNF[0].PULL.Disabled,
            //     // .up => microzig.chip.types.peripherals.P0.OUT,
            //     else => unreachable,
            // },
        });
    }

    pub fn set_direction(pin: Pin, direction: Direction) void {
        const regs = pin.get_regs();
        switch (direction) {
            .in => regs.DIRCLR.raw = pin.mask(),
            .out => regs.DIRSET.raw = pin.mask(),
        }
    }

    pub inline fn put(pin: Pin, value: u1) void {
        const regs = pin.get_regs();
        switch (value) {
            0 => regs.OUTCLR.raw = pin.mask(),
            1 => regs.OUTSET.raw = pin.mask(),
        }
    }
    pub inline fn read(pin: Pin) u1 {
        const regs = pin.get_regs();
        return if ((regs.IN.raw & pin.mask()) != 0)
            1
        else
            0;
    }

    pub fn set_drive_strength(pin: Pin, drive_strength: DriveStrength) void {
        const regs = pin.get_regs();
        // regs.PIN_CNF[pin.index()].modify(.{ .DRIVE = @intFromEnum(drive_strength) });
        regs.PIN_CNF[pin.index()].modify(.{
            .DRIVE = switch (drive_strength) {
                // .SOS1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.SOS1,
                // .HOS1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.HOS1,
                // .SOH1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.SOH1,
                // .HOH1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.HOH1,
                // .DOS1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.DOS1,
                // .DOH1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.DOH1,
                // .SOD1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.SOD1,
                // .HOD1 => microzig.chip.types.peripherals.P0.PIN_CNF[0].DRIVE.HOD1,
                else => unreachable,
            },
        });
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
