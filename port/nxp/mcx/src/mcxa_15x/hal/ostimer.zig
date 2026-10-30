const microzig = @import("microzig");
const syscon = @import("syscon.zig");

const time = microzig.drivers.time;

const OSTIMER0 = microzig.chip.peripherals.OSTIMER0;
const MRCC0 = microzig.chip.peripherals.MRCC0;

//TODO: allow Hal config to enable Time counting on Debug and set/clear ACC
pub fn init() void {

    //disable and reset timer
    syscon.disable_clock(.OSTIMER0);
    syscon.reset_assert(.OSTIMER0);
    syscon.reset_release(.OSTIMER0);

    //set clk_1m as input_clk
    //TODO: check if FRO_12m is set in sleep mode

    syscon.unlock_clock_configuration();
    MRCC0.MRCC_OSTIMER0_CLKSEL.modify_one("MUX", @fromBackingInt(@intCast(2)));
    syscon.freeze_clock_configuration();

    syscon.enable_clock(.OSTIMER0);
}

pub fn get_time_since_boot() time.Absolute {
    const sec = microzig.interrupt.enter_critical_section();
    defer sec.leave();

    //sev inst saves a snapshot of OSTIMER.EVCounter on OSTIMER.CAPTURE
    microzig.cpu.sev();

    //read current timer Gray value
    var gray: u42 = OSTIMER0.CAPTURE_L.read().CAPTURE_VALUE;
    gray |= @as(u42, OSTIMER0.CAPTURE_H.read().CAPTURE_VALUE) << 32;

    //simple gray to bin convert
    var b = gray;
    b ^= b >> 1;
    b ^= b >> 2;
    b ^= b >> 4;
    b ^= b >> 8;
    b ^= b >> 16;
    b ^= b >> 32;
    return @fromBackingInt(@intCast(b));
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
