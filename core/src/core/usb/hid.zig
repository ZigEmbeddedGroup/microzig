//! USB HID
//!
//! ## Interfaces
//!
//! HID class devices use Control and Interrupt pipes for communication
//!
//! 1. Control for USB control and data classes, reports, data from host
//! 2. Interrupt for asynchronous and low latency data to the device
//!
//! ## Settings
//!
//! ### UsbInterfaceDescriptor related settings:
//! The class type for a HID class device is defined by the Interface descriptor.
//! The subclass field is used to identify Boot Devices.
//!
//! * `interface_subclass` - 1 if boot interface, 0 else (most of the time)
//! * `interface_protocol` - 0 if no boot interface, 1 if keyboard boot interface, 2 if mouse BI
//!
//! ## Nice to know
//!
//! The host usually won't ask for the HID descriptor even if the other descriptors
//! indicate that the given device is a HID device, i. e., you should just pass the
//! HID descriptor together with the configuration descriptor.
//!
//! ## Descriptors
//!
//! ### Report
//!
//! A Report descriptor describes each piece of data that the device generates
//! and what the data is actually measuring (e.g., position or button state). The
//! descriptor consists of one or more items and answers the following questions:
//!
//! 1. Where should the input be routed to (e.g., mouse or joystick API)?
//! 2. Should the software assign a functionality to the input?
//!
//! ### Physical
//!
//! ...
//!
//! ### HID
//!
//! The HID descriptor identifies the length and type of subordinate descriptors for device.

const std = @import("std");

const types = @import("types.zig");
const utils = @import("utils.zig");

const DescType = types.DescType;
const bos = utils.BosConfig;

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Common Data Types
// +++++++++++++++++++++++++++++++++++++++++++++++++

//          ...
//           |
//           v
// -------------------------
// |  InterfaceDescriptor  |
// -------------------------
//       |        |
//       |        -----------------
//       |                        |
//       v                        v
//     ...         --------------------------
//                 |     HidDescriptor      |
//                 --------------------------
//                     |              |
//               ------               --------
//               |                           |
//               v                           v
//      -----------------------     ---------------------
//      |   ReportDescriptor  |     |    PhysicalDesc   |
//      -----------------------     ---------------------

