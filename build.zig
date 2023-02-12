//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");

pub const microzig = @import("src/main.zig");

// alias for packages
pub const addEmbeddedExecutable = microzig.addEmbeddedExecutable;
pub const boards = microzig.boards;
pub const chips = microzig.chips;
pub const Backing = microzig.Backing;

pub fn build(b: *std.build.Builder) !void {
    // Standard optimization options allow the person running `zig build -Doptimize=...` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const test_step = b.step("test", "Builds and runs the library test suite");

    const BuildConfig = struct { name: []const u8, backing: Backing, supports_uart_test: bool = true };
    const all_backings = [_]BuildConfig{
        //BuildConfig{ .name = "boards.arduino_nano", .backing = Backing{ .board = boards.arduino_nano } },
        //BuildConfig{ .name = "boards.arduino_uno", .backing = Backing{ .board = boards.arduino_uno } },
        BuildConfig{ .name = "boards.mbed_lpc1768", .backing = Backing{ .board = boards.mbed_lpc1768 } },
        //BuildConfig{ .name = "chips.atmega328p", .backing = Backing{ .chip = chips.atmega328p } },
        BuildConfig{ .name = "chips.lpc1768", .backing = Backing{ .chip = chips.lpc1768 } },
        //BuildConfig{ .name = "chips.stm32f103x8", .backing = Backing{ .chip = chips.stm32f103x8 } },
        BuildConfig{ .name = "boards.stm32f3discovery", .backing = Backing{ .board = boards.stm32f3discovery } },
        BuildConfig{ .name = "boards.stm32f4discovery", .backing = Backing{ .board = boards.stm32f4discovery } },
        BuildConfig{ .name = "boards.stm32f429idiscovery", .backing = Backing{ .board = boards.stm32f429idiscovery }, .supports_uart_test = false },
        BuildConfig{ .name = "chips.gd32vf103x8", .backing = Backing{ .chip = chips.gd32vf103x8 } },
        BuildConfig{ .name = "boards.longan_nano", .backing = Backing{ .board = boards.longan_nano } },
    };

    const Test = struct { name: []const u8, source: []const u8, uses_uart: bool = false, on_riscv32: bool = true, on_avr: bool = true };
    const all_tests = [_]Test{
        Test{ .name = "minimal", .source = "tests/minimal.zig" },
        Test{ .name = "blinky", .source = "tests/blinky.zig" },
        Test{ .name = "uart-sync", .source = "tests/uart-sync.zig", .uses_uart = true, .on_avr = false },

        // Note: this example uses the systick interrupt and therefore only for arm microcontrollers
        Test{ .name = "interrupt", .source = "tests/interrupt.zig", .on_riscv32 = false, .on_avr = true },
    };

    const filter = b.option(std.Target.Cpu.Arch, "filter-target", "Filters for a certain cpu target");

    for (all_backings) |cfg| {
        for (all_tests) |tst| {
            if (tst.uses_uart and !cfg.supports_uart_test) continue;
            if ((cfg.backing.getTarget().cpu_arch.?) == .avr and tst.on_avr == false) continue;
            if (!tst.on_riscv32) continue;

            var exe = microzig.addEmbeddedExecutable(
                b,
                b.fmt("test-{s}-{s}.elf", .{ tst.name, cfg.name }),
                tst.source,
                cfg.backing,
                .{ .optimize = optimize },
            );
            exe.addDriver(microzig.drivers.button);

            if (filter == null or exe.inner.target.cpu_arch.? == filter.?) {
                exe.inner.install();

                test_step.dependOn(&exe.inner.step);

                const bin = b.addInstallRaw(
                    exe.inner,
                    b.fmt("test-{s}-{s}.bin", .{ tst.name, cfg.name }),
                    .{},
                );
                b.getInstallStep().dependOn(&bin.step);
            }
        }
    }
}
