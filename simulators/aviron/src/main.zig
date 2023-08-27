const std = @import("std");
pub const isa = @import("isa.zig");
pub const Cpu = @import("Cpu.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const argv = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, argv);

    if (argv.len != 2) @panic("usage: aviron <elf>");

    // Emulate Atmega382p device size:
    var flash_storage = Cpu.Flash.Static(32768){};
    var sram = Cpu.RAM.Static(2048){};
    var eeprom = Cpu.RAM.Static(1024){};
    var io = IO{};

    {
        var elf_file = try std.fs.cwd().openFile(argv[1], .{});
        defer elf_file.close();

        var source = std.io.StreamSource{ .file = elf_file };
        var header = try std.elf.Header.read(&source);

        var pheaders = header.program_header_iterator(&source);
        while (try pheaders.next()) |phdr| {
            if ((phdr.p_flags & std.elf.PT_LOAD) == 0)
                continue; // Header isn't lodead

            try source.seekTo(phdr.p_offset);
            try source.reader().readNoEof(flash_storage.data[phdr.p_paddr..][0..phdr.p_filesz]);
        }
    }

    var cpu = Cpu{
        .flash = flash_storage.memory(),
        .sram = sram.memory(),
        .eeprom = eeprom.memory(),
        .io = io.memory(),
    };

    try cpu.run(null);
}

const IO = struct {
    pub fn memory(self: *IO) Cpu.IO {
        return Cpu.IO{
            .ctx = self,
            .vtable = &vtable,
        };
    }

    pub const vtable = Cpu.IO.VTable{
        .readFn = read,
        .writeFn = write,
    };

    // This is our own "debug" device with it's own debug addresses:
    const Register = enum(u6) {
        exit = 0, // read: 0, write: os.exit()
        stdout = 1, // read: 0, write: print to stdout
        stderr = 2, // read: 0, write: print to stderr

        _,
    };

    fn read(ctx: ?*anyopaque, addr: u6) u8 {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        _ = io;
        return switch (reg) {
            .exit => 0,
            .stdout => 0,
            .stderr => 0,
            _ => std.debug.panic("illegal i/o read from undefined register 0x{X:0>2}", .{addr}),
        };
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    fn write(ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        _ = io;
        switch (reg) {
            .exit => std.os.exit(value & mask),
            .stdout => std.io.getStdOut().writer().writeByte(value & mask) catch @panic("i/o failure"),
            .stderr => std.io.getStdErr().writer().writeByte(value & mask) catch @panic("i/o failure"),

            _ => std.debug.panic("illegal i/o write to undefined register 0x{X:0>2} with value=0x{X:0>2}, mask=0x{X:0>2}", .{ addr, value, mask }),
        }
    }
};
