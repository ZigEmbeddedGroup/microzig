const std = @import("std");
const app = @import("app");

pub fn main() !void {
    const gpa = std.heap.page_allocator;
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    if (args.len < 2)
        return error.InvalidArgs;

    const output_path = args[1];
    const file = try std.fs.cwd().createFile(output_path, .{});
    defer file.close();

    var buf: [4096]u8 = undefined;
    var file_writer = file.writer(&buf);
    const writer = &file_writer.interface;

    try writer.writeAll(@embedFile("start.zig"));

    inline for (@typeInfo(app).@"struct".decls) |decl| {
        if (!std.mem.eql(u8, "main", decl.name) and
            !std.mem.eql(u8, "panic", decl.name) and
            !std.mem.eql(u8, "std_options", decl.name))
        {
            try writer.print("pub const {f} = app.{f};\n", .{ std.zig.fmtId(decl.name), std.zig.fmtId(decl.name) });
        }
    }

    try writer.flush();
}
