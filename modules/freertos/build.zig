const std = @import("std");
const Translator = @import("translate_c").Translator;

const FreeRTOS_Port = enum {
    RP2040,
    RP2350_ARM,
    RP2350_RISCV,
};

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

    const cfg_idle_hook = b.option(bool, "idle_hook", "Enable FreeRTOS idle hook") orelse false;
    const cfg_tick_hook = b.option(bool, "tick_hook", "Enable FreeRTOS tick hook") orelse false;

    if (port_name != .RP2040 and port_name != .RP2350_ARM) {
        @panic("Right now only RP2040 and RP2350_ARM ports are supported");
    }

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

        freertos_lib.addIncludePath(freertos_kernel_dep.path("./portable/ThirdParty/GCC/RP2040/include/"));
    } else if (port_name == .RP2350_ARM) {
        freertos_lib.addCSourceFiles(.{
            .root = freertos_kernel_community_dep.path("./GCC/RP2350_ARM_NTZ/non_secure/"),
            .files = &[_][]const u8{ "port.c", "portasm.c" },
            .flags = &flags,
        });

        freertos_lib.addIncludePath(freertos_kernel_community_dep.path("./GCC/RP2350_ARM_NTZ/non_secure/"));
    }

    // Pico SDK glue code: partial re-implementations of SDK functions that
    // the FreeRTOS port references but MicroZig does not provide.
    freertos_lib.addCSourceFiles(.{
        .root = b.path("."),
        .files = &[_][]const u8{ "src/picosdk_irq.c", "src/picosdk_exception.c", "src/picosdk_stubs.c" },
        .flags = &flags,
    });

    // Pico SDK include paths
    const picosdk_dep = b.dependency("picosdk", .{});
    switch (port_name) {
        .RP2040 => addPicoSDKIncludeDirs(b, freertos_lib, picosdk_dep, .RP2040),
        .RP2350_ARM, .RP2350_RISCV => addPicoSDKIncludeDirs(b, freertos_lib, picosdk_dep, .RP2350),
    }

    // TODO: USE addConfigHeader instead?
    freertos_lib.addCMacro("configSMP_SPINLOCK_0", "PICO_SPINLOCK_ID_OS1");
    freertos_lib.addCMacro("configSMP_SPINLOCK_1", "PICO_SPINLOCK_ID_OS2");

    // Even if we use just one core we must define this so RP2350 port will compile.
    // It looks like lack of #ifdef LIB_PICO_MULTICORE in RP2350 ARM FreeRTOS port
    // in place where multicore_doorbell_claim_unused is called
    freertos_lib.addCMacro("LIB_PICO_MULTICORE", "1");

    // Had problems when this was enabled.
    // Microzig but also Pico SDK? dont set VTOR to 0x10000100 for RP2040 at boot even when ram_vector_table is set to false
    freertos_lib.addCMacro("PICO_NO_RAM_VECTOR_TABLE", "0");
    freertos_lib.addCMacro("PICO_SDK_VERSION_MAJOR", "2");

    const t: Translator = .init(translate_c, .{
        .c_source_file = b.path("include/freertos.h"),
        .target = target,
        .optimize = optimize,
    });
    t.addConfigHeader(config_header);
    t.addIncludePath(freertos_kernel_dep.path("include"));

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

const Chip = enum {
    RP2040,
    RP2350,
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
    _ = wf.add("picosdk_generated/pico/pico_config_platform_headers.h", "");

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
