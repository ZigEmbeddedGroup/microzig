const std = @import("std");

pub const Chip = enum {
    esp32_c3,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const chip = b.option(Chip, "chip", "chip") orelse @panic("No chip option specified");

    const esp_wifi_sys_dep = b.dependency("esp-wifi-sys", .{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("src/wifi_driver.c"),
        .target = target,
        .optimize = .ReleaseFast,
        .link_libc = false,
    });

    const mod = translate_c.addModule("wifi-driver-c");

    translate_c.addIncludePath(b.path("libc_dummy_include"));
    translate_c.addIncludePath(esp_wifi_sys_dep.path("esp-wifi-sys/include"));
    translate_c.addIncludePath(esp_wifi_sys_dep.path("esp-wifi-sys/headers"));

    switch (chip) {
        .esp32_c3 => {
            translate_c.addIncludePath(esp_wifi_sys_dep.path("esp-wifi-sys/headers/esp32c3"));

            mod.addLibraryPath(esp_wifi_sys_dep.path("esp-wifi-sys/libs/esp32c3"));
            inline for (&.{
                "btbb",
                "btdm_app",
                "coexist",
                "core",
                "espnow",
                "mesh",
                "net80211",
                "phy",
                "pp",
                "printf",
                "smartconfig",
                "wapi",
                "wpa_supplicant",
            }) |library| {
                mod.linkSystemLibrary(library, .{});
            }
        },
    }
}
