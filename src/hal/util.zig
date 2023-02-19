pub fn xor_alias(ptr: anytype) @TypeOf(ptr) {
    const xor_addr = @ptrToInt(ptr) | (1 << 12);
    return @ptrCast(@TypeOf(ptr), xor_addr);
}

pub fn set_alias(ptr: anytype) @TypeOf(ptr) {
    const set_addr = @ptrToInt(ptr) | (2 << 12);
    return @ptrCast(@TypeOf(ptr), set_addr);
}

pub fn clear_alias(ptr: anytype) @TypeOf(ptr) {
    const clear_addr = @ptrToInt(ptr) | (3 << 12);
    return @ptrCast(@TypeOf(ptr), clear_addr);
}

pub inline fn tight_loop_contents() void {
    asm volatile ("" ::: "memory");
}
