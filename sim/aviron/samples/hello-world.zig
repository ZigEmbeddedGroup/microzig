const testsuite = @import("testsuite");

export fn _start() callconv(.C) noreturn {
    testsuite.write(.stdout, "hello, world!\r\n");
    testsuite.exit(0);
}
