const std = @import("std");
const Database = @import("Database.zig");
const Arch = @import("arch.zig").Arch;
const arm = @import("arch/arm.zig");
const FS_Directory = @import("FS_Directory.zig");
const StructID = Database.StructID;

pub const core_to_cpu = std.StaticStringMap([]const u8).initComptime(&.{
    .{ "cm0", "cortex_m0" },
    .{ "cm0p", "cortex_m0plus" },
    .{ "cm3", "cortex_m3" },
    .{ "cm4", "cortex_m4" },
    .{ "cm7", "cortex_m7" },
    .{ "cm33", "cortex_m33" },
});

pub const ChipFile = struct {
    name: []const u8,
    family: []const u8,
    line: []const u8,
    die: []const u8,
    device_id: u16,
    packages: []const Package,
    memory: []const Memory,
    docs: []const Doc,
    cores: []const Core,

    pub const Package = struct {
        name: []const u8,
        package: []const u8,
        pins: []const Pin,

        pub const Pin = struct {
            position: []const u8,
            signals: []const []const u8,
        };
    };

    pub const Memory = struct {
        name: []const u8,
        kind: Kind,
        address: u32,
        size: u32,
        settings: ?Settings = null,
        access: ?Access = null,

        pub const Kind = enum {
            flash,
            ram,
        };

        pub const Settings = struct {
            erase_size: u32,
            write_size: u32,
            erase_value: u8,
        };

        pub const Access = struct {
            read: bool,
            write: bool,
            execute: bool,
        };
    };

    pub const Doc = struct {
        type: []const u8,
        title: []const u8,
        name: []const u8,
        url: []const u8,
    };

    pub const Core = struct {
        name: []const u8,
        peripherals: []const Peripheral,
        nvic_priority_bits: ?u8 = null,
        interrupts: []const Interrupt,
        dma_channels: []const DMA_Channel,

        pub const Peripheral = struct {
            name: []const u8,
            address: u32,
            registers: ?Registers = null,
            rcc: ?Rcc = null,
            pins: ?[]const Pin = null,
            interrupts: ?[]const Peripheral.Interrupt = null,
            dma_channels: ?[]const Peripheral.DMA_Channel = null,

            pub const Registers = struct {
                kind: []const u8,
                version: []const u8,
                block: []const u8,
            };

            pub const Rcc = struct {
                bus_clock: []const u8,
                kernel_clock: std.json.Value,
                enable: Field,
                reset: ?Field = null,
                stop_mode: StopMode = .Stop1,

                pub const Field = struct {
                    register: []const u8,
                    field: []const u8,
                };

                pub const StopMode = enum {
                    // this is the default if its null
                    Stop1,
                    Stop2,
                    Standby,
                };
            };

            pub const Pin = struct {
                pin: []const u8,
                signal: []const u8,
                af: ?u8 = null,
            };

            pub const Interrupt = struct {
                signal: []const u8,
                interrupt: []const u8,
            };

            pub const DMA_Channel = struct {
                signal: []const u8,
                dma: ?[]const u8 = null,
                channel: ?[]const u8 = null,
                dmamux: ?[]const u8 = null,
                request: ?u8 = null,
            };
        };

        pub const Interrupt = struct {
            name: []const u8,
            number: u8,
        };

        pub const DMA_Channel = struct {
            name: []const u8,
            dma: []const u8,
            channel: u8,
            dmamux: ?[]const u8 = null,
            dmamux_channel: ?u8 = null,
            supports_2d: ?bool = null,
        };
    };

    pub fn less_than(_: void, lhs: std.json.Parsed(ChipFile), rhs: std.json.Parsed(ChipFile)) bool {
        return std.ascii.lessThanIgnoreCase(lhs.value.name, rhs.value.name);
    }
};

