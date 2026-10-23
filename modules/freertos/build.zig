const std = @import("std");
const Translator = @import("translate_c").Translator;

pub const FreeRTOS_Port = enum {
    RP2040,
    RP2350_ARM,
    RP2350_RISCV,
};

const Chip = enum {
    RP2040,
    RP2350,
};

/// A set of files and include directories located under a root directory, which
/// is either the root of a dependency from build.zig.zon or this package itself.
const SourceSet = struct {
    /// Name of the dependency in build.zig.zon, or null for this package.
    dependency: ?[]const u8 = null,
    /// Root directory, relative to the dependency (or this package) root.
    root: []const u8 = ".",
    /// C source files, relative to `root`.
    files: []const []const u8 = &.{},
    /// Include directories, relative to `root`.
    include_dirs: []const []const u8 = &.{},
};

const CMacro = struct {
    name: []const u8,
    value: []const u8,
};

/// Everything needed to build one FreeRTOS port.
const Port = struct {
    id: FreeRTOS_Port,
    description: []const u8,
    chip: Chip,
    /// FreeRTOS port implementation (e.g. from FreeRTOS-Kernel or a community-supported port repo).
    port_sources: SourceSet,
    /// Compatibility shims that provide symbols the port expects from its SDK/platform.
    shims: SourceSet = .{},
    /// Local include directories that must shadow others when running translate-c.
    translate_c_include_dirs: []const []const u8 = &.{},
    c_macros: []const CMacro = &.{},
    /// Hook for adding external dependencies (SDKs, vendor headers, ...) required by the port.
    /// It is called with the module that all port sources are compiled into.
    configure_external: ?*const fn (b: *std.Build, mod: *std.Build.Module, port: Port) void = null,
};

const pico_c_macros = [_]CMacro{
    // TODO: USE addConfigHeader instead?
    .{ .name = "configSMP_SPINLOCK_0", .value = "PICO_SPINLOCK_ID_OS1" },
    .{ .name = "configSMP_SPINLOCK_1", .value = "PICO_SPINLOCK_ID_OS2" },
    // Even if we use just one core we must define this so RP2350 port will compile.
    // It looks like lack of #ifdef LIB_PICO_MULTICORE in RP2350 ARM FreeRTOS port
    // in place where multicore_doorbell_claim_unused is called
    .{ .name = "LIB_PICO_MULTICORE", .value = "1" },
    // Had problems when this was enabled.
    // Microzig but also Pico SDK? dont set VTOR to 0x10000100 for RP2040 at boot even when ram_vector_table is set to false
    .{ .name = "PICO_NO_RAM_VECTOR_TABLE", .value = "0" },
    .{ .name = "PICO_SDK_VERSION_MAJOR", .value = "2" },
};

const ports = [_]Port{
    .{
        .id = .RP2040,
        .description = "FreeRTOS-Kernel RP2040 (Cortex-M0+) port, single core",
        .chip = .RP2040,
        .port_sources = .{
            .dependency = "freertos_kernel",
            .root = "portable/ThirdParty/GCC/RP2040",
            .files = &.{"port.c"},
            .include_dirs = &.{"include"},
        },
        .shims = .{
            .root = "port_shims/raspberrypi",
            .files = &.{
                "picosdk/picosdk_irq.c",
                "picosdk/picosdk_exception.c",
                "rp2040/rp2040_arm/port_shim.c",
            },
        },
        .c_macros = &pico_c_macros,
        .configure_external = configurePicoSDK,
    },
    .{
        .id = .RP2350_ARM,
        .description = "FreeRTOS community RP2350 ARM non-secure (Cortex-M33) port, single core",
        .chip = .RP2350,
        .port_sources = .{
            .dependency = "freertos_kernel_community",
            .root = "GCC/RP2350_ARM_NTZ/non_secure",
            .files = &.{ "port.c", "portasm.c" },
            .include_dirs = &.{"."},
        },
        .shims = .{
            .root = "port_shims/raspberrypi",
            .files = &.{
                "picosdk/picosdk_irq.c",
                "picosdk/picosdk_exception.c",
                "rp2350/rp2350_arm_ntz/port_shim.c",
            },
        },
        // Workaround for https://github.com/Vexu/arocc/issues/1071 (#ifdef inside variadic macro arguments
        // breaks Aro's parser), hit by the RP2350 pico/platform.h. Remove once translate-c includes the fix.
        // Must come before the Pico SDK include dirs so it shadows the SDK's pico/platform.h
        .translate_c_include_dirs = &.{"translate_c_shims/rp2350"},
        .c_macros = &pico_c_macros,
        .configure_external = configurePicoSDK,
    },
};

fn findPort(id: FreeRTOS_Port) Port {
    for (ports) |port| {
        if (port.id == id) return port;
    }
    @panic("Right now only RP2040 and RP2350_ARM ports are supported");
}

