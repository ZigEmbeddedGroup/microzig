//! ### Function Select Table
//!
//!  GPIO   | F1       | F2        | F3       | F4     | F5  | F6   | F7   | F8            | F9
//!  -------|----------|-----------|----------|--------|-----|------|------|---------------|----
//!  0      | SPI0 RX  | UART0 TX  | I2C0 SDA | PWM0 A | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  1      | SPI0 CSn | UART0 RX  | I2C0 SCL | PWM0 B | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  2      | SPI0 SCK | UART0 CTS | I2C1 SDA | PWM1 A | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  3      | SPI0 TX  | UART0 RTS | I2C1 SCL | PWM1 B | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  4      | SPI0 RX  | UART1 TX  | I2C0 SDA | PWM2 A | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  5      | SPI0 CSn | UART1 RX  | I2C0 SCL | PWM2 B | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  6      | SPI0 SCK | UART1 CTS | I2C1 SDA | PWM3 A | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  7      | SPI0 TX  | UART1 RTS | I2C1 SCL | PWM3 B | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  8      | SPI1 RX  | UART1 TX  | I2C0 SDA | PWM4 A | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  9      | SPI1 CSn | UART1 RX  | I2C0 SCL | PWM4 B | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  10     | SPI1 SCK | UART1 CTS | I2C1 SDA | PWM5 A | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  11     | SPI1 TX  | UART1 RTS | I2C1 SCL | PWM5 B | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  12     | SPI1 RX  | UART0 TX  | I2C0 SDA | PWM6 A | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  13     | SPI1 CSn | UART0 RX  | I2C0 SCL | PWM6 B | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  14     | SPI1 SCK | UART0 CTS | I2C1 SDA | PWM7 A | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  15     | SPI1 TX  | UART0 RTS | I2C1 SCL | PWM7 B | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  16     | SPI0 RX  | UART0 TX  | I2C0 SDA | PWM0 A | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  17     | SPI0 CSn | UART0 RX  | I2C0 SCL | PWM0 B | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  18     | SPI0 SCK | UART0 CTS | I2C1 SDA | PWM1 A | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  19     | SPI0 TX  | UART0 RTS | I2C1 SCL | PWM1 B | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  20     | SPI0 RX  | UART1 TX  | I2C0 SDA | PWM2 A | SIO | PIO0 | PIO1 | CLOCK GPIN0   | USB VBUS EN
//!  21     | SPI0 CSn | UART1 RX  | I2C0 SCL | PWM2 B | SIO | PIO0 | PIO1 | CLOCK GPOUT0  | USB OVCUR DET
//!  22     | SPI0 SCK | UART1 CTS | I2C1 SDA | PWM3 A | SIO | PIO0 | PIO1 | CLOCK GPIN1   | USB VBUS DET
//!  23     | SPI0 TX  | UART1 RTS | I2C1 SCL | PWM3 B | SIO | PIO0 | PIO1 | CLOCK GPOUT1  | USB VBUS EN
//!  24     | SPI1 RX  | UART1 TX  | I2C0 SDA | PWM4 A | SIO | PIO0 | PIO1 | CLOCK GPOUT2  | USB OVCUR DET
//!  25     | SPI1 CSn | UART1 RX  | I2C0 SCL | PWM4 B | SIO | PIO0 | PIO1 | CLOCK GPOUT3  | USB VBUS DET
//!  26     | SPI1 SCK | UART1 CTS | I2C1 SDA | PWM5 A | SIO | PIO0 | PIO1 |               | USB VBUS EN
//!  27     | SPI1 TX  | UART1 RTS | I2C1 SCL | PWM5 B | SIO | PIO0 | PIO1 |               | USB OVCUR DET
//!  28     | SPI1 RX  | UART0 TX  | I2C0 SDA | PWM6 A | SIO | PIO0 | PIO1 |               | USB VBUS DET
//!  29     | SPI1 CSn | UART0 RX  | I2C0 SCL | PWM6 B | SIO | PIO0 | PIO1 |               | USB VBUS EN

const std = @import("std");
const microzig = @import("microzig");
const regs = microzig.chip.registers;
const assert = std.debug.assert;

pub const Function = enum(u5) {
    xip,
    spi,
    uart,
    i2c,
    pwm,
    sio,
    pio0,
    pio1,
    gpck,
    usb,
    @"null" = 0x1f,
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
    regs.RESETS.RESET.modify(.{ .io_bank0 = 1, .pads_bank0 = 1 });
    regs.RESETS.RESET.modify(.{ .io_bank0 = 0, .pads_bank0 = 0 });

    while (true) {
        const reset_done = regs.RESETS.RESET_DONE.read();
        if (reset_done.io_bank0 == 1 and reset_done.pads_bank0 == 1)
            break;
    }
}

/// Initialize a GPIO, set func to SIO
pub inline fn init(comptime gpio: u32) void {
    const mask = 1 << gpio;
    regs.SIO.GPIO_OE_CLR.raw = mask;
    regs.SIO.GPIO_OUT_CLR.raw = mask;
    setFunction(gpio, .sio);
}

/// Reset GPIO back to null function (disables it)
pub inline fn deinit(comptime gpio: u32) void {
    setFunction(gpio, .@"null");
}

pub inline fn setDir(comptime gpio: u32, direction: Direction) void {
    const mask = 1 << gpio;
    switch (direction) {
        .in => regs.SIO.GPIO_OE_CLR.raw = mask,
        .out => regs.SIO.GPIO_OE_SET.raw = mask,
    }
}

/// Drive a single GPIO high/low
pub inline fn put(comptime gpio: u32, value: u1) void {
    const mask = 1 << gpio;
    switch (value) {
        0 => regs.SIO.GPIO_OUT_CLR.raw = mask,
        1 => regs.SIO.GPIO_OUT_SET.raw = mask,
    }
}

pub inline fn toggle(comptime gpio: u32) void {
    regs.SIO.GPIO_OUT_XOR.raw = (1 << gpio);
}

pub inline fn setFunction(comptime gpio: u32, function: Function) void {
    const pad_bank_reg = comptime std.fmt.comptimePrint("GPIO{}", .{gpio});
    @field(regs.PADS_BANK0, pad_bank_reg).modify(.{
        .IE = 1,
        .OD = 0,
    });

    const io_bank_reg = comptime std.fmt.comptimePrint("GPIO{}_CTRL", .{gpio});
    @field(regs.IO_BANK0, io_bank_reg).write(.{
        .FUNCSEL = @enumToInt(function),
        .OUTOVER = 0,
        .INOVER = 0,
        .IRQOVER = 0,
        .OEOVER = 0,
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

