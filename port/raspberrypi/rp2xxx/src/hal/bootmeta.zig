/// Documentation taken from section 5.9.5.1 of the rp2350 datasheet.
const std = @import("std");
const microzig = @import("microzig");
const arch = @import("compatibility.zig").arch;

pub const image_def_block = if (microzig.config.ram_image and arch == .arm) Block(extern struct {
    image_def: ImageDef,
    entry_point: EntryPoint(false),
}){
    .items = .{
        .image_def = .{
            .image_type_flags = .{
                .image_type = .exe,
                .exe_security = microzig.options.hal.bootmeta.image_def_exe_security,
                .cpu = .arm,
                .chip = .RP2350,
                .try_before_you_buy = false,
            },
        },
        // We must specify a custom entry point since by default RP2350 expects
        // the vector table at the start of the image.
        .entry_point = .{
            .entry = &microzig.cpu.startup_logic.ram_image_entry_point,
            .sp = microzig.cpu.startup_logic._vector_table.initial_stack_pointer,
        },
    },
    .link = microzig.options.hal.bootmeta.next_block,
} else Block(extern struct {
    image_def: ImageDef,
}){
    .items = .{
        .image_def = .{
            .image_type_flags = .{
                .image_type = .exe,
                .exe_security = microzig.options.hal.bootmeta.image_def_exe_security,
                .cpu = std.meta.stringToEnum(ImageDef.ImageTypeFlags.Cpu, @tagName(arch)).?,
                .chip = .RP2350,
                .try_before_you_buy = false,
            },
        },
    },
    .link = microzig.options.hal.bootmeta.next_block,
};

comptime {
    @export(&image_def_block, .{
        .name = "_image_def_block",
        .section = ".bootmeta",
        .linkage = .strong,
    });
}

pub fn Block(Items: type) type {
    return extern struct {
        header: u32 = 0xffffded3,
        items: Items,
        last_item: u32 = 0x000000ff | ((@sizeOf(Items) / 4) << 8),
        link: ?*const anyopaque = null,
        footer: u32 = 0xab123579,
    };
}

pub const ImageDef = packed struct {
    item_type: u8 = 0x42,
    block_size: u8 = 0x01,
    image_type_flags: ImageTypeFlags,

    pub const ImageTypeFlags = packed struct {
        image_type: ImageType,
        exe_security: ExeSecurity,
        reserved0: u2 = 0,
        cpu: Cpu,
        reserved1: u1 = 0,
        chip: Chip,
        try_before_you_buy: bool,

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
    };
};

pub fn EntryPoint(with_stack_limit: bool) type {
    if (with_stack_limit) {
        return extern struct {
            header: packed struct {
                item_type: u8 = 0x44,
                block_size: u8 = 0x04,
                padding: u16 = 0,
            } = .{},
            entry: *const anyopaque,
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
            entry: *const anyopaque,
            sp: u32,
        };
    }
}
