//! Opinionated and maintainable flags library for MicroZig.
//!
//! - Flag arguments MUST precede positionals
//! - Flags must be started with `--`, as soon as this isn't the case the parser
//!   assumes it's a positional
//! - There must be an '=' joining the flag's label and its value. No spaces.
//! - If there are allocations they are saved to an arena.
const std = @import("std");
const Allocator = std.mem.Allocator;

const log = std.log.scoped(.flags);

/// Positionals are the arguments following any flags. Flags are of the form:
///
/// ```
/// --flag=<value>
/// --flag
/// ```
pub const Positionals = []const []const u8;

const label_prefix = "--";

/// Flags must have a `default` decl.
///
/// - Integers can use decimal, octal, or hexidecimal formats
pub fn parse(comptime Flags: type, arena: Allocator, args: []const []const u8) !struct { Flags, Positionals } {
    _ = arena;
    var flags: Flags = .default;
    return outer: for (args[1..], 1..) |arg, i| {
        if (!std.mem.startsWith(u8, arg, label_prefix))
            break .{ flags, args[i..] };

        const equals = std.mem.findScalar(u8, arg, '=');
        const key = arg[label_prefix.len .. equals orelse arg.len];
        const value = arg[if (equals) |eq| eq + 1 else arg.len..arg.len];
        inline for (@typeInfo(Flags).@"struct".fields) |field| {
            if (std.mem.eql(u8, key, field.name)) {
                @field(flags, field.name) = try parse_value(field.type, key, value, equals);
                continue :outer;
            }
        }

        log.err("Unrecognied CLI argument: {s}{s}", .{ label_prefix, key });
        return error.UnrecognizedCliArgument;
    } else .{ flags, &.{} };
}

fn parse_value(comptime T: type, key: []const u8, value: []const u8, equals: ?usize) !T {
    const field_info = @typeInfo(T);
    return switch (T) {
        []const u8 => value,
        else => switch (field_info) {
            .bool => if (equals != null) try parse_bool(value) else true,
            .int => |int| try std.fmt.parseInt(@Int(int.signedness, int.bits), value, 0),
            .optional => |optional| if (std.mem.eql(u8, value, "null"))
                null
            else
                try parse_value(optional.child, key, value, equals),
            .@"enum" => std.meta.stringToEnum(T, value) orelse {
                log.err("Invalid value for {s}: '{s}'", .{ key, value });
                return error.InvalidValue;
            },
            else => {
                @compileLog(field_info);
                @compileError("TODO");
            },
        },
    };
}

fn parse_bool(str: []const u8) !bool {
    return if (std.mem.eql(u8, str, "true"))
        true
    else if (std.mem.eql(u8, str, "false"))
        false
    else
        error.InvalidBoolStr;
}
