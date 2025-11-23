const microzig = @import("microzig");
const backup_domain_protection = microzig.hal.power.backup_domain_protection;

const bkp = microzig.chip.peripherals.BKP;
pub const ASOS = microzig.chip.types.peripherals.bkp_v1.ASOS;
pub const TPAL = microzig.chip.types.peripherals.bkp_v1.TPAL;

const bkp_addr = @intFromPtr(bkp);
const BKPData = packed struct(u32) {
    data: u16,
    padding16: u16 = 0,
};

///This function is used to reset the backup domain and the RTC.
/// it's is the same as `hal.rcc.reset_backup_domain()` and is here for convenience.
pub const reset = @import("rcc.zig").reset_backup_domain;

/// this data is retained as long as the backup domain is powered. (by VDD or VBAT)
/// it also can be cleared by the TAMPER pin event.
pub const BackupData1: *[10]BKPData = @ptrFromInt(bkp_addr + 0x04);
pub const BackupData2: *[31]BKPData = @ptrFromInt(bkp_addr + 0x40);

///enable/disable the backup domain write protection.
///
/// NOTE: this is the same function as `hal.power.backup_domain_protection` and is here for convenience.
pub inline fn set_data_protection(on: bool) void {
    backup_domain_protection(on);
}

///reset the entire backup domain.
pub inline fn reset_backup_domain() void {
    microzig.chip.peripherals.RCC.BDCR.modify_one("BDRST", 1);
    microzig.chip.peripherals.RCC.BDCR.modify_one("BDRST", 0);
}

///enable the tamper detection feature.
/// when tamper pin is activated, the backup domain is reset and the tamper detection flag is set.
/// the backup domain will remain in reset state until the tamper event flag is cleared by `tamper_event_clear`.
pub inline fn enable_tamper_detection(trigger_level: TPAL) void {
    bkp.CR.modify(.{
        .TPE = 1,
        .TPAL = trigger_level,
    });
}

pub inline fn disable_tamper_detection() void {
    bkp.CR.modify_one("TPE", 0);
}

pub inline fn set_tamper_interrupt(on: bool) void {
    bkp.CSR.modify_one("TPIE", @intFromBool(on));
}

pub inline fn check_tamper_event() bool {
    return bkp.CSR.read().TEF != 0;
}

pub inline fn tamper_event_clear() void {
    bkp.CSR.modify_one("CTE", 1);
}

pub inline fn tamper_interrupt_clear() void {
    bkp.CSR.modify_one("CTI", 1);
}

//----- RTC Functions -----

///select the RTC event output on the TAMPER pin.
///tamper function must be disabled to avoid activation of the tamper detection feature.
pub inline fn rtc_event_output(event: ASOS) void {
    bkp.RTCCR.modify_one("ASOS", event);
}

///enable/disable the RTC event output on the TAMPER pin.
pub inline fn set_rtc_event_output(on: bool) void {
    bkp.RTCCR.modify_one("ASOE", @intFromBool(on));
}

///enable/disable the RTC clock output on the TAMPER pin.
/// if enabled, the (RTC clock)/64 is output on the TAMPER pin.
///
/// NOTE: tamper function must be disabled to avoid activation of the tamper detection feature.
pub inline fn set_RTC_clock_output(on: bool) void {
    bkp.RTCCR.modify_one("CCO", @intFromBool(on));
}

///This value indicates the number of clock pulses that will be ignored every 2^20 clock pulses.
pub inline fn RTC_calibration(CAL: u7) void {
    bkp.RTCCR.modify_one("CAL", CAL);
}
