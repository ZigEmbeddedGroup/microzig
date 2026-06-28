// SoftDevice S113 — peripheral + observer (scanning).
// BLE stack for nRF52810, nRF52811, nRF52832, nRF52840.

pub const variant = @import("variant.zig").Variant.s113;
pub const gap = @import("gap.zig").Api(.s113);
pub const ble = @import("ble.zig");
pub const soc = @import("soc.zig");
pub const gattc = @import("gattc.zig");
pub const gatts = @import("gatts.zig");
pub const sdm = @import("sdm.zig");
pub const err = @import("err.zig");
pub const gatt = @import("gatt.zig");
pub const hci = @import("hci.zig");
pub const svc = @import("svc.zig");

pub const Error = err.Error;
