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

///
/// Some ugly glue code to implement required functions from FreeRTOS and Pico SDK
/// - This can be improved later
/// - Some or even all of these could be implemented in freertos module directly?
/// - Multicore not supported yet - multicore_reset_core1 have to be implemented
export fn panic_unsupported() callconv(.c) noreturn {
    @panic("not supported");
}

export fn irq_set_priority(num: c_uint, priority: u8) callconv(.c) void {
    const p: *volatile u32 = @ptrFromInt(@intFromPtr(&microzig.chip.peripherals.PPB.NVIC_IPR0) + (num >> 2));
    const shift: u5 = @intCast(8 * (@as(u32, @intCast(num)) & 3));
    const mask: u32 = @as(u32, 0xff) << shift;
    p.* = (p.* & ~mask) | (@as(u32, priority) << shift);
}

export fn irq_set_enabled(_: c_uint, enabled: bool) callconv(.c) void {
    if (enabled) {
        microzig.cpu.interrupt.enable(@enumFromInt(0));
    } else {
        microzig.cpu.interrupt.disable(@enumFromInt(0));
    }
}

export fn irq_set_exclusive_handler(_: u8) callconv(.c) void {
    panic_unsupported();
}

export fn multicore_launch_core1(entry: *const fn () callconv(.c) void) callconv(.c) void {
    microzig.hal.multicore.launch_core1(@ptrCast(entry));
}

export fn multicore_reset_core1() callconv(.c) void {
    // TODO: please implement this in microzig.hal.multicore and call it here
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

export fn exception_set_exclusive_handler(num: c_uint, handler: *const fn () callconv(.c) void) callconv(.c) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    // TODO: can this code be simplified?
    if (num == 11) {
        microzig.cpu.ram_vector_table.SVCall = .{ .c = handler };
    } else if (num == 14) {
        microzig.cpu.ram_vector_table.PendSV = .{ .naked = @ptrCast(handler) };
    } else if (num == 15) {
        microzig.cpu.ram_vector_table.SysTick = .{ .c = handler };
    }

    // used in PicoSDK - do we need this?
    asm volatile ("DMB" ::: .{ .memory = true });
}