pub fn load_into_db(db: *Database, path: []const u8, device: ?[]const u8) !void {
    var package_dir = try std.fs.cwd().openDir(path, .{});
    defer package_dir.close();

    var data_dir = try package_dir.openDir("data", .{});
    defer data_dir.close();

    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    const allocator = arena.allocator();

    var chip_files: std.ArrayList(std.json.Parsed(ChipFile)) = .empty;
    defer {
        for (chip_files.items) |chip_file|
            chip_file.deinit();
        chip_files.deinit(allocator);
    }

    var used_register_files = std.StringArrayHashMap(void).init(allocator);
    defer used_register_files.deinit();

    var register_files = std.StringArrayHashMap(std.json.Parsed(std.json.Value)).init(allocator);
    defer {
        for (register_files.values()) |*value|
            value.deinit();

        register_files.deinit();
    }

    var chips_dir = try data_dir.openDir("chips", .{ .iterate = true });
    defer chips_dir.close();

    var it = chips_dir.iterate();
    while (try it.next()) |entry| {
        if (entry.kind != .file)
            continue;

        std.log.info("file: {s}", .{entry.name});

        const chip_file_text = try chips_dir.readFileAlloc(allocator, entry.name, std.math.maxInt(usize));
        defer allocator.free(chip_file_text);

        var scanner = std.json.Scanner.initCompleteInput(allocator, chip_file_text);
        defer scanner.deinit();

        var diags = std.json.Diagnostics{};
        scanner.enableDiagnostics(&diags);
        errdefer {
            std.log.err("Issue found at {}:{}", .{ diags.getLine(), diags.getColumn() });
        }

        const chips_file = try std.json.parseFromTokenSource(ChipFile, allocator, &scanner, .{
            .allocate = .alloc_always,
        });
        errdefer chips_file.deinit();

        if (device) |d| {
            if (!std.mem.eql(u8, d, chips_file.value.name))
                continue;
        }

        for (chips_file.value.cores) |core| {
            for (core.peripherals) |peripheral| {
                if (peripheral.registers) |registers| {
                    const file_name = try std.fmt.allocPrint(allocator, "{s}_{s}.json", .{ registers.kind, registers.version });
                    try used_register_files.put(file_name, {});
                }
            }
        }

        try chip_files.append(allocator, chips_file);
    }

    var registers_dir = try data_dir.openDir("registers", .{ .iterate = true });
    defer registers_dir.close();

    //This holds extra data for extended registers
    var extends_list_arena = std.heap.ArenaAllocator.init(allocator);
    defer extends_list_arena.deinit();
    const extends_list_allocator = extends_list_arena.allocator();

    it = registers_dir.iterate();
    while (try it.next()) |entry| {
        if (entry.kind != .file)
            continue;

        std.log.info("file: {s}", .{entry.name});

        const register_file_text = try registers_dir.readFileAlloc(allocator, entry.name, std.math.maxInt(usize));
        defer allocator.free(register_file_text);

        var scanner = std.json.Scanner.initCompleteInput(allocator, register_file_text);
        defer scanner.deinit();

        var diags = std.json.Diagnostics{};
        scanner.enableDiagnostics(&diags);
        errdefer {
            std.log.err("Issue found at {}:{}", .{ diags.getLine(), diags.getColumn() });
        }

        var register_file = try std.json.parseFromTokenSource(std.json.Value, allocator, &scanner, .{
            .allocate = .alloc_always,
        });
        errdefer register_file.deinit();

        try handle_extends(allocator, extends_list_allocator, &register_file.value);

        const register_name = try allocator.dupe(u8, entry.name[0 .. entry.name.len - std.fs.path.extension(entry.name).len]);

        if (!used_register_files.contains(entry.name))
            continue;

        try register_files.put(register_name, register_file);
    }

    // sort to try to keep things somewhat in order
    std.sort.insertion(std.json.Parsed(ChipFile), chip_files.items, {}, ChipFile.less_than);

    for (register_files.keys(), register_files.values()) |name, register_file| {
        const periph_id = try db.create_peripheral(.{
            .name = name,
        });

        var enums = std.StringArrayHashMap(Database.EnumID).init(allocator);
        defer enums.deinit();

        for (register_file.value.object.keys(), register_file.value.object.values()) |key, obj| {
            if (!std.mem.startsWith(u8, key, "enum/"))
                continue;

            const enum_description: ?[]const u8 = if (obj.object.get("description")) |desc| desc.string else null;
            const size = obj.object.get("bit_size").?.integer;

            const struct_id = try db.get_peripheral_struct(periph_id);
            const enum_id = try db.create_enum(struct_id, .{
                .name = key["enum/".len..],
                .description = enum_description,
                .size_bits = @intCast(size),
            });

            try enums.put(key["enum/".len..], enum_id);

            for (obj.object.get("variants").?.array.items) |item| {
                const enum_field_name = item.object.get("name").?.string;
                const enum_field_description: ?[]const u8 = if (item.object.get("description")) |desc| desc.string else null;
                const value = item.object.get("value").?.integer;

                try db.add_enum_field(enum_id, .{
                    .name = enum_field_name,
                    .description = enum_field_description,
                    .value = @intCast(value),
                });
            }
        }

        for (register_file.value.object.keys(), register_file.value.object.values()) |key, obj| {
            if (!std.mem.startsWith(u8, key, "block/"))
                continue;

            const struct_id = try db.get_peripheral_struct(periph_id);
            const group_id = try db.create_nested_struct(struct_id, .{
                .name = key["block/".len..],
                .description = if (obj.object.get("description")) |desc|
                    desc.string
                else
                    null,
            });

            for (obj.object.get("items").?.array.items) |item| {
                const register_name = item.object.get("name").?.string;
                const description: ?[]const u8 = if (item.object.get("description")) |desc| desc.string else null;
                const byte_offset = item.object.get("byte_offset").?.integer;
                const item_bit_size: usize = @intCast(if (item.object.get("bit_size")) |v| v.integer else 32);

                const register_struct_id: ?StructID = if (item.object.get("fieldset")) |fieldset| blk: {
                    const register_struct_id = try db.create_struct(.{});
                    const fieldset_key = try std.fmt.allocPrint(allocator, "fieldset/{s}", .{fieldset.string});
                    const fieldset_value = (register_file.value.object.get(fieldset_key) orelse break :blk null).object;
                    next_field: for (fieldset_value.get("fields").?.array.items) |field| {
                        const field_name = field.object.get("name").?.string;
                        const field_description: ?[]const u8 = if (field.object.get("description")) |desc| desc.string else null;
                        switch (field.object.get("bit_offset").?) {
                            .integer => |int| {
                                // This is the standard bit offset case most items will be in this catigory
                                const bit_offset = int;
                                const bit_size = field.object.get("bit_size").?.integer;
                                const enum_id: ?Database.EnumID = if (field.object.get("enum")) |enum_name|
                                    if (enums.get(enum_name.string)) |enum_id| enum_id else null
                                else
                                    null;
                                var array_count: ?u16 = null;
                                var array_stride: ?u8 = null;
                                if (field.object.get("array")) |array_obj| {
                                    const object_map = array_obj.object;
                                    // This is the typical case for array objects e.g., @"A[0]", @"A[1]" registers
                                    // these are evenly spaced and much nicer to work with.

                                    array_count = if (object_map.get("len")) |len| @intCast(len.integer) else null;
                                    array_stride = if (object_map.get("stride")) |stride| @intCast(stride.integer) else null;

                                    // This category where there is an array of items, but it is given by
                                    // individual offsets as opposed to a count + stride. This is used when strides are
                                    // inconsistent between elements

                                    if (object_map.get("offsets")) |positions| {
                                        for (positions.array.items, 0..) |position, idx| {
                                            const field_name_irregular_stride = try std.fmt.allocPrint(allocator, "{s}[{}]", .{ field_name, idx });

                                            try db.add_struct_field(register_struct_id, .{
                                                .name = field_name_irregular_stride,
                                                .description = field_description,
                                                .offset_bits = @intCast(position.integer + bit_offset),
                                                .size_bits = @intCast(bit_size),
                                                .enum_id = enum_id,
                                                .count = null,
                                                .stride = null,
                                            });
                                        }
                                        continue :next_field;
                                    }
                                }

                                try db.add_struct_field(register_struct_id, .{
                                    .name = field_name,
                                    .description = field_description,
                                    .offset_bits = @intCast(bit_offset),
                                    .size_bits = @intCast(bit_size),
                                    .enum_id = enum_id,
                                    .count = array_count,
                                    .stride = array_stride,
                                });
                            },
                            .array => |arr| {
                                // This case is for discontinuous fields where the first few bits are
                                // separated from the rest of the field by padding or other fields
                                if (arr.items.len != 2) {
                                    //This should never happen, because the input data as of yet doesn't contain this.
                                    std.log.warn("skipping {s}, it's an non-consecutive field with more than two parts", .{field_name});
                                    continue;
                                }
                                const cont_field = try std.fmt.allocPrint(allocator, "{s}_CONT", .{field_name});
                                const field_names = [2][]const u8{ field_name, cont_field };

                                for (arr.items, field_names) |non_contiguous_offset, non_contiguous_field_name| {
                                    const bit_offset = non_contiguous_offset.object.get("start").?.integer;
                                    const bit_size = non_contiguous_offset.object.get("end").?.integer - bit_offset + 1;

                                    const enum_id = null; //These can't handle the ENUM size but it will still be avaiable to use.

                                    var array_count: ?u16 = null;
                                    var array_stride: ?u8 = null;
                                    if (field.object.get("array")) |array| {
                                        array_count = if (array.object.get("len")) |len| @intCast(len.integer) else null;
                                        array_stride = if (array.object.get("stride")) |stride| @intCast(stride.integer) else null;
                                    }

                                    try db.add_struct_field(register_struct_id, .{
                                        .name = non_contiguous_field_name,
                                        .description = field_description,
                                        .offset_bits = @intCast(bit_offset),
                                        .size_bits = @intCast(bit_size),
                                        .enum_id = enum_id,
                                        .count = array_count,
                                        .stride = array_stride,
                                    });
                                }
                            },
                            else => |val| {
                                std.log.warn("skipping {s}, it's a {}", .{ field_name, val });
                            },
                        }
                    }

                    break :blk register_struct_id;
                } else null;

                if (item.object.get("array")) |array| {
                    if (array.object.get("len")) |count| {
                        const stride = array.object.get("stride").?.integer;
                        if (stride == (item_bit_size / 8)) {
                            _ = try db.create_register(group_id, .{
                                .name = register_name,
                                .description = description,
                                .offset_bytes = @intCast(byte_offset),
                                .size_bits = item_bit_size,
                                .count = @intCast(count.integer),
                                .struct_id = register_struct_id,
                            });
                        } else if (stride > (item_bit_size / 8)) {
                            for (0..@intCast(count.integer)) |idx| {
                                const single_register_name = try std.fmt.allocPrint(allocator, "{s}{}", .{ register_name, idx });
                                _ = try db.create_register(group_id, .{
                                    .name = single_register_name,
                                    .description = description,
                                    .offset_bytes = @as(usize, @intCast(byte_offset)) + (idx * @as(usize, @intCast(stride))),
                                    .size_bits = item_bit_size,
                                    .struct_id = register_struct_id,
                                });

                                // First we give the struct the same name as the register
                                if (register_struct_id) |rs_id| if (!(try db.struct_decl_name_exists(struct_id, register_name))) {
                                    try db.create_struct_decl(struct_id, rs_id, register_name, .{});
                                };
                            }
                        } else {
                            std.log.warn("stride ({}) is smaller than item bit size ({}) count={}", .{ stride, item_bit_size, count.integer });
                        }
                    } else {
                        _ = try db.create_register(group_id, .{
                            .name = register_name,
                            .description = description,
                            .offset_bytes = @intCast(byte_offset),
                            .size_bits = item_bit_size,
                            .struct_id = register_struct_id,
                        });
                    }
                } else {
                    _ = try db.create_register(group_id, .{
                        .name = register_name,
                        .description = description,
                        .offset_bytes = @intCast(byte_offset),
                        .size_bits = item_bit_size,
                        .struct_id = register_struct_id,
                    });
                }
            }
        }
    }

    for (chip_files.items) |chip_file| {
        const core = chip_file.value.cores[0];
        const arch = std.meta.stringToEnum(Arch, core_to_cpu.get(core.name).?).?;
        const device_id = try db.create_device(.{
            .name = chip_file.value.name,
            .arch = arch,
        });

        try arm.load_system_interrupts(db, device_id, arch);

        // TODO: how do we want to handle multi core MCUs?
        //
        // For now we're only using the first core. We'll likely have to combine the
        // sets of peripherals, there will potentially be overlap, but if there
        // are differences between cores that's something the user will have
        // to keep track of.

        var has_fpu = false;
        var dma_channel_count: u32 = 0;
        for (core.interrupts) |interrupt| {
            _ = try db.create_interrupt(device_id, .{
                .name = interrupt.name,
                .idx = interrupt.number,
            });

            if (std.mem.indexOf(u8, interrupt.name, "FPU")) |_| {
                has_fpu = true;
            }

            if (std.mem.indexOf(u8, interrupt.name, "DMA")) |_| {
                dma_channel_count += 1;
            }
        }

        try db.add_device_property(device_id, .{
            .key = "cpu.fpuPresent",
            .value = if (has_fpu) "true" else "false",
        });

        try db.add_device_property(device_id, .{
            .key = "cpu.dmaChannelCount",
            .value = try std.fmt.allocPrint(allocator, "{d}", .{dma_channel_count}),
        });

        for (core.peripherals) |peripheral| {
            // Don't know what to do if registers is null, so skipping
            const registers = peripheral.registers orelse continue;

            const periph_name = try std.fmt.allocPrint(allocator, "{s}_{s}", .{ registers.kind, registers.version });
            // get the register group representing the peripheral instance
            const periph_id = try db.get_peripheral_by_name(periph_name) orelse return error.MissingPeripheral;
            const struct_id = try db.get_peripheral_struct(periph_id);
            const struct_decl = try db.get_struct_decl_by_name(arena.allocator(), struct_id, registers.block);
            _ = try db.create_device_peripheral(device_id, .{
                .struct_id = struct_decl.struct_id,
                .name = peripheral.name,
                .offset_bytes = peripheral.address,
            });
        }
    }
}

