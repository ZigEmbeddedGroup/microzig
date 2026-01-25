const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;

pub const ReportItem = union(enum) {
    pub const Header = packed struct(u8) {
        pub const Length = enum(u2) { zero = 0, one = 1, two = 2, four = 3 };
        pub const Type = enum(u2) { main = 0, global = 1, local = 2, _ };

        len: Length,
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
        desktop = 0x01,
        keyboard = 0x07,
        led = 0x08,
        fido = @as(i16, @bitCast(@as(u16, 0xF1D0))),
        vendor = 0xFF,
        _,
    };

    pub const Usage = union(UsagePage) {
        pub const Desktop = enum(i32) {
            keyboard = 0x06,
        };

        pub const Keyboard = enum(i32) {};

        pub const Led = enum(i32) {};

        pub const Fido = enum(i32) {
            u2fhid = 0x01,
            data_in = 0x20,
            data_out = 0x21,
        };

        desktop: Desktop,
        keyboard: Keyboard,
        led: Led,
        fido: Fido,
        vendor: i32,

        pub fn local(self: @This()) i32 {
            return switch (self) {
                inline else => |x| @intFromEnum(x),
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

            pub fn report(self: @This()) ReportItem {
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
    main_feature: []const u8,
    main_collection_end,

    // global items
    global_usage_page: UsagePage,
    global_logical_min: i32,
    global_logical_max: i32,
    global_physical_min: []const u8,
    global_physical_max: []const u8,
    global_unit_exponent: []const u8,
    global_unit: []const u8,
    global_report_size: u31,
    global_report_id: u31,
    global_report_count: u31,
    global_push: []const u8,
    global_pop: []const u8,

    // local items
    local_usage: i32,
    local_usage_min: i32,
    local_usage_max: i32,
    local_designator_index: []const u8,
    local_designator_min: []const u8,
    local_designator_max: []const u8,
    local_string_index: []const u8,
    local_string_min: []const u8,
    local_string_max: []const u8,
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
            .In => .{ .main_input = payload },
            .Out => .{ .main_output = payload },
        };
    }

    pub fn local_usage_enum(usage: Usage) @This() {
        return .{ .local_usage = usage.local() };
    }

    pub fn encode_int(int: i32) []const u8 {
        const asBytes = std.mem.asBytes;
        const toLittle = std.mem.nativeToLittle;
        return if (std.math.cast(i8, int)) |result|
            &.{@bitCast(result)}
        else if (std.math.cast(i16, int)) |result|
            asBytes(&toLittle(i16, result))
        else
            asBytes(&toLittle(i32, int));
    }

    pub fn header(self: @This(), length: usize) ?Header {
        const len: Header.Length = switch (length) {
            0 => .zero,
            1 => .one,
            2 => .two,
            4 => .four,
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

    pub fn create_report(items: []const ?@This()) []const u8 {
        var ret: []const u8 = "";

        for (items) |it_opt| if (it_opt) |it| {
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
                        []const u8 => payload,
                        Collection, UsagePage => encode_int(@intFromEnum(payload)),
                        u31, i32 => encode_int(payload),
                        InputOutput => &.{@bitCast(payload)},
                        else => |T| @compileError(@typeName(T) ++ " cannot be turned into a HID report"),
                    };
                    const h = it.header(data.len) orelse
                        @compileError(@tagName(it) ++ " is not a report");
                    break :blk &[1]u8{@bitCast(h)} ++ data;
                },
            };
        };

        return ret;
    }
};

const ClassCode = usb.types.ClassSubclassProtocol.ClassCode.HID;

pub const InInterruptOptions = struct {
    subclass: ClassCode.Subclass(),
    protocol: ClassCode.Protocol(),
    Report: type,
    report_descriptor: []const ?ReportItem,
};

pub fn InInterruptDriver(options: InInterruptOptions) type {
    const log = std.log.scoped(.usb_hid_int_driver);

    return struct {
        pub const RequestType = enum(u8) {
            GetReport = 0x01,
            GetIdle = 0x02,
            GetProtocol = 0x03,
            SetReport = 0x09,
            SetIdle = 0x0a,
            SetProtocol = 0x0b,
            _,
        };

        pub const report_descriptor = ReportItem.create_report(options.report_descriptor);

        const Report = options.Report;

        pub const Descriptor = extern struct {
            const desc = usb.descriptor;

            interface: desc.Interface,
            hid: desc.HID,
            ep_out: desc.Endpoint,
            ep_in: desc.Endpoint,

            pub const Options = struct {
                itf_string: []const u8 = "",
                poll_interval: u8,
                country_code: desc.HID.CountryCode = .NotSupported,
            };

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                max_supported_packet_size: usb.types.Len,
                desc_options: Options,
            ) usb.DescriptorCreateResult(@This()) {
                assert(@sizeOf(Report) <= max_supported_packet_size);
                return .{ .descriptor = .{
                    .interface = .{
                        .interface_number = alloc.next_itf(),
                        .alternate_setting = 0,
                        .num_endpoints = 2,
                        .interface_triple = .from(.HID, options.subclass, options.protocol),
                        .interface_s = alloc.string(desc_options.itf_string),
                    },
                    .hid = .{
                        .country_code = desc_options.country_code,
                        .num_descriptors = 1,
                        .report_length = .from(report_descriptor.len),
                    },
                    .ep_out = .interrupt(
                        alloc.next_ep(.Out),
                        @sizeOf(Report),
                        desc_options.poll_interval,
                    ),
                    .ep_in = .interrupt(
                        alloc.next_ep(.In),
                        @sizeOf(Report),
                        desc_options.poll_interval,
                    ),
                } };
            }
        };

        pub const handlers: usb.DriverHadlers(@This()) = .{
            .ep_in = on_tx_ready,
            .ep_out = on_rx,
        };

        device: *usb.DeviceInterface,
        descriptor: *const Descriptor,
        tx_ready: std.atomic.Value(bool),

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface, data: []const u8) void {
            log.debug("InInterruptDriver init", .{});
            assert(data.len == 0);
            self.* = .{
                .device = device,
                .descriptor = desc,
                .tx_ready = .init(true),
            };
            self.device.ep_listen(
                self.descriptor.ep_out.endpoint.num,
                @intCast(self.descriptor.ep_out.max_packet_size.into()),
            );
        }

        pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
            switch (setup.request_type.type) {
                .Standard => {
                    const hid_desc_type: usb.descriptor.HID.CsType = @enumFromInt(setup.value.into() >> 8);
                    const request_code: usb.types.SetupRequest = @enumFromInt(setup.request);

                    if (request_code == .GetDescriptor and hid_desc_type == .HID)
                        return std.mem.asBytes(&self.descriptor.hid)
                    else if (request_code == .GetDescriptor and hid_desc_type == .Report)
                        return report_descriptor;
                },
                .Class => {
                    const hid_request_type: RequestType = @enumFromInt(setup.request);
                    switch (hid_request_type) {
                        .SetIdle => {
                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/454
                            // The host is attempting to limit bandwidth by requesting that
                            // the device only return report data when its values actually change,
                            // or when the specified duration elapses. In practice, the device can
                            // still send reports as often as it wants, but for completeness this
                            // should be implemented eventually.
                            //
                            return usb.ack;
                        },
                        .SetProtocol => {
                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/454
                            // The device should switch the format of its reports from the boot
                            // keyboard/mouse protocol to the format described in its report descriptor,
                            // or vice versa.
                            //
                            // For now, this request is ACKed without doing anything; in practice,
                            // the OS will reuqest the report protocol anyway, so usually only one format is needed.
                            // Unless the report format matches the boot protocol exactly (see ReportDescriptorKeyboard),
                            // our device might not work in a limited BIOS environment.
                            //
                            return usb.ack;
                        },
                        .SetReport => {
                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/454
                            // This request sends a feature or output report to the device,
                            // e.g. turning on the caps lock LED. This must be handled in an
                            // application-specific way, so notify the application code of the event.
                            //
                            return usb.ack;
                        },
                        else => {},
                    }
                },
                else => {},
            }
            return usb.nak;
        }

        pub fn on_tx_ready(self: *@This(), ep: usb.types.Endpoint.Num) void {
            log.debug("tx ready ({t})", .{ep});
            self.tx_ready.store(true, .seq_cst);
        }

        pub fn on_rx(self: *@This(), ep: usb.types.Endpoint.Num) void {
            var buf: [@sizeOf(Report)]u8 = undefined;
            const len = self.device.ep_readv(ep, &.{&buf});
            log.warn("rx {any}", .{buf[0..len]});
            self.device.ep_listen(
                self.descriptor.ep_out.endpoint.num,
                @intCast(self.descriptor.ep_out.max_packet_size.into()),
            );
        }

        pub fn send_report(self: *@This(), report: *const Report) bool {
            if (!self.tx_ready.load(.seq_cst)) return false;

            self.tx_ready.store(false, .seq_cst);

            const len = self.device.ep_writev(
                self.descriptor.ep_in.endpoint.num,
                &.{std.mem.asBytes(report)},
            );

            log.debug("sent report {} {any}", .{ len, report });

            return true;
        }
    };
}
