//High-level API for timekeeping

const microzig = @import("microzig");
const rcc = @import("rcc.zig");
const bkp = @import("backup.zig");
const rtc = @import("rtc.zig");
const timer = @import("../common/timer_v1.zig");
const time = microzig.drivers.time;
const std = @import("std");

//timer ctx
var tim_ctx: ?timer.GPTimer = null;
var period: u32 = 0;
var get_time: ?*const fn () time.Absolute = null;
var deinit_fn: ?*const fn () void = null;

pub fn deinit() void {
    const callback = deinit_fn orelse return;
    callback();
}

///Starts time counting using RTC.
///NOTE: it is necessary to configure the RTC clock source before starting
///NOTE: not recommended for applications that require microsecond precision
///NOTE: initialize once per backup domain reset
pub fn init_rtc() void {
    //Enable Backup domain clocks
    rcc.enable_clock(.PWR);
    rcc.enable_clock(.BKP);

    //disable Write protection to write into RTC register
    bkp.set_data_protection(false);
    rtc.enable(true);

    rtc.apply(.{
        .counter_start_value = 0,
        .prescaler = @intCast(rcc.get_clock(.RTC) - 1),
    });
    // HSE/128 is a special case that requires DBP always disabled
    if (microzig.chip.peripherals.RCC.BDCR.read().RTCSEL != .HSE) {
        bkp.set_data_protection(true);
        rcc.disable_clock(.PWR);
        rcc.disable_clock(.BKP);
    }
    get_time = rtc_get_time_since_boot;
    deinit_fn = deinit_rtc;
}
///timekeeping with timers based on the STM32_Driver from Rust Embassy:
///https://github.com/embassy-rs/embassy/blob/539837a7485381f83ef078595a4e248a0ea11436/embassy-stm32/src/time_driver.rs#L176
///NOTE: deinit does not disable the peripheral clock
pub fn init_timer(comptime tim: timer.Instances) void {
    //comptime checks
    comptime {
        const tim_n = @tagName(tim);
        const tim_id = tim_n[3] - '0';
        if (tim_id > 5) @compileError("Only timer 2-5 are supported for now");
    }
    const tim_id = @field(rcc.Peripherals, @tagName(tim));
    const clk = rcc.get_clock(tim_id);
    rcc.enable_clock(tim_id);

    const gptim = timer.GPTimer.init(tim);
    //configure the timer with interrupt on overflow
    gptim.timer_general_config(.{
        .prescaler = @intCast((clk / 1_000_000) - 1), //1uS per tick
        .enable_update_interrupt = true,
        .counter_mode = .up,
    });
    //configure channel CC1 with interrupt on compare
    gptim.configure_ccr(0, .{
        .ch_mode = .{ .compare = .{ .mode = .ActiveOnMatch } },
        .channel_interrupt_enable = true,
    });

    gptim.load_ccr(0, 0x8000);
    gptim.software_update();

    //clear any pending interrupt before starting
    gptim.clear_interrupts();

    microzig.interrupt.enable_interrupts();
    microzig.interrupt.enable(@field(microzig.cpu.ExternalInterrupt, @tagName(tim)));
    gptim.start();

    tim_ctx = gptim;
    get_time = timer_get_time_since_boot;
    deinit_fn = deinit_timer;
}

fn deinit_rtc() void {
    rcc.enable_clock(.PWR);
    rcc.enable_clock(.BKP);

    //disable Write protection to write into RTC register
    bkp.set_data_protection(false);
    rtc.enable(false);

    rcc.disable_clock(.PWR);
    rcc.disable_clock(.BKP);

    deinit_fn = null;
    get_time = null;
}

fn rtc_get_time_since_boot() time.Absolute {
    const rtc_freq: u64 = rcc.get_clock(.RTC);
    var sec: u64 = rtc.read_counter();
    var sec_frac: u64 = rtc.read_frac();
    const sec2: u64 = rtc.read_counter();

    //check for roll over
    if (sec != sec2) {
        @branchHint(.unlikely); // a very rare case due to the high speed of APB1 compared to the RTC
        sec = sec2;
        sec_frac = rtc.read_frac();
    }

    const frac = rtc_freq - sec_frac;
    const us: u64 = (sec * 1_000_000) + (frac * 1_000_000) / rtc_freq;
    return @enumFromInt(us);
}

fn deinit_timer() void {
    get_time = null;
    deinit_fn = null;
    const tim = tim_ctx orelse return;
    tim.stop();
    tim.clear_interrupts();
    tim.clear_configs();
    tim_ctx = null;
    period = 0;
}

fn timer_get_time_since_boot() time.Absolute {
    const tim = tim_ctx orelse return @enumFromInt(0);
    const p = microzig.cpu.atomic.load(u32, &period, .acquire);
    const counter = tim.get_counter();
    const ticks = (@as(u64, p) << 15) + @as(u64, counter ^ ((p & 1) << 15));
    return @enumFromInt(ticks);
}

pub fn TIM_handler() callconv(.c) void {
    const gptim = tim_ctx orelse return;
    const event = gptim.get_interrupt_flags();
    if (event.update or event.channel1) {
        _ = microzig.cpu.atomic.add(u32, &period, 1);
    }
    gptim.clear_interrupts();
}

pub fn get_time_since_boot() time.Absolute {
    const callback = get_time orelse return @enumFromInt(0);
    return callback();
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