/// Reads throught the json data handles the "extends" inheritance.
fn handle_extends(allocator: std.mem.Allocator, extends_allocator: std.mem.Allocator, root_json: *std.json.Value) !void {
    var itr = root_json.object.iterator();
    while (itr.next()) |entry| {
        const item_name = entry.key_ptr.*;
        const item_value = entry.value_ptr;

        if (item_value.*.object.contains("extends")) {

            // This Collects unique items from the ancestors.
            var arr: std.json.ObjectMap = std.json.ObjectMap.init(allocator);
            defer arr.deinit();

            // Get child value and kind holder of inherting items
            var child = root_json.object.get(item_name).?;
            const list_name = get_section(item_name);

            // Add child items to dictionary so they are not overwritten.
            for (child.object.get(list_name).?.array.items) |child_item| {
                const child_item_name = child_item.object.get("name").?.string;
                try arr.put(child_item_name, child_item);
            }

            // Handle all parents and grandparents of the current child.
            try resolve_inheritance_recursively(allocator, root_json, item_name, &arr);

            // Replacement items will go here and should be released via the arena extends allocator
            var new_list = std.json.Array.init(extends_allocator);
            for (arr.values()) |value| {
                try new_list.append(value);
            }
            try child.object.put(list_name, std.json.Value{ .array = new_list });
        }
    }
}

