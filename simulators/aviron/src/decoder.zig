const std = @import("std");
const isa = @import("isa");
const tables = @import("autogen-tables");

pub const Opcode = isa.Opcode;
pub const Instruction = tables.Instruction;
pub const opinfo = isa.opinfo;

pub const Register4 = isa.Register4;
pub const Register = isa.Register;

/// Only decodes one instruction; make sure to decode the second word for lds, sts, jmp, call
pub fn decode(inst_val: u16) !Instruction {
    const lookup: []const isa.Opcode = &tables.lookup;
    const opcode = lookup[inst_val];
    switch (opcode) {
        inline else => |tag| {
            @setEvalBranchQuota(10_000);

            const Result = std.meta.FieldType(Instruction, tag);
            if (Result == void) {
                return @unionInit(Instruction, @tagName(tag), {});
            }

            const positionals = @field(tables.positionals, @tagName(tag));
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
                const name = &[1]u8{pos[0]};

                const raw = @bitReverse(bitsets[i].mask);

                const Dst = @TypeOf(@field(result, name));
                @field(result, name) = switch (@typeInfo(Dst)) {
                    .Enum => @enumFromInt(raw),
                    else => raw,
                };
            }

            return @unionInit(Instruction, @tagName(tag), result);
        },
    }
}
