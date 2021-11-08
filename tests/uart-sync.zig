const micro = @import("microzig");

// this will instantiate microzig and pull in all dependencies
pub const panic = micro.panic;

const pins =
    switch (micro.config.chip_name) {
    .@"ATmega328p" => .{
        .uart_tx = micro.Pin("PB5"),
        .uart_rx = micro.Pin("PB5"),
        .led = micro.Pin("PB5"),
    },
    .@"NXP LPC1768" => .{
        .uart_tx = micro.Pin("P0.15"),
        .uart_rx = micro.Pin("P0.16"),
        .led = micro.Pin("P0.18"),
    },
    .@"Raspberry Pi RP2040" => .{
        .uart_tx = micro.Pin("GPIO0"),
        .uart_rx = micro.Pin("GPIO1"),
        .led = micro.Pin("GPIO25"),
    },
    else => @compileError("unknown chip"),
};

pub const cpu_frequency: u32 = 100_000_000; // 100 MHz

pub fn main() !void {
    micro.reset(.{.gpio});

    pins.led.route(.gpio);
    pins.uart_tx.route(.uart0_tx);
    pins.uart_rx.route(.uart0_rx);

    const gpio_init = .{ .mode = .output, .initial_state = .low };

    const led1 = micro.Gpio(pins.led, gpio_init);
    led1.init();

    var debug_port = micro.Uart(0).init(.{
        .baud_rate = 9600,
        .stop_bits = .one,
        .parity = null,
        .data_bits = .eight,
    }) catch |err| {
        led1.write(.high);

        micro.hang();
    };

    var out = debug_port.writer();
    var in = debug_port.reader();
    _ = in;

    try out.writeAll("Please enter a sentence:\r\n");

    while (true) {
        try out.writeAll(".");
        micro.debug.busySleep(100_000);
    }
}
