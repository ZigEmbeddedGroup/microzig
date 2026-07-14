const std = @import("std");
const microzig = @import("microzig/build-internals");

chips: Chips,
boards: Boards,

pub const ChipVariant = struct {
    name: []const u8,
    flash_kb: u32,
    sram_kb: u32,
};

// Maybe somehow get the ram and flash size automatically in the future?
// Flash size seems too be (1 << last_name_digit) KiB
pub const chip_variants: []const ChipVariant = &.{
    // C series
    // .{ .name = "MSPM0C1103", .flash_kb = 8, .sram_kb = 1 },
    .{ .name = "MSPM0C1104", .flash_kb = 16, .sram_kb = 1 },
    // .{ .name = "MSPM0C1105", .flash_kb = 32, .sram_kb = 8 },
    // .{ .name = "MSPM0C1106", .flash_kb = 64, .sram_kb = 8 },

    // G series
    // .{ .name = "MSPM0G1105", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0G1106", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0G1107", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G1207", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G1218", .flash_kb = 256, .sram_kb = },
    // .{ .name = "MSPM0G1505", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0G1506", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0G1507", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G1518", .flash_kb = 256, .sram_kb = },
    // .{ .name = "MSPM0G1519", .flash_kb = 512, .sram_kb = },
    // .{ .name = "MSPM0G3105", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0G3106", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0G3107", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G3207", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G3218", .flash_kb = 256, .sram_kb = },
    // .{ .name = "MSPM0G3505", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0G3506", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0G3507", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G3518", .flash_kb = 256, .sram_kb = },
    // .{ .name = "MSPM0G3519", .flash_kb = 512, .sram_kb = },
    // .{ .name = "MSPM0G3529", .flash_kb = 512, .sram_kb = },
    // .{ .name = "MSPM0G5115", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0G5116", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0G5117", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0G5187", .flash_kb = 128, .sram_kb = },

    // H series
    // .{ .name = "MSPM0H3215", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0H3216", .flash_kb = 64, .sram_kb = 8 },

    // L series
    // .{ .name = "MSPM0L1105", .flash_kb = 32, .sram_kb = 4 },
    // .{ .name = "MSPM0L1106", .flash_kb = 64, .sram_kb = 4 },
    // .{ .name = "MSPM0L1116", .flash_kb = 64, .sram_kb = 16 },
    // .{ .name = "MSPM0L1117", .flash_kb = 128, .sram_kb = 16 },
    // .{ .name = "MSPM0L1126", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0L1127", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0L1227", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0L1228", .flash_kb = 256, .sram_kb = },
    // .{ .name = "MSPM0L1303", .flash_kb = 8, .sram_kb = 2 },
    // .{ .name = "MSPM0L1304", .flash_kb = 16, .sram_kb = 2 },
    // .{ .name = "MSPM0L1305", .flash_kb = 32, .sram_kb = 4 },
    // .{ .name = "MSPM0L1306", .flash_kb = 64, .sram_kb = 4 },
    // .{ .name = "MSPM0L1343", .flash_kb = 8, .sram_kb = },
    // .{ .name = "MSPM0L1344", .flash_kb = 16, .sram_kb = },
    // .{ .name = "MSPM0L1345", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0L1346", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0L2104", .flash_kb = 16, .sram_kb = },
    // .{ .name = "MSPM0L2105", .flash_kb = 32, .sram_kb = },
    // .{ .name = "MSPM0L2116", .flash_kb = 64, .sram_kb = },
    // .{ .name = "MSPM0L2117", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0L2227", .flash_kb = 128, .sram_kb = },
    // .{ .name = "MSPM0L2228", .flash_kb = 256, .sram_kb = },
};

pub const Chips = @Struct(
    .auto,
    null,
    blk: {
        var ret: [chip_variants.len][]const u8 = undefined;
        for (chip_variants, 0..) |v, i| ret[i] = v.name;
        break :blk &ret;
    },
    &@splat(*microzig.Target),
    &@splat(.{}),
);

pub const Boards = struct {};

pub fn init(dep: *std.Build.Dependency) ?@This() {
    const b = dep.builder;
    const ti_data = b.lazyDependency("ti_data", .{}) orelse return null;
    const targetdb = ti_data.path("targetdb");

    const patch_paths = [_][]const u8{
        "patches/gpio.zon",
        "patches/uart.zon",
    };
    const patch_files = b.allocator.alloc(std.Build.LazyPath, patch_paths.len) catch @panic("OOM");
    for (patch_files, patch_paths) |*dst, src|
        dst.* = b.path(src);

    var chips: Chips = undefined;

    inline for (chip_variants) |v| {
        const chip = b.allocator.create(microzig.Target) catch @panic("OOM");
        chip.* = .{
            .dep = dep,
            .preferred_binary_format = .elf,
            .zig_target = .{
                .cpu_arch = .thumb,
                .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .chip = .{
                .name = v.name,
                .register_definition = .{ .targetdb = .{
                    .path = targetdb,
                    .device = v.name,
                } },
                .memory_regions = comptime &.{
                    .{ .tag = .flash, .offset = 0x0000_0000, .length = v.flash_kb * 1024, .access = .rx },
                    .{ .tag = .ram, .offset = 0x2000_0000, .length = v.sram_kb * 1024, .access = .rwx },
                },
                .patch_files = patch_files,
            },
            .hal = .{ .root_source_file = dep.builder.path("src/hal.zig") },
        };
        @field(chips, v.name) = chip;
    }

    return .{
        .chips = chips,
        .boards = .{},
    };
}

pub fn build(b: *std.Build) !void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
