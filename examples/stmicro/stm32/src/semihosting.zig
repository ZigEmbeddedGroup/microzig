const std = @import("std");
const microzig = @import("microzig");
const semihosting = microzig.core.experimental.ARM_semihosting;

pub fn main() void {
    const msg1 = "hello";
    const msg2 = "semihosting";
    const file_name = "<path>/foo.txt";

    semihosting.debug_print("{s} {s}\n", .{ msg1, msg2 });
    const file = semihosting.fs.open_file(file_name, .W) catch {
        semihosting.debug_print("fail to open {s}!", .{file_name});
        return;
    };

    file.print("Hello File {s} id {d}", .{ file_name, @intFromEnum(file) });
    file.close() catch {
        semihosting.debug_print("fail to open {s}!", .{file_name});
        return;
    };

    while (true) {}
}