fn sourceSetRoot(b: *std.Build, set: SourceSet) std.Build.LazyPath {
    const base = if (set.dependency) |name| b.dependency(name, .{}).path(".") else b.path(".");
    return base.path(b, set.root);
}

fn addSourceSet(b: *std.Build, mod: *std.Build.Module, set: SourceSet) void {
    const root = sourceSetRoot(b, set);

    if (set.files.len > 0) {
        mod.addCSourceFiles(.{
            .root = root,
            .files = set.files,
            .flags = &flags,
        });
    }

    for (set.include_dirs) |dir| {
        mod.addIncludePath(root.path(b, dir));
    }
}

fn configurePicoSDK(b: *std.Build, mod: *std.Build.Module, port: Port) void {
    const picosdk_dep = b.dependency("picosdk", .{});
    addPicoSDKIncludeDirs(b, mod, picosdk_dep, port.chip);
}

const FreeRTOS_Config = struct {
    // Scheduler related
    configUSE_IDLE_HOOK: bool = false,
    configUSE_TICK_HOOK: bool = false,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const translate_c = b.dependency("translate_c", .{});

    // Configurable options
    const port_name = b.option(
        FreeRTOS_Port,
        "port_name",
        "FreeRTOS port to use",
    ) orelse .RP2040;

    const port = findPort(port_name);

    const cfg_idle_hook = b.option(bool, "idle_hook", "Enable FreeRTOS idle hook") orelse false;
    const cfg_tick_hook = b.option(bool, "tick_hook", "Enable FreeRTOS tick hook") orelse false;

    // In future this config might be validated against port-specific capabilities
    const config = FreeRTOS_Config{
        .configUSE_IDLE_HOOK = cfg_idle_hook,
        .configUSE_TICK_HOOK = cfg_tick_hook,
    };

    const config_header = b.addConfigHeader(.{
        .style = .{ .cmake = b.path("config/FreeRTOSConfig.h.cmake") },
        .include_path = "FreeRTOSConfig.h",
    }, config);

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
    // Add generated configuration header
    freertos_lib.addConfigHeader(config_header);

    const freertos_kernel_dep = b.dependency("freertos_kernel", .{});

    // Add FreeRTOS kernel source files
    freertos_lib.addCSourceFiles(.{
        .root = freertos_kernel_dep.path("."),
        .files = &files,
        .flags = &flags,
    });

    // FreeRTOS include paths
    freertos_lib.addIncludePath(freertos_kernel_dep.path("include"));

    // FreeRTOS port-specific files and include paths
    addSourceSet(b, freertos_lib, port.port_sources);

    // Port shims: partial re-implementations of SDK/platform functions that the
    // FreeRTOS port references but MicroZig does not provide.
    addSourceSet(b, freertos_lib, port.shims);

    // External dependencies required by the port (e.g. Pico SDK)
    if (port.configure_external) |configure| {
        configure(b, freertos_lib, port);
    }

    for (port.c_macros) |macro| {
        freertos_lib.addCMacro(macro.name, macro.value);
    }

    const t: Translator = .init(translate_c, .{
        .c_source_file = b.path("include/microzig_freertos.h"),
        .target = target,
        .optimize = optimize,
        .link_libc = false, // libc headers come from foundation-libc, there is no system libc for freestanding
    });
    t.addConfigHeader(config_header);
    t.addIncludePath(freertos_kernel_dep.path("include"));

    for (port.translate_c_include_dirs) |dir| {
        t.addIncludePath(b.path(dir));
    }

    // translate-c needs the same libc/port/SDK headers and macros as freertos_lib
    for (freertos_lib.include_dirs.items) |dir| {
        switch (dir) {
            .path => |p| t.addIncludePath(p),
            .path_system => |p| t.addSystemIncludePath(p),
            .path_after => |p| t.addAfterIncludePath(p),
            .other_step => |lib| t.addIncludePath(lib.getEmittedIncludeTree()),
            .config_header_step => |ch| t.addConfigHeader(ch),
            .framework_path, .framework_path_system, .embed_path => {},
        }
    }
    for (freertos_lib.c_macros.items) |m| {
        t.run.addArg(m);
    }

    const mod = b.addModule("freertos", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{
                .name = "c",
                .module = t.mod,
            },
        },
    });
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

