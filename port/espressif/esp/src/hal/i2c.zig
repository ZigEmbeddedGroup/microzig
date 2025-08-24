const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const drivers = mdf.base;
const peripherals = microzig.chip.peripherals;
pub const I2C0 = peripherals.I2C0;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const time = @import("time.zig");

// TODO: How and why. Is this xtal? That clock is 40_000_000 according to the hal
const SOURCE_CLK_FREQ: u32 = 20_000_000;

pub const ConfigError = error{
    InvalidClkConfig,
    PeripheralDisabled,
};

pub const Address = drivers.I2C_Device.Address;
pub const AddressError = drivers.I2C_Device.Address.Error;
pub const Error = drivers.I2C_Device.Error || error{
    FifoExceeded,
    ArbitrationLost,
    ExecutionIncomplete,
    CommandNumberExceeded,
};

const Opcode = enum(u4) {
    RSTART = 6,
    WRITE = 1,
    READ = 3,
    STOP = 2,
    END = 4,
};

const Command = union(enum) {
    start,
    stop,
    end,
    write: struct {
        /// Expected ACK value for transmitter
        ack_exp: Ack,
        /// Enable ACK checking
        ack_check_en: bool,
        /// Data length in bytes (1-255)
        length: u8,
    },
    read: struct {
        /// ACK value to send after byte received
        ack_value: Ack,
        /// Data length in bytes (1-255)
        length: u8,
    },

    /// Convert command to register value
    pub fn to_value(self: Command) u14 {
        var cmd: u14 = 0;

        switch (self) {
            .start, .stop, .end => {
                cmd = 0;
            },
            .write => |write| {
                cmd = @as(u14, write.length);
            },
            .read => |read| {
                cmd = @as(u14, read.length);
            },
        }

        // Set opcode
        const opcode: Opcode = switch (self) {
            .start => .RSTART,
            .stop => .STOP,
            .end => .END,
            .write => .WRITE,
            .read => .READ,
        };
        cmd |= @as(u14, @intFromEnum(opcode)) << 11;

        // Set ack_check_en bit
        if (self == .write and self.write.ack_check_en) {
            cmd |= 1 << 8;
        }

        // Set ack_exp bit
        const ack_exp = if (self == .write) self.write.ack_exp else .nack;
        if (ack_exp == .nack) {
            cmd |= 1 << 9;
        }

        // Set ack_value bit
        const ack_value = if (self == .read) self.read.ack_value else .nack;
        if (ack_value == .nack) {
            cmd |= 1 << 10;
        }

        return cmd;
    }
};

const Ack = enum(u1) {
    ack = 0,
    nack = 1,
};

const OperationType = enum(u1) {
    write = 0,
    read = 1,
};

/// Pins used by the I2C interface
pub const Pins = struct {
    sda: gpio.Pin,
    scl: gpio.Pin,
};

pub const instance = struct {
    pub const I2C0: I2C = @as(I2C, @enumFromInt(0));
    pub fn num(n: u1) I2C {
        return @as(I2C, @enumFromInt(n));
    }
};

const I2cRegs = microzig.chip.types.peripherals.I2C0;

const I2C_FIFO_SIZE: usize = 32;
// Chunk writes/reads by this size
const I2C_CHUNK_SIZE: usize = I2C_FIFO_SIZE - 1;

