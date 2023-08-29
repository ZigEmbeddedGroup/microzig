const std = @import("std");
const isa = @import("decoder.zig");

const Cpu = @This();

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

instr_effect: InstructionEffect = .none,

pc: u24 = 0,
regs: [32]u8 = [1]u8{0} ** 32,
sreg: SREG = @bitCast(@as(u8, 0)),

flash: Flash,
sram: RAM,
eeprom: EEPROM,
io: IO,

pub fn getIndirectAddressRegister(cpu: *Cpu, which: enum { x, y, z }) *u16 {
    return @ptrCast(cpu.regs[26 + @intFromEnum(which) * 2][0..2]);
}

pub fn shiftProgramCounter(cpu: *Cpu, by: i12) void {
    cpu.pc = @intCast(@as(i32, @intCast(cpu.pc)) + by);
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

    while (true) : (cpu.pc += 1) {
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

        const inst = try isa.decode(cpu.flash.read(cpu.pc));
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

fn regBase16(r: u4) u5 {
    return @as(u5, r) | 0x10;
}

const instructions = struct {
    // Copy:

    /// MOV – Copy Register
    /// This instruction makes a copy of one register into another. The source register Rr is left unchanged, while
    /// the destination register Rd is loaded with a copy of Rr.
    inline fn mov(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rr
        cpu.regs[info.d] = cpu.regs[info.r];
    }

    /// MOVW – Copy Register Word
    /// This instruction makes a copy of one register pair into another register pair. The source register pair Rr
    /// +1:Rr is left unchanged, while the destination register pair Rd+1:Rd is loaded with a copy of Rr + 1:Rr.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn movw(cpu: *Cpu, info: isa.opinfo.d4r4) void {
        // d ∈ {0,2,...,30}, r ∈ {0,2,...,30
        const Rd = @as(u5, info.d) << 1;
        const Rr = @as(u5, info.r) << 1;

        // Rd+1:Rd ← Rr+1:Rr
        cpu.regs[Rd + 0] = cpu.regs[Rr + 0];
        cpu.regs[Rd + 1] = cpu.regs[Rr + 1];
    }

    /// SWAP – Swap Nibbles
    /// Swaps high and low nibbles in a register.
    inline fn swap(cpu: *Cpu, info: isa.opinfo.d5) void {
        const Nibbles = packed struct(u8) { low: u4, high: u4 };

        // R(7:4) ← Rd(3:0), R(3:0) ← Rd(7:4)
        const src: Nibbles = @bitCast(cpu.regs[info.d]);
        const dst = Nibbles{ .low = src.high, .high = src.low };
        cpu.regs[info.d] = @bitCast(dst);
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
        return perform_logic(cpu, info.d, cpu.regs[info.r], .@"and");
    }

    /// EOR – Exclusive OR
    /// Performs the logical EOR between the contents of register Rd and register Rr and places the result in the
    /// destination register Rd.
    inline fn eor(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd
        return perform_logic(cpu, info.d, cpu.regs[info.r], .xor);
    }

    /// OR – Logical OR
    /// Performs the logical OR between the contents of register Rd and register Rr, and places the result in the
    /// destination register Rd.
    inline fn @"or"(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd v Rr
        return perform_logic(cpu, info.d, cpu.regs[info.r], .@"or");
    }

    /// ANDI – Logical AND with Immediate
    /// Performs the logical AND between the contents of register Rd and a constant, and places the result in the
    /// destination register Rd.
    inline fn andi(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd • K
        return perform_logic(cpu, info.d, info.k, .@"and");
    }

    /// ORI – Logical OR with Immediate
    /// Performs the logical OR between the contents of register Rd and a constant, and places the result in the
    /// destination register Rd
    inline fn ori(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd v K
        return perform_logic(cpu, info.d, info.k, .@"or");
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

        const src = cpu.regs[info.d];

        const res = src +% 1;

        cpu.regs[info.d] = res;

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

        const src = cpu.regs[info.d];

        const res = src -% 1;

        cpu.regs[info.d] = res;

        cpu.sreg.z = (res == 0);
        cpu.sreg.v = (src == 0x80);
        cpu.sreg.n = (res & 0x80) != 0;
        cpu.sreg.s = (cpu.sreg.n != cpu.sreg.v);
    }

    inline fn generic_add(cpu: *Cpu, info: isa.opinfo.d5r5, c: bool) void {
        const lhs = cpu.regs[info.d];
        const Rd: Bits8 = @bitCast(lhs);
        const rhs = cpu.regs[info.r];
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
    inline fn generic_sub_cp(cpu: *Cpu, d: u5, _rhs: u8, comptime conf: SubCpConfig) void {
        const lhs: u8 = if (conf.flip) _rhs else cpu.regs[d];
        const rhs: u8 = if (conf.flip) cpu.regs[d] else _rhs;
        const Rd: Bits8 = @bitCast(lhs);
        const Rr: Bits8 = @bitCast(rhs);
        const result: u8 = if (conf.carry)
            lhs -% rhs -% @intFromBool(cpu.sreg.c)
        else
            lhs -% rhs;
        const R: Bits8 = @bitCast(result);

        if (conf.writeback) {
            cpu.regs[d] = result;
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
            .clear_only => cpu.sreg.z = cpu.sreg.z and z,
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
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r], SubCpConfig.sub);
    }

    /// SUBI – Subtract Immediate
    /// Subtracts a register and a constant, and places the result in the destination register Rd. This instruction is
    /// working on Register R16 to R31 and is very well suited for operations on the X, Y, and Z-pointers.
    inline fn subi(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd - K
        return generic_sub_cp(cpu, regBase16(info.d), info.k, SubCpConfig.sub);
    }

    /// SBC – Subtract with Carry
    /// Subtracts two registers and subtracts with the C Flag, and places the result in the destination register Rd.
    inline fn sbc(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // Rd ← Rd - Rr - C
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r], SubCpConfig.sbc);
    }

    /// SBCI – Subtract Immediate with Carry SBI
    /// Subtracts a constant from a register and subtracts with the C Flag, and places the result in the destination
    /// register Rd.
    inline fn sbci(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // Rd ← Rd - K - C
        return generic_sub_cp(cpu, regBase16(info.d), info.k, SubCpConfig.sbc);
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
        const src = cpu.regs[info.d];

        const res: u8 = 0xFF - src;

        cpu.regs[info.d] = res;

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

    /// TODO!
    inline fn mul(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        _ = cpu;
        std.debug.print("mul {}\n", .{info});
        @panic("mul not implemented yet!");
    }

    /// TODO!
    inline fn muls(cpu: *Cpu, info: isa.opinfo.d4r4) void {
        _ = cpu;
        std.debug.print("muls {}\n", .{info});
        @panic("muls not implemented yet!");
    }

    /// TODO!
    inline fn mulsu(cpu: *Cpu, info: isa.opinfo.d3r3) void {
        _ = cpu;
        std.debug.print("mulsu {}\n", .{info});
        @panic("mulsu not implemented yet!");
    }

    // Wide ALU Arithmetic:

    /// TODO!
    /// ADIW – Add Immediate to Word
    /// Adds an immediate value (0 - 63) to a register pair and places the result in the register pair. This
    /// instruction operates on the upper four register pairs, and is well suited for operations on the pointer
    /// registers.
    ///
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn adiw(cpu: *Cpu, info: isa.opinfo.d2k6) void {
        // Rd+1:Rd ← Rd+1:Rd + K
        _ = cpu;
        std.debug.print("adiw {}\n", .{info});
        @panic("adiw not implemented yet!");
    }

    /// TODO!
    /// SBIW – Subtract Immediate from Word
    /// Subtracts an immediate value (0-63) from a register pair and places the result in the register pair. This
    /// instruction operates on the upper four register pairs, and is well suited for operations on the Pointer
    /// Registers.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn sbiw(cpu: *Cpu, info: isa.opinfo.d2k6) void {
        // Rd+1:Rd ← Rd+1:Rd - K
        _ = cpu;
        std.debug.print("sbiw {}\n", .{info});
        @panic("sbiw not implemented yet!");
    }

    // ALU Shifts

    const ShiftConfig = struct {
        msb: enum { sticky, carry, zero },
    };
    inline fn generic_shift(cpu: *Cpu, info: isa.opinfo.d5, comptime conf: ShiftConfig) void {
        const src: u8 = cpu.regs[info.d];

        const msb: u8 = switch (conf.msb) {
            .zero => 0x00,
            .carry => if (cpu.sreg.c) 0x80 else 0x00,
            .sticky => (src & 0x80),
        };
        const res: u8 = (src >> 7) | msb;

        cpu.regs[info.d] = res;

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
        cpu.io.write(info.a, 0xFF, cpu.regs[info.r]);
    }

    /// IN - Load an I/O Location to Register
    /// Loads data from the I/O Space (Ports, Timers, Configuration Registers, etc.) into register Rd in the Register File.
    inline fn in(cpu: *Cpu, info: isa.opinfo.a6d5) void {
        // Rd ← I/O(A)
        cpu.regs[info.d] = cpu.io.read(info.a);
    }

    /// CBI – Clear Bit in I/O Register
    /// Clears a specified bit in an I/O register. This instruction operates on the lower 32 I/O registers –
    /// addresses 0-31.
    inline fn cbi(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // I/O(A,b) ← 0
        cpu.io.write(info.a, bval(info.b), 0x00);
    }

    /// SBI – Set Bit in I/O Register
    /// Sets a specified bit in an I/O Register. This instruction operates on the lower 32 I/O Registers – addresses 0-31.
    inline fn sbi(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // I/O(A,b) ← 1
        cpu.io.write(info.a, bval(info.b), @as(u8, 1) << info.b);
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
        if ((val & bval(info.b)) == 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// SBIS – Skip if Bit in I/O Register is Set
    /// This instruction tests a single bit in an I/O Register and skips the next instruction if the bit is set. This
    /// instruction operates on the lower 32 I/O Registers – addresses 0-31.
    inline fn sbis(cpu: *Cpu, info: isa.opinfo.a5b3) void {
        // If I/O(A,b) = 1 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.io.read(info.a);
        if ((val & bval(info.b)) != 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// SBRC – Skip if Bit in Register is Cleared
    /// This instruction tests a single bit in a register and skips the next instruction if the bit is cleared.
    inline fn sbrc(cpu: *Cpu, info: isa.opinfo.b3r5) void {
        // If Rr(b) = 0 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.regs[info.r];
        if ((val & bval(info.b)) == 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// SBRS – Skip if Bit in Register is Set
    /// This instruction tests a single bit in a register and skips the next instruction if the bit is set.
    inline fn sbrs(cpu: *Cpu, info: isa.opinfo.b3r5) void {
        // If Rr(b) = 1 then PC ← PC + 2 (or 3) else PC ← PC + 1
        const val = cpu.regs[info.r];
        if ((val & bval(info.b)) != 0) {
            cpu.instr_effect = .skip_next;
        }
    }

    /// This instruction performs a compare between two registers Rd and Rr, and skips the next instruction if Rd = Rr.
    inline fn cpse(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // If Rd = Rr then PC ← PC + 2 (or 3) else PC ← PC + 1

        const Rd = cpu.regs[info.d];
        const Rr = cpu.regs[info.r];
        if (Rd == Rr) {
            cpu.instr_effect = .skip_next;
        }
    }

    // Jumps

    /// JMP – Jump
    /// Jump to an address within the entire 4M (words) Program memory. See also RJMP.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn jmp(cpu: *Cpu, info: isa.opinfo.k6) void {
        // PC ← k
        cpu.pc = info.k;
    }

    /// TODO!
    inline fn rjmp(cpu: *Cpu, bits: isa.opinfo.k12) void {
        cpu.shiftProgramCounter(@as(i12, @bitCast(bits.k)));
    }

    /// TODO!
    inline fn rcall(cpu: *Cpu, info: isa.opinfo.k12) void {
        _ = cpu;
        std.debug.print("rcall {}\n", .{info});
        @panic("rcall not implemented yet!");
    }

    /// TODO!
    inline fn ret(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("ret\n", .{});
        @panic("ret not implemented yet!");
    }

    /// TODO!
    inline fn reti(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("reti\n", .{});
        @panic("reti not implemented yet!");
    }

    /// TODO!
    /// Calls to a subroutine within the entire Program memory. The return address (to the instruction after the
    /// CALL) will be stored onto the Stack. (See also RCALL). The Stack Pointer uses a post-decrement
    /// scheme during CALL.
    /// This instruction is not available in all devices. Refer to the device specific instruction set summary.
    inline fn call(cpu: *Cpu, info: isa.opinfo.k6) void {
        _ = cpu;
        std.debug.print("call {}\n", .{info});
        @panic("call not implemented yet!");
    }

    /// TODO!
    inline fn icall(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("icall\n", .{});
        @panic("icall not implemented yet!");
    }

    /// TODO!
    inline fn ijmp(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("ijmp\n", .{});
        @panic("ijmp not implemented yet!");
    }

    /// TODO!
    inline fn eicall(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("eicall\n", .{});
        @panic("eicall not implemented yet!");
    }

    /// TODO!
    inline fn eijmp(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("eijmp\n", .{});
        @panic("eijmp not implemented yet!");
    }

    // Comparisons
    /// This instruction performs a compare between two registers Rd and Rr.
    /// None of the registers are changed.
    /// All conditional branches can be used after this instruction.
    inline fn cp(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // (1) Rd - Rr
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r], SubCpConfig.cp);
    }

    /// This instruction performs a compare between two registers Rd and Rr and also takes into account the
    /// previous carry.
    /// None of the registers are changed.
    /// All conditional branches can be used after this instruction.
    inline fn cpc(cpu: *Cpu, info: isa.opinfo.d5r5) void {
        // (1) Rd - Rr - C
        return generic_sub_cp(cpu, info.d, cpu.regs[info.r], SubCpConfig.cpc);
    }

    /// This instruction performs a compare between register Rd and a constant.
    /// The register is not changed.
    /// All conditional branches can be used after this instruction.
    inline fn cpi(cpu: *Cpu, info: isa.opinfo.d4k8) void {
        // (1) Rd - K
        return generic_sub_cp(cpu, regBase16(info.d), info.k, SubCpConfig.cp);
    }

    // Loads

    /// LDI – Load Immediate
    /// Loads an 8-bit constant directly to register 16 to 31.
    inline fn ldi(cpu: *Cpu, bits: isa.opinfo.d4k8) void {
        // Rd ← K
        cpu.regs[regBase16(bits.d)] = bits.k;
    }

    /// TODO!
    /// XCH – Exchange
    /// Exchanges one byte indirect between register and data space.
    /// The data location is pointed to by the Z (16 bits) Pointer Register in the Register File. Memory access is
    /// limited to the current data segment of 64KB. To access another data segment in devices with more than
    /// 64KB data space, the RAMPZ in register in the I/O area has to be changed.
    /// The Z-pointer Register is left unchanged by the operation. This instruction is especially suited for writing/
    /// reading status bits stored in SRAM.
    inline fn xch(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("xch {}\n", .{info});
        @panic("xch not implemented yet!");
    }

    /// TODO!
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
        _ = cpu;
        std.debug.print("lac {}\n", .{info});
        @panic("lac not implemented yet!");
    }

    /// TODO!
    inline fn las(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("las {}\n", .{info});
        @panic("las not implemented yet!");
    }

    /// TODO!
    inline fn lat(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("lat {}\n", .{info});
        @panic("lat not implemented yet!");
    }

    /// TODO!
    inline fn lds(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("lds {}\n", .{info});
        @panic("lds not implemented yet!");
    }

    /// TODO!
    inline fn ldx_i(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldx_i {}\n", .{info});
        @panic("ldx_i not implemented yet!");
    }

    /// TODO!
    inline fn ldx_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldx_ii {}\n", .{info});
        @panic("ldx_ii not implemented yet!");
    }

    /// TODO!
    inline fn ldx_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldx_iii {}\n", .{info});
        @panic("ldx_iii not implemented yet!");
    }

    /// TODO!
    inline fn ldy_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldy_ii {}\n", .{info});
        @panic("ldy_ii not implemented yet!");
    }

    /// TODO!
    inline fn ldy_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldy_iii {}\n", .{info});
        @panic("ldy_iii not implemented yet!");
    }

    /// TODO!
    inline fn ldy_iv(cpu: *Cpu, info: isa.opinfo.d5q6) void {
        _ = cpu;
        std.debug.print("ldy_iv {}\n", .{info});
        @panic("ldy_iv not implemented yet!");
    }

    /// TODO!
    inline fn ldz_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldz_ii {}\n", .{info});
        @panic("ldz_ii not implemented yet!");
    }

    /// TODO!
    inline fn ldz_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("ldz_iii {}\n", .{info});
        @panic("ldz_iii not implemented yet!");
    }

    /// TODO!
    inline fn ldz_iv(cpu: *Cpu, info: isa.opinfo.d5q6) void {
        _ = cpu;
        std.debug.print("ldz_iv {}\n", .{info});
        @panic("ldz_iv not implemented yet!");
    }

    /// TODO!
    inline fn lpm_i(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("lpm_i\n", .{});
        @panic("lpm_i not implemented yet!");
    }

    /// TODO!
    inline fn lpm_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("lpm_ii {}\n", .{info});
        @panic("lpm_ii not implemented yet!");
    }

    /// TODO!
    inline fn lpm_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("lpm_iii {}\n", .{info});
        @panic("lpm_iii not implemented yet!");
    }

    /// TODO!
    inline fn elpm_i(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("elpm_i\n", .{});
        @panic("elpm_i not implemented yet!");
    }

    /// TODO!
    inline fn elpm_ii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("elpm_ii {}\n", .{info});
        @panic("elpm_ii not implemented yet!");
    }

    /// TODO!
    inline fn elpm_iii(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("elpm_iii {}\n", .{info});
        @panic("elpm_iii not implemented yet!");
    }

    /// TODO!
    inline fn pop(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("pop {}\n", .{info});
        @panic("pop not implemented yet!");
    }

    // Stores:

    /// TODO!
    inline fn stx_i(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("stx_i {}\n", .{info});
        @panic("stx_i not implemented yet!");
    }

    /// TODO!
    inline fn stx_ii(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("stx_ii {}\n", .{info});
        @panic("stx_ii not implemented yet!");
    }

    /// TODO!
    inline fn stx_iii(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("stx_iii {}\n", .{info});
        @panic("stx_iii not implemented yet!");
    }

    /// TODO!
    inline fn sty_ii(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("sty_ii {}\n", .{info});
        @panic("sty_ii not implemented yet!");
    }

    /// TODO!
    inline fn sty_iii(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("sty_iii {}\n", .{info});
        @panic("sty_iii not implemented yet!");
    }

    /// TODO!
    inline fn sty_iv(cpu: *Cpu, info: isa.opinfo.q6r5) void {
        _ = cpu;
        std.debug.print("sty_iv {}\n", .{info});
        @panic("sty_iv not implemented yet!");
    }

    /// TODO!
    inline fn stz_ii(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("stz_ii {}\n", .{info});
        @panic("stz_ii not implemented yet!");
    }

    /// TODO!
    inline fn stz_iii(cpu: *Cpu, info: isa.opinfo.r5) void {
        _ = cpu;
        std.debug.print("stz_iii {}\n", .{info});
        @panic("stz_iii not implemented yet!");
    }

    /// TODO!
    inline fn stz_iv(cpu: *Cpu, info: isa.opinfo.q6r5) void {
        _ = cpu;
        std.debug.print("stz_iv {}\n", .{info});
        @panic("stz_iv not implemented yet!");
    }

    /// TODO!
    inline fn spm_i(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("spm_i\n", .{});
        @panic("spm_i not implemented yet!");
    }

    /// TODO!
    inline fn spm_ii(cpu: *Cpu) void {
        _ = cpu;
        std.debug.print("spm_ii\n", .{});
        @panic("spm_ii not implemented yet!");
    }

    /// TODO!
    inline fn sts(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("sts {}\n", .{info});
        @panic("sts not implemented yet!");
    }

    /// TODO!
    inline fn push(cpu: *Cpu, info: isa.opinfo.d5) void {
        _ = cpu;
        std.debug.print("push {}\n", .{info});
        @panic("push not implemented yet!");
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
        changeBit(&cpu.regs[info.d], info.b, cpu.sreg.t);
    }

    /// BST – Bit Store from Bit in Register to T Flag in SREG
    /// Stores bit b from Rd to the T Flag in SREG (Status Register).
    inline fn bst(cpu: *Cpu, info: isa.opinfo.b3d5) void {
        // T ← Rd(b)
        cpu.sreg.t = (cpu.regs[info.d] & bval(info.b)) != 0;
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

    /// TODO!
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

pub const Flash = struct {
    ctx: ?*anyopaque,
    vtable: *const VTable,
    size: usize,

    pub fn read(mem: Flash, addr: u24) u16 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u24) u16,
    };

    pub const empty = Flash{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = emptyRead },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u24) u16 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    pub fn Static(comptime size: comptime_int) type {
        if ((size & 1) != 0)
            @compileError("size must be a multiple of two!");
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn memory(self: *Self) Flash {
                return Flash{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{ .readFn = memRead };

            fn memRead(ctx: ?*anyopaque, addr: u24) u16 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return std.mem.bytesAsSlice(u16, &mem.data)[addr];
            }
        };
    }
};

