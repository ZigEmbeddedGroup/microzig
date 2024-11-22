//! A PIO instance can load a single `Bytecode`, it has to be loaded into memory
const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const PIO = microzig.chip.types.peripherals.PIO0;
const PIO0 = microzig.chip.peripherals.PIO0;
const PIO1 = microzig.chip.peripherals.PIO1;

const gpio = @import("gpio.zig");
const resets = @import("resets.zig");
const hw = @import("hw.zig");
pub const assembler = @import("pio/assembler.zig");
const encoder = @import("pio/assembler/encoder.zig");

// global state for keeping track of used things
var used_instruction_space: [2]u32 = [_]u32{ 0, 0 };
var claimed_state_machines: [2]u4 = [_]u4{ 0, 0 };

pub const Instruction = encoder.Instruction;
pub const Program = assembler.Program;
pub const assemble = assembler.assemble;

pub const Fifo = enum {
    tx,
    rx,
};

pub const StateMachine = enum(u2) {
    sm0,
    sm1,
    sm2,
    sm3,

    pub const Regs = extern struct {
        clkdiv: @TypeOf(PIO0.SM0_CLKDIV),
        execctrl: @TypeOf(PIO0.SM0_EXECCTRL),
        shiftctrl: @TypeOf(PIO0.SM0_SHIFTCTRL),
        addr: @TypeOf(PIO0.SM0_ADDR),
        instr: @TypeOf(PIO0.SM0_INSTR),
        pinctrl: @TypeOf(PIO0.SM0_PINCTRL),
    };

    comptime {
        assert(@sizeOf([2]Regs) == (4 * 6 * 2));
    }
};

pub const Irq = enum {
    irq0,
    irq1,

    pub const Regs = extern struct {
        enable: @TypeOf(PIO0.IRQ0_INTE),
        force: @TypeOf(PIO0.IRQ0_INTF),
        status: @TypeOf(PIO0.IRQ0_INTS),
    };

    comptime {
        assert(@sizeOf([2]Regs) == (3 * 4 * 2));
    }

    pub const Source = enum {
        rx_not_empty,
        tx_not_full,
        // TODO: determine what this does, is it just a combination of the
        // first two, or is it other things?
        statemachine,
    };
};

pub const ClkDivOptions = struct {
    int: u16 = 1,
    frac: u8 = 0,

    pub fn from_float(div: f32) ClkDivOptions {
        const fixed = @as(u24, @intFromFloat(div * 256));
        return ClkDivOptions{
            .int = @as(u16, @truncate(fixed >> 8)),
            .frac = @as(u8, @truncate(fixed)),
        };
    }
};

pub const ExecOptions = struct {
    jmp_pin: u5 = 0,
    wrap: u5 = 31,
    wrap_target: u5 = 0,
    side_pindir: bool = false,
    side_set_optional: bool = false,
};

pub const ShiftOptions = struct {
    autopush: bool = false,
    autopull: bool = false,
    in_shiftdir: Direction = .right,
    out_shiftdir: Direction = .right,
    /// 0 means full 32-bits
    push_threshold: u5 = 0,
    /// 0 means full 32-bits
    pull_threshold: u5 = 0,
    join_tx: bool = false,
    join_rx: bool = false,

    pub const Direction = enum(u1) {
        left,
        right,
    };
};

pub fn PinMapping(comptime Count: type) type {
    return struct {
        base: u5 = 0,
        count: Count = 0,
    };
}

pub const PinMappingOptions = struct {
    out: PinMapping(u6) = .{},
    set: PinMapping(u3) = .{ .count = 5 },
    side_set: PinMapping(u3) = .{},
    in_base: u5 = 0,
};

pub const StateMachineInitOptions = struct {
    clkdiv: ClkDivOptions = .{},
    pin_mappings: PinMappingOptions = .{},
    exec: ExecOptions = .{},
    shift: ShiftOptions = .{},
};

