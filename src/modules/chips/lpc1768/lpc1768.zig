const std = @import("std");
const micro = @import("microzig");
const chip = @import("registers.zig");
const regs = chip.registers;

pub usingnamespace chip;

pub const cpu_frequency: u32 = 100_000_000; // 100 MHz

pub const PinTarget = enum(u2) {
    func00 = 0b00,
    func01 = 0b01,
    func10 = 0b10,
    func11 = 0b11,
};

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}.{Pin}\" scheme.";
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    const index = std.mem.indexOfScalar(u8, spec, '.') orelse @compileError(invalid_format_msg);

    const _port: comptime_int = std.fmt.parseInt(u3, spec[1..index], 10) catch @compileError(invalid_format_msg);
    const _pin: comptime_int = std.fmt.parseInt(u5, spec[index + 1 ..], 10) catch @compileError(invalid_format_msg);

    const sel_reg_name = std.fmt.comptimePrint("PINSEL{d}", .{(2 * _port + _pin / 16)});

    const _regs = struct {
        const name_suffix = std.fmt.comptimePrint("{d}", .{_port});

        const pinsel_reg = @field(regs.PINCONNECT, sel_reg_name);
        const pinsel_field = std.fmt.comptimePrint("P{d}_{d}", .{ _port, _pin });

        const dir = @field(regs.GPIO, "DIR" ++ name_suffix);
        const pin = @field(regs.GPIO, "PIN" ++ name_suffix);
        const set = @field(regs.GPIO, "SET" ++ name_suffix);
        const clr = @field(regs.GPIO, "CLR" ++ name_suffix);
        const mask = @field(regs.GPIO, "MASK" ++ name_suffix);
    };

    return struct {
        pub const port: u3 = _port;
        pub const pin: u5 = _pin;
        pub const regs = _regs;
        const gpio_mask: u32 = (1 << pin);

        pub const Targets = PinTarget;
    };
}

pub fn routePin(comptime pin: type, function: PinTarget) void {
    var val = pin.regs.pinsel_reg.read();
    @field(val, pin.regs.pinsel_field) = @enumToInt(function);
    pin.regs.pinsel_reg.write(val);
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        pin.regs.dir.raw |= pin.gpio_mask;
    }
    pub fn setInput(comptime pin: type) void {
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

pub fn Uart(comptime index: usize) type {
    return struct {
        const UARTn = switch (index) {
            0 => regs.UART0,
            1 => regs.UART1,
            2 => regs.UART2,
            3 => regs.UART3,
            else => @compileError("LPC1768 has 4 UARTs available."),
        };
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            micro.debug.write("0");
            switch (index) {
                0 => {
                    regs.SYSCON.PCONP.modify(.{ .PCUART0 = 1 });
                    regs.SYSCON.PCLKSEL0.modify(.{ .PCLK_UART0 = @enumToInt(uart.CClkDiv.four) });
                },
                1 => {
                    regs.SYSCON.PCONP.modify(.{ .PCUART1 = 1 });
                    regs.SYSCON.PCLKSEL0.modify(.{ .PCLK_UART1 = @enumToInt(uart.CClkDiv.four) });
                },
                2 => {
                    regs.SYSCON.PCONP.modify(.{ .PCUART2 = 1 });
                    regs.SYSCON.PCLKSEL1.modify(.{ .PCLK_UART2 = @enumToInt(uart.CClkDiv.four) });
                },
                3 => {
                    regs.SYSCON.PCONP.modify(.{ .PCUART3 = 1 });
                    regs.SYSCON.PCLKSEL1.modify(.{ .PCLK_UART3 = @enumToInt(uart.CClkDiv.four) });
                },
                else => unreachable,
            }
            micro.debug.write("1");

            UARTn.LCR.modify(.{
                // 8N1
                .WLS = @enumToInt(config.data_bits),
                .SBS = @enumToInt(config.stop_bits),
                .PE = if (config.parity != null) @as(u1, 1) else @as(u1, 0),
                .PS = if (config.parity) |p| @enumToInt(p) else @enumToInt(uart.Parity.odd),
                .BC = 0,
                .DLAB = 1,
            });
            micro.debug.write("2");

            // TODO: UARTN_FIFOS_ARE_DISA is not available in all uarts
            //UARTn.FCR.modify(.{ .FIFOEN = .UARTN_FIFOS_ARE_DISA });

            micro.debug.writer().print("clock: {} baud: {} ", .{
                micro.clock.get(),
                config.baud_rate,
            }) catch {};

            const pclk = micro.clock.get() / 4;
            const divider = (pclk / (16 * config.baud_rate));

            const regval = std.math.cast(u16, divider) catch return error.UnsupportedBaudRate;

            UARTn.DLL.modify(.{ .DLLSB = @truncate(u8, regval >> 0x00) });
            UARTn.DLM.modify(.{ .DLMSB = @truncate(u8, regval >> 0x08) });

            UARTn.LCR.modify(.{ .DLAB = 0 });

            return Self{};
        }

        pub fn canWrite(self: Self) bool {
            _ = self;
            return (UARTn.LSR.read().THRE == 1);
        }
        pub fn tx(self: Self, ch: u8) void {
            while (!self.canWrite()) {} // Wait for Previous transmission
            UARTn.THR.raw = ch; // Load the data to be transmitted
        }

        pub fn canRead(self: Self) bool {
            _ = self;
            return (UARTn.LSR.read().RDR == 1);
        }
        pub fn rx(self: Self) u8 {
            while (!self.canRead()) {} // Wait till the data is received
            return UARTn.RBR.read().RBR; // Read received data
        }
    };
}
