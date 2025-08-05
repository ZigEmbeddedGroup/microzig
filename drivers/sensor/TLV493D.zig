//!
//! Generic driver for the Infineon TLV493D 3D magnetic sensor.
//!
//! Datasheet:
//! * https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
//! * https://www.infineon.com/dgdl/Infineon-TLV493D-A1B6_3DMagnetic-UM-v01_03-EN.pdf?fileId=5546d46261d5e6820161e75721903ddd
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
    enable_temp: bool = false,
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

// TODO: Ensure the order is as expected
const ReadRegister = packed struct(u80) {
    BX1: u8,
    BY1: u8,
    BZ1: u8,
    CHANNEL: u2,
    FRAMECOUNTER: u2,
    TEMP1: u4,
    BY2: u4,
    BX2: u4,
    BZ2: u4,
    PD: u1,
    FF: u1,
    T: u1,
    reserved47: u1,
    TEMP2: u8,
    reserved60: u8,
    reserved68: u8,
    reserved76: u8,
};

const WriteRegister = packed struct(u32) {
    reserved0: u8,
    LOWPOWER: u1,
    FAST: u1,
    INT: u1,
    reserved11: u2,
    I2C_ADDR: u2,
    PARITY: u1,
    reserved16: u8,
    reserved24: u5,
    PARITY_EN: u1,
    LP_PERIOD: u1,
    TEMP_NEN: u1,
};

/// Access modes for the sensor
pub const AccessMode = enum(u8) {
    powerdown = 0,
    fast = 1,
    low_power = 2,
    ultra_low_power = 3,
    master_controlled = 4,
};

/// Access mode configuration
const AccessModeConfig = struct {
    fast: u1,
    lp: u1,
    lp_period: u1,
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
    read_data: ReadRegister,
    write_data: WriteRegister,
    x_data: i16 = 0,
    y_data: i16 = 0,
    z_data: i16 = 0,
    temp_data: i16 = 0,
    mode: AccessMode,
    expected_frame_count: u8,

    /// Create a new TLV493D instance
    pub fn init(dev: Datagram_Device, clock: Clock_Device, config: Config) Error!Self {
        var self = Self{
            .dev = dev,
            .clock = clock,
            .config = config,
            .read_data = @bitCast([_]u8{0} ** 10),
            .write_data = @bitCast([_]u8{0} ** 4),
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

        if (config.enable_temp)
            try self.enable_temp();

        return self;
    }

    fn setup_write_buffer(self: *Self) !void {
        try self.read_out();

        // I am not sure why (or if) this is needed. The Adafruit CircuitPython driver reads out
        // everything and copies a bunch of reserved bits into the write register. See
        // https://github.com/adafruit/Adafruit_CircuitPython_TLV493D/blob/2.0.9/adafruit_tlv493d.py#L141-L145
        self.write_data.reserved11 = @truncate((self.read_data.reserved60 & 0x18) >> 3);
        self.write_data.reserved16 = self.read_data.reserved68;
        self.write_data.reserved24 = @truncate(self.read_data.reserved76 & 0x1F);
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
        // Due to padding on the structure, the slice is 16 bytes long, so we have to slice it to 10
        const bytes_read = self.dev.readv(&.{std.mem.asBytes(&self.read_data)[0..10]}) catch return Error.DatagramError;
        if (bytes_read != 10) return Error.InvalidData;
    }

    /// Write configuration to sensor
    fn write_out(self: *Self) Error!void {
        self.dev.writev(&.{std.mem.asBytes(&self.write_data)}) catch return Error.DatagramError;
    }

    /// Set access mode
    pub fn set_access_mode(self: *Self, mode: AccessMode) Error!void {
        const mode_config = &ACCESS_MODE_CONFIGS[@intFromEnum(mode)];

        self.write_data.FAST = mode_config.fast;
        self.write_data.LOWPOWER = mode_config.lp;
        self.write_data.LP_PERIOD = mode_config.lp_period;

        self.calc_parity();
        try self.write_out();

        self.mode = mode;
    }

    /// Enable interrupt
    pub fn enable_interrupt(self: *Self) Error!void {
        self.write_data.INT = 1;
        self.calc_parity();
        try self.write_out();
    }

    /// Disable interrupt
    pub fn disable_interrupt(self: *Self) Error!void {
        self.write_data.INT = 0;
        self.calc_parity();
        try self.write_out();
    }

    /// Enable temperature measurement
    /// Note that according to the datasheet, we can save 25% of power consumption by keeping this
    /// turned off.
    pub fn enable_temp(self: *Self) Error!void {
        self.write_data.TEMP_NEN = 0;
        self.calc_parity();
        try self.write_out();
    }

    /// Disable temperature measurement
    pub fn disable_temp(self: *Self) Error!void {
        self.write_data.TEMP_NEN = 1;
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

        // Construct results from registers
        self.x_data = self.concat_results(self.read_data.BX1, self.read_data.BX2, true);
        self.y_data = self.concat_results(self.read_data.BY1, self.read_data.BY2, true);
        self.z_data = self.concat_results(self.read_data.BZ1, self.read_data.BZ2, true);
        self.temp_data = self.concat_results(self.read_data.TEMP1, self.read_data.TEMP2, false);

        // Switch sensor back to POWERDOWNMODE if it was in POWERDOWNMODE before
        if (powerdown)
            self.set_access_mode(AccessMode.powerdown) catch return Error.BusError;

        // Check for frame errors
        if (self.read_data.CHANNEL != 0)
            return Error.FrameError;

        self.expected_frame_count = self.read_data.FRAMECOUNTER;
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
        const x: f32 = @floatFromInt(self.x_data);
        const y: f32 = @floatFromInt(self.y_data);
        const z: f32 = @floatFromInt(self.z_data);
        return TLV493D_B_MULT * @sqrt(x * x + y * y + z * z);
    }

    /// Get azimuth angle (atan2(y, x))
    pub fn get_azimuth(self: *Self) f32 {
        return std.math.atan2(@as(f32, @floatFromInt(self.y_data)), @as(f32, @floatFromInt(self.x_data)));
    }

    /// Get polar angle (atan2(z, sqrt(x² + y²)))
    pub fn get_polar(self: *Self) f32 {
        const x: f32 = @floatFromInt(self.x_data);
        const y: f32 = @floatFromInt(self.y_data);
        const z: f32 = @floatFromInt(self.z_data);
        return std.math.atan2(z, @sqrt(x * x + y * y));
    }

    /// Calculate and set parity bit
    fn calc_parity(self: *Self) void {
        // Set parity bit to 1 initially
        self.write_data.PARITY = 1;

        var y: u8 = 0x00;
        // XOR all write data bytes
        for (std.mem.asBytes(&self.write_data)) |byte| {
            y ^= byte;
        }

        // XOR all bits in the combined byte
        y = y ^ (y >> 1);
        y = y ^ (y >> 2);
        y = y ^ (y >> 4);

        // Set parity bit (LSB of y)
        self.write_data.PARITY = @truncate(y & 0x01);
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
