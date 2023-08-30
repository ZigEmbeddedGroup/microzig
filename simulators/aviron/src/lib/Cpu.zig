const std = @import("std");
const isa = @import("decoder.zig");
const io = @import("io.zig");

const Flash = io.Flash;
const RAM = io.RAM;
const EEPROM = io.EEPROM;
const IO = io.IO;

const Cpu = @This();

pub const CodeModel = enum(u24) {
    /// 16 bit program counter
    code16 = 0x00_FFFF,

    /// 22 bit program counter,
    code22 = 0x3F_FFFF,
};

const InstructionEffect = enum {
    none,

    /// Prevents execution of the next instruction, but performs decoding anyways
    skip_next,

    /// The run command will return error.Breakpoint
    breakpoint,

    /// The run command will return error.Sleep
    sleep,

    watchdog_reset,
};

// Options:
trace: bool = false,

// Device:
code_model: CodeModel,
sio: SpecialIoRegisters,
flash: Flash,
sram: RAM,
eeprom: EEPROM,
io: IO,

// State
pc: u24 = 0,
regs: [32]u8 = [1]u8{0} ** 32,
sreg: SREG = @bitCast(@as(u8, 0)),

instr_effect: InstructionEffect = .none,

pub fn reset(cpu: *Cpu) void {
    cpu.pc = 0;
    cpu.regs = [1]u8{0} ** 32;
    cpu.sreg = @bitCast(@as(u8, 0));
}

pub const RunError = error{InvalidInstruction};
pub const RunResult = enum {
    breakpoint,
    enter_sleep_mode,
    reset_watchdog,
    out_of_gas,
};

pub fn run(cpu: *Cpu, mileage: ?u64) RunError!RunResult {
    var rest_gas = mileage;

    while (true) {
        if (rest_gas) |*rg| {
            if (rg.* == 0)
                return .out_of_gas;
            rg.* -= 1;
        }

        const skip = blk: {
            defer cpu.instr_effect = .none;
            break :blk switch (cpu.instr_effect) {
                .none => false,
                .skip_next => true,
                .breakpoint => return .breakpoint,
                .sleep => return .enter_sleep_mode,
                .watchdog_reset => return .reset_watchdog,
            };
        };

        const pc = cpu.pc;
        const inst = try isa.decode(cpu.fetchCode());

        if (cpu.trace) {
            // std.debug.print("TRACE {s} {} 0x{X:0>6}: {}\n", .{
            //     if (skip) "SKIP" else "    ",
            //     cpu.sreg,
            //     pc,
            //     fmtInstruction(inst),
            // });

            std.debug.print("TRACE {s} {} [", .{
                if (skip) "SKIP" else "    ",
                cpu.sreg,
            });

            for (cpu.regs, 0..) |reg, i| {
                if (i > 0)
                    std.debug.print(" ", .{});
                std.debug.print("{X:0>2}", .{reg});
            }

            std.debug.print("] 0x{X:0>6}: {}\n", .{
                pc,
                fmtInstruction(inst),
            });
        }

        if (!skip) {
            switch (std.meta.activeTag(inst)) {
                .unknown => return error.InvalidInstruction,
                inline else => |tag| {
                    const info = @field(inst, @tagName(tag));

                    if (@TypeOf(info) == void) {
                        @field(instructions, @tagName(tag))(cpu);
                    } else {
                        @field(instructions, @tagName(tag))(cpu, info);
                    }
                },
            }
        }
    }
}

fn shiftProgramCounter(cpu: *Cpu, by: i12) void {
    cpu.pc = @intCast(@as(i32, @intCast(cpu.pc)) + by);
}

fn fetchCode(cpu: *Cpu) u16 {
    const value = cpu.flash.read(cpu.pc);
    cpu.pc +%= 1; // increment with wraparound
    cpu.pc &= @intFromEnum(cpu.code_model); // then wrap to lower bit size
    return value;
}

fn push(cpu: *Cpu, val: u8) void {
    const sp = cpu.getSP();
    cpu.sram.write(sp, val);
    cpu.setSP(sp -% 1);
}

fn pop(cpu: *Cpu) u8 {
    const sp = cpu.getSP() +% 1;
    cpu.setSP(sp);
    return cpu.sram.read(sp);
}

fn pushCodeLoc(cpu: *Cpu, val: u24) void {
    const pc: u24 = val;
    const mask: u24 = @intFromEnum(cpu.code_model);

    if ((mask & 0x0000FF) != 0) {
        cpu.push(@truncate(pc >> 0));
    }
    if ((mask & 0x00FF00) != 0) {
        cpu.push(@truncate(pc >> 8));
    }
    if ((mask & 0xFF0000) != 0) {
        cpu.push(@truncate(pc >> 16));
    }
}

fn popCodeLoc(cpu: *Cpu) u24 {
    const mask = @intFromEnum(cpu.code_model);

    var pc: u24 = 0;
    if ((mask & 0x0000FF) != 0) {
        pc |= (@as(u24, cpu.pop()) << 0);
    }
    if ((mask & 0x00FF00) != 0) {
        pc |= (@as(u24, cpu.pop()) << 8);
    }
    if ((mask & 0xFF0000) != 0) {
        pc |= (@as(u24, cpu.pop()) << 16);
    }
    return pc;
}

const WideReg = enum(u8) {
    x = 0,
    y = 1,
    z = 2,
    fn base(wr: WideReg) usize {
        return 26 + 2 * @intFromEnum(wr);
    }
};

const IndexRegReadMode = enum { eind, ramp, raw };

fn readWideReg(cpu: *Cpu, comptime reg: WideReg, comptime mode: IndexRegReadMode) u24 {
    return compose24(
        switch (mode) {
            .raw => 0,
            .ramp => switch (reg) {
                .x => if (cpu.sio.ramp_x) |ramp| cpu.io.read(ramp) else 0,
                .y => if (cpu.sio.ramp_y) |ramp| cpu.io.read(ramp) else 0,
                .z => if (cpu.sio.ramp_z) |ramp| cpu.io.read(ramp) else 0,
            },
            .eind => if (cpu.sio.e_ind) |e_ind| cpu.io.read(e_ind) else 0,
        },
        cpu.regs[reg.base() + 1],
        cpu.regs[reg.base() + 0],
    );
}

const IndexRegWriteMode = enum { raw, ramp };

fn writeWideReg(cpu: *Cpu, reg: WideReg, value: u24, comptime mode: IndexRegWriteMode) void {
    const parts = decompose24(value);
    cpu.regs[reg.base() + 0] = parts[0];
    cpu.regs[reg.base() + 1] = parts[1];
    if (mode == .ramp) {
        switch (reg) {
            .x => if (cpu.sio.ramp_x) |ramp| cpu.io.write(ramp, parts[2]),
            .y => if (cpu.sio.ramp_y) |ramp| cpu.io.write(ramp, parts[2]),
            .z => if (cpu.sio.ramp_z) |ramp| cpu.io.write(ramp, parts[2]),
        }
    }
}

