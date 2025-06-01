const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const system = hal.system;

const SPI_Regs = microzig.chip.types.peripherals.SPI2;

pub const SPI = enum(u2) {
    spi2,

    inline fn get_regs(self: SPI) *volatile SPI_Regs {
        return switch (self) {
            .spi2 => microzig.chip.peripherals.SPI2,
        };
    }

    pub const Config = struct {
        clock_config: hal.clocks.Config,
        baud_rate: u32,
        bit_order: BitOrder = .msb_first,
        // TODO: pins polarity
        // TODO: clock phase

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

    pub fn apply(self: SPI, comptime config: Config) void {
        comptime config.validate() catch @compileError("invalid baud rate");

        system.enable_clocks_and_release_reset(.{
            .spi2 = true,
        });

        const regs = self.get_regs();

        regs.CLK_GATE.modify(.{
            .CLK_EN = 1,
        });

        // this also enables using all 16 words
        regs.USER.write_raw(0);

        regs.CLK_GATE.modify(.{
            .MST_CLK_ACTIVE = 1,
            .MST_CLK_SEL = 1,
        });

        regs.CTRL.modify(.{
            .Q_POL = 0,
            .D_POL = 0,
            .WP_POL = 0,
        });

        regs.SLAVE.write_raw(0);

        regs.CLOCK.write_raw(config.get_clock_config());

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        regs.DMA_INT_ENA.modify(.{
            .TRANS_DONE_INT_ENA = 1,
        });

        self.set_bit_order(config.bit_order);
    }

    pub fn full_duplex_transceive_blocking(self: SPI, write_buffer: []const u8, read_buffer: []u8) void {
        std.debug.assert(write_buffer.len == read_buffer.len);

        const spi_buffer = self.get_spi_buffer();

        var remaining_write_buffer = write_buffer;
        var remaining_read_buffer = read_buffer;

        while (remaining_write_buffer.len != 0) {
            const transfer_len: u18 = @intCast(@min(remaining_write_buffer.len, @sizeOf(u32) * spi_buffer.len));

            self.write_spi_buffer(spi_buffer, remaining_write_buffer, transfer_len);

            self.do_transfer_generic(
                null,
                null,
                0,
                .{ .in = true, .out = true },
                transfer_len,
                .single_two_wires,
            );

            self.read_spi_buffer(spi_buffer, read_buffer, transfer_len);

            remaining_write_buffer = remaining_write_buffer[transfer_len..];
            remaining_read_buffer = remaining_read_buffer[transfer_len..];
        }
    }

    pub fn half_duplex_write_blocking(self: SPI, buffer: []const u8, bit_mode: BitMode) void {
        const regs = self.get_regs();

        regs.USER.modify(.{
            .DOUTDIN = 0,
            .SIO = @intFromBool(bit_mode == .single_one_wire),
        });

        self.set_bit_mode(bit_mode);

        regs.USER.modify(.{
            .USR_COMMAND = 0,
            .USR_ADDR = 0,
            .USR_DUMMY = 0,
            .USR_MOSI = 1,
            .USR_MISO = 0,
        });

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        regs.DMA_CONF.modify(.{
            .RX_AFIFO_RST = 1,
            .BUF_AFIFO_RST = 1,
            .DMA_AFIFO_RST = 1,
        });

        const buf: *volatile [16]u32 = @ptrCast(&regs.W0);
        const transfer_size = @min(buffer.len, @sizeOf(u32) * buf.len);

        regs.MS_DLEN.write(.{
            .MS_DATA_BITLEN = @intCast(8 * transfer_size - 1),
        });

        {
            var i: usize = 0;
            var word: u32 = 0;
            while (i < transfer_size) : (i += 1) {
                const shift: u5 = @intCast((i & 0x3) << 3);
                word |= @as(u32, buffer[i]) << shift;

                if ((i + 1) % 4 == 0) {
                    buf[i / 4] = word;
                    word = 0;
                }
            }

            if (i % 4 != 0) {
                buf[i / 4] = word;
            }
        }

        regs.CMD.modify(.{
            .UPDATE = 1,
        });

        while (regs.CMD.read().UPDATE == 1) {}

        regs.CMD.modify(.{
            .USR = 1,
        });

        while (regs.DMA_INT_RAW.read().TRANS_DONE_INT_RAW != 1) {}

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });
    }

    pub fn half_duplex_read_blocking(self: SPI, buffer: []u8, bit_mode: BitMode) void {
        const regs = self.get_regs();

        regs.USER.modify(.{
            .DOUTDIN = 0,
            .SIO = @intFromBool(bit_mode == .single_one_wire),
        });

        self.set_bit_mode(bit_mode);

        regs.USER.modify(.{
            .USR_COMMAND = 0,
            .USR_ADDR = 0,
            .USR_DUMMY = 0,
            .USR_MOSI = 0,
            .USR_MISO = 1,
        });

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        regs.DMA_CONF.modify(.{
            .RX_AFIFO_RST = 1,
            .BUF_AFIFO_RST = 1,
            .DMA_AFIFO_RST = 1,
        });

        const buf: *volatile [16]u32 = @ptrCast(&regs.W0);
        const transfer_size = @min(buffer.len, @sizeOf(u32) * buf.len);

        regs.MS_DLEN.write(.{
            .MS_DATA_BITLEN = @intCast(8 * transfer_size - 1),
        });

        regs.CMD.modify(.{
            .UPDATE = 1,
        });

        while (regs.CMD.read().UPDATE == 1) {}

        regs.CMD.modify(.{
            .USR = 1,
        });

        while (regs.DMA_INT_RAW.read().TRANS_DONE_INT_RAW != 1) {}

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        {
            var i: usize = 0;
            while (i < transfer_size) : (i += 1) {
                const shift: u5 = @intCast((i & 0x3) << 3);
                buffer[i] = @intCast((buf[i / 4] >> shift) & 0xff);
            }
        }
    }
    pub const BitOrder = enum(u1) {
        msb_first = 0,
        lsb_first = 1,
    };

    fn set_bit_order(self: SPI, bit_order: BitOrder) void {
        self.get_regs().CTRL.modify(.{
            .RD_BIT_ORDER = @intFromEnum(bit_order),
            .WR_BIT_ORDER = @intFromEnum(bit_order),
        });
    }

    pub const Mode = union(enum) {
        full_duplex,
        half_duplex: struct {
            bit_mode: BitMode,
        },
    };

    pub const BitMode = enum {
        single_one_wire,
        single_two_wires,
        dual,
        quad,
    };

    fn set_bit_mode(self: SPI, bit_mode: BitMode) void {
        const regs = self.get_regs();

        regs.CTRL.modify(.{
            .FCMD_DUAL = @intFromBool(bit_mode == .dual),
            .FCMD_QUAD = @intFromBool(bit_mode == .quad),
            .FADDR_DUAL = @intFromBool(bit_mode == .dual),
            .FADDR_QUAD = @intFromBool(bit_mode == .quad),
            .FREAD_DUAL = @intFromBool(bit_mode == .dual),
            .FREAD_QUAD = @intFromBool(bit_mode == .quad),
        });

        regs.USER.modify(.{
            .FWRITE_DUAL = @intFromBool(bit_mode == .dual),
            .FWRITE_QUAD = @intFromBool(bit_mode == .quad),
        });
    }

    fn do_transfer_generic(
        self: SPI,
        command: anytype,
        addr: anytype,
        dummy_len: u8,
        write: bool,
        read: bool,
        data_len: u18,
        bit_mode: BitMode,
    ) void {
        const command_len: u16 = comptime cmd_check: switch (@typeInfo(@TypeOf(command))) {
            .null => |_| {
                break :cmd_check 0;
            },
            .int => |int| {
                if (int.bits == 0 or int.bits > 4 or int.signedness != .unsigned) {
                    // basically continue right into error
                    continue :cmd_check .void;
                }
                break :cmd_check int.bits;
            },
            else => @compileError("command must be an int that has a bit max size of 4"),
        };

        const addr_len: u16 = comptime addr_check: switch (@typeInfo(@TypeOf(addr))) {
            .null => |_| {
                break :addr_check false;
            },
            .int => |int| {
                if (int.bits == 0 or int.bits > 5 or int.signedness != .unsigned) {
                    // basically continue right into error
                    continue :addr_check .void;
                }
                break :addr_check int.bits;
            },
            else => @compileError("address must be an int that has a bit max size of 5"),
        };

        const regs = self.get_regs();

        regs.USER.modify(.{
            .DOUTDIN = @intFromBool(write and read),
            .SIO = @intFromBool(bit_mode == .single_one_wire),

            .USR_COMMAND = @intFromBool(command_len != 0),
            .USR_ADDR = @intFromBool(addr_len != 0),
            .USR_DUMMY = @intFromBool(dummy_len != 0),
            .USR_MOSI = @intFromBool(write),
            .USR_MISO = @intFromBool(read),
        });

        regs.USER1.modify(.{
            .USR_DUMMY_CYCLELEN = if (dummy_len != 0) dummy_len - 1 else 0,
            .USR_ADDR_BITLEN = if (addr_len != 0) addr_len - 1 else 0,
        });

        regs.ADDR.modify(.{
            .USR_ADDR_VALUE = if (addr_len != 0) addr else 0,
        });

        regs.USER2.modify(.{
            .USR_COMMAND_BITLEN = if (command_len != 0) command_len - 1 else 0,
            .USR_COMMAND_VALUE = if (command_len != 0) command else 0,
        });

        regs.MS_DLEN.write(.{
            .MS_DATA_BITLEN = @intCast(data_len - 1),
        });

        self.set_bit_mode(bit_mode);

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });

        regs.DMA_CONF.modify(.{
            .RX_AFIFO_RST = 1,
            .BUF_AFIFO_RST = 1,
            .DMA_AFIFO_RST = 1,
        });

        regs.CMD.modify(.{
            .UPDATE = 1,
        });

        while (regs.CMD.read().UPDATE == 1) {}

        regs.CMD.modify(.{
            .USR = 1,
        });

        while (regs.DMA_INT_RAW.read().TRANS_DONE_INT_RAW != 1) {}

        regs.DMA_INT_CLR.modify(.{
            .TRANS_DONE_INT_CLR = 1,
        });
    }

    fn write_spi_buffer(spi_buffer: []const u8, write_buffer: []const u8, transfer_len: u18) void {
        var i: usize = 0;
        var word: u32 = 0;
        while (i < transfer_len) : (i += 1) {
            const shift: u5 = @intCast((i & 0x3) << 3);
            word |= @as(u32, write_buffer[i]) << shift;

            if ((i + 1) % 4 == 0) {
                spi_buffer[i / 4] = word;
                word = 0;
            }
        }

        if (i % 4 != 0) {
            spi_buffer[i / 4] = word;
        }
    }

    fn read_spi_buffer(spi_buffer: []const u8, write_buffer: []const u8, transfer_len: u18) []u8 {
        var i: usize = 0;
        while (i < transfer_len) : (i += 1) {
            const shift: u5 = @intCast((i & 0x3) << 3);
            write_buffer[i] = @intCast((spi_buffer[i / 4] >> shift) & 0xff);
        }
    }

    fn get_spi_buffer(self: SPI) *volatile [16]u32 {
        return @ptrCast(&self.get_regs().W0);
    }
};
