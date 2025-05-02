const std = @import("std");
const microzig = @import("microzig");
const interrupt = microzig.cpu.interrupt;
const hal = microzig.hal;
const wifi = hal.wifi;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = usb_serial_jtag.logger.logFn,
    .interrupts = .{
        .interrupt1 = wifi.interrupt_handlers.wifi_xxx,
        .interrupt2 = wifi.interrupt_handlers.timer,
        .interrupt3 = wifi.interrupt_handlers.software,
    },
};

var buffer: [70 * 1024]u8 = undefined;

pub fn main() !void {
    std.log.info("hello world!", .{});

    var fba: std.heap.FixedBufferAllocator = .init(&buffer);
    const allocator = fba.allocator();

    wifi.init(allocator) catch |err| std.debug.panic("{}", .{err});
    wifi.wifi_controller.init() catch |err| std.debug.panic("{}", .{err});


    while (true) {
        std.log.info("tick!", .{});
        hal.time.sleep_ms(1000);
    }
}
