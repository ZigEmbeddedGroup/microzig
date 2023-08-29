const std = @import("std");
pub const isa = @import("isa");
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
            if (phdr.p_type != std.elf.PT_LOAD)
                continue; // Header isn't lodead

            const dest_mem = if (phdr.p_vaddr >= 0x0080_0000)
                &sram.data
            else
                &flash_storage.data;

            const addr_masked: u24 = @intCast(phdr.p_vaddr & 0x007F_FFFF);

            try source.seekTo(phdr.p_offset);
            try source.reader().readNoEof(dest_mem[addr_masked..][0..phdr.p_filesz]);
            @memset(dest_mem[addr_masked + phdr.p_filesz ..][0 .. phdr.p_memsz - phdr.p_filesz], 0);
        }
    }

    var cpu = Cpu{
        .flash = flash_storage.memory(),
        .sram = sram.memory(),
        .eeprom = eeprom.memory(),
        .io = io.memory(),
    };

    const result = try cpu.run(null);

    std.debug.print("STOP: {s}\n", .{@tagName(result)});
}

const IO = struct {
    scratch_regs: [16]u8 = .{0} ** 16,

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
        stdio = 1, // read: stdin, write: print to stdout
        stderr = 2, // read: 0, write: print to stderr

        scratch_0 = 0x10, // scratch register
        scratch_1 = 0x11, // scratch register
        scratch_2 = 0x12, // scratch register
        scratch_3 = 0x13, // scratch register
        scratch_4 = 0x14, // scratch register
        scratch_5 = 0x15, // scratch register
        scratch_6 = 0x16, // scratch register
        scratch_7 = 0x17, // scratch register
        scratch_8 = 0x18, // scratch register
        scratch_9 = 0x19, // scratch register
        scratch_a = 0x1a, // scratch register
        scratch_b = 0x1b, // scratch register
        scratch_c = 0x1c, // scratch register
        scratch_d = 0x1d, // scratch register
        scratch_e = 0x1e, // scratch register
        scratch_f = 0x1f, // scratch register
        _,
    };

    fn read(ctx: ?*anyopaque, addr: u6) u8 {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        return switch (reg) {
            .exit => 0,
            .stdio => std.io.getStdIn().reader().readByte() catch 0xFF, // 0xFF = EOF
            .stderr => 0,

            .scratch_0 => io.scratch_regs[0x0],
            .scratch_1 => io.scratch_regs[0x1],
            .scratch_2 => io.scratch_regs[0x2],
            .scratch_3 => io.scratch_regs[0x3],
            .scratch_4 => io.scratch_regs[0x4],
            .scratch_5 => io.scratch_regs[0x5],
            .scratch_6 => io.scratch_regs[0x6],
            .scratch_7 => io.scratch_regs[0x7],
            .scratch_8 => io.scratch_regs[0x8],
            .scratch_9 => io.scratch_regs[0x9],
            .scratch_a => io.scratch_regs[0xa],
            .scratch_b => io.scratch_regs[0xb],
            .scratch_c => io.scratch_regs[0xc],
            .scratch_d => io.scratch_regs[0xd],
            .scratch_e => io.scratch_regs[0xe],
            .scratch_f => io.scratch_regs[0xf],

            _ => std.debug.panic("illegal i/o read from undefined register 0x{X:0>2}", .{addr}),
        };
    }

    /// `mask` determines which bits of `value` are written. To write everything, use `0xFF` for `mask`.
    fn write(ctx: ?*anyopaque, addr: u6, mask: u8, value: u8) void {
        const io: *IO = @ptrCast(@alignCast(ctx.?));
        const reg: Register = @enumFromInt(addr);
        switch (reg) {
            .exit => std.os.exit(value & mask),
            .stdio => std.io.getStdOut().writer().writeByte(value & mask) catch @panic("i/o failure"),
            .stderr => std.io.getStdErr().writer().writeByte(value & mask) catch @panic("i/o failure"),

            .scratch_0 => writeMasked(&io.scratch_regs[0x0], mask, value),
            .scratch_1 => writeMasked(&io.scratch_regs[0x1], mask, value),
            .scratch_2 => writeMasked(&io.scratch_regs[0x2], mask, value),
            .scratch_3 => writeMasked(&io.scratch_regs[0x3], mask, value),
            .scratch_4 => writeMasked(&io.scratch_regs[0x4], mask, value),
            .scratch_5 => writeMasked(&io.scratch_regs[0x5], mask, value),
            .scratch_6 => writeMasked(&io.scratch_regs[0x6], mask, value),
            .scratch_7 => writeMasked(&io.scratch_regs[0x7], mask, value),
            .scratch_8 => writeMasked(&io.scratch_regs[0x8], mask, value),
            .scratch_9 => writeMasked(&io.scratch_regs[0x9], mask, value),
            .scratch_a => writeMasked(&io.scratch_regs[0xa], mask, value),
            .scratch_b => writeMasked(&io.scratch_regs[0xb], mask, value),
            .scratch_c => writeMasked(&io.scratch_regs[0xc], mask, value),
            .scratch_d => writeMasked(&io.scratch_regs[0xd], mask, value),
            .scratch_e => writeMasked(&io.scratch_regs[0xe], mask, value),
            .scratch_f => writeMasked(&io.scratch_regs[0xf], mask, value),

            _ => std.debug.panic("illegal i/o write to undefined register 0x{X:0>2} with value=0x{X:0>2}, mask=0x{X:0>2}", .{ addr, value, mask }),
        }
    }

    fn writeMasked(dst: *u8, mask: u8, val: u8) void {
        dst.* &= ~mask;
        dst.* |= (val & mask);
    }
};
