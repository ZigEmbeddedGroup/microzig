//! Hello world for the PIO module: generating a square wave
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const Pio = rp2xxx.pio.Pio;
const StateMachine = rp2xxx.pio.StateMachine;

const squarewave_program = blk: {
    @setEvalBranchQuota(3000);
    break :blk rp2xxx.pio.assemble(
        \\;
        \\; Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
        \\;
        \\; SPDX-License-Identifier: BSD-3-Clause
        \\;
        \\.program squarewave
        \\    set pindirs, 1   ; Set pin to output
        \\again:
        \\    set pins, 1 [1]  ; Drive pin high and then delay for one cycle
        \\    set pins, 0      ; Drive pin low
        \\    jmp again        ; Set PC to label `again`
    , .{}).get_program_by_name("squarewave");
};

// Pick one PIO instance arbitrarily. We're also arbitrarily picking state
// machine 0 on this PIO instance (the state machines are numbered 0 to 3
// inclusive).
const pio: Pio = rp2xxx.pio.num(0);
const sm: StateMachine = .sm0;
const pin = gpio.num(2);

pub fn main() void {
    pio.gpio_init(pin);
    pio.sm_load_and_start_program(sm, squarewave_program, .{
        .clkdiv = rp2xxx.pio.ClkDivOptions.from_float(125),
        .pin_mappings = .{
            .set = .{
                .base = 2,
                .count = 1,
            },
        },
    }) catch unreachable;

    pio.sm_set_enabled(sm, true);

    while (true) {}
}
