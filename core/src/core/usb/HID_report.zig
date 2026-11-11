const std = @import("std");
const usb = @import("../usb.zig");
const assert = std.debug.assert;

/// Reports are a list of tagged ?i32 values. Encoding is variable-length.
pub const Item = union(enum) {
    pub const Header = packed struct(u8) {
        pub const Payload = enum(u2) {
            null = 0,
            i8 = 1,
            i16 = 2,
            i32 = 3,
        };
        pub const Type = enum(u2) { main = 0, global = 1, local = 2, _ };

        len: Payload,
        type: Type,
        tag: u4,
    };

    pub const Collection = enum(i32) {
        Physical = 0,
        Application,
        Logical,
        Report,
        NamedArray,
        UsageSwitch,
        UsageModifier,
        _,
    };

    pub const UsagePage = enum(i32) {
        generic_desktop = 0x01,
        keyboard = 0x07,
        led = 0x08,
        fido = @as(i16, @bitCast(@as(u16, 0xF1D0))),
        vendor = 0xFF,
        _,
    };

    pub const Usage = union(UsagePage) {
        pub const GenericDesktop = enum(i32) {
            keyboard = 0x06,
            _,
        };

        pub const Keyboard = enum(i32) { _ };
        pub const Led = enum(i32) { _ };
        pub const Button = enum(i32) { _ };

        pub const Fido = enum(i32) {
            u2fhid = 0x01,
            data_in = 0x20,
            data_out = 0x21,
            _,
        };

        generic_desktop: GenericDesktop,
        keyboard: Keyboard,
        led: Led,
        fido: Fido,
        vendor: i32,

        pub fn local(self: @This()) i32 {
            return switch (self) {
                inline else => |x| @backingInt(x),
                .vendor => |x| x,
            };
        }
    };

    pub const InputOutput = packed struct(i8) {
        constant: bool = false, // HID_DATA/HID_CONSTANT
        variable: bool = false, // HID_ARRAY/HID_VARIABLE
        relative: bool = false, // HID_ABSOLUTE/HID_RELATIVE
        wrap: bool = false, // HID_WRAP_NO/HID_WRAP
        nonlinear: bool = false, // HID_LINEAR/HID_NONLINEAR
        not_preferred: bool = false, // HID_PREFERRED_STATE/HID_PREFERRED_NO
        null_state: bool = false, // HID_NO_NULL_POSITION/HID_NULL_STATE
        @"volatile": bool = false, // HID_NON_VOLATILE/HID_VOLATILE

        pub const dynamic: @This() = .{ .variable = true };
        pub const selector: @This() = .{};
        pub const static: @This() = .{ .constant = true };
    };

    pub const Data = struct {
        pub const Type = enum { dynamic, selector };

        usage: union(enum) {
            global_page: UsagePage,
            local: Usage,
            local_raw: i32,

            pub fn report(self: @This()) Item {
                return switch (self) {
                    .global_page => |page| .{ .global_usage_page = page },
                    .local => |usage| .local_usage_enum(usage),
                    .local_raw => |val| .{ .local_usage = val },
                };
            }
        },
        usage_range: ?[2]i32 = null,
        logical_range: ?[2]i32 = null,
        count: u31,
        Child: type,
        dir: usb.types.Dir,
        type: Type,
    };

    // main items
    main_input: InputOutput,
    main_output: InputOutput,
    main_collection: Collection,
    main_feature: ?i32,
    main_collection_end,

    // global items
    global_usage_page: UsagePage,
    global_logical_min: i32,
    global_logical_max: i32,
    global_physical_min: ?i32,
    global_physical_max: ?i32,
    global_unit_exponent: ?i32,
    global_unit: ?i32,
    global_report_size: u31,
    global_report_id: u31,
    global_report_count: u31,
    global_push: ?i32,
    global_pop: ?i32,

    // local items
    local_usage: i32,
    local_usage_min: i32,
    local_usage_max: i32,
    local_designator_index: ?i32,
    local_designator_min: ?i32,
    local_designator_max: ?i32,
    local_string_index: ?i32,
    local_string_min: ?i32,
    local_string_max: ?i32,
    local_delimiter,

    // helpers
    usage_page_and_local: Usage,
    global_logical_range: [2]i32,
    global_report_type: type,
    local_usage_range: [2]i32,
    data: Data,
    data_static: struct { usb.types.Dir, type },

    pub fn main_io(dir: usb.types.Dir, payload: InputOutput) @This() {
        return switch (dir) {
            .in => .{ .main_input = payload },
            .out => .{ .main_output = payload },
        };
    }

    pub fn local_usage_enum(usage: Usage) @This() {
        return .{ .local_usage = usage.local() };
    }

    pub fn encode_int(int_opt: ?i32) []const u8 {
        const asBytes = std.mem.asBytes;
        const toLittle = std.mem.nativeToLittle;
        const int = int_opt orelse return "";
        return if (std.math.cast(i8, int)) |result|
            &.{@bitCast(result)}
        else if (std.math.cast(i16, int)) |result|
            asBytes(&toLittle(i16, result))
        else
            asBytes(&toLittle(i32, int));
    }

    pub fn header(self: @This(), length: usize) ?Header {
        const len: Header.Payload = switch (length) {
            0 => .null,
            1 => .i8,
            2 => .i16,
            4 => .i32,
            else => unreachable,
        };
        const typ: Header.Type, const tag: u4 = switch (self) {
            .main_input => .{ .main, 8 },
            .main_output => .{ .main, 9 },
            .main_collection => .{ .main, 10 },
            .main_feature => .{ .main, 11 },
            .main_collection_end => .{ .main, 12 },
            .global_usage_page => .{ .global, 0 },
            .global_logical_min => .{ .global, 1 },
            .global_logical_max => .{ .global, 2 },
            .global_physical_min => .{ .global, 3 },
            .global_physical_max => .{ .global, 4 },
            .global_unit_exponent => .{ .global, 5 },
            .global_unit => .{ .global, 6 },
            .global_report_size => .{ .global, 7 },
            .global_report_id => .{ .global, 8 },
            .global_report_count => .{ .global, 9 },
            .global_push => .{ .global, 10 },
            .global_pop => .{ .global, 11 },
            .local_usage => .{ .local, 0 },
            .local_usage_min => .{ .local, 1 },
            .local_usage_max => .{ .local, 2 },
            .local_designator_index => .{ .local, 3 },
            .local_designator_min => .{ .local, 4 },
            .local_designator_max => .{ .local, 5 },
            .local_string_index => .{ .local, 7 },
            .local_string_min => .{ .local, 8 },
            .local_string_max => .{ .local, 9 },
            .local_delimiter => .{ .local, 10 },
            else => return null,
        };
        return .{ .len = len, .type = typ, .tag = tag };
    }

    pub fn type_size(T: type) comptime_int {
        return switch (@typeInfo(T)) {
            .int, .bool => @bitSizeOf(T),
            else => @compileError(@typeName(T) ++ " cannot be sent in a HID report"),
        };
    }

    pub fn create_report(items: []const @This()) []const u8 {
        var ret: []const u8 = "";

        for (items) |it| {
            ret = ret ++ switch (it) {
                .global_report_type => |T| blk: {
                    const count, const Child = switch (@typeInfo(T)) {
                        .array => |info| .{ info.len, info.child },
                        else => .{ 1, T },
                    };
                    break :blk create_report(&.{
                        .{ .global_report_count = count },
                        .{ .global_report_size = type_size(Child) },
                    });
                },
                .global_logical_range => |range| blk: {
                    assert(range[0] < range[1]);
                    break :blk create_report(&.{
                        .{ .global_logical_min = range[0] },
                        .{ .global_logical_max = range[1] },
                    });
                },
                .local_usage_range => |range| blk: {
                    assert(range[0] < range[1]);
                    break :blk create_report(&.{
                        .{ .local_usage_min = range[0] },
                        .{ .local_usage_max = range[1] },
                    });
                },
                .data => |info| create_report(&.{
                    info.usage.report(),
                    if (info.usage_range) |ur| .{ .local_usage_range = ur } else null,
                    .{ .global_logical_range = info.logical_range orelse
                        switch (@typeInfo(info.Child)) {
                            .bool => .{ 0, 1 },
                            .int => .{ std.math.minInt(info.Child), std.math.maxInt(info.Child) },
                            else => unreachable,
                        } },
                    .{ .global_report_type = [info.count]info.Child },
                    .main_io(info.dir, switch (info.type) {
                        .dynamic => .dynamic,
                        .selector => .selector,
                    }),
                }),
                .data_static => |info| create_report(&.{
                    .{ .global_report_type = info[1] },
                    .main_io(info[0], .static),
                }),
                .usage_page_and_local => |usage| create_report(&.{
                    .{ .global_usage_page = usage },
                    .{ .local_usage = usage.local() },
                }),
                inline else => |payload| blk: {
                    const data: []const u8 = switch (@TypeOf(payload)) {
                        void => "",
                        Collection, UsagePage => encode_int(@backingInt(payload)),
                        u31, i32, ?i32 => encode_int(payload),
                        InputOutput => &.{@bitCast(payload)},
                        else => |T| @compileError(@typeName(T) ++ " cannot be turned into a HID report"),
                    };
                    const h = it.header(data.len) orelse
                        @compileError(@tagName(it) ++ " is not a report");
                    break :blk &[1]u8{@bitCast(h)} ++ data;
                },
            };
        }

        return ret;
    }
};