const instructions = struct {
    // Copy:

    /// MOV – Copy Register
    /// This instruction makes a copy of one register into another. The source register Rr is left unchanged, while
    /// the destination register Rd is loaded with a copy of Rr.
    inline fn mov(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rr
        cpu.regs[info.d.num()] = cpu.regs[info.r.num()];
    }

    /// MOVW – Copy Register Word
    /// This instruction makes a copy of one register pair into another register pair. The source register pair Rr
    /// +1:Rr is left unchanged, while the destination register pair Rd+1:Rd is loaded with a copy of Rr + 1:Rr.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn movw(cpu: *Cpu, info: isa.opinfo.d4r4) void {
        // d ∈ {0,2,...,30}, r ∈ {0,2,...,30
        const Rd = @as(u5, info.d.int()) << 1;
        const Rr = @as(u5, info.r.int()) << 1;

        // Rd+1:Rd ← Rr+1:Rr
        cpu.regs[Rd + 0] = cpu.regs[Rr + 0];
        cpu.regs[Rd + 1] = cpu.regs[Rr + 1];
    }

    /// SWAP – Swap Nibbles
    /// Swaps high and low nibbles in a register.
    inline fn swap(cpu: *Cpu, info: isa.opinfo.d5) void {
        const Nibbles = packed struct(u8) { low: u4, high: u4 };

        // R(7:4) ← Rd(3:0), R(3:0) ← Rd(7:4)
        const src: Nibbles = @bitCast(cpu.regs[info.d.num()]);
        const dst = Nibbles{ .low = src.high, .high = src.low };
        cpu.regs[info.d.num()] = @bitCast(dst);
    }

    // ALU Bitwise:

    const LogicOp = enum { @"and", @"or", xor };
    inline fn perform_logic(cpu: *Cpu, d: u5, rhs: u8, comptime op: LogicOp) void {
        const src = cpu.regs[d];
        const res = switch (op) {
            .@"and" => src & rhs,
            .@"or" => src | rhs,
            .xor => src ^ rhs,
        };

        cpu.regs[d] = res;
        cpu.sreg.z = (res == 0);
        cpu.sreg.n = (res & 0x80) != 0;
        cpu.sreg.v = false;
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    /// AND – Logical AND
    /// Performs the logical AND between the contents of register Rd and register Rr, and places the result in the
    /// destination register Rd.
    inline fn @"and"(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd • Rr
        return perform_logic(cpu, info.d.num(), cpu.regs[info.r.num()], .@"and");
    }

    /// EOR – Exclusive OR
    /// Performs the logical EOR between the contents of register Rd and register Rr and places the result in the
    /// destination register Rd.
    inline fn eor(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd
        return perform_logic(cpu, info.d.num(), cpu.regs[info.r.num()], .xor);
    }

    /// OR – Logical OR
    /// Performs the logical OR between the contents of register Rd and register Rr, and places the result in the
    /// destination register Rd.
    inline fn @"or"(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd v Rr
        return perform_logic(cpu, info.d.num(), cpu.regs[info.r.num()], .@"or");
    }

    /// ANDI – Logical AND with Immediate
    /// Performs the logical AND between the contents of register Rd and a constant, and places the result in the
    /// destination register Rd.
    inline fn andi(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd • K
        return perform_logic(cpu, info.d.num(), info.k, .@"and");
    }

    /// ORI – Logical OR with Immediate
    /// Performs the logical OR between the contents of register Rd and a constant, and places the result in the
    /// destination register Rd
    inline fn ori(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd v K
        return perform_logic(cpu, info.d.num(), info.k, .@"or");
    }

    // ALU Arithmetic:

    /// INC – Increment
    /// Adds one -1- to the contents of register Rd and places the result in the destination register Rd.
    /// The C Flag in SREG is not affected by the operation, thus allowing the INC instruction to be used on a
    /// loop counter in multiple-precision computations.
    /// When operating on unsigned numbers, only BREQ and BRNE branches can be expected to perform
    /// consistently. When operating on two’s complement values, all signed branches are available.
    inline fn inc(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← Rd + 1

        const src = cpu.regs[info.d.num()];

        const res = src +% 1;

        cpu.regs[info.d.num()] = res;

        cpu.sreg.z = (res == 0);
        cpu.sreg.v = (src == 0x7F);
        cpu.sreg.n = (res & 0x80) != 0;
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    /// DEC – Decrement
    /// Subtracts one -1- from the contents of register Rd and places the result in the destination register Rd.
    /// The C Flag in SREG is not affected by the operation, thus allowing the DEC instruction to be used on a
    /// loop counter in multiple-precision computations.
    /// When operating on unsigned values, only BREQ and BRNE branches can be expected to perform
    /// consistently. When operating on two’s complement values, all signed branches are available.
    inline fn dec(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← Rd - 1

        const src = cpu.regs[info.d.num()];

        const res = src -% 1;

        cpu.regs[info.d.num()] = res;

        cpu.sreg.z = (res == 0);
        cpu.sreg.v = (src == 0x80);
        cpu.sreg.n = (res & 0x80) != 0;
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    inline fn generic_add(cpu: *Cpu, info: isa.opinfo.d5r5, c: bool) void {
        const lhs = cpu.regs[info.d.num()];
        const Rd: Bits8 = @bitCast(lhs);
        const rhs = cpu.regs[info.r.num()];
        const Rr: Bits8 = @bitCast(rhs);

        const res: u8 = lhs +% rhs +% @intFromBool(c);

        const R: Bits8 = @bitCast(res);

        cpu.sreg.z = (res == 0);
        cpu.sreg.n = (res & 0x80) != 0;
        cpu.sreg.c = (Rd.b7 and Rr.b7) or (Rr.b7 and !R.b7) or (!R.b7 and Rd.b7);
        cpu.sreg.h = (Rd.b3 and Rr.b3) or (Rr.b3 and !R.b3) or (!R.b3 and Rd.b3);
        cpu.sreg.v = (Rd.b7 and Rr.b7 and !R.b7) or (!Rd.b7 and !Rr.b7 and R.b7);
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    /// ADD – Add without Carry
    /// Adds two registers without the C Flag and places the result in the destination register Rd.
    inline fn add(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd + Rr
        return generic_add(cpu, info, false);
    }

    /// ADC – Add with Carry
    /// Adds two registers and the contents of the C Flag and places the result in the destination register Rd.
    inline fn adc(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd + Rr + C
        return generic_add(cpu, info, cpu.sreg.c);
    }

    const SubCpConfig = struct {
        zero: enum { clear_only, replace },
        writeback: bool,
        carry: bool,
        flip: bool,

        const sub: SubCpConfig = .{ .zero = .replace, .writeback = true, .carry = false, .flip = false };
        const sbc: SubCpConfig = .{ .zero = .clear_only, .writeback = true, .carry = true, .flip = false };
        const cp: SubCpConfig = .{ .zero = .replace, .writeback = false, .carry = false, .flip = false };
        const cpc: SubCpConfig = .{ .zero = .clear_only, .writeback = false, .carry = true, .flip = false };
        const neg: SubCpConfig = .{ .zero = .replace, .writeback = true, .carry = false, .flip = true };
    };
    inline fn generic_sub_cp(cpu: *Cpu, d: isa.Register, _rhs: u8, comptime conf: SubCpConfig) void {
        const lhs: u8 = if (conf.flip) _rhs else cpu.regs[d.num()];
        const rhs: u8 = if (conf.flip) cpu.regs[d.num()] else _rhs;
        const Rd: Bits8 = @bitCast(lhs);
        const Rr: Bits8 = @bitCast(rhs);
        const result: u8 = if (conf.carry)
            lhs -% rhs -% @intFromBool(cpu.sreg.c)
        else
            lhs -% rhs;
        const R: Bits8 = @bitCast(result);

        if (conf.writeback) {
            cpu.regs[d.num()] = result;
        }

        // Set if there was a borrow from bit 3; cleared otherwise.
        // H = ~Rd3 • Rr3 + Rr3 • R3 + R3 • ~Rd3
        cpu.sreg.h = (!Rd.b3 and Rr.b3) or (Rr.b3 and R.b3) or (R.b3 and !Rd.b3);

        // Set if two’s complement overflow resulted from the operation; cleared otherwise.
        // V = Rd7 • ~Rr7 • ~R7 + ~Rd7 • Rr7 • R7
        cpu.sreg.v = (Rd.b7 and !Rr.b7 and !R.b7) or (!Rd.b7 and Rr.b7 and R.b7);

        // Set if the absolute value of the contents of Rr plus previous carry is larger than the absolute value of Rd; cleared otherwise.
        // C = ~Rd7 • Rr7 + Rr7 • R7 + R7 • ~Rd7
        cpu.sreg.c = (!Rd.b7 and Rr.b7) or (Rr.b7 and R.b7) or (R.b7 and !Rd.b7);

        const z = (result == 0);
        switch (conf.zero) {
            // Set if the result is $00; cleared otherwise.
            // Z = ~R7 • ~R6 • ~R5 • ~R4 • ~R3 • ~R2 • ~R1 • ~R0
            .replace => cpu.sreg.z = z,

            // Previous value remains unchanged when the result is zero; cleared otherwise.
            // Z = ~R7 • ~R6 • ~R5 • ~R4 • ~R3 • ~R2 • ~R1 • ~R0 • Z
            .clear_only => cpu.sreg.z = z and cpu.sreg.z,
        }

        // Set if MSB of the result is set; cleared otherwise.
        // N = R7
        cpu.sreg.n = R.b7;

        // S = N ⊕ V, for signed tests.
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    /// SUB – Subtract Without Carry
    /// Subtracts two registers and places the result in the destination register Rd.
    inline fn sub(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd - Rr
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r.num()], SubCpConfig.sub);
    }

    /// SUBI – Subtract Immediate
    /// Subtracts a register and a constant, and places the result in the destination register Rd. This instruction is
    /// working on Register R16 to R31 and is very well suited for operations on the X, Y, and Z-pointers.
    inline fn subi(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd - K
        return generic_sub_cp(cpu, info.d.reg(), info.k, SubCpConfig.sub);
    }

    /// SBC – Subtract with Carry
    /// Subtracts two registers and subtracts with the C Flag, and places the result in the destination register Rd.
    inline fn sbc(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd - Rr - C
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r.num()], SubCpConfig.sbc);
    }

    /// SBCI – Subtract Immediate with Carry SBI
    /// Subtracts a constant from a register and subtracts with the C Flag, and places the result in the destination
    /// register Rd.
    inline fn sbci(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd - K - C
        return generic_sub_cp(cpu, info.d.reg(), info.k, SubCpConfig.sbc);
    }

    /// NEG – Two’s Complement
    /// Replaces the contents of register Rd with its two’s complement; the value $80 is left unchanged.
    inline fn neg(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← $00 - Rd
        return generic_sub_cp(cpu, info.d, 0x00, SubCpConfig.neg);
    }

    /// COM – One’s Complement
    /// This instruction performs a One’s Complement of register Rd.
    inline fn com(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← $FF - Rd
        const src = cpu.regs[info.d.num()];

        const res: u8 = 0xFF - src;

        cpu.regs[info.d.num()] = res;

        cpu.sreg.z = (res == 0);
        cpu.sreg.n = (res & 0x80) != 0;
        cpu.sreg.c = true;
        cpu.sreg.v = false;
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    // Multiplier ALU Arithmetic:

    /// TODO!
    inline fn fmul(cpu: *Cpu, info: isa.opinfo.d3r3) void {
        _ = cpu;
        std.debug.print("fmul {}\n", .{info});
        @panic("fmul not implemented yet!");
    }

    /// TODO!
    inline fn fmuls(cpu: *Cpu, info: isa.opinfo.d3r3) void {
        _ = cpu;
        std.debug.print("fmuls {}\n", .{info});
        @panic("fmuls not implemented yet!");
    }

    /// TODO!
    inline fn fmulsu(cpu: *Cpu, info: isa.opinfo.d3r3) void {
        _ = cpu;
        std.debug.print("fmulsu {}\n", .{info});
        @panic("fmulsu not implemented yet!");
    }

    const MulConfig = struct {
        Lhs: type,
        Rhs: type,
        Result: type,
    };
    inline fn generic_mul(cpu: *Cpu, d: isa.Register, r: isa.Register, comptime config: MulConfig) void {
        // R1:R0 ← Rd × Rr
        const lhs_raw: u8 = cpu.regs[d.num()];
        const rhs_raw: u8 = cpu.regs[r.num()];

        const lhs: config.Lhs = @bitCast(lhs_raw);
        const rhs: config.Rhs = @bitCast(rhs_raw);

        const result: config.Result = @as(config.Result, lhs) *% @as(config.Result, rhs);

        const raw_result: u16 = @bitCast(result);

        const split_result = decompose16(raw_result);
        cpu.regs[0] = split_result[0];
        cpu.regs[1] = split_result[1];

        cpu.sreg.c = ((raw_result & 0x8000) != 0);
        cpu.sreg.z = (raw_result == 0);
    }

    /// MUL – Multiply Unsigned
    ///
    /// This instruction performs 8-bit × 8-bit → 16-bit unsigned multiplication.
    ///
    /// The multiplicand Rd and the multiplier Rr are two registers containing unsigned numbers. The 16-bit
    /// unsigned product is placed in R1 (high byte) and R0 (low byte). Note that if the multiplicand or the
    /// multiplier is selected from R0 or R1 the result will overwrite those after multiplication.
    ///
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn mul(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // R1:R0 ← Rd × Rr (unsigned ← unsigned × unsigned)
        return generic_mul(cpu, info.d.reg(), info.r.reg(), .{
            .Result = u16,
            .Lhs = u8,
            .Rhs = u8,
        });
    }

    /// MULS – Multiply Signed
    ///
    /// The multiplicand Rd and the multiplier Rr are two registers containing signed numbers. The 16-bit signed
    /// product is placed in R1 (high byte) and R0 (low byte).
    ///
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn muls(cpu: *Cpu, info: isa.opinfo.d4r4) void {
        // R1:R0 ← Rd × Rr (signed ← signed × signed)
        return generic_mul(cpu, info.d.reg(), info.r.reg(), .{
            .Result = i16,
            .Lhs = i8,
            .Rhs = i8,
        });
    }

    /// MULSU – Multiply Signed with Unsigned
    ///
    /// This instruction performs 8-bit × 8-bit → 16-bit multiplication of a signed and an unsigned number.
    ///
    /// The multiplicand Rd and the multiplier Rr are two registers. The multiplicand Rd is a signed number, and
    /// the multiplier Rr is unsigned. The 16-bit signed product is placed in R1 (high byte) and R0 (low byte).
    ///
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn mulsu(cpu: *Cpu, info: isa.opinfo.d3r3) void {
        // R1:R0 ← Rd × Rr (signed ← signed × unsigned)
        return generic_mul(cpu, info.d.reg(), info.r.reg(), .{
            .Result = i16,
            .Lhs = i8,
            .Rhs = u8,
        });
    }

    // Wide ALU Arithmetic:

    const register_pairs_4 = [4]usize{ 24, 26, 28, 30 };

    /// ADIW – Add Immediate to Word
    /// Adds an immediate value (0 - 63) to a register pair and places the result in the register pair. This
    /// instruction operates on the upper four register pairs, and is well suited for operations on the pointer
    /// registers.
    ///
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn adiw(cpu: *Cpu, info: isa.opinfo.d2k6) void {
        // Rd+1:Rd ← Rd+1:Rd + K

        const base = register_pairs_4[info.d];

        const src = compose16(cpu.regs[base + 1], cpu.regs[base + 0]);

        const res = src +% info.k;

        const res2 = decompose16(res);
        cpu.regs[base + 0] = res2[0];
        cpu.regs[base + 1] = res2[1];

        cpu.sreg.z = (res == 0);
        cpu.sreg.n = ((res & 0x8000) != 0);
        cpu.sreg.v = ((src & 0x8000) == 0) and ((res & 0x8000) != 0);
        cpu.sreg.c = ((src & 0x8000) != 0) and ((res & 0x8000) == 0);
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    /// SBIW – Subtract Immediate from Word
    /// Subtracts an immediate value (0-63) from a register pair and places the result in the register pair. This
    /// instruction operates on the upper four register pairs, and is well suited for operations on the Pointer
    /// Registers.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn sbiw(cpu: *Cpu, info: isa.opinfo.d2k6) void {
        // Rd+1:Rd ← Rd+1:Rd - K

        const base = register_pairs_4[info.d];

        const src = compose16(cpu.regs[base + 1], cpu.regs[base + 0]);

        const res = src -% info.k;

        const res2 = decompose16(res);
        cpu.regs[base + 0] = res2[0];
        cpu.regs[base + 1] = res2[1];

        cpu.sreg.z = (res == 0);
        cpu.sreg.n = ((res & 0x8000) != 0);
        cpu.sreg.c = ((src & 0x8000) == 0) and ((res & 0x8000) != 0);
        cpu.sreg.v = cpu.sreg.c;
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    // ALU Shifts

    const ShiftConfig = struct {
        msb: enum { sticky, carry, zero },
    };
    inline fn generic_shift(cpu: *Cpu, info: isa.opinfo.d5, comptime conf: ShiftConfig) void {
        const src: u8 = cpu.regs[info.d.num()];

        const msb: u8 = switch (conf.msb) {
            .zero => 0x00,
            .carry => if (cpu.sreg.c) 0x80 else 0x00,
            .sticky => (src & 0x80),
        };
        const res: u8 = (src >> 7) | msb;

        cpu.regs[info.d.num()] = res;

        // Set if the result is $00; cleared otherwise.
        // Z = ~R7 • ~R6 • ~R5 • ~R4 • ~R3 • ~R2 • ~R1 • ~R0
        cpu.sreg.z = (res == 0);

        // Set if, before the shift, the LSB of Rd was set; cleared otherwise.
        // C = Rd0
        cpu.sreg.c = (src & 0x01) != 0;

        // Set if MSB of the result is set; cleared otherwise.
        // N = R7
        cpu.sreg.n = (src & 0x80) != 0;

        // V = N ⊕ C, for N and C after the shift.
        cpu.sreg.v = (cpu.sreg.n != cpu.sreg.c);

        // N ⊕ V, for signed tests.
        cpu.sreg.n = (cpu.sreg.n != cpu.sreg.v);
    }

    /// Shifts all bits in Rd one place to the right. Bit 7 is held constant. Bit 0 is loaded into the C Flag of the
    /// SREG. This operation effectively divides a signed value by two without changing its sign. The Carry Flag
    /// can be used to round the result.
    inline fn asr(cpu: *Cpu, info: isa.opinfo.d5) void {
        return generic_shift(cpu, info, .{ .msb = .sticky });
    }

    /// LSR – Logical Shift Right
    /// Shifts all bits in Rd one place to the right. Bit 7 is cleared. Bit 0 is loaded into the C Flag of the SREG.
    /// This operation effectively divides an unsigned value by two. The C Flag can be used to round the result.
    inline fn lsr(cpu: *Cpu, info: isa.opinfo.d5) void {
        return generic_shift(cpu, info, .{ .msb = .zero });
    }

    /// ROR – Rotate Right through Carry
    /// Shifts all bits in Rd one place to the right. The C Flag is shifted into bit 7 of Rd. Bit 0 is shifted into the C
    /// Flag. This operation, combined with ASR, effectively divides multi-byte signed values by two. Combined
    /// with LSR it effectively divides multi-byte unsigned values by two. The Carry Flag can be used to round the
    /// result.
    inline fn ror(cpu: *Cpu, info: isa.opinfo.d5) void {
        return generic_shift(cpu, info, .{ .msb = .carry });
    }

    // ASL = LSL = ADD Rd, Rd
    // ROL       = ADC Rd, Rd

    // I/O:

    /// OUT – Store Register to I/O Location
    /// Stores data from register Rr in the Register File to I/O Space (Ports, Timers, Configuration Registers, etc.).
    inline fn out(cpu: *Cpu, info: isa.opinfo.a6r5) void {
        // I/O(A) ← Rr
        cpu.io.write(info.a, cpu.regs[info.r.num()]);
    }

    /// IN - Load an I/O Location to Register
    /// Loads data from the I/O Space (Ports, Timers, Configuration Registers, etc.) into register Rd in the Register File.
    inline fn in(cpu: *Cpu, info: isa.opinfo.a6d5) void {
        // Rd ← I/O(A)
        cpu.regs[info.d.num()] = cpu.io.read(info.a);
    }

    /// CBI – Clear Bit in I/O Register
    /// Clears a specified bit in an I/O register. This instruction operates on the lower 32 I/O registers –
    /// addresses 0-31.
    inline fn cbi(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // I/O(A,b) ← 0
        cpu.io.writeMasked(info.a, info.b.mask(), 0x00);
    }

    /// SBI – Set Bit in I/O Register
    /// Sets a specified bit in an I/O Register. This instruction operates on the lower 32 I/O Registers – addresses 0-31.
    inline fn sbi(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // I/O(A,b) ← 1
        cpu.io.writeMasked(info.a, info.b.mask(), 0xFF);
    }

    // Branching:

    /// BRBC – Branch if Bit in SREG is Cleared
    /// Conditional relative branch. Tests a single bit in SREG and branches relatively to PC if the bit is cleared.
    /// This instruction branches relatively to PC in either direction (PC - 63 ≤ destination ≤ PC + 64). Parameter
    /// k is the offset from PC and is represented in two’s complement form.
    inline fn brbc(cpu: *Cpu, info: isa.opinfo.k7s3) void {
        // If SREG(s) = 0 then PC ← PC + k + 1, else PC ← PC + 1
        const pc_offset: i7 = @bitCast(info.k);
        if (!cpu.sreg.readBit(info.s)) {
            cpu.shiftProgramCounter(pc_offset);
        }
    }

    /// BRBS – Branch if Bit in SREG is Set
    /// Conditional relative branch. Tests a single bit in SREG and branches relatively to PC if the bit is set. This
    /// instruction branches relatively to PC in either direction (PC - 63 ≤ destination ≤ PC + 64). Parameter k is
    /// the offset from PC and is represented in two’s complement form.
    inline fn brbs(cpu: *Cpu, bits: isa.opinfo.k7s3) void {
        // If SREG(s) = 1 then PC ← PC + k + 1, else PC ← PC + 1

        const pc_offset: i7 = @bitCast(bits.k);
        if (cpu.sreg.readBit(bits.s)) {
            cpu.shiftProgramCounter(pc_offset);
        }
    }

    /// SBIC – Skip if Bit in I/O Register is Cleared
    /// This instruction tests a single bit in an I/O Register and skips the next instruction if the bit is cleared. This
    /// instruction operates on the lower 32 I/O Registers – addresses 0-31.
    inline fn sbic(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // If I/O(A,b) = 0 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.io.read(info.a);
        if ((val & info.b.mask()) == 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// SBIS – Skip if Bit in I/O Register is Set
    /// This instruction tests a single bit in an I/O Register and skips the next instruction if the bit is set. This
    /// instruction operates on the lower 32 I/O Registers – addresses 0-31.
    inline fn sbis(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // If I/O(A,b) = 1 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.io.read(info.a);
        if ((val & info.b.mask()) != 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// SBRC – Skip if Bit in Register is Cleared
    /// This instruction tests a single bit in a register and skips the next instruction if the bit is cleared.
    inline fn sbrc(cpu: *Cpu, info: isa.opinfo.b3r5) void {
        // If Rr(b) = 0 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.regs[info.r.num()];
        if ((val & info.b.mask()) == 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// SBRS – Skip if Bit in Register is Set
    /// This instruction tests a single bit in a register and skips the next instruction if the bit is set.
    inline fn sbrs(cpu: *Cpu, info: isa.opinfo.b3r5) void {
        // If Rr(b) = 1 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.regs[info.r.num()];
        if ((val & info.b.mask()) != 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// This instruction performs a compare between two registers Rd and Rr, and skips the next instruction if Rd = Rr.
    inline fn cpse(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // If Rd = Rr then PC ← PC + 2 (or 3) else PC ← PC + 1

        const Rd = cpu.regs[info.d.num()];
        const Rr = cpu.regs[info.r.num()];
        if (Rd == Rr) {
            cpu.instr_effect = .skip_next;
        }
    }

    // Jumps

    /// JMP – Jump
    /// Jump to an address within the entire 4M (words) Program memory. See also RJMP.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    ///
    /// NOTE: 32 bit instruction!
    inline fn jmp(cpu: *Cpu, info: isa.opinfo.k6) void {
        // PC ← k
        const ext = cpu.fetchCode();
        cpu.pc = (@as(u24, info.k) << 16) | ext;
    }

    /// RJMP – Relative Jump
    /// Relative jump to an address within PC - 2K +1 and PC + 2K (words). For AVR microcontrollers with
    /// Program memory not exceeding 4K words (8KB) this instruction can address the entire memory from
    /// every address location. See also JMP.
    inline fn rjmp(cpu: *Cpu, bits: isa.opinfo.k12) void {
        cpu.shiftProgramCounter(@as(i12, @bitCast(bits.k)));
    }

    /// RCALL – Relative Call to Subroutine
    /// Relative call to an address within PC - 2K + 1 and PC + 2K (words). The return address (the instruction
    /// after the RCALL) is stored onto the Stack. See also CALL. For AVR microcontrollers with Program
    /// memory not exceeding 4K words (8KB) this instruction can address the entire memory from every
    /// address location. The Stack Pointer uses a post-decrement scheme during RCALL.
    inline fn rcall(cpu: *Cpu, info: isa.opinfo.k12) void {
        // PC ← PC + k + 1
        cpu.pushCodeLoc(cpu.pc); // PC already points to the next instruction
        rjmp(cpu, info);
    }

    /// RET – Return from Subroutine
    /// Returns from subroutine. The return address is loaded from the STACK. The Stack Pointer uses a pre-
    /// increment scheme during RET.
    inline fn ret(cpu: *Cpu) void {
        // PC(15:0) ← STACK Devices with 16-bit PC, 128KB Program memory maximum.
        // PC(21:0) ← STACK Devices with 22-bit PC, 8MB Program memory maximum.
        cpu.pc = cpu.popCodeLoc();
    }

    /// RETI – Return from Interrupt
    /// Returns from interrupt. The return address is loaded from the STACK and the Global Interrupt Flag is set.
    /// Note that the Status Register is not automatically stored when entering an interrupt routine, and it is not
    /// restored when returning from an interrupt routine. This must be handled by the application program. The
    /// Stack Pointer uses a pre-increment scheme during RETI.
    inline fn reti(cpu: *Cpu) void {
        // PC(15:0) ← STACK Devices with 16-bit PC, 128KB Program memory maximum.
        // PC(21:0) ← STACK Devices with 22-bit PC, 8MB Program memory maximum.
        cpu.pc = cpu.popCodeLoc();
        cpu.sreg.i = true;
    }

    /// CALL – Long Call to a Subroutine
    /// Calls to a subroutine within the entire Program memory. The return address (to the instruction after the
    /// CALL) will be stored onto the Stack. (See also RCALL). The Stack Pointer uses a post-decrement
    /// scheme during CALL.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    ///
    /// NOTE: 32 bit instruction!
    inline fn call(cpu: *Cpu, info: isa.opinfo.k6) void {
        const ext = cpu.fetchCode();
        cpu.pushCodeLoc(cpu.pc); // PC already points to the next instruction
        cpu.pc = (@as(u24, info.k) << 16) | ext;
    }

    /// ICALL – Indirect Call to Subroutine
    /// Calls to a subroutine within the entire 4M (words) Program memory. The return address (to the instruction
    /// after the CALL) will be stored onto the Stack. See also RCALL. The Stack Pointer uses a post-decrement
    /// scheme during CALL.
    ///
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn icall(cpu: *Cpu) void {
        // PC(15:0) ← Z(15:0)
        // PC(21:16) ← 0
        cpu.pushCodeLoc(cpu.pc); // PC already points to the next instruction
        cpu.pc = cpu.readWideReg(.z, .raw);
    }

    /// IJMP – Indirect Jump
    /// Indirect jump to the address pointed to by the Z (16 bits) Pointer Register in the Register File. The Z-
    /// pointer Register is 16 bits wide and allows jump within the lowest 64K words (128KB) section of Program
    /// memory.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn ijmp(cpu: *Cpu) void {
        // PC(15:0) ← Z(15:0)
        // PC(21:16) ← 0
        cpu.pc = cpu.readWideReg(.z, .raw);
    }

    /// EICALL – Extended Indirect Call to Subroutine
    /// Indirect call of a subroutine pointed to by the Z (16 bits) Pointer Register in the Register File and the EIND
    /// Register in the I/O space. This instruction allows for indirect calls to the entire 4M (words) Program
    /// memory space. See also ICALL. The Stack Pointer uses a post-decrement scheme during EICALL.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn eicall(cpu: *Cpu) void {
        // PC(15:0) ← Z(15:0)
        // PC(21:16) ← EIND
        cpu.pushCodeLoc(cpu.pc); // PC already points to the next instruction
        cpu.pc = cpu.readWideReg(.z, .eind);
    }

    /// EIJMP – Extended Indirect Jump
    /// Indirect jump to the address pointed to by the Z (16 bits) Pointer Register in the Register File and the
    /// EIND Register in the I/O space. This instruction allows for indirect jumps to the entire 4M (words)
    /// Program memory space. See also IJMP.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn eijmp(cpu: *Cpu) void {
        // PC(15:0) ← Z(15:0)
        // PC(21:16) ← EIND
        cpu.pc = cpu.readWideReg(.z, .eind);
    }

    // Comparisons

    /// This instruction performs a compare between two registers Rd and Rr.
    /// None of the registers are changed.
    /// All conditional branches can be used after this instruction.
    inline fn cp(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // (1) Rd - Rr
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r.num()], SubCpConfig.cp);
    }

    /// This instruction performs a compare between two registers Rd and Rr and also takes into account the
    /// previous carry.
    /// None of the registers are changed.
    /// All conditional branches can be used after this instruction.
    inline fn cpc(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // (1) Rd - Rr - C
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r.num()], SubCpConfig.cpc);
    }

    /// This instruction performs a compare between register Rd and a constant.
    /// The register is not changed.
    /// All conditional branches can be used after this instruction.
    inline fn cpi(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // (1) Rd - K
        return generic_sub_cp(cpu, info.d.reg(), info.k, SubCpConfig.cp);
    }

    // Loads

    /// LDI – Load Immediate
    /// Loads an 8-bit constant directly to register 16 to 31.
    inline fn ldi(cpu: *Cpu, bits: isa.opinfo.d4k8) void {
        // Rd ← K
        cpu.regs[bits.d.num()] = bits.k;
    }

    /// XCH – Exchange
    /// Exchanges one byte indirect between register and data space.
    /// The data location is pointed to by the Z (16 bits) Pointer Register in the Register File. Memory access is
    /// limited to the current data segment of 64KB. To access another data segment in devices with more than
    /// 64KB data space, the RAMPZ in register in the I/O area has to be changed.
    /// The Z-pointer Register is left unchanged by the operation. This instruction is especially suited for writing/
    /// reading status bits stored in SRAM.
    inline fn xch(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (Z) ← Rd, Rd ← (Z)
        const z = cpu.readWideReg(.z, .ramp);

        const Rd = cpu.regs[info.r.num()];
        const mem = cpu.sram.read(z);
        cpu.sram.write(z, Rd);
        cpu.regs[info.r.num()] = mem;
    }

    /// Load one byte indirect from data space to register and stores and clear the bits in data space specified by
    /// the register. The instruction can only be used towards internal SRAM.
    /// The data location is pointed to by the Z (16 bits) Pointer Register in the Register File. Memory access is
    /// limited to the current data segment of 64KB. To access another data segment in devices with more than
    /// 64KB data space, the RAMPZ in register in the I/O area has to be changed.
    /// The Z-pointer Register is left unchanged by the operation. This instruction is especially suited for clearing
    /// status bits stored in SRAM.
    ///
    /// (Z) ← ($FF – Rd) • (Z), Rd ← (Z)
    inline fn lac(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (Z) ← ($FF – Rd) • (Z), Rd ← (Z)
        const z = cpu.readWideReg(.z, .ramp);

        const Rd = cpu.regs[info.r.num()];
        const mem = cpu.sram.read(z);
        cpu.sram.write(z, (0xFF - Rd) & mem);
        cpu.regs[info.r.num()] = mem;
    }

    /// LAS – Load and Set
    ///
    /// Load one byte indirect from data space to register and set bits in data space specified by the register. The
    /// instruction can only be used towards internal SRAM.
    /// The data location is pointed to by the Z (16 bits) Pointer Register in the Register File. Memory access is
    /// limited to the current data segment of 64KB. To access another data segment in devices with more than
    /// 64KB data space, the RAMPZ in register in the I/O area has to be changed.
    /// The Z-pointer Register is left unchanged by the operation. This instruction is especially suited for setting
    /// status bits stored in SRAM.
    inline fn las(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (Z) ← Rd v (Z), Rd ← (Z)
        const z = cpu.readWideReg(.z, .ramp);

        const Rd = cpu.regs[info.r.num()];
        const mem = cpu.sram.read(z);
        cpu.sram.write(z, Rd | mem);
        cpu.regs[info.r.num()] = mem;
    }

    /// LAT – Load and Toggle
    /// Load one byte indirect from data space to register and toggles bits in the data space specified by the
    /// register. The instruction can only be used towards SRAM.
    /// The data location is pointed to by the Z (16 bits) Pointer Register in the Register File. Memory access is
    /// limited to the current data segment of 64KB. To access another data segment in devices with more than
    /// 64KB data space, the RAMPZ in register in the I/O area has to be changed.
    /// The Z-pointer Register is left unchanged by the operation. This instruction is especially suited for
    /// changing status bits stored in SRAM.
    inline fn lat(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (Z) ← Rd ⊕ (Z), Rd ← (Z)
        const z = cpu.readWideReg(.z, .ramp);

        const Rd = cpu.regs[info.r.num()];
        const mem = cpu.sram.read(z);
        cpu.sram.write(z, Rd ^ mem);
        cpu.regs[info.r.num()] = mem;
    }

    /// LDS – Load Direct from Data Space
    ///
    /// Loads one byte from the data space to a register. For parts with SRAM, the data space consists of the
    /// Register File, I/O memory, and internal SRAM (and external SRAM if applicable). For parts without
    /// SRAM, the data space consists of the register file only. The EEPROM has a separate address space.
    /// A 16-bit address must be supplied. Memory access is limited to the current data segment of 64KB. The
    /// LDS instruction uses the RAMPD Register to access memory above 64KB. To access another data
    /// segment in devices with more than 64KB data space, the RAMPD in register in the I/O area has to be
    /// changed.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    ///
    /// NOTE: 32 bit instruction!
    inline fn lds(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (k)
        const addr = cpu.extendDirectAddress(cpu.fetchCode());
        cpu.regs[info.d.num()] = cpu.sram.read(addr);
    }

    const IndexOpMode = enum { none, post_incr, pre_decr, displace };
    const IndexOpConfig = struct {
        op: IndexOpMode,
        wb: IndexRegWriteMode,
        rd: IndexRegReadMode,
    };
    inline fn compute_and_mutate_index(cpu: *Cpu, comptime wr: WideReg, q: u6, comptime config: IndexOpConfig) u24 {
        const raw = cpu.readWideReg(wr, config.rd);
        const address = switch (config.op) {
            .none => raw,
            .displace => raw +% q,
            .pre_decr => blk: {
                const index = raw -% 1;
                cpu.writeWideReg(wr, index, config.wb);
                break :blk index;
            },
            .post_incr => blk: {
                cpu.writeWideReg(wr, raw +% 1, config.wb);
                break :blk raw;
            },
        };
        return address;
    }

    inline fn generic_indexed_load(cpu: *Cpu, comptime wr: WideReg, d: isa.Register, q: u6, comptime mode: IndexOpMode) void {
        const address = compute_and_mutate_index(cpu, wr, q, .{
            .op = mode,
            .rd = .ramp,
            .wb = .ramp,
        });
        cpu.regs[d.num()] = cpu.sram.read(address);
    }

    /// LD – Load Indirect from Data Space to Register using Index X
    inline fn ldx_i(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (X)
        return generic_indexed_load(cpu, .x, info.d, 0, .none);
    }

    /// LD – Load Indirect from Data Space to Register using Index X
    inline fn ldx_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (X) X ← X + 1
        return generic_indexed_load(cpu, .x, info.d, 0, .post_incr);
    }

    /// LD – Load Indirect from Data Space to Register using Index X
    inline fn ldx_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // X ← X - 1 Rd ← (X)
        return generic_indexed_load(cpu, .x, info.d, 0, .pre_decr);
    }

    // ldy_i is equivalent to ldy_iv with q=0

    /// LD (LDD) – Load Indirect from Data Space to Register using Index Y
    inline fn ldy_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (Y), Y ← Y + 1
        return generic_indexed_load(cpu, .y, info.d, 0, .post_incr);
    }

    /// LD (LDD) – Load Indirect from Data Space to Register using Index Y
    inline fn ldy_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Y ← Y - 1, Rd ← (Y)
        return generic_indexed_load(cpu, .y, info.d, 0, .pre_decr);
    }

    /// LD (LDD) – Load Indirect from Data Space to Register using Index Y
    inline fn ldy_iv(cpu: *Cpu, info: isa.opinfo.d5q6) void {
        // Rd ← (Y+q)
        return generic_indexed_load(cpu, .y, info.d, info.q, .displace);
    }

    // ldz_i is equivalent to ldz_iv with q=0

    /// LD (LDD) – Load Indirect From Data Space to Register using Index Z
    inline fn ldz_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (Z), Z ← Z + 1
        return generic_indexed_load(cpu, .z, info.d, 0, .post_incr);
    }

    /// LD (LDD) – Load Indirect From Data Space to Register using Index Z
    inline fn ldz_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Z ← Z - 1, Rd ← (Z)
        return generic_indexed_load(cpu, .z, info.d, 0, .pre_decr);
    }

    /// LD (LDD) – Load Indirect From Data Space to Register using Index Z
    inline fn ldz_iv(cpu: *Cpu, info: isa.opinfo.d5q6) void {
        // Rd ← (Z+q)
        return generic_indexed_load(cpu, .z, info.d, info.q, .displace);
    }

    /// LPM – Load Program Memory
    ///
    /// Loads one byte pointed to by the Z-register into the destination register Rd. This instruction features a
    /// 100% space effective constant initialization or constant data fetch. The Program memory is organized in
    /// 16-bit words while the Z-pointer is a byte address. Thus, the least significant bit of the Z-pointer selects
    /// either low byte (ZLSB = 0) or high byte (ZLSB = 1). This instruction can address the first 64KB (32K words)
    /// of Program memory. The Z-pointer Register can either be left unchanged by the operation, or it can be
    /// incremented. The incrementation does not apply to the RAMPZ Register.
    /// Devices with Self-Programming capability can use the LPM instruction to read the Fuse and Lock bit
    /// values. Refer to the device documentation for a detailed description.
    /// The LPM instruction is not available in all devices. Refer to the device specific instruction set summary.
    /// The result of these combinations is undefined:
    /// LPM r30, Z+
    /// LPM r31, Z+
    ///
    /// ELPM – Extended Load Program Memory
    ///
    /// Loads one byte pointed to by the Z-register and the RAMPZ Register in the I/O space, and places this
    /// byte in the destination register Rd. This instruction features a 100% space effective constant initialization
    /// or constant data fetch. The Program memory is organized in 16-bit words while the Z-pointer is a byte
    /// address. Thus, the least significant bit of the Z-pointer selects either low byte (ZLSB = 0) or high byte (ZLSB
    /// = 1). This instruction can address the entire Program memory space. The Z-pointer Register can either be
    /// left unchanged by the operation, or it can be incremented. The incrementation applies to the entire 24-bit
    /// concatenation of the RAMPZ and Z-pointer Registers.
    /// Devices with Self-Programming capability can use the ELPM instruction to read the Fuse and Lock bit
    /// value. Refer to the device documentation for a detailed description.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    /// The result of these combinations is undefined:
    /// ELPM r30, Z+
    /// ELPM r31, Z+
    inline fn generic_lpm(cpu: *Cpu, d: isa.Register, mode: IndexOpMode, size: enum { regular, extended }) void {
        const addr = compute_and_mutate_index(cpu, .z, 0, .{
            .op = mode,
            .wb = switch (size) {
                .regular => .raw,
                .extended => .ramp,
            },
            .rd = switch (size) {
                .regular => .raw,
                .extended => .ramp,
            },
        });
        const word = cpu.flash.read(addr >> 1);
        cpu.regs[d.num()] = if ((addr & 1) != 0)
            @truncate(word >> 8)
        else
            @truncate(word >> 0);
    }

    inline fn lpm_i(cpu: *Cpu) void {
        // R0 ← (Z)
        return generic_lpm(cpu, .r0, .none, .regular);
    }

    inline fn lpm_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (Z)
        return generic_lpm(cpu, info.d, .none, .regular);
    }

    inline fn lpm_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (Z) Z ← Z + 1
        return generic_lpm(cpu, info.d, .post_incr, .regular);
    }

    inline fn elpm_i(cpu: *Cpu) void {
        // R0 ← (RAMPZ:Z)
        return generic_lpm(cpu, .r0, .none, .extended);
    }

    inline fn elpm_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (RAMPZ:Z)
        return generic_lpm(cpu, info.d, .none, .extended);
    }

    inline fn elpm_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← (RAMPZ:Z), (RAMPZ:Z) ← (RAMPZ:Z) + 1
        return generic_lpm(cpu, info.d, .post_incr, .extended);
    }

    /// POP – Pop Register from Stack
    /// This instruction loads register Rd with a byte from the STACK. The Stack Pointer is pre-incremented by 1
    /// before the POP.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn pop(cpu: *Cpu, info: isa.opinfo.d5) void {
        // Rd ← STACK
        cpu.regs[info.d.num()] = cpu.pop();
    }

    // Stores:

    inline fn generic_indexed_store(cpu: *Cpu, comptime wr: WideReg, r: isa.Register, q: u6, comptime mode: IndexOpMode) void {
        const address = compute_and_mutate_index(cpu, wr, q, .{
            .op = mode,
            .rd = .ramp,
            .wb = .ramp,
        });
        cpu.sram.write(address, cpu.regs[r.num()]);
    }

    /// ST – Store Indirect From Register to Data Space using Index X
    inline fn stx_i(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (X) ← Rr
        generic_indexed_store(cpu, .x, info.r, 0, .none);
    }

    /// ST – Store Indirect From Register to Data Space using Index X
    inline fn stx_ii(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (X) ← Rr, X ← X+1
        generic_indexed_store(cpu, .x, info.r, 0, .post_incr);
    }

    /// ST – Store Indirect From Register to Data Space using Index X
    inline fn stx_iii(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (iii) X ← X - 1, (X) ← Rr
        generic_indexed_store(cpu, .x, info.r, 0, .pre_decr);
    }

    // sty_i is sty_iv with q=0

    /// ST (STD) – Store Indirect From Register to Data Space using Index Y
    inline fn sty_ii(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (Y) ← Rr, Y ← Y+1
        generic_indexed_store(cpu, .y, info.r, 0, .none);
    }

    /// ST (STD) – Store Indirect From Register to Data Space using Index Y
    inline fn sty_iii(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (iii) Y ← Y - 1, (Y) ← Rr
        generic_indexed_store(cpu, .y, info.r, 0, .post_incr);
    }

    /// ST (STD) – Store Indirect From Register to Data Space using Index Y
    inline fn sty_iv(cpu: *Cpu, info: isa.opinfo.q6r5) void {
        // (iv) (Y+q) ← Rr
        generic_indexed_store(cpu, .y, info.r, info.q, .displace);
    }

    // stz_i is stz_iv with q=0

    /// ST (STD) – Store Indirect From Register to Data Space using Index Z
    inline fn stz_ii(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (Z) ← Rr, Z ← Z+1
        generic_indexed_store(cpu, .z, info.r, 0, .none);
    }

    /// ST (STD) – Store Indirect From Register to Data Space using Index Z
    inline fn stz_iii(cpu: *Cpu, info: isa.opinfo.r5) void {
        // (iii) Z ← Z - 1, (Z) ← Rr
        generic_indexed_store(cpu, .z, info.r, 0, .post_incr);
    }

    /// ST (STD) – Store Indirect From Register to Data Space using Index Z
    inline fn stz_iv(cpu: *Cpu, info: isa.opinfo.q6r5) void {
        // (iv) (Z+q) ← Rr
        generic_indexed_store(cpu, .z, info.r, info.q, .displace);
    }

    /// SPM – Store Program Memory
    ///
    /// SPM can be used to erase a page in the Program memory, to write a page in the Program memory (that
    /// is already erased), and to set Boot Loader Lock bits. In some devices, the Program memory can be
    /// written one word at a time, in other devices an entire page can be programmed simultaneously after first
    /// filling a temporary page buffer. In all cases, the Program memory must be erased one page at a time.
    /// When erasing the Program memory, the RAMPZ and Z-register are used as page address. When writing
    /// the Program memory, the RAMPZ and Z-register are used as page or word address, and the R1:R0
    /// register pair is used as data(1). When setting the Boot Loader Lock bits, the R1:R0 register pair is used as
    /// data. Refer to the device documentation for detailed description of SPM usage. This instruction can
    /// address the entire Program memory.
    /// The SPM instruction is not available in all devices. Refer to the device specific instruction set summary.
    ///
    /// **NOTE:** 1. R1 determines the instruction high byte, and R0 determines the instruction low byte.
    ///
    ///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
    inline fn spm_i(cpu: *Cpu) void {
        _ = cpu;
        @panic("spm (i) is not supported.");
    }

    /// SPM #2 – Store Program Memory
    ///
    /// SPM can be used to erase a page in the Program memory and to write a page in the Program memory
    /// (that is already erased). An entire page can be programmed simultaneously after first filling a temporary
    /// page buffer. The Program memory must be erased one page at a time. When erasing the Program
    /// memory, the RAMPZ and Z-register are used as page address. When writing the Program memory, the
    /// RAMPZ and Z-register are used as page or word address, and the R1:R0 register pair is used as data(1).
    /// Refer to the device documentation for detailed description of SPM usage. This instruction can address
    /// the entire Program memory.
    ///
    /// **NOTE:** 1. R1 determines the instruction high byte, and R0 determines the instruction low byte.
    ///
    ///! TODO! (implement much later, we don't really need it for emulating everything execpt bootloaders)
    inline fn spm_ii(cpu: *Cpu) void {
        _ = cpu;
        @panic("spm #2 is not supported.");
    }

    /// STS – Store Direct to Data Space
    ///
    /// Stores one byte from a Register to the data space. For parts with SRAM, the data space consists of the
    /// Register File, I/O memory, and internal SRAM (and external SRAM if applicable). For parts without
    /// SRAM, the data space consists of the Register File only. The EEPROM has a separate address space.
    /// A 16-bit address must be supplied. Memory access is limited to the current data segment of 64KB. The
    /// STS instruction uses the RAMPD Register to access memory above 64KB. To access another data
    /// segment in devices with more than 64KB data space, the RAMPD in register in the I/O area has to be
    /// changed.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    ///
    /// NOTE: 32 bit instruction!
    inline fn sts(cpu: *Cpu, info: isa.opinfo.d5) void {
        // (k) ← Rr
        const addr = cpu.extendDirectAddress(cpu.fetchCode());
        cpu.sram.write(addr, cpu.regs[info.d.num()]);
    }

    /// PUSH – Push Register on Stack
    /// This instruction stores the contents of register Rr on the STACK. The Stack Pointer is post-decremented
    /// by 1 after the PUSH.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn push(cpu: *Cpu, info: isa.opinfo.d5) void {
        // STACK ← Rr
        cpu.push(cpu.regs[info.d.num()]);
    }

    // Status Register

    /// BCLR – Bit Clear in SREG
    /// Clears a single Flag in SREG.
    inline fn bclr(cpu: *Cpu, info: isa.opinfo.s3) void {
        // SREG(s) ← 0
        cpu.sreg.writeBit(info.s, false);
    }

    /// BSET – Bit Set in SREG
    /// Sets a single Flag or bit in SREG.
    inline fn bset(cpu: *Cpu, info: isa.opinfo.s3) void {
        // SREG(s) ← 1
        cpu.sreg.writeBit(info.s, true);
    }

    /// BLD – Bit Load from the T Flag in SREG to a Bit in Register
    /// Copies the T Flag in the SREG (Status Register) to bit b in register Rd.
    inline fn bld(cpu: *Cpu, info: isa.opinfo.b3d5) void {
        // Rd(b) ← T
        changeBit(&cpu.regs[info.d.num()], info.b.num(), cpu.sreg.t);
    }

    /// BST – Bit Store from Bit in Register to T Flag in SREG
    /// Stores bit b from Rd to the T Flag in SREG (Status Register).
    inline fn bst(cpu: *Cpu, info: isa.opinfo.b3d5) void {
        // T ← Rd(b)
        cpu.sreg.t = (cpu.regs[info.d.num()] & info.b.mask()) != 0;
    }

    // Others:

    /// BREAK – Break
    /// The BREAK instruction is used by the On-chip Debug system, and is normally not used in the application
    /// software. When the BREAK instruction is executed, the AVR CPU is set in the Stopped Mode. This gives
    /// the On-chip Debugger access to internal resources.
    /// If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat
    /// the BREAK instruction as a NOP and will not enter the Stopped mode.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn @"break"(cpu: *Cpu) void {
        // On-chip Debug system break.
        cpu.instr_effect = .breakpoint;
    }

    /// DES – Data Encryption Standard
    ///
    /// Tshe module is an instruction set extension to the AVR CPU, performing DES iterations. The 64-bit data
    /// block (plaintext or ciphertext) is placed in the CPU register file, registers R0-R7, where LSB of data is
    /// placed in LSB of R0 and MSB of data is placed in MSB of R7. The full 64-bit key (including parity bits) is
    /// placed in registers R8-R15, organized in the register file with LSB of key in LSB of R8 and MSB of key in
    /// MSB of R15. Executing one DES instruction performs one round in the DES algorithm. Sixteen rounds
    /// must be executed in increasing order to form the correct DES ciphertext or plaintext. Intermediate results
    /// are stored in the register file (R0-R15) after each DES instruction. The instruction's operand (K)
    /// determines which round is executed, and the half carry flag (H) determines whether encryption or
    /// decryption is performed.
    /// The DES algorithm is described in “Specifications for the Data Encryption Standard” (Federal Information
    /// Processing Standards Publication 46). Intermediate results in this implementation differ from the standard
    /// because the initial permutation and the inverse initial permutation are performed in each iteration. This
    /// does not affect the result in the final ciphertext or plaintext, but reduces the execution time.
    ///
    /// TODO! (Not necessarily required for implementation, very weird use case)
    inline fn des(cpu: *Cpu, info: isa.opinfo.k4) void {
        _ = cpu;
        _ = info;
        @panic("TODO: Implement DES instruction!");
    }

    /// NOP – No Operation
    /// This instruction performs a single cycle No Operation.
    inline fn nop(cpu: *Cpu) void {
        _ = cpu;
    }

    /// SLEEP
    /// This instruction sets the circuit in sleep mode defined by the MCU Control Register.
    inline fn sleep(cpu: *Cpu) void {
        // Refer to the device documentation for detailed description of SLEEP usage.
        cpu.instr_effect = .sleep;
    }

    /// WDR – Watchdog Reset
    /// This instruction resets the Watchdog Timer. This instruction must be executed within a limited time given
    /// by the WD prescaler. See the Watchdog Timer hardware specification.
    inline fn wdr(cpu: *Cpu) void {
        // WD timer restart.
        cpu.instr_effect = .watchdog_reset;
    }
};

