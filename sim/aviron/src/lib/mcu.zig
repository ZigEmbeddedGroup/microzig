const std = @import("std");
const bus = @import("bus.zig");
const Cpu = @import("Cpu.zig");

/// MCU configuration defines the memory layout and special register addresses
/// for a specific AVR microcontroller.
pub const Config = struct {
    /// Human-readable name of the MCU
    name: []const u8,

    /// Flash memory size in bytes (must be 2-aligned)
    flash_size: bus.Flash.Address,

    /// SRAM size in bytes
    sram_size: u16,

    /// SRAM base address in data space
    sram_base: bus.DataBus.Address,

    /// EEPROM size in bytes
    eeprom_size: u16,

    /// Code model (determines PC width)
    code_model: Cpu.CodeModel,

    /// Instruction set variant
    instruction_set: Cpu.InstructionSet,

    /// Special I/O register addresses
    special_io: Cpu.SpecialIoRegisters,

    /// Start of IO window in data address space (inclusive).
    io_window_base: bus.DataBus.Address,
    /// End of IO window in data address space (inclusive).
    io_window_end: bus.DataBus.Address,
};

/// Convenience container for constructed memory spaces.
pub const Spaces = struct {
    data: bus.MemoryMapping(bus.DataBus),
    io: bus.MemoryMapping(bus.DataBus),

    pub fn deinit(self: *const Spaces, alloc: std.mem.Allocator) void {
        self.data.deinit(alloc);
        self.io.deinit(alloc);
    }
};

/// Build memory spaces (data, io) for the given MCU configuration.
pub fn build_spaces(
    alloc: std.mem.Allocator,
    cfg: Config,
    sram_dev: bus.DataBus,
    io_dev: bus.DataBus,
) !Spaces {
    const DataMapping = bus.MemoryMapping(bus.DataBus);

    // IO window size
    const io_size: bus.DataBus.Address = @intCast(cfg.io_window_end - cfg.io_window_base + 1);

    // Data space: IO window mapped into data space (at base), then SRAM at sram_base
    var data_seg_buf: [2]DataMapping.Segment = undefined;
    data_seg_buf[0] = .{ .at = cfg.io_window_base, .size = io_size, .backend = io_dev };
    data_seg_buf[1] = .{ .at = cfg.sram_base, .size = cfg.sram_size, .backend = sram_dev };
    const data_space = try DataMapping.init(alloc, data_seg_buf[0..]);

    // IO space: IO addresses starting at 0
    var io_seg_buf: [1]DataMapping.Segment = undefined;
    io_seg_buf[0] = .{ .at = 0, .size = io_size, .backend = io_dev };
    const io_space = try DataMapping.init(alloc, io_seg_buf[0..]);

    return .{
        .data = data_space,
        .io = io_space,
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
    .io_window_base = 0x20,
    .io_window_end = 0x5F,
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
    .io_window_base = 0x20,
    .io_window_end = 0x5F,
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
    .io_window_base = 0x20,
    .io_window_end = 0x00FF,
};

/// ATxmega128A4U configuration (XMEGA A-series)
pub const xmega128a4u = Config{
    .name = "ATxmega128A4U",
    .flash_size = 131072, // 128 KiB
    .sram_size = 8192, // 8 KiB
    .sram_base = 0x2000, // XMEGA SRAM typically starts at 0x2000
    .eeprom_size = 2048, // 2 KiB
    .code_model = .code22,
    .instruction_set = .avrxmega,
    .special_io = .{
        // XMEGA provides RAMP registers; EIND is present on parts with >128 KiB, but define for completeness.
        .ramp_x = 0x39,
        .ramp_y = 0x3A,
        .ramp_z = 0x3B,
        .ramp_d = 0x38,
        .e_ind = 0x3C,
        .sp_l = 0x3D,
        .sp_h = 0x3E,
        .sreg = 0x3F,
    },
    // XMEGA extended I/O space up to 0x0FFF (12-bit I/O addresses)
    .io_window_base = 0x20,
    .io_window_end = 0x0FFF,
};
