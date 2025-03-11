const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;

comptime {
    _ = BootromData.bootloader_data;
}

const BootromData = if (chip == .RP2040) struct {
    fn prepare_boot_sector(comptime stage2_rom: []const u8) [256]u8 {
        @setEvalBranchQuota(10_000);

        var bootrom: [256]u8 = @splat(0xFF);
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
} else {};
