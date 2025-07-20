const std = @import("std");
const assert = std.debug.assert;

const Chip = @import("../chip.zig").Chip;
const tokenizer = @import("assembler/tokenizer.zig");
const encoder = @import("assembler/encoder.zig");

pub const TokenizeOptions = tokenizer.Options;
pub const EncodeOptions = encoder.Options;

pub const Define = struct {
    name: []const u8,
    value: i64,
};

pub const Program = struct {
    name: []const u8,
    defines: []const Define,
    instructions: []const u16,
    origin: ?u5,
    side_set: ?encoder.SideSet,
    wrap_target: ?u5,
    wrap: ?u5,

    pub fn get_mask(program: Program) u32 {
        return (@as(u32, 1) << @as(u5, @intCast(program.instructions.len))) - 1;
    }
};

pub const Output = struct {
    defines: []const Define,
    programs: []const Program,

    pub fn get_program_by_name(
        comptime output: Output,
        comptime name: []const u8,
    ) Program {
        return for (output.programs) |program| {
            if (std.mem.eql(u8, name, program.name))
                break program;
        } else @panic(std.fmt.comptimePrint("program '{s}' not found", .{name}));
    }

    pub fn get_define_by_name(
        comptime output: Output,
        comptime name: []const u8,
    ) u32 {
        return for (output.defines) |define| {
            if (std.mem.eql(u8, define.name, define))
                break define;
        } else @panic(std.fmt.comptimePrint("define '{s}' not found", .{name}));
    }
};

pub const AssembleOptions = struct {
    tokenize: TokenizeOptions = .{},
    encode: EncodeOptions = .{},
};

pub const Diagnostics = struct {
    message: std.BoundedArray(u8, 256),
    index: u32,

    pub fn init(index: u32, comptime fmt: []const u8, args: anytype) Diagnostics {
        var ret = Diagnostics{
            .message = std.BoundedArray(u8, 256).init(0) catch unreachable,
            .index = index,
        };

        ret.message.writer().print(fmt, args) catch unreachable;
        return ret;
    }
};

pub fn assemble_impl(comptime chip: Chip, comptime source: []const u8, diags: *?Diagnostics, options: AssembleOptions) !Output {
    const tokens = try tokenizer.tokenize(chip, source, diags, options.tokenize);
    const encoder_output = try encoder.encode(chip, tokens.slice(), diags, options.encode);
    var programs = std.BoundedArray(Program, options.encode.max_programs).init(0) catch unreachable;
    for (encoder_output.programs.slice()) |bounded|
        try programs.append(bounded.to_exported_program());

    const program_copy = programs.buffer[0..programs.len].*;

    return Output{
        .defines = blk: {
            var tmp = std.BoundedArray(Define, options.encode.max_defines).init(0) catch unreachable;
            for (encoder_output.global_defines.slice()) |define|
                tmp.append(.{
                    .name = define.name,
                    .value = define.value,
                }) catch unreachable;
            const copy = tmp.buffer[0..tmp.len].*;
            break :blk &copy;
        },
        .programs = &program_copy,
    };
}

fn format_compile_error(comptime message: []const u8, comptime source: []const u8, comptime index: u32) []const u8 {
    var line_str: []const u8 = "";
    var line_num: u32 = 1;
    var column: u32 = 0;
    var line_it = std.mem.tokenizeAny(u8, source, "\n\r");
    while (line_it.next()) |line| : (line_num += 1) {
        line_str = line_str ++ "\n" ++ line;
        if (line_it.index >= index) {
            column = line.len - (line_it.index - index);
            line_str = line;
            break;
        }
    }

    return std.fmt.comptimePrint(
        \\failed to assemble PIO code:
        \\
        \\{s}
        \\{s}^
        \\{s}{s}
        \\
    , .{
        line_str,
        [_]u8{' '} ** column,
        [_]u8{' '} ** column,
        message,
    });
}

pub fn assemble(comptime chip: Chip, comptime source: []const u8, comptime options: AssembleOptions) Output {
    var diags: ?Diagnostics = null;
    return assemble_impl(chip, source, &diags, options) catch |err| {
        if (diags) |d|
            @compileError(format_compile_error(d.message.slice(), source, d.index));
        @compileError(@errorName(err));
    };
}

test "tokenizer and encoder" {
    std.testing.refAllDecls(tokenizer);
    std.testing.refAllDecls(@import("assembler/Expression.zig"));
    std.testing.refAllDecls(encoder);
}

test "comparison" {
    std.testing.refAllDecls(@import("assembler/comparison_tests.zig"));
}

test "assemble" {
    // Test that the assembler can compile a simple program
    // this also verifies that the assemble function can be compiled
    _ = comptime assemble(.RP2040, ".program testprog", .{})
        .get_program_by_name("testprog");
}

test "format compile error" {
    const result = comptime format_compile_error(
        "invalid instruction",
        ".program testprog\n bad",
        19,
    );
    try std.testing.expectEqualStrings(
        \\failed to assemble PIO code:
        \\
        \\ bad
        \\ ^
        \\ invalid instruction
        \\
    , result);
}
