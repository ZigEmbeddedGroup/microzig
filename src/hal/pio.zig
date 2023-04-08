//! A PIO instance can load a single `Bytecode`, it has to be loaded into memory
const std = @import("std");

const microzig = @import("microzig");
const PIO = microzig.chip.types.peripherals.PIO0;
const PIO0 = microzig.chip.peripherals.PIO0;
const PIO1 = microzig.chip.peripherals.PIO1;

const gpio = @import("gpio.zig");
const assembler = @import("pio/assembler.zig");
pub const Bytecode = Bytecode;
pub const Program = assembler.Program;
pub const assemble = assembler.assemble;

var used_instruction_space: [2]u32 = [_]u32{ 0, 0 };
var claimed_state_machines: [2]u4 = [_]u4{ 0, 0 };

pub const Join = enum {
    none,
    rx,
    tx,
};

pub const Status = enum {
    rx_lessthan,
    tx_lessthan,
};

pub const Configuration = struct {
    pin: u32,
};

pub const StateMachine = enum(u2) {
    sm0,
    sm1,
    sm2,
    sm3,
};

pub const Pio = enum(u1) {
    pio0 = 0,
    pio1 = 1,

    fn get_regs(self: Pio) *volatile PIO {
        return switch (self) {
            .pio0 => PIO0,
            .pio1 => PIO1,
        };
    }

    pub fn get_instruction_memory(self: Pio) *volatile [32]u32 {
        const regs = self.get_regs();
        return @ptrCast(*volatile [32]u32, &regs.INSTR_MEM0);
    }

    pub fn gpio_init(self: Pio, comptime pin: u5) void {
        gpio.set_function(pin, switch (self) {
            .pio0 => .pio0,
            .pio1 => .pio1,
        });
    }

    pub fn load(self: Pio, bytecode: Bytecode) !void {
        _ = self;
        _ = bytecode;
    }

    fn can_add_program_at_offset(self: Pio, program: Program, offset: u5) bool {
        if (program.origin) |origin|
            if (origin != offset)
                return false;

        const used_mask = used_instruction_space[@enumToInt(self)];
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
        else for (0..32 - program.isntruction.len) |i| {
            if (self.can_add_program_at_offset(program, i))
                break i;
        } else error.NoSpace;
    }

    fn add_program_at_offset_unlocked(self: Pio, program: Program, offset: u5) !void {
        if (!self.can_add_program_at_offset(program, offset))
            return error.NoSpace;

        const instruction_memory = self.get_instruction_memory();
        for (program.instructions, offset..) |insn, i|
            instruction_memory[i] = insn;

        const program_mask = program.get_mask();
        used_instruction_space[@enumToInt(self)] |= program_mask << offset;
    }

    /// Public functions will need to lock independently, so only exposing this function for now
    pub fn add_program(self: Pio, program: Program) !void {
        // TODO: const lock = hw.Lock.claim()
        // defer lock.unlock();

        const offset = try self.find_offset_for_program_unlocked();
        try self.add_program_at_offset(program, offset);
    }

    pub fn claim_unused_state_machine(self: Pio) !StateMachine {
        // TODO: const lock = hw.Lock.claim()
        // defer lock.unlock();

        const claimed_mask = claimed_state_machines[@enumToInt(self)];
        return for (0..4) |i| {
            const sm_mask = (@as(u4, 1) << @intCast(u2, i));
            if (0 == (claimed_mask & sm_mask)) {
                claimed_state_machines[@enumToInt(self)] |= sm_mask;
                break @intToEnum(StateMachine, i);
            }
        } else error.NoSpace;
    }

    pub const StateMachineRegs = extern struct {
        clkdiv: @TypeOf(PIO0.SM0_CLKDIV),
        execctrl: @TypeOf(PIO0.SM0_EXECCTRL),
        shiftctrl: @TypeOf(PIO0.SM0_SHIFTCTRL),
        addr: @TypeOf(PIO0.SM0_ADDR),
        instr: @TypeOf(PIO0.SM0_INSTR),
        pinctrl: @TypeOf(PIO0.SM0_PINCTRL),
    };

    fn get_sm_regs(self: Pio, sm: StateMachine) *volatile StateMachineRegs {
        const pio_regs = self.get_regs();
        return switch (sm) {
            .sm0 => @ptrCast(*volatile StateMachineRegs, &pio_regs.SM0_CLKDIV),
            .sm1 => @ptrCast(*volatile StateMachineRegs, &pio_regs.SM1_CLKDIV),
            .sm2 => @ptrCast(*volatile StateMachineRegs, &pio_regs.SM2_CLKDIV),
            .sm3 => @ptrCast(*volatile StateMachineRegs, &pio_regs.SM3_CLKDIV),
        };
    }

    pub fn join_fifo(self: Pio, sm: StateMachine, join: Join) void {
        const tx: u1 = switch (join) {
            .tx => 1,
            .rx => 0,
            .none => 0,
        };
        const rx: u1 = switch (join) {
            .tx => 0,
            .rx => 1,
            .none => 0,
        };

        const sm_regs = self.get_sm_regs(sm);
        sm_regs.shiftctrl.modify(.{
            .FJOIN_TX = tx,
            .FJOIN_RX = rx,
        });
    }

    pub fn set_clkdiv_int_frac(self: Pio, sm: StateMachine, div_int: u16, div_frac: u8) void {
        if (div_int == 0 and div_frac != 0)
            @panic("invalid params");

        const sm_regs = self.get_sm_regs(sm);
        sm_regs.clkdiv.write(.{
            .INT = div_int,
            .FRAC = div_frac,

            .reserved8 = 0,
        });
    }

    pub fn set_out_shift(self: Pio, sm: StateMachine, args: struct {
        shift_right: bool,
        autopull: bool,
        pull_threshold: u5,
    }) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.shiftctrl.modify(.{
            .OUT_SHIFTDIR = @boolToInt(args.shift_right),
            .AUTOPULL = @boolToInt(args.autopull),
            .PULL_THRESH = args.pull_threshold,
        });
    }

    pub fn set_out_pins(self: Pio, sm: StateMachine, base: u5, count: u5) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.pinctrl.modify(.{
            .OUT_BASE = base,
            .OUT_COUNT = count,
        });
    }

    pub fn set_sideset_pins(self: Pio, sm: StateMachine, base: u5) void {
        const sm_regs = self.get_sm_regs(sm);
        sm_regs.pinctrl.modify(.{ .SIDESET_BASE = base });
    }

    pub fn is_tx_fifo_full(self: Pio, sm: StateMachine) bool {
        const regs = self.get_regs();
        const txfull = regs.FSTAT.read().TXFULL;
        return (txfull & (@as(u4, 1) << @enumToInt(sm))) != 0;
    }

    pub fn get_tx_fifo(self: Pio, sm: StateMachine) *volatile u32 {
        const regs = self.get_regs();
        return switch (sm) {
            .sm0 => &regs.TXF0,
            .sm1 => &regs.TXF1,
            .sm2 => &regs.TXF2,
            .sm3 => &regs.TXF3,
        };
    }

    pub fn blocking_write(self: Pio, sm: StateMachine, value: u32) void {
        while (self.is_tx_fifo_full(sm)) {}

        const fifo_ptr = self.get_tx_fifo(sm);
        fifo_ptr.* = value;
    }

    pub fn encode_jmp() void {}

    //static inline uint _pio_encode_instr_and_args(enum pio_instr_bits instr_bits, uint arg1, uint arg2) {
    //    valid_params_if(PIO_INSTRUCTIONS, arg1 <= 0x7);
    //#if PARAM_ASSERTIONS_ENABLED(PIO_INSTRUCTIONS)
    //    uint32_t major = _pio_major_instr_bits(instr_bits);
    //    if (major == pio_instr_bits_in || major == pio_instr_bits_out) {
    //        assert(arg2 && arg2 <= 32);
    //    } else {
    //        assert(arg2 <= 31);
    //    }
    //#endif
    //    return instr_bits | (arg1 << 5u) | (arg2 & 0x1fu);
    //}
    //
    //static inline uint pio_encode_jmp(uint addr) {
    //    return _pio_encode_instr_and_args(pio_instr_bits_jmp, 0, addr);
    //}

    pub fn set_enabled(self: Pio, sm: StateMachine, enabled: bool) void {
        const regs = self.get_regs();

        var value = regs.CTRL.read();
        if (enabled)
            value.SM_ENABLE |= @as(u4, 1) << @enumToInt(sm)
        else
            value.SM_ENABLE &= ~(@as(u4, 1) << @enumToInt(sm));

        regs.CTRL.write(value);
    }

    pub fn sm_init(self: Pio, sm: StateMachine, initial_pc: u5, config: StateMachineRegs) void {
        // Halt the machine, set some sensible defaults
        self.set_enabled(sm, false);

        self.set_config(sm, config);
        self.clear_fifos(sm);

        // Clear FIFO debug flags
        //const uint32_t fdebug_sm_mask =
        //        (1u << PIO_FDEBUG_TXOVER_LSB) |
        //        (1u << PIO_FDEBUG_RXUNDER_LSB) |
        //        (1u << PIO_FDEBUG_TXSTALL_LSB) |
        //        (1u << PIO_FDEBUG_RXSTALL_LSB);
        //pio->fdebug = fdebug_sm_mask << sm;

        // Finally, clear some internal SM state
        self.restart(sm);
        self.clkdiv_restart(sm);
        self.exec(sm, encode_jmp(initial_pc));
    }

    // state machine configuration helpers:
    //
    // - set_out_pins
    // - set_set_pins
    // - set_in_pins
    // - set_sideset_pins
    // - set_sideset
    // - calculate_clkdiv_from_float
    // - set_clkdiv
    // - set_wrap
    // - set_jmp_pin
    // - set_in_shift
    // - set_out_shift
    // - set_fifo_join
    // - set_out_special
    // - set_mov_status
    //
    // PIO:
    //
    // - can_add_program
    // - add_program_at_offset
    // - add_program
    // - remove_program
    // - clear_instruction_memory
    // - sm_init
    // - sm_set_enabled
    // - sm_mask_enabled
    // - sm_restart
    // - restart_sm_mask
    // - sm_clkdiv_restart
    // - clkdiv_restart_sm_mask
    // - enable_sm_mask_in_sync
    // - set_irq0_source_enabled
    // - set_irq1_source_enabled
    // - set_irq0_source_mask_enabled
    // - set_irq1_source_mask_enabled
    // - set_irqn_source_enabled
    // - set_irqn_source_mask_enabled
    // - interrupt_get
    // - interrupt_clear
    // - sm_get_pc
    // - sm_exec
    // - sm_is_exec_stalled
    // - sm_exec_wait_blocking
    // - sm_set_wrap
    // - sm_set_out_pins
    // - sm_set_set_pins
    // - sm_set_in_pins
    // - sm_set_sideset_pins
    // - sm_put
    // - sm_get
    // - sm_is_rx_fifo_full
    // - sm_is_rx_fifo_empty
    // - sm_is_rx_fifo_level
    // - sm_is_tx_fifo_full
    // - sm_is_tx_fifo_empty
    // - sm_is_tx_fifo_level
    // - sm_put_blocking
    // - sm_get_blocking
    // - sm_drain_tx_fifo
    // - sm_set_clkdiv_int_frac
    // - sm_set_clkdiv
    // - sm_clear_fifos
    // - sm_set_pins
    // - sm_set_pins_with_mask
    // - sm_set_pindirs_with_mask
    // - sm_set_consecutive_pindirs
    // - sm_claim
    // - claim_sm_mask
    // - sm_unclaim
    // - claim_unused_sm
    // - sm_is_claimed
    //
};

test "pio" {
    std.testing.refAllDecls(assembler);
    //std.testing.refAllDecls(@import("pio/test.zig"));
}
