// SoftDevice initialization example for PCA10040.
//
// Enables the SoftDevice BLE stack, then blinks LED1 to confirm it's running.
// LED4 is lit on fault. This demonstrates the minimal SoftDevice setup.
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;
const sd = nrf.softdevice;
const time = nrf.time;

pub fn main() void {
    board.init();

    // Enable SoftDevice with default LF clock (internal RC oscillator).
    const clock_cfg: sd.sdm.ClockLfCfg = .{
        .source = .rc,
        .rc_ctiv = 16, // calibration interval (4s * 16 = 64s)
        .rc_temp_ctiv = 2, // calibrate on temperature change every 2 intervals
        .accuracy = .ppm_500,
    };

    sd.sdm.enable(&clock_cfg, fault_handler) catch {
        // Signal error on LED4
        board.led4.put(board.led_active_state);
        while (true) {}
    };

    // SoftDevice is running — blink LED1
    while (true) {
        board.led1.toggle();
        time.sleep_ms(500);
    }
}

fn fault_handler(_: sd.sdm.FaultId, _: u32, _: u32) callconv(.c) void {
    board.led4.put(board.led_active_state);
    while (true) {}
}
