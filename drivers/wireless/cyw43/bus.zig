const std = @import("std");
const mdf = @import("../../framework.zig");
const consts = @import("consts.zig");
const DigitalIO = mdf.base.Digital_IO;

/// Callback for microsecond delays
pub const delayus_callback = fn (delay: u32) void;

/// SPI interface for CYW43
pub const Cyw43_Spi = struct {
    const Self = @This();
    ptr: *anyopaque,
    vtable: *const VTable,

    /// Reads data from SPI into `buffer` using `cmd`
    pub fn spi_read_blocking(self: *Self, cmd: u32, buffer: []u32) u32 {
        return self.vtable.spi_read_blocking_fn(self.ptr, cmd, buffer);
    }

    /// Writes `buffer` to SPI.
    pub fn spi_write_blocking(self: *Self, buffer: []const u32) u32 {
        return self.vtable.spi_write_blocking_fn(self.ptr, buffer);
    }

    pub const VTable = struct {
        spi_read_blocking_fn: *const fn (*anyopaque, cmd: u32, buffer: []u32) u32,
        spi_write_blocking_fn: *const fn (*anyopaque, buffer: []const u32) u32,
    };
};

/// CYW43 bus controller (SPI + power management)
pub const Cyw43_Bus = struct {
    const Self = @This();
    const log = std.log.scoped(.cyw43_bus);

    const TestPattern = 0x12345678;
    pwr_pin: DigitalIO,
    spi: *Cyw43_Spi,
    internal_delay_ms: *const delayus_callback,
    backplane_window: u32 = 0xAAAA_AAAA,

    pub fn init_bus(self: *Self) !void {
        // Init sequence
        try self.pwr_pin.write(.low);
        self.internal_delay_ms(50);
        try self.pwr_pin.write(.high);
        self.internal_delay_ms(250);

        log.debug("read REG_BUS_TEST_RO", .{});
        while (true) {
            const first_ro_test = self.read32_swapped(.bus, consts.REG_BUS_TEST_RO);
            log.debug("0x{X}", .{first_ro_test});
            if (first_ro_test == consts.FEEDBEAD)
                break;
        }

        log.debug("write REG_BUS_TEST_RW", .{});
        self.write32_swapped(.bus, consts.REG_BUS_TEST_RW, consts.TEST_PATTERN);
        const first_rw_test = self.read32_swapped(.bus, consts.REG_BUS_TEST_RW);
        log.debug("0x{X}", .{first_rw_test});
        std.debug.assert(first_rw_test == consts.TEST_PATTERN);

        log.debug("read REG_BUS_CTRL", .{});
        const ctrl_reg_val = self.read32_swapped(.bus, consts.REG_BUS_CTRL);
        log.debug("0b{b}", .{@as(u8, @truncate(ctrl_reg_val))});

        // Set 32-bit word length and keep default endianness: little endian
        const setup_regs = Cyw43FirstFourRegs{
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

        log.debug("write REG_BUS_CTRL", .{});
        self.write32_swapped(.bus, consts.REG_BUS_CTRL, @bitCast(setup_regs));

        log.debug("read REG_BUS_TEST_RO", .{});
        const second_ro_test = self.read32(.bus, consts.REG_BUS_TEST_RO);
        log.debug("0x{X}", .{second_ro_test});
        std.debug.assert(second_ro_test == consts.FEEDBEAD);

        log.debug("read REG_BUS_TEST_RW", .{});
        const second_rw_test = self.read32(.bus, consts.REG_BUS_TEST_RW);
        log.debug("0x{X}", .{second_rw_test});
        std.debug.assert(second_rw_test == consts.TEST_PATTERN);

        log.debug("write SPI_RESP_DELAY_F1 CYW43_BACKPLANE_READ_PAD_LEN_BYTES", .{});
        self.write8(.bus, consts.SPI_RESP_DELAY_F1, consts.WHD_BUS_SPI_BACKPLANE_READ_PADD_SIZE);

        // TODO: Make sure error interrupt bits are clear?
        // cyw43_write_reg_u8(self, BUS_FUNCTION, SPI_INTERRUPT_REGISTER, DATA_UNAVAILABLE | COMMAND_ERROR | DATA_ERROR | F1_OVERFLOW) != 0)
        log.debug("Make sure error interrupt bits are clear", .{});
        self.write8(.bus, consts.REG_BUS_INTERRUPT, (consts.IRQ_DATA_UNAVAILABLE | consts.IRQ_COMMAND_ERROR | consts.IRQ_DATA_ERROR | consts.IRQ_F1_OVERFLOW));

        // Enable a selection of interrupts
        // TODO: why not all of these F2_F3_FIFO_RD_UNDERFLOW | F2_F3_FIFO_WR_OVERFLOW | COMMAND_ERROR | DATA_ERROR | F2_PACKET_AVAILABLE | F1_OVERFLOW | F1_INTR
        log.debug("enable a selection of interrupts", .{});

        const val: u16 = consts.IRQ_F2_F3_FIFO_RD_UNDERFLOW |
            consts.IRQ_F2_F3_FIFO_WR_OVERFLOW |
            consts.IRQ_COMMAND_ERROR |
            consts.IRQ_DATA_ERROR |
            consts.IRQ_F2_PACKET_AVAILABLE |
            consts.IRQ_F1_OVERFLOW;

        //if bluetooth_enabled {
        //    val = val | IRQ_F1_INTR;
        //}

        self.write16(.bus, consts.REG_BUS_INTERRUPT_ENABLE, val);
    }

    pub inline fn read8(self: *Self, func: FuncType, addr: u17) u8 {
        return @truncate(self.readn(func, addr, 1));
    }

    pub inline fn read16(self: *Self, func: FuncType, addr: u17) u16 {
        return @truncate(self.readn(func, addr, 2));
    }

    pub inline fn read32(self: *Self, func: FuncType, addr: u17) u32 {
        return self.readn(func, addr, 4);
    }

    fn readn(self: *Self, func: FuncType, addr: u17, len: u11) u32 {
        const cmd = Cyw43Cmd{ .cmd = .read, .incr = .incremental, .func = func, .addr = addr, .len = len };
        var buff = [_]u32{0} ** 2;
        // if we are reading from the backplane, we need an extra word for the response delay
        const buff_len: usize = if (func == .backplane) 2 else 1;

        _ = self.spi.spi_read_blocking(@bitCast(cmd), buff[0..buff_len]);

        return if (func == .backplane) buff[1] else buff[0];
    }

    pub inline fn write8(self: *Self, func: FuncType, addr: u17, value: u8) void {
        return self.writen(func, addr, value, 1);
    }

    pub inline fn write16(self: *Self, func: FuncType, addr: u17, value: u16) void {
        return self.writen(func, addr, value, 2);
    }

    pub inline fn write32(self: *Self, func: FuncType, addr: u17, value: u32) void {
        return self.writen(func, addr, value, 4);
    }

    fn writen(self: *Self, func: FuncType, addr: u17, value: u32, len: u11) void {
        const cmd = Cyw43Cmd{ .cmd = .write, .incr = .incremental, .func = func, .addr = addr, .len = len };

        _ = self.spi.spi_write_blocking(&[_]u32{ @bitCast(cmd), value });
    }

    pub fn bp_read(self: *Self, addr: u32, data: []u8) void {
        log.debug("bp_read addr = 0x{X}", .{addr});

        // It seems the HW force-aligns the addr
        // to 2 if data.len() >= 2
        // to 4 if data.len() >= 4
        // To simplify, enforce 4-align for now.
        // TODO: fails with (cyw43_bus): bp_read addr = 0x17E7E
        // std.debug.assert(addr % 4 == 0);

        var buf: [consts.BACKPLANE_MAX_TRANSFER_SIZE / 4 + 1]u32 = undefined;

        var current_addr = addr;
        var remaining_data = data;

        while (remaining_data.len > 0) {
            const window_offs = current_addr & consts.BACKPLANE_ADDRESS_MASK;
            const window_remaining = consts.BACKPLANE_WINDOW_SIZE - @as(usize, @intCast(window_offs));

            const len: usize = @min(remaining_data.len, consts.BACKPLANE_MAX_TRANSFER_SIZE, window_remaining);

            self.backplane_set_window(current_addr);

            const cmd = Cyw43Cmd{ .cmd = .read, .incr = .incremental, .func = .backplane, .addr = @truncate(window_offs), .len = @truncate(len) };

            // round `buf` to word boundary, add one extra word for the response delay
            const words_to_send = (len + 3) / 4 + 1;
            _ = self.spi.spi_read_blocking(@bitCast(cmd), buf[0..words_to_send]);

            const u32_data_slice = buf[1..];
            var u8_buf_view = std.mem.sliceAsBytes(u32_data_slice);

            @memcpy(remaining_data[0..len], u8_buf_view[0..len]);

            current_addr += @as(u32, @intCast(len));
            remaining_data = remaining_data[len..];
        }
    }

    pub inline fn bp_read8(self: *Self, addr: u32) u8 {
        return @truncate(self.backplane_readn(addr, 1));
    }

    pub inline fn bp_read16(self: *Self, addr: u32) u16 {
        return @truncate(self.backplane_readn(addr, 2));
    }

    pub inline fn bp_read32(self: *Self, addr: u32) u32 {
        return @truncate(self.backplane_readn(addr, 4));
    }

    pub fn backplane_readn(self: *Self, addr: u32, len: u11) u32 {
        log.debug("backplane_readn addr = 0x{X} len = {}", .{ addr, len });

        self.backplane_set_window(addr);

        var bus_addr = addr & consts.BACKPLANE_ADDRESS_MASK;
        if (len == 4) {
            bus_addr |= consts.BACKPLANE_ADDRESS_32BIT_FLAG;
        }

        const val = self.readn(.backplane, @truncate(bus_addr), len);

        log.debug("backplane_readn addr = 0x{X} len = {} val = 0x{X}", .{ addr, len, val });

        return val;
    }

    pub fn bp_write(self: *Self, addr: u32, data: []const u8) void {
        log.debug("bp_write addr = 0x{X} len = {}", .{ addr, data.len });

        // It seems the HW force-aligns the addr
        // to 2 if data.len() >= 2
        // to 4 if data.len() >= 4
        // To simplify, enforce 4-align for now.
        std.debug.assert(addr % 4 == 0);

        var buf: [consts.BACKPLANE_MAX_TRANSFER_SIZE / 4 + 1]u32 = undefined;

        var current_addr = addr;
        var remaining_data = data;

        while (remaining_data.len > 0) {
            const window_offs = current_addr & consts.BACKPLANE_ADDRESS_MASK;
            const window_remaining = consts.BACKPLANE_WINDOW_SIZE - @as(usize, @intCast(window_offs));

            const len: usize = @min(remaining_data.len, consts.BACKPLANE_MAX_TRANSFER_SIZE, window_remaining);

            const u32_data_slice = buf[1..];
            var u8_buf_view = std.mem.sliceAsBytes(u32_data_slice);

            @memcpy(u8_buf_view[0..len], remaining_data[0..len]);

            self.backplane_set_window(current_addr);

            const cmd = Cyw43Cmd{ .cmd = .write, .incr = .incremental, .func = .backplane, .addr = @truncate(window_offs), .len = @truncate(len) };
            buf[0] = @bitCast(cmd);

            const words_to_send = (len + 3) / 4 + 1;
            _ = self.spi.spi_write_blocking(buf[0..words_to_send]);

            current_addr += @as(u32, @intCast(len));
            remaining_data = remaining_data[len..];
        }
    }

    pub inline fn bp_write8(self: *Self, addr: u32, value: u8) void {
        self.backplane_writen(addr, value, 1);
    }

    pub inline fn bp_write16(self: *Self, addr: u32, value: u16) void {
        self.backplane_writen(addr, value, 2);
    }

    pub inline fn bp_write32(self: *Self, addr: u32, value: u32) void {
        self.backplane_writen(addr, value, 4);
    }

    pub fn backplane_writen(self: *Self, addr: u32, value: u32, len: u11) void {
        log.debug("backplane_writen addr = 0x{X} len = {} val = 0x{X}", .{ addr, len, value });

        self.backplane_set_window(addr);

        var bus_addr = addr & consts.BACKPLANE_ADDRESS_MASK;
        if (len == 4) {
            bus_addr |= consts.BACKPLANE_ADDRESS_32BIT_FLAG;
        }

        self.writen(.backplane, @truncate(bus_addr), value, len);
    }

    fn backplane_set_window(self: *Self, addr: u32) void {
        const new_window = addr & ~consts.BACKPLANE_ADDRESS_MASK;

        if (@as(u8, @truncate(new_window >> 24)) != @as(u8, @truncate(self.backplane_window >> 24))) {
            self.write8(.backplane, consts.REG_BACKPLANE_BACKPLANE_ADDRESS_HIGH, @as(u8, @truncate(new_window >> 24)));
        }
        if (@as(u8, @truncate(new_window >> 16)) != @as(u8, @truncate(self.backplane_window >> 16))) {
            self.write8(.backplane, consts.REG_BACKPLANE_BACKPLANE_ADDRESS_MID, @as(u8, @truncate(new_window >> 16)));
        }
        if (@as(u8, @truncate(new_window >> 8)) != @as(u8, @truncate(self.backplane_window >> 8))) {
            self.write8(.backplane, consts.REG_BACKPLANE_BACKPLANE_ADDRESS_LOW, @as(u8, @truncate(new_window >> 8)));
        }

        self.backplane_window = new_window;
    }

    fn read32_swapped(self: *Self, func: FuncType, addr: u17) u32 {
        const cmd = Cyw43Cmd{ .cmd = .read, .incr = .incremental, .func = func, .addr = addr, .len = 4 };
        const cmd_swapped = swap16(@bitCast(cmd));

        var buff = [1]u32{0};
        _ = self.spi.spi_read_blocking(cmd_swapped, &buff);

        return swap16(buff[0]);
    }

    fn write32_swapped(self: *Self, func: FuncType, addr: u17, value: u32) void {
        const cmd = Cyw43Cmd{ .cmd = .write, .incr = .incremental, .func = func, .addr = addr, .len = 4 };

        var buff: [2]u32 = .{ swap16(@bitCast(cmd)), swap16(value) };
        _ = self.spi.spi_write_blocking(&buff);
    }

    inline fn swap16(x: u32) u32 {
        return x << 16 | x >> 16;
    }
};

const CmdType = enum(u1) {
    read = 0,
    write = 1,
};

const IncrMode = enum(u1) {
    fixed = 0, // Fixed address (no increment)
    incremental = 1, // Incremental burst
};

const FuncType = enum(u2) { bus = 0, backplane = 1, wlan = 2, bt = 3 };

const Cyw43Cmd = packed struct(u32) {
    len: u11,
    addr: u17,
    func: FuncType = .bus,
    incr: IncrMode = .fixed,
    cmd: CmdType,
};

const CtrlWordLength = enum(u1) { word_16 = 0, word_32 = 1 };

const CtrlEndianness = enum(u1) { little_endian = 0, big_endian = 1 };

const CtrlSpeedMode = enum(u1) { normal = 0, high_speed = 1 };

const CtrlInterruptPolarity = enum(u1) { low_polarity = 0, high_polarity = 1 };

const CtrlReg = packed struct(u8) {
    word_length: CtrlWordLength,
    endianness: CtrlEndianness,
    reserved1: u2 = 0,
    speed_mode: CtrlSpeedMode,
    interrupt_polarity: CtrlInterruptPolarity,
    reserved3: u1 = 0,
    wake_up: bool,
};

const ResponseDelay = packed struct(u8) {
    unknown: u8,
};

const StatusEnableReg = packed struct(u8) {
    status_enable: bool,
    interrupt_with_status: bool,
    reserved1: u6 = 0,
};

const Cyw43FirstFourRegs = packed struct(u32) {
    ctrl: CtrlReg,
    response_delay: ResponseDelay,
    status_enable: StatusEnableReg,
    reserved1: u8 = 0,
};
