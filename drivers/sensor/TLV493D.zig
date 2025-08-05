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
pub const TLV493D_ADDRESS0: u8 = 0x1F;
pub const TLV493D_ADDRESS1: u8 = 0x5E; // Default

/// Startup delay in milliseconds
pub const TLV493D_STARTUPDELAY_MS: u32 = 40;

/// Conversion factors
pub const TLV493D_B_MULT: f32 = 0.098; // mT per LSB
pub const TLV493D_TEMP_MULT: f32 = 1.1; // °C per LSB
pub const TLV493D_TEMP_OFFSET = 340; // Temperature offset (in LSB)

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

const ReadRegister = packed struct(u80) {
    // Bx (0x0) - Bx[11:4]
    BxH: u8,
    // By (0x1) - By[11:4]
    ByH: u8,
    // Bz (0x2) - Bz[11:4]
    BzH: u8,
    // Temp (0x3) - bits 1:0=CH, bits 3:2=FRM, bits 7:4=Temp[11:8]
    // -- CHANNEL should read 0. Means conversion is complete and read is valid
    CHANNEL: u2,
    FRAMECOUNTER: u2,
    TEMPH: u4,
    // Bx2 (0x4) - bits 3:0=By[3:0], bits 7:4=Bx[3:0]
    ByL: u4,
    BxL: u4,
    // Bz2 (0x5) - bits 3:0=Bz[3:0], bit 4=PD, bit 5=FF, bit 6=T, bit 7=Reserved
    BzL: u4,
    // -- Should be 1. Power down flag
    PD: u1,
    // -- Should be 1. Fuse parity check
    FF: u1,
    // -- Should be 0. Test mode
    T: u1,
    reserved47: u1,
    // Temp2 (0x6) - Temp[7:0]
    TEMPL: u8,
    // FactSet1 (0x7) - Reserved
    // -- Bits 6:3 must be saved into register 1
    // -- NOTE: Doc must have a bug, we only have 2 bits in register 1
    reserved60: u8,
    // FactSet2 (0x8) - Reserved
    // -- Bits 7:0 must be written into register 2
    reserved68: u8,
    // FactSet3 (0x9) - Reserved
    // -- Bits 4:0 must be written into register 3
    reserved76: u8,
};

const WriteRegister = packed struct(u32) {
    // Res (0x0) - Reserved
    reserved0: u8,
    // MOD1 (0x1) - bit 0=LOW, bit 1=FAST, bit 2=INT, bits 4:3=Reserved, bits 6:5=I2CAddr, bit 7=P
    LOWPOWER: u1,
    FAST: u1,
    INT: u1,
    // -- Must store bits 4:3 from register 7
    reserved11: u2,
    // -- Used to set slave address for extra devices (up to 8 total). Seems to set bits 4 and 2
    // to the complement of bit 1 and 0, respectivly
    I2C_ADDR: u2,
    PARITY: u1,
    // Res (0x2) - Reserved
    // -- Must store register 8
    reserved16: u8,
    // MOD2 (0x3) - bits 4:0=Reserved, bit 5=PT, bit 6=LP, bit 7=T
    // -- Must store bits 4:00 from register 9
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
    // POWERDOWNMODE: Can write configuration, but measurements are not taken
    .{ .fast = 0, .lp = 0, .lp_period = 0, .measurement_time = 1000 },
    .{ .fast = 1, .lp = 0, .lp_period = 0, .measurement_time = 1 }, // FASTMODE
    .{ .fast = 0, .lp = 1, .lp_period = 0, .measurement_time = 10 }, // LOWPOWERMODE
    .{ .fast = 0, .lp = 1, .lp_period = 1, .measurement_time = 100 }, // ULTRALOWPOWERMODE
    // MASTERCONTROLLEDMODE: Measurements are made after the last value is read
    .{ .fast = 1, .lp = 1, .lp_period = 0, .measurement_time = 1 },
};

pub const TLV493D = struct {
    const Self = @This();

    dev: Datagram_Device,
    clock: Clock_Device,
    config: Config,
    read_data: ReadRegister,
    write_data: WriteRegister,
    x_data: i12 = 0,
    y_data: i12 = 0,
    z_data: i12 = 0,
    temp_data: i12 = 0,
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

        // The first thing we have to do is read out the factory calibration and pack it into the
        // write register so that we don't clear it on the first write.
        self.setup_write_buffer() catch return Error.BusError;

        // Sleep for startup delay
        // TODO: Needed?
        self.clock.sleep_ms(TLV493D_STARTUPDELAY_MS);

        // Reset sensor if requested
        if (config.reset)
            try self.reset_sensor();

        // Get all register data from sensor
        try self.read_out();

        // We must set the mode, as it powers up in power-down mode.
        try self.set_access_mode(self.mode);

        if (config.enable_temp)
            try self.enable_temp();

        return self;
    }

    fn setup_write_buffer(self: *Self) !void {
        try self.read_out();

        // Section 5.2 of the user manual:
        // > After that byte 7, 8 & 9 have to be read out at least one time and stored for later use
        // > by the user. This is necessary for any write command later on in order not to change
        // > the internal configurations accidentally. This means, that the bits transferred at any
        // > write command and not used for configuration, needs to be set to the same values as you
        // > read them out before, otherwise configuration will be changed
        // Section 7 explains how the read registers map to the write registers.
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
        // TODO: To do this we have to write to the i2c address 0, which we can't do with a datagram
        // device.
        // On startup the SDA line is sampled. If the line is high, it will listen on address 0x5E.
        // Otherwise, it will listen on 0x1F. The line must be kept stable for 200us.
        // Because we shouldn't be touching the line that early, and SDA is pulled high, it should
        // be assigned 0x5E, but it is better if we can explicitly set it.
        // We can explicitly set the address by writing either 0xFF ox 0x00 to address 0
        // var reset_data: [1]u8 = undefined;
        // if (self.config.addr == TLV493D_ADDRESS1)
        //     reset_data[0] = 0xFF // Set SDA high for address 0x5E
        // else
        //     reset_data[0] = 0x00; // Set SDA low for address 0x1F
        // self.dev.writev(&.{&reset_data}) catch return Error.DatagramError;

        // Send recovery frame, clearing bad state
        self.dev.writev(&.{&.{0xFF}}) catch return Error.DatagramError;
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
        self.x_data = @as(i12, self.read_data.BxH) << 4 | self.read_data.BxL;
        self.y_data = @as(i12, self.read_data.ByH) << 4 | self.read_data.ByL;
        self.z_data = @as(i12, self.read_data.BzH) << 4 | self.read_data.BzL;
        self.temp_data = @as(i12, self.read_data.TEMPH) << 8 | self.read_data.TEMPL;

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
            .temp = (@as(f32, @floatFromInt(self.temp_data - TLV493D_TEMP_OFFSET))) * TLV493D_TEMP_MULT,
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
};