pub const RAM = struct {
    ctx: ?*anyopaque,
    vtable: *const VTable,
    size: usize,

    pub fn read(mem: RAM, addr: u16) u8 {
        std.debug.assert(addr < mem.size);
        return mem.vtable.readFn(mem.ctx, addr);
    }

    pub fn write(mem: RAM, addr: u16, value: u8) void {
        std.debug.assert(addr < mem.size);
        return mem.vtable.writeFn(mem.ctx, addr, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u16) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: u16, value: u8) void,
    };

    pub const empty = RAM{
        .ctx = null,
        .size = 0,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u16) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: u16, value: u8) void {
        _ = value;
        _ = addr;
        _ = ctx;
    }

    pub fn Static(comptime size: comptime_int) type {
        return struct {
            const Self = @This();

            data: [size]u8 align(2) = .{0} ** size,

            pub fn memory(self: *Self) RAM {
                return RAM{
                    .ctx = self,
                    .vtable = &vtable,
                    .size = @divExact(size, 2),
                };
            }

            pub const vtable = VTable{
                .readFn = memRead,
                .writeFn = memWrite,
            };

            fn memRead(ctx: ?*anyopaque, addr: u16) u8 {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                return mem.data[addr];
            }

            fn memWrite(ctx: ?*anyopaque, addr: u16, value: u8) void {
                const mem: *Self = @ptrCast(@alignCast(ctx.?));
                mem.data[addr] = value;
            }
        };
    }
};

