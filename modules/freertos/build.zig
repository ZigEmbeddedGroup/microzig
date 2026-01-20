const std = @import("std");

const FreeRTOSPort = enum {
    RP2040,
    RP2350_ARM,
    RP2350_RISCV,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Configurable options
    const port_name = b.option(
        FreeRTOSPort,
        "port_name",
        "FreeRTOS port to use",
    ) orelse .RP2040;

    if (port_name != .RP2040 and port_name != .RP2350_ARM) {
        @panic("Right now only RP2040 and RP2350_ARM ports are supported");
    }

    const foundationlibc_dep = b.dependency("foundationlibc", .{
        .target = target,
        .optimize = optimize,
        .single_threaded = true,
    });

    const freertos_lib = b.addModule("freertos_lib", .{
        .target = target,
        .optimize = optimize,
    });

    // Link libc
    freertos_lib.linkLibrary(foundationlibc_dep.artifact("foundation"));

    const freertos_kernel_dep = b.dependency("freertos_kernel", .{});
    const freertos_kernel_community_dep = b.dependency("freertos_kernel_community", .{});

    // Add FreeRTOS kernel source files
    freertos_lib.addCSourceFiles(.{
        .root = freertos_kernel_dep.path("."),
        .files = &files,
        .flags = &flags,
    });

    // FreeRTOS include paths
    freertos_lib.addIncludePath(freertos_kernel_dep.path("include"));

    // FreeRTOS port-specific files and include paths
    if (port_name == .RP2040) {
        freertos_lib.addCSourceFiles(.{
            .root = freertos_kernel_dep.path("./portable/ThirdParty/GCC/RP2040/"),
            .files = &[_][]const u8{
                "port.c",
            },
            .flags = &flags,
        });

        freertos_lib.addIncludePath(b.path("config/RP2040/"));
        freertos_lib.addIncludePath(freertos_kernel_dep.path("./portable/ThirdParty/GCC/RP2040/include/"));
    } else if (port_name == .RP2350_ARM) {
        freertos_lib.addCSourceFiles(.{
            .root = freertos_kernel_community_dep.path("./GCC/RP2350_ARM_NTZ/non_secure/"),
            .files = &[_][]const u8{ "port.c", "portasm.c" },
            .flags = &flags,
        });

        freertos_lib.addIncludePath(b.path("config/RP2350_ARM/"));
        freertos_lib.addIncludePath(freertos_kernel_community_dep.path("./GCC/RP2350_ARM_NTZ/non_secure/"));
    }

    // Pico SDK include paths
    freertos_lib.addIncludePath(b.path("picosdk/include_common/"));
    if (port_name == .RP2040) {
        freertos_lib.addIncludePath(b.path("picosdk/include_rp2040/"));
    } else if (port_name == .RP2350_ARM or port_name == .RP2350_RISCV) {
        freertos_lib.addIncludePath(b.path("picosdk/include_rp2350/"));
    }

    // TODO: USE addConfigHeader instead?
    freertos_lib.addCMacro("configSMP_SPINLOCK_0", "PICO_SPINLOCK_ID_OS1");
    freertos_lib.addCMacro("configSMP_SPINLOCK_1", "PICO_SPINLOCK_ID_OS2");

    freertos_lib.addCMacro("LIB_PICO_MULTICORE", "0");

    // Had problems when this was enabled.
    // Microzig but also Pico SDK? dont set VTOR to 0x10000100 for RP2040 at boot even when ram_vector_table is set to false
    freertos_lib.addCMacro("PICO_NO_RAM_VECTOR_TABLE", "0");
    freertos_lib.addCMacro("PICO_SDK_VERSION_MAJOR", "2");

    const mod = b.addModule("freertos", .{ .root_source_file = b.path("src/root.zig"), .target = target, .optimize = optimize });
    mod.addImport("freertos_lib", freertos_lib);

    for (freertos_lib.c_macros.items) |m| {
        mod.c_macros.append(b.allocator, m) catch @panic("out of memory");
    }
    for (freertos_lib.include_dirs.items) |dir| {
        mod.include_dirs.append(b.allocator, dir) catch @panic("out of memory");
    }
}

const flags = [_][]const u8{ "-std=c11", "-fno-sanitize=undefined", "-Wno-pointer-to-int-cast" };
const files = [_][]const u8{
    "croutine.c",
    "event_groups.c",
    "list.c",
    "queue.c",
    "stream_buffer.c",
    "tasks.c",
    "timers.c",
    "portable/MemMang/heap_1.c",
};
