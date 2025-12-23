const std = @import("std");
const regz = @import("regz");
const ChipFile = regz.embassy.ChipFile;

pub const std_options = std.Options{
    .log_level = .info,
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

    var chip_files = std.array_list.Managed(std.json.Parsed(ChipFile)).init(allocator);
    defer {
        for (chip_files.items) |chip_file|
            chip_file.deinit();
        chip_files.deinit();
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

    // sort to try to keep things somewhat in order
    std.sort.insertion(std.json.Parsed(ChipFile), chip_files.items, {}, ChipFile.less_than);

    const chips_file = try std.fs.cwd().createFile("src/Chips.zig", .{});
    defer chips_file.close();

    var buf: [4096]u8 = undefined;
    var writer = chips_file.writer(&buf);
    try generate_chips_file(allocator, &writer.interface, chip_files.items);
}

// Chip
//  - name
//  - core
//  - memory

fn generate_chips_file(
    allocator: std.mem.Allocator,
    writer: *std.Io.Writer,
    chip_files: []const std.json.Parsed(ChipFile),
) !void {
    try writer.writeAll(
        \\//AUTOMATICALLY GENERATED FILE!
        \\//For modifications, consider editing the generation script in generate.zig
        \\
        \\const std = @import("std");
        \\const microzig = @import("microzig/build-internals");
        \\
        \\const Self = @This();
        \\
        \\
    );

    for (chip_files) |json| {
        const chip_file = json.value;
        try writer.print("{f}: *microzig.Target,\n", .{std.zig.fmtId(chip_file.name)});
    }

    try writer.writeAll(
        \\
        \\pub fn init(dep: *std.Build.Dependency) Self {
        \\    const b = dep.builder;
        \\    const embassy = b.dependency("stm32-data-generated", .{}).path(".");
        \\    var ret: Self = undefined;
        \\    const hal_imports: []std.Build.Module.Import = b.allocator.dupe(std.Build.Module.Import, &.{
        \\     .{ 
        \\          .name = "ClockTree",
        \\          .module = std.Build.Module.create(b, .{ .root_source_file = b.path("stm32-clocks/lib.zig") }),
        \\      },
        \\    }) catch @panic("out of memory");
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
            \\    ret.{f} = b.allocator.create(microzig.Target) catch @panic("out of memory");
            \\    ret.{f}.* = .{{
            \\        .dep = dep,
            \\        .preferred_binary_format = .elf,
            \\        .zig_target = .{{
            \\            .cpu_arch = .thumb,
            \\            .cpu_model = .{{ .explicit = &std.Target.arm.cpu.{s} }},
            \\            .os_tag = .freestanding,
            \\
        , .{
            std.zig.fmtId(chip_file.name),
            std.zig.fmtId(chip_file.name),
            regz.embassy.core_to_cpu.get(core.name).?,
        });

        if (with_fpu) {
            try writer.print(
                \\            .cpu_features_add = std.Target.arm.featureSet(&.{{.{s}}}),
                \\            .abi = .eabihf,
                \\        }},
                \\
            , .{
                fpu_feature.get(core.name).?,
            });
        } else {
            try writer.writeAll(
                \\            .abi = .eabi,
                \\        },
                \\
            );
        }

        try writer.print(
            \\        .chip = .{{
            \\            .name = "{s}",
            \\            .register_definition = .{{
            \\                .embassy = embassy,
            \\            }},
            \\            .memory_regions = &.{{
            \\
        ,
            .{chip_file.name},
        );

        {
            var chip_memory = try std.array_list.Managed(ChipFile.Memory).initCapacity(allocator, chip_file.memory.len);
            defer chip_memory.deinit();

            // Some flash bank regions are not merged so we better do that.
            // Flash memory names are formated as: BANK_{id}_REGION_{id}.

            if (chip_file.memory.len == 0) break;

            var flash_bank: ?ChipFile.Memory = null;
            for (chip_file.memory) |memory| {
                if (memory.kind == .flash) {
                    var part_iter = std.mem.splitBackwardsScalar(u8, memory.name, '_');

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
                    \\                .{{ .tag = .{s}, .offset = 0x{X}, .length = 0x{X}, .access = .{s} }},
                    \\
                , .{ switch (memory.kind) {
                    .flash => "flash",
                    .ram => "ram",
                }, memory.address, memory.size, switch (memory.kind) {
                    .flash => "rx",
                    .ram => "rwx",
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
                \\            .root_source_file = b.path("src/hals/STM32F103.zig"),
                \\            .imports = hal_imports,
                \\        },
                \\
            );
        }
        if (std.mem.startsWith(u8, chip_file.name, "STM32L47")) {
            try writer.writeAll(
                \\        .hal = .{
                \\            .root_source_file = b.path("src/hals/STM32L47X.zig"),
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

    try writer.flush();
}
