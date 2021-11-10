const std = @import("std");
const micro = @import("microzig");
const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");
pub const registers = @import("registers.zig");
pub const clocks = @import("clocks.zig");

pub const reset = @import("reset.zig").reset;

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x10000000, .length = 2 * 1024 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x20000000, .length = 256 * 1024, .kind = .ram },
};

pub const PinTarget = enum {
    gpio,
    pwm,
    adc,

    spi0_sclk,
    spi0_mosi,
    spi0_miso,
    spi0_ss,

    spi1_sclk,
    spi1_mosi,
    spi1_miso,
    spi1_ss,

    uart0_tx,
    uart0_rx,
    uart0_cts,
    uart0_rts,

    uart1_tx,
    uart1_rx,
    uart1_cts,
    uart1_rts,

    i2c0_scl,
    i2c0_sda,

    i2c1_scl,
    i2c1_sda,

    pio0,
    pio1,
};

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"GPIO{Pin}\" scheme.";
    if (spec.len < 5)
        @compileError(invalid_format_msg);

    if (!std.mem.eql(u8, spec[0..4], "GPIO"))
        @compileError(invalid_format_msg);

    const _pin: comptime_int = std.fmt.parseInt(u5, spec[4..], 10) catch @compileError(invalid_format_msg);
    if (_pin > 29)
        @compileError(std.fmt.comptimePrint("Invalid pin number {} valid pins are from range 0..29", .{_pin}));

    const name_suffix = std.fmt.comptimePrint("GPIO{d}", .{_pin});
    const _regs = struct {
        const CTRL = @field(registers.IO_BANK0, std.fmt.comptimePrint("{s}_CTRL", .{name_suffix}));
        const FUNCSEL = struct {
            const Type = std.meta.fieldInfo(@TypeOf(CTRL.*).underlying_type, .FUNCSEL).field_type;
            const sio = @field(Type, std.fmt.comptimePrint("sio_{}", .{_pin}));
            const pio0 = @field(Type, std.fmt.comptimePrint("pio0_{}", .{_pin}));
            const pio1 = @field(Type, std.fmt.comptimePrint("pio1_{}", .{_pin}));
        };
    };

    return struct {
        pub const pin: u5 = _pin;
        pub const regs = _regs;
        pub const gpio_mask: u32 = 1 << pin;

        pub const Targets = PinTarget;
    };
}

pub fn getFuncseclFromTarget(comptime pin: type, comptime function: PinTarget) ?pin.regs.FUNCSEL.Type {
    switch (function) {
        .gpio => return pin.regs.FUNCSEL.sio,
        .pio0 => return pin.regs.FUNCSEL.pio0,
        .pio1 => return pin.regs.FUNCSEL.pio1,

        .spi0_mosi => return .spi0_tx,
        .spi1_mosi => return .spi1_tx,

        .spi0_miso => return .spi0_rx,
        .spi1_miso => return .spi1_rx,
        else => {},
    }

    const name = @tagName(function);
    if (@hasField(pin.regs.FUNCSEL.Type, name)) {
        return @field(pin.regs.FUNCSEL.Type, name);
    }

    return null;
}

pub fn routePin(comptime pin: type, comptime function: PinTarget) void {
    if (comptime getFuncseclFromTarget(pin, function)) |func|
        pin.regs.CTRL.modify(.{ .FUNCSEL = func })
    else
        @compileError(comptime std.fmt.comptimePrint("Pin GPIO{} doesn't support function {s}", .{ pin.pin, @tagName(function) }));
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        registers.SIO.GPIO_OE_SET.modify(.{ .GPIO_OE_SET = pin.gpio_mask });
    }
    pub fn setInput(comptime pin: type) void {
        registers.SIO.GPIO_OE_CLR.modify(.{ .GPIO_OE_CLR = pin.gpio_mask });
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        return if ((registers.SIO.GPIO_IN.raw & pin.gpio_mask) != 0)
            micro.gpio.State.high
        else
            micro.gpio.State.low;
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        if (state == .high) {
            registers.SIO.GPIO_OUT_SET.raw = pin.gpio_mask;
        } else {
            registers.SIO.GPIO_OUT_CLR.raw = pin.gpio_mask;
        }
    }

    pub fn toggle(comptime pin: type) void {
        registers.SIO.GPIO_OUT_XOR.raw = pin.gpio_mask;
    }
};

pub const uart = struct {
    pub const DataBits = enum(u2) {
        five = 0,
        six = 1,
        seven = 2,
        eight = 3,
    };

    pub const StopBits = enum(u1) {
        one = 0,
        two = 1,
    };

    pub const Parity = enum(u1) {
        even = 1,
        odd = 0,
    };
};

