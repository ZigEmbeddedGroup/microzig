const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
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

pub const Error = error{
    FifoExceeded,
    AcknowledgeCheckFailed,
    Timeout,
    ArbitrationLost,
    ExecutionIncomplete,
    CommandNumberExceeded,
    ZeroLengthInvalid,
    TargetAddressReserved,
};

///
/// 7-bit I²C address, without the read/write bit.
///
pub const Address = enum(u7) {
    _,

    pub fn new(addr: u7) Address {
        var a = @as(Address, @enumFromInt(addr));
        std.debug.assert(!a.is_reserved());
        return a;
    }

    ///
    /// Returns `true` if the Address is a reserved I²C address.
    ///
    /// Reserved addresses are ones that match `0b0000XXX` or `0b1111XXX`.
    ///
    /// See more here: https://www.i2c-bus.org/addressing/
    pub fn is_reserved(addr: Address) bool {
        const value: u7 = @intFromEnum(addr);
        return ((value & 0x78) == 0) or ((value & 0x78) == 0x78);
    }

    pub fn format(addr: Address, fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        try writer.print("I2C(0x{X:0>2})", .{@intFromEnum(addr)});
    }
};

const Opcode = enum(u4) {
    RSTART = 6,
    WRITE = 1,
    READ = 3,
    STOP = 2,
    END = 4,
};

const Command = union(enum) {
    Start,
    Stop,
    Write: struct {
        /// Expected ACK value for transmitter
        ack_exp: Ack,
        /// Enable ACK checking
        ack_check_en: bool,
        /// Data length in bytes (1-255)
        length: u8,
    },
    Read: struct {
        /// ACK value to send after byte received
        ack_value: Ack,
        // TODO: No ack_check_en for read? TRM says only for write, but examples set it (Page 696)
        /// Data length in bytes (1-255)
        length: u8,
    },

    /// Convert command to register value
    pub fn toValue(self: Command) u14 {
        var cmd: u14 = 0;

        switch (self) {
            .Start, .Stop => {
                cmd = 0;
            },
            .Write => |write| {
                cmd = @as(u14, write.length);
            },
            .Read => |read| {
                cmd = @as(u14, read.length);
            },
        }

        // Set opcode
        const opcode: Opcode = switch (self) {
            .Start => .RSTART,
            .Stop => .STOP,
            .Write => .WRITE,
            .Read => .READ,
        };
        cmd |= @as(u14, @intFromEnum(opcode)) << 11;

        // Set ack_check_en bit
        if (self == .Write and self.Write.ack_check_en) {
            cmd |= 1 << 8;
        }

        // Set ack_exp bit
        const ack_exp = if (self == .Write) self.Write.ack_exp else .Nack;
        if (ack_exp == .Nack) {
            cmd |= 1 << 9;
        }

        // Set ack_value bit
        const ack_value = if (self == .Read) self.Read.ack_value else .Nack;
        if (ack_value == .Nack) {
            cmd |= 1 << 10;
        }

        return cmd;
    }
};

const Ack = enum(u1) {
    Ack = 0,
    Nack = 1,
};

const OperationType = enum(u1) {
    Write = 0,
    Read = 1,
};

