//!
//! This file implements the I²C driver for the CH32V chip family
//!
//! Based on the WCH CH32V20x I2C peripheral implementation.
//! Reference: CH32V20x Reference Manual Section on I2C
//!
const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const drivers = mdf.base;
const hal = microzig.hal;

const I2C1 = microzig.chip.peripherals.I2C1;
const I2C2 = microzig.chip.peripherals.I2C2;

const I2cRegs = microzig.chip.types.peripherals.I2C1;

pub const Address = drivers.I2C_Device.Address;
pub const AddressError = drivers.I2C_Device.Address.Error;
pub const Error = drivers.I2C_Device.Error || error{
    ArbitrationLost,
    BusError,
    Overrun,
};

/// Pin remapping configuration for I2C peripherals
///
/// I2C1 has 2 configurations (1 bit: PCFR1.I2C1_RM):
///   .default (0): SCL=PB6,  SDA=PB7
///   .remap1  (1): SCL=PB8,  SDA=PB9
///
/// I2C2 has only 1 configuration (no remap available):
///   .default: SCL=PB10, SDA=PB11
///
/// See CH32V Reference Manual AFIO_PCFR1 section for details
pub const Remap = enum(u1) {
    default = 0,
    remap1 = 1,
};

pub const Config = struct {
    repeated_start: bool = true,
    baud_rate: u32 = 100_000,
    duty_cycle: DutyCycle = .duty_2,
    remap: Remap = .default,
};

pub const DutyCycle = enum {
    duty_2, // I2C fast mode Tlow/Thigh = 2
    duty_16_9, // I2C fast mode Tlow/Thigh = 16/9
};

pub const ConfigError = error{
    UnsupportedBaudRate,
    InputFreqTooLow,
};

pub const instance = struct {
    pub const I2C1: I2C = @enumFromInt(0);
    pub const I2C2: I2C = @enumFromInt(1);
    pub fn num(instance_number: u2) I2C {
        return @enumFromInt(instance_number - 1);
    }
};

