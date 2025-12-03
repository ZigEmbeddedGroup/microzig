const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const rtc = hal.rtc;
const rcc = hal.rcc;
const bkp = hal.backup;
const gpio = hal.gpio;

pub const microzig_options = microzig.Options{
    .interrupts = .{ .RTC = .{ .c = rtc_handler } },
};

pub fn rtc_handler() callconv(.c) void {
    const events = rtc.read_events();
    if (events.second) {
        led.toggle();
    }
    rtc.clear_events(events);
}

///LED used to indicate that the RTC is running.
///On the WeAct BluePill+ board, this is the built-in LED.
///On other BluePill boards, you need to connect an LED to pin PB2,
///(NOTE: PC13 is the TAMPER pin, which is used for output RTC events on this example)
const led = gpio.Pin.from_port(.B, 2);

pub fn main() !void {

    //RTC is part of the backup domain, therefore it is not reset (except for interrupt config)
    //by the system reset, so we need to check if it is already running.
    //If it is not running, we will configure it and enable it.
    if (fresh_start()) {
        _ = try rcc.apply(.{
            .RTCClockSelection = .RCC_RTCCLKSOURCE_LSE,
            .flags = .{ .RTCUsed_ForRCC = true, .LSEOscillator = true },
        });
        rcc.enable_clock(.PWR);
        rcc.enable_clock(.BKP);

        //disable the backup domain protection
        //this is necessary to write to the backup registers
        bkp.set_data_protection(false);

        bkp.BackupData1[0].data = 0xBEEF;
        bkp.BackupData1[1].data = 0xDEAD;

        //enable the RTC event output on the TAMPER pin (PC13)
        bkp.rtc_event_output(.Second);
        bkp.set_rtc_event_output(true);

        rtc.enable(true);
        rtc.apply(.{ .prescaler = 32_768 });

        //enable the backup domain write protection
        bkp.set_data_protection(true);
    }
    rtc.busy_sync(); //wait for RTC to be ready

    //RTC interrupt need to be applied every time the system is reset
    //even if the RTC is already running.
    rtc.apply_interrupts(.{ .second_interrupt = true });

    rcc.enable_clock(.GPIOB); //enable GPIOB clock for LED
    rcc.enable_clock(.GPIOC); //enable GPIOC clock for TAMPER pin
    led.set_output_mode(.general_purpose_push_pull, .max_10MHz);
    microzig.interrupt.enable(.RTC);
    microzig.interrupt.enable_interrupts();
    while (true) {}
}

fn fresh_start() bool {
    const power_down: bool = hal.Reset_Reason == .POR_or_PDR;
    rcc.enable_clock(.PWR);
    rcc.enable_clock(.BKP);
    const data: u32 = (@as(u32, bkp.BackupData1[1].data) << 16) | bkp.BackupData1[0].data;
    rcc.disable_all_clocks();
    return (data != 0xDEADBEEF) or power_down;
}