pub const SREG = packed struct(u8) {
    /// Carry Flag
    /// This flag is set when there is a carry in an arithmetic or logic operation, and is cleared otherwise.
    c: bool,

    /// Zero Flag
    /// This flag is set when there is a zero result in an arithmetic or logic operation, and is cleared otherwise.
    z: bool,

    /// Negative Flag
    /// This flag is set when there is a negative result in an arithmetic or logic operation, and is cleared otherwise.
    n: bool,

    /// Two’s Complement Overflow Flag
    /// This flag is set when there is an overflow in arithmetic operations that support this, and is cleared otherwise
    v: bool,

    /// Sign Flag
    /// This flag is always an Exclusive Or (XOR) between the Negative flag (N) and the Two’s Complement Overflow flag (V).
    s: bool,

    /// Half Carry Flag
    /// This flag is set when there is a half carry in arithmetic operations that support this, and is cleared otherwise. Half
    /// carry is useful in BCD arithmetic.
    h: bool,

    /// Transfer Bit
    /// The bit copy instructions, Bit Load (BLD) and Bit Store (BST), use the T bit as source or destination for the operated
    /// bit.
    t: bool,

    /// Global Interrupt Enable
    /// Writing a ‘1’ to this bit enables interrupts on the device.
    /// Writing a ‘0’ to this bit disables interrupts on the device, independent of the individual interrupt enable settings of the
    /// peripherals.
    /// This bit is not cleared by hardware while entering an Interrupt Service Routine (ISR) or set when the RETI instruction
    /// is executed.
    /// This bit can be set and cleared by software with the SEI and CLI instructions.
    /// Changing the I bit through the I/O register results in a one-cycle Wait state on the access.
    i: bool,

    pub fn readBit(sreg: SREG, bit: isa.StatusRegisterBit) bool {
        const val: u8 = @bitCast(sreg);
        return (bit.mask() & val) != 0;
    }

    pub fn writeBit(sreg: *SREG, bit: isa.StatusRegisterBit, value: bool) void {
        var val: u8 = @bitCast(sreg.*);
        changeBit(&val, bit.num(), value);
        sreg.* = @bitCast(val);
    }

    pub fn format(sreg: SREG, fmt: []const u8, opt: std.fmt.FormatOptions, writer: anytype) !void {
        _ = opt;
        _ = fmt;
        try writer.print("[{c}{c}{c}{c}{c}{c}{c}{c}]", .{
            if (sreg.c) @as(u8, 'C') else '-',
            if (sreg.z) @as(u8, 'Z') else '-',
            if (sreg.n) @as(u8, 'N') else '-',
            if (sreg.v) @as(u8, 'V') else '-',
            if (sreg.s) @as(u8, 'S') else '-',
            if (sreg.h) @as(u8, 'H') else '-',
            if (sreg.t) @as(u8, 'T') else '-',
            if (sreg.i) @as(u8, 'I') else '-',
        });
    }
};

