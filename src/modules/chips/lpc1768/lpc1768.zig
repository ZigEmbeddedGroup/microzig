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

pub fn parsePin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}.{Pin}\" scheme.";
    if (spec[0] != 'P')
        @compileError(invalid_format_msg);

    const index = std.mem.indexOfScalar(u8, spec, '.') orelse @compileError(invalid_format_msg);

    const _port: u3 = std.fmt.parseInt(u3, spec[1..index], 10) catch @compileError(invalid_format_msg);
    const _pin: u5 = std.fmt.parseInt(u5, spec[index + 1 ..], 10) catch @compileError(invalid_format_msg);

    const _regs = struct {
        const name_suffix = std.fmt.comptimePrint("{d}", .{_port});

        const dir = @field(registers.GPIO, "DIR" ++ name_suffix);
        const pin = @field(registers.GPIO, "PIN" ++ name_suffix);
        const set = @field(registers.GPIO, "SET" ++ name_suffix);
        const clr = @field(registers.GPIO, "CLR" ++ name_suffix);
        const mask = @field(registers.GPIO, "MASK" ++ name_suffix);
    };

    return struct {
        pub const port = _port;
        pub const pin = _pin;
        pub const regs = _regs;
        const gpio_mask: u32 = (1 << pin);
    };
}

pub const gpio = struct {
    pub fn setOutput(comptime pin: type) void {
        pin.regs.dir.raw |= pin.gpio_mask;
    }
    pub fn setInput(comptime pin: type) void {
        pin.regs.dir.raw &= ~pin.gpio_mask;
    }

    pub fn read(comptime pin: type) u1 {
        return if ((pin.regs.pin.raw & pin.gpio_mask) != 0)
            @as(u1, 1)
        else
            0;
    }

    pub fn write(comptime pin: type, state: u1) void {
        if (state == 1) {
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
            UARTn.FCR.modify(.{ .FIFOEN = false });

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
