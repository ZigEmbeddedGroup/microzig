// SoftDevice S122 — peripheral (mesh-focused).
// Different GAP SVC offsets from S112/S113/S132/S140.
// BLE stack for nRF52820, nRF52833, nRF52840.

pub const variant = @import("variant.zig").Variant.s122;
pub const gap = @import("gap.zig").Api(.s122);
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