pub const EEPROM = RAM; // actually the same interface *shrug*

pub const IO = struct {
    ctx: ?*anyopaque,
    vtable: *const VTable,

    pub fn read(mem: IO, addr: u6) u8 {
        return mem.vtable.readFn(mem.ctx, addr);
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    pub fn write(mem: IO, addr: u6, mask: u8, value: u8) void {
        return mem.vtable.writeFn(mem.ctx, addr, mask, value);
    }

    pub const VTable = struct {
        readFn: *const fn (ctx: ?*anyopaque, addr: u6) u8,
        writeFn: *const fn (ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void,
    };

    pub const empty = IO{
        .ctx = null,
        .vtable = &VTable{ .readFn = emptyRead, .writeFn = emptyWrite },
    };

    fn emptyRead(ctx: ?*anyopaque, addr: u6) u8 {
        _ = addr;
        _ = ctx;
        return 0;
    }

    fn emptyWrite(ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void {
        _ = mask;
        _ = value;
        _ = addr;
        _ = ctx;
    }
};

pub const SREG = packed struct(u8) {
    /// Carry Flag
    c: bool,
    /// Zero Flag
    z: bool,
    /// Negative Flag
    n: bool,
    /// Two's Compliment Overflow Flag
    v: bool,
    /// Sign Flag, S = N xor V
    s: bool,
    /// Half Carry Flag
    h: bool,
    /// Copy Storage
    t: bool,
    /// Global Interrupt Enable
    i: bool,

    pub fn readBit(sreg: SREG, bit: u3) bool {
        const val: u8 = @bitCast(sreg);
        return (bval(bit) & val) != 0;
    }

    pub fn writeBit(sreg: *SREG, bit: u3, value: bool) void {
        var val: u8 = @bitCast(sreg.*);
        changeBit(&val, bit, value);
        sreg.* = @bitCast(val);
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
