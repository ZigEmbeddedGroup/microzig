pub fn MMIO(comptime addr: usize, comptime IntT: type, comptime PackedT: type) type {
    return struct {
        pub fn underlaying_type() type {
            return PackedT;
        }
        pub fn ptr() *volatile IntT {
            return @intToPtr(*volatile IntT, addr);
        }
        pub fn read() PackedT {
            const intValue = ptr().*;
            return @bitCast(PackedT, intValue);
        }

        pub fn write(val: PackedT) void {
            const intValue = @bitCast(IntT, val);
            ptr().* = intValue;
        }
        pub fn set(fields: anytype) void {
            var val = read();
            inline for (@typeInfo(@TypeOf(fields)).Struct.fields) |field| {
                @field(val, field.name) = @field(fields, field.name);
            }
            write(val);
        }
        pub const get = read;
        pub fn toggle(fields: anytype) void {
            var val = read();
            inline for (@typeInfo(@TypeOf(fields)).Struct.fields) |field| {
                @field(val, field.name) = !@field(val, field.name);
            }
            write(val);
        }
    };
}
