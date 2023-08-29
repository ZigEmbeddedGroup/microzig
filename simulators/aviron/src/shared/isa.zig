const std = @import("std");

pub const Opcode = enum(u8) {
    movw,
    muls,
    nop,
    mulsu,
    fmul,
    fmuls,
    fmulsu,
    cpc,
    sbc,
    add,
    cpse,
    cp,
    sub,
    adc,
    @"and",
    eor,
    @"or",
    mov,
    cpi,
    sbci,
    subi,
    ori,
    andi,
    lds,
    ldz_ii,
    ldz_iii,
    lpm_ii,
    lpm_iii,
    elpm_ii,
    elpm_iii,
    ldy_ii,
    ldy_iii,
    ldx_i,
    ldx_ii,
    ldx_iii,
    pop,
    sts,
    push,
    stz_ii,
    stz_iii,
    xch,
    las,
    lac,
    lat,
    sty_ii,
    sty_iii,
    stx_i,
    stx_ii,
    stx_iii,
    ijmp,
    eijmp,
    bset,
    bclr,
    des,
    ret,
    icall,
    reti,
    eicall,
    sleep,
    wdr,
    lpm_i,
    elpm_i,
    spm_i,
    spm_ii,
    com,
    neg,
    swap,
    inc,
    asr,
    lsr,
    ror,
    dec,
    jmp,
    call,
    adiw,
    sbiw,
    cbi,
    sbic,
    sbi,
    sbis,
    mul,
    in,
    out,
    ldz_iv,
    ldy_iv,
    stz_iv,
    sty_iv,
    rcall,
    ldi,
    brbs,
    brbc,
    bld,
    bst,
    sbrc,
    sbrs,
    rjmp,
    @"break",

    unknown,
};

pub const opinfo = struct {
    pub const a6d5 = struct { a: u6, d: u5 };
    pub const a6r5 = struct { a: u6, r: u5 };
    pub const a5b3 = struct { a: u5, b: u3 };
    pub const b3d5 = struct { b: u3, d: u5 };
    pub const b3r5 = struct { b: u3, r: u5 };
    pub const d5 = struct { d: u5 };
    pub const d5k16 = struct { d: u5, k: u16 };
    pub const d5q6 = struct { d: u5, q: u6 };
    pub const d5r5 = struct { d: u5, r: u5 };
    pub const d4k8 = struct { d: u4, k: u8 };
    pub const d4r4 = struct { d: u4, r: u4 };
    pub const d3r3 = struct { d: u3, r: u3 };
    pub const d2k6 = struct { d: u2, k: u6 };
    pub const k4 = struct { k: u4 };
    pub const k6 = struct { k: u6 };
    pub const k12 = struct { k: u12 };
    pub const k22 = struct { k: u22 };
    pub const k7s3 = struct { k: u7, s: u3 };
    pub const q6r5 = struct { q: u6, r: u5 };
    pub const r5 = struct { r: u5 };
    pub const s3 = struct { s: u3 };
};
