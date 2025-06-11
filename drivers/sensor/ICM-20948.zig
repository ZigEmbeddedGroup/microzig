//!
//! Generic driver for the TDK ICM-20948 9-axis motion tracker
//!
//! Datasheet:
//! * https://invensense.tdk.com/wp-content/uploads/2024/03/DS-000189-ICM-20948-v1.6.pdf
//!
//! Example usage:
//! ```zig
//! var sensor = try ICM_20948.init(
//!     i2c_device.datagram_device(),
//!     clock.clock_device(),
//!     .{
//!         .accel_range = .gs4,
//!         .gyro_range = .dps1000,
//!         .accel_dlp = .@"50Hz",
//!     },
//! );
//! try sensor.setup();
//!
//! while (true) {
//!     const data = try sensor.get_all_sensor_data();
//!     // Process data...
//! }
//! ```
//!
//! TODO:
//! * Add support for magnetometer
//! * Allow configuring the unit of the readings (Gs vs m/s^2, degrees vs. radians, C vs F)
//! * Test/ensure support for SPI datagram devices (need to set r/w bit in register address)
//! * Add support for calibration/bias correction
//!   * In the accelerometer
//!   * In the gyroscope
//!

const std = @import("std");
const mdf = @import("../framework.zig");

const log = struct {
    const builtin = @import("builtin");
    fn debug(comptime format: []const u8, args: anytype) void {
        if (!builtin.is_test)
            std.log.debug(format, args);
    }

    fn err(comptime format: []const u8, args: anytype) void {
        if (!builtin.is_test)
            std.log.err(format, args);
    }
};

