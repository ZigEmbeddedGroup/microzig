const std = @import("std");
const assert = std.debug.assert;

const descriptor = @import("../descriptor.zig");
const types = @import("../types.zig");

pub const RequestType = enum(u8) {
    GetReport = 0x01,
    GetIdle = 0x02,
    GetProtocol = 0x03,
    SetReport = 0x09,
    SetIdle = 0x0a,
    SetProtocol = 0x0b,
    _,
};

/// USB HID descriptor
pub const HID = extern struct {
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
        _,
    };

    pub const Type = enum(u8) {
        HID = 0x21,
        Report = 0x22,
        Physical = 0x23,
        _,
    };

    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 9);
    }

    length: u8 = @sizeOf(@This()),
    /// Type of this descriptor
    descriptor_type: descriptor.Type = .CsDevice,
    /// Numeric expression identifying the HID Class Specification release
    /// 1.11 seems to be the only one
    bcd_hid: types.Version = .v1_11,
    /// Numeric expression identifying country code of the localized hardware
    country_code: CountryCode,
    /// Numeric expression specifying the number of class descriptors
    num_descriptors: u8,
    /// Type of HID class report
    report_type: Type = .Report,
    /// The total size of the Report descriptor
    report_length: types.U16_Le,
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
    pub const desktop: [1]u8 = "\x01".*;
    pub const keyboard: [1]u8 = "\x07".*;
    pub const led: [1]u8 = "\x08".*;
    pub const fido: [2]u8 = "\xD0\xF1".*;
    pub const vendor: [2]u8 = "\x00\xFF".*;
};

pub const FidoAllianceUsage = struct {
    pub const u2fhid: [1]u8 = "\x01".*;
    pub const data_in: [1]u8 = "\x20".*;
    pub const data_out: [1]u8 = "\x21".*;
};

pub const DesktopUsage = struct {
    pub const keyboard: [1]u8 = "\x06".*;
};

pub const HID_DATA: u8 = 0 << 0;
pub const HID_CONSTANT: u8 = 1 << 0;

pub const HID_ARRAY = 0 << 1;
pub const HID_VARIABLE = 1 << 1;

pub const HID_ABSOLUTE = 0 << 2;
pub const HID_RELATIVE = 1 << 2;

pub const HID_WRAP_NO = 0 << 3;
pub const HID_WRAP = 1 << 3;

pub const HID_LINEAR = 0 << 4;
pub const HID_NONLINEAR = 1 << 4;

pub const HID_PREFERRED_STATE = 0 << 5;
pub const HID_PREFERRED_NO = 1 << 5;

pub const HID_NO_NULL_POSITION = 0 << 6;
pub const HID_NULL_STATE = 1 << 6;

pub const HID_NON_VOLATILE = 0 << 7;
pub const HID_VOLATILE = 1 << 7;

pub const HID_BITFIELD = 0 << 8;
pub const HID_BUFFERED_BYTES = 1 << 8;

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
