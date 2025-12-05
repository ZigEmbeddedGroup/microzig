const std = @import("std");
const assert = std.debug.assert;
const consts = @import("consts.zig");

const log = std.log.scoped(.cyw43_bus);

pub const SpiInterface = struct {
    const Self = @This();
    ptr: *anyopaque,
    vtable: *const VTable,

    /// Reads data from SPI into `buffer` using `cmd`
    pub fn read(self: *Self, words: []u32) void {
        return self.vtable.read(self.ptr, words);
    }

    /// Writes `buffer` to SPI.
    pub fn write(self: *Self, words: []u32) void {
        self.vtable.write(self.ptr, words);
    }

    pub const VTable = struct {
        read: *const fn (*anyopaque, []u32) void,
        write: *const fn (*anyopaque, []u32) void,
    };
};

/// CYW43 bus controller (SPI + power management)
pub const Bus = struct {
    const Self = @This();

    spi: SpiInterface,
    sleep_ms: *const fn (delay: u32) void,
    backplane_window: u32 = 0xAAAA_AAAA,

    pub fn init(self: *Self) !void {
        // First read of ro test register
        out: {
            var val: u32 = 0;
            for (0..8) |_| {
                val = self.read_swapped(.bus, consts.REG_BUS_TEST_RO);
                if (val == consts.FEEDBEAD)
                    break :out;
                self.sleep_ms(2);
            }
            log.err("ro register first read unexpected value: {x}", .{val});
            return error.Cyw43NotFound;
        }
        // First write/read of rw test register
        {
            self.write_swapped(.bus, consts.REG_BUS_TEST_RW, consts.TEST_PATTERN);
            const val = self.read_swapped(.bus, consts.REG_BUS_TEST_RW);
            if (val != consts.TEST_PATTERN) {
                log.err("rw register first read unexpected value: {x}", .{val});
                return error.Cyw43TestReadFailed;
            }
        }
        // Write setup registers
        {
            _ = self.read_swapped(.bus, consts.REG_BUS_CTRL);
            // Set 32-bit word length and keep default endianness: little endian
            const setup_regs = SetupRegs{
                .ctrl = .{
                    .word_length = .word_32,
                    .endianness = .little_endian,
                    .speed_mode = .high_speed,
                    .interrupt_polarity = .high_polarity,
                    .wake_up = true,
                },
                .response_delay = .{
                    .unknown = 0x4, // 32-bit response delay?
                },
                .status_enable = .{
                    .status_enable = true,
                    .interrupt_with_status = true,
                },
            };
            self.write_swapped(.bus, consts.REG_BUS_CTRL, @bitCast(setup_regs));
        }
        // Second read of ro and rw registers
        {
            const ro_val = self.read_int(u32, .bus, consts.REG_BUS_TEST_RO);
            if (ro_val != consts.FEEDBEAD) {
                log.err("ro register second read unexpected value: {x}", .{ro_val});
                return error.Cyw43SecondTestReadFailed;
            }

            const rw_val = self.read_int(u32, .bus, consts.REG_BUS_TEST_RW);
            if (rw_val != consts.TEST_PATTERN) {
                log.err("rw register second read unexpected value: {x}", .{rw_val});
                return error.Cyw43SecondTestReadFailed;
            }
        }
        { // bluetooth... TODO
            self.write_int(u8, .bus, consts.SPI_RESP_DELAY_F1, consts.WHD_BUS_SPI_BACKPLANE_READ_PADD_SIZE);
        }
        // Set interrupts
        {
            // Clear error interrupt bits
            self.write_int(u8, .bus, consts.REG_BUS_INTERRUPT, consts.IRQ_CLEAR);
            // Enable a selection of interrupts
            const val: u16 = consts.IRQ_F2_F3_FIFO_RD_UNDERFLOW |
                consts.IRQ_F2_F3_FIFO_WR_OVERFLOW |
                consts.IRQ_COMMAND_ERROR |
                consts.IRQ_DATA_ERROR |
                consts.IRQ_F2_PACKET_AVAILABLE |
                consts.IRQ_F1_OVERFLOW;
            self.write_int(u16, .bus, consts.REG_BUS_INTERRUPT_ENABLE, val);
        }
    }

    pub fn read_int(self: *Self, T: type, func: Cmd.Func, waddr: u32) T {
        const addr: u17 = if (func == .backplane and waddr > consts.REG_BACKPLANE_SLEEP_CSR)
            self.backplane_window_addr(waddr, @sizeOf(T))
        else
            @intCast(waddr);

        var buf: [3]u32 = @splat(0);
        // When making a ‘backplane’ read, the first 4 return bytes are
        // discarded; they are padding to give the remote peripheral time to
        // respond. Last word is status.
        const buf_len: usize = if (func == .backplane) 3 else 2;
        self.read(func, addr, @sizeOf(T), buf[0..buf_len]);
        return @truncate(if (func == .backplane) buf[1] else buf[0]);
    }

    // len - number of bytes to read
    // buffer must have one word for status at the end
    pub fn read(self: *Self, func: Cmd.Func, addr: u17, len: u11, buf: []u32) void {
        assert(@divFloor(len + 3, 4) < buf.len);
        const cmd = Cmd{ .kind = .read, .func = func, .addr = addr, .len = len };
        buf[0] = @bitCast(cmd);
        self.spi.read(buf);
    }

    pub fn write_int(self: *Self, T: type, func: Cmd.Func, waddr: u32, value: T) void {
        const addr: u17 = if (func == .backplane and waddr > consts.REG_BACKPLANE_SLEEP_CSR)
            self.backplane_window_addr(waddr, @sizeOf(T))
        else
            @intCast(waddr);
        var buf: [2]u32 = @splat(0);
        buf[1] = @intCast(value);
        self.write(func, addr, @sizeOf(T), &buf);
    }

    pub fn write(self: *Self, func: Cmd.Func, addr: u17, len: u11, buf: []u32) void {
        const cmd = Cmd{ .kind = .write, .func = func, .addr = addr, .len = len };
        buf[0] = @bitCast(cmd);
        self.spi.write(buf);
        // status is in the first word of buf
    }

    pub fn backplane_read(self: *Self, addr: u32, data: []u8) void {
        //log.debug("bp_read addr = 0x{X} len = {}", .{ addr, data.len });
        // It seems the HW force-aligns the addr
        // to 2 if data.len() >= 2
        // to 4 if data.len() >= 4
        // To simplify, enforce 4-align for now.
        // TODO: fails with (cyw43_bus): bp_read addr = 0x17E7E
        // std.debug.assert(addr % 4 == 0);

        var words: [consts.BACKPLANE_MAX_TRANSFER_SIZE / 4 + 2]u32 = undefined;
        var current_addr = addr;
        var remaining_data = data;

        while (remaining_data.len > 0) {
            const window_offs = current_addr & consts.BACKPLANE_ADDRESS_MASK;
            const window_remaining = consts.BACKPLANE_WINDOW_SIZE - @as(usize, @intCast(window_offs));
            const len: usize = @min(remaining_data.len, consts.BACKPLANE_MAX_TRANSFER_SIZE, window_remaining);

            self.backplane_set_window(current_addr);

            const cmd = Cmd{
                .kind = .read,
                .func = .backplane,
                .addr = @truncate(window_offs),
                .len = @truncate(len),
            };
            // round `buf` to word boundary
            // add one extra word for the response delay (at the start)
            // and one word for status (at the end)
            const wlen = 1 + ((len + 3) >> 2) + 1;
            words[0] = @bitCast(cmd);
            _ = self.spi.read(words[0..wlen]);

            var buf = std.mem.sliceAsBytes(words[1 .. wlen - 1]);
            @memcpy(remaining_data[0..len], buf[0..len]);

            current_addr += @as(u32, @intCast(len));
            remaining_data = remaining_data[len..];
        }
    }

    pub fn backplane_write(self: *Self, addr: u32, data: []const u8) void {
        //log.debug("bp_write addr = 0x{X} len = {}", .{ addr, data.len });

        // It seems the HW force-aligns the addr
        // to 2 if data.len() >= 2
        // to 4 if data.len() >= 4
        // To simplify, enforce 4-align for now.
        std.debug.assert(addr % 4 == 0);

        // write buffer in words, 1 word at the start for the bus cmd
        var words: [consts.BACKPLANE_MAX_TRANSFER_SIZE / 4 + 1]u32 = undefined;

        var current_addr = addr;
        var remaining = data;
        while (remaining.len > 0) {
            const window_offset = current_addr & consts.BACKPLANE_ADDRESS_MASK;
            const window_remaining = consts.BACKPLANE_WINDOW_SIZE - @as(usize, @intCast(window_offset));
            const len: usize = @min(remaining.len, consts.BACKPLANE_MAX_TRANSFER_SIZE, window_remaining);
            const wlen = (len + 3) >> 2; // len in words

            // copy to words buffer
            @memcpy(std.mem.sliceAsBytes(words[1..])[0..len], remaining[0..len]);
            // write
            self.backplane_set_window(current_addr);
            // const cmd = Cmd{
            //     .kind = .write,
            //     .func = .backplane,
            //     .addr = @truncate(window_offset),
            //     .len = @truncate(len),
            // };
            self.write(.backplane, @truncate(window_offset), @intCast(len), words[0 .. wlen + 1]);

            //_ = self.spi.write(@bitCast(cmd), &.{words[0..wlen]});

            current_addr += @as(u32, @intCast(len));
            remaining = remaining[len..];
        }
    }

    fn backplane_window_addr(self: *Self, addr: u32, len: u11) u17 {
        self.backplane_set_window(addr);
        var bus_addr = addr & consts.BACKPLANE_ADDRESS_MASK;
        if (len == 4) {
            bus_addr |= consts.BACKPLANE_ADDRESS_32BIT_FLAG;
        }
        return @truncate(bus_addr);
    }

    fn backplane_set_window(self: *Self, addr: u32) void {
        const new_window = addr & ~consts.BACKPLANE_ADDRESS_MASK;

        if (@as(u8, @truncate(new_window >> 24)) != @as(u8, @truncate(self.backplane_window >> 24))) {
            self.write_int(u8, .backplane, consts.REG_BACKPLANE_BACKPLANE_ADDRESS_HIGH, @as(u8, @truncate(new_window >> 24)));
        }
        if (@as(u8, @truncate(new_window >> 16)) != @as(u8, @truncate(self.backplane_window >> 16))) {
            self.write_int(u8, .backplane, consts.REG_BACKPLANE_BACKPLANE_ADDRESS_MID, @as(u8, @truncate(new_window >> 16)));
        }
        if (@as(u8, @truncate(new_window >> 8)) != @as(u8, @truncate(self.backplane_window >> 8))) {
            self.write_int(u8, .backplane, consts.REG_BACKPLANE_BACKPLANE_ADDRESS_LOW, @as(u8, @truncate(new_window >> 8)));
        }

        self.backplane_window = new_window;
    }

    fn read_swapped(self: *Self, func: Cmd.Func, addr: u17) u32 {
        const cmd = Cmd{ .kind = .read, .func = func, .addr = addr, .len = 4 };
        var buf: [2]u32 = @splat(0); // second word is status
        buf[0] = swap16(@bitCast(cmd));
        self.spi.read(&buf);
        return swap16(buf[0]);
    }

    fn write_swapped(self: *Self, func: Cmd.Func, addr: u17, value: u32) void {
        const cmd = Cmd{ .kind = .write, .func = func, .addr = addr, .len = 4 };
        var buf: [2]u32 = @splat(0);
        buf[0] = swap16(@bitCast(cmd));
        buf[1] = swap16(value);
        self.spi.write(&buf);
    }

    inline fn swap16(x: u32) u32 {
        return x << 16 | x >> 16;
    }
};

