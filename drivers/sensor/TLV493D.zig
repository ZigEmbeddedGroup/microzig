//!
//! Generic driver for the Infineon TLV493D 3D magnetic sensor.
//!
//! Datasheet:
//! * https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");
const Datagram_Device = mdf.base.Datagram_Device;
const Clock_Device = mdf.base.Clock_Device;

/// TLV493D I2C addresses
pub const TLV493D_ADDRESS1: u8 = 0x5E;
pub const TLV493D_ADDRESS2: u8 = 0x1F;

/// Startup delay in milliseconds
pub const TLV493D_STARTUPDELAY_MS: u32 = 40;

/// Conversion factors
pub const TLV493D_B_MULT: f32 = 0.098; // mT per LSB
pub const TLV493D_TEMP_MULT: f32 = 1.1; // °C per LSB
pub const TLV493D_TEMP_OFFSET: f32 = 340.0; // Temperature offset

/// Access modes for the sensor
pub const AccessMode = enum(u8) {
    powerdown = 0,
    fast = 1,
    low_power = 2,
    ultra_low_power = 3,
    master_controlled = 4,
};

/// Default mode for sensor operation
pub const TLV493D_DEFAULTMODE = AccessMode.master_controlled;

/// TLV493D Measurement values
pub const Values = struct {
    x: f32, // X axis magnetic flux (mT)
    y: f32, // Y axis magnetic flux (mT)
    z: f32, // Z axis magnetic flux (mT)
    temp: f32, // Device temperature (°C)
};

/// TLV493D configuration
pub const Config = struct {
    // TODO: With an i2c interface we'd use this to set up the peripheral
    addr: u8, // No default to force user to set it
    reset: bool = true,
};

/// TLV493D related errors
pub const Error = error{
    // TODO: We can only detect NoDevice if we get a NACK, which we can only tell with a proper i2c
    // interface
    NoDevice,
    BusError,
    FrameError,
    DatagramError,
    InvalidData,
};

/// Register indices for read operations
const ReadReg = struct {
    pub const BX1: u8 = 0;
    pub const BY1: u8 = 1;
    pub const BZ1: u8 = 2;
    pub const TEMP1: u8 = 3;
    pub const BX2: u8 = 4;
    pub const BZ2: u8 = 5;
    pub const TEMP2: u8 = 6;
    pub const RES1: u8 = 7;
    pub const RES2: u8 = 8;
    pub const RES3: u8 = 9;
};

/// Register masks for bit field operations
const RegMask = struct {
    byte_index: u8,
    mask: u8,
    shift: u3,
};

/// Read register mask keys
const ReadMaskKey = enum(u8) {
    R_BX1 = 0,
    R_BY1 = 1,
    R_BZ1 = 2,
    R_TEMP1 = 3,
    R_BX2 = 4,
    R_BY2 = 5,
    R_BZ2 = 6,
    R_TEMP2 = 7,
    R_FRAMECOUNTER = 8,
    R_CHANNEL = 9,
    R_RES1 = 10,
    R_RES2 = 11,
    R_RES3 = 12,
};

/// Read register masks lookup table
const READ_MASK_TABLE = [_]RegMask{
    RegMask{ .byte_index = 0, .mask = 0xFF, .shift = 0 }, // R_BX1
    RegMask{ .byte_index = 1, .mask = 0xFF, .shift = 0 }, // R_BY1
    RegMask{ .byte_index = 2, .mask = 0xFF, .shift = 0 }, // R_BZ1
    RegMask{ .byte_index = 3, .mask = 0xF0, .shift = 4 }, // R_TEMP1
    RegMask{ .byte_index = 4, .mask = 0xF0, .shift = 4 }, // R_BX2
    RegMask{ .byte_index = 4, .mask = 0x0F, .shift = 0 }, // R_BY2
    RegMask{ .byte_index = 5, .mask = 0x0F, .shift = 0 }, // R_BZ2
    RegMask{ .byte_index = 6, .mask = 0xFF, .shift = 0 }, // R_TEMP2
    RegMask{ .byte_index = 3, .mask = 0x0C, .shift = 2 }, // R_FRAMECOUNTER
    RegMask{ .byte_index = 3, .mask = 0x03, .shift = 0 }, // R_CHANNEL
    RegMask{ .byte_index = 7, .mask = 0x1F, .shift = 0 }, // R_RES1
    RegMask{ .byte_index = 8, .mask = 0xFF, .shift = 0 }, // R_RES2
    RegMask{ .byte_index = 9, .mask = 0x1F, .shift = 0 }, // R_RES3
};