pub const ICM_20948 = struct {
    const Self = @This();

    const WHOAMI = 0xEA;
    const BANK_SWITCH_DELAY_US = 25;
    const REGISTER_WRITE_DELAY_US = 2;
    const REGISTER_READ_DELAY_US = 2;
    const RESET_DELAY_US = 100_000;

    const MAG_WHOAMI = 0x09;
    const MAG_ADDRESS = 0x0C;
    const MAG_WRITE_DELAY_US = 10_000;
    const MAG_RESET_DELAY_US = 100_000;

    dev: mdf.base.Datagram_Device,
    clock: mdf.base.Clock_Device,
    config: Config,
    current_bank: ?u2 = null,
    slave_address: u8 = 0,

    pub const Error = error{
        // Device identification errors
        DeviceNotFound,
        UnexpectedDeviceId,

        // Communication errors
        CommunicationTimeout,
        ReadError,
        WriteError,

        // Device state errors
        DeviceNotReady,
        ResetFailed,
        SetupFailed,
        BankSwitchFailed,

        InvalidParameter,
    };

    const Register = union(enum) {
        bank0: enum(u8) {
            who_am_i = 0x00,
            user_ctrl = 0x03,
            lp_config = 0x05,
            pwr_mgmt_1 = 0x06,
            pwr_mgmt_2 = 0x07,
            int_pin_cfg = 0x0F,
            int_enable = 0x10,
            int_enable_1 = 0x11,
            int_enable_2 = 0x12,
            int_enable_3 = 0x13,
            i2c_mst_status = 0x17,
            int_status = 0x19,
            int_status_1 = 0x1A,
            int_status_2 = 0x1B,
            int_status_3 = 0x1C,
            delay_time_h = 0x28,
            delay_time_l = 0x29,
            accel_xout_h = 0x2D,
            accel_xout_l = 0x2E,
            accel_yout_h = 0x2F,
            accel_yout_l = 0x30,
            accel_zout_h = 0x31,
            accel_zout_l = 0x32,
            gyro_xout_h = 0x33,
            gyro_xout_l = 0x34,
            gyro_yout_h = 0x35,
            gyro_yout_l = 0x36,
            gyro_zout_h = 0x37,
            gyro_zout_l = 0x38,
            temp_out_h = 0x39,
            temp_out_l = 0x3A,
            // 24 of these
            ext_slv_sens_data_00 = 0x3B,

            reg_bank_sel = 0x7F,
        },
        bank1: enum(u8) {
            self_test_x_gyro = 0x02,
            self_test_y_gyro = 0x03,
            self_test_z_gyro = 0x04,
            self_test_x_accel = 0x0E,
            self_test_y_accel = 0x0F,
            self_test_z_accel = 0x10,
            xa_offs_h = 0x14,
            ya_offs_h = 0x17,
            za_offs_h = 0x1A,
            TimebaseCorrectionPll = 0x28,
        },
        bank2: enum(u8) {
            gyro_smplrt_div = 0x00,
            gyro_config_1 = 0x01,
            gyro_config_2 = 0x02,
            xg_offs_usrh = 0x03,
            yg_offs_usrh = 0x05,
            zg_offs_usrh = 0x07,
            odr_align_en = 0x09,
            accel_smplrt_div_1 = 0x10,
            accel_smplrt_div_2 = 0x11,
            accel_intel_ctrl = 0x12,
            accel_wom_thr = 0x13,
            accel_config = 0x14,
            accel_config_2 = 0x15,
            fsing_config = 0x52,
            temp_config = 0x53,
            mod_ctrl_usr = 0x54,
        },
        bank3: enum(u8) {
            i2c_mst_odr_config = 0x00,
            i2c_mst_ctrl = 0x01,
            i2c_mst_delay_ctrl = 0x02,
            i2c_slv0_addr = 0x03,
            i2c_slv0_reg = 0x04,
            i2c_slv0_ctrl = 0x05,
            i2c_slv0_do = 0x06,
        },
        inline fn value(self: @This()) u8 {
            // This peels off the outer union to get access to the inner enum
            return switch (self) {
                inline else => |e| @intFromEnum(e),
            };
        }
        inline fn bank(self: @This()) u2 {
            return switch (self) {
                .bank0 => 0,
                .bank1 => 1,
                .bank2 => 2,
                .bank3 => 3,
            };
        }
    };

    const MagRegister = enum(u8) {
        comp_id = 0x00, // DELETEME
        device_id = 0x01,
        status1 = 0x10,
        // xl, xh, yl, yh, zl, zh
        hxl = 0x11,
        status_2 = 0x18,
        control2 = 0x31,
        control3 = 0x32,
        test_1 = 0x33,
        test_2 = 0x34,
    };

    const Config = struct {
        // TODO: Fields to enable each part and only configure what we need. Put the rest in low power mode
        accel_range: enum(u2) {
            gs2 = 0,
            gs4 = 1,
            gs8 = 2,
            gs16 = 3,

            fn scalar(self: @This()) f32 {
                // TODO: Support converting to Gs
                _ = self;
                return 9.81;
            }

            fn divisor(self: @This()) f32 {
                return switch (self) {
                    .gs2 => @as(f32, std.math.maxInt(i16)) / 2.0,
                    .gs4 => @as(f32, std.math.maxInt(i16)) / 4.0,
                    .gs8 => @as(f32, std.math.maxInt(i16)) / 8.0,
                    .gs16 => @as(f32, std.math.maxInt(i16)) / 16.0,
                };
            }
        } = .gs2,

        gyro_range: enum(u2) {
            dps250 = 0,
            dps500 = 1,
            dps1000 = 2,
            dps2000 = 3,

            fn scalar(self: @This()) f32 {
                // TODO: Support converting to radians
                _ = self;
                return 1.0;
            }

            fn divisor(self: @This()) f32 {
                return switch (self) {
                    .dps250 => @as(f32, std.math.maxInt(i16)) / 250.0,
                    .dps500 => @as(f32, std.math.maxInt(i16)) / 500.0,
                    .dps1000 => @as(f32, std.math.maxInt(i16)) / 1000.0,
                    .dps2000 => @as(f32, std.math.maxInt(i16)) / 2000.0,
                };
            }
        } = .dps1000,

        accel_dlp: enum(u4) {
            @"473Hz" = 7,
            @"246Hz" = 1,
            @"111Hz" = 2,
            @"50Hz" = 3,
            @"24Hz" = 4,
            @"12Hz" = 5,
            @"6Hz" = 6,
            disabled = 8,
        } = .disabled,

        gyro_dlp: enum(u4) {
            @"361Hz" = 7,
            @"197Hz" = 0,
            @"152Hz" = 1,
            @"120Hz" = 2,
            @"51Hz" = 3,
            @"24Hz" = 4,
            @"12Hz" = 5,
            @"6Hz" = 6,
            disabled = 8,
        } = .disabled,

        // ODR (output data rate) is computed as: 1125Hz / (1 + ACCEL_SMPLRT_DIV)
        accel_odr_div: u12 = 0,
        // ODR = 1100 / (1 + GYRO_SMPLRT_DIV)
        gyro_odr_div: u8 = 0,
    };

    const user_ctrl = packed struct(u8) {
        reserved_0: u1,
        I2C_MST_RST: u1,
        SRAM_RST: u1,
        DMP_RST: u1,
        I2C_IF_DIS: u1,
        I2C_MST_EN: u1,
        FIFO_EN: u1,
        DMP_EN: u1,
    };

    const pwr_mgmt_1 = packed struct(u8) {
        CLKSEL: u3 = 0,
        TEMP_DIS: u1 = 0,
        reserved_4: u1 = 0,
        LP_EN: bool = false,
        SLEEP: bool = false,
        DEVICE_RESET: bool = false,
    };

    const pwr_mgmt_2 = packed struct(u8) {
        DISABLE_GYRO: enum(u3) { disable = 0b111, enable = 0b000 } = .enable,
        DISABLE_ACCEL: enum(u3) { disable = 0b111, enable = 0b000 } = .enable,
        reserved_6: u2 = 0,
    };

    const lp_config = packed struct(u8) {
        reserved_0: u3,
        GYRO_CYCLE: u1,
        ACCEL_CYCLE: u1,
        I2C_MST_CYCLE: u2,
        reserved_7: u1,
    };

    // TODO: We probably don't need this defined right now, we only set the clock
    const i2c_mst_ctrl = packed struct(u8) {
        i2c_mst_clk: u4 = 0,
        i2c_mst_p_nsr: u1 = 0,
        reserved_5: u2 = 0,
        mult_mst_en: u1 = 0,
    };

    const i2c_slv0_ctrl = packed struct(u8) {
        i2c_slv0_leng: u4 = 0,
        i2c_slv0_grp: u1 = 0,
        i2c_slv0_reg_dis: u1 = 0,
        i2c_lsv0_byte_sw: u1 = 0,
        i2c_slv0_en: u1 = 0,
    };

    pub fn init(dev: mdf.base.Datagram_Device, clock: mdf.base.Clock_Device, config: Config) Error!Self {
        return Self{ .dev = dev, .clock = clock, .config = config };
    }

    pub fn setup(self: *Self) Error!void {
        self.reset() catch |err| {
            log.err("Failed to reset device: {}", .{err});
            return Error.ResetFailed;
        };

        // Verify device identity
        const id = self.read_byte(.{ .bank0 = .who_am_i }) catch |err| {
            log.err("Failed to read device ID: {}", .{err});
            return Error.DeviceNotFound;
        };

        if (id != WHOAMI) {
            log.err("Unexpected device ID: expected 0x{X:02}, got 0x{X:02}", .{ WHOAMI, id });
            return Error.UnexpectedDeviceId;
        }

        self.set_clocks() catch |err| {
            log.err("Failed to set clocks: {}", .{err});
            return Error.SetupFailed;
        };

        self.low_power(false) catch |err| {
            log.err("Failed to configure low power mode: {}", .{err});
            return Error.SetupFailed;
        };

        // This sets DLPF as well as full scale and enables the devices
        self.configure_accelerometer(self.config) catch |err| {
            log.err("Failed to configure accelerometer: {}", .{err});
            return Error.SetupFailed;
        };

        self.configure_gyroscope(self.config) catch |err| {
            log.err("Failed to configure gyroscope: {}", .{err});
            return Error.SetupFailed;
        };

        self.configure_magnetometer(self.config) catch |err| {
            log.err("Failed to configure magnetometer: {}", .{err});
            return Error.SetupFailed;
        };

        self.set_sample_mode() catch |err| {
            log.err("Failed to set sample mode: {}", .{err});
            return Error.SetupFailed;
        };
    }

    /// Check if the device is responsive by reading the WHO_AM_I register
    pub fn is_device_responsive(self: *Self) bool {
        const id = self.read_byte(.{ .bank0 = .who_am_i }) catch return false;
        return id == WHOAMI;
    }

    /// Perform a basic device health check
    pub fn health_check(self: *Self) Error!void {
        // Check device identity
        if (!self.is_device_responsive())
            return Error.DeviceNotFound;

        // Try reading some basic registers to ensure communication is working
        _ = self.read_byte(.{ .bank0 = .pwr_mgmt_1 }) catch |err| {
            log.err("Health check failed: cannot read power management register: {}", .{err});
            return Error.DeviceNotReady;
        };

        log.debug("Device health check passed", .{});
    }

    pub inline fn read_register(self: *Self, reg: Self.Register, buf: []u8) Error!void {
        if (buf.len == 0) return Error.InvalidParameter;

        try self.set_bank(reg.bank());

        self.dev.writev_then_readv(&.{&.{reg.value()}}, &.{buf}) catch |err| {
            log.err("Failed to read register 0x{X:02}: {}", .{ reg.value(), err });
            return Error.ReadError;
        };

        self.clock.sleep_us(REGISTER_READ_DELAY_US);
    }

    pub inline fn read_byte(self: *Self, reg: Self.Register) Error!u8 {
        var buf: [1]u8 = undefined;
        try self.read_register(reg, &buf);
        return buf[0];
    }

    pub inline fn write_byte(self: *Self, reg: Self.Register, val: u8) Error!void {
        try self.set_bank(reg.bank());

        self.dev.write(&.{ reg.value(), val }) catch |err| {
            log.err("Failed to write register 0x{X:02} = 0x{X:02}: {}", .{ reg.value(), val, err });
            return Error.WriteError;
        };

        self.clock.sleep_us(REGISTER_WRITE_DELAY_US);
    }

    /// Read the register and modify the matching fields as provided
    pub inline fn modify_register(self: *Self, reg: Self.Register, reg_t: type, fields: anytype) Error!void {
        // Read the current value
        const current_val = self.read_byte(reg) catch |err| {
            log.err("Failed to read register 0x{X:02} for modification: {}", .{ reg.value(), err });
            return err;
        };

        // Cast to the correct type and modify the named fields
        var val: reg_t = @bitCast(current_val);
        inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
            @field(val, field.name) = @field(fields, field.name);
        }

        // Write back the modified value
        self.write_byte(reg, @bitCast(val)) catch |err| {
            log.err("Failed to write modified register 0x{X:02}: {}", .{ reg.value(), err });
            return err;
        };
    }

    /// Set the register bank for the next read/write. This device tracks which bank was last set to
    /// avoid having to set it continuously when using registers in the same bank.
    pub inline fn set_bank(self: *Self, comptime bank: u2) Error!void {
        // Avoid a write if we are already on the correct bank
        if (bank == self.current_bank) return;

        // Bits 5:4 - directly write to bank0 register without recursion
        self.dev.write(&.{ 0x7F, @as(u8, bank) << 4 }) catch |err| {
            log.err("Failed to switch to bank {}: {}", .{ bank, err });
            return Error.BankSwitchFailed;
        };

        self.clock.sleep_us(BANK_SWITCH_DELAY_US);
        self.current_bank = bank;
    }

    pub fn reset(self: *Self) Error!void {
        log.debug("Resetting ICM-20948", .{});

        // Reset the current bank cache since we're resetting the device
        self.current_bank = null;
        // Reset the slave address as well
        self.slave_address = 0;

        self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{ .DEVICE_RESET = true }) catch
            return Error.ResetFailed;

        // Sleep longer after reset to ensure device is ready
        self.clock.sleep_us(RESET_DELAY_US);

        // Clear the bank cache after reset
        self.current_bank = null;
    }

    pub fn sleep(self: *Self, on: bool) Error!void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{ .SLEEP = on });
    }

    pub fn low_power(self: *Self, on: bool) Error!void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{ .LP_EN = on });
    }

    pub fn set_clocks(self: *Self) Error!void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{
            // 1 = Auto select
            .CLKSEL = 1,
            .SLEEP = false,
            .DEVICE_RESET = false,
        });
    }

    pub fn set_sample_mode(self: *Self) Error!void {
        // TODO: Support setting these individually. Could set based on if ODR fields are set (make
        // optional?)
        // TODO: Apparently the mst_odr_config does not matter when accel or gyro are enabled, it
        // just uses gyro or accel (in that order)
        try self.modify_register(.{ .bank0 = .lp_config }, lp_config, .{
            .I2C_MST_CYCLE = 1, // ENABLE? i2c master duty cycle
            .ACCEL_CYCLE = 1, // Duty cycle mode, use ACCEL_SMPLRT_DIV
            .GYRO_CYCLE = 1, // Duty cycle mode, use GYRO_SMPLTR_DIV
        });
    }

    pub fn configure_accelerometer(self: *Self, config: Config) Error!void {
        const reg = packed struct(u8) {
            ACCEL_FCHOICE: u1,
            ACCEL_FS_SEL: u2,
            ACCEL_DLPFCFG: u3,
            reserved_6: u2 = 0,
        }{
            .ACCEL_FCHOICE = if (config.accel_dlp == .disabled) 0 else 1,
            .ACCEL_FS_SEL = @intFromEnum(config.accel_range),
            .ACCEL_DLPFCFG = @truncate(@intFromEnum(config.accel_dlp)),
        };

        try self.write_byte(.{ .bank2 = .accel_config }, @bitCast(reg));

        try self.write_byte(
            .{ .bank2 = .accel_smplrt_div_1 },
            @truncate(config.accel_odr_div >> 8),
        );
        try self.write_byte(
            .{ .bank2 = .accel_smplrt_div_2 },
            @truncate(config.accel_odr_div),
        );
    }

    pub fn disable_accelerometer(self: *Self) Error!void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_2 }, pwr_mgmt_2, .{
            .DISABLE_ACCEL = .disable,
        });
    }

    const Accel_data_unscaled = struct {
        x: i16 = 0,
        y: i16 = 0,
        z: i16 = 0,
    };

    pub fn get_accel_data_unscaled(self: *Self) Error!Accel_data_unscaled {
        var raw_data: Accel_data_unscaled = .{};

        self.read_register(.{ .bank0 = .accel_xout_h }, std.mem.asBytes(&raw_data)) catch |err| {
            log.err("Failed to read accelerometer data: {}", .{err});
            return err;
        };

        return .{
            .x = std.mem.bigToNative(i16, raw_data.x),
            .y = std.mem.bigToNative(i16, raw_data.y),
            .z = std.mem.bigToNative(i16, raw_data.z),
        };
    }

    const Accel_data = struct {
        x: f32 = 0,
        y: f32 = 0,
        z: f32 = 0,
    };

    pub fn get_accel_data(self: *Self) Error!Accel_data {
        const unscaled_data = try self.get_accel_data_unscaled();
        const scalar_val = self.accel_scalar();

        return .{
            .x = @as(f32, @floatFromInt(unscaled_data.x)) * scalar_val,
            .y = @as(f32, @floatFromInt(unscaled_data.y)) * scalar_val,
            .z = @as(f32, @floatFromInt(unscaled_data.z)) * scalar_val,
        };
    }

    fn accel_scalar(self: *Self) f32 {
        return self.config.accel_range.scalar() / self.config.accel_range.divisor();
    }

    pub fn configure_gyroscope(self: *Self, config: Config) Error!void {
        const reg = packed struct(u8) {
            GYRO_FCHOICE: u1,
            GYRO_FS_SEL: u2,
            GYRO_DLPFCFG: u3,
            reserved_6: u2 = 0,
        }{
            .GYRO_FCHOICE = if (config.gyro_dlp == .disabled) 0 else 1,
            .GYRO_FS_SEL = @intFromEnum(config.gyro_range),
            .GYRO_DLPFCFG = @truncate(@intFromEnum(config.gyro_dlp)),
        };

        try self.write_byte(.{ .bank2 = .gyro_config_1 }, @bitCast(reg));
        try self.write_byte(.{ .bank2 = .gyro_smplrt_div }, config.gyro_odr_div);
    }

    pub fn disable_gyroscope(self: *Self) Error!void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_2 }, pwr_mgmt_2, .{
            .DISABLE_GYRO = .disable,
        });
    }

    const Gyro_data_unscaled = struct {
        x: i16 = 0,
        y: i16 = 0,
        z: i16 = 0,
    };

    pub fn get_gyro_data_unscaled(self: *Self) Error!Gyro_data_unscaled {
        var raw_data: Gyro_data_unscaled = .{};

        self.read_register(.{ .bank0 = .gyro_xout_h }, std.mem.asBytes(&raw_data)) catch |err| {
            log.err("Failed to read gyroscope data: {}", .{err});
            return err;
        };

        return .{
            .x = std.mem.bigToNative(i16, raw_data.x),
            .y = std.mem.bigToNative(i16, raw_data.y),
            .z = std.mem.bigToNative(i16, raw_data.z),
        };
    }

    const Gyro_data = struct {
        x: f32 = 0,
        y: f32 = 0,
        z: f32 = 0,
    };

    pub fn get_gyro_data(self: *Self) Error!Gyro_data {
        const unscaled_data = try self.get_gyro_data_unscaled();
        const scalar_val = self.gyro_scalar();

        return .{
            .x = @as(f32, @floatFromInt(unscaled_data.x)) * scalar_val,
            .y = @as(f32, @floatFromInt(unscaled_data.y)) * scalar_val,
            .z = @as(f32, @floatFromInt(unscaled_data.z)) * scalar_val,
        };
    }

    fn gyro_scalar(self: *Self) f32 {
        return self.config.gyro_range.scalar() / self.config.gyro_range.divisor();
    }

    const SixDofData = struct {
        accel: Accel_data,
        gyro: Gyro_data,
    };

    pub fn get_accel_gyro_data(self: *Self) Error!SixDofData {
        var raw_data = packed struct {
            ax: i16 = 0,
            ay: i16 = 0,
            az: i16 = 0,
            gx: i16 = 0,
            gy: i16 = 0,
            gz: i16 = 0,
        }{};

        self.read_register(.{ .bank0 = .accel_xout_h }, std.mem.asBytes(&raw_data)) catch |err| {
            log.err("Failed to read combined accel/gyro data: {}", .{err});
            return err;
        };

        const accel_scalar_val = self.accel_scalar();
        const gyro_scalar_val = self.gyro_scalar();

        return .{ .accel = .{
            .x = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.ax))) * accel_scalar_val,
            .y = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.ay))) * accel_scalar_val,
            .z = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.az))) * accel_scalar_val,
        }, .gyro = .{
            .x = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.gx))) * gyro_scalar_val,
            .y = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.gy))) * gyro_scalar_val,
            .z = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.gz))) * gyro_scalar_val,
        } };
    }

    pub fn get_temp(self: *Self) Error!f32 {
        var raw_data: i16 = undefined;

        self.read_register(.{ .bank0 = .temp_out_h }, std.mem.asBytes(&raw_data)) catch |err| {
            log.err("Failed to read temperature data: {}", .{err});
            return err;
        };

        const temp_raw = std.mem.bigToNative(i16, raw_data);
        // Temperature conversion formula from datasheet:
        // Temp_degC = (TEMP_OUT - RoomTemp_Offset)/Temp_Sensitivity + 21°C
        // Where Temp_Sensitivity = 333.87 LSB/°C and RoomTemp_Offset is typically 0
        const temp_celsius = @as(f32, @floatFromInt(temp_raw)) / 333.87 + 21.0;

        return temp_celsius;
    }

    pub fn configure_magnetometer(self: *Self, config: Config) Error!void {
        _ = config;
        // const mag_id = try self.mag_read_byte(.device_id);
        // if (mag_id != MAG_WHOAMI) {
        //     log.err("Unexpected magnetometer device ID: expected 0x{X:02}, got 0x{X:02}", .{ MAG_WHOAMI, mag_id });
        //     return error.SetupFailed;
        // }
        // NOTE: Trying to set odr align for some reason
        try self.write_byte(.{ .bank2 = .odr_align_en }, 1);
        // Setup this device's I2C master speed at recommended 345.60kHz
        // Disable passthrough
        //
        // TODO: I just tried nsr for shits n giggles.
        // Enable slave delay for slave 0
        try self.write_byte(.{ .bank3 = .i2c_mst_delay_ctrl }, 1);
        // Set master odr? Probably isn't used unless the other sensors are disabled
        // 1.1kHz/2^(config)
        try self.write_byte(
            .{ .bank3 = .i2c_mst_odr_config },
            0,
        );

        // Enable I2C master on this device
        try self.modify_register(.{ .bank0 = .user_ctrl }, user_ctrl, .{ .I2C_MST_EN = 1 });
        // Read it back // DELETEME
        const usr_ctrl = try self.read_byte(.{ .bank0 = .user_ctrl }); // DELETEME
        log.err("User ctrl {x}", .{usr_ctrl}); // DELETEME

        // Set slave address to address of the magnetometer
        try self.write_byte(.{ .bank3 = .i2c_slv0_addr }, MAG_ADDRESS | 0x80); // set read should do
        // it
        const reg = i2c_mst_ctrl{ .i2c_mst_p_nsr = 1, .i2c_mst_clk = 7, .mult_mst_en = 1 };
        try self.write_byte(.{ .bank3 = .i2c_mst_ctrl }, @bitCast(reg));
        // try self.write_byte(.{ .bank3 = .i2c_mst_ctrl }, 0x4D);

        // Reset to known-good state
        try self.mag_reset();

        // Check master status
        //   DELETEME>>
        const v = try self.read_byte(.{ .bank0 = .i2c_mst_status });
        log.err("Master status {x}", .{v});
        const ctrl = try self.read_byte(.{ .bank3 = .i2c_mst_ctrl });
        log.err("Master ctrl {x}", .{ctrl});
        const status = try self.mag_read_byte(.status1);
        log.err("Mag status {x}", .{status});
        //   DELETEME<<

        // Ensure we can read from the magnetometer
        const mag_id = try self.mag_read_byte(.device_id);
        if (mag_id != MAG_WHOAMI) {
            log.err("Unexpected magnetometer device ID: expected 0x{X:02}, got 0x{X:02}", .{ MAG_WHOAMI, mag_id });
            return error.SetupFailed;
        }

        // TODO: Needed?
        try self.mag_reset();

        // Set to continuous mode (100Hz)
        try self.mag_write_byte(.control2, 0b01000);

        // Set read address as xl so we can read all 6 bytes
        try self.write_byte(.{ .bank3 = .i2c_slv0_reg }, @intFromEnum(MagRegister.hxl));

        // Enable auto-reading
        // TODO: Enable byte swapping and set GRP correctly so we can avoid swapping from BigEndian
        // hxl is 0x11 (odd)
        try self.write_byte(.{ .bank3 = .i2c_slv0_ctrl }, @bitCast(i2c_slv0_ctrl{
            .i2c_slv0_en = 1,
            // TODO: 6 right? 3 i16s
            .i2c_slv0_leng = 6,
        }));

        // Sleep to give master time to fill sens data with data from new register
        self.clock.sleep_ms(MAG_READ_DELAY_US);
    }

    /// Clear the read bit in the sensor's master controller for the next transaction. This
    /// preserves the i2c slave address, so it must be set correctly in the first place.
    inline fn set_mag_write(self: *Self) !void {
        if (self.slave_address == 0x80 | MAG_ADDRESS) return;

        try self.write_byte(.{ .bank3 = .i2c_slv0_addr }, MAG_ADDRESS);
        self.slave_address = MAG_ADDRESS;
    }

    /// Set the read bit in the sensor's master controller for the next transaction This preserves
    /// the i2c slave address, so it must be set correctly in the first place.
    fn set_mag_read(self: *Self) !void {
        if (self.slave_address == 0x80 | MAG_ADDRESS) return;

        try self.write_byte(.{ .bank3 = .i2c_slv0_addr }, 0x80 | MAG_ADDRESS);
        self.slave_address = 0x80 | MAG_ADDRESS;
    }

    pub fn mag_read_register(self: *Self, reg: MagRegister, buf: []u8) Error!void {
        if (buf.len == 0) return Error.InvalidParameter;
        if (buf.len > std.math.maxInt(u4)) return Error.InvalidParameter;

        // Set (read) address
        try self.set_mag_read();
        self.clock.sleep_us(MAG_WRITE_DELAY_US);
        // Set register to read from
        try self.write_byte(.{ .bank3 = .i2c_slv0_reg }, @intFromEnum(reg));
        // Configure master to auto-read into SENS_DATA regs
        // try self.write_byte(.{ .bank3 = .i2c_slv0_ctrl }, 0xff);
        try self.write_byte(.{ .bank3 = .i2c_slv0_ctrl }, @bitCast(i2c_slv0_ctrl{
            .i2c_slv0_leng = @truncate(buf.len),
            .i2c_slv0_en = 1,
        }));
        // Read the data the master read in
        return try self.read_register(.{ .bank0 = .ext_slv_sens_data_00 }, buf);
    }

    pub inline fn mag_read_byte(self: *Self, reg: MagRegister) Error!u8 {
        var buf: [1]u8 = undefined;
        try self.mag_read_register(reg, &buf);
        return buf[0];
    }

    pub inline fn mag_write_byte(self: *Self, reg: MagRegister, val: u8) Error!void {
        try self.set_mag_write();
        self.clock.sleep_us(MAG_WRITE_DELAY_US);
        try self.write_byte(.{ .bank3 = .i2c_slv0_reg }, @intFromEnum(reg));
        try self.write_byte(.{ .bank3 = .i2c_slv0_do }, val);
        try self.write_byte(.{ .bank3 = .i2c_slv0_ctrl }, @bitCast(i2c_slv0_ctrl{
            .i2c_slv0_leng = 1,
            .i2c_slv0_en = 1,
        }));
        self.clock.sleep_us(MAG_WRITE_DELAY_US);
        // try self.set_mag_read();
    }

    pub fn mag_reset(self: *Self) Error!void {
        // Control 3 only has 1 bit, which initiates soft reset
        try self.mag_write_byte(.control3, 1);
        self.clock.sleep_us(MAG_RESET_DELAY_US);

        // Reset I2C master on device
        // try self.modify_register(.{ .bank0 = .user_ctrl }, user_ctrl, .{ .I2C_MST_RST = 1 });
    }

    const Mag_data_unscaled = struct {
        x: i16 = 0,
        y: i16 = 0,
        z: i16 = 0,
    };

    pub fn get_mag_data_unscaled(self: *Self) Error!Mag_data_unscaled {
        var raw_data: Mag_data_unscaled = .{};

        self.read_register(.{ .bank0 = .ext_slv_sens_data_00 }, std.mem.asBytes(&raw_data)) catch |err| {
            log.err("Failed to read magnetometer data: {}", .{err});
            return err;
        };

        return .{
            .x = std.mem.bigToNative(i16, raw_data.x),
            .y = std.mem.bigToNative(i16, raw_data.y),
            .z = std.mem.bigToNative(i16, raw_data.z),
        };
    }
};

