const std = @import("std");
const microzig = @import("microzig");

const freertos = @import("freertos");
const freertos_os = freertos.OS;

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .cpu = .{
        .ram_vector_table = true,
    },
};

pub fn main() !void {
    uart_tx_pin.set_function(.uart);

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    // Give it large stack because printing is demanding
    _ = freertos_os.xTaskCreate(hello_task, "hello_task", freertos_os.MINIMAL_STACK_SIZE * 8, null, freertos_os.MAX_PRIORITIES - 1, null);

    freertos_os.vTaskStartScheduler();
}

pub fn hello_task(_: ?*anyopaque) callconv(.c) void {
    var i: u32 = 0;
    while (true) : (i += 1) {
        std.log.info("Hello from FreeRTOS task {}", .{i});
        freertos_os.vTaskDelay(500);
    }
}

export fn __unhandled_user_irq() callconv(.c) void {
    std.log.err("Unhandled IRQ called!", .{});
    @panic("Unhandled IRQ");
}

///
/// Some ugly glue code to implement required functions from FreeRTOS and Pico SDK
/// - This can be improved later
/// - Some or even all of these could be implemented in freertos module directly?
/// - Multicore not supported yet - multicore_reset_core1 have to be implemented
export fn panic_unsupported() callconv(.c) noreturn {
    @panic("not supported");
}

export fn multicore_launch_core1(entry: *const fn () callconv(.c) void) callconv(.c) void {
    microzig.hal.multicore.launch_core1(@ptrCast(entry));
}

export fn multicore_reset_core1() callconv(.c) void {
    // TODO: please implement this in microzig.hal.multicore and call it here
}

export fn multicore_doorbell_claim_unused(_: c_uint, _: bool) callconv(.c) c_int {
    // TODO: please implement this in microzig.hal.multicore and call it here
    return 0;
}

export fn clock_get_hz(_: u32) callconv(.c) u32 {
    std.log.info("clock_get_hz called", .{});
    // FIXME: this seems to return null
    // return microzig.hal.clock_config.sys_freq.?;
    return switch (microzig.hal.compatibility.chip) {
        .RP2040 => 125_000_000,
        .RP2350 => 150_000_000,
    };
}

export fn spin_lock_claim(_: c_uint) callconv(.c) void {}

export fn next_striped_spin_lock_num() callconv(.c) c_uint {
    return 16;
}
