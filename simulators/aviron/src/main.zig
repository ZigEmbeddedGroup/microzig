const std = @import("std");
pub const isa = @import("isa.zig");
pub const Cpu = @import("Cpu.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var thing = try std.fs.cwd().openFile("zig-out/bin/aviron-sample-math", .{});
    defer thing.close();

    var source = std.io.StreamSource{ .file = thing };
    var header = try std.elf.Header.read(&source);

    var strtab: ?struct { usize, usize } = null;
    var section_it = header.section_header_iterator(&source);
    while (try section_it.next()) |section| {
        if (section.sh_type == 0x3) {
            strtab = .{ section.sh_offset, section.sh_size };
        }
    }

    try source.seekTo(strtab.?[0]);
    var strtab_data = try allocator.alloc(u8, strtab.?[1]);
    try source.reader().readNoEof(strtab_data);

    var text: ?struct { usize, usize } = null;
    section_it = header.section_header_iterator(&source);
    while (try section_it.next()) |section| {
        const name = std.mem.span(@as([*:0]const u8, @ptrCast(strtab_data[section.sh_name..strtab_data.len].ptr)));

        if (std.mem.eql(u8, name, ".text")) {
            text = .{ section.sh_offset, section.sh_size };
        }
    }

    try source.seekTo(text.?[0]);
    var text_data = try allocator.alloc(u8, text.?[1]);
    try source.reader().readNoEof(text_data);
    std.log.info("{}", .{std.fmt.fmtSliceHexLower(text_data)});

    var cpu = Cpu{};

    @memcpy(cpu.memory[0..text_data.len], text_data);
    try cpu.run();
}

// pub const DecodeError = error{InvalidInstruction};
// pub fn decode(first: u16, second: ?u16) DecodeError!void {
//     _ = first;
//     _ = second;
// }