/// I2C Master peripheral driver
pub const I2C = enum(u1) {
    _,

    inline fn get_regs(i2c: I2C) *volatile I2cRegs {
        _ = i2c;
        return I2C0;
    }

    pub fn apply(self: I2C, pins: Pins, frequency: u32) ConfigError!void {
        const regs = self.get_regs();

        // Enable I2C peripheral clock and take it out of reset
        microzig.hal.system.enable_clocks_and_release_reset(.{ .i2c_ext0 = true });

        // Setup SDA pin
        pins.sda.set_open_drain_output(true);
        pins.sda.set_input_enable(true);
        pins.sda.set_pullup(true);
        pins.sda.connect_peripheral_to_output(.i2cext0_sda);
        pins.sda.connect_input_to_peripheral(.i2cext0_sda);

        // Setup SCL pin
        pins.scl.set_open_drain_output(true);
        pins.scl.set_input_enable(true);
        pins.scl.set_pullup(true);
        pins.scl.connect_peripheral_to_output(.i2cext0_scl);
        pins.scl.connect_input_to_peripheral(.i2cext0_scl);

        // Reset entire peripheral (also resets fifo)
        self.reset();

        // Disable all I2C interrupts
        regs.INT_ENA.write_raw(0);

        // Clear all I2C interrupts
        self.clear_interrupts();

        // Configure controller
        regs.CTR.write_raw(0);
        regs.CTR.modify(.{
            .MS_MODE = 1, // Set I2C controller to master mode
            .SDA_FORCE_OUT = 1, // Use open drain output for SDA
            .SCL_FORCE_OUT = 1, // Use open drain output for SCL
            .TX_LSB_FIRST = 0, // MSB first for sending
            .RX_LSB_FIRST = 0, // MSB first for receiving
            .CLK_EN = 1, // Enable clock
        });

        // Configure filter
        self.set_filter(7, 7);

        // Configure frequency
        // TODO: Take timeout as extra arg and handle saturation?
        try self.set_frequency(SOURCE_CLK_FREQ, frequency);

        // Propagate configuration changes
        self.update_config();
    }

    /// Reset the I2C controller
    fn reset(self: I2C) void {
        // NOTE: This is done explicitly in apply after disabling all i2c interrupts
        // Clear all I2C interrupts
        // self.clear_interrupts();

        // Reset FIFO
        self.reset_fifo();

        // Reset command list
        self.reset_command_list();

        // Reset FSM
        self.get_regs().CTR.modify(.{ .FSM_RST = 1 });
    }

    /// Reset the FIFO buffers
    fn reset_fifo(self: I2C) void {
        self.get_regs().FIFO_CONF.modify(.{
            .TX_FIFO_RST = 1,
            .RX_FIFO_RST = 1,
            // Esp hal sets these here
            .NONFIFO_EN = 0,
            // Esp hal sets these, but why?
            .RXFIFO_WM_THRHD = 1,
            .TXFIFO_WM_THRHD = 31,
        });

        // Shouldn't be needed, it's clear on write
        self.get_regs().FIFO_CONF.modify(.{
            .TX_FIFO_RST = 0,
            .RX_FIFO_RST = 0,
        });

        // Make sure the FIFO operates in FIFO mode
        self.get_regs().FIFO_CONF.modify(.{
            .NONFIFO_EN = 0,
            .FIFO_PRT_EN = 0,
        });

        self.get_regs().INT_CLR.modify(.{
            .RXFIFO_WM_INT_CLR = 1,
            .TXFIFO_WM_INT_CLR = 1,
        });

        self.update_config();
    }

    /// Reset the command list
    fn reset_command_list(self: I2C) void {
        // Reset all command registers
        for (0..self.get_regs().COMD.len) |i|
            self.get_regs().COMD[@intCast(i)].write_raw(0);
    }

    /// Set the filter threshold in clock cycles
    fn set_filter(self: I2C, sda_threshold: ?u4, scl_threshold: ?u4) void {
        self.get_regs().FILTER_CFG.write(.{
            .SDA_FILTER_THRES = if (sda_threshold) |t| t else 0,
            .SDA_FILTER_EN = if (sda_threshold) |_| @as(u1, 1) else @as(u1, 0),
            .SCL_FILTER_THRES = if (scl_threshold) |t| t else 0,
            .SCL_FILTER_EN = if (scl_threshold) |_| @as(u1, 1) else @as(u1, 0),
        });
    }

    /// Sets the frequency of the I2C interface
    fn set_frequency(self: I2C, source_clk: u32, bus_freq: u32) !void {
        // Calculate dividing factor (maximum possible)
        const sclk_div: u32 = @intCast((source_clk / (bus_freq * 1024) + 1));
        if (sclk_div >= 256) {
            return ConfigError.InvalidClkConfig;
        }

        // Calculate half cycle
        const half_cycle: u32 = @intCast(source_clk / (bus_freq * @as(u32, sclk_div) * 2));
        if (half_cycle > std.math.maxInt(u9))
            return ConfigError.InvalidClkConfig;

        const scl_low: u9 = @intCast(half_cycle - 1);
        // NOTE: If we were not hardcoding the filter, we would have to conditionally set this based
        // on the filter value.
        const scl_high: u9 = @intCast(half_cycle - 1);
        const sda_hold: u9 = @intCast(half_cycle / 2);
        const sda_sample: u9 = @intCast(scl_high / 2);
        const setup: u9 = @intCast(half_cycle);
        const hold: u9 = @intCast(half_cycle);
        // Set timeout value to 10 bus cycles
        const timeout: u5 = 10;

        // Set clock divider
        self.get_regs().CLK_CONF.modify(.{
            .SCLK_SEL = 0,
            .SCLK_DIV_NUM = @as(u8, @truncate(sclk_div - 1)),
        });

        // Set SCL period
        self.get_regs().SCL_LOW_PERIOD.modify(.{ .SCL_LOW_PERIOD = scl_low });
        self.get_regs().SCL_HIGH_PERIOD.modify(.{ .SCL_HIGH_PERIOD = scl_high });

        // Set SDA sample and hold times
        self.get_regs().SDA_HOLD.write(.{ .TIME = sda_hold });
        self.get_regs().SDA_SAMPLE.write(.{ .TIME = sda_sample });

        // Set setup times
        self.get_regs().SCL_RSTART_SETUP.write(.{ .TIME = setup });
        self.get_regs().SCL_STOP_SETUP.write(.{ .TIME = setup });

        // Set hold times
        self.get_regs().SCL_START_HOLD.write(.{ .TIME = hold });
        self.get_regs().SCL_STOP_HOLD.write(.{ .TIME = hold });

        // Set timeout
        self.get_regs().TO.write(.{
            .TIME_OUT_VALUE = timeout,
            .TIME_OUT_EN = 1,
        });
    }

    fn check_errors(self: I2C) !void {
        // Reset the peripheral in case of error
        errdefer self.reset();

        const interrupts = self.get_regs().INT_RAW.read();
        if (interrupts.TIME_OUT_INT_RAW == 1) {
            return Error.Timeout;
        } else if (interrupts.NACK_INT_RAW == 1) {
            return Error.NoAcknowledge;
        } else if (interrupts.ARBITRATION_LOST_INT_RAW == 1) {
            return Error.ArbitrationLost;
        } else if (interrupts.TRANS_COMPLETE_INT_RAW == 1 and self.get_regs().SR.read().RESP_REC == 0) {
            return Error.NoAcknowledge;
        }
    }
    /// Propagate configuration to the peripheral
    inline fn update_config(self: I2C) void {
        self.get_regs().CTR.modify(.{ .CONF_UPGATE = 1 });
    }

    /// Read data from FIFO
    inline fn read_fifo(self: I2C) u8 {
        return self.get_regs().DATA.read().FIFO_RDATA;
    }

    /// Write data to FIFO
    inline fn write_fifo(self: I2C, data: u8) void {
        self.get_regs().DATA.write(.{ .FIFO_RDATA = data });
    }

    /// Clear all interrupts
    inline fn clear_interrupts(self: I2C) void {
        self.get_regs().INT_CLR.write_raw(0x3ffff);
    }

    inline fn start_transmission(self: I2C) void {
        self.get_regs().CTR.modify(.{ .TRANS_START = 1 });
    }

    inline fn add_cmd(self: I2C, cmd_start_idx: *usize, cmd: Command) !void {
        if (cmd_start_idx.* + 1 > self.get_regs().COMD.len)
            return Error.CommandNumberExceeded;

        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = cmd.to_value(),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;
    }

    fn setup_read(
        self: I2C,
        addr: Address,
        buffer: []const u8,
        start: bool,
        will_continue: bool,
        cmd_start_idx: *usize,
    ) !void {
        if (buffer.len == 0)
            return Error.NoData;

        const max_len = if (will_continue) I2C_CHUNK_SIZE else I2C_CHUNK_SIZE + 1;
        const initial_len: u8 = @truncate(if (will_continue) buffer.len else buffer.len - 1);
        if (buffer.len > max_len)
            return Error.FifoExceeded;

        if (start)
            try self.add_cmd(cmd_start_idx, .{ .write = .{
                .ack_exp = .ack,
                .ack_check_en = true,
                .length = 1,
            } });

        if (initial_len > 0) {
            if (initial_len < 2) {
                try self.add_cmd(cmd_start_idx, .{ .read = .{
                    .ack_value = .ack,
                    .length = @bitCast(initial_len),
                } });
            } else if (!will_continue) {
                try self.add_cmd(cmd_start_idx, .{ .read = .{
                    .ack_value = .ack,
                    .length = @bitCast(initial_len - 1),
                } });
                try self.add_cmd(cmd_start_idx, .{ .read = .{
                    .ack_value = .ack,
                    .length = 1,
                } });
            } else {
                try self.add_cmd(cmd_start_idx, .{ .read = .{
                    .ack_value = .ack,
                    .length = @bitCast(initial_len - 2),
                } });
                try self.add_cmd(cmd_start_idx, .{ .read = .{
                    .ack_value = .ack,
                    .length = 1,
                } });
                try self.add_cmd(cmd_start_idx, .{ .read = .{
                    .ack_value = .ack,
                    .length = 1,
                } });
            }
        }

        if (!will_continue)
            try self.add_cmd(cmd_start_idx, .{ .read = .{
                .ack_value = .nack,
                .length = 1,
            } });

        self.update_config();

        // Load address and R/W bit
        if (start)
            self.write_fifo(@as(u8, @intFromEnum(addr)) << 1 | @intFromEnum(OperationType.read));
    }

    fn setup_write(self: I2C, addr: Address, bytes: []const u8, start: bool, cmd_start_idx: *usize) !void {
        const max_len = if (start) I2C_CHUNK_SIZE else I2C_CHUNK_SIZE + 1;
        if (bytes.len > max_len)
            return Error.FifoExceeded;

        const write_len: u8 = @truncate(if (start) bytes.len + 1 else bytes.len);

        if (write_len > 0) {
            if (write_len < 2) {
                try self.add_cmd(cmd_start_idx, .{ .write = .{
                    .ack_exp = .ack,
                    .ack_check_en = true,
                    .length = @bitCast(write_len),
                } });
            } else if (start) {
                try self.add_cmd(cmd_start_idx, .{ .write = .{
                    .ack_exp = .ack,
                    .ack_check_en = true,
                    .length = @bitCast(write_len - 1),
                } });
                try self.add_cmd(cmd_start_idx, .{ .write = .{
                    .ack_exp = .ack,
                    .ack_check_en = true,
                    .length = 1,
                } });
            } else {
                try self.add_cmd(cmd_start_idx, .{ .write = .{
                    .ack_exp = .ack,
                    .ack_check_en = true,
                    .length = @bitCast(write_len - 2),
                } });
                try self.add_cmd(cmd_start_idx, .{ .write = .{
                    .ack_exp = .ack,
                    .ack_check_en = true,
                    .length = 1,
                } });
                try self.add_cmd(cmd_start_idx, .{ .write = .{
                    .ack_exp = .ack,
                    .ack_check_en = true,
                    .length = 1,
                } });
            }
        }

        self.update_config();

        // Load address and R/W bit
        if (start)
            self.write_fifo(@as(u8, @intFromEnum(addr)) << 1 | @intFromEnum(OperationType.write));

        // Load data bytes into FIFO
        for (bytes) |byte|
            self.write_fifo(byte);
    }

    fn read_all_from_fifo(self: I2C, buffer: []u8) !void {
        if (self.get_regs().SR.read().RXFIFO_CNT < buffer.len)
            return Error.ExecutionIncomplete;

        for (buffer) |*byte|
            byte.* = self.read_fifo();
    }

    fn wait_for_completion(self: I2C, deadline: mdf.time.Deadline) !void {
        // Monitor for completion or errors
        while (true) {
            const interrupts = self.get_regs().INT_RAW.read();

            // Check for errors
            try self.check_errors();

            // Check for completion
            if (interrupts.TRANS_COMPLETE_INT_RAW == 1 or interrupts.END_DETECT_INT_RAW == 1)
                break;

            // Check for timeout
            if (deadline.is_reached_by(time.get_time_since_boot())) {
                self.reset();
                return Error.Timeout;
            }
        }

        // Verify all commands were executed
        for (0..self.get_regs().COMD.len) |i| {
            const cmd = self.get_regs().COMD[i].read();
            if (cmd.COMMAND != 0 and cmd.COMMAND_DONE == 0) {
                return Error.ExecutionIncomplete;
            }
        }
    }

    fn stop_operation(self: I2C) !void {
        var cmd_idx: usize = 0;
        try self.add_cmd(&cmd_idx, Command.stop);

        self.start_transmission();
        try self.wait_for_completion(mdf.time.Deadline.init_absolute(null));
    }

    /// Read data from an I2C slave
    pub fn read_blocking(self: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) !void {
        return self.readv_blocking(addr, &.{dst}, timeout);
    }

    pub fn readv_blocking(self: I2C, addr: Address, chunks: []const []u8, timeout: ?mdf.time.Duration) !void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        const read_vec = microzig.utilities.Slice_Vector([]u8).init(chunks);

        var is_first_chunk = true;
        // Always saving room for the address byte. With a custom iterator we could make sure only the first chunk is 31 (room for address)
        const total_size = read_vec.size();
        var bytes_processed: usize = 0;

        var iter = read_vec.iterator();
        // TODO: Maybe we don't need 31 byte limit for reads
        while (iter.next_chunk(31)) |chunk| {
            const is_last_chunk = (bytes_processed + chunk.len == total_size);
            try self.read_operation_blocking(
                addr,
                chunk,
                is_first_chunk,
                is_last_chunk,
                !is_last_chunk,
                deadline,
            );
            is_first_chunk = false;
            bytes_processed += chunk.len;
        }
    }

    fn read_operation_blocking(
        self: I2C,
        addr: Address,
        buffer: []u8,
        start: bool,
        stop: bool,
        will_continue: bool,
        deadline: mdf.time.Deadline,
    ) !void {
        addr.check_reserved() catch return Error.TargetAddressReserved;

        self.clear_interrupts();

        // Short circuit for zero length reads as that would be an invalid operation.
        // Read lengths in the TRM are 1-255.
        if (buffer.len == 0 and !start and !stop)
            return;

        try self.start_read_operation(addr, buffer, start, will_continue);
        try self.wait_for_completion(deadline);

        // Read data from FIFO into buffer
        try self.read_all_from_fifo(buffer);

        if (stop)
            try self.stop_operation();
    }

    fn start_read_operation(self: I2C, addr: Address, buffer: []u8, start: bool, will_continue: bool) !void {
        self.reset_fifo();
        self.reset_command_list();

        var cmd_idx: usize = 0;

        if (start)
            try self.add_cmd(&cmd_idx, Command.start);

        try self.setup_read(addr, buffer, start, will_continue, &cmd_idx);

        try self.add_cmd(&cmd_idx, Command.end);
        self.start_transmission();
    }

    /// Write data to an I2C slave
    pub fn write_blocking(self: I2C, addr: Address, data: []const u8, timeout: ?mdf.time.Duration) !void {
        return self.writev_blocking(addr, &.{data}, timeout);
    }

    pub fn writev_blocking(self: I2C, addr: Address, chunks: []const []const u8, timeout: ?mdf.time.Duration) Error!void {
        return self.writev_operation_blocking(addr, chunks, true, true, timeout);
    }

    fn writev_operation_blocking(
        self: I2C,
        addr: Address,
        chunks: []const []const u8,
        start: bool,
        stop: bool,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        // TODO: Write a new utility that does similar but that will coalesce into a specified size
        const write_vec = microzig.utilities.Slice_Vector([]const u8).init(chunks);
        if (write_vec.size() == 0)
            return self.write_operation_blocking(addr, &.{}, start, stop, deadline);

        var iter = write_vec.iterator();

        var is_first_chunk = true;
        var buffer: [I2C_FIFO_SIZE]u8 = undefined;
        var buffer_level: usize = 0;
        const total_size = write_vec.size();
        var remaining = total_size;
        // Pack up 'vec' chunks into 'fifo' chunks of up to `max_chunk_size`, writing whenever we
        // fill up.
        while (remaining != 0) {
            const max_chunk_size = if (remaining <= I2C_CHUNK_SIZE)
                remaining
            else if (remaining > I2C_CHUNK_SIZE + 2)
                I2C_CHUNK_SIZE
            else
                I2C_CHUNK_SIZE - 2;

            const buffer_remaining = max_chunk_size - buffer_level;
            if (buffer_remaining == 0) {
                // Buffer is full, send it
                remaining -= buffer_level;
                const is_last_chunk = (remaining == 0);
                try self.write_operation_blocking(addr, buffer[0..buffer_level], is_first_chunk, is_last_chunk, deadline);
                is_first_chunk = false;
                buffer_level = 0;
                continue;
            }

            // Try to get next chunk. We should never not get a chunk here since we know ahead of
            // time how much to request.
            const chunk = iter.next_chunk(buffer_remaining) orelse return;

            // Copy chunk to buffer
            @memcpy(buffer[buffer_level..][0..chunk.len], chunk);
            buffer_level += chunk.len;
        }
    }

    fn write_operation_blocking(
        self: I2C,
        addr: Address,
        bytes: []const u8,
        start: bool,
        stop: bool,
        deadline: mdf.time.Deadline,
    ) Error!void {
        addr.check_reserved() catch |err| switch (err) {
            AddressError.GeneralCall => {},
            else => return Error.TargetAddressReserved,
        };

        // Short circuit for zero length writes without start or end as that would be an
        // invalid operation. Write lengths in the TRM are 1-255.
        if (bytes.len == 0 and !start and !stop)
            return;

        self.clear_interrupts();

        try self.start_write_operation(addr, bytes, start);
        try self.wait_for_completion(deadline);

        if (stop)
            try self.stop_operation();
    }

    fn start_write_operation(self: I2C, addr: Address, bytes: []const u8, start: bool) !void {
        self.reset_fifo();
        self.reset_command_list();

        var cmd_idx: usize = 0;

        if (start)
            try self.add_cmd(&cmd_idx, Command.start);

        try self.setup_write(addr, bytes, start, &cmd_idx);

        try self.add_cmd(&cmd_idx, Command.end);
        self.start_transmission();
    }
};