const Bits8 = packed struct(u8) {
    b0: bool,
    b1: bool,
    b2: bool,
    b3: bool,
    b4: bool,
    b5: bool,
    b6: bool,
    b7: bool,
};

inline fn bval(b: u3) u8 {
    return @as(u8, 1) << b;
}

inline fn changeBit(dst: *u8, bit: u3, val: bool) void {
    if (val) {
        dst.* |= bval(bit);
    } else {
        dst.* &= ~bval(bit);
    }
}

pub const SpecialIoRegisters = struct {
    /// Register concatenated with the X-registers enabling indirect addressing of the whole data
    /// space on MCUs with more than 64KB data space, and constant data fetch on MCUs with more than
    /// 64KB program space.
    ramp_x: ?IO.Address,

    /// Register concatenated with the Y-registers enabling indirect addressing of the whole data
    /// space on MCUs with more than 64KB data space, and constant data fetch on MCUs with more than
    /// 64KB program space.
    ramp_y: ?IO.Address,

    /// Register concatenated with the Z-registers enabling indirect addressing of the whole data
    /// space on MCUs with more than 64KB data space, and constant data fetch on MCUs with more than
    /// 64KB program space.
    ramp_z: ?IO.Address,

    /// Register concatenated with the Z-register enabling direct addressing of the whole data space on MCUs
    /// with more than 64KB data space.
    ramp_d: ?IO.Address,

    /// Register concatenated with the Z-register enabling indirect jump and call to the whole program space on
    /// MCUs with more than 64K words (128KB) program space.
    e_ind: ?IO.Address,

    sp_l: IO.Address, // SP[7:0]
    sp_h: IO.Address, // SP[15:8]

    sreg: IO.Address,
};

