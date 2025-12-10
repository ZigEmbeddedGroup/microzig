//!
//! Generic driver for the ASAIR AHT30 Temperature and Humidity Sensor.
//!
//! Datasheet:
//! * AHT30: https://eleparts.co.kr/data/goods_attach/202306/good-pdf-12751003-1.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");

pub const AHT30 = struct {
    dev: mdf.base.I2C_Device,
    address: mdf.base.I2C_Device.Address,

    const Reading = struct {
        relative_humidity: f32,
        temperature_c: f32,
    };

    const Status = packed struct {
        reserved: u2,
        /// 0 -- The calibrated capacitance data is within the CMP interrupt threshold range
        /// 1 -- The calibrated capacitance data is outside the CMP interrupt threshold range
        cmp_interrupt: u1,
        /// 0 -- The calibration calculation function is disabled, and the output data is the raw data output by the ADC
        /// 1 -- The calibration calculation function is enabled, and the output data is the calibrated data
        calibration_enabled: bool,
        /// 0 -- Indicates that the integrity test failed, indicating that there is an error in the OTP data
        /// 1 -- Indicates that the OTP memory data integrity test (CRC) passed,
        crc_flag: u1,
        mode_status: enum(u2) { nor, cyc, cmd, _ },
        /// 0 -- Sensor idle, in sleep state
        /// 1 -- Sensor is busy, measuring in progress
        busy: bool,
    };

    const write_measurement_command = [_]u8{ 0xAC, 0x33, 0x00 };

    /// init should be followed by a delay of at least 5ms
    pub fn init(dev: mdf.base.I2C_Device, address: mdf.base.I2C_Device.Address) !AHT30 {
        return AHT30{
            .dev = dev,
            .address = address,
        };
    }

    /// CRC8 check polynomial is X8+X5+X4+1
    fn crc8(data: [7]u8) u8 {
        var crc: u8 = 0xFF;
        // skip CRC itself
        for (data[0 .. data.len - 1]) |b| {
            crc ^= b;
            for (0..8) |_| {
                crc = if (crc & 0x80 != 0) (crc << 1) ^ 0x31 else crc << 1;
            }
        }
        return crc;
    }

    /// For greater precision the data collection cycle should be greater than 1 second
    pub fn read_data(self: AHT30) !Reading {
        var data: [7]u8 = undefined;
        const read = try self.dev.read(self.address, &data);
        if (read != data.len) {
            return error.InvalidResponseLength;
        }

        const status: Status = @bitCast(data[0]);
        if (status.busy) return error.SensorBusy;
        if (status.cmp_interrupt == 1) return error.DataOutsiteThreshold;
        if (status.crc_flag == 0) return error.IntegrityTestFailed;

        if (data[6] != crc8(data)) {
            return error.InvalidCrc8;
        }

        const relative_humidity_data = (@as(u32, data[1]) << 12) | (@as(u32, data[2]) << 4) | data[3] >> 4;
        const temperature_data = ((@as(u32, data[3]) & 0x0F) << 16) | (@as(u32, data[4]) << 8) | data[5];

        return .{
            .relative_humidity = to_relative_humidity(relative_humidity_data),
            .temperature_c = to_temp(temperature_data),
        };
    }

    /// update_readings should be followed by a delay of at least 80ms
    pub fn update_readings(self: AHT30) !void {
        try self.dev.write(
            self.address,
            &write_measurement_command,
        );
    }

    fn to_temp(temp_data: u32) f32 {
        return (@as(f32, @floatFromInt(temp_data)) / 1048576) * 200 - 50;
    }

    fn to_relative_humidity(humidity_data: u32) f32 {
        return (@as(f32, @floatFromInt(humidity_data)) / 1048576) * 100;
    }

    pub fn c_to_f(temp_c: f32) f32 {
        return (temp_c * 9 / 5) + 32;
    }
};

test "temp conversions C to F" {
    try std.testing.expectEqual(-40, AHT30.c_to_f(-40));
    try std.testing.expectEqual(32, AHT30.c_to_f(0));
    try std.testing.expectEqual(86, AHT30.c_to_f(30));
}

test "unit conversions to temp" {
    try std.testing.expectEqual(0, AHT30.to_temp(0));
    try std.testing.expectEqual(7.8125E-3, AHT30.to_temp(1));
    try std.testing.expectEqual(-7.8125E-3, AHT30.to_temp(-1));
}

test "temp conversions to units" {
    try std.testing.expectEqual(0, AHT30.to_temp_units(0));
    try std.testing.expectEqual(32640, AHT30.to_temp_units(255));
    try std.testing.expectEqual(-32640, AHT30.to_temp_units(-255));
}