pub const HidDescType = enum(u8) {
    Hid = 0x21,
    Report = 0x22,
    Physical = 0x23,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const HidRequestType = enum(u8) {
    GetReport = 0x01,
    GetIdle = 0x02,
    GetProtocol = 0x03,
    SetReport = 0x09,
    SetIdle = 0x0a,
    SetProtocol = 0x0b,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

/// USB HID descriptor
pub const HidDescriptor = struct {
    pub const const_descriptor_type = HidDescType.Hid;

    length: u8 = 9,
    /// Type of this descriptor
    descriptor_type: HidDescType = const_descriptor_type,
    /// Numeric expression identifying the HID Class Specification release
    bcd_hid: u16 align(1),
    /// Numeric expression identifying country code of the localized hardware
    country_code: u8,
    /// Numeric expression specifying the number of class descriptors
    num_descriptors: u8,
    /// Type of HID class report
    report_type: HidDescType = HidDescType.Report,
    /// The total size of the Report descriptor
    report_length: u16 align(1),

    pub fn serialize(self: *const @This()) [9]u8 {
        var out: [9]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = @intCast(self.bcd_hid & 0xff);
        out[3] = @intCast((self.bcd_hid >> 8) & 0xff);
        out[4] = self.country_code;
        out[5] = self.num_descriptors;
        out[6] = @intFromEnum(self.report_type);
        out[7] = @intCast(self.report_length & 0xff);
        out[8] = @intCast((self.report_length >> 8) & 0xff);
        return out;
    }
};

/// HID interface Subclass (for UsbInterfaceDescriptor)
pub const Subclass = enum(u8) {
    /// No Subclass
    None = 0,
    /// Boot Interface Subclass
    Boot = 1,
};

/// HID interface protocol
pub const Protocol = enum(u8) {
    /// No protocol
    None = 0,
    /// Keyboard (only if boot interface)
    Keyboard = 1,
    /// Mouse (only if boot interface)
    Mouse = 2,
};

/// HID request report type
pub const ReportType = enum(u8) {
    Invalid = 0,
    Input = 1,
    Output = 2,
    Feature = 3,
};

/// HID country codes
pub const CountryCode = enum(u8) {
    NotSupported = 0,
    Arabic,
    Belgian,
    CanadianBilingual,
    CanadianFrench,
    CzechRepublic,
    Danish,
    Finnish,
    French,
    German,
    Greek,
    Hebrew,
    Hungary,
    International,
    Italian,
    JapanKatakana,
    Korean,
    LatinAmerica,
    NetherlandsDutch,
    Norwegian,
    PersianFarsi,
    Poland,
    Portuguese,
    Russia,
    Slovakia,
    Spanish,
    Swedish,
    SwissFrench,
    SwissGerman,
    Switzerland,
    Taiwan,
    TurkishQ,
    Uk,
    Us,
    Yugoslavia,
    TurkishF,
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Report Descriptor Data Types
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const ReportItemTypes = enum(u2) {
    Main = 0,
    Global = 1,
    Local = 2,
};

pub const ReportItemMainGroup = enum(u4) {
    Input = 8,
    Output = 9,
    Collection = 10,
    Feature = 11,
    CollectionEnd = 12,
};

pub const CollectionItem = enum(u8) {
    Physical = 0,
    Application,
    Logical,
    Report,
    NamedArray,
    UsageSwitch,
    UsageModifier,
};

pub const GlobalItem = enum(u4) {
    UsagePage = 0,
    LogicalMin = 1,
    LogicalMax = 2,
    PhysicalMin = 3,
    PhysicalMax = 4,
    UnitExponent = 5,
    Unit = 6,
    ReportSize = 7,
    ReportId = 8,
    ReportCount = 9,
    Push = 10,
    Pop = 11,
};

pub const LocalItem = enum(u4) {
    Usage = 0,
    UsageMin = 1,
    UsageMax = 2,
    DesignatorIndex = 3,
    DesignatorMin = 4,
    DesignatorMax = 5,
    StringIndex = 7,
    StringMin = 8,
    StringMax = 9,
    Delimiter = 10,
};

pub const UsageTable = struct {
    const desktop: [1]u8 = "\x01".*;
    const keyboard: [1]u8 = "\x07".*;
    const led: [1]u8 = "\x08".*;
    const fido: [2]u8 = "\xD0\xF1".*;
    const vendor: [2]u8 = "\x00\xFF".*;
};

pub const FidoAllianceUsage = struct {
    const u2fhid: [1]u8 = "\x01".*;
    const data_in: [1]u8 = "\x20".*;
    const data_out: [1]u8 = "\x21".*;
};

pub const DesktopUsage = struct {
    const keyboard: [1]u8 = "\x06".*;
};

const HID_DATA: u8 = 0 << 0;
const HID_CONSTANT: u8 = 1 << 0;

const HID_ARRAY = 0 << 1;
const HID_VARIABLE = 1 << 1;

const HID_ABSOLUTE = 0 << 2;
const HID_RELATIVE = 1 << 2;

const HID_WRAP_NO = 0 << 3;
const HID_WRAP = 1 << 3;

const HID_LINEAR = 0 << 4;
const HID_NONLINEAR = 1 << 4;

const HID_PREFERRED_STATE = 0 << 5;
const HID_PREFERRED_NO = 1 << 5;

const HID_NO_NULL_POSITION = 0 << 6;
const HID_NULL_STATE = 1 << 6;

const HID_NON_VOLATILE = 0 << 7;
const HID_VOLATILE = 1 << 7;

const HID_BITFIELD = 0 << 8;
const HID_BUFFERED_BYTES = 1 << 8;

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Report Descriptor Functions
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub fn hid_report_item(
    comptime n: u2,
    typ: u2,
    tag: u4,
    data: [n]u8,
) [n + 1]u8 {
    var out: [n + 1]u8 = undefined;

    out[0] = (@as(u8, @intCast(tag)) << 4) | (@as(u8, @intCast(typ)) << 2) | n;

    var i: usize = 0;
    while (i < n) : (i += 1) {
        out[i + 1] = data[i];
    }

    return out;
}

// Main Items
// -------------------------------------------------

pub fn hid_collection(data: CollectionItem) [2]u8 {
    return hid_report_item(
        1,
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.Collection),
        std.mem.toBytes(@intFromEnum(data)),
    );
}

pub fn hid_input(data: u8) [2]u8 {
    return hid_report_item(
        1,
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.Input),
        std.mem.toBytes(data),
    );
}

pub fn hid_output(data: u8) [2]u8 {
    return hid_report_item(
        1,
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.Output),
        std.mem.toBytes(data),
    );
}

pub fn hid_collection_end() [1]u8 {
    return hid_report_item(
        0,
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.CollectionEnd),
        .{},
    );
}

// Global Items
// -------------------------------------------------

pub fn hid_usage_page(comptime n: u2, usage: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.UsagePage),
        usage,
    );
}

pub fn hid_usage_min(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Local),
        @intFromEnum(LocalItem.UsageMin),
        data,
    );
}

