//!
//! Generic driver for the TDK ICM-20948 9-axis motion tracker
//!
//! Datasheet:
//! * https://invensense.tdk.com/wp-content/uploads/2024/03/DS-000189-ICM-20948-v1.6.pdf
//!
//! TODO:
//! * Add support for magnetometer
//! * Allow configuring the unit of the readings (Gs vs m/s^2, degrees vs. radians, C vs F)
//! * Figure out minimium timing. 150 is too low, 200 is OK, but find it in the docs!
//!
const std = @import("std");
const mdf = @import("../framework.zig");

pub const ICM_20948 = struct {
    const Self = @This();
    const MIN_SLEEP_US = 200;
    const WHOAMI = 0xEA;
    dev: mdf.base.Datagram_Device,
    clock: mdf.base.Clock_Device,
    config: Config,
    current_bank: ?u2 = null,

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

    const Config = struct {
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

    // const power_modes = enum {
    //     sleep = .{ false, false, false },
    //     lp_accel = .{ false, true, false }, // TODO: "Duty cycled"
    //     ln_accel = .{ false, true, false },
    //     gyro = .{ true, false, false },
    //     magnetometer = .{ false, false, true },
    //     accel_gyro = .{ true, true, false },
    //     accel_magnetometer = .{ false, true, true },
    //     @"9axis" = .{ true, true, true },
    // };

    const pwr_mgmt_1 = packed struct(u8) {
        CLKSEL: u3 = 0,
        TEMP_DIS: u1 = 0,
        reserved_0: u1 = 0,
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

    pub fn init(dev: mdf.base.Datagram_Device, clock: mdf.base.Clock_Device, config: Config) !Self {
        return Self{ .dev = dev, .clock = clock, .config = config };
    }

    pub fn setup(self: *Self) !void {
        try self.reset();

        std.log.debug("Reading who am i", .{}); // DELETEME
        const id = try self.read_byte(.{ .bank0 = .who_am_i });
        if (id != Self.WHOAMI) return error.WhoAmI;

        try self.set_clocks();

        // TODO: We should set low power on after we are done configuring
        try self.low_power(false);

        // try self.startup_magnetometer();

        // set sample mode
        try self.set_sample_mode();

        // This sets DLPF as well as full scale and enables the devices
        try self.configure_accelerometer(self.config);
        try self.configure_gyroscope(self.config);
    }

    pub inline fn read_register(self: *Self, reg: Self.Register, buf: []u8) !void {
        try self.set_bank(reg.bank());
        try self.dev.write(&[_]u8{reg.value()});
        self.clock.sleep_us(MIN_SLEEP_US);
        const size = try self.dev.read(buf);
        if (size != buf.len) return error.ReadError;
        self.clock.sleep_us(MIN_SLEEP_US);
    }

    pub inline fn read_byte(self: *Self, reg: Self.Register) !u8 {
        var buf: [1]u8 = undefined;
        try self.read_register(reg, &buf);
        return @bitCast(buf[0]);
    }

    pub inline fn write_byte(self: *Self, reg: Self.Register, val: u8) !void {
        defer self.clock.sleep_us(MIN_SLEEP_US);
        return self.dev.write(&([2]u8{ reg.value(), val }));
    }

    /// Read the register and modify the matching fields as provided
    pub inline fn modify_register(self: *Self, reg: Self.Register, reg_t: type, fields: anytype) !void {
        // Read the value and cast to the correct type
        var val: reg_t = @bitCast(try self.read_byte(reg));
        // std.log.debug("Modify: before: {any}", .{val}); // DELETEME
        // Modify the named fields
        inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
            @field(val, field.name) = @field(fields, field.name);
        }
        // std.log.debug("Modify: after: {any}", .{val}); // DELETEME
        try self.write_byte(reg, @bitCast(val));
    }

    /// Set the register bank for the next read/write. This device tracks which bank was last set to
    /// avoid having to set it continuously when using registers in the same bank.
    pub inline fn set_bank(self: *Self, comptime bank: u2) !void {
        // Avoid a write if we are already on the correct bank
        if (bank == self.current_bank) return;
        std.log.debug("Setting bank to {}", .{bank}); // DELETEME

        // Bits 5:4
        try self.write_byte(.{ .bank0 = .reg_bank_sel }, @as(u8, bank) << 4);
        self.current_bank = bank;
    }

    pub fn reset(self: *Self) !void {
        std.log.debug("Reset", .{}); // DELETEME
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{ .DEVICE_RESET = true });
    }

    pub fn sleep(self: *Self, on: bool) !void {
        std.log.debug("Sleep ({any})", .{on}); // DELETEME
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{ .SLEEP = on });
    }

    pub fn low_power(self: *Self, on: bool) !void {
        std.log.debug("Low power ({any})", .{on}); // DELETEME
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{ .LP_EN = on });
    }

    pub fn set_clocks(self: *Self) !void {
        std.log.debug("Set clocks", .{});
        try self.modify_register(.{ .bank0 = .pwr_mgmt_1 }, pwr_mgmt_1, .{
            .CLKSEL = 1,
            .SLEEP = false,
            .DEVICE_RESET = false,
        });
    }

    // pub fn startup_magnetometer(self: *Self) !void {
    //     // enable master passthrough false
    //     // enable master
    //     // reset magnetometer
    //     // loop a few tries until we can read MAG who i am
    //
    //     // Write mode 100hz to reg cntl 2
    //     // configure master peripheral
    //
    // }

    pub fn set_sample_mode(self: *Self) !void {
        // TODO: Support setting these individually. Could set based on if ODR fields are set (make
        // optional?)
        try self.modify_register(.{ .bank0 = .lp_config }, lp_config, .{
            .I2C_MST_CYCLE = 0, // Disable i2c master duty cycle
            .ACCEL_CYCLE = 1, // Duty cycle mode, use ACCEL_SMPLRT_DIV
            .GYRO_CYCLE = 1, // Duty cycle mode, use GYRO_SMPLTR_DIV
        });
    }

    pub fn configure_accelerometer(self: *Self, config: Config) !void {
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

    pub fn disable_accelerometer(self: *Self) !void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_2 }, pwr_mgmt_2, .{
            .DISABLE_ACCEL = .disable,
        });
    }

    const Accel_data = struct {
        x: f32 = 0,
        y: f32 = 0,
        z: f32 = 0,
    };
    pub fn get_accel_data(self: *Self) !Accel_data {
        var raw_data = packed struct {
            x: i16 = 0,
            y: i16 = 0,
            z: i16 = 0,
        }{};
        try self.read_register(.{ .bank0 = .accel_xout_h }, std.mem.asBytes(&raw_data));
        return .{
            .x = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.x))) * self.accel_scalar(),
            .y = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.y))) * self.accel_scalar(),
            .z = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.z))) * self.accel_scalar(),
        };
    }

    fn accel_scalar(self: *Self) f32 {
        return self.config.accel_range.scalar() / self.config.accel_range.divisor();
    }

    pub fn configure_gyroscope(self: *Self, config: Config) !void {
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

    pub fn disable_gyroscope(self: *Self) !void {
        try self.modify_register(.{ .bank0 = .pwr_mgmt_2 }, pwr_mgmt_2, .{
            .DISABLE_GYRO = .disable,
        });
    }

    const Gyro_data_unscaled = struct {
        x: i16 = 0,
        y: i16 = 0,
        z: i16 = 0,
    };
    pub fn get_gyro_data_unscaled(self: *Self) !Gyro_data_unscaled {
        var raw_data: Gyro_data_unscaled = .{};
        try self.read_register(.{ .bank0 = .gyro_xout_h }, std.mem.asBytes(&raw_data));
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
    pub fn get_gyro_data(self: *Self) !Gyro_data {
        const unscaled_data = try self.get_gyro_data_unscaled();
        return .{
            .x = @as(f32, @floatFromInt(unscaled_data.x)) * self.gyro_scalar(),
            .y = @as(f32, @floatFromInt(unscaled_data.y)) * self.gyro_scalar(),
            .z = @as(f32, @floatFromInt(unscaled_data.z)) * self.gyro_scalar(),
        };
    }

    fn gyro_scalar(self: *Self) f32 {
        return self.config.gyro_range.scalar() / self.config.gyro_range.divisor();
    }

    const @"6Dof_data" = struct {
        accel: Accel_data,
        gyro: Gyro_data,
    };
    pub fn get_accel_gyro_data(self: *Self) !@"6Dof_data" {
        var raw_data = packed struct {
            ax: i16 = 0,
            ay: i16 = 0,
            az: i16 = 0,
            gx: i16 = 0,
            gy: i16 = 0,
            gz: i16 = 0,
        }{};
        try self.read_register(.{ .bank0 = .accel_xout_h }, std.mem.asBytes(&raw_data));
        return .{ .accel = .{
            .x = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.ax))) * self.accel_scalar(),
            .y = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.ay))) * self.accel_scalar(),
            .z = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.az))) * self.accel_scalar(),
        }, .gyro = .{
            .x = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.gx))) * self.gyro_scalar(),
            .y = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.gy))) * self.gyro_scalar(),
            .z = @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data.gz))) * self.gyro_scalar(),
        } };
    }

    pub fn get_temp(self: *Self) !f32 {
        var raw_data: i16 = undefined;
        try self.read_register(.{ .bank0 = .temp_out_h }, std.mem.asBytes(&raw_data));
        return @as(f32, @floatFromInt(std.mem.bigToNative(i16, raw_data))) / 333.87 + 21.0;
    }
};