pub fn Uart(comptime index: usize) type {
    return struct {
        const UARTn = switch (index) {
            0 => registers.UART0,
            1 => registers.UART1,
            else => @compileError("rp2040 has 2 UARTs available."),
        };
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            UARTn.UARTCR.modify(.{
                .UARTEN = 1, // enable uart
                .TXE = 1, // enable tx
                .RXE = 1, // enable rx
            });

            UARTn.UARTLCR_H.modify(.{
                .FEN = 1, // enable fifos

                .WLEN = @enumToInt(config.data_bits),
                .STP2 = @enumToInt(config.stop_bits),
                .PEN = if (config.parity) |_| @as(u1, 1) else @as(u1, 0),
                .EPS = if (config.parity) |p| @enumToInt(p) else 0,
            });

            {
                // the uart controller doesn't count start and stop bits
                const data_bits: u32 = switch (config.data_bits) {
                    .five => @as(u32, 5),
                    .six => 6,
                    .seven => 7,
                    .eight => 8,
                } + if (config.parity) |_| @as(u32, 1) else 0;

                const baud_rate_div: u32 = (data_bits * clocks.current_clocks_config.clocks.sys.frequency) / config.baud_rate;
                var baud_ibrd: u16 = @intCast(u16, baud_rate_div >> 7);
                var baud_fbrd: u6 = @intCast(u6, ((baud_rate_div & 0x7f) + 1) / 2);
                if (baud_ibrd == 0) {
                    baud_ibrd = 1;
                    baud_fbrd = 0;
                } else if (baud_ibrd >= 65535) {
                    baud_ibrd = 65535;
                    baud_fbrd = 0;
                }

                UARTn.UARTIBRD.write(.{ .BAUD_DIVINT = baud_ibrd });
                UARTn.UARTFBRD.write(.{ .BAUD_DIVFRAC = baud_fbrd });

                //
                UARTn.UARTLCR_H.modify(.{});
            }

            return Self{};
        }

        pub fn canWrite(self: Self) bool {
            _ = self;
            return UARTn.UARTFR.read().BUSY == 0;
        }
        pub fn tx(self: Self, ch: u8) void {
            _ = self;
            UARTn.UARTDR.modify(.{ .DATA = ch });
        }

        pub fn canRead(self: Self) bool {
            _ = self;
        }
        pub fn rx(self: Self) u8 {
            _ = self;
            return 0;
        }
    };
}

// TODO: implement that in inline assemble
// this is boot2.bin stolen from official sdk
pub export const _BOOT2: [256]u8 linksection(".microzig_rp2040_boot2") = [_]u8{ 0x00, 0xb5, 0x32, 0x4b, 0x21, 0x20, 0x58, 0x60, 0x98, 0x68, 0x02, 0x21, 0x88, 0x43, 0x98, 0x60, 0xd8, 0x60, 0x18, 0x61, 0x58, 0x61, 0x2e, 0x4b, 0x00, 0x21, 0x99, 0x60, 0x02, 0x21, 0x59, 0x61, 0x01, 0x21, 0xf0, 0x22, 0x99, 0x50, 0x2b, 0x49, 0x19, 0x60, 0x01, 0x21, 0x99, 0x60, 0x35, 0x20, 0x00, 0xf0, 0x44, 0xf8, 0x02, 0x22, 0x90, 0x42, 0x14, 0xd0, 0x06, 0x21, 0x19, 0x66, 0x00, 0xf0, 0x34, 0xf8, 0x19, 0x6e, 0x01, 0x21, 0x19, 0x66, 0x00, 0x20, 0x18, 0x66, 0x1a, 0x66, 0x00, 0xf0, 0x2c, 0xf8, 0x19, 0x6e, 0x19, 0x6e, 0x19, 0x6e, 0x05, 0x20, 0x00, 0xf0, 0x2f, 0xf8, 0x01, 0x21, 0x08, 0x42, 0xf9, 0xd1, 0x00, 0x21, 0x99, 0x60, 0x1b, 0x49, 0x19, 0x60, 0x00, 0x21, 0x59, 0x60, 0x1a, 0x49, 0x1b, 0x48, 0x01, 0x60, 0x01, 0x21, 0x99, 0x60, 0xeb, 0x21, 0x19, 0x66, 0xa0, 0x21, 0x19, 0x66, 0x00, 0xf0, 0x12, 0xf8, 0x00, 0x21, 0x99, 0x60, 0x16, 0x49, 0x14, 0x48, 0x01, 0x60, 0x01, 0x21, 0x99, 0x60, 0x01, 0xbc, 0x00, 0x28, 0x00, 0xd0, 0x00, 0x47, 0x12, 0x48, 0x13, 0x49, 0x08, 0x60, 0x03, 0xc8, 0x80, 0xf3, 0x08, 0x88, 0x08, 0x47, 0x03, 0xb5, 0x99, 0x6a, 0x04, 0x20, 0x01, 0x42, 0xfb, 0xd0, 0x01, 0x20, 0x01, 0x42, 0xf8, 0xd1, 0x03, 0xbd, 0x02, 0xb5, 0x18, 0x66, 0x18, 0x66, 0xff, 0xf7, 0xf2, 0xff, 0x18, 0x6e, 0x18, 0x6e, 0x02, 0xbd, 0x00, 0x00, 0x02, 0x40, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x07, 0x00, 0x00, 0x03, 0x5f, 0x00, 0x21, 0x22, 0x00, 0x00, 0xf4, 0x00, 0x00, 0x18, 0x22, 0x20, 0x00, 0xa0, 0x00, 0x01, 0x00, 0x10, 0x08, 0xed, 0x00, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x74, 0xb2, 0x4e, 0x7a };