// ref: datasheet page 19
const Cmd = packed struct(u32) {
    const Kind = enum(u1) {
        read = 0,
        write = 1,
    };

    const Access = enum(u1) {
        fixed = 0, //       Fixed address (no increment)
        incremental = 1, // Incremental burst
    };

    const Func = enum(u2) {
        bus = 0, //       Func 0: All SPI-specific registers
        backplane = 1, // Func 1: Registers and memories belonging to other blocks in the chip (64 bytes max)
        wlan = 2, //      Func 2: DMA channel 1. WLAN packets up to 2048 bytes.
        bt = 3, //        Func 3: DMA channel 2 (optional). Packets up to 2048 bytes.
    };

    len: u11, // Packet length, max 2048 bytes
    addr: u17,
    func: Func = .bus,
    access: Access = .incremental,
    kind: Kind,
};

const CtrlReg = packed struct(u8) {
    const WordLength = enum(u1) {
        word_16 = 0,
        word_32 = 1,
    };

    const Endianness = enum(u1) {
        little_endian = 0,
        big_endian = 1,
    };

    const SpeedMode = enum(u1) {
        normal = 0,
        high_speed = 1,
    };

    const InterruptPolarity = enum(u1) {
        low_polarity = 0,
        high_polarity = 1,
    };

    word_length: WordLength,
    endianness: Endianness,
    reserved1: u2 = 0,
    speed_mode: SpeedMode,
    interrupt_polarity: InterruptPolarity,
    reserved3: u1 = 0,
    wake_up: bool,
};

const SetupRegs = packed struct(u32) {
    const ResponseDelay = packed struct(u8) {
        unknown: u8,
    };
    const StatusEnable = packed struct(u8) {
        status_enable: bool,
        interrupt_with_status: bool,
        reserved1: u6 = 0,
    };

    ctrl: CtrlReg,
    response_delay: ResponseDelay,
    status_enable: StatusEnable,
    reserved1: u8 = 0,
};
