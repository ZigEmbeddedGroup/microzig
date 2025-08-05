const std = @import("std");
const microzig = @import("microzig");

const pwd = microzig.chip.peripherals.PWR;
const PDDS = microzig.chip.types.peripherals.pwr_f1.PDDS;

pub const PDVThreshold = enum(u3) {
    V2_2,
    V2_3,
    V2_4,
    V2_5,
    V2_6,
    V2_7,
    V2_8,
    V2_9,
};

pub const DeepsleepModes = enum(u1) {
    stop,
    standby,
};

pub const VoltRegulatorMode = enum(u1) {
    on,
    off,
};

pub const Events = packed struct(u2) {
    Standby: bool = false,
    Wakeup: bool = false,
};

pub const PowerConfig = struct {
    pdv_trhreshold: PDVThreshold = .V2_9,
    deepsleep_mode: DeepsleepModes = .stop, //define the deepsleep behavior
    volt_regulator_mode: VoltRegulatorMode = .on, //define the voltage regulator behavior , only used if `deepsleep_mode` is set to `stop`
    wakeup_pin: bool = false, //enable/disable the wakeup pin
};

pub inline fn apply(config: PowerConfig) void {
    pwd.CR.modify(.{
        .PLS = @intFromEnum(config.pdv_trhreshold),
        .PDDS = @as(PDDS, @enumFromInt(@intFromEnum(config.deepsleep_mode))),
        .LPDS = @intFromEnum(config.volt_regulator_mode),
    });
    pwd.CSR.modify(.{ .EWUP = @intFromBool(config.wakeup_pin) });
}

///enable/disable the power detection peripheral.
pub inline fn set_pdv(set: bool) void {
    pwd.CR.modify(.{ .PVDE = @intFromBool(set) });
}

///get the current power detection status.
/// 0 = VDD/VDDA is higher than the threshold.
/// 1 = VDD/VDDA is lower than the threshold.
pub inline fn pdv_status() u1 {
    return pwd.CSR.read().PVDO;
}

///enable/disable the backup domain write protection.
/// this is used to protect the RTC and backup registers.
///
/// this function also exist in the `hal.backup` module.
pub inline fn backup_domain_protection(set: bool) void {
    pwd.CR.modify(.{ .DBP = @intFromBool(!set) });
}

pub inline fn get_events() Events {
    const csr = pwd.CSR.read();
    return Events{
        .Standby = csr.SBF != 0,
        .Wakeup = csr.WUF != 0,
    };
}

pub inline fn clear_events() void {
    pwd.CR.modify(.{ .CWUF = 1, .CSBF = 1 });
}
