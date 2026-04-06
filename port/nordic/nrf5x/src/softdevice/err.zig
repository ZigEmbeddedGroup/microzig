// Nordic SoftDevice error codes mapped to a Zig error set.

pub const Error = error{
    SvcHandlerMissing,
    SoftdeviceNotEnabled,
    Internal,
    NoMem,
    NotFound,
    NotSupported,
    InvalidParam,
    InvalidState,
    InvalidLength,
    InvalidFlags,
    InvalidData,
    DataSize,
    Timeout,
    Null,
    Forbidden,
    InvalidAddr,
    Busy,
    ConnCount,
    Resources,

    // SDM errors (0x1000+)
    LfclkSourceUnknown,
    IncorrectInterruptConfiguration,
    IncorrectClenr0,

    // SoC errors (0x2000+)
    MutexAlreadyTaken,
    NvicInterruptNotAvailable,
    NvicInterruptPriorityNotAllowed,
    NvicShouldNotReturn,
    PowerModeUnknown,
    PowerPofThresholdUnknown,
    PowerOffShouldNotReturn,
    RandNotEnoughValues,
    PpiInvalidChannel,
    PpiInvalidGroup,

    // BLE stack errors (0x3000+)
    BleNotEnabled,
    BleInvalidConnHandle,
    BleInvalidAttrHandle,
    BleInvalidAdvHandle,
    BleInvalidRole,
    BleBlockedByOtherLinks,

    // GAP errors (0x3200+)
    GapUuidListMismatch,
    GapDiscoverableWithWhitelist,
    GapInvalidBleAddr,
    GapWhitelistInUse,
    GapDeviceIdentitiesInUse,
    GapDeviceIdentitiesDuplicate,

    // GATTC errors (0x3300+)
    GattcProcNotPermitted,

    // GATTS errors (0x3400+)
    GattsInvalidAttrType,
    GattsSysAttrMissing,

    Unknown,
};

pub fn check(ret: u32) Error!void {
    if (ret == 0) return;
    return from_code(ret);
}

pub fn from_code(code: u32) Error {
    return switch (code) {
        0x01 => Error.SvcHandlerMissing,
        0x02 => Error.SoftdeviceNotEnabled,
        0x03 => Error.Internal,
        0x04 => Error.NoMem,
        0x05 => Error.NotFound,
        0x06 => Error.NotSupported,
        0x07 => Error.InvalidParam,
        0x08 => Error.InvalidState,
        0x09 => Error.InvalidLength,
        0x0A => Error.InvalidFlags,
        0x0B => Error.InvalidData,
        0x0C => Error.DataSize,
        0x0D => Error.Timeout,
        0x0E => Error.Null,
        0x0F => Error.Forbidden,
        0x10 => Error.InvalidAddr,
        0x11 => Error.Busy,
        0x12 => Error.ConnCount,
        0x13 => Error.Resources,

        0x1000 => Error.LfclkSourceUnknown,
        0x1001 => Error.IncorrectInterruptConfiguration,
        0x1002 => Error.IncorrectClenr0,

        0x2000 => Error.MutexAlreadyTaken,
        0x2001 => Error.NvicInterruptNotAvailable,
        0x2002 => Error.NvicInterruptPriorityNotAllowed,
        0x2003 => Error.NvicShouldNotReturn,
        0x2004 => Error.PowerModeUnknown,
        0x2005 => Error.PowerPofThresholdUnknown,
        0x2006 => Error.PowerOffShouldNotReturn,
        0x2007 => Error.RandNotEnoughValues,
        0x2008 => Error.PpiInvalidChannel,
        0x2009 => Error.PpiInvalidGroup,

        0x3001 => Error.BleNotEnabled,
        0x3002 => Error.BleInvalidConnHandle,
        0x3003 => Error.BleInvalidAttrHandle,
        0x3004 => Error.BleInvalidAdvHandle,
        0x3005 => Error.BleInvalidRole,
        0x3006 => Error.BleBlockedByOtherLinks,

        0x3200 => Error.GapUuidListMismatch,
        0x3201 => Error.GapDiscoverableWithWhitelist,
        0x3202 => Error.GapInvalidBleAddr,
        0x3203 => Error.GapWhitelistInUse,
        0x3204 => Error.GapDeviceIdentitiesInUse,
        0x3205 => Error.GapDeviceIdentitiesDuplicate,

        0x3300 => Error.GattcProcNotPermitted,

        0x3400 => Error.GattsInvalidAttrType,
        0x3401 => Error.GattsSysAttrMissing,

        else => Error.Unknown,
    };
}
