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

/// Bit manipulations of the SR should be done by: MOV, BIS, BIC
pub const Status = packed struct(u16) {
    carry: bool,
    zero: bool,
    negative: bool,
    /// General Interrupt Enable
    gie: bool,
    /// When this bit is set, it turns off the CPU.
    cpuoff: bool,
    /// When this bit is set, it turnes off the LFXT1 crystal oscillator when
    /// LFXT1CLK is not used for MCLK or SMCLK
    oscoff: bool,
    /// System clock generator 0. Depends on device family.
    scg0: bool,
    /// System clock generator 1. Depends on device family.
    scg1: bool,
    overflow: bool,
};

// Interrupts
//
// - Vectored interrupts with no polling necessary
// - interrupt vectors are located downward from address 0xFFFE.
//
// During an interrupt, the PC and status register are pushed onto the stack. It
// stores the high bits of the PC appended to the SR value on the stack.
//
// When the RETI instruction is executed, the full 20-bit PC is restored making
// it return from the interrupt to any address in the memory range possible.

// The BR and CALL instructions reset the upper four PC bits to 0. only
// addresses in the lower 64KB address range can be reached with the BR or CALL
// instruction.
//
// Addresses beyond 64KB can only be reached using BRA or CALLA instructions.
//
// The PC is automatically stored on the stack with CALL or CALLA instructions
// and during an interrupt service routine. CALLA uses two words on the stack
// to store the 20-bit address, but CALL only needs one.
//
// The RETA instruction restores bits 19:0 of the PC and adds 4 to the stack
// pointer, the RET instruction restores bits 15:0 and adds 2.

// The 20-bit stack pointer is used by the CPU to store the return addresses of
// subroutine calls and interrupts.
//
// It uses a predecrement, postincrement scheme. The SP is initialized into RAM
// by the user and is always aligned to even addresses.

// Constant generator registers R2 and R3. The constants are selected using the
// addressing modes. They have things like 0, +4, +8. This way there's no code
// memory access required to retrieve the constant

// The 12 CPU registers contain 8, 16, or 20-bit values. Any byte write to a CPU
// register clears the upper bits. Same goes for a workd write.
//
// The only exception is the SXT instruction, which extends the sign through the
// entire register.

pub const DoubleOperandInstruction = packed struct(u16) {
    rdst: u4,
    as: u2,
    bw: u1,
    ad: u1,
    rsrc: u4,
    opcode: u4,
};

pub const SingleOperandInstruction = packed struct(u16) {
    rdst: u4,
    ad: u2,
    bw: u1,
    opcode: u9,
};

pub const JumpInstruction = packed struct(u16) { offset: i10, s: u1, condition: u3, opcode: u3 };
