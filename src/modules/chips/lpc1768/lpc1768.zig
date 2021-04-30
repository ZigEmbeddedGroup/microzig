const std = @import("std");
const micro = @import("microzig");
const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");
pub const registers = @import("registers.zig");

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
    micro_linker.MemoryRegion{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
};

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

        const pinsel_reg = @field(registers.PINCONNECT, sel_reg_name);
        const pinsel_field = std.fmt.comptimePrint("P{d}_{d}", .{ _port, _pin });

        const dir = @field(registers.GPIO, "DIR" ++ name_suffix);
        const pin = @field(registers.GPIO, "PIN" ++ name_suffix);
        const set = @field(registers.GPIO, "SET" ++ name_suffix);
        const clr = @field(registers.GPIO, "CLR" ++ name_suffix);
        const mask = @field(registers.GPIO, "MASK" ++ name_suffix);
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

pub fn Uart(comptime index: usize) type {
    return struct {
        const UARTn = switch (index) {
            0 => registers.UART0,
            1 => registers.UART1,
            2 => registers.UART2,
            3 => registers.UART3,
            else => @compileError("LPC1768 has 4 UARTs available."),
        };
        const Self = @This();

        pub fn init(config: micro.uart.Config) !Self {
            micro.debug.write("0");
            switch (index) {
                0 => {
                    registers.SYSCON.PCONP.modify(.{ .PCUART0 = true });
                    registers.SYSCON.PCLKSEL0.modify(.{ .PCLK_UART0 = 0 });
                },
                1 => {
                    registers.SYSCON.PCONP.modify(.{ .PCUART1 = true });
                    registers.SYSCON.PCLKSEL0.modify(.{ .PCLK_UART1 = 0 });
                },
                2 => {
                    registers.SYSCON.PCONP.modify(.{ .PCUART2 = true });
                    registers.SYSCON.PCLKSEL0.modify(.{ .PCLK_UART2 = 0 });
                },
                3 => {
                    registers.SYSCON.PCONP.modify(.{ .PCUART3 = true });
                    registers.SYSCON.PCLKSEL0.modify(.{ .PCLK_UART3 = 0 });
                },
                else => unreachable,
            }
            micro.debug.write("1");

            UARTn.LCR.write(.{
                // 8N1
                .WLS = switch (config.data_bits) {
                    .@"5" => 0b00,
                    .@"6" => 0b01,
                    .@"7" => 0b10,
                    .@"8" => 0b11,
                    .@"9" => return error.UnsupportedWordSize,
                },
                .SBS = switch (config.stop_bits) {
                    .one => false,
                    .two => true,
                },
                .PE = (config.parity != .none),
                .PS = switch (config.parity) {
                    .none, .odd => @as(u2, 0b00),
                    .even => 0b01,
                    .mark => 0b10,
                    .space => 0b11,
                },
                .BC = false,
                .DLAB = true,
            });
            micro.debug.write("2");
            UARTn.FCR.modify(.{ .FIFOEN = false });

            micro.debug.writer().print("clock: {} baud: {} ", .{
                micro.clock.get(),
                config.baud_rate,
            }) catch {};

            const pclk = micro.clock.get() / 4;
            const divider = (pclk / (16 * config.baud_rate));

            const regval = std.math.cast(u16, divider) catch return error.UnsupportedBaudRate;

            UARTn.DLL.write(.{ .DLLSB = @truncate(u8, regval >> 0x00) });
            UARTn.DLM.write(.{ .DLMSB = @truncate(u8, regval >> 0x08) });

            UARTn.LCR.modify(.{ .DLAB = false });

            return Self{};
        }

        pub fn canWrite(self: Self) bool {
            return UARTn.LSR.read().THRE;
        }
        pub fn tx(self: Self, ch: u8) void {
            while (!self.canWrite()) {} // Wait for Previous transmission
            UARTn.THR.raw = ch; // Load the data to be transmitted
        }

        pub fn canRead(self: Self) bool {
            return UARTn.LSR.read().RDR;
        }
        pub fn rx(self: Self) u8 {
            while (!self.canRead()) {} // Wait till the data is received
            return UARTn.RBR.read().RBR; // Read received data
        }
    };
}
