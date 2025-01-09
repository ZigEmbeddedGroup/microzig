//! A PIO instance can load a single `Bytecode`, it has to be loaded into memory
const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const chip = @import("compatibility.zig").chip;

// Re-export of platform rectified pio implementation
const common = @import("pio/common.zig");
const chip_specific = switch (chip) {
    .RP2040 => @import("pio/rp2040.zig"),
    .RP2350 => @import("pio/rp2350.zig"),
};
pub const StateMachine = common.StateMachine;
pub const Instruction = common.Instruction;
pub const PinMapping = common.PinMapping;
pub const PinMappingOptions = common.PinMappingOptions;
pub const StateMachineInitOptions = chip_specific.StateMachineInitOptions;
pub const LoadAndStartProgramOptions = chip_specific.LoadAndStartProgramOptions;
pub const ClkDivOptions = common.ClkDivOptions;
pub const ShiftOptions = chip_specific.ShiftOptions;

pub const assembler = @import("pio/assembler.zig");
const encoder = @import("pio/assembler/encoder.zig");

pub const Program = assembler.Program;
pub const assemble = assembler.assemble;

pub fn num(n: u2) Pio {
    switch (chip) {
        .RP2040 => {
            if (n > 1)
                @panic("the RP2040 only has PIO0 and PIO1");
        },
        .RP2350 => {
            if (n > 2)
                @panic("the RP2350 only has PIO0-2");
        },
    }

    return @as(Pio, @enumFromInt(n));
}

pub const Pio = chip_specific.Pio;

test "pio" {
    std.testing.refAllDecls(assembler);
}
