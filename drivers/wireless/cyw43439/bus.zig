/// CYW43 bus controller (SPI + power management)
///
const std = @import("std");
const assert = std.debug.assert;

const log = std.log.scoped(.cyw43_bus);

pub const Spi = struct {
    ptr: *anyopaque,
    vtable: *const VTable,

    /// Reads data from SPI into buffer, first word in buffer is command
    pub fn read(self: *@This(), buffer: []u32) void {
        return self.vtable.read(self.ptr, buffer);
    }

    /// Writes buffer to SPI, first word in buffer is command
    pub fn write(self: *@This(), buffer: []u32) void {
        self.vtable.write(self.ptr, buffer);
    }

    pub const VTable = struct {
        read: *const fn (*anyopaque, []u32) void,
        write: *const fn (*anyopaque, []u32) void,
    };
};

const Self = @This();

spi: Spi,
sleep_ms: *const fn (delay: u32) void,
backplane_window: u32 = 0xAAAA_AAAA,

pub fn init(self: *Self) !void {
    // First read of read only test register
    out: {
        var val: u32 = 0;
        for (0..8) |_| {
            val = self.read_swapped(.bus, reg.test_read_only);
            if (val == reg.test_read_only_content)
                break :out;
            self.sleep_ms(2);
        }
        log.err("ro register first read unexpected value: {x}", .{val});
        return error.Cyw43RoTestReadFailed;
    }

    const test_rw_value: u32 = 0x12345678;
    // First write/read of read/write test register
    {
        self.write_swapped(.bus, reg.test_read_write, test_rw_value);
        const val = self.read_swapped(.bus, reg.test_read_write);
        if (val != test_rw_value) {
            log.err("rw register first read unexpected value: {x}", .{val});
            return error.Cyw43RwTestReadFailed;
        }
    }
    // Write setup registers
    {
        _ = self.read_swapped(.bus, reg.control);
        // Set 32-bit word length and keep default endianness: little endian
        const setup_regs = SetupRegs{
            .control = .{
                .word_length = .word_32,
                .endianness = .little,
                .speed_mode = .high,
                .interrupt_polarity = .high,
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
        self.write_swapped(.bus, reg.control, @bitCast(setup_regs));
    }
    // Second read of ro and rw registers
    {
        const ro_val = self.read_int(u32, .bus, reg.test_read_only);
        if (ro_val != reg.test_read_only_content) {
            log.err("ro register second read unexpected value: {x}", .{ro_val});
            return error.Cyw43SecondTestReadFailed;
        }

        const rw_val = self.read_int(u32, .bus, reg.test_read_write);
        if (rw_val != test_rw_value) {
            log.err("rw register second read unexpected value: {x}", .{rw_val});
            return error.Cyw43SecondTestReadFailed;
        }
    }
    // Set interrupts
    {
        // Clear error interrupt bits
        self.write_int(u16, .bus, reg.interrupt, @bitCast(Irq.clear));
        // Enable a selection of interrupts
        self.write_int(u16, .bus, reg.interrupt_enable, @bitCast(Irq{
            .f2_f3_fifo_rd_underflow = true,
            .f2_f3_fifo_wr_overflow = true,
            .command_error = true,
            .data_error = true,
            .f2_packet_available = true,
            .f1_overflow = true,
        }));
    }
    { // bluetooth... TODO
        self.write_int(u8, .bus, bt.spi_resp_delay_f1, bt.whd_bus_spi_backplane_read_padd_size);
    }
}

pub fn read_int(self: *Self, T: type, func: Cmd.Func, waddr: u32) T {
    const addr: u17 = if (func == .backplane and waddr > backplane.sleep_csr)
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
    const addr: u17 = if (func == .backplane and waddr > backplane.sleep_csr)
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

    var words: [backplane.max_transfer_size / 4 + 2]u32 = undefined;
    var current_addr = addr;
    var remaining_data = data;

    while (remaining_data.len > 0) {
        const window_offs = current_addr & backplane.address_mask;
        const window_remaining = backplane.window_size - @as(usize, @intCast(window_offs));
        const len: usize = @min(remaining_data.len, backplane.max_transfer_size, window_remaining);

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
    var words: [backplane.max_transfer_size / 4 + 1]u32 = undefined;

    var current_addr = addr;
    var remaining = data;
    while (remaining.len > 0) {
        const window_offset = current_addr & backplane.address_mask;
        const window_remaining = backplane.window_size - @as(usize, @intCast(window_offset));
        const len: usize = @min(remaining.len, backplane.max_transfer_size, window_remaining);
        const wlen = (len + 3) >> 2; // len in words

        // copy to words buffer
        @memcpy(std.mem.sliceAsBytes(words[1..])[0..len], remaining[0..len]);
        // write
        self.backplane_set_window(current_addr);
        self.write(.backplane, @truncate(window_offset), @intCast(len), words[0 .. wlen + 1]);

        current_addr += @as(u32, @intCast(len));
        remaining = remaining[len..];
    }
}

fn backplane_window_addr(self: *Self, addr: u32, len: u11) u17 {
    self.backplane_set_window(addr);
    var bus_addr = addr & backplane.address_mask;
    if (len == 4) {
        bus_addr |= backplane.address_32bit_flag;
    }
    return @truncate(bus_addr);
}

fn backplane_set_window(self: *Self, addr: u32) void {
    const new_window = addr & ~backplane.address_mask;

    if (@as(u8, @truncate(new_window >> 24)) != @as(u8, @truncate(self.backplane_window >> 24))) {
        self.write_int(u8, .backplane, backplane.address_high, @as(u8, @truncate(new_window >> 24)));
    }
    if (@as(u8, @truncate(new_window >> 16)) != @as(u8, @truncate(self.backplane_window >> 16))) {
        self.write_int(u8, .backplane, backplane.address_mid, @as(u8, @truncate(new_window >> 16)));
    }
    if (@as(u8, @truncate(new_window >> 8)) != @as(u8, @truncate(self.backplane_window >> 8))) {
        self.write_int(u8, .backplane, backplane.address_low, @as(u8, @truncate(new_window >> 8)));
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

const SetupRegs = packed struct(u32) {
    const Control = packed struct(u8) {
        const WordLength = enum(u1) {
            word_16 = 0,
            word_32 = 1,
        };

        const Endianness = enum(u1) {
            little = 0,
            big = 1,
        };

        const SpeedMode = enum(u1) {
            normal = 0,
            high = 1,
        };

        const InterruptPolarity = enum(u1) {
            low = 0,
            high = 1,
        };

        word_length: WordLength,
        endianness: Endianness,
        _reserved1: u2 = 0,
        speed_mode: SpeedMode,
        interrupt_polarity: InterruptPolarity,
        _reserved2: u1 = 0,
        wake_up: bool,
    };
    const ResponseDelay = packed struct(u8) {
        unknown: u8,
    };
    const StatusEnable = packed struct(u8) {
        status_enable: bool,
        interrupt_with_status: bool,
        _reserved1: u6 = 0,
    };

    control: Control,
    response_delay: ResponseDelay,
    status_enable: StatusEnable,
    _reserved1: u8 = 0,
};

// Register addresses
// reference datasheet page 22 'Table 6. gSPI Registers'
pub const reg = struct {
    const control: u32 = 0x0;
    const response_delay: u32 = 0x1;
    const status_enable: u32 = 0x2;

    pub const interrupt: u32 = 0x04; // 16 bits - Interrupt status
    pub const interrupt_enable: u32 = 0x06; // 16 bits - Interrupt mask
    pub const status: u32 = 0x8;

    // This register contains a predefined pattern, which the host can read to
    // determine if the gSPI interface is working properly.
    const test_read_only: u32 = 0x14;
    const test_read_only_content: u32 = 0xFEEDBEAD;
    // This is a dummy register where the host can write some pattern and read it
    // back to determine if the gSPI interface is working properly.
    const test_read_write: u32 = 0x18;
    //pub const RESP_DELAY: u32 = 0x1c;
};

// interrupt register and interrupt enable register bits
pub const Irq = packed struct {
    data_unavailable: bool = false, // Requested data not available; Clear by writing a "1"
    f2_f3_fifo_rd_underflow: bool = false,
    f2_f3_fifo_wr_overflow: bool = false,
    command_error: bool = false, // Cleared by writing 1
    data_error: bool = false, // Cleared by writing 1
    f2_packet_available: bool = false,
    f3_packet_available: bool = false,
    f1_overflow: bool = false, // Due to last write. Bkplane has pending write requests
    misc_intr0: bool = false,
    misc_intr1: bool = false,
    misc_intr2: bool = false,
    misc_intr3: bool = false,
    misc_intr4: bool = false,
    f1_intr: bool = false,
    f2_intr: bool = false,
    f3_intr: bool = false,

    const clear = Irq{
        .data_unavailable = true,
        .command_error = true,
        .data_error = true,
        .f1_overflow = true,
    };
};

pub const backplane = struct {
    const window_size: usize = 0x8000;
    const address_mask: u32 = 0x7FFF;
    const address_32bit_flag: u32 = 0x08000;
    const max_transfer_size: usize = 64;

    pub const function2_watermark: u32 = 0x10008;
    pub const address_low: u32 = 0x1000A;
    pub const address_mid: u32 = 0x1000B;
    pub const address_high: u32 = 0x1000C;
    pub const chip_clock_csr: u32 = 0x1000E;
    pub const pull_up: u32 = 0x1000F;
    pub const sleep_csr: u32 = 0x1001F;

    pub const alp_avail_req: u8 = 0x08;
    pub const alp_avail: u8 = 0x40;
};

// Bluetooth constants.
const bt = struct {
    const spi_resp_delay_f1: u32 = 0x001d;
    const whd_bus_spi_backplane_read_padd_size: u8 = 4;
};