// General function to handle inheritance
fn resolve_inheritance_recursively(allocator: std.mem.Allocator, json_data: *std.json.Value, child_full_name: []const u8, accumulator: *std.json.ObjectMap) !void {
    const child = json_data.object.get(child_full_name).?;
    const list_name = get_section(child_full_name);

    //This element has a parent ! so it needs to be handled.
    const extended = child.object.get("extends");
    if (extended) |parent_unqualified_name| {

        //Get access to the parent and its list of items.
        const parent = try get_parent(allocator, json_data, child_full_name, parent_unqualified_name.string);
        const parent_section_array = parent.value_ptr.object.get(list_name).?.array;

        // If our dictionary doesn't contain an item present in the child add it to the list
        for (parent_section_array.items) |parent_element| {
            const parent_element_name = if (parent_element.object.get("name")) |name| name.string else @panic("No Name exist in array properties");
            if (!accumulator.contains(parent_element_name)) {
                try accumulator.put(parent_element_name, parent_element);
            }
        }

        if (parent.value_ptr.object.contains("extends")) {
            try resolve_inheritance_recursively(allocator, json_data, parent.key_ptr.*, accumulator);
        }
    }
}

fn get_parent(allocator: std.mem.Allocator, json_data: *std.json.Value, child_full_name: []const u8, parent_name: []const u8) !std.json.ObjectMap.Entry {
    //Get Family name eg Block, Fieldset
    var name_iterator = std.mem.splitScalar(u8, child_full_name, '/');
    const family_name = name_iterator.first();

    //Get qualified parent name
    const parent_full_name = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ family_name, parent_name });
    defer allocator.free(parent_full_name);

    return json_data.object.getEntry(parent_full_name).?;
}

/// In the json data
/// blocks inherit their "items"
/// fieldsets inherit their "feilds"
/// This picks the appropriate item based on its name.
fn get_section(child_full_name: []const u8) []const u8 {
    const Item_t = struct {
        data_type: []const u8,
        section: []const u8,
    };

    const items = [_]Item_t{
        Item_t{ .data_type = "block", .section = "items" },
        Item_t{ .data_type = "fieldset", .section = "fields" },
    };

    //Get Family name eg Block, Fieldset
    var name_iterator = std.mem.splitScalar(u8, child_full_name, '/');
    const family_name = name_iterator.first();

    inline for (items) |item| {
        if (std.mem.eql(u8, item.data_type, family_name)) {
            return item.section;
        }
    }
    @panic("Unhandled extends Type");
}
