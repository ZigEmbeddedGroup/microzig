const std = @import("std");
const xml = @import("xml.zig");

const Database = @import("Database.zig");
const DeviceID = Database.DeviceID;
const PeripheralID = Database.PeripheralID;
const RegisterID = Database.RegisterID;
const StructID = Database.StructID;
const EnumID = Database.EnumID;

pub fn load_into_db(io: std.Io, db: *Database, path: []const u8, device: ?[]const u8) !void {
    var targetdb_dir = try std.Io.Dir.cwd().openDir(io, path, .{});
    defer targetdb_dir.close(io);

    var devices_dir = try targetdb_dir.openDir(io, "devices", .{ .iterate = true });
    defer devices_dir.close(io);

    var it = devices_dir.iterate();
    while (try it.next(io)) |entry| {
        if (entry.kind != .file)
            continue;

        // only MSP430 for now
        if (!std.mem.startsWith(u8, entry.name, "MSP430"))
            continue;

        if (device) |d| {
            if (std.mem.eql(u8, d, entry.name[0 .. entry.name.len - ".xml".len])) {
                try load_device(io, db, devices_dir, entry.name);
                return;
            }
        } else {
            try load_device(io, db, devices_dir, entry.name);
        }
    } else if (device != null) {
        return error.DeviceMissing;
    }
}

fn load_device(io: std.Io, db: *Database, devices_dir: std.Io.Dir, filename: []const u8) !void {
    const device_text = try devices_dir.readFileAlloc(io, filename, db.gpa, .unlimited);
    defer db.gpa.free(device_text);

    var doc = try xml.Doc.from_memory(device_text);
    defer doc.deinit();

    const root = try doc.get_root_element();

    const device_id = try db.create_device(.{
        .arch = .msp430,
        .description = root.get_attribute("description"),
        .name = root.get_attribute("id") orelse return error.MissingField,
    });

    const include_it = root.iterate(&.{}, &.{"include"});
    const property_it = root.iterate(&.{}, &.{"property"});

    _ = include_it;
    _ = property_it;

    const cpu_node = root.find_child(&.{"cpu"}) orelse return error.MissingField;

    var instance_it = cpu_node.iterate(&.{}, &.{"instance"});

    while (instance_it.next()) |instance_node| {
        try load_instance(io, db, device_id, devices_dir, instance_node);
    }
}

fn load_instance(
    io: std.Io,
    db: *Database,
    device_id: DeviceID,
    devices_dir: std.Io.Dir,
    node: xml.Node,
) !void {
    const name = node.get_attribute("id") orelse return error.MissingField;
    const href = node.get_attribute("href") orelse return error.MissingField;

    const baseaddr_str = node.get_attribute("baseaddr") orelse return error.MissingField;
    const baseaddr = try std.fmt.parseInt(u64, baseaddr_str, 0);

    const module_text = try devices_dir.readFileAlloc(io, href, db.gpa, .unlimited);
    defer db.gpa.free(module_text);

    var doc = try xml.Doc.from_memory(module_text);
    defer doc.deinit();

    const root = try doc.get_root_element();
    if (root.get_attribute("hidden")) |hidden_str| {
        if (std.mem.eql(u8, hidden_str, "true"))
            return;
    }

    const description = root.get_attribute("description");
    const peripheral_id = try db.create_peripheral(.{
        .name = name,
        .description = description,
    });

    var min_offset: ?u64 = null;
    var register_it = root.iterate(&.{}, &.{"register"});
    while (register_it.next()) |register_node| {
        const offset_str = register_node.get_attribute("offset") orelse return error.MissingField;
        const offset = try std.fmt.parseInt(u64, std.mem.trim(u8, offset_str, " "), 0);
        min_offset = if (min_offset) |current|
            @min(current, offset)
        else
            offset;
    }

    const base_offset = min_offset orelse return error.MissingField;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    _ = try db.create_device_peripheral(device_id, .{
        .name = name,
        .description = description,
        .struct_id = struct_id,
        .offset_bytes = baseaddr + base_offset,
    });

    register_it = root.iterate(&.{}, &.{"register"});
    while (register_it.next()) |register_node| {
        try load_register(db, struct_id, base_offset, register_node);
    }
}

fn load_register(db: *Database, struct_id: StructID, base_offset: u64, node: xml.Node) !void {
    const offset_str = node.get_attribute("offset") orelse return error.MissingField;
    const abs_offset = try std.fmt.parseInt(u64, std.mem.trim(u8, offset_str, " "), 0);

    const width_str = node.get_attribute("width") orelse return error.MissingField;
    const width_bits = try std.fmt.parseInt(u64, width_str, 0);

    const register_id = try db.create_register(struct_id, .{
        .name = node.get_attribute("acronym") orelse return error.MissingField,
        .description = node.get_attribute("description"),
        .offset_bytes = abs_offset - base_offset,
        .size_bits = width_bits,
    });

    var bitfield_it = node.iterate(&.{}, &.{"bitfield"});
    while (bitfield_it.next()) |bitfield_node| {
        try load_bitfield(db, register_id, bitfield_node);
    }
}

fn load_bitfield(db: *Database, register_id: RegisterID, node: xml.Node) !void {
    const name = node.get_attribute("id") orelse return error.MissingField;
    const description = node.get_attribute("description");

    const width_str = node.get_attribute("width") orelse return error.MissingField;
    const width_bits = try std.fmt.parseInt(u8, width_str, 0);

    const end_str = node.get_attribute("end") orelse return error.MissingField;
    const end_bit = try std.fmt.parseInt(u8, end_str, 0);

    const access_str = node.get_attribute("rwaccess");
    const access: Database.Access = if (access_str) |str|
        if (std.mem.eql(u8, str, "RW"))
            .read_write
        else
            @panic(str)
    else
        .read_write;

    const enum_id: ?EnumID = if (node.find_child(&.{"bitenum"}) != null) blk: {
        const enum_id = try db.create_enum(null, .{
            .size_bits = width_bits,
        });

        var bitenum_it = node.iterate(&.{}, &.{"bitenum"});
        while (bitenum_it.next()) |bitenum_node| {
            const value_str = bitenum_node.get_attribute("value") orelse return error.MissingField;
            try db.add_enum_field(enum_id, .{
                .name = bitenum_node.get_attribute("token") orelse return error.MissingField,
                .description = bitenum_node.get_attribute("description"),
                .value = try std.fmt.parseInt(u64, value_str, 0),
            });
        }

        break :blk enum_id;
    } else null;

    try db.add_register_field(register_id, .{
        .name = name,
        .description = description,
        .enum_id = enum_id,
        .access = access,
        .offset_bits = end_bit,
        .size_bits = width_bits,
    });
}
