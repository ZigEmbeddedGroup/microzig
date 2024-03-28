const std = @import("std");
const micro = @import("microzig");
const peripherals = micro.chip.peripherals;
const GPIO = peripherals.GPIO;
const PINCONNECT = peripherals.PINCONNECT;
const UART0 = peripherals.UART0;
const UART1 = peripherals.UART1;
const UART2 = peripherals.UART2;
const UART3 = peripherals.UART3;
const SYSCON = peripherals.SYSCON;

pub const clock = struct {
    pub const Domain = enum {
        cpu,
    };
};

pub const clock_frequencies = .{
    .cpu = 100_000_000, // 100 Mhz
};

pub const PinTarget = enum(u2) {
    func00 = 0b00,
    func01 = 0b01,
    func10 = 0b10,
    func11 = 0b11,
};

pub fn parse_pin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}.{Pin}\" scheme.";
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    const index = std.mem.indexOfScalar(u8, spec, '.') orelse @compileError(invalid_format_msg);

    const _port: comptime_int = std.fmt.parseInt(u3, spec[1..index], 10) catch @compileError(invalid_format_msg);
    const _pin: comptime_int = std.fmt.parseInt(u5, spec[index + 1 ..], 10) catch @compileError(invalid_format_msg);

    const sel_reg_name = std.fmt.comptimePrint("PINSEL{d}", .{(2 * _port + _pin / 16)});

    const _regs = struct {
        const name_suffix = std.fmt.comptimePrint("{d}", .{_port});

        const pinsel_reg = @field(PINCONNECT, sel_reg_name);
        const pinsel_field = std.fmt.comptimePrint("P{d}_{d}", .{ _port, _pin });

        const dir = @field(GPIO, "DIR" ++ name_suffix);
        const pin = @field(GPIO, "PIN" ++ name_suffix);
        const set = @field(GPIO, "SET" ++ name_suffix);
        const clr = @field(GPIO, "CLR" ++ name_suffix);
        const mask = @field(GPIO, "MASK" ++ name_suffix);
    };

    return struct {
        pub const port: u3 = _port;
        pub const pin: u5 = _pin;
        pub const regs = _regs;
        const gpio_mask: u32 = (1 << pin);

        pub const Targets = PinTarget;
    };
}

pub fn route_pin(comptime pin: type, function: PinTarget) void {
    var val = pin.regs.pinsel_reg.read();
    @field(val, pin.regs.pinsel_field) = @intFromEnum(function);
    pin.regs.pinsel_reg.write(val);
}

pub const gpio = struct {
    pub fn set_output(comptime pin: type) void {
        pin.regs.dir.raw |= pin.gpio_mask;
    }
    pub fn set_input(comptime pin: type) void {
        pin.regs.dir.raw &= ~pin.gpio_mask;
    }

    pub fn read(comptime pin: type) micro.gpio.State {
        return if ((pin.regs.pin.raw & pin.gpio_mask) != 0)
            micro.gpio.State.high
        else
            micro.gpio.State.low;
    }

    pub fn write(comptime pin: type, state: micro.gpio.State) void {
        if (state == .high) {
            pin.regs.set.raw = pin.gpio_mask;
        } else {
            pin.regs.clr.raw = pin.gpio_mask;
        }
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

    pub const Parity = enum(u2) {
        odd = 0,
        even = 1,
        mark = 2,
        space = 3,
    };

    pub const CClkDiv = enum(u2) {
        four = 0,
        one = 1,
        two = 2,
        eight = 3,
    };
};

pub fn Uart(comptime index: usize, comptime pins: micro.uart.Pins) type {
    if (pins.tx != null or pins.rx != null)
        @compileError("TODO: custom pins are not currently supported");

    return struct {
        const UARTn = switch (index) {
            0 => UART0,
            1 => UART1,
            2 => UART2,
            3 => UART3,
            else => @compileError("LPC1768 has 4 UARTs available."),
        };
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            micro.debug.write("0");
            switch (index) {
                0 => {
                    SYSCON.PCONP.modify(.{ .PCUART0 = 1 });
                    SYSCON.PCLKSEL0.modify(.{ .PCLK_UART0 = @intFromEnum(uart.CClkDiv.four) });
                },
                1 => {
                    SYSCON.PCONP.modify(.{ .PCUART1 = 1 });
                    SYSCON.PCLKSEL0.modify(.{ .PCLK_UART1 = @intFromEnum(uart.CClkDiv.four) });
                },
                2 => {
                    SYSCON.PCONP.modify(.{ .PCUART2 = 1 });
                    SYSCON.PCLKSEL1.modify(.{ .PCLK_UART2 = @intFromEnum(uart.CClkDiv.four) });
                },
                3 => {
                    SYSCON.PCONP.modify(.{ .PCUART3 = 1 });
                    SYSCON.PCLKSEL1.modify(.{ .PCLK_UART3 = @intFromEnum(uart.CClkDiv.four) });
                },
                else => unreachable,
            }
            micro.debug.write("1");

            UARTn.LCR.modify(.{
                // 8N1
                .WLS = @intFromEnum(config.data_bits),
                .SBS = @intFromEnum(config.stop_bits),
                .PE = if (config.parity != null) @as(u1, 1) else @as(u1, 0),
                .PS = if (config.parity) |p| @intFromEnum(p) else @intFromEnum(uart.Parity.odd),
                .BC = 0,
                .DLAB = 1,
            });
            micro.debug.write("2");

            // TODO: UARTN_FIFOS_ARE_DISA is not available in all uarts
            //UARTn.FCR.modify(.{ .FIFOEN = .UARTN_FIFOS_ARE_DISA });

            micro.debug.writer().print("clock: {} baud: {} ", .{
                micro.clock.get().cpu,
                config.baud_rate,
            }) catch {};

            const pclk = micro.clock.get().cpu / 4;
            const divider = (pclk / (16 * config.baud_rate));

            const regval = std.math.cast(u16, divider) orelse return error.UnsupportedBaudRate;

            UARTn.DLL.modify(.{ .DLLSB = @as(u8, @truncate(regval >> 0x00)) });
            UARTn.DLM.modify(.{ .DLMSB = @as(u8, @truncate(regval >> 0x08)) });

            UARTn.LCR.modify(.{ .DLAB = 0 });

            return Self{};
        }

        pub fn can_write(self: Self) bool {
            _ = self;
            return (UARTn.LSR.read().THRE == 1);
        }
        pub fn tx(self: Self, ch: u8) void {
            while (!self.can_write()) {} // Wait for Previous transmission
            UARTn.THR.raw = ch; // Load the data to be transmitted
        }

        pub fn can_read(self: Self) bool {
            _ = self;
            return (UARTn.LSR.read().RDR == 1);
        }
        pub fn rx(self: Self) u8 {
            while (!self.can_read()) {} // Wait till the data is received
            return UARTn.RBR.read().RBR; // Read received data
        }
    };
}