pub const I2C = enum(u1) {
    _,

    pub inline fn get_regs(i2c: I2C) *volatile I2cRegs {
        return switch (@intFromEnum(i2c)) {
            0 => I2C1,
            1 => I2C2,
        };
    }

    inline fn disable(i2c: I2C) void {
        i2c.get_regs().CTLR1.modify(.{ .PE = 0 });
    }

    inline fn enable(i2c: I2C) void {
        i2c.get_regs().CTLR1.modify(.{ .PE = 1 });
    }

    /// Initializes the I2C HW block per the Config provided
    pub fn apply(comptime i2c: I2C, comptime config: Config) void {
        const regs = i2c.get_regs();

        // Enable peripheral clock
        hal.clocks.enable_peripheral_clock(switch (@intFromEnum(i2c)) {
            0 => .I2C1,
            1 => .I2C2,
        });

        // Configure AFIO remap
        hal.clocks.enable_afio_clock();
        const AFIO = microzig.chip.peripherals.AFIO;
        switch (@intFromEnum(i2c)) {
            0 => AFIO.PCFR1.modify(.{ .I2C1_RM = @intFromEnum(config.remap) }),
            // I2C2 does not have remap support on CH32V20x
            1 => {},
        }

        // Get peripheral clock frequency
        const rcc_clocks = hal.clocks.get_freqs();
        const pclk1 = rcc_clocks.pclk1;

        // Set peripheral clock frequency in MHz (must be done before disable per WCH code)
        const freqrange: u6 = @intCast(@min(pclk1 / 1_000_000, 63));
        regs.CTLR2.modify(.{ .FREQ = freqrange });

        // Disable peripheral for configuration
        i2c.disable();

        // Calculate clock control register value
        var ccr: u16 = 0;
        if (config.baud_rate <= 100_000) {
            // Standard mode (≤100kHz)
            var result = @as(u16, @intCast(pclk1 / (config.baud_rate * 2)));
            if (result < 4) result = 4; // Minimum value
            ccr = result;

            // Rise time register: freqrange + 1
            regs.RTR.write(.{ .TRISE = freqrange + 1 });
        } else {
            // Fast mode (>100kHz)
            var result: u16 = 0;
            if (config.duty_cycle == .duty_2) {
                result = @intCast(pclk1 / (config.baud_rate * 3));
            } else {
                result = @intCast(pclk1 / (config.baud_rate * 25));
                result |= 0x4000; // Set duty cycle bit
            }

            if ((result & 0x0FFF) == 0) {
                result |= 0x0001; // Minimum value
            }

            ccr = result | 0x8000; // Set F/S bit for fast mode

            // Rise time register: ((freqrange * 300) / 1000) + 1
            const trise: u6 = @intCast(((freqrange * 300) / 1000) + 1);
            regs.RTR.write(.{ .TRISE = trise });
        }

        // Write clock configuration
        regs.CKCFGR.write_raw(ccr);

        // Enable peripheral first
        i2c.enable();

        // Configure control register 1 - clear mode bits and set I2C mode + ACK
        // This matches: tmpreg &= CTLR1_CLEAR_Mask; tmpreg |= (I2C_Mode_I2C | I2C_Ack_Enable);
        regs.CTLR1.modify(.{
            .SMBUS = 0, // I2C mode (not SMBus)
            .SMBTYPE = 0, // Not used in I2C mode
            .ACK = 1, // Enable ACK
            .ENGC = 0, // Disable general call
        });
    }

    /// Disables I2C, returns peripheral registers to reset state.
    pub fn reset(i2c: I2C) void {
        i2c.disable();
    }

    /// Generate START condition
    inline fn generate_start(i2c: I2C) void {
        i2c.get_regs().CTLR1.modify(.{ .START = 1 });
    }

    /// Generate STOP condition
    inline fn generate_stop(i2c: I2C) void {
        i2c.get_regs().CTLR1.modify(.{ .STOP = 1 });
    }

    /// Generate STOP and wait for bus to be released (used in error cleanup)
    /// TRM 19.12.7 (I2Cx_STAR2): BUSY is cleared when a STOP bit is detected.
    /// Waiting for BUSY == 0 ensures the bus is idle after issuing STOP.
    fn cleanup_stop(i2c: I2C) void {
        i2c.generate_stop();

        // Wait for BUSY to clear (with simple iteration timeout, ignore deadline)
        i2c.wait_flag_star2("BUSY", 0, .no_deadline) catch {};
    }

    /// Enable/disable ACK
    inline fn set_ack(i2c: I2C, en: bool) void {
        i2c.get_regs().CTLR1.modify(.{ .ACK = @intFromBool(en) });
    }

    /// Send 7-bit address with direction bit
    inline fn send_address(i2c: I2C, addr: Address, direction: enum { write, read }) void {
        const addr_byte = @as(u8, @intFromEnum(addr)) << 1 | @intFromBool(direction == .read);
        i2c.get_regs().DATAR.write_raw(addr_byte);
    }

    /// Common wait for STAR1/STAR2 flag with timeout
    /// Note: Error flags reside in STAR1; we poll check_errors() only on STAR1 path.
    inline fn wait_flag_reg(i2c: I2C, comptime use_star2: bool, comptime flag_name: []const u8, expected: u1, deadline: mdf.time.Deadline) Error!void {
        const regs = i2c.get_regs();
        var iterations: u32 = 0;
        while ((if (use_star2) @field(regs.STAR2.read(), flag_name) else @field(regs.STAR1.read(), flag_name)) != expected) {
            if (!use_star2) {
                // Only STAR1 has error flags we should poll while waiting
                try i2c.check_errors();
            }
            iterations += 1;
            if (iterations > 100_000) return Error.Timeout;
            if (deadline.is_reached_by(hal.time.get_time_since_boot())) return Error.Timeout;
        }
    }

    /// Wait for a specific flag in STAR1 with timeout
    inline fn wait_flag_star1(i2c: I2C, comptime flag_name: []const u8, expected: u1, deadline: mdf.time.Deadline) Error!void {
        return i2c.wait_flag_reg(false, flag_name, expected, deadline);
    }

    /// Wait for a specific flag in STAR2 with timeout
    inline fn wait_flag_star2(i2c: I2C, comptime flag_name: []const u8, expected: u1, deadline: mdf.time.Deadline) Error!void {
        return i2c.wait_flag_reg(true, flag_name, expected, deadline);
    }

    /// Check and clear error flags
    /// TRM 19.12.6 (I2Cx_STAR1): AF, ARLO, BERR, OVR are cleared by software
    /// by writing 0 (or by hardware when PE becomes 0). Clear only bits observed
    /// set to avoid clearing a flag that latched after the status read.
    fn check_errors(i2c: I2C) Error!void {
        const regs = i2c.get_regs();
        const star1 = regs.STAR1.read();

        // Choose one error to report
        var err: ?Error = null;
        if (star1.AF == 1) {
            err = Error.NoAcknowledge;
        } else if (star1.ARLO == 1) {
            err = Error.ArbitrationLost;
        } else if (star1.BERR == 1) {
            err = Error.BusError;
        } else if (star1.OVR == 1) {
            err = Error.Overrun;
        }

        // Clear only the flags that were observed set to avoid
        // accidentally clearing an error that latched after our read.
        if (err) |e| {
            if (star1.AF == 1) regs.STAR1.modify(.{ .AF = 0 });
            if (star1.ARLO == 1) regs.STAR1.modify(.{ .ARLO = 0 });
            if (star1.BERR == 1) regs.STAR1.modify(.{ .BERR = 0 });
            if (star1.OVR == 1) regs.STAR1.modify(.{ .OVR = 0 });
            return e;
        }
    }

    /// Attempts to write bytes to target device and blocks until complete, error, or timeout
    pub fn write_blocking(i2c: I2C, addr: Address, data: []const u8, timeout: ?mdf.time.Duration) Error!void {
        return i2c.writev_blocking(addr, &.{data}, timeout);
    }

    /// Vectored write - writes multiple buffers in sequence
    pub fn writev_blocking(i2c: I2C, addr: Address, chunks: []const []const u8, timeout: ?mdf.time.Duration) Error!void {
        const regs = i2c.get_regs();
        const write_vec = microzig.utilities.SliceVector([]const u8).init(chunks);

        if (write_vec.size() == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(hal.time.get_time_since_boot(), timeout);

        // Generate START condition (hardware will wait if bus is busy)
        i2c.generate_start();

        // Ensure STOP is generated and bus is released on any error
        errdefer i2c.cleanup_stop();

        // Wait for SB (Start Bit) flag
        try i2c.wait_flag_star1("SB", 1, deadline);

        // Send address with write bit
        i2c.send_address(addr, .write);

        // Wait for ADDR flag (errors like NACK are checked while waiting)
        try i2c.wait_flag_star1("ADDR", 1, deadline);

        // Clear ADDR by reading SR2
        _ = regs.STAR2.read();

        // Send data bytes
        var iter = write_vec.iterator();
        while (iter.next_element()) |element| {
            // Wait for TXE (Transmit buffer Empty)
            try i2c.wait_flag_star1("TxE", 1, deadline);

            // Write data to DATAR
            regs.DATAR.write_raw(element.value);
        }

        // Wait for BTF (Byte Transfer Finished) - ensures last byte is transmitted
        try i2c.wait_flag_star1("BTF", 1, deadline);

        // Generate STOP condition
        i2c.generate_stop();

        // Wait for BUSY flag to clear
        try i2c.wait_flag_star2("BUSY", 0, deadline);
    }

    /// Attempts to read bytes from target device and blocks until complete, error, or timeout
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) Error!void {
        return i2c.readv_blocking(addr, &.{dst}, timeout);
    }

    /// Vectored read - reads into multiple buffers in sequence
    pub fn readv_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?mdf.time.Duration) Error!void {
        const regs = i2c.get_regs();
        const read_vec = microzig.utilities.SliceVector([]u8).init(chunks);

        if (read_vec.size() == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(hal.time.get_time_since_boot(), timeout);
        const total_bytes = read_vec.size();

        // Enable ACK for multi-byte reads
        if (total_bytes > 1) {
            i2c.set_ack(true);
        }

        // Generate START condition
        i2c.generate_start();

        // Ensure STOP is generated and bus is released on any error
        errdefer i2c.cleanup_stop();

        // Wait for SB (Start Bit) flag
        try i2c.wait_flag_star1("SB", 1, deadline);

        // Send address with read bit
        i2c.send_address(addr, .read);

        // Wait for ADDR flag (errors like NACK are checked while waiting)
        try i2c.wait_flag_star1("ADDR", 1, deadline);

        // Handle single byte read specially
        if (total_bytes == 1) {
            // Disable ACK before clearing ADDR
            i2c.set_ack(false);

            // Clear ADDR by reading SR2
            _ = regs.STAR2.read();

            // Generate STOP
            i2c.generate_stop();

            // Wait for RxNE
            try i2c.wait_flag_star1("RxNE", 1, deadline);

            // Read data
            var iter = read_vec.iterator();
            if (iter.next_element_ptr()) |element| {
                element.value_ptr.* = regs.DATAR.read().DATAR;
            }
        } else {
            // Clear ADDR by reading SR2
            _ = regs.STAR2.read();

            // Read data bytes
            var iter = read_vec.iterator();
            var bytes_remaining = total_bytes;

            while (iter.next_element_ptr()) |element| {
                bytes_remaining -= 1;

                // For the second-to-last byte, disable ACK
                if (bytes_remaining == 1) {
                    i2c.set_ack(false);
                }

                // For the last byte, generate STOP
                if (bytes_remaining == 0) {
                    i2c.generate_stop();
                }

                // Wait for RxNE
                try i2c.wait_flag_star1("RxNE", 1, deadline);

                // Read data
                element.value_ptr.* = regs.DATAR.read().DATAR;
            }
        }

        // Wait for BUSY flag to clear
        try i2c.wait_flag_star2("BUSY", 0, deadline);
    }

    /// Write then read with repeated start (or STOP/START if repeated start disabled)
    pub fn write_then_read_blocking(i2c: I2C, addr: Address, src: []const u8, dst: []u8, timeout: ?mdf.time.Duration) Error!void {
        // For CH32V, we'll do separate write and read operations
        // The repeated start would require more complex state machine
        try i2c.write_blocking(addr, src, timeout);
        try i2c.read_blocking(addr, dst, timeout);
    }

    /// Write then read with repeated start (or STOP/START if repeated start disabled)
    pub fn writev_then_readv_blocking(
        i2c: I2C,
        addr: Address,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        // For CH32V, we'll do separate write and read operations
        // The repeated start would require more complex state machine
        try i2c.writev_blocking(addr, write_chunks, timeout);
        try i2c.readv_blocking(addr, read_chunks, timeout);
    }
};
