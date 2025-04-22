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

    const PioImpl = common.PioImpl(Pio, .RP2040);
    pub fn get_regs(self: Pio) *volatile common.PIO {
        return switch (self) {
            .pio0 => common.PIO0,
            .pio1 => common.PIO1,
        };
    }

    pub const get_instruction_memory = PioImpl.get_instruction_memory;

    pub fn gpio_init(self: Pio, pin: gpio.Pin) void {
        pin.set_function(switch (self) {
            .pio0 => .pio0,
            .pio1 => .pio1,
        });
    }

    pub const can_add_program_at_offset = PioImpl.can_add_program_at_offset;
    pub const find_offset_for_program = PioImpl.find_offset_for_program;
    pub const add_program_at_offset_unlocked = PioImpl.add_program_at_offset_unlocked;
    pub const add_program = PioImpl.add_program;
    pub const claim_unused_state_machine = PioImpl.claim_unused_state_machine;
    pub const get_sm_regs = PioImpl.get_sm_regs;
    pub const get_irq_regs = PioImpl.get_irq_regs;
    pub const sm_set_clkdiv = PioImpl.sm_set_clkdiv;
    pub const sm_set_exec_options = PioImpl.sm_set_exec_options;

    pub fn sm_set_shift_options(self: Pio, sm: common.StateMachine, options: common.ShiftOptions(.RP2040)) void {
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
        });
    }

    pub const sm_set_pin_mappings = PioImpl.sm_set_pin_mappings;
    pub const sm_set_pindir = PioImpl.sm_set_pindir;
    pub const sm_set_pin = PioImpl.sm_set_pin;
    pub const sm_get_rx_fifo = PioImpl.sm_get_rx_fifo;
    pub const sm_is_rx_fifo_empty = PioImpl.sm_is_rx_fifo_empty;
    pub const sm_blocking_read = PioImpl.sm_blocking_read;
    pub const sm_read = PioImpl.sm_read;
    pub const sm_is_tx_fifo_full = PioImpl.sm_is_tx_fifo_full;
    pub const sm_get_tx_fifo = PioImpl.sm_get_tx_fifo;
    pub const sm_write = PioImpl.sm_write;
    pub const sm_blocking_write = PioImpl.sm_blocking_write;
    pub const sm_set_enabled = PioImpl.sm_set_enabled;
    pub const sm_clear_debug = PioImpl.sm_clear_debug;

    /// changing the state of fifos will clear them
    pub fn sm_clear_fifos(self: Pio, sm: common.StateMachine) void {
        const sm_regs = self.get_sm_regs(sm);
        const xor_shiftctrl = hw.xor_alias(&sm_regs.shiftctrl);
        const mask = @TypeOf(common.PIO0.SM0_SHIFTCTRL).underlying_type{
            .FJOIN_TX = 1,
            .FJOIN_RX = 1,

            .AUTOPUSH = 0,
            .AUTOPULL = 0,
            .IN_SHIFTDIR = 0,
            .OUT_SHIFTDIR = 0,
            .PUSH_THRESH = 0,
            .PULL_THRESH = 0,
        };

        xor_shiftctrl.write(mask);
        xor_shiftctrl.write(mask);
    }

    pub const sm_fifo_level = PioImpl.sm_fifo_level;
    pub const sm_clear_interrupt = PioImpl.sm_clear_interrupt;
    pub const sm_enable_interrupt = PioImpl.sm_enable_interrupt;
    pub const sm_restart = PioImpl.sm_restart;
    pub const sm_clkdiv_restart = PioImpl.sm_clkdiv_restart;
    pub const sm_init = PioImpl.sm_init;
    pub const sm_exec = PioImpl.sm_exec;
    pub const sm_load_and_start_program = PioImpl.sm_load_and_start_program;
};
