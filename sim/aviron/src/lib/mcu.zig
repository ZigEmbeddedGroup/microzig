const std = @import("std");
const io_mod = @import("io.zig");
const Cpu = @import("Cpu.zig");

/// MCU configuration defines the memory layout and special register addresses
/// for a specific AVR microcontroller.
pub const Config = struct {
    /// Human-readable name of the MCU
    name: []const u8,

    /// Flash memory size in bytes (must be 2-aligned)
    flash_size: usize,

    /// SRAM size in bytes
    sram_size: usize,

    /// SRAM base address in data space
    sram_base: u24,

    /// EEPROM size in bytes
    eeprom_size: usize,

    /// Code model (determines PC width)
    code_model: Cpu.CodeModel,

    /// Instruction set variant
    instruction_set: Cpu.InstructionSet,

    /// Special I/O register addresses
    special_io: SpecialIoConfig,

    /// Memory mapper configuration
    mapper_config: MapperConfig,
};

pub const SpecialIoConfig = struct {
    /// RAMP registers for extended addressing (if present)
    ramp_x: ?io_mod.IO.Address = null,
    ramp_y: ?io_mod.IO.Address = null,
    ramp_z: ?io_mod.IO.Address = null,
    ramp_d: ?io_mod.IO.Address = null,

    /// Extended indirect register (if present)
    e_ind: ?io_mod.IO.Address = null,

    /// Stack pointer registers
    sp_l: io_mod.IO.Address,
    sp_h: io_mod.IO.Address,

    /// Status register
    sreg: io_mod.IO.Address,
};

/// Configuration for the memory mapper
pub const MapperConfig = struct {
    /// Function to translate data-space address to IO address
    /// Returns null if the address is not mapped to IO
    io_translate: *const fn (data_addr: u24) ?io_mod.IO.Address,

    /// Base address where SRAM is mapped in data space
    sram_base: u24,
};

/// Classic AVR memory layout: IO mapped at 0x0020-0x005F in data space, SRAM at 0x0100+
pub fn ClassicMapperConfig(comptime sram_base: u24) type {
    return struct {
        pub fn io_translate(data_addr: u24) ?io_mod.IO.Address {
            // Classic AVR: IO registers at 0x0020-0x005F map to IO addresses 0x00-0x3F
            return if (data_addr >= 0x20 and data_addr <= 0x5F)
                @intCast(data_addr - 0x20)
            else
                null;
        }

        pub const config = MapperConfig{
            .io_translate = io_translate,
            .sram_base = sram_base,
        };
    };
}

/// Extended IO mapping for devices with more IO registers
pub fn ExtendedMapperConfig(comptime sram_base: u24) type {
    return struct {
        pub fn io_translate(data_addr: u24) ?io_mod.IO.Address {
            // Extended IO: 0x0020-0x00FF map to IO addresses 0x00-0xDF
            return if (data_addr >= 0x20 and data_addr <= 0xFF)
                @intCast(data_addr - 0x20)
            else
                null;
        }

        pub const config = MapperConfig{
            .io_translate = io_translate,
            .sram_base = sram_base,
        };
    };
}

// ============================================================================
// Predefined MCU Configurations
// ============================================================================

/// ATmega328P configuration (Arduino Uno)
pub const atmega328p = Config{
    .name = "ATmega328P",
    .flash_size = 32768,
    .sram_size = 2048,
    .sram_base = 0x0100,
    .eeprom_size = 1024,
    .code_model = .code16,
    .instruction_set = .avr5,
    .special_io = .{
        .ramp_x = null,
        .ramp_y = null,
        .ramp_z = null,
        .ramp_d = null,
        .e_ind = null,
        .sp_l = 0x3D,
        .sp_h = 0x3E,
        .sreg = 0x3F,
    },
    .mapper_config = .{
        .io_translate = ClassicMapperConfig(0x0100).config.io_translate,
        .sram_base = 0x0100,
    },
};

/// ATtiny816 configuration (modern tinyAVR)
pub const attiny816 = Config{
    .name = "ATtiny816",
    .flash_size = 8192,
    .sram_size = 512,
    .sram_base = 0x3F00, // High memory for tinyAVR 0/1/2 series
    .eeprom_size = 128,
    .code_model = .code16,
    .instruction_set = .avr5, // Actually uses AVRe/AVRe+ but avr5 is close enough
    .special_io = .{
        .ramp_x = null,
        .ramp_y = null,
        .ramp_z = null,
        .ramp_d = null,
        .e_ind = null,
        .sp_l = 0x3D,
        .sp_h = 0x3E,
        .sreg = 0x3F,
    },
    .mapper_config = .{
        .io_translate = ClassicMapperConfig(0x3F00).config.io_translate,
        .sram_base = 0x3F00,
    },
};

/// ATmega2560 configuration (Arduino Mega)
pub const atmega2560 = Config{
    .name = "ATmega2560",
    .flash_size = 262144,
    .sram_size = 8192,
    .sram_base = 0x0200,
    .eeprom_size = 4096,
    .code_model = .code22,
    .instruction_set = .avr6,
    .special_io = .{
        .ramp_x = null,
        .ramp_y = null,
        .ramp_z = 0x3B, // RAMPZ for extended addressing
        .ramp_d = 0x38, // RAMPD
        .e_ind = 0x3C, // EIND
        .sp_l = 0x3D,
        .sp_h = 0x3E,
        .sreg = 0x3F,
    },
    .mapper_config = .{
        .io_translate = ExtendedMapperConfig(0x0200).config.io_translate,
        .sram_base = 0x0200,
    },
};

/// Lookup MCU configuration by name
pub fn getConfig(name: []const u8) ?Config {
    const configs = .{
        atmega328p,
        attiny816,
        atmega2560,
    };

    inline for (configs) |config| {
        if (std.mem.eql(u8, config.name, name)) {
            return config;
        }
    }

    return null;
}
