const std = @import("std");
const microzig = @import("microzig");
const drivers = microzig.drivers;
const lcd = drivers.display.HD44780;
const lcd_config = drivers.display.hd44780.Config;
const io_device = drivers.base.Datagram_Device;
const WriteError = io_device.WriteError;

const rp2040 = microzig.hal;
const i2c = rp2040.i2c;
const gpio = rp2040.gpio;
const peripherals = microzig.chip.peripherals;
const timer = rp2040.time;

const i2c0 = i2c.instance.num(0);

pub const i2c_device = struct {
    i2c_bus: i2c.I2C,
    addr: i2c.Address,
    pub fn init(bus: i2c.I2C, addr: i2c.Address) i2c_device {
        return .{
            .i2c_bus = bus,
            .addr = addr,
        };
    }

    fn writev(ctx: *anyopaque, datagrams: []const []const u8) WriteError!void {
        const device: *i2c_device = @ptrCast(@alignCast(ctx));
        device.i2c_bus.writev_blocking(device.addr, datagrams, null) catch return WriteError.IoError;
    }

    const vtable = drivers.base.Datagram_Device.VTable{
        .connect_fn = null,
        .disconnect_fn = null,
        .writev_fn = i2c_device.writev,
        .readv_fn = null,
    };

    pub fn datagram_device(device: *i2c_device) io_device {
        return io_device{
            .object = device,
            .vtable = &vtable,
        };
    }
};

pub fn delay_us(time_delay: u32) void {
    timer.sleep_us(time_delay);
}

pub fn main() !void {
    const scl_pin = gpio.num(5);
    const sda_pin = gpio.num(4);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger(.enabled);
        pin.set_function(.i2c);
    }

    try i2c0.apply(.{
        .clock_config = rp2040.clock_config,
    });
    const msg = "hello world - From Zig";
    var bus = i2c_device.init(i2c0, @enumFromInt(0x27));
    var my_lcd = lcd.init(
        bus.datagram_device(),
        delay_us,
        .{},
    );
    _ = my_lcd.init_device(false).write(msg);

    while (true) {
        _ = my_lcd.shift_display_right();
        timer.sleep_ms(350);
    }
}
