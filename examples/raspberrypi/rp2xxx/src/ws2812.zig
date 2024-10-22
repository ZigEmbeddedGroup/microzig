const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const Pio = rp2xxx.pio.Pio;
const StateMachine = rp2xxx.pio.StateMachine;

const ws2812_program = blk: {
    @setEvalBranchQuota(5000);
    break :blk rp2xxx.pio.assemble(
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
const led_pin = gpio.num(23);

pub fn main() void {
    pio.gpio_init(led_pin);
    sm_set_consecutive_pindirs(pio, sm, @intFromEnum(led_pin), 1, true);

    const cycles_per_bit: comptime_int = ws2812_program.defines[0].value + //T1
        ws2812_program.defines[1].value + //T2
        ws2812_program.defines[2].value; //T3
    const div = @as(f32, @floatFromInt(rp2xxx.clock_config.sys.?.frequency())) /
        (800_000 * cycles_per_bit);

    pio.sm_load_and_start_program(sm, ws2812_program, .{
        .clkdiv = rp2xxx.pio.ClkDivOptions.from_float(div),
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

    while (true) {
        pio.sm_blocking_write(sm, 0x00ff00 << 8); //red
        rp2xxx.time.sleep_ms(1000);
        pio.sm_blocking_write(sm, 0xff0000 << 8); //green
        rp2xxx.time.sleep_ms(1000);
        pio.sm_blocking_write(sm, 0x0000ff << 8); //blue
        rp2xxx.time.sleep_ms(1000);
    }
}

fn sm_set_consecutive_pindirs(_pio: Pio, _sm: StateMachine, pin: u5, count: u3, is_out: bool) void {
    const sm_regs = _pio.get_sm_regs(_sm);
    const pinctrl_saved = sm_regs.pinctrl.raw;
    sm_regs.pinctrl.modify(.{
        .SET_BASE = pin,
        .SET_COUNT = count,
    });
    _pio.sm_exec(_sm, rp2xxx.pio.Instruction{
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