/// Operation kind used during transactions
const OpKind = enum(u1) {
    Write,
    Read,
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

/// I2C Master peripheral driver
pub const I2C = enum(u1) {
    _,

    inline fn get_regs(i2c: I2C) *volatile I2cRegs {
        _ = i2c;
        return I2C0;
    }

    pub fn apply(i2c: I2C, pins: Pins, frequency: u32) ConfigError!void {
        std.log.debug("Applying config", .{});
        const regs = i2c.get_regs();

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
        i2c.reset();

        // Disable all I2C interrupts
        regs.INT_ENA.write_raw(0);

        // Clear all I2C interrupts
        i2c.clear_interrupts();

        // Configure controller
        regs.CTR.write_raw(0);
        regs.CTR.modify(.{
            .MS_MODE = 1, // Set I2C controller to master mode
            // The rs one sets 1, but doc says 0. esp-idf sets 1
            // Seems we set this to 1 because we use the first method to set SCL and SDA as open drain (page 681)
            .SDA_FORCE_OUT = 1, // Use open drain output for SDA
            .SCL_FORCE_OUT = 1, // Use open drain output for SCL
            // .SDA_FORCE_OUT = 0, // Use open drain output for SDA
            // .SCL_FORCE_OUT = 0, // Use open drain output for SCL
            .TX_LSB_FIRST = 0, // MSB first for sending
            .RX_LSB_FIRST = 0, // MSB first for receiving
            .CLK_EN = 1, // Enable clock
        });

        // Configure filter
        i2c.set_filter(7, 7);

        // Configure frequency
        try i2c.set_frequency(SOURCE_CLK_FREQ, frequency);

        // Propagate configuration changes
        regs.CTR.modify(.{ .CONF_UPGATE = 1 });
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
            // TODO: esp-hal does .bits(32). But that's more than 5 bits?
            // .TXFIFO_WM_THRHD = 32,
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
        // self.updateConfig();

        // TODO: Do we need to clear interrupts?
        // clear_interrupts clears ALL, this only clear rx/tx fifo ones
        self.get_regs().INT_CLR.modify(.{
            .RXFIFO_WM_INT_CLR = 1,
            .TXFIFO_WM_INT_CLR = 1,
        });
    }

    /// Reset the command list
    fn reset_command_list(self: I2C) void {
        // Reset all command registers
        for (0..self.get_regs().COMD.len) |i|
            self.get_regs().COMD[@intCast(i)].write_raw(0);
    }

    /// Set the filter threshold in clock cycles
    fn set_filter(self: I2C, sda_threshold: ?u4, scl_threshold: ?u4) void {
        std.log.debug("Setting filter", .{});
        // // TODO: Maybe do in two writes?
        // if (sda_threshold) |threshold| {
        //     self.get_regs().FILTER_CFG.modify(.{
        //         .SDA_FILTER_THRES = threshold,
        //         .SDA_FILTER_EN = 1,
        //     });
        // } else {
        //     self.get_regs().FILTER_CFG.modify(.{ .SDA_FILTER_EN = 0 });
        // }
        //
        // // This UNSETs the SDA stuff (maybe) since we read back 0 in these bits
        // if (scl_threshold) |threshold| {
        //     self.get_regs().FILTER_CFG.modify(.{
        //         .SCL_FILTER_THRES = threshold,
        //         .SCL_FILTER_EN = 1,
        //     });
        // } else {
        //     self.get_regs().FILTER_CFG.modify(.{ .SCL_FILTER_EN = 0 });
        // }
        self.get_regs().FILTER_CFG.write(.{
            .SDA_FILTER_THRES = if (sda_threshold) |t| t else 0,
            .SDA_FILTER_EN = if (sda_threshold) |_| @as(u1, 1) else @as(u1, 0),
            .SCL_FILTER_THRES = if (scl_threshold) |t| t else 0,
            .SCL_FILTER_EN = if (scl_threshold) |_| @as(u1, 1) else @as(u1, 0),
        });
    }

    /// Sets the frequency of the I2C interface
    fn set_frequency(self: I2C, source_clk: u32, bus_freq: u32) !void {
        std.log.debug("Setting frequency", .{});
        // Calculate dividing factor (maximum possible)
        const sclk_div: u8 = @intCast((source_clk / (bus_freq * 1024) + 1));
        if (sclk_div >= 256) {
            return ConfigError.InvalidClkConfig;
        }

        // Calculate half cycle
        const half_cycle: u32 = @intCast(source_clk / (bus_freq * @as(u32, sclk_div) * 2));
        if (half_cycle > std.math.maxInt(u9)) {
            return ConfigError.InvalidClkConfig;
        }

        const scl_low: u9 = @intCast(half_cycle);
        const scl_high: u9 = @intCast(half_cycle);
        const sda_hold: u9 = @intCast(half_cycle / 2);
        const sda_sample: u9 = @intCast(scl_high / 2);
        const setup: u9 = @intCast(half_cycle);
        const hold: u9 = @intCast(half_cycle);
        // Set timeout value to 10 bus cycles
        // This value is the exponent e.g. 2^timeout cycles
        // TODO: CLz
        const timeout: u5 = @intCast(std.math.log2(half_cycle * 20));
        std.log.debug(
            "scl low {} scl high {} sda hold {} sda sample {} setup {} hold {} timeout {}",
            .{ scl_low, scl_high, sda_hold, sda_sample, setup, hold, timeout },
        );

        // Set clock divider
        self.get_regs().CLK_CONF.modify(.{
            .SCLK_SEL = 0,
            .SCLK_DIV_NUM = sclk_div,
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

    /// Execute transmission and monitor for completion/errors
    fn execute_transmission(self: I2C, deadline: mdf.time.Deadline) !void {
        // Clear all I2C interrupts
        self.clear_interrupts();

        // Ensure configuration is propagated
        self.get_regs().CTR.modify(.{ .CONF_UPGATE = 1 });

        // Start transmission, causes peripheral to read its commands from COMD
        self.get_regs().CTR.modify(.{ .TRANS_START = 1 });

        // Monitor for completion or errors
        while (true) {
            const interrupts = self.get_regs().INT_RAW.read();

            // Check for errors
            if (interrupts.TIME_OUT_INT_RAW == 1) {
                return Error.Timeout;
            } else if (interrupts.NACK_INT_RAW == 1) {
                return Error.AcknowledgeCheckFailed;
            } else if (interrupts.ARBITRATION_LOST_INT_RAW == 1) {
                return Error.ArbitrationLost;
            }

            // Check for completion
            if (interrupts.TRANS_COMPLETE_INT_RAW == 1 or interrupts.END_DETECT_INT_RAW == 1)
                break;

            // Check for timeout
            if (deadline.is_reached_by(time.get_time_since_boot()))
                return Error.Timeout;
        }

        // Verify all commands were executed
        for (0..self.get_regs().COMD.len) |i| {
            const cmd = self.get_regs().COMD[i].read();
            if (cmd.COMMAND != 0 and cmd.COMMAND_DONE == 0) {
                return Error.ExecutionIncomplete;
            }
        }
    }

    /// Add a write operation to the command sequence
    fn add_write_op(self: I2C, addr: Address, bytes: []const u8, cmd_start_idx: *usize) !void {
        // Check if we have enough command registers
        // Need START, WRITE, STOP
        const needed_cmds: usize = 3;
        if (cmd_start_idx.* + needed_cmds > self.get_regs().COMD.len)
            return Error.CommandNumberExceeded;

        // START command
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = Command.toValue(.Start),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;

        // Load address with WRITE bit into FIFO
        self.write_fifo(@as(u8, @intFromEnum(addr)) << 1 | @intFromEnum(OperationType.Read));

        // Load data bytes into FIFO
        for (bytes) |byte|
            self.write_fifo(byte);

        // WRITE command
        const write_cmd = Command.Write{
            .ack_exp = .ACK,
            .ack_check_en = 1,
            .length = @intCast(1 + bytes.len),
        };
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = write_cmd.toValue(),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;

        // STOP command
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = Command.toValue(.Stop),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;
    }

    /// Add a read operation to the command sequence
    fn add_read_op(self: I2C, addr: Address, buffer_len: usize, cmd_start_idx: *usize) !void {
        // Check if we have enough command registers
        // If buffer > 1, we need START, WRITE, READ, READ, STOP
        const needed_cmds: usize = if (buffer_len > 1) 5 else 4;
        if (cmd_start_idx.* + needed_cmds > self.get_regs().COMD.len)
            return Error.CommandNumberExceeded;

        // START command
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = Command.toValue(.Start),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;

        // Load address with READ bit set into FIFO
        self.write_fifo(@as(u8, @intFromEnum(addr)) << 1 | @intFromEnum(OperationType.Read));

        // WRITE command for address
        const write_cmd: Command = .{ .Write = .{
            .ack_exp = .Ack,
            .ack_check_en = true,
            .length = 1,
        } };
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = write_cmd.toValue(),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;

        // For reading multiple bytes, first n-1 bytes with ACK
        if (buffer_len > 1) {
            const read_cmd = Command{ .Read = .{
                .ack_value = .Ack,
                .length = @intCast(buffer_len - 1),
            } };
            self.get_regs().COMD[cmd_start_idx.*].write(.{
                .COMMAND = read_cmd.toValue(),
                .COMMAND_DONE = 0,
            });
            cmd_start_idx.* += 1;
        }

        // Last byte with NACK
        const last_read_cmd = Command{ .Read = .{
            .ack_value = .Nack,
            .length = 1,
        } };
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = last_read_cmd.toValue(),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;

        // STOP command
        self.get_regs().COMD[cmd_start_idx.*].write(.{
            .COMMAND = Command.toValue(.Stop),
            .COMMAND_DONE = 0,
        });
        cmd_start_idx.* += 1;
    }

    /// Read data from an I2C slave
    pub fn read_blocking(self: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) !void {
        // TODO: readv_blocking
        if (addr.is_reserved())
            return error.TargetAddressReserved;

        // Check if buffer exceeds FIFO size
        if (dst.len > 31)
            return Error.FifoExceeded;

        // Reset FIFO and command list
        self.reset_fifo();
        self.reset_command_list();

        // Add read operation
        var cmd_idx: usize = 0;
        try self.add_read_op(addr, dst.len, &cmd_idx);

        // Execute transmission
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
        try self.execute_transmission(deadline);

        // Read data from FIFO into dst
        for (dst) |*byte|
            byte.* = self.read_fifo();
    }

    /// Write data to an I2C slave
    pub fn write_blocking(self: I2C, addr: Address, src: []const u8, timeout: ?mdf.time.Duration) !void {
        // TODO: writev_blocking
        if (addr.is_reserved())
            return error.TargetAddressReserved;

        // Split data into chunks that fit in TX FIFO (31 bytes max + 1 addr byte)
        var chunk_start: usize = 0;

        while (chunk_start < src.len) {
            // Reset FIFO and command list
            self.reset_fifo();
            self.reset_command_list();

            // Calculate chunk size (max 31 bytes)
            const remaining = src.len - chunk_start;
            const chunk_size = if (remaining > 31) 31 else remaining;
            const chunk = src[chunk_start .. chunk_start + chunk_size];

            // Add write operation
            var cmd_idx: usize = 0;
            try self.add_write_op(addr, chunk, &cmd_idx);

            // Execute transmission
            const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);
            try self.execute_transmission(deadline);

            // Move to next chunk
            chunk_start += chunk_size;
        }
    }

    /// Write data then read data from an I2C slave
    pub fn write_then_read_blocking(self: I2C, addr: Address, src: []const u8, dst: []u8, timeout: ?mdf.time.Duration) !void {
        if (addr.is_reserved())
            return error.TargetAddressReserved;

        // Check if buffers exceed FIFO size
        if (src.len > 31 or dst.len > 31)
            return Error.FifoExceeded;

        // Reset FIFO and command list
        self.reset_fifo();
        self.reset_command_list();

        // Add write operation followed by read operation
        var cmd_idx: usize = 0;
        try self.add_write_op(addr, src, &cmd_idx);
        try self.add_read_op(addr, dst.len, &cmd_idx);

        // Execute transmission
        try self.execute_transmission(timeout);

        // Read data from FIFO into buffer
        for (dst) |*byte|
            byte.* = self.read_fifo();
    }
};
