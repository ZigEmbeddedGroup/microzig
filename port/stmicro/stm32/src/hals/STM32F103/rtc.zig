const microzig = @import("microzig");
const rcc = @import("rcc.zig");
const rtc = microzig.chip.peripherals.RTC;

///enable the RTC clock.
///this function is the same as `hal.rcc.enable_RTC()`.
///it is here for convenience.
pub const enable = rcc.enable_RTC;
pub const is_running = rcc.rtc_running;

///RTC clock source is selected in the clock configs
pub const Config = struct {
    prescaler: u20 = 0,
    alarm: u32 = 0,
    counter_start_value: u32 = 0,
};

pub const InterruptConfig = struct {
    second_interrupt: bool = false,
    alarm_interrupt: bool = false,
    overflow_interrupt: bool = false,
};

pub const Events = packed struct(u3) {
    overflow: bool = false,
    alarm: bool = false,
    second: bool = false,
};

pub fn enter_config_mode() void {
    while (rtc.CRL.read().RTOFF == .Ongoing) asm volatile ("" ::: "memory");
    //enter in config mode
    rtc.CRL.modify_one("CNF", 1);
}

pub fn exit_config_mode() void {
    //exit config mode
    rtc.CRL.modify_one("CNF", 0);
    //wait for the config to finish
    while (rtc.CRL.read().RTOFF == .Ongoing) asm volatile ("" ::: "memory");
}

pub fn apply(config: Config) void {
    const pll_high: u4 = @truncate(config.prescaler >> 16);
    const pll_low: u16 = @truncate(config.prescaler);

    const alarm = config.alarm;
    const alr_high: u16 = @truncate(alarm >> 16);
    const alr_low: u16 = @truncate(alarm);

    const start = config.counter_start_value;
    const str_high: u16 = @truncate(start >> 16);
    const str_low: u16 = @truncate(start);

    enter_config_mode();

    //config prescaler
    rtc.PRLH.modify_one("PRLH", pll_high);
    rtc.PRLL.modify_one("PRLL", pll_low);

    //config alarm
    rtc.ALRH.modify_one("ALRH", alr_high);
    rtc.ALRL.modify_one("ALRL", alr_low);

    //config counter
    rtc.CNTH.modify_one("CNTH", str_high);
    rtc.CNTL.modify_one("CNTL", str_low);

    exit_config_mode();
}

///Interrups are one of the only things that is reset by the system reset,
///so we needs to apply them every time a reset occurs.
pub fn apply_interrupts(config: InterruptConfig) void {
    enter_config_mode();
    rtc.CRH.modify(.{
        .SECIE = @intFromBool(config.second_interrupt),
        .ALRIE = @intFromBool(config.alarm_interrupt),
        .OWIE = @intFromBool(config.overflow_interrupt),
    });
    exit_config_mode();
}

///Wait for RTC registers to synchronize.
///After a reset, reading RTC registers may return unsynchronized or corrupted data.
pub fn busy_sync() void {
    const cr = rtc.CRL.read();
    while (cr.RSF == 0) asm volatile ("" ::: "memory");
    rtc.CRL.modify_one("RSF", 0);
}

pub fn read_events() Events {
    const crl = rtc.CRL.read();
    return Events{
        .alarm = crl.ALRF == 1,
        .overflow = crl.OWF == 1,
        .second = crl.SECF == 1,
    };
}

pub fn clear_events(events: Events) void {
    rtc.CRL.modify(.{
        .ALRF = @intFromBool(!events.alarm),

        .OWF = @intFromBool(!events.overflow),

        .SECF = @intFromBool(!events.second),
    });
}

///read the current frac of the RTC counter.
pub fn read_frac() u20 {
    return @truncate(rtc.DIVL.read().DIVL | (@as(u32, (rtc.DIVH.read().DIVH)) << 16));
}

pub fn read_counter() u32 {
    const low = rtc.CNTL.read().CNTL;
    const high = rtc.CNTH.read().CNTH;
    return low | (@as(u32, (high)) << 16);
}