fn extendDirectAddress(cpu: *Cpu, value: u16) u24 {
    return value | if (cpu.sio.ramp_d) |ramp_d|
        @as(u24, cpu.io.read(ramp_d)) << 16
    else
        0;
}

fn getSP(cpu: *Cpu) u16 {
    const lo = cpu.io.read(cpu.sio.sp_l);
    const hi = cpu.io.read(cpu.sio.sp_h);

    return (@as(u16, hi) << 8) | lo;
}

fn setSP(cpu: *Cpu, value: u16) void {
    const lo: u8 = @truncate(value >> 0);
    const hi: u8 = @truncate(value >> 8);

    cpu.io.write(cpu.sio.sp_l, lo);
    cpu.io.write(cpu.sio.sp_h, hi);
}

fn compose24(hi: u8, mid: u8, lo: u8) u24 {
    return (@as(u24, hi) << 16) |
        (@as(u24, mid) << 8) |
        (@as(u24, lo) << 0);
}

fn decompose24(value: u24) [3]u8 {
    return [3]u8{
        @truncate(value >> 0),
        @truncate(value >> 8),
        @truncate(value >> 16),
    };
}

fn compose16(hi: u8, lo: u8) u16 {
    return (@as(u16, hi) << 8) | (@as(u16, lo) << 0);
}

fn decompose16(value: u16) [2]u8 {
    return [2]u8{
        @truncate(value >> 0),
        @truncate(value >> 8),
    };
}

fn fmtInstruction(inst: isa.Instruction) std.fmt.Formatter(formatInstruction) {
    return .{ .data = inst };
}

fn formatInstruction(inst: isa.Instruction, fmt: []const u8, opt: std.fmt.FormatOptions, writer: anytype) !void {
    _ = opt;
    _ = fmt;
    try writer.print(" {s: <8}", .{@tagName(inst)});

    switch (inst) {
        inline else => |args| {
            const T = @TypeOf(args);
            if (T != void) {
                const info = @typeInfo(T).Struct;

                inline for (info.fields, 0..) |fld, i| {
                    if (i > 0) {
                        try writer.writeAll(", ");
                    }
                    try writer.print("{s}={}", .{ fld.name, @field(args, fld.name) });
                }
            }
        },
    }
}
