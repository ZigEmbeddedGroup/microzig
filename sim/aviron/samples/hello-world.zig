const testsuite = @import("testsuite");

export fn _start() callconv(.c) noreturn {
    testsuite.write(.stdout, "hello, world!\r\n");
    testsuite.exit(0);
}
