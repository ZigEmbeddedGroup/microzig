// SoftDevice Manager (SDM) - enable, disable, and query the SoftDevice.

const svc = @import("svc.zig");
const err = @import("err.zig");
const Error = err.Error;

// SVC numbers (SDM_SVC_BASE = 0x10)
const SD_SOFTDEVICE_ENABLE = 0x10;
const SD_SOFTDEVICE_DISABLE = 0x11;
const SD_SOFTDEVICE_IS_ENABLED = 0x12;
const SD_SOFTDEVICE_VECTOR_TABLE_BASE_SET = 0x13;

pub const ClockLfSrc = enum(u8) {
    rc = 0,
    xtal = 1,
    synth = 2,
};

pub const ClockLfAccuracy = enum(u8) {
    ppm_250 = 0,
    ppm_500 = 1,
    ppm_150 = 2,
    ppm_100 = 3,
    ppm_75 = 4,
    ppm_50 = 5,
    ppm_30 = 6,
    ppm_20 = 7,
    ppm_10 = 8,
    ppm_5 = 9,
    ppm_2 = 10,
    ppm_1 = 11,
};

pub const ClockLfCfg = extern struct {
    source: ClockLfSrc,
    rc_ctiv: u8,
    rc_temp_ctiv: u8,
    accuracy: ClockLfAccuracy,
};

pub const FaultId = enum(u32) {
    sd_assert = 0x00000001,
    app_memacc = 0x00001001,
    _,
};

pub const FaultHandler = *const fn (id: FaultId, pc: u32, info: u32) callconv(.C) void;

pub fn enable(cfg: ?*const ClockLfCfg, handler: FaultHandler) Error!void {
    return err.check(svc.svcall2(
        SD_SOFTDEVICE_ENABLE,
        if (cfg) |p| @intFromPtr(p) else 0,
        @intFromPtr(handler),
    ));
}

pub fn disable() Error!void {
    return err.check(svc.svcall0(SD_SOFTDEVICE_DISABLE));
}

pub fn is_enabled() Error!bool {
    var result: u8 = 0;
    try err.check(svc.svcall1(SD_SOFTDEVICE_IS_ENABLED, @intFromPtr(&result)));
    return result != 0;
}

pub fn set_vector_table_base(address: u32) Error!void {
    return err.check(svc.svcall1(SD_SOFTDEVICE_VECTOR_TABLE_BASE_SET, address));
}
