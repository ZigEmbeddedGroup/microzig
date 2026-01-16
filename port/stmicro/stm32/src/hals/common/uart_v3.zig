const std = @import("std");
const bdma_v1 = @import("./bdma_v1.zig");
const microzig = @import("microzig");
const enums = @import("enums.zig");
const UART_Type = enums.UART_Type;

const rcc = microzig.hal.rcc;
const USART_Periipheral = microzig.chip.types.peripherals.usart_v3.USART;
const STOP = microzig.chip.types.peripherals.usart_v3.STOP;

pub const WordBits = enum {
    seven,
    eight,
    nine,
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

pub const ConfigError = error{
    InvalidUartNum,
    UnsupportedBaudRate,
    UnsupportedFlowControl,
};

pub const Config = struct {
    baud_rate: u32 = 115200,
    word_bits: WordBits = .eight,
    stop_bits: STOP = .Stop1,
    parity: Parity = .none,
    flow_control: FlowControl = .none,
    dma: ?*bdma_v1.Channel = null,
};

pub const StopBits = STOP;
pub const DataBits = WordBits;

pub fn Uart(comptime index: UART_Type) type {
    const regs = enums.get_regs(USART_Periipheral, index);
    return struct {
        const Self = @This();

        dma: ?*bdma_v1.Channel,

        pub fn init(config: Config) Self {
            rcc.enable_clock(enums.to_peripheral(index));

            if (regs.CR1.read().UE == 1)
                @panic("Trying to initialize USART while it is already enabled");

            // clear USART1 configuration to its default
            regs.CR1.raw = 0;
            regs.CR2.raw = 0;
            regs.CR3.raw = 0;

            switch (config.word_bits) {
                .seven => regs.CR1.modify(.{ .M0 = .Bit8, .M1 = .Bit7 }),
                .eight => regs.CR1.modify(.{ .M0 = .Bit8, .M1 = .M0 }),
                .nine => regs.CR1.modify(.{ .M0 = .Bit9, .M1 = .M0 }),
            }
            switch (config.parity) {
                .none => regs.CR1.modify(.{ .PCE = 0 }),
                .even => regs.CR1.modify(.{ .PCE = 1, .PS = .Even }),
                .odd => regs.CR1.modify(.{ .PCE = 1, .PS = .Odd }),
            }

            regs.CR2.modify(.{ .STOP = config.stop_bits });

            // set the baud rate
            // TODO: Do not use the _board_'s frequency, but the _U(S)ARTx_ frequency
            // from the chip
            // TODO: Do some checks to see if the baud rate is too high (or perhaps too low)
            const usartdiv = @divTrunc(if (index == .USART1) rcc.current_clock.usart1_clk else rcc.current_clock.p1_clk, config.baud_rate);
            regs.BRR.raw = @as(u16, @intCast(usartdiv));
            // TODO: We assume the default OVER8=0 configuration above.

            // enable USART1, and its transmitter and receiver
            regs.CR1.modify(.{ .UE = 1 });
            regs.CR1.modify(.{ .TE = 1 });
            regs.CR1.modify(.{ .RE = 1 });

            if (config.dma != null) {
                regs.CR3.modify(.{ .DMAT = 1 });
            }

            return Self{ .dma = config.dma };
        }

        pub fn get_or_init(config: Config) !Self {
            if (regs.CR1.read().UE == 1) {
                // UART1 already enabled, don't reinitialize and disturb things;
                // instead read and use the actual configuration.
                return Self{ .dma = config.dma };
            } else return init(config);
        }

        pub fn read_mask() u8 {
            const cr1 = regs.CR1.read();
            return if (cr1.PCE == 1 and cr1.M0 == .Bit8) 0x7F else 0xFF;
        }

        pub fn can_write(self: Self) bool {
            _ = self;
            return switch (regs.ISR.read().TXE) {
                1 => true,
                0 => false,
            };
        }

        fn tx_blocking(self: Self, ch: u8) void {
            while (!self.can_write()) {} // Wait for Previous transmission
            regs.TDR.modify(.{ .DR = ch });
        }

        // We assume interrupt handler is setup
        fn tx(self: Self, buffer: []const u8) void {
            if (self.dma) |dma| fallback: {
                while (dma.is_in_progress()) {
                    // We wait for the last communication to end before sendig other byte
                    microzig.cpu.wfi();
                }

                dma.apply(.{
                    .direction = .FromMemory,
                    .memory_increment = true,
                    .periph_address = @intFromPtr(&regs.TDR),
                    .transfer_complete_interrupt = true,
                });

                dma.load_memeory_data(buffer) catch {
                    break :fallback;
                };

                regs.ICR.modify(.{ .TC = 1 });
                dma.start();
                return;
            }

            for (buffer) |byte| {
                self.tx_blocking(byte);
            }
        }

        pub fn txflush(_: Self) void {
            while (regs.ISR.read().TC == 0) {}
        }

        pub fn can_read(self: Self) bool {
            _ = self;
            return switch (regs.ISR.read().RXNE) {
                1 => true,
                0 => false,
            };
        }

        pub fn rx(self: Self) u8 {
            while (!self.can_read()) {} // Wait till the data is received
            const data_with_parity_bit: u9 = regs.RDR.read().RDR;
            return @as(u8, @intCast(data_with_parity_bit & self.read_mask()));
        }

        fn writer_fn(self: *Self, buffer: []const u8) error{}!usize {
            self.tx(buffer);
            return buffer.len;
        }
    };
}

pub fn UartWriter(comptime index: UART_Type) type {
    return struct {
        uart: *Uart(index),
        interface: std.Io.Writer,

        pub fn init(uart: *Uart(index), buffer: []u8) UartWriter(index) {
            return .{
                .uart = uart,
                .interface = .{
                    .vtable = &.{
                        .drain = drain,
                    },
                    .buffer = buffer,
                },
            };
        }

        pub fn drain(io_w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
            const w: *UartWriter(index) = @alignCast(@fieldParentPtr("interface", io_w));
            var n: u32 = 0;
            if (io_w.buffer.len > 0) {
                _ = try w.uart.writer_fn(io_w.buffered());
                n += io_w.consumeAll();
            }
            for (data[0 .. data.len - 1]) |buf| {
                n += try w.uart.writer_fn(buf);
            }
            const pattern = data[data.len - 1];
            for (0..splat) |_| {
                n += try w.uart.writer_fn(pattern);
            }
            return n;
        }
    };
}

pub fn UARTLogger(comptime index: UART_Type) type {
    return struct {
        var logger: ?UartWriter(index) = null;
        var uart: ?Uart(index) = null;

        pub fn init(config: Config) void {
            uart = Uart(index).init(config);
            logger = UartWriter(index).init(&uart.?, &.{});
            std.log.info("================ STARTING NEW LOGGER ================\r\n", .{});
        }
        pub fn deinit() void {

            // TODO Deinit usart
            logger = null;
        }

        pub fn log(comptime level: std.log.Level, comptime scope: @TypeOf(.EnumLiteral), comptime format: []const u8, args: anytype) void {
            const prefix = comptime level.asText() ++ switch (scope) {
                .default => ": ",
                else => " (" ++ @tagName(scope) ++ "): ",
            };

            if (logger) |*actual_logger| {
                var w = &actual_logger.interface;
                w.print(prefix ++ format ++ "\r\n", args) catch {};
            }
        }
    };
}
