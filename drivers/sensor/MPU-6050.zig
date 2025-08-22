//!
//! Generic driver for the MPU-6050 accelerometer/gyroscope(/temperature)
//! sensor.
//!
//! Datasheet:
//! * https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-6000-Datasheet1.pdf
//!
//! Example usage:
//! ```zig
//! const mpu_6050: MPU_6050 = try .init(i2c_driver.datagram_device(), clock_device.clock_device());
//!
//! while (true) {
//!     const data = try mpu_6050.read_accel_temp_gyro();
//!     // Process data...
//! }
//! ```
//!
//! TODO:
//! * MPU-6000
//! * Add missing functionality (maybe also getters for some registers)
//! * DMP support

const mdf = @import("../framework.zig");
const Datagram_Device = mdf.base.Datagram_Device;
const Clock_Device = mdf.base.Clock_Device;

pub const MPU_6050 = struct {
    dev: Datagram_Device,
    clock: Clock_Device,
    accel_range: AccelRange,
    gyro_range: GyroRange,

    pub const DEFAULT_SLAVE_ADDRESS = 0x68;
    pub const TEMP_SENSITIVITY: f32 = 340;
    pub const TEMP_OFFSET: f32 = 36.53;
    pub const TEMP_SCALE: f32 = 1.0 / TEMP_SENSITIVITY;

    pub fn init(dev: Datagram_Device, clock: Clock_Device) !MPU_6050 {
        var self: MPU_6050 = .{
            .dev = dev,
            .clock = clock,
            .accel_range = undefined,
            .gyro_range = undefined,
        };

        try self.modify_reg(.pwr_mgmt_1, regs.PWR_MGMT_1, .{
            .CLK_SEL = 0x1, // Set clock source to be PLL with x-axis gyroscope reference
            .TEMP_DIS = false,
            .CYCLE = false,
            .SLEEP = false,
        });
        clock.sleep_ms(100);

        try self.verify();
        try self.set_digital_lpf(.@"256Hz");
        try self.set_accel_range(.@"2G");
        try self.set_accel_hpf(.none);
        try self.set_gyro_range(.@"250d");

        return self;
    }

    fn verify(self: MPU_6050) !void {
        const address = try self.read_byte(.whoami);
        if (address != DEFAULT_SLAVE_ADDRESS) {
            return error.DeviceNotRecognized;
        }
    }

    pub fn set_digital_lpf(self: MPU_6050, dlpf: Digital_LPF) !void {
        try self.modify_reg(.config, regs.CONFIG, .{
            .DLPF_CFG = dlpf,
        });
    }

    pub const Digital_LPF = enum(u3) {
        @"256Hz" = 0,
        @"188Hz" = 1,
        @"98Hz" = 2,
        @"42Hz" = 3,
        @"20Hz" = 4,
        @"10Hz" = 5,
        @"5Hz" = 6,
    };

    pub fn set_accel_range(self: *MPU_6050, range: AccelRange) !void {
        try self.modify_reg(.accel_config, regs.ACCEL_CONFIG, .{
            .AFS_SEL = range,
        });

        self.accel_range = range;
    }

    pub fn set_accel_self_test(self: MPU_6050, enable: packed struct(u3) {
        x: bool,
        y: bool,
        z: bool,
    }) !void {
        try self.modify_reg(.accel_config, regs.ACCEL_CONFIG, .{
            .XA_ST = enable.x,
            .YA_ST = enable.y,
            .ZA_ST = enable.z,
        });
    }

    pub const AccelRange = enum(u2) {
        @"2G" = 0,
        @"4G" = 1,
        @"8G" = 2,
        @"16G" = 3,

        pub fn sensitivity(range: AccelRange) f32 {
            return switch (range) {
                .@"2G" => 16384,
                .@"4G" => 8192,
                .@"8G" => 4096,
                .@"16G" => 2048,
            };
        }

        pub fn scale(range: AccelRange) f32 {
            return 1.0 / range.sensitivity();
        }
    };

    pub fn set_accel_hpf(self: MPU_6050, filter: Accel_HPF) !void {
        try self.modify_reg(.accel_config, regs.ACCEL_CONFIG, .{
            .HPF_CFG = filter,
        });
    }

    pub const Accel_HPF = enum(u3) {
        none = 0,
        @"5Hz" = 1,
        @"2.5Hz" = 2,
        @"1.25Hz" = 3,
        @"0.63Hz" = 4,
        hold = 7,
    };

    pub fn set_gyro_range(self: *MPU_6050, range: GyroRange) !void {
        try self.modify_reg(.gyro_config, regs.GYRO_CONFIG, .{
            .FS_SEL = range,
        });

        self.gyro_range = range;
    }

    pub const GyroRange = enum(u2) {
        @"250d" = 0,
        @"500d" = 1,
        @"1000d" = 2,
        @"2000d" = 3,

        pub fn sensitivity(range: GyroRange) f32 {
            return switch (range) {
                .@"250d" => 131,
                .@"500d" => 65.5,
                .@"1000d" => 32.8,
                .@"2000d" => 16.4,
            };
        }

        pub fn scale(range: GyroRange) f32 {
            return 1.0 / range.sensitivity();
        }
    };

    pub fn set_gyro_self_test(self: MPU_6050, enable: packed struct(u3) {
        x: bool,
        y: bool,
        z: bool,
    }) !void {
        try self.modify_reg(.gyro_config, regs.GYRO_CONFIG, .{
            .XG_ST = enable.x,
            .YG_ST = enable.y,
            .ZG_ST = enable.z,
        });
    }

    pub fn read_accel_raw(self: MPU_6050) ![3]i16 {
        return try self.read_raw_data(.acc_regx_h, 3);
    }

    pub fn read_accel(self: MPU_6050) ![3]f32 {
        const raw = try self.read_accel_raw();
        const scale = self.accel_range.scale();
        return .{
            @as(f32, @floatFromInt(raw[0])) * scale,
            @as(f32, @floatFromInt(raw[1])) * scale,
            @as(f32, @floatFromInt(raw[2])) * scale,
        };
    }

    pub fn read_temp_raw(self: MPU_6050) !i16 {
        return try self.read_raw_data(.temp_out_h, 1)[0];
    }

    pub fn read_temp(self: MPU_6050) !f32 {
        return @as(f32, @floatFromInt(try self.read_temp_raw())) * TEMP_SCALE + TEMP_OFFSET;
    }

    pub fn read_gyro_raw(self: MPU_6050) ![3]i16 {
        return try self.read_raw_data(.gyro_regx_h, 3);
    }

    pub fn read_gyro(self: MPU_6050) ![3]f32 {
        const raw = try self.read_gyro_raw();
        const scale = self.gyro_range.scale();
        return .{
            @as(f32, @floatFromInt(raw[0])) * scale,
            @as(f32, @floatFromInt(raw[1])) * scale,
            @as(f32, @floatFromInt(raw[2])) * scale,
        };
    }

    pub fn read_accel_temp_gyro_raw(self: MPU_6050) !struct {
        accel: [3]i16,
        temp: i16,
        gyro: [3]i16,
    } {
        const data = try self.read_raw_data(.acc_regx_h, 7);
        return .{
            .accel = .{ data[0], data[1], data[2] },
            .temp = data[3],
            .gyro = .{ data[4], data[5], data[6] },
        };
    }

    pub fn read_accel_temp_gyro(self: MPU_6050) !struct {
        accel: [3]f32,
        temp: f32,
        gyro: [3]f32,
    } {
        const data = try self.read_accel_temp_gyro_raw();
        const accel_scale = self.accel_range.scale();
        const gyro_scale = self.gyro_range.scale();
        return .{
            .accel = .{
                @as(f32, @floatFromInt(data.accel[0])) * accel_scale,
                @as(f32, @floatFromInt(data.accel[1])) * accel_scale,
                @as(f32, @floatFromInt(data.accel[2])) * accel_scale,
            },
            .temp = @as(f32, @floatFromInt(data.temp)) * TEMP_SCALE + TEMP_OFFSET,
            .gyro = .{
                @as(f32, @floatFromInt(data.gyro[0])) * gyro_scale,
                @as(f32, @floatFromInt(data.gyro[1])) * gyro_scale,
                @as(f32, @floatFromInt(data.gyro[2])) * gyro_scale,
            },
        };
    }

    fn read_raw_data(self: MPU_6050, reg: Register, comptime n: usize) ![n]i16 {
        var buf: [2 * n]u8 = undefined;
        try self.dev.write_then_read(&.{@intFromEnum(reg)}, &buf);
        var out: [n]i16 = undefined;
        inline for (0..n) |i| {
            out[i] = @bitCast(@as(u16, buf[2 * i]) << 8 | buf[2 * i + 1]);
        }
        return out;
    }

    fn write_byte(self: MPU_6050, reg: Register, value: u8) !void {
        try self.dev.write(&.{ @intFromEnum(reg), value });
    }

    fn read_byte(self: MPU_6050, reg: Register) !u8 {
        var value: u8 = undefined;
        try self.dev.write_then_read(&.{@intFromEnum(reg)}, (&value)[0..1]);
        return value;
    }

    inline fn read_reg(self: MPU_6050, reg: Register, T: type) !T {
        return @bitCast(try self.read_byte(reg));
    }

    inline fn modify_reg(self: MPU_6050, reg: Register, T: type, fields: anytype) !void {
        const current_val = try self.read_reg(reg, T);

        var val: T = @bitCast(current_val);
        inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
            @field(val, field.name) = @field(fields, field.name);
        }

        try self.write_byte(reg, @bitCast(val));
    }

    pub const Register = enum(u8) {
        config = 0x1a,
        gyro_config = 0x1b,
        accel_config = 0x1c,
        mot_thr = 0x1F,
        motion_duration = 0x20,
        gyro_regx_h = 0x43,
        gyro_regy_h = 0x45,
        gyro_regz_h = 0x47,
        acc_regx_h = 0x3b,
        temp_out_h = 0x41,
        pwr_mgmt_1 = 0x6b,
        whoami = 0x75,
        _,
    };

    pub const regs = struct {
        pub const CONFIG = packed struct(u8) {
            DLPF_CFG: Digital_LPF,
            EXT_SYNC_SET: u3,
            reserved0: u2,
        };

        pub const GYRO_CONFIG = packed struct(u8) {
            reserved0: u3,
            FS_SEL: GyroRange,
            ZG_ST: bool,
            YG_ST: bool,
            XG_ST: bool,
        };

        pub const ACCEL_CONFIG = packed struct(u8) {
            HPF_CFG: Accel_HPF,
            AFS_SEL: AccelRange,
            ZA_ST: bool,
            YA_ST: bool,
            XA_ST: bool,
        };

        pub const PWR_MGMT_1 = packed struct(u8) {
            CLK_SEL: u3,
            TEMP_DIS: bool,
            reserved0: u1,
            CYCLE: bool,
            SLEEP: bool,
            DEVICE_RESET: bool,
        };
    };
};