// Testing
const TestDatagramDevice = mdf.base.Datagram_Device.Test_Device;
const TestTime = mdf.base.Clock_Device.Test_Device;

test "set_bank" {
    var ttd = TestTime.init();
    var d = TestDatagramDevice.init(null, true);
    defer d.deinit();
    const dd = d.datagram_device();
    try dd.connect();

    var dev = try ICM_20948.init(dd, ttd.clock_device(), .{});

    // Nothing is sent in init
    try d.expect_sent(&.{});

    // First call sets the bank, since it starts as null
    try dev.set_bank(0);
    try d.expect_sent(&.{&.{ 0x7f, 0x00 }});

    // Second call skips all writes, since we cache it and know we don't need to write
    try dev.set_bank(0);
    try d.expect_sent(&.{&.{ 0x7f, 0x00 }});

    // Third call changes the bank, so we need to write again
    try dev.set_bank(3);
    try d.expect_sent(&.{ &.{ 0x7f, 0x00 }, &.{ 0x7F, 0x30 } });

    // Fourth is again repeated, so no data is sent
    try dev.set_bank(3);
    try d.expect_sent(&.{ &.{ 0x7f, 0x00 }, &.{ 0x7F, 0x30 } });
}

test "reset" {
    var ttd = TestTime.init();
    var d = TestDatagramDevice.init(null, true);
    defer d.deinit();
    const dd = d.datagram_device();
    try dd.connect();

    var dev = try ICM_20948.init(dd, ttd.clock_device(), .{});

    // Nothing is sent in init
    try d.expect_sent(&.{});

    // Reset will set the bank, then the register address, modify, and write it back
    // -- Put in the values it expects to read
    d.input_sequence = &.{&.{0x41}};
    try dev.reset();
    try d.expect_sent(&.{ &.{ 0x7f, 0x00 }, &.{0x06}, &.{ 0x06, 0xC1 } });
}

