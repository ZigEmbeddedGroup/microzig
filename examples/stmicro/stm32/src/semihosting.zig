const std = @import("std");
const microzig = @import("microzig");
const semihosting = microzig.core.experimental.ARM_semihosting;

pub fn main() void {
    const msg1 = "hello";
    const msg2 = "semihosting";
    const patch = "";
    const file_name = patch ++ "foo.txt";
    const new_name = patch ++ "bar.txt";
    var some_buf: [80]u8 = undefined;

    //debug features
    semihosting.Debug.print("{s} {s}\n", .{ msg1, msg2 });

    const args = semihosting.Debug.get_cmd_args(&some_buf) catch return;
    semihosting.Debug.print("recive args: {s}\n", .{args});

    //time features
    const clock = semihosting.Time.absolute();
    const host_time = semihosting.Time.system_time();

    //fs features
    const file = semihosting.fs.open(file_name, .@"W+") catch {
        semihosting.Debug.print("fail to open {s}!", .{file_name});
        return;
    };

    file.print("[{any}:{d}] | Hello File {s} id {d}", .{
        clock,
        host_time,
        file_name,
        @intFromEnum(file),
    });

    const f_size = file.size() catch return;

    semihosting.Debug.print("now file has size {d}\n", .{f_size});
    file.close() catch {
        semihosting.Debug.print("fail to close {s}!", .{file_name});
        return;
    };

    semihosting.fs.rename(file_name, new_name) catch {
        semihosting.Debug.print("fail to rename {s} to {s}", .{ file_name, new_name });
    };
    while (true) {}
}
