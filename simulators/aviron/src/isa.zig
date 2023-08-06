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

pub const Instruction = blk: {
    var fields: [tables.positionals.len]std.builtin.Type.UnionField = undefined;

    inline for (tables.positionals, 0..) |pos, i| {
        const T = if (pos.len == 0) void else tblk: {
            var struct_fields: [pos.len]std.builtin.Type.StructField = undefined;

            inline for (pos, 0..) |p, ii| {
                struct_fields[ii] = .{
                    .name = &[1]u8{p[0]},
                    .type = @Type(.{ .Int = .{ .signedness = .unsigned, .bits = p[1].len } }),
                    .default_value = null,
                    .is_comptime = false,
                    .alignment = 0,
                };
            }

            break :tblk @Type(.{
                .Struct = .{
                    .layout = .Auto,
                    .fields = &struct_fields,
                    .decls = &[0]std.builtin.Type.Declaration{},
                    .is_tuple = false,
                },
            });
        };

        fields[i] = .{
            .name = @tagName(@as(Opcode, @enumFromInt(i))),
            .type = T,
            .alignment = 0,
        };
    }

    break :blk @Type(.{
        .Union = .{
            .layout = .Auto,
            .tag_type = Opcode,
            .fields = &fields,
            .decls = &[0]std.builtin.Type.Declaration{},
        },
    });
};

/// Only decodes one instruction; make sure to decode the second word for lds, sts, jmp, call
pub fn decode(inst_val: u16) !Instruction {
    const opcode = tables.lookup[inst_val];
    switch (opcode) {
        inline else => |tag| {
            @setEvalBranchQuota(10_000);

            const Result = std.meta.FieldType(Instruction, tag);
            if (Result == void)
                return @unionInit(Instruction, @tagName(tag), {});

            const positionals = tables.positionals[@intFromEnum(tag)];
            const Bitsets = std.meta.Tuple(types: {
                var bs_types: [positionals.len]type = undefined;
                inline for (positionals, 0..) |pos, i| {
                    bs_types[i] = std.bit_set.IntegerBitSet(pos[1].len);
                }
                break :types &bs_types;
            });

            var bitsets: Bitsets = undefined;
            inline for (&bitsets) |*bs| {
                bs.* = @TypeOf(bs.*).initEmpty();
            }

            var bitset = std.bit_set.IntegerBitSet(16).initEmpty();
            bitset.mask = @bitReverse(inst_val);

            var result: Result = undefined;
            inline for (positionals, 0..) |pos, i| {
                inline for (pos[1], 0..) |p, ii| {
                    bitsets[i].setValue(ii, bitset.isSet(p));
                }
                @field(result, &[1]u8{pos[0]}) = @bitReverse(bitsets[i].mask);
            }

            return @unionInit(Instruction, @tagName(tag), result);
        },
    }
}
