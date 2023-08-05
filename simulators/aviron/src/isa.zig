const std = @import("std");
const tables = @import("tables.zig");

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

    unknown,
};

pub const Instruction = union(Opcode) {
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

    unknown,
};

// const opcode_to_format = blk: {
//     @setEvalBranchQuota(10_000);
//     var arr = std.EnumArray(Opcode, []const u8).initUndefined();

//     var lit = std.mem.split(u8, isa, "\n");
//     while (lit.next()) |line| {
//         var pit = std.mem.split(u8, line, " ");
//         arr.set(@field(Opcode, pit.next().?), std.mem.trim(u8, pit.rest(), &std.ascii.whitespace));
//     }

//     break :blk arr;
// };

// fn BitExtractInputType(comptime fmt: []const u8) type {
//     return @
// }

// pub fn bitExtract(comptime fmt: []const u8, value: BitExtractInputType(fmt), out: anytype)

// @TypeOf(reader).Error
pub fn decode(reader: anytype) !Instruction {
    const inst = tables.lookup[try reader.readIntLittle(u16)];
    switch (inst) {
        inline .lds, .sts, .jmp, .call => |tag| {
            _ = try reader.readIntLittle(u16);
            return @unionInit(Instruction, @tagName(tag), {});
        },
        inline else => |tag| {
            @setEvalBranchQuota(10_000);
            if (std.meta.FieldType(Instruction, tag) == void)
                return @unionInit(Instruction, @tagName(tag), {});

            // const format = comptime opcode_to_format.get(tag);

            // comptime var chars_counter = std.StaticBitSet(256).initEmpty();
            // comptime var chars_count = std.BoundedArray(u8, 256).init(0) catch unreachable;
            // comptime chars_count.appendNTimes(0, 256) catch unreachable;

            // comptime for (format) |c|
            //     switch (c) {
            //         ' ', '0', '1' => {},
            //         else => {
            //             chars_counter.set(c);
            //             chars_count.slice()[c] += 1;
            //         },
            //     };

            // comptime var fields: [chars_counter.count()]std.builtin.Type.StructField = undefined;
            // comptime var index: usize = 0;
            // comptime var iterator = chars_counter.iterator(.{});
            // comptime while (iterator.next()) |v| : (index += 1) {
            //     const Bitset = std.bit_set.IntegerBitSet(chars_count.get(v));
            //     const T = struct {
            //         index: u8 = 0,
            //         bitset: Bitset = Bitset.initEmpty(),
            //     };

            //     fields[index] = .{
            //         .name = &[1]u8{v},
            //         .type = T,
            //         .default_value = &T{},
            //         .is_comptime = false,
            //         .alignment = 0,
            //     };
            // };

            // const Bitsets = @Type(.{
            //     .Struct = .{
            //         .layout = .Auto,
            //         .is_tuple = false,
            //         .fields = &fields,
            //         .decls = &[0]std.builtin.Type.Declaration{},
            //     },
            // });

            // var source = std.bit_set.IntegerBitSet(16).initEmpty();
            // source.mask = @intFromEnum(inst);

            // var bitsets = Bitsets{};

            // var result: std.meta.FieldType(Instruction, tag) = undefined;

            // var f_index: u8 = 0;
            // inline for (format) |c| {
            //     if (c == ' ') continue;

            //     if (c != '0' and c != '1') {
            //         var field = &@field(bitsets, &[1]u8{c});
            //         field.bitset.setValue(field.index, source.isSet(f_index));
            //         field.index += 1;
            //     }

            //     f_index += 1;
            // }

            // inline for (std.meta.fields(@TypeOf(result))) |field| {
            //     @field(result, field.name) = @field(bitsets, field.name).bitset.mask;
            // }

            // return @unionInit(Instruction, @tagName(tag), result);
        },
    }
}
