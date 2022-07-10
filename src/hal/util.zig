pub fn xorAlias(ptr: anytype) @TypeOf(ptr) {
    const xor_addr = @ptrToInt(ptr) | (1 << 12);
    return @ptrCast(@TypeOf(ptr), xor_addr);
}

pub fn setAlias(ptr: anytype) @TypeOf(ptr) {
    const set_addr = @ptrToInt(ptr) | (2 << 12);
    return @ptrCast(@TypeOf(ptr), set_addr);
}

pub fn clearAlias(ptr: anytype) @TypeOf(ptr) {
    const clear_addr = @ptrToInt(ptr) | (3 << 12);
    return @ptrCast(@TypeOf(ptr), clear_addr);
}

pub inline fn tightLoopContents() void {
    asm volatile ("" ::: "memory");
}
