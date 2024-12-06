//! Hello world for the PIO module: generating a square wave
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const Pio = rp2xxx.pio.Pio;
const StateMachine = rp2xxx.pio.StateMachine;

const squarewave_program = blk: {
    @setEvalBranchQuota(2000);
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

pub fn main() void {
    pio.gpio_init(gpio.num(2));
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

    //// Load the assembled program directly into the PIO's instruction memory.
    //// Each PIO instance has a 32-slot instruction memory, which all 4 state
    //// machines can see. The system has write-only access.
    //for (squarewave_program.instructions, 0..) |insn, i|
    //    pio.get_instruction_memory()[i] = insn;

    //// Configure state machine 0 to run at sysclk/2.5. The state machines can
    //// run as fast as one instruction per clock cycle, but we can scale their
    //// speed down uniformly to meet some precise frequency target, e.g. for a
    //// UART baud rate. This register has 16 integer divisor bits and 8
    //// fractional divisor bits.
    //pio.sm_set_clkdiv(sm, .{
    //    .int = 2,
    //    .frac = 0x80,
    //});

    //// There are five pin mapping groups (out, in, set, side-set, jmp pin)
    //// which are used by different instructions or in different circumstances.
    //// Here we're just using SET instructions. Configure state machine 0 SETs
    //// to affect GPIO 0 only; then configure GPIO0 to be controlled by PIO0,
    //// as opposed to e.g. the processors.
    //pio.gpio_init(2);
    //pio.sm_set_pin_mappings(sm, .{
    //    .out = .{
    //        .base = 2,
    //        .count = 1,
    //    },
    //});

    //// Set the state machine running. The PIO CTRL register is global within a
    //// PIO instance, so you can start/stop multiple state machines
    //// simultaneously. We're using the register's hardware atomic set alias to
    //// make one bit high without doing a read-modify-write on the register.
    //pio.sm_set_enabled(sm, true);

    //while (true) {}
}
