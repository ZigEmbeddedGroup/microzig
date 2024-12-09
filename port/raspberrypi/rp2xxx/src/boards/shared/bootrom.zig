const std = @import("std");
const microzig = @import("microzig");
const arch = microzig.hal.compatibility.arch;
const chip = microzig.hal.compatibility.chip;

comptime {
    _ = BootromData.bootloader_data;
}

const BootromData =
    switch (chip) {
    .RP2040 => struct {
        fn prepare_boot_sector(comptime stage2_rom: []const u8) [256]u8 {
            @setEvalBranchQuota(10_000);

            var bootrom: [256]u8 = .{0xFF} ** 256;
            @memcpy(bootrom[0..stage2_rom.len], stage2_rom);

            // 2.8.1.3.1. Checksum
            // The last four bytes of the image loaded from flash (which we hope is a valid flash second stage) are a CRC32 checksum
            // of the first 252 bytes. The parameters of the checksum are:
            // • Polynomial: 0x04c11db7
            // • Input reflection: no
            // • Output reflection: no
            // • Initial value: 0xffffffff
            // • Final XOR: 0x00000000
            // • Checksum value appears as little-endian integer at end of image
            // The Bootrom makes 128 attempts of approximately 4ms each for a total of approximately 0.5 seconds before giving up
            // and dropping into USB code to load and checksum the second stage with varying SPI parameters. If it sees a checksum
            // pass it will immediately jump into the 252-byte payload which contains the flash second stage.
            const Hash = std.hash.crc.Crc(u32, .{
                .polynomial = 0x04c11db7,
                .initial = 0xffffffff,
                .reflect_input = false,
                .reflect_output = false,
                .xor_output = 0x00000000,
            });

            std.mem.writeInt(u32, bootrom[252..256], Hash.hash(bootrom[0..252]), .little);

            return bootrom;
        }

        export const bootloader_data: [256]u8 linksection(".boot2") = prepare_boot_sector(@embedFile("bootloader"));
    },
    .RP2350 => switch (arch) {
        .arm => struct {
            /// Taken directly from section 5.9.5.1 of the RP2350 datasheet
            ///
            /// Translates to an IMAGE_DEF block that lets the bootrom know there is an executable flash image at address 0 in flash.
            /// TODO: This isn't very sophisticated and a lot more functionality surrounding metadata and how the ROM bootloader treats
            ///       it can be implemented for the RP2350.
            export const bootloader_data: [5]u32 linksection(".bootmeta") = [5]u32{
                0xffffded3,
                0x10210142,
                0x000001ff,
                0x00000000,
                0xab123579,
            };
        },
        .riscv => struct {
            pub const Entry = extern union {
                V: u32,
                F: *const fn () callconv(.Naked) void,
            };

            export const bootloader_data: [8]Entry linksection(".bootmeta") = [8]Entry{
                .{ .V = 0xffffded3 },
                .{ .V = 0x11210142 },
                .{ .V = 0x00000344 },
                .{ .F = trampoline },
                .{ .V = microzig.config.end_of_stack },
                .{ .V = 0x000004ff },
                .{ .V = 0x00000000 },
                .{ .V = 0xab123579 },
            };

            export fn trap() callconv(.C) void {
                const pin_config = microzig.hal.pins.GlobalConfiguration{
                    .GPIO0 = .{
                        .name = "led",
                        .direction = .out,
                    },
                };
                const pins = pin_config.apply();
                pins.led.toggle();

                while (true) {
                    asm volatile ("wfi");
                }
            }

            export fn trampoline() callconv(.Naked) void {
                asm volatile (
                    \\.option push
                    \\.option norelax
                    \\la gp, __global_pointer$
                    \\.option pop
                    \\
                    \\mv sp, %[eos]
                    \\
                    \\la a0, trap
                    \\csrw mtvec, a0
                    \\
                    // if core 1 gets here (through a miracle), send it back to bootrom
                    \\csrr a0, mhartid
                    \\bnez a0, reenter_bootrom
                    \\
                    \\call _start
                    \\
                    \\reenter_bootrom:
                    \\li a0, 0x7dfc
                    \\jr a0
                    :
                    : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
                );
            }
        },
    },
};
