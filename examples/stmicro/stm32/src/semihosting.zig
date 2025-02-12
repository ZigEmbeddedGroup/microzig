const std = @import("std");
const microzig = @import("microzig");
const semihosting = microzig.core.experimental.ARM_semihosting;

pub fn main() void {
    const msg1 = "hello";
    const msg2 = "semihosting";
    const file_name = "<path>/foo.txt";
    const new_name = "<path>/bar.txt";

    semihosting.Debug.print("{s} {s}\n", .{ msg1, msg2 });
    const file = semihosting.fs.open(file_name, .W) catch {
        semihosting.Debug.print("fail to open {s}!", .{file_name});
        return;
    };

    file.print("Hello File {s} id {d}", .{ file_name, @intFromEnum(file) });
    file.close() catch {
        semihosting.Debug.print("fail to close {s}!", .{file_name});
        return;
    };

    semihosting.fs.rename(file_name, new_name) catch {
        semihosting.Debug.print("fail to rename {s} to {s}", .{ file_name, new_name });
    };

    while (true) {}
}
