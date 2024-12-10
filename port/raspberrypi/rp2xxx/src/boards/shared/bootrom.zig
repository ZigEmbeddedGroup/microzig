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
    .RP2350 => blk: {
        // taken directly from section 5.9.5.1 of the rp2350 datasheet
        //
        // translates to an image_def block that lets the bootrom know there is an executable flash image at address 0 in flash.
        // todo: this isn't very sophisticated and a lot more functionality surrounding metadata and how the rom bootloader treats
        //       it can be implemented for the rp2350.

        break :blk switch (arch) {
            .arm => struct {
                export const bootloader_data linksection(".bootmeta") = Metadata.block(.{
                    Metadata.ImageDef{
                        .image_type_flags = .{
                            .image_type = .exe,
                            .exe_security = .secure,
                            .cpu = .arm,
                            .chip = .RP2350,
                            .try_before_you_buy = false,
                        },
                    },
                });
            },
            .riscv => struct {
                export const bootloader_data linksection(".bootmeta") = Metadata.block(.{
                    Metadata.ImageDef{
                        .image_type_flags = .{
                            .image_type = .exe,
                            .exe_security = .secure,
                            .cpu = .riscv,
                            .chip = .RP2350,
                            .try_before_you_buy = false,
                        },
                    },
                    Metadata.EntryPoint(false){
                        .entry = trampoline,
                        .sp = microzig.config.end_of_stack,
                    },
                });

                export fn trap() callconv(.C) void {
                    const pin_config = microzig.hal.pins.GlobalConfiguration{
                        .GPIO0 = .{
                            .name = "led",
                            .direction = .out,
                        },
                    };
                    const pins = pin_config.apply();
                    pins.led.toggle();

                    while (true) {}
                }

                export fn trampoline() linksection("microzig_flash_start") callconv(.Naked) noreturn {
                    asm volatile (
                        \\.option push
                        \\.option norelax
                        \\la gp, __global_pointer$
                        \\.option pop
                    );

                    asm volatile (
                        \\mv sp, %[eos]
                        :
                        : [eos] "r" (@as(u32, microzig.config.end_of_stack)),
                    );

                    asm volatile (
                        \\la a0, trap
                        \\csrw mtvec, a0
                        \\
                        \\csrr a0, mhartid // if core 1 gets here (through a miracle), send it back to bootrom
                        \\bnez a0, reenter_bootrom
                        \\
                        \\call _start
                        \\
                        \\reenter_bootrom:
                        \\li a0, 0x7dfc
                        \\jr a0
                    );
                }
            },
        };
    },
};

pub const Metadata = struct {
    fn Extern(Any: type) type {
        var fields: []const std.builtin.Type.StructField = &.{};
        for (@typeInfo(Any).Struct.fields) |item_field| {
            fields = fields ++ [_]std.builtin.Type.StructField{.{
                .name = item_field.name,
                .type = item_field.type,
                .default_value = null,
                .is_comptime = false,
                .alignment = 0,
            }};
        }

        return @Type(.{
            .Struct = .{
                .layout = .@"extern",
                .fields = fields,
                .decls = &.{},
                .is_tuple = false,
            },
        });
    }

    fn BlockType(Items: type) type {
        return extern struct {
            header: u32,
            user_items: Extern(Items),
            last_item: u32,
            link: u32,
            footer: u32,
        };
    }

    pub fn block(items: anytype) BlockType(@TypeOf(items)) {
        return .{
            .header = 0xffffded3,
            .user_items = items,
            .last_item = 0x000000ff | ((@sizeOf(Extern(@TypeOf(items))) / 4) << 8),
            .link = 0,
            .footer = 0xab123579,
        };
    }

    pub const ImageDef = packed struct {
        pub const ImageTypeFlags = packed struct {
            pub const ImageType = enum(u4) {
                invalid = 0,
                exe = 1,
                data = 2,
            };

            pub const ExeSecurity = enum(u2) {
                unspecified = 0,
                non_secure = 1,
                secure = 2,
            };

            pub const Cpu = enum(u3) {
                arm = 0,
                riscv = 1,
            };

            pub const Chip = enum(u3) {
                RP2040 = 0,
                RP2350 = 1,
            };

            image_type: ImageType,
            exe_security: ExeSecurity,
            reserved0: u2 = 0,
            cpu: Cpu,
            reserved1: u1 = 0,
            chip: Chip,
            try_before_you_buy: bool,
        };

        type: u8 = 0x42,
        block_size: u8 = 0x01,
        image_type_flags: ImageTypeFlags,
    };

    pub fn EntryPoint(with_stack_limit: bool) type {
        if (with_stack_limit) {
            return extern struct {
                header: packed struct {
                    item_type: u8 = 0x44,
                    block_size: u8 = 0x04,
                    padding: u16 = 0,
                } = .{},
                entry: *const fn () callconv(.Naked) noreturn,
                sp: u32,
                sp_limit: u32,
            };
        } else {
            return extern struct {
                header: packed struct {
                    item_type: u8 = 0x44,
                    block_size: u8 = 0x03,
                    padding: u16 = 0,
                } = .{},
                entry: *const fn () callconv(.Naked) noreturn,
                sp: u32,
            };
        }
    }
};
