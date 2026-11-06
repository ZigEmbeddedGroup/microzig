const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{ .logFn = usart.log });

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;

const usart = microzig.hal.usart;
const usart1 = usart.usart1;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .USART1 = on_usart1 },
};

// Shared between the ISR and main.
var rx_byte: u8 = 0;
var rx_pending: bool = false;

fn on_usart1() callconv(cpu.riscv_calling_convention) void {
    // Handle (and clear) ORE/FE/NE/PE first;
    // the STATR->DATAR sequence would otherwise swallow the byte below.
    usart1.check_errors() catch return;

    if (usart1.is_readable()) {
        @atomicStore(u8, &rx_byte, usart1.read_byte(), .release);
        @atomicStore(bool, &rx_pending, true, .release);
    }
    if (usart1.is_idle()) usart1.clear_idle();
}

pub fn main() !void {
    usart1.init_logger();

    usart1.set_interrupts(.{ .rx = true, .errors = true, .idle = true });
    usart1.enable_interrupt();

    var tx_buffer: [4]u8 = undefined;
    var tx = usart1.writer(&tx_buffer);
    tx.interface.writeAll("usart echo\r\n") catch {};
    tx.interface.flush() catch {};

    while (true) {
        while (!@atomicLoad(bool, &rx_pending, .acquire)) cpu.wfi();
        @atomicStore(bool, &rx_pending, false, .release);
        const byte = @atomicLoad(u8, &rx_byte, .acquire);
        tx.interface.print("> {c}\n", .{byte}) catch {};
        tx.interface.flush() catch {};
    }
}
