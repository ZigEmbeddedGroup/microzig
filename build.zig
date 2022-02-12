//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using 

const std = @import("std");
const microzig = @import("src/main.zig");

const boards = microzig.boards;
const chips = microzig.chips;
const Backing = microzig.Backing;

pub fn build(b: *std.build.Builder) !void {
    const mode = b.standardReleaseOptions();

    const test_step = b.step("test", "Builds and runs the library test suite");

    const BuildConfig = struct { name: []const u8, backing: Backing, supports_uart: bool = true };
    const all_backings = [_]BuildConfig{
        //BuildConfig{ .name = "boards.arduino_nano", .backing = Backing{ .board = boards.arduino_nano } },
        BuildConfig{ .name = "boards.mbed_lpc1768", .backing = Backing{ .board = boards.mbed_lpc1768 } },
        //BuildConfig{ .name = "chips.atmega328p", .backing = Backing{ .chip = pkgs.chips.atmega328p } },
        BuildConfig{ .name = "chips.lpc1768", .backing = Backing{ .chip = chips.lpc1768 } },
        //BuildConfig{ .name = "chips.stm32f103x8", .backing = Backing{ .chip = chips.stm32f103x8 } },
        BuildConfig{ .name = "boards.stm32f3discovery", .backing = Backing{ .board = boards.stm32f3discovery }, .supports_uart = false },
    };

    const Test = struct { name: []const u8, source: []const u8, uses_uart: bool = false };
    const all_tests = [_]Test{
        Test{ .name = "minimal", .source = "tests/minimal.zig" },
        Test{ .name = "blinky", .source = "tests/blinky.zig" },
        Test{ .name = "uart-sync", .source = "tests/uart-sync.zig", .uses_uart = true },
    };

    const filter = b.option(std.Target.Cpu.Arch, "filter-target", "Filters for a certain cpu target");

    inline for (all_backings) |cfg| {
        inline for (all_tests) |tst| {
            if (tst.uses_uart and !cfg.supports_uart) continue;

            const exe = try microzig.addEmbeddedExecutable(
                b,
                "test-" ++ tst.name ++ "-" ++ cfg.name ++ ".elf",
                tst.source,
                cfg.backing,
            );

            if (filter == null or exe.target.cpu_arch.? == filter.?) {
                exe.setBuildMode(mode);
                exe.install();

                test_step.dependOn(&exe.step);

                const bin = b.addInstallRaw(
                    exe,
                    "test-" ++ tst.name ++ "-" ++ cfg.name ++ ".bin",
                    .{},
                );
                b.getInstallStep().dependOn(&bin.step);
            }
        }
    }
}
