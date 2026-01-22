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
            .files = &[_][]const u8{"port.c"},
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

    // Add some Pico SDK glue code
    // TODO: maybee we should use Pico sourcee filee directly?
    // but curreent way we know what is internaly used by FreeRTOS port
    freertos_lib.addCSourceFiles(.{
        .root = b.path("."),
        .files = &[_][]const u8{ "src/picosdk_irq.c", "src/picosdk_exception.c" },
        .flags = &flags,
    });

    // Pico SDK include paths
    const picosdk_dep = b.dependency("picosdk", .{});
    const picosdk_root = picosdk_dep.path(".");

    if (port_name == .RP2040) {
        addPicoSDKIncludeDirs(b, freertos_lib, picosdk_root, .RP2040);
    } else if (port_name == .RP2350_ARM or port_name == .RP2350_RISCV) {
        addPicoSDKIncludeDirs(b, freertos_lib, picosdk_root, .RP2350);
    }
    //freertos_lib.addIncludePath(b.path("picosdk/include_common/"));
    //if (port_name == .RP2040) {
    //    freertos_lib.addIncludePath(b.path("picosdk/include_rp2040/"));
    //} else if (port_name == .RP2350_ARM or port_name == .RP2350_RISCV) {
    //    freertos_lib.addIncludePath(b.path("picosdk/include_rp2350/"));

    // TODO: USE addConfigHeader instead?
    freertos_lib.addCMacro("configSMP_SPINLOCK_0", "PICO_SPINLOCK_ID_OS1");
    freertos_lib.addCMacro("configSMP_SPINLOCK_1", "PICO_SPINLOCK_ID_OS2");

    freertos_lib.addCMacro("LIB_PICO_MULTICORE", "1");

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

const Chip = enum {
    RP2040,
    RP2350,
};

fn addPicoSDKIncludeDirs(
    b: *std.Build,
    mod: *std.Build.Module,
    pico_root: std.Build.LazyPath,
    chip: Chip,
) void {
    const wf = b.addWriteFiles();

    // Generate version.h
    const cmake_version_file = b.addConfigHeader(.{ .style = .{ .cmake = pico_root.path(b, "src/common/pico_base_headers/include/pico/version.h.in") } }, .{
        .PICO_SDK_VERSION_STRING = "2.2.0",
        .PICO_SDK_VERSION_MAJOR = "2",
        .PICO_SDK_VERSION_MINOR = "2",
        .PICO_SDK_VERSION_REVISION = "0",
    });

    _ = wf.addCopyFile(cmake_version_file.getOutput(), "picosdk_generated/pico/version.h");

    // Generate required config_autogen.h (this support custom #include directives)
    _ = wf.addCopyFile(pico_root.path(b, "bazel/include/pico/config_autogen.h"), "picosdk_generated/pico/config_autogen.h");
    _ = wf.add("picosdk_generated/pico/pico_config_extra_headers.h", "");
    _ = wf.add("picosdk_generated/pico/pico_config_platform_headers.h", "");

    // Add generated files to include path
    mod.addIncludePath(wf.getDirectory().path(b, "picosdk_generated"));

    // The Pico SDK places this header behind an extra directory level that is not compatible
    // with our automatic include-path registration logic. Because <sys/cdefs.h> is expected
    // to be found directly under "sys/", we copy it into a synthetic include directory with
    // the correct relative structure.
    _ = wf.addCopyFile(pico_root.path(b, "src/rp2_common/pico_clib_interface/include/llvm_libc/sys/cdefs.h"), "llvm_libc/sys/cdefs.h");
    mod.addIncludePath(wf.getDirectory().path(b, "llvm_libc"));

    // Add all relevant include directories from Pico SDK
    addAllIncludeDirs(b, mod, pico_root, "src/common");
    addAllIncludeDirs(b, mod, pico_root, "src/rp2_common");

    if (chip == .RP2040) {
        mod.addCMacro("PICO_RP2040", "1");
        addAllIncludeDirs(b, mod, pico_root, "src/rp2040");
    } else if (chip == .RP2350) {
        mod.addCMacro("PICO_RP2350", "1");
        // Be defualt RP2350 is using software spinlocks because of some errata
        // don't know what it is exactly but we will force hardware spinlocks anyway
        // to simplify compilation of this module
        mod.addCMacro("PICO_USE_SW_SPIN_LOCKS", "0");
        addAllIncludeDirs(b, mod, pico_root, "src/rp2350");
    }
}

fn addAllIncludeDirs(
    b: *std.Build,
    mod: *std.Build.Module,
    base: std.Build.LazyPath,
    subdir: []const u8,
) void {
    const allocator = b.allocator;
    const full = std.fs.path.join(allocator, &.{ base.getPath(b), subdir }) catch @panic("join");
    defer allocator.free(full);

    var dir = std.fs.openDirAbsolute(full, .{ .iterate = true }) catch return;
    defer dir.close();

    var walker = dir.walk(allocator) catch @panic("walk");
    defer walker.deinit();

    while (walker.next() catch @panic("next")) |e| {
        if (e.kind != .directory) continue;
        if (!std.mem.eql(u8, std.fs.path.basename(e.path), "include")) continue;

        const inc = std.fs.path.join(allocator, &.{ full, e.path }) catch @panic("join2");
        defer allocator.free(inc);

        mod.addIncludePath(.{ .cwd_relative = inc });
    }
}
