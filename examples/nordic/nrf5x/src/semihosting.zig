const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;
const time = nrf.time;

const semihosting = microzig.core.experimental.ARM_semihosting;
var TimeNow: isize = 0;

//   DELETEME>>
const uart = nrf.uart.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.log,
};
//   DELETEME<<

pub fn main() void {
    board.init();
    //   DELETEME>>
    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
    });

    nrf.uart.init_logger(uart);
    //   DELETEME<<
    const path = "";
    const file_name = path ++ "foo.txt";
    const new_name = path ++ "bar.txt";
    var some_buf: [80]u8 = undefined;

    //debug features
    semihosting.Debug.print("Hello World\n", .{});

    const args = semihosting.Debug.get_cmd_args(&some_buf) catch return;
    semihosting.Debug.print("receive args: {s}\n", .{args});

    semihosting.Debug.print("feature support: STDOUT FILE: {any}, EXIT CODE {any}\n", .{
        semihosting.Debug.check_extensions(0, 1),
        semihosting.Debug.check_extensions(0, 0),
    });

    const stdout = semihosting.Debug.stdout() catch return;
    stdout.print("hello STDOUT!!!!\n", .{});

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

    semihosting.Debug.exit(0);

    while (true) {}
}
