const std = @import("std");
const regz = @import("regz");

pub const std_options = std.Options{
    .log_level = .info,
};

const ChipFile = struct {
    name: []const u8,
    family: []const u8,
    line: []const u8,
    die: []const u8,
    device_id: u16,
    packages: []const Package,
    memory: []const Memory,
    docs: []const Doc,
    cores: []const Core,

    const Package = struct {
        name: []const u8,
        package: []const u8,
        pins: []const Pin,

        const Pin = struct {
            position: []const u8,
            signals: []const []const u8,
        };
    };

    const Memory = struct {
        name: []const u8,
        kind: Kind,
        address: u32,
        size: u32,
        settings: ?Settings = null,
        access: ?Access = null,

        const Kind = enum {
            flash,
            ram,
        };

        const Settings = struct {
            erase_size: u32,
            write_size: u32,
            erase_value: u8,
        };

        const Access = struct {
            read: bool,
            write: bool,
            execute: bool,
        };
    };

    const Doc = struct {
        type: []const u8,
        title: []const u8,
        name: []const u8,
        url: []const u8,
    };

    const Core = struct {
        name: []const u8,
        peripherals: []const Peripheral,
        nvic_priority_bits: ?u8 = null,
        interrupts: []const Interrupt,
        dma_channels: []const DMA_Channel,

        const Peripheral = struct {
            name: []const u8,
            address: u32,
            registers: ?Registers = null,
            rcc: ?Rcc = null,
            pins: ?[]const Pin = null,
            interrupts: ?[]const Peripheral.Interrupt = null,
            dma_channels: ?[]const Peripheral.DMA_Channel = null,

            const Registers = struct {
                kind: []const u8,
                version: []const u8,
                block: []const u8,
            };

            const Rcc = struct {
                bus_clock: []const u8,
                kernel_clock: std.json.Value,
                enable: Field,
                reset: ?Field = null,
                stop_mode: StopMode = .Stop1,

                const Field = struct {
                    register: []const u8,
                    field: []const u8,
                };

                const StopMode = enum {
                    // this is the default if its null
                    Stop1,
                    Stop2,
                    Standby,
                };
            };

            const Pin = struct {
                pin: []const u8,
                signal: []const u8,
                af: ?u8 = null,
            };

            const Interrupt = struct {
                signal: []const u8,
                interrupt: []const u8,
            };

            const DMA_Channel = struct {
                signal: []const u8,
                dma: ?[]const u8 = null,
                channel: ?[]const u8 = null,
                dmamux: ?[]const u8 = null,
                request: ?u8 = null,
            };
        };

        const Interrupt = struct {
            name: []const u8,
            number: u8,
        };

        const DMA_Channel = struct {
            name: []const u8,
            dma: []const u8,
            channel: u8,
            dmamux: ?[]const u8 = null,
            dmamux_channel: ?u8 = null,
            supports_2d: ?bool = null,
        };
    };
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const allocator = arena.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2)
        return error.InvalidArgs;

    const package_path = args[1];

    std.log.info("package path: {s}", .{package_path});

    var package_dir = try std.fs.cwd().openDir(package_path, .{});
    defer package_dir.close();

    var data_dir = try package_dir.openDir("data", .{});
    defer data_dir.close();

    var chip_files = std.ArrayList(std.json.Parsed(ChipFile)).init(allocator);
    defer {
        for (chip_files.items) |chip_file|
            chip_file.deinit();
        chip_files.deinit();
    }

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

        try chip_files.append(chips_file);
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
        try register_files.put(register_name, register_file);
    }

    // sort to try to keep things somewhat in order
    std.sort.insertion(std.json.Parsed(ChipFile), chip_files.items, {}, chip_file_less_than);

    var db = try regz.Database.create(gpa.allocator());
    defer db.destroy();

    for (register_files.keys(), register_files.values()) |name, register_file| {
        const periph_id = try db.create_peripheral(.{
            .name = name,
        });

        var enums = std.StringArrayHashMap(regz.Database.EnumID).init(allocator);
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

                const register_id = try db.create_register(group_id, .{
                    .name = register_name,
                    .description = description,
                    .offset_bytes = @intCast(byte_offset),
                    .size_bits = 32,
                    .count = if (item.object.get("array")) |array| blk: {
                        if (array.object.get("len")) |count| {
                            // ensure stride is always 4 for now, assuming that
                            // it's in bytes
                            const stride = array.object.get("stride").?.integer;
                            if (stride != 4) {
                                std.log.warn("ignoring register array with unsupported stride: {} != 4 for register {s} in {s} in {s}", .{ stride, register_name, key["block/".len..], name });
                                break :blk null;
                            }

                            break :blk @intCast(count.integer);
                        }

                        break :blk null;
                    } else null,
                });

                if (item.object.get("fieldset")) |fieldset| blk: {
                    const fieldset_key = try std.fmt.allocPrint(allocator, "fieldset/{s}", .{fieldset.string});
                    const fieldset_value = (register_file.value.object.get(fieldset_key) orelse break :blk).object;
                    for (fieldset_value.get("fields").?.array.items) |field| {
                        const field_name = field.object.get("name").?.string;
                        const field_description: ?[]const u8 = if (field.object.get("description")) |desc| desc.string else null;
                        const bit_offset = switch (field.object.get("bit_offset").?) {
                            .integer => |int| int,
                            else => |val| {
                                std.log.warn("skipping {s}, it's a {}", .{ field_name, val });
                                break :blk;
                            },
                        };

                        const bit_size = field.object.get("bit_size").?.integer;
                        const enum_id: ?regz.Database.EnumID = if (field.object.get("enum")) |enum_name|
                            if (enums.get(enum_name.string)) |enum_id| enum_id else null
                        else
                            null;
                        var array_count: ?u16 = null;
                        var array_stride: ?u8 = null;
                        if (field.object.get("array")) |array| {
                            array_count = if (array.object.get("len")) |len| @intCast(len.integer) else null;
                            array_stride = if (array.object.get("stride")) |stride| @intCast(stride.integer) else null;
                        }

                        try db.add_register_field(register_id, .{
                            .name = field_name,
                            .description = field_description,
                            .offset_bits = @intCast(bit_offset),
                            .size_bits = @intCast(bit_size),
                            .enum_id = enum_id,
                            .count = array_count,
                            .stride = array_stride,
                        });
                    }
                }
            }
        }
    }

    for (chip_files.items) |chip_file| {
        const core = chip_file.value.cores[0];
        const device_id = try db.create_device(.{
            .name = chip_file.value.name,
            // TODO
            .arch = std.meta.stringToEnum(regz.Database.Arch, core_to_cpu.get(core.name).?).?,
        });

        const device = try db.get_device_by_name(arena.allocator(), chip_file.value.name);
        try regz.arm.load_system_interrupts(db, &device);

        // TODO: how do we want to handle multi core MCUs?
        //
        // For now we're only using the first core. We'll likely have to combine the
        // sets of peripherals, there will potentially be overlap, but if there
        // are differences between cores that's something the user will have
        // to keep track of.

        for (core.interrupts) |interrupt| {
            _ = try db.create_interrupt(device_id, .{
                .name = interrupt.name,
                .idx = interrupt.number,
            });
        }

        for (core.peripherals) |peripheral| {
            // TODO: don't know what to do if registers is null, so skipping
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

    const chips_file = try std.fs.cwd().createFile("src/Chips.zig", .{});
    defer chips_file.close();

    try generate_chips_file(allocator, chips_file.writer(), chip_files.items);

    const out_file = try std.fs.cwd().createFile("src/chips/all.zig", .{});
    defer out_file.close();

    try db.backup("stm32.regz");

    db.to_zig(out_file.writer(), .{ .for_microzig = true }) catch |err| {
        std.log.err("Failed to write", .{});
        return err;
    };
}

const core_to_cpu = std.StaticStringMap([]const u8).initComptime(&.{
    .{ "cm0", "cortex_m0" },
    .{ "cm0p", "cortex_m0plus" },
    .{ "cm3", "cortex_m3" },
    .{ "cm4", "cortex_m4" },
    .{ "cm7", "cortex_m7" },
    .{ "cm33", "cortex_m33" },
});

fn generate_chips_file(
    allocator: std.mem.Allocator,
    writer: anytype,
    chip_files: []const std.json.Parsed(ChipFile),
) !void {
    try writer.writeAll(
        \\const std = @import("std");
        \\const microzig = @import("microzig/build-internals");
        \\
        \\const Self = @This();
        \\
        \\
    );

    for (chip_files) |json| {
        const chip_file = json.value;
        try writer.print("{}: *microzig.Target,\n", .{std.zig.fmtId(chip_file.name)});
    }

    try writer.writeAll(
        \\
        \\pub fn init(dep: *std.Build.Dependency) Self {
        \\    const b = dep.builder;
        \\    const register_definition_path = b.path("src/chips/all.zig");
        \\
        \\    var ret: Self = undefined;
        \\
        \\
    );

    for (chip_files) |json| {
        const chip_file = json.value;
        const core = chip_file.cores[0];

        const fpu_feature = std.StaticStringMap([]const u8).initComptime(&.{
            .{ "cm4", "vfp4d16sp" },
            .{ "cm7", "fp_armv8d16sp" },
            .{ "cm33", "vfp4d16sp" },
        });

        var with_fpu = false;
        for (core.interrupts) |item| {
            if (std.mem.indexOf(u8, item.name, "FPU")) |_| {
                with_fpu = true;
                break;
            }
        }

        try writer.print(
            \\    ret.{} = b.allocator.create(microzig.Target) catch @panic("out of memory");
            \\    ret.{}.* = .{{
            \\        .dep = dep,
            \\        .preferred_binary_format = .elf,
            \\        .chip = .{{
            \\            .name = "{s}",
            \\            .cpu = .{{
            \\                .cpu_arch = .thumb,
            \\                .cpu_model = .{{ .explicit = &std.Target.arm.cpu.{s} }},
            \\                .os_tag = .freestanding,
            \\
        , .{
            std.zig.fmtId(chip_file.name),
            std.zig.fmtId(chip_file.name),
            chip_file.name,
            core_to_cpu.get(core.name).?,
        });

        if (with_fpu) {
            try writer.print(
                \\                .cpu_features_add = std.Target.arm.featureSet(&.{{.{s}}}),
                \\                .abi = .eabihf,
                \\            }},
                \\
            , .{
                fpu_feature.get(core.name).?,
            });
        } else {
            try writer.writeAll(
                \\                .abi = .eabi,
                \\            },
                \\
            );
        }

        try writer.writeAll(
            \\            .register_definition = .{
            \\                .zig = register_definition_path,
            \\            },
            \\            .memory_regions = &.{
            \\
        );

        {
            var chip_memory = try std.ArrayList(ChipFile.Memory).initCapacity(allocator, chip_file.memory.len);
            defer chip_memory.deinit();

            // Some flash bank regions are not merged so we better do that.
            // Flash memory names are formated as: BANK_{id}_REGION_{id}.

            if (chip_file.memory.len == 0) break;

            var flash_bank: ?ChipFile.Memory = null;
            for (chip_file.memory) |memory| {
                if (memory.kind == .flash) {
                    var part_iter = std.mem.splitBackwards(u8, memory.name, "_");

                    // Ignore the region id.
                    _ = part_iter.next() orelse return error.InvalidMemoryName;

                    // Ignore 'REGION'.
                    _ = part_iter.next() orelse return error.InvalidMemoryName;

                    if (part_iter.rest().len > 0) {
                        // If there are two underscores then a bank is split into regions.
                        // The rest is equal to BANK_{id}.
                        const core_ident = part_iter.rest();

                        if (flash_bank) |*bank| {
                            // Are we in the same bank? Then make it bigger.
                            if (std.mem.startsWith(u8, bank.name, core_ident)) {
                                // Assert regions are adjacent.
                                std.debug.assert(bank.address + bank.size == memory.address);
                                bank.size += memory.size;

                                continue;
                            }
                        } else {
                            // This is the beggining of a bank with regions.
                            flash_bank = memory;
                            flash_bank.?.name = core_ident;

                            continue;
                        }
                    }
                }

                if (flash_bank) |bank| {
                    chip_memory.appendAssumeCapacity(bank);
                    flash_bank = null;
                }
                chip_memory.appendAssumeCapacity(memory);
            }

            if (flash_bank) |bank| {
                chip_memory.appendAssumeCapacity(bank);
            }

            for (chip_memory.items) |memory| {
                try writer.print(
                    \\                .{{ .offset = 0x{X}, .length = 0x{X}, .kind = .{s} }},
                    \\
                , .{ memory.address, memory.size, switch (memory.kind) {
                    .flash => "flash",
                    .ram => "ram",
                } });
            }
        }

        try writer.writeAll(
            \\            },
            \\        },
            \\
        );

        // TODO: Better system to detect if hal is present.
        if (std.mem.startsWith(u8, chip_file.name, "STM32F103")) {
            try writer.writeAll(
                \\        .hal = .{
                \\            .root_source_file = b.path("src/hals/STM32F103/hal.zig"),
                \\        },
                \\
            );
        }

        try writer.writeAll(
            \\    };
            \\
            \\
        );
    }

    try writer.writeAll(
        \\    return ret;
        \\}
        \\
    );
}

fn chip_file_less_than(_: void, lhs: std.json.Parsed(ChipFile), rhs: std.json.Parsed(ChipFile)) bool {
    return std.ascii.lessThanIgnoreCase(lhs.value.name, rhs.value.name);
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
