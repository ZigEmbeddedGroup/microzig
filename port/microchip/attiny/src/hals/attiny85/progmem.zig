pub fn Table(comptime T: type, comptime len: usize, comptime values: [len]T) type {
    return struct {
        pub const data linksection(".progmem.data") = values;

        pub inline fn get(index: usize) T {
            return read(T, &data[index]);
        }
    };
}

pub inline fn read(comptime T: type, ptr: *const T) T {
    return ptr.*;
}

pub inline fn read_byte(ptr: *const u8) u8 {
    return read(u8, ptr);
}

pub inline fn read_word(ptr: *const u16) u16 {
    return read(u16, ptr);
}
