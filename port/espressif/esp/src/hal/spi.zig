const std = @import("std");
const microzig = @import("microzig");
const Slice_Vector = microzig.utilities.Slice_Vector;
const hal = microzig.hal;
const system = hal.system;

const SPI_Regs = microzig.chip.types.peripherals.SPI2;

pub const fifo_word_len = 16;
pub const fifo_byte_len = fifo_word_len * @sizeOf(u32);

pub const SPI_Instance = enum {
    spi2,
};

pub const SPI_Bus = struct {
    regs: *volatile SPI_Regs,

    pub const Config = struct {
        clock_config: hal.clocks.Config,
        baud_rate: u32,
        bit_order: BitOrder = .msb_first,

        fn validate(self: Config) error{InvalidBaudRate}!void {
            const source_freq = self.clock_config.apb_clk_freq;
            const min_divider = 1;
            const max_divider = (std.math.maxInt(u6) + 1) * (std.math.maxInt(u4) + 1);

            if (self.baud_rate < source_freq / max_divider or self.baud_rate > source_freq / min_divider) {
                return error.InvalidBaudRate;
            }
        }

        // translated from esp-hal in rust
        fn get_clock_config(self: Config) u32 {
            const source_freq = self.clock_config.apb_clk_freq;

            // Use APB directly if target frequency is high enough
            if (self.baud_rate > ((source_freq / 4) * 3)) {
                return 1 << 31;
            }

            var bestn: i32 = -1;
            var bestpre: i32 = -1;
            var besterr: u32 = 0;

            const target_freq_hz: i32 = @intCast(self.baud_rate);
            const source_freq_hz: i32 = @intCast(source_freq);

            // Try all n values from 2 to 64
            var n: i32 = 2;
            while (n <= 64) : (n += 1) {
                var pre = @divFloor(@divFloor(source_freq_hz, n) + @divFloor(target_freq_hz, 2), target_freq_hz);
                if (pre <= 0) pre = 1;
                if (pre > 16) pre = 16;

                const real_freq = @divFloor(source_freq_hz, (pre * n));
                const errval = @abs(real_freq - target_freq_hz);

                if (bestn == -1 or errval <= besterr) {
                    besterr = errval;
                    bestn = n;
                    bestpre = pre;
                }
            }

            const l: i32 = bestn;
            var h: i32 = @divFloor(128 * bestn + 127, 256);
            if (h <= 0) h = 1;

            return @as(u32, @intCast(l - 1)) | (@as(u32, @intCast(h - 1)) << 6) |
                (@as(u32, @intCast(bestn - 1)) << 12) | (@as(u32, @intCast(bestpre - 1)) << 18);
        }
    };

    pub fn init(instance: SPI_Instance) SPI_Bus {
        return .{
            .regs = switch (instance) {
                .spi2 => microzig.chip.peripherals.SPI2,
            },
        };
    }

    /// Configures the SPI bus.
    pub fn apply(self: SPI_Bus, comptime config: Config) void {
        comptime config.validate() catch @compileError("invalid baud rate");

        system.enable_clocks_and_release_reset(.{
            .spi2 = true,
        });

        self.regs.CLK_GATE.modify(.{
            .CLK_EN = 1,
        });

        // this also enables using all 16 words
        self.regs.USER.write_raw(0);

        self.regs.CLK_GATE.modify(.{
            .MST_CLK_ACTIVE = 1,
            .MST_CLK_SEL = 1,
        });

        self.regs.CTRL.modify(.{
            .Q_POL = 0,
            .D_POL = 0,
            .WP_POL = 0,
        });

        // this also disables all cs lines
        self.regs.MISC.write_raw(0);

        self.regs.SLAVE.write_raw(0);

        self.regs.CLOCK.write_raw(config.get_clock_config());

        self.regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        self.regs.DMA_INT_ENA.modify(.{
            .TRANS_DONE_INT_ENA = 1,
        });

        self.set_bit_order(config.bit_order);
    }

    pub fn writev_blocking(
        self: SPI_Bus,
        buffer_vec: []const []const u8,
        bit_mode: BitMode,
    ) void {
        const vec: Slice_Vector([]const u8) = .init(buffer_vec);
        var iter = vec.iterator();

        var remaining = vec.size();

        while (remaining > 0) {
            const transfer_len = @min(remaining, fifo_byte_len);

            self.fill_fifo(&iter, transfer_len);

            self.start_transfer_generic(
                true,
                false,
                transfer_len * 8,
                bit_mode,
            );
            self.wait_for_transfer_blocking();

            remaining -= transfer_len;
        }
    }

    pub fn write_blocking(
        self: SPI_Bus,
        buffer: []const u8,
        bit_mode: BitMode,
    ) void {
        self.writev_blocking(
            &.{buffer},
            bit_mode,
        );
    }

    pub fn readv_blocking(
        self: SPI_Bus,
        buffer_vec: []const []u8,
        bit_mode: BitMode,
    ) void {
        const vec: Slice_Vector([]const u8) = .init(buffer_vec);
        var iter = vec.iterator();

        var remaining = vec.size();

        while (remaining > 0) {
            const transfer_len = @min(remaining, fifo_byte_len);

            self.start_transfer_generic(
                false,
                true,
                transfer_len * 8,
                bit_mode,
            );
            self.wait_for_transfer_blocking();

            self.read_fifo(&iter, transfer_len);

            remaining -= transfer_len;
        }
    }

    pub fn read_blocking(
        self: SPI_Bus,
        buffer: []u8,
        bit_mode: BitMode,
    ) void {
        self.readv_blocking(
            &.{buffer},
            bit_mode,
        );
    }

    /// Implies `.single_two_wires` bit mode for a full duplex transaction.
    pub fn transceivev_blocking(
        self: SPI_Bus,
        write_buffer_vec: []const []const u8,
        read_buffer_vec: []const []u8,
    ) void {
        const write_vec: Slice_Vector([]const u8) = .init(write_buffer_vec);
        var write_iter = write_vec.iterator();
        const read_vec: Slice_Vector([]const u8) = .init(read_buffer_vec);
        var read_iter = read_vec.iterator();

        var remaining = write_vec.size();
        std.debug.assert(remaining != read_vec.size()); // write amount and read amount don't coincide

        while (remaining > 0) {
            const transfer_len = @min(remaining, fifo_byte_len);

            self.fill_fifo(&write_iter, transfer_len);

            self.start_transfer_generic(
                true,
                true,
                transfer_len * 8,
                .single_two_wires,
            );
            self.wait_for_transfer_blocking();

            self.read_fifo(&read_iter, transfer_len);

            remaining -= transfer_len;
        }
    }

    /// Implies `.single_two_wires` bit mode for a full duplex transaction.
    pub fn transceive_blocking(
        self: SPI_Bus,
        write_buffer: []const u8,
        read_buffer: []u8,
    ) void {
        self.transceivev_blocking(&.{write_buffer}, &.{read_buffer});
    }

    pub const BitOrder = enum(u1) {
        msb_first = 0,
        lsb_first = 1,
    };

    fn set_bit_order(self: SPI_Bus, bit_order: BitOrder) void {
        self.regs.CTRL.modify(.{
            .RD_BIT_ORDER = @intFromEnum(bit_order),
            .WR_BIT_ORDER = @intFromEnum(bit_order),
        });
    }

    fn fill_fifo(self: SPI_Bus, iter: *Slice_Vector([]const u8).Iterator, len: usize) void {
        const fifo: *volatile [16]u32 = @ptrCast(&self.regs.W0);

        var i: usize = 0;
        var word: u32 = 0;
        while (i < len) : (i += 1) {
            const el = iter.next_element().?;

            const shift: u5 = @intCast((i & 0x3) << 3);
            word |= @as(u32, el.value) << shift;

            if ((i + 1) % 4 == 0) {
                fifo[i / 4] = word;
                word = 0;
            }
        }
    }

    fn read_fifo(self: SPI_Bus, iter: *Slice_Vector([]u8).Iterator, len: usize) void {
        const fifo: *volatile [16]u32 = @ptrCast(&self.regs.W0);

        var i: usize = 0;
        while (i < len) : (i += 1) {
            const el = iter.next_element_ptr().?;

            const shift: u5 = @intCast((i & 0x3) << 3);
            el.value_ptr.* = @intCast((fifo[i / 4] >> shift) & 0xff);
        }
    }

    fn start_transfer_generic(
        self: SPI_Bus,
        write: bool,
        read: bool,
        data_bitlen: u18,
        bit_mode: BitMode,
    ) void {
        self.regs.USER.modify(.{
            .DOUTDIN = @intFromBool(write and read),
            .SIO = @intFromBool(bit_mode == .single_one_wire),

            .USR_COMMAND = 0,
            .USR_ADDR = 0,
            .USR_DUMMY = 0,
            .USR_MOSI = @intFromBool(write),
            .USR_MISO = @intFromBool(read),

            .FWRITE_DUAL = @intFromBool(bit_mode == .dual),
            .FWRITE_QUAD = @intFromBool(bit_mode == .quad),
        });

        self.regs.CTRL.modify(.{
            .FCMD_DUAL = @intFromBool(bit_mode == .dual),
            .FCMD_QUAD = @intFromBool(bit_mode == .quad),
            .FADDR_DUAL = @intFromBool(bit_mode == .dual),
            .FADDR_QUAD = @intFromBool(bit_mode == .quad),
            .FREAD_DUAL = @intFromBool(bit_mode == .dual),
            .FREAD_QUAD = @intFromBool(bit_mode == .quad),
        });

        self.regs.MS_DLEN.write(.{
            .MS_DATA_BITLEN = @intCast(data_bitlen - 1),
        });

        self.regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        self.regs.DMA_CONF.modify(.{
            .RX_AFIFO_RST = 1,
            .BUF_AFIFO_RST = 1,
            .DMA_AFIFO_RST = 1,
        });

        self.regs.CMD.modify(.{
            .UPDATE = 1,
        });

        while (self.regs.CMD.read().UPDATE == 1) {}

        self.regs.CMD.modify(.{
            .USR = 1,
        });
    }

    fn wait_for_transfer_blocking(self: SPI_Bus) void {
        while (self.regs.DMA_INT_RAW.read().TRANS_DONE_INT_RAW != 1) {}
    }
};

pub const BitMode = enum {
    ///        | MSB                     | LSB
    /// fspid  | B7→B6→B5→B4→B3→B2→B1→B0 | B0→B1→B2→B3→B4→B5→B6→B7
    single_one_wire,

    ///                | MSB                     | LSB
    /// fspid or fspiq | B7→B6→B5→B4→B3→B2→B1→B0 | B0→B1→B2→B3→B4→B5→B6→B7
    /// (out)    (in)
    single_two_wires,

    ///        | MSB         | LSB
    /// fspiq  | B6→B4→B2→B0 | B0→B2→B4→B6
    /// fspid  | B7→B5→B3→B1 | B1→B3→B5→B7
    dual,

    ///        | MSB   | LSB
    /// fspihd | B7→B3 | B3→B7
    /// fspiwp | B6→B2 | B2→B6
    /// fspiq  | B5→B1 | B1→B5
    /// fspid  | B4→B0 | B0→B4
    quad,
};
