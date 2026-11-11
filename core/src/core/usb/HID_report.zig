const std = @import("std");
const usb = @import("../usb.zig");
const assert = std.debug.assert;
const SFAttributes = std.builtin.Type.Struct.FieldAttributes;

pub const Keycode = enum(u8) {
    // Codes taken from:
    // https://gist.github.com/mildsunrise/4e231346e2078f440969cdefb6d4caa3
    // https://gist.github.com/MightyPork/6da26e382a7ad91b5496ee55fdc73db2

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

    execute, help, menu, select, stop, again, undo, cut, copy, paste, find,
    mute, volumeup, volumedown,
    locking_caps_lock, locking_num_lock, locking_scroll_lock,

    @"kpad_,", @"kpad_alternate_=",

    international1, international2, international3, international4, international5,
    international6, international7, international8, international9,
    lang1, lang2, lang3, lang4, lang5, lang6, lang7, lang8, lang9,

    alternate_erase, sysreq_attention, cancel, clear, prior, @"return",
    separator, out, oper, clear_again, crsel_props, exsel,

    kpad_00 = 0xb0, kpad_000, kpad_thousands_separator, kpad_decimal_separator,
    kpad_currency_unit, kpad_currency_subunit,
    @"kpad_(", @"kpad_)", @"kpad_{", @"kpad_}", kpad_tab, kpad_backspace,
    kpad_a, kpad_b, kpad_c, kpad_d, kpad_e, kpad_f,
    kpad_xor, @"kpad_^", @"kpad_%", @"kpad_<", @"kpad_>", @"kpad_&", @"kpad_&&",
    @"kpad_|", @"kpad_||", @"kpad_:", @"kpad_#", kpad_space, @"kpad_@", @"kpad_!",
    kpad_memory_store, kpad_memory_recall, kpad_memory_clear, kpad_memory_add,
    kpad_memory_subtract, kpad_memory_multiply, kpad_memory_divide, @"kpad_+/-",
    kpad_clear, kpad_clear_entry, kpad_binary, kpad_octal, kpad_decimal, kpad_hexadecimal,

    lctrl = 0xe0, lshift, lalt, lgui, rctrl, rshift, ralt, rgui,

    media_playpause, media_stopcd, media_previoussong, media_nextsong,
    media_ejectcd, media_volumeup, media_volumedown, media_mute,
    media_www, media_back, media_forward, media_stop, media_find,
    media_scrollup, media_scrolldown, media_edit, media_sleep,
    media_coffee, media_refresh, media_calc,
    // zig fmt: on
    _,

    // Aliases
    const open: @This() = .execute;
    const props: @This() = .menu;
    const front: @This() = .select;
    const ro: @This() = .international1;
    const katakanahiragana: @This() = .international2;
    const yen: @This() = .international3;
    const henkan: @This() = .international4;
    const muhenkan: @This() = .international5;
    const kpjpcomma: @This() = .international6;
    const hangeul: @This() = .lang1;
    const hanja: @This() = .lang2;
    const katakana: @This() = .lang3;
    const hiragana: @This() = .lang4;
    const zenkakuhankaku: @This() = .lang5;
};

pub const Ledcode = enum(u3) {
    num_lock = 1,
    caps_lock = 2,
    scroll_lock = 3,
    compose = 4,
    kana = 5,
};

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

        pub fn Type(self: @This()) type {
            return switch (self) {
                .keyboard => Keycode,
                .led => Ledcode,
                inline else => @compileError("Not supported for: " ++ @tagName(self)),
            };
        }
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

    pub fn header(self: @This(), length: usize) Header {
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
        };
        return .{ .len = len, .type = typ, .tag = tag };
    }

    pub fn create_report(items: []const @This()) []const u8 {
        var ret: []const u8 = "";

        for (items) |it| {
            ret = ret ++ switch (it) {
                inline else => |payload| blk: {
                    const data: []const u8 = switch (@TypeOf(payload)) {
                        void => "",
                        Collection, UsagePage => encode_int(@backingInt(payload)),
                        u31, i32, ?i32 => encode_int(payload),
                        InputOutput => &.{@backingInt(payload)},
                        else => |T| @compileError(@typeName(T) ++ " cannot be turned into a HID report"),
                    };
                    const h = it.header(data.len);
                    break :blk &[1]u8{@backingInt(h)} ++ data;
                },
            };
        }

        return ret;
    }
};

pub const Finalized = struct {
    descriptor: []const u8,
    in: type,
    out: type,

    pub const boot_keyboard = blk: {
        var ret: Report = .generic_desktop;
        ret.add_raw(.local_usage_enum(.{ .generic_desktop = .keyboard }));
        ret.add_raw(.{ .main_collection = .Application });
        // Input: modifier key bitmap
        ret.add_data_dynamic("modifiers", u8, .keyboard, .lctrl, 8, .in);
        // Reserved 8 bits
        ret.add_data_static(8, .in);
        // Output: indicator LEDs
        ret.add_data_dynamic("led", u8, .led, .num_lock, 5, .out);
        // Input: up to 6 pressed key codes
        ret.add_data_selector("keys", .keyboard, 6, .in);
        break :blk ret.finalize();
    };
};

