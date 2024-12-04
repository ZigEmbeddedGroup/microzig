const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");

const common = @import("common.zig");

const gpio = @import("../gpio.zig");
const resets = @import("../resets.zig");
const hw = @import("../hw.zig");

pub const Pio = enum(u1) {
    pio0 = 0,
    pio1 = 1,

    pub fn reset(self: Pio) void {
        switch (self) {
            .pio0 => resets.reset(&.{.pio0}),
            .pio1 => resets.reset(&.{.pio1}),
        }
    }

    pub fn get_regs(self: Pio) *volatile common.PIO {
        return switch (self) {
            .pio0 => common.PIO0,
            .pio1 => common.PIO1,
        };
    }

    pub const get_instruction_memory = common.PioImpl(Pio).get_instruction_memory;

    pub fn gpio_init(self: Pio, pin: gpio.Pin) void {
        pin.set_function(switch (self) {
            .pio0 => .pio0,
            .pio1 => .pio1,
        });
    }

    pub const can_add_program_at_offset = common.PioImpl(Pio).can_add_program_at_offset;
    pub const find_offset_for_program = common.PioImpl(Pio).find_offset_for_program;
    pub const add_program_at_offset_unlocked = common.PioImpl(Pio).add_program_at_offset_unlocked;
    pub const add_program = common.PioImpl(Pio).add_program;
    pub const claim_unused_state_machine = common.PioImpl(Pio).claim_unused_state_machine;
    pub const get_sm_regs = common.PioImpl(Pio).get_sm_regs;
    pub const get_irq_regs = common.PioImpl(Pio).get_irq_regs;
    pub const sm_set_clkdiv = common.PioImpl(Pio).sm_set_clkdiv;
    pub const sm_set_exec_options = common.PioImpl(Pio).sm_set_exec_options;

    pub fn sm_set_shift_options(self: Pio, sm: common.StateMachine, options: common.ShiftOptions) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.shiftctrl.write(.{
            .AUTOPUSH = @intFromBool(options.autopush),
            .AUTOPULL = @intFromBool(options.autopull),

            .IN_SHIFTDIR = @intFromEnum(options.in_shiftdir),
            .OUT_SHIFTDIR = @intFromEnum(options.out_shiftdir),

            .PUSH_THRESH = options.push_threshold,
            .PULL_THRESH = options.pull_threshold,

            .FJOIN_TX = @intFromBool(options.join_tx),
            .FJOIN_RX = @intFromBool(options.join_rx),
            .reserved16 = 0,
        });
    }

    pub const sm_set_pin_mappings = common.PioImpl(Pio).sm_set_pin_mappings;
    pub const sm_set_pindir = common.PioImpl(Pio).sm_set_pindir;
    pub const sm_set_pin = common.PioImpl(Pio).sm_set_pin;
    pub const sm_get_rx_fifo = common.PioImpl(Pio).sm_get_rx_fifo;
    pub const sm_is_rx_fifo_empty = common.PioImpl(Pio).sm_is_rx_fifo_empty;
    pub const sm_blocking_read = common.PioImpl(Pio).sm_blocking_read;
    pub const sm_read = common.PioImpl(Pio).sm_read;
    pub const sm_is_tx_fifo_full = common.PioImpl(Pio).sm_is_tx_fifo_full;
    pub const sm_get_tx_fifo = common.PioImpl(Pio).sm_get_tx_fifo;
    pub const sm_write = common.PioImpl(Pio).sm_write;
    pub const sm_blocking_write = common.PioImpl(Pio).sm_blocking_write;
    pub const sm_set_enabled = common.PioImpl(Pio).sm_set_enabled;
    pub const sm_clear_debug = common.PioImpl(Pio).sm_clear_debug;

    /// changing the state of fifos will clear them
    pub fn sm_clear_fifos(self: Pio, sm: common.StateMachine) void {
        const sm_regs = self.get_sm_regs(sm);
        const xor_shiftctrl = hw.xor_alias(&sm_regs.shiftctrl);
        const mask = .{
            .FJOIN_TX = 1,
            .FJOIN_RX = 1,

            .AUTOPUSH = 0,
            .AUTOPULL = 0,
            .IN_SHIFTDIR = 0,
            .OUT_SHIFTDIR = 0,
            .PUSH_THRESH = 0,
            .PULL_THRESH = 0,

            .reserved16 = 0,
        };

        xor_shiftctrl.write(mask);
        xor_shiftctrl.write(mask);
    }

    pub const sm_fifo_level = common.PioImpl(Pio).sm_fifo_level;
    const interrupt_bit_pos = common.PioImpl(Pio).interrupt_bit_pos;
    pub const sm_clear_interrupt = common.PioImpl(Pio).sm_clear_interrupt;
    pub const sm_enable_interrupt = common.PioImpl(Pio).sm_enable_interrupt;
    pub const sm_restart = common.PioImpl(Pio).sm_restart;
    pub const sm_clkdiv_restart = common.PioImpl(Pio).sm_clkdiv_restart;
    pub const sm_init = common.PioImpl(Pio).sm_init;
    pub const sm_exec = common.PioImpl(Pio).sm_exec;
    pub const sm_load_and_start_program = common.PioImpl(Pio).sm_load_and_start_program;
};
