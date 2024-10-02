const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const Pio = rp2040.pio.Pio;
const StateMachine = rp2040.pio.StateMachine;

const ws2812_program = blk: {
    @setEvalBranchQuota(5000);
    break :blk rp2040.pio.assemble(
        \\;
        \\; Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
        \\;
        \\; SPDX-License-Identifier: BSD-3-Clause
        \\;
        \\.program ws2812
        \\.side_set 1
        \\
        \\.define public T1 2
        \\.define public T2 5
        \\.define public T3 3
        \\
        \\.wrap_target
        \\bitloop:
        \\    out x, 1       side 0 [T3 - 1] ; Side-set still takes place when instruction stalls
        \\    jmp !x do_zero side 1 [T1 - 1] ; Branch on the bit we shifted out. Positive pulse
        \\do_one:
        \\    jmp  bitloop   side 1 [T2 - 1] ; Continue driving high, for a long pulse
        \\do_zero:
        \\    nop            side 0 [T2 - 1] ; Or drive low, for a short pulse
        \\.wrap
    , .{}).get_program_by_name("ws2812");
};

const pio: Pio = .pio0;
const sm: StateMachine = .sm0;
const led_pin = gpio.num(16);

const brightness: [256]u8 = blk: {
    @setEvalBranchQuota(10_000);

    const gamma = 2.2;

    const max_brightness = 0x10;

    var data: [256]u8 = undefined;
    for (&data, 0..) |*bit, i| {
        const raw_index: f32 = @floatFromInt(i);

        const gamma_brightness = std.math.pow(f32, raw_index / 255.0, gamma);

        bit.* = @intFromFloat(max_brightness * gamma_brightness);
    }
    // @compileLog(data);
    break :blk data;
};

const RGB = extern struct {
    x: u8 = 0x00,
    b: u8,
    g: u8,
    r: u8,
};

inline fn floatToBright(f: f32) u8 {
    return brightness[
        @intFromFloat(
            std.math.clamp(255.0 * f, 0.0, 255.0),
        )
    ];
}

pub fn main() void {
    pio.gpio_init(led_pin);
    sm_set_consecutive_pindirs(pio, sm, @intFromEnum(led_pin), 1, true);

    const cycles_per_bit: comptime_int = ws2812_program.defines[0].value + //T1
        ws2812_program.defines[1].value + //T2
        ws2812_program.defines[2].value; //T3
    const div = @as(f32, @floatFromInt(rp2040.clock_config.sys.?.frequency())) /
        (800_000 * cycles_per_bit);

    pio.sm_load_and_start_program(sm, ws2812_program, .{
        .clkdiv = rp2040.pio.ClkDivOptions.from_float(div),
        .pin_mappings = .{
            .side_set = .{
                .base = @intFromEnum(led_pin),
                .count = 1,
            },
        },
        .shift = .{
            .out_shiftdir = .left,
            .autopull = true,
            .pull_threshold = 24,
            .join_tx = true,
        },
    }) catch unreachable;
    pio.sm_set_enabled(sm, true);

    var rng_src = std.Random.DefaultPrng.init(0x1234);

    const rng = rng_src.random();

    var screen: [5][5]RGB = undefined;
    for (&screen) |*row| {
        for (row) |*pix| {
            pix.* = RGB{
                .r = brightness[rng.int(u8)],
                .g = brightness[rng.int(u8)],
                .b = brightness[rng.int(u8)],
            };
        }
    }

    while (true) {
        screen[rng.intRangeLessThan(u8, 0, 5)][rng.intRangeLessThan(u8, 0, 5)] = RGB{
            .r = brightness[rng.int(u8)],
            .g = brightness[rng.int(u8)],
            .b = brightness[rng.int(u8)],
        };

        for (@as([25]RGB, @bitCast(screen))) |color| {
            pio.sm_blocking_write(sm, @bitCast(color));
        }
        rp2040.time.sleep_ms(50);
    }
}

fn sm_set_consecutive_pindirs(_pio: Pio, _sm: StateMachine, pin: u5, count: u3, is_out: bool) void {
    const sm_regs = _pio.get_sm_regs(_sm);
    const pinctrl_saved = sm_regs.pinctrl.raw;
    sm_regs.pinctrl.modify(.{
        .SET_BASE = pin,
        .SET_COUNT = count,
    });
    _pio.sm_exec(_sm, rp2040.pio.Instruction{
        .tag = .set,
        .delay_side_set = 0,
        .payload = .{
            .set = .{
                .data = @intFromBool(is_out),
                .destination = .pindirs,
            },
        },
    });
    sm_regs.pinctrl.raw = pinctrl_saved;
}
