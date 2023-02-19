const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SIO = peripherals.SIO;
const PADS_BANK0 = peripherals.PADS_BANK0;
const IO_BANK0 = peripherals.IO_BANK0;

const resets = @import("resets.zig");

const log = std.log.scoped(.gpio);

pub const Function = enum(u5) {
    xip = 0,
    spi,
    uart,
    i2c,
    pwm,
    sio,
    pio0,
    pio1,
    gpck,
    usb,
    null = 0x1f,
};

pub const Direction = enum(u1) {
    in,
    out,
};

pub const IrqLevel = enum(u2) {
    low,
    high,
    fall,
    rise,
};

pub const IrqCallback = fn (gpio: u32, events: u32) callconv(.C) void;

pub const Override = enum {
    normal,
    invert,
    low,
    high,
};

pub const SlewRate = enum {
    slow,
    fast,
};

pub const DriveStrength = enum {
    @"2mA",
    @"4mA",
    @"8mA",
    @"12mA",
};

pub const Enabled = enum {
    disabled,
    enabled,
};

pub inline fn reset() void {
    resets.reset(&.{ .io_bank0, .pads_bank0 });
}

/// Initialize a GPIO, set func to SIO
pub inline fn init(comptime gpio: u32) void {
    const mask = 1 << gpio;
    SIO.GPIO_OE_CLR.raw = mask;
    SIO.GPIO_OUT_CLR.raw = mask;
    set_function(gpio, .sio);
}

/// Reset GPIO back to null function (disables it)
pub inline fn deinit(comptime gpio: u32) void {
    set_function(gpio, .null);
}

pub const PullUpDown = enum {
    up,
    down,
};

pub inline fn set_pull(comptime gpio: u32, mode: ?PullUpDown) void {
    const gpio_name = comptime std.fmt.comptimePrint("GPIO{d}", .{gpio});
    const gpio_regs = @field(PADS_BANK0, gpio_name);

    if (mode == null) {
        gpio_regs.modify(.{ .PUE = 0, .PDE = 0 });
    } else switch (mode.?) {
        .up => gpio_regs.modify(.{ .PUE = 1, .PDE = 0 }),
        .down => gpio_regs.modify(.{ .PUE = 0, .PDE = 1 }),
    }
}

pub inline fn set_direction(comptime gpio: u32, direction: Direction) void {
    const mask = 1 << gpio;
    switch (direction) {
        .in => SIO.GPIO_OE_CLR.raw = mask,
        .out => SIO.GPIO_OE_SET.raw = mask,
    }
}

/// Drive a single GPIO high/low
pub inline fn put(comptime gpio: u32, value: u1) void {
    std.log.debug("GPIO{} put: {}", .{ gpio, value });
    const mask = 1 << gpio;
    switch (value) {
        0 => SIO.GPIO_OUT_CLR.raw = mask,
        1 => SIO.GPIO_OUT_SET.raw = mask,
    }
}

pub inline fn toggle(comptime gpio: u32) void {
    SIO.GPIO_OUT_XOR.raw = (1 << gpio);
}

pub inline fn read(comptime gpio: u32) u1 {
    const mask = 1 << gpio;
    return if ((SIO.GPIO_IN.raw & mask) != 0)
        1
    else
        0;
}

pub inline fn set_function(comptime gpio: u32, function: Function) void {
    const pad_bank_reg = comptime std.fmt.comptimePrint("GPIO{}", .{gpio});
    @field(PADS_BANK0, pad_bank_reg).modify(.{
        .IE = 1,
        .OD = 0,
    });

    const io_bank_reg = comptime std.fmt.comptimePrint("GPIO{}_CTRL", .{gpio});
    @field(IO_BANK0, io_bank_reg).write(.{
        .FUNCSEL = .{ .raw = @enumToInt(function) },
        .OUTOVER = .{ .value = .NORMAL },
        .INOVER = .{ .value = .NORMAL },
        .IRQOVER = .{ .value = .NORMAL },
        .OEOVER = .{ .value = .NORMAL },

        .reserved8 = 0,
        .reserved12 = 0,
        .reserved16 = 0,
        .reserved28 = 0,
        .padding = 0,
    });
}

// setting both uplls enables a "bus keep" function, a weak pull to whatever
// is current high/low state of GPIO
//pub fn setPulls(gpio: u32, up: bool, down: bool) void {}
//
//pub fn pullUp(gpio: u32) void {}
//
//pub fn pullDown(gpio: u32) void {}
//pub fn disablePulls(gpio: u32) void {}
//pub fn setIrqOver(gpio: u32, value: u32) void {}
//pub fn setOutOver(gpio: u32, value: u32) void {}
//pub fn setInOver(gpio: u32, value: u32) void {}
//pub fn setOeOver(gpio: u32, value: u32) void {}
//pub fn setInputEnabled(gpio: u32, enabled: Enabled) void {}
//pub fn setinputHysteresisEnabled(gpio: u32, enabled: Enabled) void {}
//pub fn setSlewRate(gpio: u32, slew_rate: SlewRate) void {}
//pub fn setDriveStrength(gpio: u32, drive: DriveStrength) void {}
//pub fn setIrqEnabled(gpio: u32, events: IrqEvents) void {}
//pub fn acknowledgeIrq(gpio: u32, events: IrqEvents) void {}

