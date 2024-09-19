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

        const register_file = try std.json.parseFromTokenSource(std.json.Value, allocator, &scanner, .{
            .allocate = .alloc_always,
        });
        errdefer register_file.deinit();

        const register_name = try allocator.dupe(u8, entry.name[0 .. entry.name.len - std.fs.path.extension(entry.name).len]);
        try register_files.put(register_name, register_file);
    }

    // sort to try to keep things somewhat in order
    std.sort.insertion(std.json.Parsed(ChipFile), chip_files.items, {}, chip_file_less_than);

    var db = try regz.Database.init(gpa.allocator());
    defer db.deinit();

    for (register_files.keys(), register_files.values()) |name, register_file| {
        const periph_id = try db.create_peripheral(.{
            .name = name,
        });
        for (register_file.value.object.keys(), register_file.value.object.values()) |key, obj| {
            if (!std.mem.startsWith(u8, key, "block/"))
                continue;

            const group_id = try db.create_register_group(periph_id, .{
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
                    .offset = @intCast(byte_offset),
                    .size = 32,
                    .count = if (item.object.get("array")) |array| blk: {
                        if (array.object.get("len")) |count| {
                            // ensure stride is always 4 for now, assuming that
                            // it's in bytes
                            const stride = array.object.get("stride").?.integer;
                            if (stride != 4) {
                                std.log.warn("found stride: {} for {s} in {s} in {s}", .{ stride, register_name, key["block/".len..], name });
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

                        _ = try db.create_field(register_id, .{
                            .name = field_name,
                            .description = field_description,
                            .offset = @intCast(bit_offset),
                            .size = @intCast(bit_size),
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
            .arch = std.meta.stringToEnum(regz.Database.Arch, core_to_microzig_cpu.get(core.name).?).?,
        });

        try regz.arm.load_system_interrupts(&db, device_id);

        // TODO: how do we want to handle multi core MCUs?
        //
        // For now we're only using the first core. We'll likely have to combine the
        // sets of peripherals, there will potentially be overlap, but if there
        // are differences between cores that's something the user will have
        // to keep track of.

        for (core.interrupts) |interrupt| {
            _ = try db.create_interrupt(device_id, .{
                .name = interrupt.name,
                .index = interrupt.number,
            });
        }

        for (core.peripherals) |peripheral| {
            // TODO: don't know what to do if registers is null, so skipping
            const registers = peripheral.registers orelse continue;

            const periph_name = try std.fmt.allocPrint(allocator, "{s}_{s}", .{ registers.kind, registers.version });
            // get the register group representing the peripheral instance
            const periph_id = try db.get_entity_id_by_name("type.peripheral", periph_name);
            const children = db.children.register_groups.get(periph_id).?;
            const register_group_id = for (children.keys()) |child_id| {
                const child_name = db.attrs.name.get(child_id).?;
                if (std.mem.eql(u8, child_name, registers.block))
                    break child_id;
            } else return error.FailedToFindRegisterGroup;

            _ = try db.create_peripheral_instance(device_id, register_group_id, .{
                .name = peripheral.name,
                .offset = peripheral.address,
            });
        }
    }

    const chips_file = try std.fs.cwd().createFile("src/chips.zig", .{});
    defer chips_file.close();

    try generate_chips_file(chips_file.writer(), chip_files.items);

    const out_file = try std.fs.cwd().createFile("src/chips/all.zig", .{});
    defer out_file.close();

    db.to_zig(out_file.writer()) catch |err| {
        std.log.err("Failed to write", .{});
        return err;
    };
}

const core_to_microzig_cpu = std.StaticStringMap([]const u8).initComptime(&.{
    .{ "cm0", "cortex_m0" },
    .{ "cm0p", "cortex_m0plus" },
    .{ "cm3", "cortex_m3" },
    .{ "cm4", "cortex_m4" },
    .{ "cm7", "cortex_m7" },
    .{ "cm33", "cortex_m33" },
});

fn generate_chips_file(writer: anytype, chip_files: []const std.json.Parsed(ChipFile)) !void {
    try writer.writeAll(
        \\const std = @import("std");
        \\const MicroZig = @import("microzig/build");
        \\
        \\fn root() []const u8 {
        \\    return comptime (std.fs.path.dirname(@src().file) orelse ".");
        \\}
        \\const build_root = root();
        \\const register_definition_path = build_root ++ "/chips/all.zig";
        \\
    );

    for (chip_files) |json| {
        const chip_file = json.value;
        try writer.print(
            \\
            \\pub const {} = MicroZig.Target{{
            \\    .preferred_format = .elf,
            \\    .chip = .{{
            \\        .name = "{s}",
            \\        .cpu = MicroZig.cpus.{s},
            \\        .memory_regions = &.{{
            \\
        , .{
            std.zig.fmtId(chip_file.name),
            chip_file.name,
            core_to_microzig_cpu.get(chip_file.cores[0].name) orelse {
                std.log.err("Unhandled core name: '{s}'", .{chip_file.cores[0].name});
                return error.UnhandledCoreName;
            },
        });

        for (chip_file.memory) |memory| {
            try writer.print(
                \\            .{{ .offset = 0x{X}, .length = 0x{X}, .kind = .{s} }},
                \\
            , .{ memory.address, memory.size, switch (memory.kind) {
                .flash => "flash",
                .ram => "ram",
            } });
        }

        try writer.writeAll(
            \\        },
            \\        .register_definition = .{
            \\            .zig = .{ .cwd_relative = register_definition_path },
            \\        },
            \\    },
            \\
        );

        // For now
        if (std.mem.startsWith(u8, chip_file.name, "STM32F103")) {
            try writer.writeAll(
                \\    .hal = .{
                \\        .root_source_file = .{ .cwd_relative = build_root ++ "/hals/STM32F103/hal.zig" },
                \\    },
                \\
                ,
            );
        }

        try writer.writeAll(
            \\};
            \\
        );
    }
}

fn chip_file_less_than(_: void, lhs: std.json.Parsed(ChipFile), rhs: std.json.Parsed(ChipFile)) bool {
    return std.ascii.lessThanIgnoreCase(lhs.value.name, rhs.value.name);
}