fn addPicoSDKIncludeDirs(
    b: *std.Build,
    mod: *std.Build.Module,
    pico_sdk: *std.Build.Dependency,
    chip: Chip,
) void {
    const wf = b.addWriteFiles();

    // Generate version.h
    const cmake_version_file = b.addConfigHeader(.{ .style = .{ .cmake = pico_sdk.path("src/common/pico_base_headers/include/pico/version.h.in") } }, .{
        .PICO_SDK_VERSION_STRING = "2.2.0",
        .PICO_SDK_VERSION_MAJOR = "2",
        .PICO_SDK_VERSION_MINOR = "2",
        .PICO_SDK_VERSION_REVISION = "0",
    });

    _ = wf.addCopyFile(cmake_version_file.getOutputFile(), "picosdk_generated/pico/version.h");

    // Generate required config_autogen.h (this support custom #include directives)
    _ = wf.addCopyFile(pico_sdk.path("bazel/include/pico/config_autogen.h"), "picosdk_generated/pico/config_autogen.h");
    _ = wf.add("picosdk_generated/pico/pico_config_extra_headers.h", "");
    // Clang reports __sev/__wfe via __has_builtin, so the Pico SDK does not define them itself, but they
    // are only declared by arm_acle.h (which conflicts with other SDK definitions), so provide them here.
    _ = wf.add("picosdk_generated/pico/pico_config_platform_headers.h",
        \\static inline __attribute__((always_inline)) void __sev(void) { __asm volatile("sev"); }
        \\static inline __attribute__((always_inline)) void __wfe(void) { __asm volatile("wfe"); }
        \\
    );

    // Add generated files to include path
    mod.addIncludePath(wf.getDirectory().path(b, "picosdk_generated"));

    // The Pico SDK places this header behind an extra directory level that is not compatible
    // with our automatic include-path registration logic. Because <sys/cdefs.h> is expected
    // to be found directly under "sys/", we copy it into a synthetic include directory with
    // the correct relative structure.
    _ = wf.addCopyFile(pico_sdk.path("src/rp2_common/pico_clib_interface/include/llvm_libc/sys/cdefs.h"), "llvm_libc/sys/cdefs.h");
    mod.addIncludePath(wf.getDirectory().path(b, "llvm_libc"));

    // Add all relevant include directories from Pico SDK
    mod.addIncludePath(pico_sdk.path("src/common/boot_picobin_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/boot_picoboot_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/boot_uf2_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/hardware_claim/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_base_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_binary_info/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_bit_ops_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_divider_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_stdlib_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_sync/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_time/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_usb_reset_interface_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/common/pico_util/include"));

    mod.addIncludePath(pico_sdk.path("src/rp2_common/boot_bootrom_headers/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/cmsis/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_adc/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_base/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_boot_lock/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_clocks/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_dcp/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_divider/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_dma/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_exception/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_flash/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_gpio/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_hazard3/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_i2c/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_interp/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_irq/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_pio/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_pll/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_powman/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_pwm/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_rcp/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_resets/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_riscv/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_riscv_platform_timer/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_rtc/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_sha256/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_spi/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_sync/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_sync_spin_lock/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_ticks/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_timer/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_uart/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_vreg/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_watchdog/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_xip_cache/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/hardware_xosc/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_aon_timer/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_async_context/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_atomic/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_bootrom/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_btstack/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_clib_interface/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_cyw43_arch/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_cyw43_driver/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_double/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_fix/rp2040_usb_device_enumeration/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_flash/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_float/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_i2c_slave/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_int64_ops/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_lwip/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_malloc/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_mbedtls/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_mem_ops/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_multicore/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_platform_common/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_platform_compiler/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_platform_panic/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_platform_sections/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_printf/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_rand/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_runtime/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_runtime_init/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_sha256/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_status_led/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_stdio/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_stdio_rtt/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_stdio_semihosting/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_stdio_uart/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_stdio_usb/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_time_adapter/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/pico_unique_id/include"));
    mod.addIncludePath(pico_sdk.path("src/rp2_common/tinyusb/include"));
    switch (chip) {
        .RP2040 => {
            mod.addCMacro("PICO_RP2040", "1");
            mod.addIncludePath(pico_sdk.path("src/rp2040/boot_stage2/include"));
            mod.addIncludePath(pico_sdk.path("src/rp2040/hardware_regs/include"));
            mod.addIncludePath(pico_sdk.path("src/rp2040/hardware_structs/include"));
            mod.addIncludePath(pico_sdk.path("src/rp2040/pico_platform/include"));
        },
        .RP2350 => {
            mod.addCMacro("PICO_RP2350", "1");
            // By default RP2350 is using software spinlocks because of some errata
            // don't know what it is exactly but we will force hardware spinlocks anyway
            // to simplify compilation of this module
            mod.addCMacro("PICO_USE_SW_SPIN_LOCKS", "0");
            mod.addIncludePath(pico_sdk.path("src/rp2350/boot_stage2/include"));
            mod.addIncludePath(pico_sdk.path("src/rp2350/hardware_regs/include"));
            mod.addIncludePath(pico_sdk.path("src/rp2350/hardware_structs/include"));
            mod.addIncludePath(pico_sdk.path("src/rp2350/pico_platform/include"));
        },
    }
}
