const std = @import("std");

const fmt = std.fmt;

pub const default = .{
    .string = string,
    .str = string,
    .u8 = int(u8, 0),
    .u16 = int(u16, 0),
    .u32 = int(u32, 0),
    .u64 = int(u64, 0),
    .usize = int(usize, 0),
    .i8 = int(i8, 0),
    .i16 = int(i16, 0),
    .i32 = int(i32, 0),
    .i64 = int(i64, 0),
    .isize = int(isize, 0),
    .f32 = float(f32),
    .f64 = float(f64),
};

pub fn string(in: []const u8) error{}![]const u8 {
    return in;
}

pub fn int(comptime T: type, comptime radix: u8) fn ([]const u8) fmt.ParseIntError!T {
    return struct {
        fn parse(in: []const u8) fmt.ParseIntError!T {
            return fmt.parseInt(T, in, radix);
        }
    }.parse;
}

pub fn float(comptime T: type) fn ([]const u8) fmt.ParseFloatError!T {
    return struct {
        fn parse(in: []const u8) fmt.ParseFloatError!T {
            return fmt.parseFloat(T, in);
        }
    }.parse;
}

fn ReturnType(comptime P: type) type {
    return @typeInfo(P).Fn.return_type.?;
}

pub fn Result(comptime P: type) type {
    return @typeInfo(ReturnType(P)).ErrorUnion.payload;
}
