const std = @import("std");
const types = @import("../types.zig");
const assert = std.debug.assert;

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

pub const SubType = enum(u8) {
    Hid = 0x21,
    Report = 0x22,
    Physical = 0x23,
};

pub const RequestType = enum(u8) {
    GetReport = 0x01,
    GetIdle = 0x02,
    GetProtocol = 0x03,
    SetReport = 0x09,
    SetIdle = 0x0a,
    SetProtocol = 0x0b,
};

/// USB HID descriptor
pub const Hid = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 9);
    }

    length: u8 = @sizeOf(@This()),
    /// Type of this descriptor
    descriptor_type: SubType = .Hid,
    /// Numeric expression identifying the HID Class Specification release
    bcd_hid: types.U16Le,
    /// Numeric expression identifying country code of the localized hardware
    country_code: u8,
    /// Numeric expression specifying the number of class descriptors
    num_descriptors: u8,
    /// Type of HID class report
    report_type: SubType = .Report,
    /// The total size of the Report descriptor
    report_length: types.U16Le,
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

pub fn report_item(
    typ: u2,
    tag: u4,
    data: anytype,
) [data.len + 1]u8 {
    comptime if (data.len != 0) assert(@TypeOf(data[0]) == u8);
    const first = (@as(u8, tag) << 4) | (@as(u8, typ) << 2) | @as(u2, data.len + 1);

    return switch (@typeInfo(@TypeOf(data))) {
        .array, .@"struct" => .{first} ++ data,
        .pointer => .{first} ++ data.*,
        else => @compileLog(data),
    };
}

// Main Items
// -------------------------------------------------

pub fn collection(data: CollectionItem) [2]u8 {
    return report_item(
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.Collection),
        .{@intFromEnum(data)},
    );
}

pub fn input(data: u8) [2]u8 {
    return report_item(
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.Input),
        .{data},
    );
}

pub fn output(data: u8) [2]u8 {
    return report_item(
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.Output),
        .{data},
    );
}

pub fn collection_end() [1]u8 {
    return report_item(
        @intFromEnum(ReportItemTypes.Main),
        @intFromEnum(ReportItemMainGroup.CollectionEnd),
        .{},
    );
}

// Global Items
// -------------------------------------------------

pub fn usage_page(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.UsagePage),
        data,
    );
}

pub fn logical_min(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.LogicalMin),
        data,
    );
}

pub fn logical_max(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.LogicalMax),
        data,
    );
}

pub fn report_size(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.ReportSize),
        data,
    );
}

pub fn report_count(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Global),
        @intFromEnum(GlobalItem.ReportCount),
        data,
    );
}

// Local Items
// -------------------------------------------------

pub fn usage(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Local),
        @intFromEnum(LocalItem.Usage),
        data,
    );
}

pub fn usage_min(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Local),
        @intFromEnum(LocalItem.UsageMin),
        data,
    );
}

pub fn usage_max(data: anytype) [data.len + 1]u8 {
    comptime assert(@TypeOf(data[0]) == u8);
    return report_item(
        @intFromEnum(ReportItemTypes.Local),
        @intFromEnum(LocalItem.UsageMax),
        data,
    );
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Report Descriptors
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const report = struct {
    pub const FidoU2f = usage_page(UsageTable.fido) //
        ++ usage(FidoAllianceUsage.u2fhid) //
        ++ collection(CollectionItem.Application) //
        // Usage Data In
        ++ usage(FidoAllianceUsage.data_in) //
        ++ logical_min("\x00") //
        ++ logical_max("\xff\x00") //
        ++ report_size("\x08") //
        ++ report_count("\x40") //
        ++ input(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
        // Usage Data Out
        ++ usage(FidoAllianceUsage.data_out) //
        ++ logical_min("\x00") //
        ++ logical_max("\xff\x00") //
        ++ report_size("\x08") //
        ++ report_count("\x40") //
        ++ output(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
        // End
        ++ collection_end();

    pub const GenericInOut = usage_page(UsageTable.vendor) //
        ++ usage("\x01") //
        ++ collection(CollectionItem.Application) //
        // Usage Data In
        ++ usage("\x02") //
        ++ logical_min("\x00") //
        ++ logical_max("\xff\x00") //
        ++ report_size("\x08") //
        ++ report_count("\x40") //
        ++ input(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
        // Usage Data Out
        ++ usage("\x03") //
        ++ logical_min("\x00") //
        ++ logical_max("\xff\x00") //
        ++ report_size("\x08") //
        ++ report_count("\x40") //
        ++ output(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
        // End
        ++ collection_end();

    /// Common keyboard report format, conforming to the boot protocol.
    /// See Appendix B.1 of the USB HID specification:
    /// https://usb.org/sites/default/files/hid1_11.pdf
    pub const Keyboard = usage_page(UsageTable.desktop) ++ usage(DesktopUsage.keyboard) ++ collection(.Application)
        // Input: modifier key bitmap
    ++ usage_page(UsageTable.keyboard) ++ usage_min("\xe0") ++ usage_max("\xe7") ++ logical_min("\x00") ++ logical_max("\x01") ++ report_count("\x08") ++ report_size("\x01") ++ input(HID_DATA | HID_VARIABLE | HID_ABSOLUTE) //
        // Reserved 8 bits
    ++ report_count("\x01") ++ report_size("\x08") ++ input(HID_CONSTANT)
        // Output: indicator LEDs
    ++ usage_page(UsageTable.led) ++ usage_min("\x01") ++ usage_max("\x05") ++ report_count("\x05") ++ report_size("\x01") ++ output(HID_DATA | HID_VARIABLE | HID_ABSOLUTE)
        // Padding
    ++ report_count("\x01") ++ report_size("\x03") ++ output(HID_CONSTANT)
        // Input: up to 6 pressed key codes
    ++ usage_page(UsageTable.keyboard) ++ usage_min("\x00") ++ usage_max("\xff\x00") ++ logical_min("\x00") ++ logical_max("\xff\x00") ++ report_count("\x06") ++ report_size("\x08") ++ input(HID_DATA | HID_ARRAY | HID_ABSOLUTE)
        // End
    ++ collection_end();

    test "create hid report item" {
        const r = report_item(
            2,
            0,
            3,
            "\x22\x11",
        );

        try std.testing.expectEqual(@as(usize, @intCast(3)), r.len);
        try std.testing.expectEqual(@as(u8, @intCast(50)), r[0]);
        try std.testing.expectEqual(@as(u8, @intCast(0x22)), r[1]);
        try std.testing.expectEqual(@as(u8, @intCast(0x11)), r[2]);
    }

    test "create hid fido usage page" {
        const f = usage_page(UsageTable.fido);

        try std.testing.expectEqual(@as(usize, @intCast(3)), f.len);
        try std.testing.expectEqual(@as(u8, @intCast(6)), f[0]);
        try std.testing.expectEqual(@as(u8, @intCast(0xd0)), f[1]);
        try std.testing.expectEqual(@as(u8, @intCast(0xf1)), f[2]);
    }

    test "report descriptor fido" {
        _ = FidoU2f;
    }
};
