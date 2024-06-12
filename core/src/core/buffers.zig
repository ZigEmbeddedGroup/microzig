const std = @import("std");
const builtin = @import("builtin");

pub const BufferWriter = struct {
    buffer: []u8,
    pos: usize = 0,
    endian: std.builtin.Endian = builtin.cpu.arch.endian(),

    pub const Error = error{ EndOfBuffer };

    /// Moves forward write cursor by the provided number of bytes.
    pub fn advance(self: *@This(), bytes: usize) Error!void {
        try self.bound_check(bytes);
        self.advance_unsafe(bytes);
    }

    /// Writes data provided as a slice to the buffer and moves write cursor forward by data size.
    pub fn write(self: *@This(), data: []const u8) Error!void {
        try self.bound_check(data.len);
        defer self.advance_unsafe(data.len);
        @memcpy(self.buffer[self.pos..self.pos + data.len], data);
    }

    /// Writes an int with respect to the buffer's endianness and moves write cursor forward by int size.
    pub fn write_int(self: *@This(), comptime T: type, value: T) Error!void {
        const size = @divExact(@typeInfo(T).Int.bits, 8);
        try self.bound_check(size);
        defer self.advance_unsafe(size);
        std.mem.writeInt(T, self.buffer[self.pos..][0..size], value, self.endian);
    }

    /// Writes an int with respect to the buffer's endianness but skip bound check.
    /// Useful in cases where the bound can be checked once for batch of ints.
    pub fn write_int_unsafe(self: *@This(), comptime T: type, value: T) void {
        const size = @divExact(@typeInfo(T).Int.bits, 8);
        defer self.advance_unsafe(size);
        std.mem.writeInt(T, self.buffer[self.pos..][0..size], value, self.endian);
    }

    /// Returns a slice of the internal buffer containing the written data.
    pub fn get_written_slice(self: *const @This()) []const u8 {
        return self.buffer[0..self.pos];
    }

    /// Performs a buffer bound check against the current cursor position and the provided number of bytes to check forward.
    pub fn bound_check(self: *const @This(), bytes: usize) Error!void {
        if (self.pos + bytes > self.buffer.len) return error.EndOfBuffer;
    }

    fn advance_unsafe(self: *@This(), bytes: usize) void {
        self.pos += bytes;
    }
};

pub const BufferReader = struct {
    buffer: []const u8,
    pos: usize = 0,
    endian: std.builtin.Endian = builtin.cpu.arch.endian(),

    /// Attempts to move read cursor forward by the specified number of bytes.
    /// Returns the actual number of bytes advanced, up to the specified number.
    pub fn try_advance(self: *@This(), bytes: usize) usize {
        const size = @min(bytes, self.buffer.len - self.pos);
        self.advance_unsafe(size);
        return size;
    }

    /// Attempts to read the given amount of bytes (or less if close to buffer end) and advances the read cursor.
    pub fn try_read(self: *@This(), bytes: usize) []const u8 {
        const size = @min(bytes, self.buffer.len - self.pos);
        defer self.advance_unsafe(size);
        return self.buffer[self.pos..self.pos + size];
    }

    /// Attempts to read the given amount of bytes (or less if close to buffer end) without advancing the read cursor.
    pub fn try_peek(self: *@This(), bytes: usize) []const u8 {
        const size = @min(bytes, self.buffer.len - self.pos);
        return self.buffer[self.pos..self.pos + size];
    }

    /// Returns the number of bytes remaining from the current read cursor position to the end of the underlying buffer.
    pub fn get_remaining_bytes_count(self: *const @This()) usize {
        return self.buffer.len - self.pos;
    }

    fn advance_unsafe(self: *@This(), bytes: usize) void {
        self.pos += bytes;
    }
};