fn get_read_mask(key: ReadMaskKey) RegMask {
    return READ_MASK_TABLE[@intFromEnum(key)];
}

/// Write register mask keys
const WriteMaskKey = enum(u8) {
    W_PARITY = 0,
    W_RES1 = 1,
    W_INT = 2,
    W_FAST = 3,
    W_LOWPOWER = 4,
    W_RES2 = 5,
    W_TEMP_NEN = 6,
    W_LP_PERIOD = 7,
    W_PARITY_EN = 8,
    W_RES3 = 9,
};

/// Write register masks lookup table
const WRITE_MASK_TABLE = [_]RegMask{
    RegMask{ .byte_index = 1, .mask = 0x80, .shift = 7 }, // W_PARITY
    RegMask{ .byte_index = 1, .mask = 0x18, .shift = 3 }, // W_RES1
    RegMask{ .byte_index = 1, .mask = 0x04, .shift = 2 }, // W_INT
    RegMask{ .byte_index = 1, .mask = 0x02, .shift = 1 }, // W_FAST
    RegMask{ .byte_index = 1, .mask = 0x01, .shift = 0 }, // W_LOWPOWER
    RegMask{ .byte_index = 2, .mask = 0xFF, .shift = 0 }, // W_RES2
    RegMask{ .byte_index = 3, .mask = 0x80, .shift = 7 }, // W_TEMP_NEN
    RegMask{ .byte_index = 3, .mask = 0x40, .shift = 6 }, // W_LP_PERIOD
    RegMask{ .byte_index = 3, .mask = 0x20, .shift = 5 }, // W_PARITY_EN
    RegMask{ .byte_index = 3, .mask = 0x1F, .shift = 0 }, // W_RES3
};

fn get_write_mask(key: WriteMaskKey) RegMask {
    return WRITE_MASK_TABLE[@intFromEnum(key)];
}

/// Access mode configuration
const AccessModeConfig = struct {
    fast: u8,
    lp: u8,
    lp_period: u8,
    measurement_time: u16, // in ms
};

/// Access mode lookup table
const ACCESS_MODE_CONFIGS = [_]AccessModeConfig{
    .{ .fast = 0, .lp = 0, .lp_period = 0, .measurement_time = 1000 }, // POWERDOWNMODE
    .{ .fast = 1, .lp = 0, .lp_period = 0, .measurement_time = 1 }, // FASTMODE
    .{ .fast = 0, .lp = 1, .lp_period = 0, .measurement_time = 10 }, // LOWPOWERMODE
    .{ .fast = 0, .lp = 1, .lp_period = 1, .measurement_time = 100 }, // ULTRALOWPOWERMODE
    .{ .fast = 1, .lp = 1, .lp_period = 0, .measurement_time = 1 }, // MASTERCONTROLLEDMODE
};