pub fn hid_usage_max(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Local),
        @intFromEnum(LocalItem.UsageMax),
        data,
    );
}

pub fn hid_logical_min(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.LogicalMin),
        data,
    );
}

pub fn hid_logical_max(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.LogicalMax),
        data,
    );
}

pub fn hid_report_size(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.ReportSize),
        data,
    );
}

pub fn hid_report_count(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.ReportCount),
        data,
    );
}

// Local Items
// -------------------------------------------------

pub fn hid_usage(comptime n: u2, data: [n]u8) [n + 1]u8 {
    return hid_report_item(
        n,
        @intFromEnum(ReportItemTypes.Local),
        @intFromEnum(LocalItem.Usage),
        data,
    );
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Report Descriptors
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const ReportDescriptorFidoU2f = hid_usage_page(2, UsageTable.fido) //
    ++ hid_usage(1, FidoAllianceUsage.u2fhid) //
    ++ hid_collection(CollectionItem.Application) //
    // Usage Data In
    ++ hid_usage(1, FidoAllianceUsage.data_in) //
    ++ hid_logical_min(1, "\x00".*) //
    ++ hid_logical_max(2, "\xff\x00".*) //
    ++ hid_report_size(1, "\x08".*) //
    ++ hid_report_count(1, "\x40".*) //
    ++ hid_input(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
    // Usage Data Out
    ++ hid_usage(1, FidoAllianceUsage.data_out) //
    ++ hid_logical_min(1, "\x00".*) //
    ++ hid_logical_max(2, "\xff\x00".*) //
    ++ hid_report_size(1, "\x08".*) //
    ++ hid_report_count(1, "\x40".*) //
    ++ hid_output(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
    // End
    ++ hid_collection_end();

pub const ReportDescriptorGenericInOut = hid_usage_page(2, UsageTable.vendor) //
    ++ hid_usage(1, "\x01".*) //
    ++ hid_collection(CollectionItem.Application) //
    // Usage Data In
    ++ hid_usage(1, "\x02".*) //
    ++ hid_logical_min(1, "\x00".*) //
    ++ hid_logical_max(2, "\xff\x00".*) //
    ++ hid_report_size(1, "\x08".*) //
    ++ hid_report_count(1, "\x40".*) //
    ++ hid_input(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
    // Usage Data Out
    ++ hid_usage(1, "\x03".*) //
    ++ hid_logical_min(1, "\x00".*) //
    ++ hid_logical_max(2, "\xff\x00".*) //
    ++ hid_report_size(1, "\x08".*) //
    ++ hid_report_count(1, "\x40".*) //
    ++ hid_output(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
    // End
    ++ hid_collection_end();

/// Common keyboard report format, conforming to the boot protocol.
/// See Appendix B.1 of the USB HID specification:
/// https://usb.org/sites/default/files/hid1_11.pdf
pub const ReportDescriptorKeyboard = hid_usage_page(1, UsageTable.desktop) //
    ++ hid_usage(1, DesktopUsage.keyboard) //
    ++ hid_collection(.Application) //
    // Input: modifier key bitmap
    ++ hid_usage_page(1, UsageTable.keyboard) //
    ++ hid_usage_min(1, "\xe0".*) //
    ++ hid_usage_max(1, "\xe7".*) //
    ++ hid_logical_min(1, "\x00".*) //
    ++ hid_logical_max(1, "\x01".*) //
    ++ hid_report_count(1, "\x08".*) //
    ++ hid_report_size(1, "\x01".*) //
    ++ hid_input(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
    // Reserved 8 bits
    ++ hid_report_count(1, "\x01".*) //
    ++ hid_report_size(1, "\x08".*) //
    ++ hid_input(HID_CONSTANT) //
    // Output: indicator LEDs
    ++ hid_usage_page(1, UsageTable.led) //
    ++ hid_usage_min(1, "\x01".*) //
    ++ hid_usage_max(1, "\x05".*) //
    ++ hid_report_count(1, "\x05".*) //
    ++ hid_report_size(1, "\x01".*) //
    ++ hid_output(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
    // Padding
    ++ hid_report_count(1, "\x01".*) //
    ++ hid_report_size(1, "\x03".*) //
    ++ hid_output(HID_CONSTANT) //
    // Input: up to 6 pressed key codes
    ++ hid_usage_page(1, UsageTable.keyboard) //
    ++ hid_usage_min(1, "\x00".*) //
    ++ hid_usage_max(2, "\xff\x00".*) //
    ++ hid_logical_min(1, "\x00".*) //
    ++ hid_logical_max(2, "\xff\x00".*) //
    ++ hid_report_count(1, "\x06".*) //
    ++ hid_report_size(1, "\x08".*) //
    ++ hid_input(HID_DATA | HID_ARRAY | HID_ABSOLUTE) //
    // End
    ++ hid_collection_end();

pub const HidClassDriver = struct {
    device: ?types.UsbDevice = null,
    ep_in: u8 = 0,
    ep_out: u8 = 0,
    hid_descriptor: []const u8 = &.{},
    report_descriptor: []const u8,

    fn init(ptr: *anyopaque, device: types.UsbDevice) void {
        var self: *HidClassDriver = @ptrCast(@alignCast(ptr));
        self.device = device;
    }

    fn open(ptr: *anyopaque, cfg: []const u8) !usize {
        var self: *HidClassDriver = @ptrCast(@alignCast(ptr));
        var curr_cfg = cfg;

        if (bos.try_get_desc_as(types.InterfaceDescriptor, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class != @intFromEnum(types.ClassCode.Hid)) return types.DriverErrors.UnsupportedInterfaceClassType;
        } else {
            return types.DriverErrors.ExpectedInterfaceDescriptor;
        }

        curr_cfg = bos.get_desc_next(curr_cfg);
        if (bos.try_get_desc_as(HidDescriptor, curr_cfg)) |_| {
            self.hid_descriptor = curr_cfg[0..bos.get_desc_len(curr_cfg)];
            curr_cfg = bos.get_desc_next(curr_cfg);
        } else {
            return types.DriverErrors.UnexpectedDescriptor;
        }

        for (0..2) |_| {
            if (bos.try_get_desc_as(types.EndpointDescriptor, curr_cfg)) |desc_ep| {
                switch (types.Endpoint.dir_from_address(desc_ep.endpoint_address)) {
                    .In => self.ep_in = desc_ep.endpoint_address,
                    .Out => self.ep_out = desc_ep.endpoint_address,
                }
                self.device.?.endpoint_open(curr_cfg[0..desc_ep.length]);
                curr_cfg = bos.get_desc_next(curr_cfg);
            }
        }

        return cfg.len - curr_cfg.len;
    }

    fn class_control(ptr: *anyopaque, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
        var self: *HidClassDriver = @ptrCast(@alignCast(ptr));

        switch (setup.request_type.type) {
            .Standard => {
                if (stage == .Setup) {
                    const hid_desc_type = HidDescType.from_u8(@intCast((setup.value >> 8) & 0xff));
                    const request_code = types.SetupRequest.from_u8(setup.request);

                    if (hid_desc_type == null or request_code == null) {
                        return false;
                    }

                    if (request_code.? == .GetDescriptor and hid_desc_type == .Hid) {
                        self.device.?.control_transfer(setup, self.hid_descriptor);
                    } else if (request_code.? == .GetDescriptor and hid_desc_type == .Report) {
                        self.device.?.control_transfer(setup, self.report_descriptor);
                    } else {
                        return false;
                    }
                }
            },
            .Class => {
                const hid_request_type = HidRequestType.from_u8(setup.request);
                if (hid_request_type == null) return false;

                switch (hid_request_type.?) {
                    .SetIdle => {
                        if (stage == .Setup) {
                            self.device.?.control_ack(setup);
                        }
                    },
                    else => {
                        return false;
                    },
                }
            },
            else => {
                return false;
            },
        }

        return true;
    }

    fn transfer(_: *anyopaque, _: u8, _: []u8) void {}

    pub fn driver(self: *@This()) types.UsbClassDriver {
        return .{
            .ptr = self,
            .fn_init = init,
            .fn_open = open,
            .fn_class_control = class_control,
            .fn_transfer = transfer,
        };
    }
};

test "create hid report item" {
    const r = hid_report_item(
        2,
        0,
        3,
        "\x22\x11".*,
    );

    try std.testing.expectEqual(@as(usize, @intCast(3)), r.len);
    try std.testing.expectEqual(@as(u8, @intCast(50)), r[0]);
    try std.testing.expectEqual(@as(u8, @intCast(0x22)), r[1]);
    try std.testing.expectEqual(@as(u8, @intCast(0x11)), r[2]);
}

test "create hid fido usage page" {
    const f = hid_usage_page(2, UsageTable.fido);

    try std.testing.expectEqual(@as(usize, @intCast(3)), f.len);
    try std.testing.expectEqual(@as(u8, @intCast(6)), f[0]);
    try std.testing.expectEqual(@as(u8, @intCast(0xd0)), f[1]);
    try std.testing.expectEqual(@as(u8, @intCast(0xf1)), f[2]);
}

test "report descriptor fido" {
    _ = ReportDescriptorFidoU2f;
}
