const std = @import("std");

pub const Opcode = enum(u8) {
    @"and",
    @"break",
    @"or",
    adc,
    add,
    adiw,
    andi,
    asr,
    bclr,
    bld,
    brbc,
    brbs,
    bset,
    bst,
    call,
    cbi,
    com,
    cp,
    cpc,
    cpi,
    cpse,
    dec,
    des,
    eicall,
    eijmp,
    elpm_i,
    elpm_ii,
    elpm_iii,
    eor,
    fmul,
    fmuls,
    fmulsu,
    icall,
    ijmp,
    in,
    inc,
    jmp,
    lac,
    las,
    lat,
    ldi,
    lds,
    ldx_i,
    ldx_ii,
    ldx_iii,
    // ldy_i is the same as ldy_iv
    ldy_ii,
    ldy_iii,
    ldy_iv,
    // ldz_i is the same as ldz_iv
    ldz_ii,
    ldz_iii,
    ldz_iv,
    lpm_i,
    lpm_ii,
    lpm_iii,
    lsr,
    mov,
    movw,
    mul,
    muls,
    mulsu,
    neg,
    nop,
    ori,
    out,
    pop,
    push,
    rcall,
    ret,
    reti,
    rjmp,
    ror,
    sbc,
    sbci,
    sbi,
    sbic,
    sbis,
    sbiw,
    sbrc,
    sbrs,
    sleep,
    spm_i,
    spm_ii,
    sts,
    stx_i,
    stx_ii,
    stx_iii,
    sty_ii,
    sty_iii,
    sty_iv,
    stz_ii,
    stz_iii,
    stz_iv,
    sub,
    subi,
    swap,
    wdr,
    xch,

    unknown,
};

pub const opinfo = struct {
    pub const a6d5 = struct { a: u6, d: Register };
    pub const a6r5 = struct { a: u6, r: Register };
    pub const a5b3 = struct { a: u5, b: DataBit };
    pub const b3d5 = struct { b: DataBit, d: Register };
    pub const b3r5 = struct { b: DataBit, r: Register };
    pub const d5 = struct { d: Register };
    pub const d5k16 = struct { d: Register, k: u16 };
    pub const d5q6 = struct { d: Register, q: u6 };
    pub const d5r5 = struct { d: Register, r: Register };
    pub const d4k8 = struct { d: Register4, k: u8 };
    pub const d4r4 = struct { d: u4, r: u4 };
    pub const d3r3 = struct { d: u3, r: u3 };
    pub const d2k6 = struct { d: u2, k: u6 };
    pub const k4 = struct { k: u4 };
    pub const k6 = struct { k: u6 };
    pub const k12 = struct { k: u12 };
    pub const k22 = struct { k: u22 };
    pub const k7s3 = struct { k: u7, s: StatusRegisterBit };
    pub const q6r5 = struct { q: u6, r: Register };
    pub const r5 = struct { r: Register };
    pub const s3 = struct { s: StatusRegisterBit };
};

pub const Register4 = enum(u4) {
    _,

    pub fn format(reg4: Register4, fmt: []const u8, opt: std.fmt.FormatOptions, writer: anytype) !void {
        _ = opt;
        _ = fmt;
        try writer.print("r{}", .{
            16 + @as(u32, @intFromEnum(reg4)),
        });
    }

    /// Returns the numeric value of this value.
    pub fn int(r4: Register4) u4 {
        return @intFromEnum(r4);
    }

    /// Returns the register number.
    pub fn num(r4: Register4) u5 {
        return 16 + @as(u5, @intFromEnum(r4));
    }

    pub fn reg(r4: Register4) Register {
        return @enumFromInt(r4.num());
    }
};

pub const Register = enum(u5) {
    _,

    pub fn format(reg5: Register, fmt: []const u8, opt: std.fmt.FormatOptions, writer: anytype) !void {
        _ = opt;
        _ = fmt;
        try writer.print("r{}", .{@intFromEnum(reg5)});
    }

    /// Returns the numeric value of this value.
    pub fn int(r5: Register) u5 {
        return @intFromEnum(r5);
    }

    /// Returns the register number.
    pub fn num(r5: Register) u5 {
        return @intFromEnum(r5);
    }
};

pub const StatusRegisterBit = enum(u3) {
    C = 0,
    Z = 1,
    N = 2,
    V = 3,
    S = 4,
    H = 5,
    T = 6,
    I = 7,

    pub fn format(bit: StatusRegisterBit, fmt: []const u8, opt: std.fmt.FormatOptions, writer: anytype) !void {
        _ = opt;
        _ = fmt;
        try writer.print("{s}", .{@tagName(bit)});
    }

    /// Returns the bit index.
    pub fn num(bit: StatusRegisterBit) u3 {
        return @intFromEnum(bit);
    }

    /// Returns the bit mask.
    pub fn mask(bit: StatusRegisterBit) u8 {
        return @as(u8, 1) << @intFromEnum(bit);
    }
};

pub const DataBit = enum(u3) {
    _,

    pub fn format(bit: DataBit, fmt: []const u8, opt: std.fmt.FormatOptions, writer: anytype) !void {
        _ = opt;
        _ = fmt;
        try writer.print("{}", .{@intFromEnum(bit)});
    }

    /// Returns the bit index.
    pub fn num(bit: DataBit) u3 {
        return @intFromEnum(bit);
    }

    /// Returns the bit mask.
    pub fn mask(bit: DataBit) u8 {
        return @as(u8, 1) << @intFromEnum(bit);
    }
};
