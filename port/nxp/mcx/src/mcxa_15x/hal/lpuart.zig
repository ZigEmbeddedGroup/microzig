const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const syscon = @import("syscon.zig");
const mapper = @import("mapper.zig");
const meta = @import("meta_utils.zig");
const port = @import("port.zig");

const peripherals = microzig.chip.peripherals;
const LPUART_T = microzig.chip.types.peripherals.LPUART0;

pub const ReadError = error{
    FailedToRead,
} || error{Timeout};

pub const StatusError = packed struct {
    FE: bool = false, // Framing Error
    PE: bool = false, // Parity Error
    OR: bool = false, // Overrun Error
    NE: bool = false, // Noise Error
};

pub const Mux = enum(u3) {
    FRO_12M = 0,
    FRO_HF_DIV = 2,
    CLK_IN = 3,
    CLK_16K = 4,
    CLK_1M = 5,
    NO_CLK = 7,
    _,
};

pub const PinConfig = struct {
    TXD: mapper.PIN,
    RXD: ?mapper.PIN = null,
    CTS: ?mapper.PIN = null,
    RTS: ?mapper.PIN = null,
};

pub const OSR = enum(u5) {
    /// Results in an OSR of 16
    DEFAULT = 0x0,
    /// Results in an OSR of 4 (requires BAUD[BOTHEDGE] to be 1)
    OSR_4 = 0x3,
    /// Results in an OSR of 5 (requires BAUD[BOTHEDGE] to be 1)
    OSR_5 = 0x4,
    /// Results in an OSR of 6 (requires BAUD[BOTHEDGE] to be 1)
    OSR_6 = 0x5,
    /// Results in an OSR of 7 (requires BAUD[BOTHEDGE] to be 1)
    OSR_7 = 0x6,
    /// Results in an OSR of 8
    OSR_8 = 0x7,
    /// Results in an OSR of 9
    OSR_9 = 0x8,
    /// Results in an OSR of 10
    OSR_10 = 0x9,
    /// Results in an OSR of 11
    OSR_11 = 0xa,
    /// Results in an OSR of 12
    OSR_12 = 0xb,
    /// Results in an OSR of 13
    OSR_13 = 0xc,
    /// Results in an OSR of 14
    OSR_14 = 0xd,
    /// Results in an OSR of 15
    OSR_15 = 0xe,
    /// Results in an OSR of 16
    OSR_16 = 0xf,
    /// Results in an OSR of 17
    OSR_17 = 0x10,
    /// Results in an OSR of 18
    OSR_18 = 0x11,
    /// Results in an OSR of 19
    OSR_19 = 0x12,
    /// Results in an OSR of 20
    OSR_20 = 0x13,
    /// Results in an OSR of 21
    OSR_21 = 0x14,
    /// Results in an OSR of 22
    OSR_22 = 0x15,
    /// Results in an OSR of 23
    OSR_23 = 0x16,
    /// Results in an OSR of 24
    OSR_24 = 0x17,
    /// Results in an OSR of 25
    OSR_25 = 0x18,
    /// Results in an OSR of 26
    OSR_26 = 0x19,
    /// Results in an OSR of 27
    OSR_27 = 0x1a,
    /// Results in an OSR of 28
    OSR_28 = 0x1b,
    /// Results in an OSR of 29
    OSR_29 = 0x1c,
    /// Results in an OSR of 30
    OSR_30 = 0x1d,
    /// Results in an OSR of 31
    OSR_31 = 0x1e,
    /// Results in an OSR of 32
    OSR_32 = 0x1f,
    _,
};

pub const DataSize = enum {
    bits_7,
    bits_8,
    bits_9,
    bits_10,
};

pub const StopBits = enum {
    One,
    Two,
};

pub const endian = enum {
    LSB,
    MSB,
};

pub const Parity = enum {
    odd,
    even,
};

pub const InterruptConfig = struct {
    lin_break_detect: bool = false,
    rx_input_active_edge: bool = false,
    noise_error: bool = false,
    overrun: bool = false,
    framing: bool = false,
    parity: bool = false,
    tx_data: bool = false,
    tx_completed: bool = false,
    tx_overflow: bool = false,
    rx_data: bool = false,
    rx_underflow: bool = false,
    idle: bool = false,
};