pub const LoadAndStartProgramOptions = struct {
    clkdiv: ClkDivOptions,
    shift: ShiftOptions = .{},
    pin_mappings: PinMappingOptions = .{},
    exec: ExecOptions = .{},
};

pub const Pio = enum(u1) {
    pio0 = 0,
    pio1 = 1,

    pub fn reset(self: Pio) void {
        switch (self) {
            .pio0 => resets.reset(&.{.pio0}),
            .pio1 => resets.reset(&.{.pio1}),
        }
    }

    fn get_regs(self: Pio) *volatile PIO {
        return switch (self) {
            .pio0 => PIO0,
            .pio1 => PIO1,
        };
    }

    pub fn get_instruction_memory(self: Pio) *volatile [32]u32 {
        const regs = self.get_regs();
        return @as(*volatile [32]u32, @ptrCast(&regs.INSTR_MEM0));
    }

    pub fn gpio_init(self: Pio, pin: gpio.Pin) void {
        pin.set_function(switch (self) {
            .pio0 => .pio0,
            .pio1 => .pio1,
        });
    }

    fn can_add_program_at_offset(self: Pio, program: Program, offset: u5) bool {
        if (program.origin) |origin|
            if (origin != offset)
                return false;

        const used_mask = used_instruction_space[@intFromEnum(self)];
        const program_mask = program.get_mask();

        // We can add the program if the masks don't overlap, if there is
        // overlap the result of a bitwise AND will have a non-zero result
        return (used_mask & program_mask) == 0;
    }

    fn find_offset_for_program(self: Pio, program: Program) !u5 {
        return if (program.origin) |origin|
            if (self.can_add_program_at_offset(program, origin))
                origin
            else
                error.NoSpace
        else for (0..(32 - program.instructions.len)) |i| {
            const offset = @as(u5, @intCast(i));
            if (self.can_add_program_at_offset(program, offset))
                break offset;
        } else error.NoSpace;
    }

    fn add_program_at_offset_unlocked(self: Pio, program: Program, offset: u5) !void {
        if (!self.can_add_program_at_offset(program, offset))
            return error.NoSpace;

        const instruction_memory = self.get_instruction_memory();
        for (program.instructions, offset..) |insn, i|
            instruction_memory[i] = insn;

        const program_mask = program.get_mask();
        used_instruction_space[@intFromEnum(self)] |= program_mask << offset;
    }

    /// Public functions will need to lock independently, so only exposing this function for now
    pub fn add_program(self: Pio, program: Program) !u5 {
        //const lock = hw.Lock.claim();
        //defer lock.unlock();

        const offset = try self.find_offset_for_program(program);
        try self.add_program_at_offset_unlocked(program, offset);
        return offset;
    }

    pub fn claim_unused_state_machine(self: Pio) !StateMachine {
        // TODO: const lock = hw.Lock.claim()
        // defer lock.unlock();

        const claimed_mask = claimed_state_machines[@intFromEnum(self)];
        return for (0..4) |i| {
            const sm_mask = (@as(u4, 1) << @as(u2, @intCast(i)));
            if (0 == (claimed_mask & sm_mask)) {
                claimed_state_machines[@intFromEnum(self)] |= sm_mask;
                break @as(StateMachine, @enumFromInt(i));
            }
        } else error.NoSpace;
    }

    pub fn get_sm_regs(self: Pio, sm: StateMachine) *volatile StateMachine.Regs {
        const pio_regs = self.get_regs();
        const sm_regs = @as(*volatile [4]StateMachine.Regs, @ptrCast(&pio_regs.SM0_CLKDIV));
        return &sm_regs[@intFromEnum(sm)];
    }

    fn get_irq_regs(self: Pio, irq: Irq) *volatile Irq.Regs {
        const pio_regs = self.get_regs();
        const irq_regs = @as(*volatile [2]Irq.Regs, @ptrCast(&pio_regs.IRQ0_INTE));
        return &irq_regs[@intFromEnum(irq)];
    }

    pub fn sm_set_clkdiv(self: Pio, sm: StateMachine, options: ClkDivOptions) void {
        if (options.int == 0 and options.frac != 0)
            @panic("invalid params");

        const sm_regs = self.get_sm_regs(sm);
        sm_regs.clkdiv.write(.{
            .INT = options.int,
            .FRAC = options.frac,

            .reserved8 = 0,
        });
    }

    pub fn sm_set_exec_options(self: Pio, sm: StateMachine, options: ExecOptions) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.execctrl.modify(.{
            // NOTE: EXEC_STALLED is RO
            .WRAP_BOTTOM = options.wrap_target,
            .WRAP_TOP = options.wrap,
            .SIDE_PINDIR = @intFromBool(options.side_pindir),
            .SIDE_EN = @intFromBool(options.side_set_optional),
            .JMP_PIN = options.jmp_pin,

            // TODO: plug in rest of the options
            // STATUS_N
            // STATUS_SEL
            // OUT_STICKY
            // INLINE_OUT_EN
            // OUT_EN_SEL
            // EXEC_STALLED
        });
    }

    pub fn sm_set_shift_options(self: Pio, sm: StateMachine, options: ShiftOptions) void {
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

    pub fn sm_set_pin_mappings(self: Pio, sm: StateMachine, options: PinMappingOptions) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.pinctrl.modify(.{
            .OUT_BASE = options.out.base,
            .OUT_COUNT = options.out.count,

            .SET_BASE = options.set.base,
            .SET_COUNT = options.set.count,

            .SIDESET_BASE = options.side_set.base,
            .SIDESET_COUNT = options.side_set.count,

            .IN_BASE = options.in_base,
        });
    }

    pub fn sm_set_pindir(self: Pio, sm: StateMachine, base: u5, count: u5, dir: gpio.Direction) void {
        const sm_regs = self.get_sm_regs(sm);
        const reg_pinctrl__copy = sm_regs.pinctrl;
        const reg_execctrl__copy = sm_regs.execctrl;

        for (base..base + count) |pin__number| {
            const pin_config: PinMappingOptions = .{
                .out = .{
                    .base = 0,
                    .count = 0,
                },
                .set = .{
                    .base = @intCast(pin__number),
                    .count = 1,
                },
                .side_set = .{
                    .base = 0,
                    .count = 0,
                },
                .in_base = 0,
            };
            sm_regs.pinctrl.modify(.{
                .OUT_BASE = pin_config.out.base,
                .OUT_COUNT = pin_config.out.count,

                .SET_BASE = pin_config.set.base,
                .SET_COUNT = pin_config.set.count,

                .SIDESET_BASE = pin_config.side_set.base,
                .SIDESET_COUNT = pin_config.side_set.count,

                .IN_BASE = pin_config.in_base,
            });
            self.sm_exec(sm, .{
                .payload = .{
                    .set = .{
                        .data = @intFromEnum(dir),
                        .destination = .pindirs,
                    },
                },
                .delay_side_set = 0,
                .tag = .set,
            });
        }
        sm_regs.pinctrl = reg_pinctrl__copy;
        sm_regs.execctrl = reg_execctrl__copy;
    }

    pub fn sm_set_pin(self: Pio, sm: StateMachine, base: u5, count: u5, value: u1) void {
        const sm_regs = self.get_sm_regs(sm);
        const reg_pinctrl__copy = sm_regs.pinctrl;
        const reg_execctrl__copy = sm_regs.execctrl;

        for (base..base + count) |pin__number| {
            const pin_config: PinMappingOptions = .{
                .out = .{
                    .base = 0,
                    .count = 0,
                },
                .set = .{
                    .base = @intCast(pin__number),
                    .count = 1,
                },
                .side_set = .{
                    .base = 0,
                    .count = 0,
                },
                .in_base = 0,
            };
            sm_regs.pinctrl.modify(.{
                .OUT_BASE = pin_config.out.base,
                .OUT_COUNT = pin_config.out.count,

                .SET_BASE = pin_config.set.base,
                .SET_COUNT = pin_config.set.count,

                .SIDESET_BASE = pin_config.side_set.base,
                .SIDESET_COUNT = pin_config.side_set.count,

                .IN_BASE = pin_config.in_base,
            });
            self.sm_exec(sm, .{
                .payload = .{
                    .set = .{
                        .data = value,
                        .destination = .pins,
                    },
                },
                .delay_side_set = 0,
                .tag = .set,
            });
        }
        sm_regs.pinctrl = reg_pinctrl__copy;
        sm_regs.execctrl = reg_execctrl__copy;
    }

    pub fn sm_get_rx_fifo(self: Pio, sm: StateMachine) *volatile u32 {
        const regs = self.get_regs();
        const fifos = @as(*volatile [4]u32, @ptrCast(&regs.RXF0));
        return &fifos[@intFromEnum(sm)];
    }

    pub fn sm_is_rx_fifo_empty(self: Pio, sm: StateMachine) bool {
        const regs = self.get_regs();
        const rxempty = regs.FSTAT.read().RXEMPTY;
        return (rxempty & (@as(u4, 1) << @intFromEnum(sm))) != 0;
    }

    pub fn sm_blocking_read(self: Pio, sm: StateMachine) u32 {
        while (self.sm_is_rx_fifo_empty(sm)) {}
        return self.sm_read(sm);
    }

    pub fn sm_read(self: Pio, sm: StateMachine) u32 {
        const fifo_ptr = self.sm_get_rx_fifo(sm);
        return fifo_ptr.*;
    }

    pub fn sm_is_tx_fifo_full(self: Pio, sm: StateMachine) bool {
        const regs = self.get_regs();
        const txfull = regs.FSTAT.read().TXFULL;
        return (txfull & (@as(u4, 1) << @intFromEnum(sm))) != 0;
    }

    pub fn sm_get_tx_fifo(self: Pio, sm: StateMachine) *volatile u32 {
        const regs = self.get_regs();
        const fifos = @as(*volatile [4]u32, @ptrCast(&regs.TXF0));
        return &fifos[@intFromEnum(sm)];
    }

    /// this function writes to the TX FIFO without checking that it's
    /// writable, if it's not then the value is ignored
    pub fn sm_write(self: Pio, sm: StateMachine, value: u32) void {
        const fifo_ptr = self.sm_get_tx_fifo(sm);
        fifo_ptr.* = value;
    }

    pub fn sm_blocking_write(self: Pio, sm: StateMachine, value: u32) void {
        while (self.sm_is_tx_fifo_full(sm)) {}

        self.sm_write(sm, value);
    }

    pub fn sm_set_enabled(self: Pio, sm: StateMachine, enabled: bool) void {
        const regs = self.get_regs();

        var value = regs.CTRL.read();
        if (enabled)
            value.SM_ENABLE |= @as(u4, 1) << @intFromEnum(sm)
        else
            value.SM_ENABLE &= ~(@as(u4, 1) << @intFromEnum(sm));

        regs.CTRL.write(value);
    }

    fn sm_clear_debug(self: Pio, sm: StateMachine) void {
        const regs = self.get_regs();
        const mask: u4 = (@as(u4, 1) << @intFromEnum(sm));

        // write 1 to clear this register
        regs.FDEBUG.modify(.{
            .RXSTALL = mask,
            .RXUNDER = mask,
            .TXOVER = mask,
            .TXSTALL = mask,
        });
    }

    /// changing the state of fifos will clear them
    pub fn sm_clear_fifos(self: Pio, sm: StateMachine) void {
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

    pub fn sm_fifo_level(self: Pio, sm: StateMachine, fifo: Fifo) u4 {
        const num = @intFromEnum(sm);
        const offset: u5 = switch (fifo) {
            .tx => 0,
            .rx => 4,
        };

        const regs = self.get_regs();
        const levels = regs.FLEVEL.raw;

        return @as(u4, @truncate(levels >> (@as(u5, 4) * num) + offset));
    }

    fn interrupt_bit_pos(
        sm: StateMachine,
        source: Irq.Source,
    ) u5 {
        return (@as(u5, 4) * @intFromEnum(source)) + @intFromEnum(sm);
    }

    pub fn sm_clear_interrupt(
        self: Pio,
        sm: StateMachine,
        irq: Irq,
        source: Irq.Source,
    ) void {
        // TODO: why does the raw interrupt register no have irq1/0?
        _ = irq;
        const regs = self.get_regs();
        regs.IRQ.raw |= @as(u32, 1) << interrupt_bit_pos(sm, source);
    }

    // TODO: be able to disable an interrupt
    pub fn sm_enable_interrupt(
        self: Pio,
        sm: StateMachine,
        irq: Irq,
        source: Irq.Source,
    ) void {
        const irq_regs = self.get_irq_regs(irq);
        irq_regs.enable.raw |= @as(u32, 1) << interrupt_bit_pos(sm, source);
    }

    pub fn sm_restart(self: Pio, sm: StateMachine) void {
        const mask: u4 = (@as(u4, 1) << @intFromEnum(sm));
        const regs = self.get_regs();
        regs.CTRL.modify(.{
            .SM_RESTART = mask,
        });
    }

    pub fn sm_clkdiv_restart(self: Pio, sm: StateMachine) void {
        const mask: u4 = (@as(u4, 1) << @intFromEnum(sm));
        const regs = self.get_regs();
        regs.CTRL.modify(.{
            .CLKDIV_RESTART = mask,
        });
    }

    pub fn sm_init(
        self: Pio,
        sm: StateMachine,
        initial_pc: u5,
        options: StateMachineInitOptions,
    ) void {
        // Halt the machine, set some sensible defaults
        self.sm_set_enabled(sm, false);
        self.sm_set_clkdiv(sm, options.clkdiv);
        self.sm_set_exec_options(sm, options.exec);
        self.sm_set_shift_options(sm, options.shift);
        self.sm_set_pin_mappings(sm, options.pin_mappings);

        self.sm_clear_fifos(sm);
        self.sm_clear_debug(sm);

        // Finally, clear some internal SM state
        self.sm_restart(sm);
        self.sm_clkdiv_restart(sm);
        self.sm_exec(sm, Instruction{
            .tag = .jmp,

            .delay_side_set = 0,
            .payload = .{
                .jmp = .{
                    .address = initial_pc,
                    .condition = .always,
                },
            },
        });
    }

    pub fn sm_exec(self: Pio, sm: StateMachine, instruction: Instruction) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.instr.raw = @as(u16, @bitCast(instruction));
    }

    pub fn sm_load_and_start_program(
        self: Pio,
        sm: StateMachine,
        program: Program,
        options: LoadAndStartProgramOptions,
    ) !void {
        const expected_side_set_pins = if (program.side_set) |side_set|
            if (side_set.optional)
                side_set.count + 1
            else
                side_set.count
        else
            0;

        assert(expected_side_set_pins == options.pin_mappings.side_set.count);

        // TODO: check program settings vs pin mapping
        const offset = try self.add_program(program);
        self.sm_init(sm, offset, .{
            .clkdiv = options.clkdiv,
            .shift = options.shift,
            .pin_mappings = options.pin_mappings,
            .exec = .{
                .wrap = if (program.wrap) |wrap|
                    wrap
                else
                    offset + @as(u5, @intCast(program.instructions.len)),

                .wrap_target = if (program.wrap_target) |wrap_target|
                    wrap_target
                else
                    offset,

                .side_pindir = if (program.side_set) |side_set|
                    side_set.pindir
                else
                    false,

                .side_set_optional = if (program.side_set) |side_set|
                    side_set.optional
                else
                    false,

                .jmp_pin = options.exec.jmp_pin,
            },
        });
    }
};

test "pio" {
    std.testing.refAllDecls(assembler);
}