test "read_byte" {
    var ttd = TestTime.init();
    var d = TestDatagramDevice.init(null, true);
    defer d.deinit();
    const dd = d.datagram_device();
    try dd.connect();

    var dev = try ICM_20948.init(dd, ttd.clock_device(), .{});

    // Read byte will set the bank
    // -- Put in the values it expects to read
    d.input_sequence = &.{&.{0x41}};
    const b = try dev.read_byte(.{ .bank1 = .xa_offs_h });
    // -- bank sel, bank 1, register 0x14
    try d.expect_sent(&.{ &.{ 0x7f, 0x10 }, &.{0x14} });
    try std.testing.expectEqual(0x41, b);
}

test "error handling in setup" {
    var ttd = TestTime.init();
    var d = TestDatagramDevice.init(null, true);
    defer d.deinit();
    const dd = d.datagram_device();
    try dd.connect();

    var dev = try ICM_20948.init(dd, ttd.clock_device(), .{});

    // Test wrong WHO_AM_I response, first byte is read during reset()
    d.input_sequence = &.{ &.{0x00}, &.{0xFF} }; // Wrong ID after reset
    const result = dev.setup();
    try std.testing.expectError(ICM_20948.Error.UnexpectedDeviceId, result);
}

test "device responsiveness check" {
    var ttd = TestTime.init();
    var d = TestDatagramDevice.init(null, true);
    defer d.deinit();
    const dd = d.datagram_device();
    try dd.connect();

    var dev = try ICM_20948.init(dd, ttd.clock_device(), .{});

    // Test with correct WHO_AM_I
    d.input_sequence = &.{&.{ICM_20948.WHOAMI}};
    try std.testing.expect(dev.is_device_responsive());

    // Test with incorrect WHO_AM_I
    d.input_sequence = &.{&.{0x00}};
    try std.testing.expect(!dev.is_device_responsive());
}
