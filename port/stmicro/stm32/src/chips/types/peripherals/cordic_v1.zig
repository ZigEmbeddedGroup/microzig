const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const FUNC = enum(u4) {
    /// Cosine function.
    Cosine = 0x0,
    /// Sine function.
    Sine = 0x1,
    /// Phase function.
    Phase = 0x2,
    /// Modulus function.
    Modulus = 0x3,
    /// Arctangent function.
    Arctangent = 0x4,
    /// Hyperbolic Cosine function.
    HyperbolicCosine = 0x5,
    /// Hyperbolic Sine function.
    HyperbolicSine = 0x6,
    /// Arctanh function.
    Arctanh = 0x7,
    /// Natural Logarithm function.
    NaturalLogarithm = 0x8,
    /// Square Root function.
    SquareRoot = 0x9,
    _,
};

pub const Num = enum(u1) {
    /// 1 input/output
    Num1 = 0x0,
    /// 2 input/output
    Num2 = 0x1,
};

pub const PRECISION = enum(u4) {
    /// 4 iterations.
    Iters4 = 0x1,
    /// 8 iterations.
    Iters8 = 0x2,
    /// 12 iterations.
    Iters12 = 0x3,
    /// 16 iterations.
    Iters16 = 0x4,
    /// 20 iterations.
    Iters20 = 0x5,
    /// 24 iterations.
    Iters24 = 0x6,
    /// 28 iterations.
    Iters28 = 0x7,
    /// 32 iterations.
    Iters32 = 0x8,
    /// 36 iterations.
    Iters36 = 0x9,
    /// 40 iterations.
    Iters40 = 0xa,
    /// 44 iterations.
    Iters44 = 0xb,
    /// 48 iterations.
    Iters48 = 0xc,
    /// 52 iterations.
    Iters52 = 0xd,
    /// 56 iterations.
    Iters56 = 0xe,
    /// 60 iterations.
    Iters60 = 0xf,
    _,
};

pub const Scale = enum(u3) {
    /// Argument multiplied by 1, result multiplied by 1
    A1_R1 = 0x0,
    /// Argument multiplied by 1/2, result multiplied by 2
    A1o2_R2 = 0x1,
    /// Argument multiplied by 1/4, result multiplied by 4
    A1o4_R4 = 0x2,
    /// Argument multiplied by 1/8, result multiplied by 8
    A1o8_R8 = 0x3,
    /// Argument multiplied by 1/16, result multiplied by 16
    A1o16_R16 = 0x4,
    /// Argument multiplied by 1/32, result multiplied by 32
    A1o32_R32 = 0x5,
    /// Argument multiplied by 1/64, result multiplied by 64
    A1o64_R64 = 0x6,
    /// Argument multiplied by 1/128, result multiplied by 128
    A1o128_R128 = 0x7,
};

pub const Size = enum(u1) {
    /// Use 32 bit input/output values.
    Bits32 = 0x0,
    /// Use 16 bit input/output values.
    Bits16 = 0x1,
};

/// CORDIC co-processor.
pub const CORDIC = extern struct {
    /// Control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Function.
        FUNC: FUNC,
        /// Precision required (number of iterations/cycles), where PRECISION = (number of iterations/4).
        PRECISION: PRECISION,
        /// Scaling factor. Input value has been multiplied by 2^(-n) before for argument. Output value will need to be multiplied by 2^n later for results.
        SCALE: Scale,
        reserved16: u5 = 0,
        /// Enable interrupt.
        IEN: u1,
        /// Enable DMA wread channel.
        DMAREN: u1,
        /// Enable DMA write channel.
        DMAWEN: u1,
        /// Number of results in the RDATA register.
        NRES: Num,
        /// Number of arguments expected by the WDATA register.
        NARGS: Num,
        /// Width of output data.
        RESSIZE: Size,
        /// Width of input data.
        ARGSIZE: Size,
        reserved31: u8 = 0,
        /// Result ready flag.
        RRDY: u1,
    }),
    /// Argument register.
    /// offset: 0x04
    WDATA: u32,
    /// Result register.
    /// offset: 0x08
    RDATA: u32,
};
