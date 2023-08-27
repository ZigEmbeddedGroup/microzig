const std = @import("std");
pub const isa = @import("isa.zig");
pub const Cpu = @import("Cpu.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const argv = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, argv);

    if (argv.len != 2) @panic("usage: aviron <elf>");

    var flash_storage = Cpu.Flash.Static(32768){};
    var sram = Cpu.RAM.Static(2048){};
    var eeprom = Cpu.RAM.Static(1024){};

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
        .io = Cpu.IO.empty,
    };

    try cpu.run();
}

// pub const DecodeError = error{InvalidInstruction};
// pub fn decode(first: u16, second: ?u16) DecodeError!void {
//     _ = first;
//     _ = second;
// }
