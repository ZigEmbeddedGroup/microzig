const micro = @import("microzig");

// Configures the led_pin to a hardware pin
const uart_txd_pin = micro.Pin("P0.15");
const uart_rxd_pin = micro.Pin("P0.16");

const debug_pin = micro.Pin("P0.17");

const led1_pin = micro.Pin("P1.18");
const led2_pin = micro.Pin("P1.20");
const led3_pin = micro.Pin("P1.21");
const led4_pin = micro.Pin("P1.23");

pub const cpu_frequency: u32 = 100_000_000; // 100 MHz

const PLL = struct {
    fn init() void {
        reset_overclocking();
    }

    fn reset_overclocking() void {
        overclock_flash(5); // 5 cycles access time
        overclock_pll(3); // 100 MHz
    }

    fn overclock_flash(timing: u4) void {
        micro.chip.registers.SYSCON.FLASHCFG.modify(.{
            .FLASHTIM = timing - 1,
        });
    }
    inline fn feed_pll() void {
        micro.chip.registers.SYSCON.PLL0FEED.modify(.{ .PLL0FEED = 0xAA });
        micro.chip.registers.SYSCON.PLL0FEED.modify(.{ .PLL0FEED = 0x55 });
    }

    fn overclock_pll(divider: u8) void {
        // PLL einrichten für RC
        micro.chip.registers.SYSCON.PLL0CON.modify(.{
            .PLLE0 = 0,
            .PLLC0 = 0,
        });
        feed_pll();

        micro.chip.registers.SYSCON.CLKSRCSEL.modify(.{ .CLKSRC = 0 }); // RC-Oszillator als Quelle
        micro.chip.registers.SYSCON.PLL0CFG.modify(.{
            // SysClk = (4MHz / 2) * (2 * 75) = 300 MHz
            .MSEL0 = 74,
            .NSEL0 = 1,
        });
        // CPU Takt = SysClk / divider
        micro.chip.registers.SYSCON.CCLKCFG.modify(.{ .CCLKSEL = divider - 1 });

        feed_pll();

        micro.chip.registers.SYSCON.PLL0CON.modify(.{ .PLLE0 = 1 }); // PLL einschalten
        feed_pll();

        var i: usize = 0;
        while (i < 1_000) : (i += 1) {
            micro.cpu.nop();
        }

        micro.chip.registers.SYSCON.PLL0CON.modify(.{ .PLLC0 = 1 });
        feed_pll();
    }
};

pub fn main() !void {
    const gpio_init = .{ .mode = .output, .initial_state = .low };

    const led1 = micro.Gpio(led1_pin, gpio_init);
    const led2 = micro.Gpio(led2_pin, gpio_init);
    const led3 = micro.Gpio(led3_pin, gpio_init);
    const led4 = micro.Gpio(led4_pin, gpio_init);

    const status = micro.Gpio(debug_pin, .{
        .mode = .output,
        .initial_state = .high,
    });
    status.init();
    led1.init();
    led2.init();
    led3.init();
    led4.init();

    uart_txd_pin.route(.func01);
    uart_rxd_pin.route(.func01);

    PLL.init();
    led1.setToHigh();

    var debug_port = micro.Uart(1).init(.{
        .baud_rate = 9600,
        .stop_bits = .one,
        .parity = null,
        .data_bits = .eight,
    }) catch |err| {
        led1.write(if (err == error.UnsupportedBaudRate) micro.gpio.State.low else .high);
        led2.write(if (err == error.UnsupportedParity) micro.gpio.State.low else .high);
        led3.write(if (err == error.UnsupportedStopBitCount) micro.gpio.State.low else .high);
        led4.write(if (err == error.UnsupportedWordSize) micro.gpio.State.low else .high);

        micro.hang();
    };
    led2.setToHigh();

    var out = debug_port.writer();
    var in = debug_port.reader();
    _ = in;

    try out.writeAll("Please enter a sentence:\r\n");

    led3.setToHigh();

    while (true) {
        try out.writeAll(".");
        led4.toggle();
        micro.debug.busySleep(100_000);
    }
}
