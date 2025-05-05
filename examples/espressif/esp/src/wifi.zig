const std = @import("std");
const microzig = @import("microzig");
const interrupt = microzig.cpu.interrupt;
const hal = microzig.hal;
const radio = hal.radio;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = logFn,
    .interrupts = .{
        .interrupt1 = radio.interrupt_handlers.wifi_xxx,
        .interrupt2 = radio.interrupt_handlers.timer,
        .interrupt3 = radio.interrupt_handlers.software,
    },
};

pub fn logFn(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    usb_serial_jtag.logger.logFn(level, scope, format, args);
}

var buffer: [70 * 1024]u8 = undefined;

pub fn main() !void {
    std.log.info("hello world!", .{});

    var fba: std.heap.FixedBufferAllocator = .init(&buffer);
    const allocator = fba.allocator();

    radio.init(allocator) catch |err| std.debug.panic("{}", .{err});
    radio.wifi.init() catch |err| std.debug.panic("{}", .{err});

    while (true) {
        std.log.info("tick!", .{});
        hal.time.sleep_ms(1000);
    }
}
