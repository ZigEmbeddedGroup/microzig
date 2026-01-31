const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .esp = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const examples: []const Example = &.{
        .{ .name = "blinky", .file = "src/blinky.zig" },
        .{ .name = "custom_clock_config", .file = "src/custom_clock_config.zig" },
        .{ .name = "gpio_input", .file = "src/gpio_input.zig" },
        .{ .name = "i2c_bus_scan", .file = "src/i2c_bus_scan.zig" },
        .{ .name = "i2c_temp", .file = "src/i2c_temp.zig" },
        .{ .name = "i2c_display_sh1106", .file = "src/i2c_display_sh1106.zig" },
        .{ .name = "ledc_pwm_servo", .file = "src/ledc_pwm_servo.zig" },
        .{ .name = "stepper_driver", .file = "src/stepper_driver.zig" },
        .{ .name = "stepper_driver_dumb", .file = "src/stepper_driver_dumb.zig" },
        .{ .name = "systimer", .file = "src/systimer.zig" },
        .{ .name = "ws2812_blinky", .file = "src/ws2812_blinky.zig" },
        .{ .name = "rtos", .file = "src/rtos.zig" },
        .{ .name = "tcp_server", .file = "src/tcp_server.zig", .features = .{
            .flashless = false,
            .lwip = true,
        } },
    };

    for (examples) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        for (std.enums.values(TargetEnum)) |target_enum| {
            if (!example.features.flashless and std.mem.containsAtLeast(u8, @tagName(target_enum), 1, "flashless"))
                continue;

            const target_desc = target_enum.get_target_desc(mb);

            // `add_firmware` basically works like addExecutable, but takes a
            // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
            //
            // The target will convey all necessary information on the chip,
            // cpu and potentially the board as well.
            const firmware = mb.add_firmware(.{
                .name = b.fmt("{s}_{s}", .{ target_desc.prefix, example.name }),
                .target = target_desc.target,
                .optimize = optimize,
                .root_source_file = b.path(example.file),
            });

            if (example.features.lwip) {
                const target = b.resolveTargetQuery(firmware.target.zig_target);

                const foundation_dep = b.dependency("foundation_libc", .{
                    .target = target,
                    .optimize = optimize,
                    .single_threaded = true,
                });

                const lwip_dep = b.dependency("lwip", .{
                    .target = target,
                    .optimize = optimize,
                    .include_dir = b.path("src/lwip/include"),
                });

                const libc_lib = foundation_dep.artifact("foundation");
                const lwip_lib = lwip_dep.artifact("lwip");

                lwip_lib.root_module.linkLibrary(libc_lib);
                firmware.app_mod.linkLibrary(lwip_lib);
            }

            // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
            // and allows installing the firmware as a typical firmware file.
            //
            // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
            mb.install_firmware(firmware, .{});

            // For debugging, we also always install the firmware as an ELF file
            mb.install_firmware(firmware, .{ .format = .elf });
        }
    }
}

const TargetEnum = enum {
    esp32_c3,
    esp32_c3_direct_boot,
    esp32_c3_flashless,

    fn get_target_desc(target_enum: TargetEnum, mb: *MicroBuild) TargetDescription {
        return switch (target_enum) {
            .esp32_c3 => .{
                .prefix = "esp32_c3",
                .target = mb.ports.esp.chips.esp32_c3,
            },
            .esp32_c3_direct_boot => .{
                .prefix = "esp32_c3_direct_boot",
                .target = mb.ports.esp.chips.esp32_c3_direct_boot,
            },
            .esp32_c3_flashless => .{
                .prefix = "esp32_c3_flashless",
                .target = mb.ports.esp.chips.esp32_c3_flashless,
            },
        };
    }
};

const TargetDescription = struct {
    prefix: []const u8,
    target: *const microzig.Target,
};

const Example = struct {
    const Features = packed struct {
        flashless: bool = true,
        lwip: bool = false,
    };

    name: []const u8,
    file: []const u8,
    features: Features = .{},
};

const lwip_flags = [_][]const u8{ "-std=c99", "-fno-sanitize=undefined" };
const lwip_files = [_][]const u8{
    // Core files
    "core/init.c",
    "core/def.c",
    "core/dns.c",
    "core/inet_chksum.c",
    "core/ip.c",
    "core/mem.c",
    "core/memp.c",
    "core/netif.c",
    "core/pbuf.c",
    "core/raw.c",
    "core/stats.c",
    "core/sys.c",
    "core/altcp.c",
    "core/altcp_alloc.c",
    "core/altcp_tcp.c",
    "core/tcp.c",
    "core/tcp_in.c",
    "core/tcp_out.c",
    "core/timeouts.c",
    "core/udp.c",

    // IPv4 implementation:
    "core/ipv4/acd.c",
    "core/ipv4/autoip.c",
    "core/ipv4/dhcp.c",
    "core/ipv4/etharp.c",
    "core/ipv4/icmp.c",
    "core/ipv4/igmp.c",
    "core/ipv4/ip4_frag.c",
    "core/ipv4/ip4.c",
    "core/ipv4/ip4_addr.c",

    // IPv6 implementation:
    "core/ipv6/dhcp6.c",
    "core/ipv6/ethip6.c",
    "core/ipv6/icmp6.c",
    "core/ipv6/inet6.c",
    "core/ipv6/ip6.c",
    "core/ipv6/ip6_addr.c",
    "core/ipv6/ip6_frag.c",
    "core/ipv6/mld6.c",
    "core/ipv6/nd6.c",

    // Interfaces
    "netif/ethernet.c",

    // Interfaces:
    // "netif/bridgeif.c",
    // "netif/ethernet.c",
    // "netif/slipif.c",
    // "netif/bridgeif_fdb.c",

    // sequential APIs
    // "api/err.c",
    // "api/api_msg.c",
    // "api/netifapi.c",
    // "api/sockets.c",
    // "api/netbuf.c",
    // "api/api_lib.c",
    // "api/tcpip.c",
    // "api/netdb.c",
    // "api/if_api.c",

    // 6LoWPAN
    // "netif/lowpan6.c",
    // "netif/lowpan6_ble.c",
    // "netif/lowpan6_common.c",
    // "netif/zepif.c",

    // PPP
    // "netif/ppp/polarssl/arc4.c",
    // "netif/ppp/polarssl/des.c",
    // "netif/ppp/polarssl/md4.c",
    // "netif/ppp/polarssl/sha1.c",
    // "netif/ppp/polarssl/md5.c",
    // "netif/ppp/ipcp.c",
    // "netif/ppp/magic.c",
    // "netif/ppp/pppoe.c",
    // "netif/ppp/mppe.c",
    // "netif/ppp/multilink.c",
    // "netif/ppp/chap-new.c",
    // "netif/ppp/auth.c",
    // "netif/ppp/chap_ms.c",
    // "netif/ppp/ipv6cp.c",
    // "netif/ppp/chap-md5.c",
    // "netif/ppp/upap.c",
    // "netif/ppp/pppapi.c",
    // "netif/ppp/pppos.c",
    // "netif/ppp/eap.c",
    // "netif/ppp/pppol2tp.c",
    // "netif/ppp/demand.c",
    // "netif/ppp/fsm.c",
    // "netif/ppp/eui64.c",
    // "netif/ppp/ccp.c",
    // "netif/ppp/pppcrypt.c",
    // "netif/ppp/utils.c",
    // "netif/ppp/vj.c",
    // "netif/ppp/lcp.c",
    // "netif/ppp/ppp.c",
    // "netif/ppp/ecp.c",
};