pub const DMAConfig = struct {
    TX: bool = false,
    RX: bool = false,
    RX_FULL: bool = false,
    RX_IDLE: bool = false,
};

pub const Config = struct {
    stop_bits: StopBits = .One,
    data_size: DataSize = .bits_8,
    parity: ?Parity = null,
    baudrate: usize = 115200,
    oversample_rate: OSR = .OSR_13,
    both_edge_sampling: bool = false,
    rx_inversion: bool = false,
    tx_inversion: bool = false,

    interrupt: InterruptConfig = .{},
    dma: DMAConfig = .{},
};

pub const ConfigError = error{
    InvalidOversampleRate,
    UnsupportedBaudRate,
    UnsupportedClockSource,
};

// TODO: change this to a format that is portable to any chip
//TODO: Match Modes / LIN / wakeup / low-power / single wire / IR / watermark / MODEN
pub const LPUART = enum {
    LPUART0,
    LPUART1,
    LPUART2,
    LPUART3,
    LPUART4,

    pub fn get_regs(inst: LPUART) *volatile LPUART_T {
        return switch (inst) {
            .LPUART0 => peripherals.LPUART0,
            .LPUART1 => peripherals.LPUART1,
            .LPUART2 => peripherals.LPUART2,
            .LPUART3 => peripherals.LPUART3,
            .LPUART4 => peripherals.LPUART4,
        };
    }

    pub fn get_mrcc_tag(inst: LPUART) syscon.Peripheral {
        return switch (inst) {
            .LPUART0 => syscon.Peripheral.LPUART0,
            .LPUART1 => syscon.Peripheral.LPUART1,
            .LPUART2 => syscon.Peripheral.LPUART2,
            .LPUART3 => syscon.Peripheral.LPUART3,
            .LPUART4 => syscon.Peripheral.LPUART4,
        };
    }

    pub fn get_clk_tag(inst: LPUART) syscon.ClkPeripheral {
        return switch (inst) {
            .LPUART0 => syscon.ClkPeripheral.LPUART0,
            .LPUART1 => syscon.ClkPeripheral.LPUART1,
            .LPUART2 => syscon.ClkPeripheral.LPUART2,
            .LPUART3 => syscon.ClkPeripheral.LPUART3,
            .LPUART4 => syscon.ClkPeripheral.LPUART4,
        };
    }

    pub fn enable_clock(comptime inst: LPUART, div: u4, sel: Mux) void {
        syscon.set_clock(inst.get_clk_tag(), div, @fromBackingInt(@backingInt(sel)));
        syscon.enable_clock(inst.get_mrcc_tag());
        syscon.reset_release(inst.get_mrcc_tag());
    }

    pub fn get_clock_frequency(inst: LPUART) ConfigError!usize {
        const clock_tag = inst.get_clk_tag();
        const mux: Mux = @fromBackingInt(@backingInt(clock_tag.clksel().MUX));
        const divider = @as(usize, clock_tag.clkdiv().DIV) + 1;
        const source_frequency: usize = switch (mux) {
            .FRO_12M => syscon.clocks.fro_12m,
            .FRO_HF_DIV => syscon.clocks.fro_hf_div,
            .CLK_IN => syscon.clocks.clk_in,
            .CLK_16K => syscon.clocks.clk_16k_0,
            .CLK_1M => syscon.clocks.clk_1m,
            else => return error.UnsupportedClockSource,
        };

        if (source_frequency == 0) return error.UnsupportedClockSource;
        return source_frequency / divider;
    }

    pub fn get_baud_divisor(clock_frequency: usize, config: *const Config) ConfigError!u13 {
        const osr_value = @as(u5, @backingInt(config.oversample_rate));
        if (osr_value == 1 or osr_value == 2) return error.InvalidOversampleRate;

        const oversample: usize = if (osr_value == 0) 16 else @as(usize, osr_value) + 1;
        if (oversample <= 7 and !config.both_edge_sampling) {
            return error.InvalidOversampleRate;
        }
        if (config.baudrate == 0) return 0;

        const divisor_denominator = config.baudrate * oversample;
        const divisor = (clock_frequency + divisor_denominator / 2) / divisor_denominator;
        if (divisor == 0 or divisor > std.math.maxInt(u13)) {
            return error.UnsupportedBaudRate;
        }

        const actual_baudrate = clock_frequency / (divisor * oversample);

        //check 3% tolerance
        const difference: u64 = @max(actual_baudrate, config.baudrate) - @min(actual_baudrate, config.baudrate);
        if (difference * 100 > @as(u64, config.baudrate) * 3) {
            return error.UnsupportedBaudRate;
        }

        return @intCast(divisor);
    }

    pub fn apply(inst: LPUART, config: Config) ConfigError!void {
        const regs = inst.get_regs();
        const baud_divisor: u13 = try get_baud_divisor(try get_clock_frequency(inst), &config);

        // Reset the LPUART peripheral to ensure it's in a known state before applying new configuration
        //no delay is needed between set and clear of those bits.
        regs.GLOBAL.modify_one("RST", .RESET);
        regs.GLOBAL.modify_one("RST", .NO_EFFECT);

        var baud = regs.BAUD.read();
        baud.SBR = baud_divisor;
        baud.SBNS = if (config.stop_bits == .Two) .TWO else .ONE;
        baud.OSR = @fromBackingInt(@backingInt(config.oversample_rate));
        baud.BOTHEDGE = @fromBackingInt(@intFromBool(config.both_edge_sampling));
        baud.M10 = @fromBackingInt(@intFromBool(config.data_size == .bits_10));
        baud.RXEDGIE = @fromBackingInt(@intFromBool(config.interrupt.rx_input_active_edge));
        baud.LBKDIE = @fromBackingInt(@intFromBool(config.interrupt.lin_break_detect));
        baud.TDMAE = @fromBackingInt(@intFromBool(config.dma.TX));
        baud.RDMAE = @fromBackingInt(@intFromBool(config.dma.RX));
        baud.RIDMAE = @fromBackingInt(@intFromBool(config.dma.RX_IDLE));
        regs.BAUD.write(baud);

        var ctrl = regs.CTRL.read();
        ctrl.PE = @fromBackingInt(@intFromBool(config.parity != null));
        ctrl.PT = if (config.parity) |parity|
            (if (parity == .odd) .ODD else .EVEN)
        else
            .EVEN;
        ctrl.M = if (config.data_size == .bits_9) .DATA9 else .DATA8;
        ctrl.M7 = if (config.data_size == .bits_7) .DATA7 else .NO_EFFECT;
        ctrl.TXINV = @fromBackingInt(@intFromBool(config.tx_inversion));
        ctrl.NEIE = @fromBackingInt(@intFromBool(config.interrupt.noise_error));
        ctrl.ORIE = @fromBackingInt(@intFromBool(config.interrupt.overrun));
        ctrl.FEIE = @fromBackingInt(@intFromBool(config.interrupt.framing));
        ctrl.PEIE = @fromBackingInt(@intFromBool(config.interrupt.parity));
        ctrl.TIE = @fromBackingInt(@intFromBool(config.interrupt.tx_data));
        ctrl.TCIE = @fromBackingInt(@intFromBool(config.interrupt.tx_completed));
        ctrl.RIE = @fromBackingInt(@intFromBool(config.interrupt.rx_data));
        ctrl.ILIE = @fromBackingInt(@intFromBool(config.interrupt.idle));
        regs.CTRL.write(ctrl);

        var fifo = regs.FIFO.read();
        fifo.RXFE = .ENABLED;
        fifo.TXFE = .ENABLED;
        fifo.RXUFE = @fromBackingInt(@intFromBool(config.interrupt.rx_underflow));
        fifo.TXOFE = @fromBackingInt(@intFromBool(config.interrupt.tx_overflow));
        regs.FIFO.write(fifo);

        //MCXA156 has a 4-byte FIFO, so we set the watermark to 3 to trigger events when there are 3 bytes in the FIFO
        var water = regs.WATER.read();
        water.RXWATER = 3;
        water.TXWATER = 3;
        regs.WATER.write(water);

        var stat = regs.STAT.read();
        stat.RXINV = @fromBackingInt(@intFromBool(config.rx_inversion));
        regs.STAT.write(stat);

        ctrl = regs.CTRL.read();
        ctrl.TE = .ENABLED;
        ctrl.RE = .ENABLED;
        regs.CTRL.write(ctrl);
    }

    //TODO: allow for non-8bits char
    pub fn write_blocking(self: LPUART, data: []const u8, deadline: time.Deadline) !void {
        const regs = self.get_regs();
        for (data) |b| {
            while (regs.STAT.read().TDRE == .TXDATA)
                try deadline.check(microzig.hal.time.get_time_since_boot());
            regs.DATA.raw = b;
        }
        while (regs.STAT.read().TC == .ACTIVE) try deadline.check(microzig.hal.time.get_time_since_boot());
    }

    pub fn writev_blocking(self: LPUART, data: []const []const u8, deadline: time.Deadline) !void {
        for (data) |slice| {
            try self.write_blocking(slice, deadline);
        }
    }

    pub fn read_blocking(self: LPUART, data: []u8, deadline: time.Deadline) !void {
        const regs = self.get_regs();
        for (data) |*b| {
            while (regs.WATER.read().RXCOUNT == 0) {
                try deadline.check(microzig.hal.time.get_time_since_boot());
                try self.check_status();
            }
            b.* = @as(u8, @truncate(regs.DATA.raw));
            try self.check_status();
        }
    }

    pub fn readv_blocking(self: LPUART, payload: []const []u8, deadline: time.Deadline) !void {
        for (payload) |slice| {
            try self.read_blocking(slice, deadline);
        }
    }

    fn check_status(self: LPUART) ReadError!void {
        const regs = self.get_regs();
        const stat = regs.STAT.read();
        if (stat.FE == .ERROR or stat.PF == .PARITY or stat.OR == .OVERRUN or stat.NF == .NOISE) {
            return ReadError.FailedToRead;
        }
    }

    pub fn get_errors(self: LPUART) StatusError {
        const regs = self.get_regs();
        const stat = regs.STAT.read();
        return StatusError{
            .FE = @fromBackingInt(stat.FE),
            .PE = @fromBackingInt(stat.PF),
            .OR = @fromBackingInt(stat.OR),
            .NE = @fromBackingInt(stat.NF),
        };
    }

    pub fn clear_errors(self: LPUART) void {
        const regs = self.get_regs();
        var stat = regs.STAT.read();
        stat.FE = @fromBackingInt(1); //W1C
        stat.PF = @fromBackingInt(1);
        stat.OR = @fromBackingInt(1);
        stat.NF = @fromBackingInt(1);
        regs.STAT.write(stat);
    }

    pub fn set_pins(comptime inst: LPUART, comptime pin_config: PinConfig) void {
        const txd_mux = comptime std.meta.stringToEnum(mapper.SIGNALS, @tagName(inst) ++ "_txd").?;
        const rxd_mux = comptime std.meta.stringToEnum(mapper.SIGNALS, @tagName(inst) ++ "_rxd").?;
        const cts_mux = comptime std.meta.stringToEnum(mapper.SIGNALS, @tagName(inst) ++ "_cts").?;
        const rts_mux = comptime std.meta.stringToEnum(mapper.SIGNALS, @tagName(inst) ++ "_rts").?;

        port.Port.configure_pin(pin_config.TXD, .{
            .MUX = comptime meta.check_mux(pin_config.TXD, txd_mux),
        });

        if (pin_config.RXD) |pin| {
            port.Port.configure_pin(pin, .{
                .MUX = comptime meta.check_mux(pin, rxd_mux),
            });
        }
        if (pin_config.CTS) |pin| {
            port.Port.configure_pin(pin, .{
                .MUX = comptime meta.check_mux(pin, cts_mux),
            });
        }
        if (pin_config.RTS) |pin| {
            port.Port.configure_pin(pin, .{
                .MUX = comptime meta.check_mux(pin, rts_mux),
            });
        }
    }
};