const Report = @This();

reserved: u16 = 0,
items: []const Item,
names: [2][]const [:0]const u8,
types: [2][]const type,
attrs: [2][]const SFAttributes,

pub fn finalize(self: Report) Finalized {
    var ret = Finalized{
        .descriptor = Item.create_report(self.items ++ [_]Item{.main_collection_end}),
        .in = undefined,
        .out = undefined,
    };
    for (&.{ usb.types.Dir.in, usb.types.Dir.out }) |dir|
        @field(ret, @tagName(dir)) = @Struct(
            .@"extern",
            null,
            self.names[@backingInt(dir)],
            self.types[@backingInt(dir)],
            self.attrs[@backingInt(dir)],
        );
    return ret;
}

pub fn add_raw(self: *Report, item: Item) void {
    self.items = self.items ++ [_]Item{item};
}

pub fn add_data_static(
    self: *Report,
    num_bits: u16,
    dir: usb.types.Dir,
) void {
    self.add_data_static_no_field(num_bits, dir);
    self.add_field(dir, "", @Int(.unsigned, num_bits));
}

pub fn add_data_dynamic(
    self: *Report,
    name: [:0]const u8,
    BackingInt: type,
    usage_page: Item.UsagePage,
    first: usage_page.Type(),
    count: u16,
    dir: usb.types.Dir,
) void {
    const T = usage_page.Type();
    self.add_data_non_static_no_field(
        usage_page,
        @backingInt(first),
        @backingInt(first) + (count - 1),
        count,
        1,
        dir,
        .dynamic,
    );
    var names: [count + @intFromBool(count < @bitSizeOf(BackingInt))][:0]const u8 = undefined;
    var types: [names.len]type = @splat(bool);
    var attrs: [names.len]SFAttributes = @splat(.{});
    for (0..count) |i|
        names[i] = @tagName(@as(T, @fromBackingInt(@backingInt(first) + i)));

    if (count < @bitSizeOf(BackingInt)) {
        const Padding = @Int(.unsigned, @bitSizeOf(BackingInt) - count);
        self.add_data_static_no_field(@bitSizeOf(Padding), dir);
        names[count] = self.get_reserved_name();
        types[count] = Padding;
        attrs[count].default_value_ptr = &@as(Padding, 0);
    }
    self.add_field(dir, name, @Struct(.@"packed", BackingInt, &names, &types, &attrs));
}

pub fn add_data_selector(
    self: *Report,
    name: [:0]const u8,
    usage_page: Item.UsagePage,
    count: u16,
    dir: usb.types.Dir,
) void {
    const T = usage_page.Type();
    self.add_data_non_static_no_field(
        usage_page,
        0,
        (1 << @bitSizeOf(T)) - 1,
        count,
        @bitSizeOf(T),
        dir,
        .selector,
    );
    self.add_field(dir, name, [count]T);
}

pub fn with_first_item(item: Item) Report {
    return .{
        .reserved = 0,
        .items = &.{item},
        .names = @splat(&.{}),
        .types = @splat(&.{}),
        .attrs = @splat(&.{}),
    };
}

pub const generic_desktop = with_first_item(.{ .global_usage_page = .generic_desktop });

fn add_field(self: *Report, dir: usb.types.Dir, name: [:0]const u8, Type: type) void {
    var attr = SFAttributes{ .@"align" = 1 };
    if (name.len > 0)
        self.names[@backingInt(dir)] = self.names[@backingInt(dir)] ++ [_][:0]const u8{name}
    else {
        self.names[@backingInt(dir)] = self.names[@backingInt(dir)] ++ [_][:0]const u8{self.get_reserved_name()};
        attr.default_value_ptr = &@as(Type, 0);
    }
    self.types[@backingInt(dir)] = self.types[@backingInt(dir)] ++ [_]type{Type};
    self.attrs[@backingInt(dir)] = self.attrs[@backingInt(dir)] ++ [_]SFAttributes{attr};
}

fn get_reserved_name(self: *Report) [:0]const u8 {
    defer self.reserved += 1;
    return std.fmt.comptimePrint("reserved{}", .{self.reserved});
}

fn add_data_static_no_field(
    self: *Report,
    bitsize: u16,
    dir: usb.types.Dir,
) void {
    self.items = self.items ++ [_]Item{
        .{ .global_report_count = 1 },
        .{ .global_report_size = bitsize },
        .main_io(dir, .static),
    };
}

fn add_data_non_static_no_field(
    self: *Report,
    usage_page: Item.UsagePage,
    range_min: i32,
    range_max: i32,
    count: u16,
    bitsize: u16,
    dir: usb.types.Dir,
    data_type: Item.InputOutput,
) void {
    self.items = self.items ++ [_]Item{
        .{ .global_usage_page = usage_page },
        .{ .local_usage_min = range_min },
        .{ .local_usage_max = range_max },
        .{ .global_logical_min = 0 },
        .{ .global_logical_max = (1 << bitsize) - 1 },
        .{ .global_report_count = count },
        .{ .global_report_size = bitsize },
        .main_io(dir, data_type),
    };
}
