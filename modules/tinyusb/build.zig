const std = @import("std");
const Build = std.Build;

// TODO: Switch to lazy dependencies?

pub fn build(b: *Build) !void {
    addTinyUSBLib(b);
}
const tusb_h_contents =
    \\#include_next "tusb.h"
    \\#define TU_ATTR_FAST_FUNC       __attribute__((section(".ram_text")))
;

pub fn addTinyUSBLib(b: *Build) void {
    const module = b.addModule("tinyusb", .{
        .link_libc = false,
        // seems important to release fast to avoid some extra dependencies
        .optimize = .ReleaseFast,
    });
    const wf_step = b.addWriteFile("tusb.h", tusb_h_contents);
    module.addIncludePath(wf_step.getDirectory());

    // TinyUSB src folder
    const tusb_dep = b.dependency("tusb", .{});
    const tusb_src = tusb_dep.path("src");
    module.addIncludePath(tusb_src);
    for (tinyusb_source_files) |file| {
        module.addCSourceFile(.{ .file = tusb_src.path(b, file) });
    }

    // Add libc for embedded
    const newlib_dep = b.dependency("newlib", .{});
    module.addIncludePath(newlib_dep.path("newlib/libc/include"));
}

const SupportedChips = enum {
    RP2040,
};

/// Add chip specific things to built library
// / TODO: Can this be a build option rather than a function call?
pub fn addChip(b: *Build, module: *Build.Module, chip_name: []const u8) void {
    const option = std.meta.stringToEnum(
        SupportedChips,
        chip_name,
    ) orelse {
        std.debug.print("BUILD ERROR: Chip not supported: {s}\n\r", .{chip_name});
        @panic("Chip not supported for TinyUSB yet");
    };
    switch (option) {
        .RP2040 => {
            module.addCMacro("CFG_TUSB_MCU", "OPT_MCU_RP2040");
            module.addCMacro("CFG_TUSB_OS", "OPT_OS_NONE");
            module.addCMacro("PICO_RP2040", "1");
            module.addCMacro("BOARD_TUD_RHPORT", "0");
            module.addCMacro("PICO_RP2040_USB_FAST_IRQ", "1");
            module.addCMacro("__not_in_flash(group)", "__attribute__((section(\".ram_text\")))");

            // add empty files for pico headers to be happy
            // TODO: empty seems to work but maybe we'd prefer to add something.
            // TODO: is the step order implicit when doing addIncludePath due to lazy directories
            const wf_step = b.addWriteFiles();
            _ = wf_step.add("pico/config_autogen.h", "");
            _ = wf_step.add("pico/version.h", "");
            module.addIncludePath(wf_step.getDirectory());
            // pico-sdk headers
            addPicoSdkInclude(b, module);
        },
    }
}

/// Enables debug logging in the generated tusb library
/// TODO: Can this be controlled through build options somehow rather than a function like this?
pub fn enableDebug(module: *Build.Module) void {
    // Add printf implementation
    const prntf_dep = module.owner.lazyDependency("printf", .{});
    if (prntf_dep) |dep| {
        module.addIncludePath(dep.path(""));
        module.addCSourceFile(.{ .file = dep.path("printf.c") });
        module.addCMacro("CFG_TUSB_DEBUG_PRINTF", "printf_");
        module.addCMacro("snprintf", "snprintf_");
        module.addCMacro("CFG_TUSB_DEBUG", "3");
    }
}

pub fn getTinyUsbCTranslate(
    b: *Build,
    target: Build.ResolvedTarget,
) *Build.Step.TranslateC {
    // const target = b.standardTargetOptions(.{});
    const tusb_dep = b.dependency("tusb", .{});
    const tusb_src = tusb_dep.path("src");
    const tinyusb_c = b.addTranslateC(.{
        .root_source_file = tusb_src.path(b, "tusb.h"),
        .target = target,
        .optimize = .ReleaseFast,
        .link_libc = false,
    });

    tinyusb_c.defineCMacro("CFG_TUSB_MCU", "OPT_MCU_NONE");
    tinyusb_c.defineCMacro("CFG_TUSB_OS", "OPT_OS_NONE");

    // TinyUSB src folder
    tinyusb_c.addIncludePath(tusb_src);

    // Add libc for embedded
    const newlib_dep = b.dependency("newlib", .{});
    tinyusb_c.addIncludePath(newlib_dep.path("newlib/libc/include"));

    return tinyusb_c;
}

/// List of all .c files in the tinyUSB src directory less the portable directory files
/// tinyusb does a good job only compiling based on options selected.
const tinyusb_source_files = [_][]const u8{
    "tusb.c",
    "device/usbd.c",
    "device/usbd_control.c",
    "class/msc/msc_host.c",
    "class/msc/msc_device.c",
    "class/cdc/cdc_host.c",
    "class/cdc/cdc_rndis_host.c",
    "class/cdc/cdc_device.c",
    "class/dfu/dfu_rt_device.c",
    "class/dfu/dfu_device.c",
    "class/video/video_device.c",
    "class/usbtmc/usbtmc_device.c",
    "class/vendor/vendor_host.c",
    "class/vendor/vendor_device.c",
    "class/net/ecm_rndis_device.c",
    "class/net/ncm_device.c",
    // "class/mtp/mtp_device.c", not available in older tinyusb compatible with sdk?
    "class/audio/audio_device.c",
    "class/bth/bth_device.c",
    "class/midi/midi_device.c",
    // "class/midi/midi_host.c", not available in older tinyusb compatible with sdk?
    "class/hid/hid_device.c",
    "class/hid/hid_host.c",
    "host/usbh.c",
    "host/hub.c",
    "common/tusb_fifo.c",
    "typec/usbc.c",
    "portable/raspberrypi/rp2040/rp2040_usb.c",
    "portable/raspberrypi/rp2040/dcd_rp2040.c",
};

fn addPicoSdkInclude(b: *std.Build, m: *std.Build.Module) void {
    const pico_sdk_dep = b.lazyDependency("pico_sdk", .{});
    if (pico_sdk_dep) |pico_dep| {
        for (rp_2040_includes) |dir| {
            m.addIncludePath(pico_dep.path(dir));
        }
    }
}

const rp_2040_includes = [_][]const u8{
    "src",
    "src/common/pico_base_headers/include",
    "src/common/pico_time/include",
    "src/rp2_common/pico_platform_compiler/include",
    "src/rp2_common/pico_platform_sections/include",
    "src/rp2_common/pico_platform_panic/include",
    "src/rp2_common/pico_platform_common/include",
    "src/rp2_common/hardware_timer/include",
    "src/rp2_common/hardware_base/include",
    "src/common/pico_sync/include",
    "src/rp2_common/hardware_sync/include",
    "src/rp2_common/hardware_sync_spin_lock/include",
    "src/rp2_common/hardware_irq/include",
    "src/rp2_common/hardware_resets/include",
    // I think these are the only things that would need to change for RP2350
    "src/rp2040/pico_platform/include",
    "src/rp2040/hardware_structs/include",
    "src/rp2040/hardware_regs/include",
    "src/rp2040/hardware_regs/include",
    "src/rp2040/hardware_structs/include",
};
