//! MSP430 is 2-byte aligned for the stack. It must be aligned at all times.
//!
//! Clock cycles for the instruction are dependent on instruction format and
//! addressing modes.

pub const CPU = enum {
    msp430,
    msp430x,
};

/// Object code files with different memory models may not be linked together.
///
/// Memory is little-endian only
pub const MemoryModel = enum {
    // Code and data are restricted to the lower 64KB memory. Code and Data
    // pointers are 16-bits.
    small,
    // 20-bit pointers
    restricted,
    // 20-bit pointers
    large,
};

pub const CodeModel = enum {
    // 16-bit pointers, restricted to lower 64KB memory.
    small,
    // 20-bit pointers.
    large,
};

/// R12 through R15 are used to pass arguments. For special cases R8 through R11
/// are used as well.
pub const Register = enum(u4) {
    /// Program Counter
    pc,
    /// Call Stack Pointer
    sp,
    /// Status Register
    sr,
    /// Constant Generator Register
    cg,

    // All numeric values are valid
    _,

    pub const CalleePreserved = enum {
        yes,
        no,
        na,
    };

    pub fn callee_preserved(r: Register) CalleePreserved {
        return switch (@intFromEnum(r)) {
            0, 2, 3 => .na,
            1, 4, 5, 6, 7, 8, 9, 10 => .yes,
            11, 12, 13, 14, 15 => .no,
        };
    }
};

pub const MSP430_Core = struct {
    regs: Registers(16),
};

pub const MSP430X_Core = struct {
    regs: Registers(20),
};

pub fn Registers(comptime bits: usize) type {
    return [16]@Int(.unsigned, bits);
}

pub const Instruction = enum {
    // MSP430X only. Push consecutive registers to the stack.
    pushm,
    // MSP430X only. Pop consecutive registers to the stack.
    popm,

    call,
    calla,

    ret,
    reta,
    reti,

    adc,
    add,
    addc,
    @"and",
    bic,
    bis,
    bit,
    br,
    clr,
    clrc,
    clrn,
    clrz,
    cmp,
    dadc,
    dadd,
    dec,
    decd,
    dint,
    eint,
    inc,
    incd,
    inv,
    jc,
    jhs,
    jz,
    jeq,
    jge,
    jl,
    jmp,
    jn,
    jnc,
    jlo,
    jne,
    jnz,
    mov,
    nop,
    pop,
    push,
    rla,
    rlc,
    rra,
    rrc,
    sbc,
    setc,
    setn,
    setz,
    sub,
    subc,
    swpb,
    sxt,
    tst,
    xor,

    pub fn compatible(insn: Instruction, cpu: CPU) bool {
        return switch (insn) {
            .pushm, .popm => (cpu == .msp430x),
            else => unreachable,
        };
    }

    pub fn emulated(insn: Instruction) bool {
        return switch (insn) {
            .adc,
            .br,
            .clr,
            .clrc,
            .clrn,
            .clrz,
            .dadc,
            .dec,
            .decd,
            .dint,
            .eint,
            .inc,
            .incd,
            .inv,
            .nop,
            .pop,
            .ret,
            .rla,
            .rlc,
            .sbc,
            .setc,
            .setn,
            .setz,
            .tst,
            => true,
            else => false,
        };
    }
};

pub const AddressingMode = enum {
    /// Syntax: Rn
    ///
    /// Register contents are operand
    register,
    /// Syntax: X(Rn)
    ///
    /// (Rn + X) points to operand. X is stored in the next word.
    indexed,
    /// Syntax: ADDR
    ///
    /// (PC + X) points to the operand. X is stored in the next word. Indexed
    /// mode X(PC) is used.
    symbolic,
    /// Syntax: &ADDR
    ///
    /// The word following the instruction contains the absolute address.
    absolute,
    /// Syntax: @Rn
    ///
    /// Rn is used as a pointer to the operand.
    indirect_register,
    /// Syntax: @Rn+
    ///
    /// Rn is used as a pointer to the operand, and is incremented afterwards.
    indirect_autoincrement,
    /// Syntax: #N
    ///
    /// The word following the instruction contains the immediate constant N.
    /// Indirect Autoincrement @PC+ is used.
    immediate,
};
