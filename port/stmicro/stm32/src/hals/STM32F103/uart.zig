const std = @import("std");
const microzig = @import("microzig");

const peripherals = microzig.chip.peripherals;
const UartReg = *volatile microzig.chip.types.peripherals.usart_v1.USART;
const M0 = microzig.chip.types.peripherals.usart_v1.M0;
const PS = microzig.chip.types.peripherals.usart_v1.PS;
const STOP = microzig.chip.types.peripherals.usart_v1.STOP;

pub const WordBits = enum {
    eight,
    nine,
};

pub const StopBits = enum {
    one,
    half,
    two,
    one_and_half,
};

pub const Parity = enum {
    none,
    even,
    odd,
};

pub const FlowControl = enum {
    none,
    CTS,
    RTS,
    CTS_RTS,
};

//TODO: add error for UART4/5 invalid features
pub const ConfigError = error{
    UnsupportedBaudRate,
};

pub const Config = struct {
    clock_speed: u32,
    baud_rate: u32,
    word_bits: WordBits = .eight,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
    flow_control: FlowControl = .none,
};

pub const TransmitError = error{
    Timeout,
};

pub const ReceiveError = error{
    OverrunError,
    BreakError,
    ParityError,
    FramingError,
    Timeout,
};

pub const ErrorStates = packed struct(u4) {
    overrun_error: bool = false,
    break_error: bool = false,
    parity_error: bool = false,
    framing_error: bool = false,
};

fn comptime_fail_or_error(msg: []const u8, fmt_args: anytype, err: ConfigError) ConfigError {
    if (@inComptime()) {
        @compileError(std.fmt.comptimePrint(msg, fmt_args));
    } else {
        return err;
    }
}

pub const UART = enum(u3) {
    _,

    /// Returns an error at runtime, and raises a compile error at comptime.
    fn validate_baudrate(baud_rate: u32, peri_freq: u32) ConfigError!void {
        const val: f32 = @as(f32, @floatFromInt(peri_freq)) / (@as(f32, @floatFromInt(baud_rate)) * 16);
        if (val > 4095) {
            return comptime_fail_or_error(
                "Baud {d} is too low for Clock {d}",
                .{ baud_rate, peri_freq },
                ConfigError.UnsupportedBaudRate,
            );
        } else if (val < 1.0) {
            return comptime_fail_or_error(
                "Baud {d} is too High for Clock {d}",
                .{ baud_rate, peri_freq },
                ConfigError.UnsupportedBaudRate,
            );
        }
    }

    fn get_regs(uart: UART) UartReg {
        return switch (@intFromEnum(uart)) {
            0 => if (@hasDecl(peripherals, "USART1")) peripherals.USART1 else @panic("Invalid UART"),
            1 => if (@hasDecl(peripherals, "USART2")) peripherals.USART2 else @panic("Invalid UART"),
            2 => if (@hasDecl(peripherals, "USART3")) peripherals.USART3 else @panic("Invalid UART"),
            3 => if (@hasDecl(peripherals, "UART4")) peripherals.UART4 else @panic("Invalid UART"),
            4 => if (@hasDecl(peripherals, "UART5")) peripherals.UART5 else @panic("Invalid UART"),
            else => @panic("Invalid UART"),
        };
    }

    pub fn apply(uart: UART, comptime config: Config) void {
        comptime validate_baudrate(config.baud_rate, config.clock_speed) catch unreachable;
        uart.apply_internal(config);
    }

    pub fn apply_runtime(uart: UART, comptime config: Config) void {
        try validate_baudrate(config.baud_rate, config.clock_speed);
        uart.apply_internal(config);
    }

    fn apply_internal(uart: UART, config: Config) void {
        const regs = get_regs(uart);
        uart.set_baudrate(config.baud_rate, config.clock_speed);
        uart.set_wordbits(config.word_bits);
        uart.set_parity(config.parity);
        uart.set_stopbits(config.stop_bits);
        uart.set_flowcontrol(config.flow_control);
        regs.CR1.modify(.{
            .UE = 1,
            .RE = 1,
            .TE = 1,
        });
    }

    fn set_baudrate(uart: UART, baudrate: u32, clock_fraq: u32) void {
        const regs = get_regs(uart);
        const baud: f32 = @as(f32, @floatFromInt(clock_fraq)) / (@as(f32, @floatFromInt(baudrate)) * 16);

        var mantissa: u32 = @intFromFloat(baud);
        var frac: u32 = @intFromFloat(@floor((baud - @as(f32, @floatFromInt(mantissa))) * 16));
        mantissa += @divTrunc(frac, 16);
        frac = frac % 16;

        const value: u32 = 0xFFFF & ((mantissa << 4) | frac);
        regs.BRR.raw = value;
    }

    fn set_wordbits(uart: UART, word: WordBits) void {
        const regs = get_regs(uart);
        regs.CR1.modify(.{
            .M0 = @as(M0, @enumFromInt(@intFromEnum(word))),
        });
    }

    fn set_stopbits(uart: UART, stops: StopBits) void {
        const regs = get_regs(uart);
        regs.CR2.modify(.{
            .STOP = @as(STOP, @enumFromInt(@intFromEnum(stops))),
        });
    }

    fn set_parity(uart: UART, parity: Parity) void {
        const regs = get_regs(uart);
        switch (parity) {
            .none => {
                regs.CR1.modify(.{
                    .PCE = 0,
                });
            },
            else => |ps| {
                const val: PS = @enumFromInt(@intFromEnum(ps) - 1);
                regs.CR1.modify(.{
                    .PCE = 1,
                    .PS = val,
                });
            },
        }
    }

    fn set_flowcontrol(uart: UART, flowcontrol: FlowControl) void {
        const regs = get_regs(uart);
        var RTS: u1 = 0;
        var CTS: u1 = 0;

        switch (flowcontrol) {
            .CTS => CTS = 1,
            .RTS => RTS = 1,
            .CTS_RTS => {
                CTS = 1;
                RTS = 1;
            },
            else => {},
        }

        regs.CR3.modify(.{
            .RTSE = RTS,
            .CTSE = CTS,
        });
    }

    pub fn write_blocking(uart: UART, data: []const u8) TransmitError!void {
        const regs = get_regs(uart);
        for (data) |bytes| {
            regs.DR.raw = @intCast(bytes);
            while (regs.SR.read().TXE == 0) {
                asm volatile ("nop");
            }
        }
    }
};