pub const BootKeyboardModifiers = packed struct(u8) {
    lctrl: bool,
    lshift: bool,
    lalt: bool,
    lgui: bool,
    rctrl: bool,
    rshift: bool,
    ralt: bool,
    rgui: bool,

    pub const none: @This() = @bitCast(@as(u8, 0));
};

pub const BootKeycode = enum(u8) {
    // Codes taken from https://gist.github.com/mildsunrise/4e231346e2078f440969cdefb6d4caa3
    // zig fmt: off
    reserved = 0x00, error_roll_over, post_fail, error_undefined,
    a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z,
    top_1, top_2, top_3, top_4, top_5, top_6, top_7, top_8, top_9, top_0,
    enter, escape, delete, tab, space,
    @"-", @"=", @"[", @"]", @"\\", @"non_us_#", @";", @"'", @"`", @",", @".", @"/",
    caps_lock,
    f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12,
    print_screen, scroll_lock, pause, insert, home, page_up, delete_forward, end, page_down,
    right_arrow, left_arrow, down_arrow, up_arrow, num_lock,
    kpad_div, kpad_mul, kpad_sub, kpad_add, kpad_enter,
    kpad_1, kpad_2, kpad_3, kpad_4, kpad_5, kpad_6, kpad_7, kpad_8, kpad_9, kpad_0,
    kpad_delete, @"non_us_\\", application, power, @"kpad_=",
    f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24,
    lctrl = 224, lshift, lalt, lgui, rctrl, rshift, ralt, rgui,
    // zig fmt: on
    _,
};

pub const boot_keyboard = [_]Item{
    .{ .global_usage_page = .generic_desktop },
    .local_usage_enum(.{ .generic_desktop = .keyboard }),
    .{ .main_collection = .Application },
    // Input: modifier key bitmap
    .{ .data = .{
        .usage = .{ .global_page = .keyboard },
        .usage_range = .{ 0xE0, 0xE7 },
        .count = 8,
        .Child = bool,
        .dir = .in,
        .type = .dynamic,
    } },
    // Reserved 8 bits
    .{ .data_static = .{ .in, u8 } },
    // Output: indicator LEDs
    .{ .data = .{
        .usage = .{ .global_page = .led },
        .usage_range = .{ 1, 5 },
        .count = 5,
        .Child = bool,
        .dir = .out,
        .type = .dynamic,
    } },
    // Padding
    .{ .data_static = .{ .out, u3 } },
    // Input: up to 6 pressed key codes
    .{ .data = .{
        .usage = .{ .global_page = .keyboard },
        .usage_range = .{ 0x00, 0xff },
        .count = 6,
        .Child = u8,
        .dir = .in,
        .type = .selector,
    } },
    // End
    .main_collection_end,
};
