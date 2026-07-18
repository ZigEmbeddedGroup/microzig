const std = @import("std");
const microzig = @import("microzig");

const peri_types = microzig.chip.types.peripherals;
const Uart = @This();

regs: *volatile peri_types.uart0,

pub fn num(n: comptime_int) Uart {
    const name = std.fmt.comptimePrint("uart{}", .{n});
    return .{ .regs = if (@hasDecl(microzig.chip.peripherals, name))
        @field(microzig.chip.peripherals, name)
    else
        @compileError(name ++ " not present or not supported") };
}

pub const Config = struct {
    pub const Clock = struct {
        pub const Source = enum { BUSCLK, MFCLK, LFCLK };

        src: Source = .BUSCLK,
        div0: peri_types.uart0.ClkdivRatio = .@"1",
        ovs: RegFieldType("UART0_CTL0", "HSE") = .OVS16,
        div: microzig.utilities.IntFracDiv(16, 6),
    };

    clk: Clock,
    bits: RegFieldType("UART0_LCRH", "WLEN") = .DATABIT8,
    loopback: bool = false,
    manchester_encode: bool = false,
    enable: bool = true,
};

/// See Technical Reference Manual 14.2.6: Initialization
pub fn configure(self: Uart, cfg: Config) void {
    self.regs.UART0_PWREN.raw = 0x2600_0001;
    // Technical reference manual part 2.2.6
    inline for (0..4) |_|
        asm volatile ("nop");
    self.regs.UART0_CLKSEL.write(.{
        .LFCLK_SEL = @enumFromInt(@intFromBool(cfg.clk.src == .LFCLK)),
        .MFCLK_SEL = @enumFromInt(@intFromBool(cfg.clk.src == .MFCLK)),
        .BUSCLK_SEL = @enumFromInt(@intFromBool(cfg.clk.src == .BUSCLK)),
    });
    self.regs.UART0_CLKDIV.write(.{ .RATIO = cfg.clk.div0 });
    var ctl0 = self.regs.UART0_CTL0.read();
    if (ctl0.ENABLE != .DISABLE) {
        ctl0.ENABLE = .DISABLE;
        self.regs.UART0_CTL0.write(ctl0);
    }
    self.regs.UART0_IBRD.write(.{ .DIVINT = @enumFromInt(cfg.clk.div.int) });
    self.regs.UART0_FBRD.write(.{ .DIVFRAC = @enumFromInt(cfg.clk.div.frac) });

    // There are more ctl0 options
    ctl0.LBE = if (cfg.loopback) .ENABLE else .DISABLE;
    ctl0.MENC = if (cfg.manchester_encode) .ENABLE else .DISABLE;
    ctl0.HSE = cfg.clk.ovs;
    self.regs.UART0_CTL0.write(ctl0);

    self.regs.UART0_LCRH.write(.{
        .BRK = .DISABLE,
        .PEN = .DISABLE,
        .EPS = .ODD,
        .STP2 = .DISABLE,
        .WLEN = cfg.bits,
        .SPS = .DISABLE,
        .SENDIDLE = .DISABLE,
        .EXTDIR_SETUP = @enumFromInt(0),
        .EXTDIR_HOLD = @enumFromInt(0),
    });
    if (cfg.enable) {
        ctl0.ENABLE = .ENABLE;
        self.regs.UART0_CTL0.write(ctl0);
    }
}

pub fn disable(self: Uart) void {
    self.regs.PWREN = 0;
}

pub fn write(self: Uart, b: u8) bool {
    const stat = self.regs.UART0_STAT.read();
    if (stat.TXFF == .SET) return false;
    self.regs.UART0_TXDATA.write(.{ .DATA = @enumFromInt(b) });
    return true;
}

pub fn read(self: Uart) ?u8 {
    const stat = self.regs.UART0_STAT.read();
    if (stat.RXFE == .SET) return null;
    return @intFromEnum(self.regs.UART0_TXDATA.read().DATA);
}

pub const Writer = struct {
    const vtable: *const std.Io.Writer.VTable = &.{
        .drain = drain,
    };

    instance: Uart,
    seek: usize = 0,
    interface: std.Io.Writer,

    pub fn drain(w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
        _ = splat;
        const self: *Writer = @fieldParentPtr("interface", w);

        // Drain interface buffer first
        while (self.seek != w.end) {
            if (!self.instance.write(w.buffer[self.seek]))
                return 0;
            self.seek += 1;
        }
        w.end = 0;
        self.seek = 0;

        // Only drain from the first data slice
        for (data[0], 0..) |c, i| {
            if (!self.instance.write(c))
                return i;
        }
        return data[0].len;
    }
};

pub fn writer(self: Uart, buffer: []u8) Writer {
    return .{
        .instance = self,
        .interface = .{
            .vtable = Writer.vtable,
            .buffer = buffer,
        },
    };
}

var logger: ?Uart.Writer = null;

/// Set a specific uart instance to be used for logging.
///
/// Allows system logging over uart via:
/// pub const microzig_options = .{
///     .logFn = hal.uart.log,
/// };
pub fn init_logger(uart: Uart) void {
    logger = uart.writer("");
    logger.?.interface.writeAll("\r\n================ STARTING NEW LOGGER ================\r\n") catch {};
}

/// Disables logging via the uart instance.
pub fn deinit_logger() void {
    logger = null;
}

pub fn log(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    // const level_prefix = comptime "[{}.{:0>6}] " ++ level.asText();
    const prefix = comptime level.asText() ++ switch (scope) {
        .default => ": ",
        else => " (" ++ @tagName(scope) ++ "): ",
    };

    if (logger) |*w| {
        // const current_time = time.get_time_since_boot();
        // const seconds = current_time.to_us() / std.time.us_per_s;
        // const microseconds = current_time.to_us() % std.time.us_per_s;

        // w.interface.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
        w.interface.print(prefix ++ format ++ "\r\n", args) catch {};
        w.interface.flush() catch {};
    }
}

fn RegFieldType(register_name: []const u8, field_name: []const u8) type {
    const reg_idx = std.meta.fieldIndex(peri_types.uart0, register_name) orelse
        @compileError("No register " ++ register_name ++ " in uart0.");
    const Reg = std.meta.fieldTypes(peri_types.uart0)[reg_idx].underlying_type;

    const fld_idx = std.meta.fieldIndex(Reg, field_name) orelse
        @compileError("No field " ++ field_name ++ " in uart0." ++ register_name ++ ".");
    return std.meta.fieldTypes(Reg)[fld_idx];
}
