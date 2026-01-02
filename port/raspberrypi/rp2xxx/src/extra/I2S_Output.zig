pub const I2S_Output = @This();

pio: Pio,
sm: StateMachine,

sample_rate: u32,
sample_size: u6,

const program = blk: {
    @setEvalBranchQuota(20_000);
    break :blk pio_.assemble(
        \\.program i2s_output
        \\.side_set 2
        \\
        \\.wrap_target
        \\;                              0bWB W - Word Clock B - Bit clock
        \\    mov x, y              side 0b01
        \\left_channel:
        \\    out pins, 1           side 0b00
        \\    jmp x-- left_channel  side 0b01
        \\    out pins 1            side 0b10
        \\    mov x, y              side 0b11
        \\right_channel:
        \\    out pins 1            side 0b10
        \\    jmp x-- right_channel side 0b11
        \\    out pins 1            side 0b00
        \\.wrap
    , .{}).get_program_by_name("i2s_output");
};

pub const InitConfig = struct {
    clock_config: clocks.config.Global,
    pio: Pio,
    sm: StateMachine,

    data_pin: Pin,
    mclk_pin: Pin,
    lrclk_pin: Pin,

    sample_rate: u32 = 44100,
    sample_size: u6 = 32,
};

pub fn init(config: InitConfig) !I2S_Output {
    if (@intFromEnum(config.lrclk_pin) + 1 != @intFromEnum(config.mclk_pin)) return error.MclkNotAfterLrclk;

    const sample_rate_multiplier: u32 = switch (config.sample_size) {
        // 8, TODO: borked for some reasons
        16 => 1,
        // 24 => // TODO
        32 => 2,
        else => return error.InvalidSampleSize,
    };

    const system_frequency = config.clock_config.sys.?.frequency();
    const divider = system_frequency * 4 / (config.sample_rate * sample_rate_multiplier);

    try config.pio.sm_load_and_start_program(config.sm, program, .{
        .clkdiv = .{ .int = @intCast(divider >> 8), .frac = @intCast(divider & 0xff) },
        .pin_mappings = .{
            .out = .single(config.data_pin),
            .side_set = .{ .low = config.lrclk_pin, .high = config.mclk_pin },
        },
        .shift = .{
            .out_shiftdir = .left,
            .autopull = true,
            .pull_threshold = if (config.sample_size == 32) 0 else @truncate(config.sample_size),
            .join_tx = true,
        },
    });

    // there are 2 instructions outside the loop
    config.pio.sm_exec_set_y(config.sm, config.sample_size - 2);

    try config.pio.sm_set_pindir(config.sm, config.lrclk_pin, 2, .out);
    try config.pio.sm_set_pindir(config.sm, config.data_pin, 1, .out);
    config.pio.sm_set_enabled(config.sm, true);

    return I2S_Output{
        .pio = config.pio,
        .sm = config.sm,
        .sample_rate = config.sample_rate,
        .sample_size = config.sample_size,
    };
}

pub fn dma_data_size(self: I2S_Output) DataSize {
    return switch (self.sample_size) {
        8 => .size_8,
        16 => .size_16,
        32 => .size_32,
        else => unreachable,
    };
}

pub inline fn write_sample(self: I2S_Output, sample: anytype) void {
    switch (@TypeOf(sample)) {
        i8, i16, i32 => {},
        else => comptime unreachable,
    }
    std.debug.assert(@bitSizeOf(@TypeOf(sample)) == self.sample_size);

    const tx_fifo: *volatile @TypeOf(sample) = @ptrCast(self.pio.sm_get_tx_fifo(self.sm));
    tx_fifo.* = sample;
}

const std = @import("std");
const clocks = @import("../hal/clocks.zig");
const dma = @import("../hal/dma.zig");
const DataSize = dma.DataSize;
const gpio = @import("../hal/gpio.zig");
const Pin = gpio.Pin;
const pio_ = @import("../hal/pio.zig");
const Pio = pio_.Pio;
const StateMachine = pio_.StateMachine;
