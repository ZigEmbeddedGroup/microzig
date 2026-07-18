const std = @import("std");
const microzig = @import("microzig");

const peri = microzig.chip.peripherals;

pub const Port = enum { gpioa };

fn instance(port: Port) *volatile microzig.chip.types.peripherals.gpioa {
    return switch (port) {
        inline else => @field(peri, @tagName(port)),
    };
}

pub fn enable(port: Port) void {
    instance(port).GPIOA_PWREN.raw.write(0x26000001);
    // Technical reference manual part 2.2.6
    inline for (0..4) |_|
        asm volatile ("nop");
}

pub const Direction = enum(u1) { in, out };

pub const Pin = struct {
    port: Port,
    num: u5,

    pub fn set_function(p: Pin, function: u6) void {
        peri.iomux.IOMUX_PINCM[p.num].write(.{
            .PF = @enumFromInt(function),
            .PC = .CONNECTED,
            .WAKESTAT = .DISABLE,
            .PIPD = .DISABLE,
            .PIPU = .DISABLE,
            .INENA = .DISABLE,
            .HYSTEN = .DISABLE,
            .DRV = .DRVVAL0,
            .HIZ1 = .DISABLE,
            .INV = .DISABLE,
            .WUEN = .DISABLE,
            .WCOMP = .MATCH0,
        });
    }

    pub fn set_direction(p: Pin, dir: Direction) void {
        const reg = switch (dir) {
            .in => &instance(p.port).GPIOA_DOECLR31_0.raw.read(),
            .out => &instance(p.port).GPIOA_DOESET31_0.raw.read(),
        };
        reg.* = p.mask();
    }

    pub fn mask(p: Pin) u32 {
        return @as(u32, 1) << p.num;
    }

    pub fn put(p: Pin, value: u1) void {
        const reg = switch (value) {
            0 => &instance(p.port).GPIOA_DOUTCLR31_0.raw.read(),
            1 => &instance(p.port).GPIOA_DOUTSET31_0.raw.read(),
        };
        reg.* = p.mask();
    }

    pub fn toggle(p: Pin) void {
        instance(p.port).GPIOA_DOUTTGL31_0.raw.write(p.mask());
    }

    pub fn read(p: Pin) u1 {
        return @intFromBool(instance(p.port).GPIOA_DIN31_0.raw.read() & p.mask() != 0);
    }
};

pub fn num(port: Port, n: u5) Pin {
    return .{ .port = port, .num = n };
}
