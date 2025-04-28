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
        .interrupt1 = wifi.interrupt_handlers.wifi_mac,
        .interrupt2 = wifi.interrupt_handlers.wifi_pwr,
        .interrupt3 = wifi.interrupt_handlers.timer,
        .interrupt4 = wifi.interrupt_handlers.software,
    },
};

var buffer: [1024]u8 = undefined;

pub fn main() !void {
    std.log.info("hello world!", .{});

    var fba: std.heap.FixedBufferAllocator = .init(&buffer);
    const allocator = fba.allocator();

    wifi.init(allocator) catch @panic("OOM");

    // microzig.cpu.interrupt.set_priority_threshold(.zero);
    //
    // microzig.cpu.interrupt.set_type(.interrupt1, .level);
    // microzig.cpu.interrupt.set_priority(.interrupt1, .highest);
    // microzig.cpu.interrupt.map(.systimer_target0, .interrupt1);
    // microzig.cpu.interrupt.enable(.interrupt1);
    //
    // microzig.cpu.interrupt.enable_interrupts();

    while (true) {
        microzig.cpu.wfi();
    }
}