pub const TLV493D = struct {
    const Self = @This();

    dev: Datagram_Device,
    clock: Clock_Device,
    config: Config,
    read_data: [10]u8,
    write_data: [4]u8,
    x_data: i16 = 0,
    y_data: i16 = 0,
    z_data: i16 = 0,
    temp_data: i16 = 0,
    mode: AccessMode,
    expected_frame_count: u8,

    /// Create a new TLV493D instance
    pub fn init(
        dev: Datagram_Device,
        clock: Clock_Device,
        config: Config,
    ) Error!Self {
        var self = Self{
            .dev = dev,
            .clock = clock,
            .config = config,
            .read_data = [_]u8{0} ** 10,
            .write_data = [_]u8{0} ** 4,
            // TODO: Add to config
            // .mode = .fast,
            .mode = TLV493D_DEFAULTMODE,
            .expected_frame_count = 0,
        };

        self.setup_write_buffer() catch return Error.BusError;

        // Sleep for startup delay
        // TODO: Needed?
        self.clock.sleep_ms(TLV493D_STARTUPDELAY_MS);

        // Reset sensor if requested
        if (config.reset)
            try self.reset_sensor();

        // Get all register data from sensor
        try self.read_out();

        try self.set_access_mode(self.mode);

        return self;
    }

    fn setup_write_buffer(self: *Self) !void {
        // NOTE: I think that this is just to clear it out and reset its state.
        try self.read_out();

        inline for (
            .{ WriteMaskKey.W_RES1, WriteMaskKey.W_RES2, WriteMaskKey.W_RES3 },
            .{ ReadMaskKey.R_RES1, ReadMaskKey.R_RES2, ReadMaskKey.R_RES3 },
        ) |w_mask, r_mask| {
            const value = self.get_reg_bits(get_read_mask(r_mask));
            self.set_write_key(get_write_mask(w_mask), value);
        }
    }

    /// Deinitialize the device
    pub fn deinit(self: *Self) void {
        self.disable_interrupt() catch {};
        self.set_access_mode(AccessMode.powerdown) catch {};
    }

    /// Reset the sensor using recovery sequence
    fn reset_sensor(self: *Self) Error!void {
        var reset_data: [1]u8 = undefined;

        // This IC uses the value on the SDA line to determine which address it listens on.
        // NOTE: The proper way to do this is to write to the i2c address 0, which we can't do with
        // a datagram device.
        if (self.config.addr == TLV493D_ADDRESS1)
            reset_data[0] = 0xFF // Set SDA high for address 0x5E
        else
            reset_data[0] = 0x00; // Set SDA low for address 0x1F

        self.dev.writev(&.{&reset_data}) catch return Error.DatagramError;
    }

    /// Read all registers from sensor
    fn read_out(self: *Self) Error!void {
        const bytes_read = self.dev.readv(&.{&self.read_data}) catch return Error.DatagramError;
        if (bytes_read != 10) return Error.InvalidData;
    }

    /// Write configuration to sensor
    fn write_out(self: *Self) Error!void {
        self.dev.writev(&.{&self.write_data}) catch return Error.DatagramError;
    }

    /// Set access mode
    pub fn set_access_mode(self: *Self, mode: AccessMode) Error!void {
        const mode_config = &ACCESS_MODE_CONFIGS[@intFromEnum(mode)];

        self.set_write_key(get_write_mask(WriteMaskKey.W_FAST), mode_config.fast);
        self.set_write_key(get_write_mask(WriteMaskKey.W_LOWPOWER), mode_config.lp);
        self.set_write_key(get_write_mask(WriteMaskKey.W_LP_PERIOD), mode_config.lp_period);

        self.calc_parity();
        try self.write_out();

        self.mode = mode;
    }

    /// Enable interrupt
    pub fn enable_interrupt(self: *Self) Error!void {
        self.set_write_key(get_write_mask(WriteMaskKey.W_INT), 1);
        self.calc_parity();
        try self.write_out();
    }

    /// Disable interrupt
    pub fn disable_interrupt(self: *Self) Error!void {
        self.set_write_key(get_write_mask(WriteMaskKey.W_INT), 0);
        self.calc_parity();
        try self.write_out();
    }

    /// Enable temperature measurement
    /// Note that according to the datasheet, we can save 25% of power consumption by keeping this
    /// turned off.
    pub fn enable_temp(self: *Self) Error!void {
        self.set_write_key(get_write_mask(WriteMaskKey.W_TEMP_NEN), 0);
        self.calc_parity();
        try self.write_out();
    }

    /// Disable temperature measurement
    pub fn disableTemp(self: *Self) Error!void {
        self.set_write_key(get_write_mask(WriteMaskKey.W_TEMP_NEN), 1);
        self.calc_parity();
        try self.write_out();
    }

    /// Get measurement delay (in ms) for current mode
    pub fn get_measurement_delay(self: *Self) u16 {
        return ACCESS_MODE_CONFIGS[@intFromEnum(self.mode)].measurement_time;
    }

    /// Update sensor data
    pub fn update_data(self: *Self) Error!void {
        var powerdown = false;

        // In POWERDOWNMODE, sensor has to be switched on for one measurement
        if (self.mode == AccessMode.powerdown) {
            self.set_access_mode(AccessMode.master_controlled) catch return Error.BusError;

            // Wait for measurement delay
            self.clock.sleep_ms(self.get_measurement_delay());

            powerdown = true;
        }

        // Read measurement data
        self.read_out() catch return Error.BusError;
        // std.log.debug("{x}", .{self.read_data}); // DELETEME

        // Construct results from registers
        self.x_data = self.concat_results(
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_BX1)),
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_BX2)),
            true,
        );
        self.y_data = self.concat_results(
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_BY1)),
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_BY2)),
            true,
        );
        self.z_data = self.concat_results(
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_BZ1)),
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_BZ2)),
            true,
        );
        self.temp_data = self.concat_results(
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_TEMP1)),
            self.get_reg_bits(get_read_mask(ReadMaskKey.R_TEMP2)),
            false,
        );

        // Switch sensor back to POWERDOWNMODE if it was in POWERDOWNMODE before
        if (powerdown)
            self.set_access_mode(AccessMode.powerdown) catch return Error.BusError;

        // Check for frame errors
        if (self.get_reg_bits(get_read_mask(ReadMaskKey.R_CHANNEL)) != 0)
            return Error.FrameError;

        self.expected_frame_count = self.get_reg_bits(get_read_mask(ReadMaskKey.R_FRAMECOUNTER)) +% 1;
    }

    /// Read magnetic field and temperature values
    pub fn read(self: *Self) Error!Values {
        try self.update_data();

        return Values{
            .x = @as(f32, @floatFromInt(self.x_data)) * TLV493D_B_MULT,
            .y = @as(f32, @floatFromInt(self.y_data)) * TLV493D_B_MULT,
            .z = @as(f32, @floatFromInt(self.z_data)) * TLV493D_B_MULT,
            .temp = (@as(f32, @floatFromInt(self.temp_data)) - TLV493D_TEMP_OFFSET) * TLV493D_TEMP_MULT,
        };
    }

    /// Get X-axis magnetic field
    pub fn get_x(self: *Self) f32 {
        return @as(f32, @floatFromInt(self.x_data)) * TLV493D_B_MULT;
    }

    /// Get Y-axis magnetic field
    pub fn get_y(self: *Self) f32 {
        return @as(f32, @floatFromInt(self.y_data)) * TLV493D_B_MULT;
    }

    /// Get Z-axis magnetic field
    pub fn get_z(self: *Self) f32 {
        return @as(f32, @floatFromInt(self.z_data)) * TLV493D_B_MULT;
    }

    /// Get temperature in °C
    pub fn get_temp(self: *Self) f32 {
        return (@as(f32, @floatFromInt(self.temp_data)) - TLV493D_TEMP_OFFSET) * TLV493D_TEMP_MULT;
    }

    /// Get magnetic field magnitude
    pub fn get_magnitude(self: *Self) f32 {
        const x = @as(f32, @floatFromInt(self.x_data));
        const y = @as(f32, @floatFromInt(self.y_data));
        const z = @as(f32, @floatFromInt(self.z_data));
        return TLV493D_B_MULT * @sqrt(x * x + y * y + z * z);
    }

    /// Get azimuth angle (atan2(y, x))
    pub fn get_azimuth(self: *Self) f32 {
        return std.math.atan2(@as(f32, @floatFromInt(self.y_data)), @as(f32, @floatFromInt(self.x_data)));
    }

    /// Get polar angle (atan2(z, sqrt(x² + y²)))
    pub fn get_polar(self: *Self) f32 {
        const x = @as(f32, @floatFromInt(self.x_data));
        const y = @as(f32, @floatFromInt(self.y_data));
        const z = @as(f32, @floatFromInt(self.z_data));
        return std.math.atan2(z, @sqrt(x * x + y * y));
    }

    /// Set register bits using mask
    fn set_write_key(self: *Self, mask: RegMask, data: u8) void {
        var current = self.write_data[mask.byte_index];
        current &= ~mask.mask; // Clear bits
        current |= (data << mask.shift) & mask.mask; // Set new bits
        self.write_data[mask.byte_index] = current;
    }

    /// Get register bits using mask
    fn get_reg_bits(self: *Self, mask: RegMask) u8 {
        return (self.read_data[mask.byte_index] & mask.mask) >> mask.shift;
    }

    /// Calculate and set parity bit
    fn calc_parity(self: *Self) void {
        // Set parity bit to 1 initially
        self.set_write_key(get_write_mask(WriteMaskKey.W_PARITY), 1);

        var y: u8 = 0x00;
        // XOR all write data bytes
        for (self.write_data) |byte| {
            y ^= byte;
        }

        // XOR all bits in the combined byte
        y = y ^ (y >> 1);
        y = y ^ (y >> 2);
        y = y ^ (y >> 4);

        // Set parity bit (LSB of y)
        self.set_write_key(get_write_mask(WriteMaskKey.W_PARITY), y & 0x01);
    }

    /// Concatenate register values into 12-bit signed result
    fn concat_results(self: *Self, upper_byte: u8, lower_byte: u8, upper_full: bool) i16 {
        _ = self;
        var value: i16 = 0;

        if (upper_full) {
            value = @as(i16, upper_byte) << 8;
            value |= @as(i16, lower_byte & 0x0F) << 4;
        } else {
            value = @as(i16, upper_byte & 0x0F) << 12;
            value |= @as(i16, lower_byte) << 4;
        }

        // Shift right to get signed 12-bit integer
        return value >> 4;
    }
};
