const std = @import("std");

pub fn mmio(addr: usize, comptime size: u8, comptime PackedT: type) *volatile Mmio(size, PackedT) {
    return @intToPtr(*volatile Mmio(size, PackedT), addr);
}

pub fn Mmio(comptime size: u8, comptime PackedT: type) type {
    if ((size % 8) != 0)
        @compileError("size must be divisible by 8!");

    if (!std.math.isPowerOfTwo(size / 8))
        @compileError("size must encode a power of two number of bytes!");

    const IntT = std.meta.Int(.unsigned, size);

    if (@sizeOf(PackedT) != (size / 8))
        @compileError(std.fmt.comptimePrint("IntT and PackedT must have the same size!, they are {} and {} bytes respectively", .{ size / 8, @sizeOf(PackedT) }));

    return extern struct {
        const Self = @This();

        raw: IntT,

        pub const underlying_type = PackedT;

        pub inline fn read(addr: *volatile Self) PackedT {
            return @bitCast(PackedT, addr.raw);
        }

        pub inline fn write(addr: *volatile Self, val: PackedT) void {
            // This is a workaround for a compiler bug related to miscompilation
            // If the tmp var is not used, result location will fuck things up
            var tmp = @bitCast(IntT, val);
            addr.raw = tmp;
        }

        pub inline fn modify(addr: *volatile Self, fields: anytype) void {
            var val = read(addr);
            inline for (@typeInfo(@TypeOf(fields)).Struct.fields) |field| {
                @field(val, field.name) = @field(fields, field.name);
            }
            write(addr, val);
        }

        pub inline fn toggle(addr: *volatile Self, fields: anytype) void {
            var val = read(addr);
            inline for (@typeInfo(@TypeOf(fields)).Struct.fields) |field| {
                @field(val, @tagName(field.default_value.?)) = !@field(val, @tagName(field.default_value.?));
            }
            write(addr, val);
        }
    };
}

pub fn MmioInt(comptime size: u8, comptime T: type) type {
    return extern struct {
        const Self = @This();

        raw: std.meta.Int(.unsigned, size),

        pub inline fn read(addr: *volatile Self) T {
            return @truncate(T, addr.raw);
        }

        pub inline fn modify(addr: *volatile Self, val: T) void {
            const Int = std.meta.Int(.unsigned, size);
            const mask = ~@as(Int, (1 << @bitSizeOf(T)) - 1);

            var tmp = addr.raw;
            addr.raw = (tmp & mask) | val;
        }
    };
}

pub fn mmioInt(addr: usize, comptime size: usize, comptime T: type) *volatile MmioInt(size, T) {
    return @intToPtr(*volatile MmioInt(size, T), addr);
}

pub const InterruptVector = extern union {
    C: fn () callconv(.C) void,
    Naked: fn () callconv(.Naked) void,
    // Interrupt is not supported on arm
};

const unhandled = InterruptVector{
    .C = struct {
        fn tmp() callconv(.C) noreturn {
            @panic("unhandled interrupt");
        }
    }.tmp,
};
