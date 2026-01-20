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

    if (port_name != .RP2040) {
        @panic("Right now only RP2040 port is supported");
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

    // Add FreeRTOS kernel source files
    freertos_lib.addCSourceFiles(.{
        .root = freertos_kernel_dep.path("."),
        .files = &files,
        .flags = &flags,
    });

    // FreeRTOS include paths
    freertos_lib.addIncludePath(b.path("config"));
    freertos_lib.addIncludePath(freertos_kernel_dep.path("include"));

    // Add FreeRTOS port source files
    freertos_lib.addCSourceFiles(.{
        .root = freertos_kernel_dep.path("./portable/ThirdParty/GCC/RP2040/"),
        .files = &files_port,
        .flags = &flags,
    });

    // FreeRTOS port include paths
    freertos_lib.addIncludePath(freertos_kernel_dep.path("./portable/ThirdParty/GCC/RP2040/include/"));

    // Pico SDK include paths
    freertos_lib.addIncludePath(b.path("picosdk/include_common/"));
    freertos_lib.addIncludePath(b.path("picosdk/include_rp2040/"));

    // TODO: USE addConfigHeader instead?
    freertos_lib.addCMacro("configSMP_SPINLOCK_0", "PICO_SPINLOCK_ID_OS1");
    freertos_lib.addCMacro("configSMP_SPINLOCK_1", "PICO_SPINLOCK_ID_OS2");

    freertos_lib.addCMacro("LIB_PICO_MULTICORE", "0");

    // Had problems when this was enabled.
    // Microzig but also Pico SDK? dont set VTOR to 0x10000100 for RP2040 at boot even when ram_vector_table is set to false
    freertos_lib.addCMacro("PICO_NO_RAM_VECTOR_TABLE", "0");

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
const files_port = [_][]const u8{
    "port.c",
};
